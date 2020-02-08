---
title: "Bugbounty alert automation tips"
layout: post
categories:
  - hacking
tags:
  - hacking
---

I have always loved automation. Being a computer science student in college, as well as getting really into Instagram around 2011 (back when people would follow you if you liked their photo or left a single comment on it) led me to try and automate gathering Instagram followers. 

<img alt="ig" src="/assets/ig.png" width="600px" />
There was no web version of instagram at the time, but a site called Statigram existed. I wrote a little [AutoHotKey](https://www.autohotkey.com/)'s script to refresh on a popular hashtag, click the heart to like the top 5 photos and then refresh. I was getting _some_ followers. Then eventually I added the ability to add comments of the form: 

`I {really|very much|etc} {like|love} this {photo|pic|pictures}{!|!!|!!!}`

Shortly after realizing people put irrelevant hashtags on nsfw pictures (and that I had commented "I really love this pic!" on some lewd images), I stopped automating that task. But when I started doing bug bounty hunting last August, I knew I would use automation whenever possible.

## The Goal
Let's start with a goal: Get automated alerts for interesting stuff. I knew I wanted to get alerted via slack. I also love chaining commands together in bash, so I wanted it to take stdin as input and write to my slack as output. Here's the 2 line script to do so: https://github.com/jthack/toslack

```
#!/bin/bash

message=`cat`
curl -X POST -H 'Content-type: application/json' --data "{\"text\":\"$message\"}" $SLACK_WEBHOOK_URL
```

## Useful Use-Cases
I've got lots of ideas for alerting. Some are easier to implement than others. Almost all of them have challenges. Let's focus on two for this blog post:
1. New domains
2. Newly alive domains (because a new certificate doesn't mean it's pointed at a server yet)

We want to check for these periodically, so I used [cronjobs](https://opensource.com/article/17/11/how-use-cron-linux) in linux calling my script with the root domains like this:

`0 8 * * * /home/rez0/monitor.sh yahoo.com`

I love using [findomain](https://github.com/Edu4rdSHL/findomain) for domains because it's wicked fast. So my alerting for new domains looks like this:

`findomain $1 | toslack`

The problem with this is too much noise. We only want to know about new ones. We could get a database set up and all, but I think it's a lot easier to just use text files. Luckily [@tomnomnom](https://twitter.com/TomNomNom) has a fantastic tool for this. His tool [anew](https://github.com/tomnomnom/anew) appends lines from stdin to a file, but only if they don't already appear in the file. Perfect! Let's make a quick change to the alerting:

`findomain $1 | anew domains_$1.txt | toslack`

Congrats! You just set up alerting for new domains! But we also want to get alerts for newly alive domains. Luckily [@tomnomnom](https://twitter.com/TomNomNom) also has a great tool for checking liveness in the same stdin/stdout fashion. It's called [httprobe](https://github.com/tomnomnom/httprobe). It takes domains on stdin and output their live urls on stdout. So conquering #2 from above is as easy as adding this line to your monitoring script (don't for get anew so that you don't get alerted for ALL live domains every time):

`cat domains_$1.txt | httprobe | anew live_domains_$1.txt | toslack`

There are nearly endless way to use these tips to set up quick and easy monitoring. 

## Thanks!
I hope you enjoyed the write-up. Let me know if you set up any cool alerts with these tips!

Twitter: [rez0\_\_](https://twitter.com/rez0__)

Subscribe to get an email when I write a new blog: [click here](http://eepurl.com/c5WVgj)
