---
layout: post
title: Using Template Switch and Powermeter for IR Devices
excerpt_separator: "<!--more-->"
categories: 
  - Archive
tags:
  - Homeassistant
---
I finally found a way to know whether my IR devices are really on or off
<!--more-->

For a long time I wanted to automatically turn off my TV when leaving the house or going to bed.
But the damn thing is pretty old and I control it via a [RM Pro by Broadlink](https://amzn.to/2yKO5OO) and sometimes it
does not react to the IR commands being sent.

This means I can never be sure whether the TV is really on or off. And when I don't know it, it means Homeassistant
doesn't know it either so if I include the TV in my *turn everything off when I leave* automation it could be that the
TV gets turned on instead of off.

Why? Because the IR command for On and Off is the same thing.

## Template Switch

Out of accident I stumbled upon the [Template Switch](https://www.home-assistant.io/components/switch.template/) and got
the idea to use it with a [TP-Link Smart Plug HS110](https://amzn.to/2wPNJ7F) which has a Powermeter. If the old thing
is drawing power it means that it is propably on.

Long story short, here is the template switch config I now use to avoid accidentically switching my TV on:

```yaml
- platform: template
  switches:
    tv:
      friendly_name: Fernseher
      value_template: "{{float(states.sensor.tplink_tv_power_usage.state) > 10}}"
      turn_on:
        - condition: state
          entity_id: switch.tv
          state: 'off'
        - service: switch.turn_on
          data:
            entity_id: switch.broadlink_tv
      turn_off:
        - condition: state
          entity_id: switch.tv
          state: 'on'
        - service: switch.turn_off
          data:
            entity_id: switch.broadlink_tv
```

It works great and I quickly adopted it to my old receiver in the bedroom and my RF controlled sunblind.
You can find these in my whole config under [https://github.com/eifinger/homeassistant-config](https://github.com/eifinger/homeassistant-config)