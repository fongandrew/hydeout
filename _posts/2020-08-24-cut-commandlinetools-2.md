---
title: "cut: command-line tools #2"
layout: post
categories:
  - hacking
tags:
  - hacking
---

Welcome back to my command-line tools series. If you missed the first post, it's here: [grep](http://rez0.blog/hacking/2020/08/20/grep-command-line-tools-1.html). Today we're talking about `cut`. I use it almost as much as I use `grep`

Unlike grep, where I have multiple use-cases, I mostly use cut for a single purpose. I use it to split a string into pieces and return the piece I want. My cut commands almost always use only 2 flags:
 `-d` and `-f` . The `d` flag sets the delimiter. The `f` flag sets the fields you want to output. 

When using bug bounty tools, almost all of them return data delimited in some way (usually spaces or commas). For example, I use [ffuf](https://github.com/ffuf/ffuf) a lot. I always store the data from my scans. My output type of choice is csv because I'm no `jq` expert. When going back through the output to find interesting things, `cut` is invaluable.  (Usually from within vim, like this `:%!cut -d, -f1,2,6` but also from the command line like below)

```bash
~ ❯ cat output.csv 
FUZZ,url,redirectlocation,position,status_code,content_length,content_words,content_lines,resultfile
akamai,https://br.mail.yahoo.com/akamai,,2515,200,0,1,1,
b,https://br.mail.yahoo.com/b,,2833,200,11794,636,7,
favicon.ico,https://br.mail.yahoo.com/favicon.ico,,3887,200,2222,6,2,
healthcheck,https://br.mail.yahoo.com/healthcheck,,4043,200,2,1,1,

~ ❯ cat output.csv | cut -d, -f2,5,6
url,status_code,content_length
https://br.mail.yahoo.com/akamai,200,0
https://br.mail.yahoo.com/b,200,11794
https://br.mail.yahoo.com/favicon.ico,200,2222
https://br.mail.yahoo.com/healthcheck,200,2
```

As you can see, I was quickly able to pull out the url, status code, and response size (in bytes) of my output. I also prefer spaces over commas so I'll replace all the commas with spaces either:
in `vim` with `:%s/,/ /`
OR
from the command line: `cat output.csv | cut -d, -f2,5,6 | sed 's/,/ /g'`

## Oh actually, one other use-case

While typing this up, I remembered another good use-case for `cut`. Sometimes I'll want to strip off the last element of a path for all the urls in a file. Or I'll want to strip off the top-level domain off a bunch of subdomains. I'm sure there are fancy ways to do this with regular expressions or awk, but here's a really easy way to do this with `cut` that's easy for me to remember. Here's the command assuming `/` as a delimiter and stripping off the last element:

```bash
rev | cut -d/ -f2- | rev
```
`rev` reverses the line (for example `a/b/c` becomes `c/b/a`)

`cut` with `/` as the delimiter and `-f2-` means the second field to the end

`rev` reverses the line back to normal

Here it is in action:

```bash
~ ❯ cat test.txt
https://target.com/path/here
https://target.com/one/two/three
https://target.com/paths
~ ❯ cat test.txt | rev | cut -d/ -f2- | rev
https://target.com/path
https://target.com/one/two
https://target.com
```

Notice how it chops off the last part of the path. 

Thanks for reading, and I hope you found this useful. Next week, I'll either cover `sort` , feature some of tomnomnoms tools, or show some useful bash aliases. Feel free to suggest something to me on twitter at [https://twitter.com/rez0\_\_](https://twitter.com/rez0__) . To be updated for the next post, either follow me on twitter or subscribe to [the newsletter](http://eepurl.com/c5WVgj). 

\- rez0
