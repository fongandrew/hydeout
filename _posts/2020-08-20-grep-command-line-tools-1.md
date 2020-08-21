---
title: "grep - command-tools #1"
layout: post
categories:
  - hacking
tags:
  - hacking
---

Welcome to part 1 of a blog series I'm going to do on command line tools, and how they're useful as a bug bounty hunter. I'm going to highlight a different command line tool in each post, as well as do an extra post showing most of my bash aliases (there's quite a few). 

**Disclaimer:** This is mostly going to be use-cases for the tools related to how they are useful to me when bug hunting. I still rely on tools like ffuf, httprobe, aquatone, etc. but this series will cover how I use these command line tools to save time, process data, automate steps, and quickly extract meaningful conclusions. 

## Finding a specific thing

Anyone who has used grep knows it's really great at finding a single string in a file or entire directory. My use-case is digging up some old endpoint or subdomain, or grepping for specific string like api\_key. This is usually the command I use:

`grep -Hrnia search_term`

<img src="https://i.imgur.com/DE5BO7i.png" width="500px" />

`-H`: show filename in output

`-r`: recursive in all subfolders

`-n`: show line number

`-i`: case insensitive 

`-a`: process a binary file as if it were text

I remember those flags by thinking "hernia". Pretty weird, but it works. 

I also use the above command when grepping through source code because I pulled the source from all pages I was fuzzing with `meg` or the`-od` flag in ffuf (that's the flag to save all responses into the (o)utput (d)irectory that you pass to the `-od` flag.)

The downside to this method is many lines are very long. If grep matches a string in a massive line (like minified javascript), it will fill up your terminal. For this, it's a bit ugly looking, but I use the following:

`grep -HrniaE ".{0,20}search_term.{0,20}"` 

The only flag I added was `E` which is the indicator to treat the search as a regular expression. The `.{0,20}` says to show 20 characters. Since I placed it before and after, it will return 20 characters before and after the search value, but nothing else. So this can make the output from your grepping a bit more readable if you're grepping files with long lines.

## As a filter

My second major use case for `grep` is filtering output from a tool. Sometimes it's to get what I want. Sometimes it's to exclude what I don't want. For example, let's say I'm using [fff](https://github.com/tomnomnom/fff)  by [tomnomnom](https://twitter.com/tomnomnom) to validate all the urls which I found by using [Corben's](https://twitter.com/hacker_?lang=en) tool [gau](https://github.com/lc/gau) with a command such as this:

gau takes a domain as input, and outputs links like:

```
https://target.com/js/main.js
https://target.com/login
https://target.com/photo.jpg
```
fff returns the url with a status, space delimited `https://target.com/login 200`
```bash
gau target.com | grep -vE "jpg|gif|png" | fff | grep " 200" > live.txt
```

The first use of grep is filtering out any jpegs, gifs, or pngs. Those aren't usually relevant for hunting. The `-v` is the flag that excludes matches. The `-E` is the flag which indicates the use of a regular expression. This allows me to use the OR operator (via the `|` pipe) to filter out a bunch of strings I want to exclude. 

Then I used another grep filter to only keep the results that are 200 return codes. To be completely honest, this is only a simplified version of a line in my scanning script. I paired it down so that it was easier to understand. Here's the full command for those of you who want to dig deeper.

```bash
while read line;do gau $line | grep -v -e '^$' | grep -vE "jpg|gif|png|css|jpeg|ttf|woff|svg" | tee -a gau.txt | fff --delay 100 | grep -E " 200| 403| 401| 405" | anew endpoints_live.txt;done < target.com.txt
```

## Smaller use cases (more free #bugbountytips)

- I use `grep ?` to filter links from `gau` and `waybackurls` which have params.
- I use `grep -v http` if there's a tool that returns full links and relative links like some uses of `linkfinder` and `hakrawler` and I deicde that I only want the relative links.
- I use `grep target.com` as a filter when I'm worried the output from a crawling or scanning tool might pass something out of scope into another part of my script.
- I use `grep -v -e '^$'` to remove empty lines from output. Probably a better way to do this.

Well, that's about it. I hope you learned something. If you enjoyed this, you can tweet or follow me at [https://twitter.com/rez0\_\_](https://twitter.com/rez0__) and/or subscribe to [my newsletter](http://eepurl.com/c5WVgj) 

- rez0
