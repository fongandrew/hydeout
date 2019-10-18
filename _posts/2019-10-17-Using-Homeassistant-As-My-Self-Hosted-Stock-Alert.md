---
layout: post
title: Using Homeassistant as my self hosted stock alert
excerpt_separator: "<!--more-->"
categories: 
  - Archive
tags:
  - Homeassistant
  - Brokerage
  - Stock
---
I recently start to take an interest into the stock markets and investing into stocks directly instead of fonds or the like. For some interesting stocks I was looking for an online stock alert website or app but soon realized that all of them required at least my email and would start sending me tons of spam mails.
Why not use this great system I have at home the one which is focused on privacy?
<!--more-->

# Available Stock Sensors

[Homeassistant](https://www.home-assistant.io) does have the built in component [alpha_vantage](https://www.home-assistant.io/integrations/alpha_vantage/) which requires an API key and in return offers you information on stocks and cryptocoins. Unfortunately the stock information is currently broken and I can only use it to track my Monero investment.

I took a short look in the [HACS](https://hacs.xyz/) store and found the custom component [avanza_stock](https://github.com/custom-components/sensor.avanza_stock).

# The first stock sensor

Following the instructions I searched for the Microsoft stock, got the ID from the URL and created my first sensor:

```yaml
sensor:
  - platform: avanza_stock
    stock: 3873
    name: avanza_microsoft
    monitored_conditions:
      - change
      - changePercent
      - country
      - currency
      - directYield
      - dividends
      - flagCode
      - hasInvestmentFees
      - highestPrice
      - id
      - isin
      - lastPrice
      - lastPriceUpdated
      - loanFactor
      - lowestPrice
      - marketCapital
      - marketList
      - marketMakerExpected
      - marketPlace
      - marketTrades
      - morningStarFactSheetUrl
      - name
      - numberOfOwners
      - orderDepthReceivedTime
      - priceAtStartOfYear
      - priceEarningsRatio
      - priceFiveYearsAgo
      - priceOneMonthAgo
      - priceOneWeekAgo
      - priceOneYearAgo
      - priceSixMonthsAgo
      - priceThreeMonthsAgo
      - priceThreeYearsAgo
      - pushPermitted
      - quoteUpdated
      - sector
      - shortSellable
      - superLoan
      - tickerSymbol
      - totalNumberOfShares
      - totalValueTraded
      - totalVolumeTraded
      - tradable
      - volatility
```

I am not sure if I will not all the attributes but I can always get rid of them again later.
To display the sensor in the form of a stock tracker I chose the custom card [mini-graph-card](https://github.com/kalkih/mini-graph-card):

![mini_graph_card_microsoft_stock](https://raw.githubusercontent.com/eifinger/blog.kevineifinger.de/master/assets/pictures/mini_graph_card_microsoft_stock.png)

The configuration for this card is as follows:

```yaml
- animate: true
  entities:
    - sensor.avanza_microsoft
  graph: line
  hour24: true
  hours_to_show: 720 # 1 month
  name: Microsoft Stock last Month
  show:
    extrema: true
    icon: true
    name: true
  type: 'custom:mini-graph-card'
```

# The stock alert system

I want to be notified when the tracked stock reaches a certain upper or lower limit. These limits change frequently so I don't want to restart homeassistant every time I want to adjust the limits.

I chose [input_text](https://www.home-assistant.io/integrations/input_text/) elements to hold my tresholds:

```yaml
input_text:
  avanza_microsoft_min:
    icon: mdi:arrow-collapse-down
    name: Min Alert
  avanza_microsoft_max:
    icon: mdi:arrow-collapse-up
    name: Max Alert
```

I combined them with an [automation](https://www.home-assistant.io/docs/automation/) which sends me a notification as soon as the sensor is above the max or under the min limit:

```yaml
automation:
- id: avanza_microsoft
  alias: Avanza Microsoft
  trigger:
    - platform: template
      value_template: >
        {{ states('sensor.avanza_microsoft') | float > states('input_text.avanza_microsoft_max') | float and states('input_text.avanza_ibm_min') not in ['unknown', ''] }}
    - platform: template
      value_template: >
        {{ states('sensor.avanza_microsoft') | float < states('input_text.avanza_microsoft_min') | float and states('input_text.avanza_ibm_min') not in ['unknown', ''] }}
  action:
    - service: notify.kevin
      data_template:
        message: >
          {% if states('sensor.avanza_microsoft') | float > states('input_text.avanza_microsoft_max') | float %}
          "Stock alert: {{ state_attr('sensor.avanza_microsoft','name') }} over threshold of {{ states('input_text.avanza_microsoft_max') }}"
          {% else %}
          "Stock alert: {{ state_attr('sensor.avanza_microsoft','name') }} under threshold of {{ states('input_text.avanza_microsoft_min') }}"
          {% endif %}
```

I use [Telegram](https://www.home-assistant.io/integrations/telegram_webhooks/) as my notification system but you can use every supported notification component.

The whole sensor with the stock alert controls looks like this:

![complete_microsoft_stock](https://raw.githubusercontent.com/eifinger/blog.kevineifinger.de/master/assets/pictures/complete_microsoft_stock.png)

As soon as the sensor reaches a treshold I get a notification:

![stock_alert_johnson_and_johnson](https://raw.githubusercontent.com/eifinger/blog.kevineifinger.de/master/assets/pictures/stock_alert_johnson_and_johnson.png)

The Microsoft Alert did not trigger yet so I had to choose another stock ;-)

As always you can find the whole configuration in my repo under [https://github.com/eifinger/homeassistant-config](https://github.com/eifinger/homeassistant-config)