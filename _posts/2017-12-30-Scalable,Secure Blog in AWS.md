---
layout: post
title: Scalable,Secure Blog in AWS
---

With a plan  to build self managed blog platform which would inifinetly scale ,secure,flexible and cost effectiveness as key design principles below are details. 


### Design Principles: 

* Scale
  - The content should be static with no web servers to manage, AWS S3 supports this out of box.
  - By going with static pages, it also helps to improve latency by take advantage of content delivert networks (CDN), Hence will use Cloudfront 
  - uses of Alias Feature from Route 53
  
 
* Secure
  - all traffic should be https (TLS1.1), will make use of cloudfront to redirect http traffic to https 
 
* Flexibility
  - should leverage existing open source framework, hence this uses Jekyll based Hydeout theme
  - Editing should be user friendly, uses github pages feature and most of IDEs supports this.
  - to support Continous Intergration (CI), this makes use of travis CI for building and deployment to AWS
  
* Cost Effectiveness
  - Fixed costs in this setup is incurred only at Route 53 Hosted zone, $0.5/month for one TLD
  - by using cloudfront(https) with alternate domain name feature, certification cost will be zero
  - DNS variable costs are avoided by using Alias record set
  - variable costs based on traffic is incurred for S3/Cloudfront.
  - overall all the costs should not exceed $2/month for all this setup
   
    


