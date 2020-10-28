---
title: "ffuf filters"
layout: post
categories:
  - hacking
tags:
  - hacking
---

I’ve been wanting to write more here to be helpful, practice writing, and clarify my thoughts. However, I have a hard time making time to actually do it. I tweeted something about removing false positives from ffuf, and it’s blowing up a little bit. I immediately knew I wanted to clarify it a bit, and I think it would be a good little blog #BugBountyTip.

Here’s the tweet: https://twitter.com/rez0\_\_/status/1321236534855639041

I essentially said the best way to remove false positives from ffuf is the autocalibrate `-ac` flag + 302, 400, 404, 429, and 500-504 would get 99% of the noise. But that is a very general answer which covers most cases. That said, it misses the really interesting behavior that often leads to bugs other people are missing. Here’s a few ffuf clarifications to the above simplification.

# First, the ones I left off that I sometimes filter. 

401 & 403 - If the whole host is 401 or 403, I filter it, but that will usually be caught by -ac. I left it off because I like to try and bypass it via path traversal or verb tampering. If it’s not caught by -ac, it’s likely a rule in the ACL.

301 - Some hosts hit 301 way too frequently to be directories, but usually they represent directories, which means more fuzzing :) 302 isprobably the next best return code besides 200.

# Now, the reasoning behind the codes in list and why they are sometimes actually awesome.

302 is almost always junk, but I’ve seen 302s to other hosts that were not in my word list.

400 & 404 are often noise, but if you have -ac in your request and you see a 400 or 404, that’s interesting because it’s a different response size. I will usually check into it. 

429 is always a false positive, but it DOES let you know you’re being rate limited, so it’s useful to see them so you know to slow down you’re fuzzing or to stop fuzzing that host.

500 can sometimes return if a server is erroring due to a weird fuzz payload, etc. but it’s often something interesting. I will often do a parameter brute force on paths which return 500. 

502-504 are often false positives due to too much traffic on a weak server or something similar, but they can sometimes be interesting.
.
# Other Tips

1. Always use `-mc all -ac`. You’re not at much risk of false positives due to matching ever response code since the autocalibrate will catch most issues it would cause. Also, I’ve seen response codes that are non-standard like 999.
2. If you’re using `-mc all -ac` and there’s a small number of results 
3. Honestly, watching the results come in is really useful. I like a terminal which auto-makes links into links so I can click the results to go straight to the site. Ubuntu’s terminal does this. I also like to ffuf multiple sites at the same time so I can watch it all in split tmux windows. 

I have lots of tips for how to save off all your ffuf data and also parse it after the fact, but most of that will be in my bash alias / bash profile blog post that I plan to do soon.

Thanks! I hope you learned something. If you enjoyed this, you can tweet or follow me at [https://twitter.com/rez0\_\_](https://twitter.com/rez0__) and/or subscribe to [my newsletter](http://eepurl.com/c5WVgj) 

rez0
