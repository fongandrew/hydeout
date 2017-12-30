---
layout: post
title: Scalable,Secure Blog in AWS
---

With a plan  to build self managed blog platform which would inifinetly scale ,secure,flexible and cost effectiveness as key design principles. Here are the details 


### Design Principles: 

* Scale
  - To support large scale, the content should be static with no web servers to manage, AWS S3 serves supports this out of box.
  - By going with static pages, it also helps to improve latency by take advantage of content delivert networks (CDN), Hence will use Cloudfront 
  - DNS routing to the TLD will make use of Alias Feature using Route 53
 
* Secure
  - all traffic should be https (TLS1.1), will make use of cloudfront which will redirect http traffic to https 
 
* Flexibility
  - should leverage existing open source framework, hence this uses Jekyll based Hydeout theme
  - Editing should be user friendly, uses github pages feature and most of IDEs supports this.
  - to support Continous Intergration (CI), this makes use of travis CI for building and deployment to AWS
  
* Cost Effectiveness
  - Fixed costs in this setup is incurred only at Route 53 Hosted zone, which costs $0.5/month for one TLD
 
  - by using cloudfront we get free https/certification for the domain ,hence does not costs
  - DNS resolution costs are aoided by using Alias record set by pointing to cloudfront distribution
  
  - variable costs based on traffic is incurred at
      - S3 & Cloudfront data out to Internet
      - S3 & Cloudfront data storage cost 
   - Overall all the costs may not exceed $2/month for few thousand hits
   
    


