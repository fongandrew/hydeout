---
layout: post
title: New architecture diagram using plantuml
excerpt_separator: "<!--more-->"
categories: 
  - Archive
tags:
  - Homeassistant
  - PlantUML
---
The newest addition to my homeassistant-config: A architecture diagram of all the important hardware and software parts in setup
<!--more-->

I wanted this overview for some time, mostly for myself and to show how intertwined a home-automation setup.

![diagram](http://www.plantuml.com/plantuml/proxy?cache=no&src=https://raw.github.com/eifinger/homeassistant-config/master/www/plantuml/homeassistant-architecture.puml&fmt=svg)

When I finally found the time to actually do it using [PlantUML](www.plantuml.com) it was a matter of minutes to determine
the elements, their connection and display the image using the plantuml proxy as described in [this](https://blog.anoff.io/2018-07-31-diagrams-with-plantuml) blog post.

Sadly my first image returned from the proxy server was cut in half. I tried to come up with a solution and found out, that when I generate the diagram as svg
directly on http://www.plantuml.com/plantuml/ it was not cut in half. But now I had to get the long URL of the image and put it into my
Markdown in my repo. And I would have to do that everytime I changed something in the .puml file. That defeats one of the great benefits of PlantUML.

I headed over to the [source code](https://github.com/plantuml/plantuml-server/blob/master/src/main/java/net/sourceforge/plantuml/servlet/ProxyServlet.java) of the plantuml proxy servlet and found that I can supply a GET parameter **&fmt=svg** to force the generation of SVG instead of PNG.

This worked perfectly. I love PlantUML!

You can find my repo under [https://github.com/eifinger/homeassistant-config](https://github.com/eifinger/homeassistant-config)