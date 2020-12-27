---
title: "non-technical bugbounty tips"
layout: post
categories:
  - hacking
tags:
  - hacking
---

There are a lot of [#bugbountytips](https://twitter.com/hashtag/bugbountytips) on twitter, but very few are non-technical. I’ve had a number of top hackers tell me some measure of their success in bug bounty can be attributed to being kind. Without networking and collaboration, I would have made about ¼th of my total bounties this year.

Being kind and collaborating are only the tip of the iceberg when it comes to the non-technical side of bug bounty. Here are some tips that have helped me as hacker, but also in other areas of life. I’ve included examples to be more helpful.

## 1. Be clear 
Being clear often translates to being verbose. I’m an over-explainer, and I think it helps. In my reports and my questions to other hackers, I will usually type out a lot and rewrite a few sentences. 

There’s hardly any downside to being too verbose or clear. The upside can be big though. It might help a triager understand the bug better which prevents them from closing a legit issue as Not Applicable. Or it may show a fellow hacker all the steps you took so that they can more easily derive what steps they would have taken, or what steps they’d recommend you take.

Example:
```
Hey douglas, I am hacking on this program where I think there is an IDOR. 
I’ve tried:
* this
* that
* this other thing. 
I wanted to try xyz, but I couldn’t because of the way the permissions are implemented. 
If you had any suggestions, I’d be super grateful to hear them :)
```

## 2. Be assertive, but respectful. 
We’ve all had the experience of reporting a bug and it not going too well. For example, let’s say you reported a vulnerability and it was closed in error. I see two major pitfalls that hackers fall into. 

The first is being disrespectful in their reply. This isn’t likely to get a triager or platform to help you remediate the issue. In fact, being overly disrespectful can get you a temporary ban. 

The second pitfall is assuming you the matter is settled and you have no course of action to take. If there is a legitimate issue, respectfully ask the team to reconsider. If that isn’t fruitful, request support. Be firm, but respectful. 


Example:
``` 
Hey <triager>. Thanks for taking the time to look at the report. 

I understand the CVSS of the report calculates to medium, 
but I was able to access the PII of thousands of users without 
their interaction. The impact seems higher to me if you would 
reconsider the severity.
```
## 3. Default to sharing
When you have attempted to exploit something, got stuck, and would normally move on, send it to 2-3 hacker friends or mentors instead. If it’s a private program, look at the Top Hackers for that program and consider direct messaging them. There’s a lot that can be said about this tip concerning game theory, maximizing your odds of a bounty, and more. 

I’ll keep it short. If you give up on 100 “potential bugs” in a year, you made nothing from those 100 bugs. If you send 100 “potential bugs” to friends or mentors asking for help, you will very likely have converted on some of them. Also, you hone your ability to discern what a good indicator of a potential bug is.

Example:
```
Hey fellow hacker, I noticed you were a Top Hacker on <private program>. I’m also in that program. I think the parameter user at path /profile is vulnerable to xss, but I keep getting stopped by the WAF. Here’s the payload I’m using. Would you mind giving it a try? I’d happily collaborate on the report! No problem if not, thanks!
```

## 4. “Interesting” notes
I’m actually really bad at this one, but it’s paid off multiple times when I do it. I only take notes about 10% of the time. My notes page has resulted in bugs months after taking them though. What happens is I’ll put anything interesting in my notes, and a bit later, I will meet someone who asks me a question about a program I’ve hacked on. After answering their question, I’ll send over all my notes for that program. If they find something, we collaborate on the report, and we split the bounty! 

For h1-2010, the live hacking event where our team won the best team award (w00t!), the scope was *.yahoo.com for round one. I had hacked on Verizon Media a lot. I sent over all my notes, and it gave us a lot of leads for potential bugs. 

Example:
```
https://site.com/endpoint - looks really old
https://site.com/profile?user=’%assdfkjkf - weird behavior for bad data in this param
etc.
```

## 5. Join the community
Maybe you’ve found your way here because you’re a twitter lurker. Well lurk no more, hacker. Messaging other bug hunters, replying to their tweets, being in hacker slacks or discords, posting in subreddits, and going to local hacker meetups are all ways you can get involved in the hacker community. Find and engage your peers. Peers are awesome because they are source of collaboration, help, mentorship, and most importantly, friendship. We could all use a little more friendship. And if you don’t need others, they certainly need you. 

Example:
HackerOne’s discord
Reddit: /r/netsec
Follow #bugbountytips or any of the hundreds of popular hackers on twitter

## 6. Learn the programs
All programs handle reports differently. Some care more about PII exposure. Some will well for XSS, some won’t. Some pay bounties per endpoint. Some don’t. Learning the programs allows you to set yourself up for success by looking for what they care about, reporting bugs in an optimal way, and knowing which red flags to look for which indicate to you personally when to move on to a different program.

## 7. Default to reporting
I’ve heard a lot of hackers mention that they don’t report low severity bugs, and I’ve had conversations where hackers tell me a bug that they didn’t report because they didn’t think it was good enough. It’s often a legitimate vulnerability. If you find a legitimate bug, even if it’s a low, report it!!! Or at least hand it off to another hacker to report. They’ll be thankful, and you’ll make some money! Otherwise, you’re leaving money on the table. You’re leaving the company’s customers at risk. 

That said, please don’t report junk. They receive enough of that already. If you aren’t sure, ask for a few hunters’ opinions. Feel free to tweet or dm me: https://twitter.com/rez0__

## Thanks
Thanks for reading! I this helps you. If you want, you can follow me at [https://twitter.com/rez0\_\_](https://twitter.com/rez0__) 

rez0
