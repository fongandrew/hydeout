---
layout: post
title: Using a Xiaomi Round Button as a dimmer switch
excerpt_separator: "<!--more-->"
categories: 
  - Archive
tags:
  - Homeassistant
---
I created an Appdaemon App so I can dimm my smart LEDs using a Xiaomi Round Button
<!--more-->

I already use strategically placed Xiaomi Buttons to toggle some lights, especially in the bathroom, and the bedroom.
In these rooms there is no Alexa and I don't always have my Smartphone at hand.

What I couldn't do with these buttons until know was to adjust the brightness.

To do that I created an Appdaemon App which increases the brightness as long as I hold the button.
If it increases beyong 100% it starts again from 0%.

You can find the Appdaemon App in my repo under [https://github.com/eifinger/appdaemon-scripts/tree/master/buttonClicked](https://github.com/eifinger/appdaemon-scripts/tree/master/buttonClicked)

## Edit

User [nickrout](https://community.home-assistant.io/u/nickrout/summary) pointed out to me that this has been done
done before using built in scripts and automations. You can find these blog posts here:

[https://community.home-assistant.io/t/finally-a-cheap-wireless-switch-that-dims-xiaomi-switch-gen1/27574](https://community.home-assistant.io/t/finally-a-cheap-wireless-switch-that-dims-xiaomi-switch-gen1/27574)

[https://community.home-assistant.io/t/hue-dimmer-to-actually-dim-a-light/76585/13](https://community.home-assistant.io/t/hue-dimmer-to-actually-dim-a-light/76585/13)