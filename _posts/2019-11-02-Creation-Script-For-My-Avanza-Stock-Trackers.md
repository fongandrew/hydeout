---
layout: post
title: Creation Script For My Avanza Stock Trackers
excerpt_separator: "<!--more-->"
categories: 
  - Archive
tags:
  - Homeassistant
  - Brokerage
  - Stock
  - Python
---
A new utility script to automate the entity creation for my avanza stock trackers.
<!--more-->

## The Problem

In my article [Using-Homeassistant-As-My-Self-Hosted-Stock-Alert](https://blog.kevineifinger.de/archive/2019/10/17/Using-Homeassistant-As-My-Self-Hosted-Stock-Alert.html) I described how I used Homeassistant to keep track of stocks and send me automated alert when lower or upper tresholds are met. After adding a few of them I got annoyed with the time consuming process of copy&pasting that was needed to add the new sensors to my configuration.yaml.

## The Script

I chose Python instead of bash or powershell because I wanted the script to run on my Windows 10 laptop as well as on my Ubuntu server directly.

[click](https://click.palletsprojects.com/en/7.x/) is a really great Pthon lib that enables you to write a beatiful command line interface in a few minutes. I used it together with [Template](https://docs.python.org/3/library/string.html#template-strings) which is part of the Python standard library to create this script:

```python
"""Create new Avanza Stock Sensors."""

import click
from string import Template

TEMPLATE_FILE = "avanza_stock.yaml.template"

@click.command()
@click.argument('name', type=click.STRING)
@click.argument('id', type=click.INT)
def cli(name, id):
    filein = open( TEMPLATE_FILE )
    template = Template( filein.read() )
    result = template.safe_substitute(name=name,id=id)
    filename = f"avanza_stock_{name}.yaml"
    with open(filename, "w") as f:
        f.write(result)

if __name__ == '__main__':
    cli()
```

This script is located under `<config>/packages/avanza_stock` and uses the following template to create new yaml files under the same directory. These will get picked up by Homeassistant via the packages mechanism.

```yaml
{% raw %}---
sensor:
  - platform: avanza_stock
    stock: ${id}
    name: avanza_${name}
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
input_text:
  avanza_${name}_min:
    icon: mdi:arrow-collapse-down
    name: Min Alert
  avanza_${name}_max:
    icon: mdi:arrow-collapse-up
    name: Max Alert
automation:
  - id: avanza_${name}
    alias: Avanza ${name}
    trigger:
      - platform: template
        value_template: >
          {{ states('sensor.avanza_${name}') | float > states('input_text.avanza_${name}_max') |float
          and states('input_text.avanza_${name}_max') not in ['unknown', ''] }}
      - platform: template
        value_template: >
          {{ states('sensor.avanza_${name}') | float < states('input_text.avanza_${name}_min') | float
          and states('input_text.avanza_${name}_min') not in ['unknown', ''] }}
    action:
      - service: notify.kevin
        data_template:
          message: >
            {% if states('sensor.avanza_${name}') | float >states('input_text.avanza_${name}_max') | float %}
            "Stock alert: {{ state_attr('sensor.avanza_${name}','name') }}:
            {{ states('sensor.avanza_${name}') }} {{ state_attr('sensor.avanza_${name}','currency') }}.
            Over threshold of {{ states('input_text.avanza_${name}_max') }}"
            {% else %}
            "Stock alert: {{ state_attr('sensor.avanza_${name}','name') }}:
            {{ states('sensor.avanza_${name}') }} {{ state_attr('sensor.avanza_${name}','currency') }}.
            Under threshold of {{ states('input_text.avanza_${name}_min') }}"
            {% endif %}
{% endraw %}
```

I can now use the following command to create a new sensor without the need for copy pasting:

```bash
python new_avanza_stock_sensors.py pfizer 4145
```

You can find the Python script and the template file [here](https://github.com/eifinger/homeassistant-config/tree/master/packages/avanza_stock) and as always you can find the whole configuration in my repo under [https://github.com/eifinger/homeassistant-config](https://github.com/eifinger/homeassistant-config)
