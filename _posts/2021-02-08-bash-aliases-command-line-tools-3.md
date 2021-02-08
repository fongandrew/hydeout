---
title: "bash aliases: command-line tools #3"
layout: post
categories:
  - hacking
tags:
  - hacking
---

Welcome back to my command-line tools series. Here is [part one on grep](http://rez0.blog/hacking/2020/08/20/grep-command-line-tools-1.html) and [part two on cut](http://rez0.blog/hacking/2020/08/24/cut-commandlinetools-2.html). This post is going to highlight many of my bash aliases. I'm sure many of these can be improved. I'd love to know how if you are willing to tweet me: [https://twitter.com/rez0\_\_](https://twitter.com/rez0__)

## ffuf

These are my ffuf scripts. In general they all do a few things:

- [unfurl](https://github.com/tomnomnom/unfurl) the domain to use as the output file
- `-mc all -ac` match all codes, but auto calibrate. greatly reduces noise
- set a custom bug bounty header (in case they need to request me to stop fuzzing)
- output in csv format
- limit the max time of the ffuf run
- setting a custom user agent because ffuf is getting blocked more often

I particularly like my naming convention. It allows for auto-naming without passing in an output filename.

ffuf with my personal quickhits list:

```bash
ffuf_quick(){
	dom=$(echo $1 | unfurl format %s%d)
	ffuf -c -v -u $1/FUZZ -w quick.txt \
	-H "User-Agent: Mozilla Firefox Mozilla/5.0" \
	-H "X-Bug-Bounty: rez0" -ac -mc all -o quick_$dom.csv \
	-of csv $2 -maxtime 360 $3
}
```

ffuf deep recursive (one difference with this alias is it takes a wordlist as the 2nd param):

```bash
ffuf_recursive(){
  mkdir -p recursive
  dom=$(echo $1 | unfurl format %s%d)
  ffuf -c -v -u $1/FUZZ -w $2 -H "User-Agent: Mozilla Firefox Mozilla/5.0" \
  -H "X-Bug-Bounty: rez0" -recursion -recursion-depth 5 -mc all -ac \
	-o recursive/recursive_$dom.csv -of csv $3
}
```

Using ffuf to find vhosts (a special wordlist I have + subs that resolve to internal IPs):

```bash
ffuf_vhost(){
	dom=$(echo $1 | unfurl format %s%d)
	ffuf -c -u $1 -H "Host: FUZZ" -w vhosts.txt \
	-H "X-Bug-Bounty: rez0" -ac -mc all -fc 400,404 -o vhost_$dom.csv \
	-of csv -maxtime 120
}
```

## nuclei

These are my nuclei aliases. The first takes a single site. The second takes a list of hosts.

Usage: `rez0@vps:~$ nuclei_site https://google.com`

```bash
nuclei_site(){
    echo $1 | nuclei -t cves/ -t exposed-tokens/ -t exposed-tokens/ \
		-t exposed-tokens/ -t vulnerabilities/ -t fuzzing/ -t misconfiguration/ \
		-t miscellaneous/dir-listing.yaml -pbar -c 30
}
nuclei_file(){
    nuclei -l $1 -t cves/ -t exposed-tokens/ -t exposed-tokens/ \
		-t exposed-tokens/ -t vulnerabilities/ -t fuzzing/ -t misconfiguration/ \
		-t miscellaneous/dir-listing.yaml -pbar -c 50
}
```

## add_to_lists

Custom wordlists are a massive advantage when hacking. Sharing with friends, compiling data from github repos, and adding to lists over time are great ways to have stronger wordlists. I'll frequently find a path while hacking that I want to add to my wordlist. Since I use multiple lists, I want to add it to all of them. If there is too much friction, I know I won't do it, so I made this alias to reduce the friction of adding words to my wordlists:

Usage: `rez0@vps:~$ add_to_lists example.conf` 

```bash
add_to_lists(){
	echo $1 | anew ~/tools/wls/recursive.txt
	echo $1 | anew ~/tools/wls/massive.txt
	echo $1 | anew ~/tools/wls/quick.txt
}
```

And many times I will want to add a bunch of words from a single file so I use this wrapper along with the alias above:

Usage: `rez0@vps:~$ add_to_lists_from_file infile.txt`

```bash
add_to_lists_from_file(){
	while read line;do add_to_lists $line;done < $1
}
```

## arjun wrapper

I use this because I'm lazy when I want to fuzz for parameters. It takes `get`, `post`, or `json` as the 2nd parameter.

Usage: `rez0@vps:~$ arjun https://google.com get`

```bash
arjun(){
    here=$(pwd) 
    cd ~/tools/Arjun 
    python3 arjun.py -u $1 -m $2 -w ~/tools/dirsearch/db/params.txt 
    cd $here 
}
```

## cidr2ip

This will take a CIDR range and output all the IP addresses. This is useful when fuzzing with an SSRF for internal hosts or if a program gives a CIDR range as their scope and you want to fuzz on that range, etc. 

Usage: `rez0@vps:~$ cidr2ip 10.0.0.0/8`

```bash
cidr2ip(){
	nmap -sL $1 | awk '/Nmap scan report/{print $NF}'
}
```

## httprobemore

This is just a wrapper for [https://github.com/tomnomnom/httprobe](https://github.com/tomnomnom/httprobe). You can obviously add as many extra ports as you'd like. I like the x-large list from aquatone. 

Usage: `rez0@vps:~$ cat hosts | httprobemore` 

```bash
httprobemore(){
	httprobe -p http:8000 -p https:9443 -p http:8080 -p https:8443 -c 50 -t 1000
}
```

## processing ffuf output

My quick and dirty "interesting ffuf" alias. This is my go-to ffuf output processor when I'm scanning so many hosts that it's unrealistic for me to deal with unique 404s, param search on 500s, etc. 

Because my scanning does a quick scan, a recursive scan, and a custom wordlist scan, I normally have a bunch of different csv output from ffuf laying around. That's why this alias uses `find`. If you have a single file, you can shorten this by replacing the find command with `cat $1`. The grep and sed are self-explanatory. The sort is where the magic happens. It's a unique, numeric sort by column 5, response size, which removes any duplicate response sizes. This eliminates most noise. hundreds of thousands of lines of output usually reduce down to a few hundred. Oh, and of course it opens the output in vim. One extra point worth noting is that the largest files will be at the bottom and the smallest at the top. This comes in handy when looking for anomalies. 

Usage: `rez0@vps:~$ findcsvsummary`

```bash
findcsvsummary(){
    find -name "*.csv" -exec cat {} \; | grep ,200, \
	| sed 's/,/ /g' | sort -k 5,5 -u -n | vim -
}
```

## http verb tampering

This was made by [https://twitter.com/healthyoutlet](https://twitter.com/healthyoutlet). It tries all the verbs in that first line on the url you pass in. It's a useful way to quickly check the status code of all the different http verbs.

Usage: `rez0@vps:~$ tamper https://rez0.blog`

Example output:

[`https://rez0.blog](https://rez0.blog/): GET-200 POST-405 HEAD-200 PUT-405 DELETE-405 CONNECT-405 OPTIONS-405 TRACE-405 PATCH-405 ASDF-405`

```bash
tamper() {
    echo -n "$1: "; for i in GET POST HEAD PUT DELETE CONNECT OPTIONS TRACE PATCH ASDF; \
	do echo "echo -n \"$i-$(curl -k -s -X $i $1 -o /dev/null -w '%{http_code}') \""; done \
	| parallel -j 10 ; echo
}
```

## linkfinder wrapper

I usually don't care about the hosts that come out of linkfinder, but I do really like paths for custom fuzzing. For that reason, I wrap my linkfinder in commands to make sure it ONLY outputs paths. 

Usage: `rez0@vps:~$ linkfinder https://site.com/main.js | anew paths.txt`

```bash
linkfinder(){
	python3 /home/rez0/tools/LinkFinder/linkfinder.py -i $1 -o cli \
	| grep -v http | grep -v // | sed 's/^\.\//\//' | sed 's/^\///'
}
```

## make a fleet

This is an axiom helper alias. Digital Ocean doesn't love spinning up more than 10 instances at once. 

Usage: `rez0@vps:~$ make_fleet rez0 40`

```bash
makefleet(){
    fleet=$1

    total=0
    while [[ "$total" -lt $2 ]];
    do
        axiom-fleet "$fleet" -i=10
        total=$((total+10))
        echo "Spun up $total"
        sleep 60
    done
}
```

## two ways to find large files

I usually work off a tiny Digital Ocean droplet. Here's a referral link for your first month free. But anyways, my recon data sometimes fills up the disk, so I'm looking for huge files to delete. These both do the trick, but `largefiles` seems to be faster.

```bash
bigfiles(){
	du -a $1 | sort -n -r | head -n 10
}

largefiles(){
	du -k | sort -n \
	| perl -ne 'if ( /^(\d+)\s+(.*$)/){$l=log($1+.1);$m=int($l/log(1024)); printf ("%6.1f\t%s\t%25s | %s\n",($1/(2**(10*$m))),(("K","M","G","T","P")[$m]),"*"x(1.5*$l),$2);}'
}
```

## thanks

I really appreciate you taking the time to read this post. I plan to continue to post if you want to add this site to feedly, subscribe to my newsletter, or follow me on twitter:
*  [https://twitter.com/rez0\_\_](https://twitter.com/rez0__) 
* [my newsletter](http://eepurl.com/c5WVgj) 


\- rez0
