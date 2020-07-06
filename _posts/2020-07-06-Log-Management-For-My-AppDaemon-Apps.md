---
layout: post
title: Log Management For my AppDaemon Apps
excerpt_separator: "<!--more-->"
categories: 
  - Archive
tags:
  - Homeassistant
  - Appdaemon
  - Python
  - Seq
---
Aggregate and search my Appdaemon logs by log level, app name and more.
<!--more-->

## The Problem - Where are my logs

I am running [AppDaemon](https://appdaemon.readthedocs.io/) in a docker container with more than 90 apps automating my home.
When I want to debug my apps or review an app crash I login to my server with ssh and run
`docker logs -f appdaemon` to see my logs. When I recreated the container, for example because a new AppDaemon version
was released all my logs where gone. When the container was running for a long time it would take several minutes until I
had arrived at the point in the logs I was interested in.

Not very sophisticated.

## The Search

I wanted a solution which would store my logs and let me search them by log level, app name and date. A free text search
would be a nice addition.

At work we often use Splunk and the Elastic Stack for log management and more. So I started with these
two to try and better analyze my Appdaemon app logs.

### Splunk

I found out that I can run a free single node instance of splunk when I do not ingest more than 500MB of data each day.
This was sufficient enough for me and there was also a ready to use docker image which I could add to
[my docker-compose.yaml](https://github.com/eifinger/homeassistant-config#docker-compose-yaml-):

```yaml
splunk:
    container_name: splunk
    hostname: splunk
    restart: unless-stopped
    image: splunk/splunk:7.2
    ports:
      - "8000:8000"
      - "8088:8088"
    volumes:
      - /home/admin/splunk/etc:/opt/splunk/etc
      - /home/admin/splunk/var:/opt/splunk/var
    environment:
      - SPLUNK_START_ARGS="--accept-license"
      - SPLUNK_ENABLE_LISTEN="9997"
      - SPLUNK_ADD="tcp 1514"
      - SPLUNK_PASSWORD="secure"
```

This started up a splunk instance which I could access with my browser under port 8000. I then modified my appdaemon configuration
so that the container would use the splunk logging plugin and log directly to splunk:

```yaml
appdaemon:
  container_name: appdaemon
  restart: unless-stopped
  image: acockburn/appdaemon:3.0.5
  volumes:
    - /etc/localtime:/etc/localtime:ro
    - /home/admin/appdaemon:/conf
    - /home/admin/homeassistant/www:/config/www
  environment:
    - HA_URL="https://hidden.de"
    - TOKEN="secure"
    - DASH_URL="http://hidden:5050"
  ports:
    - "5050:5050"
    - "8124:8124"
  logging:
    driver: splunk
    options:
      splunk-token: secure
      splunk-url: http://servername:8088
      splunk-insecureskipverify: "true"
      splunk-verify-connection: "false"
```

This worked very well until I found out, that stack traces of crashing apps where ingested as distinct log events.
Each linebreak was an indicator for splunk that the log message ended which made reviewing logs with stack traces in it a burden.

I googled around a bit but could not find a straight up solution to this problem.

But I kept splunk running in the hope that I would someday find out how to properly ingest stack traces.

Then some days later when I was restarting my server the splunk container got restarted, ran a bunch of ansible scripts (why?!) and didn't have
any of the stored logs it had before.

Having to face two issues to solve with splunk now I dropped it altogether and moved on.

### Elastic

Short story short, I could not find any way to run a maintainable setup of the elastic stack which would not fry my hardware.
Even the best and shortest tutorials and prepared docker files would mean a lot of maintenance to get all the moving parts up and running.

My usecase is just to small for a solution like that.

### Seq

Another thing which popped up at work was [Seq](https://datalust.co/seq) which we use because it works great when programming in
C# and logging with Serilog.

Seq also has a free single user license and is very kind with its hardware requirements.

Running it as a docker container is pretty straight forward. I created a local directory to store all information and
added it to [my docker-compose.yaml](https://github.com/eifinger/homeassistant-config#docker-compose-yaml-):

```yaml
seq:
  container_name: seq
  image: datalust/seq:2020.1.4212
  volumes:
    - /home/admin/seq/data:/data
  ports:
    - "5340:80"
    - "5341:5341"
  environment:
    - "ACCEPT_EULA=Y"
```

I chose to map port `5340` to the container port `80` under which the dashboard is hosted because it was still free
and aligns with the ingest port `5341`.

Now on to the question of how to actually get my AppDaemon logs into it.

Being still traumatized from the multiline
stracktrace desaster I remembered that some time ago I tried to watch the AppDaemon logs from within an app itself.
Back then the logging API was different and I couldn't get the desired behaviour and never finished my app `appWatcher`.
But with the release of AppDaemon 4 the api changed and it is now easily possible to listen to all log messages
which are logged in all AppDaemon apps.

During the search for the updated logging API I found a Github [issue](https://github.com/AppDaemon/appdaemon/issues/684)
where someone found my unfinished app and tried to make it work. I am sorry! I should have documented that I had given up
on that app back then.

But with the new logging API I was able to make that app work and also knew how to send all my messages to seq.

## The Solution - seqSink

There are some libraries recommended when trying to log to Seq with python.
One of them is [seqlog](https://seqlog.readthedocs.io/en/latest/usage.html). The usage seemed pretty straight forward
and exactly what I needed:

```python
import seqlog

seqlog.log_to_seq(
   server_url="http://my-seq-server:5341/",
   api_key="My API Key",
   level=logging.INFO,
   batch_size=10,
   auto_flush_timeout=10,  # seconds
   override_root_logger=True,
   json_encoder_class=json.encoder.JSONEncoder  # Optional; only specify this if you want to use a custom JSON encoder
)
```

The only problem is that this integrates deeply into the logging framework of python and I was not sure whether that
would mess up the logging functionality of AppDaemon.

I can access all AppDaemon log messages from within an app with a log listener and a callback function:

```python
self.handle = self.listen_log(self.log_message_callback)

def log_message_callback(self, app_name, ts, level, log_type, message, kwargs):
    """This callback lets you handle log messages."""
```

So I went ahead and got into the sourcecode of seqlog trying to find out how it sends it messages to Seq.
Turns out it is only building a dictionary and then sending it with requests. I recreated the functionality for
[my AppDaemon app](https://github.com/eifinger/appdaemon-scripts/blob/master/seqSink/seqSink.py):

```python
class SeqSink(hass.Hass):
    def initialize(self):
        self.server_url = self.args["server_url"]
        if not self.server_url.endswith("/"):
            self.server_url += "/"
        self.server_url += "api/events/raw"

        self.session = requests.Session()
        self.session.headers["Content-Type"] = "application/json"

        api_key = self.args.get("api_key")
        if api_key:
            self.session.headers["X-Seq-ApiKey"] = api_key

        self.handle = self.listen_log(self.log_message_callback)

    def log_message_callback(self, app_name, ts, level, log_type, message, kwargs):
        if app_name != "seqSink":
            event_data = {
                "Timestamp": str(ts),
                "Level": str(level),
                "MessageTemplate": str(message),
                "Properties": {
                    "Type": "Appdaemon",
                    "AppName": str(app_name)
                },
            }
            request_body = {"Events": [event_data]}

            try:
                request_body_json = json.dumps(request_body)
            except TypeError:
                self.log(f"Could not serialize {request_body}")
                return

            try:
                response = self.session.post(
                    self.server_url,
                    data=request_body_json,
                    stream=True,  # prevent '362'
                )
                response.raise_for_status()
            except requests.RequestException as requestFailed:
                self.log(f"Could not serialize {message}")

                # Attempt to log error response
                if not requestFailed.response:
                    self.log("Response from Seq was unavailable.")
                elif not requestFailed.response.text:
                    self.log("Response body from Seq was empty.")
                else:
                    self.log(f"Response body from Seq:{requestFailed.response.text}")
```

I run the app under the name `seqSink` so the first thing this function does is to filter out log messages from itself in order to prevent a never ending loop. Then it creates a dictionary storing the log message information in a format
that seq can understand. I added two custom Properties `Type` and `AppName`.

The `Type` is always `Appdaemon` so I can filter on it if I later on add more log sources to seq like homeassistant
itself for example.

The `AppName` is the argument given to the callback indicating which AppDaemon app logged the message. This lets me
easily filter all logs for a specific app.

The app is running for some days now and is working absolutely great. No more tailing the docker logs directly
and searching for a specific error message in over 2 weeks worth of logs.

Here is an example of how that looks when I filter for messages of my Notifier app:

![notifier_log_messages_in_seq](https://raw.githubusercontent.com/eifinger/blog.kevineifinger.de/master/assets/pictures/notifier_log_messages_in_seq.png)

You can find the app and the configuration for it in my repo [github.com/eifinger/appdaemon-scripts](https://github.com/eifinger/appdaemon-scripts/tree/master/seqSink).
