---
title: "how to make your website hard to hack"
layout: post
categories:
  - hacking
tags:
  - hacking
---

Having tested and hacked on thousands of websites, I've come to some conclusions about what makes a hacker's job difficult. Put another way, I've realized what makes a website secure. And to put it a third (more honest) way, I'm always slightly annoyed when I start hacking a website and these things are present! :P 

Below is list of design decisions which add significant security impact by their mere existence. 

## me-based authorization

This is I call it when API endpoints are deciding what data to return based on the authorization mechanism (cookies or authorization headers generally) for that user, rather than a parameter or path. This increases security significantly because it cuts down on all the IDOR protection that must be coded into the functions behind each endpoint and request. 

Indication this is implemented: API endpoints are generic like `/api/v1/me` or `/api/v1/account` and only return your data. The alternative would be a path such as `/api/v1/account/1337` or `/api/v1/account?id=1337`. This can still be secure, of course. But any hacker will tell you that it's *much* less likely to be so. 

Note: There may be a term for this design principle. If so, please let me know on [twitter](https://twitter.com/rez0__). 

## simple rbac

The most difficult-to-hack websites are those with simple permissioning schemes. A good example would be a site that has only users and admins. Or perhaps a site with only admins and read-only auditor accounts. 

Role-based access control significantly increases complexity. Complexity increases the odds of having vulnerabilities. If you add a new role, you now have to validate (and continually test) every single piece of functionality that the new role should and should not be able to perform. This is further complicated if you have granular permissions or the ability to grant cross-tenant access.

Indication this is implemented: Self-evident in the permission scheme.

## org-based data segregation

Cross-org (or cross-tenant) data access is often the most impactful vulnerability during an assessment. The fall out of an Acme Corp employee escalating to admin is often not that high compared to someone at Acme Corp being able to access or modify the data for all organizations using the website. 

Whether or not the data segregation is separate hardware or just separate indices in a flat database doesn't matter too much. Can the application _ever_ access data cross-org? A useful thought exercise might be to ask yourself or the developers: How hard would it be to modify the code such that one org _could_ access data from another org?

Indication this is implemented: It's often hard to tell. One way to I've observed this be evident is when there's a request such as `/api/v1/org/52452345/details` and changing the org id actually results in a 404 rather than a 403 or 401. 

## single sign-on everywhere

Not being able to even _access_ any website for a company makes it extremely difficult, if not impossible, to hack. If I'm testing a company without credentials and all their sites just redirect to single sign-on, there's almost nothing to test. I'm simplifying a bit, but it severely limits the options available to the hacker, which is great for security.

Indication this is implemented: When browsing to all the different domains a company owns, you get redirected to an SSO page such as Okta. 

## site-wide CSRF tokens

This one is a bit more implementation-based rather than a design decision, but it's worth including due to the number of times I've seen it implemented in a fragmented way. For example, when a company only implements CSRF protection on sensitive sites or sensitive API endpoints, there are often gaps. Or if there aren't gaps now, future features will end up lacking the CSRF protection. By properly implementing it site-wide as a policy, CSRF as a bug class can be removed as a possibility.

Indication this is implemented: When browsing to a variety of pages on multiples domains and API hosts, every request has a CSRF token as a header. 

## thanks

I really appreciate you taking the time to read this post. I plan to continue to post if you want to add this site to feedly, subscribe to my newsletter, or follow me on twitter:
* [https://twitter.com/rez0\_\_](https://twitter.com/rez0__) 
* [my newsletter](http://eepurl.com/c5WVgj) 


\- rez0

