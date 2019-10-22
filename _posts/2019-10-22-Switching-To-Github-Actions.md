---
layout: post
title: Switching to Github Actions
excerpt_separator: "<!--more-->"
categories: 
  - Archive
tags:
  - Homeassistant
  - Github
---
I switched my CI system from Azure DevOps to Github Actions.
<!--more-->

# My CI History

When I published my homeassistant config on [May 23rd 2018](https://github.com/eifinger/homeassistant-config/commit/e13607145c172b36dd57013fa9960da482b9b994) I started out using Travis CI as my configuration test pipeline and stayed with it a long time.

I switched to [Azure DevOps Pipelines](https://azure.microsoft.com/de-de/services/devops/pipelines/) on [July 21st 2019](https://github.com/eifinger/homeassistant-config/commit/28719f07fdb96fffcab09ce9fa17f336b4269249) because Travis was too slow for me and I started working with Azure DevOps at work and wanted to use my private repos to get experience as fast as possible.

# Why Github Actions?

The fact that I use Azure DevOps at work is actually the reason why I switched to Github Actions.

Azure DevOps Pipeline are great. Great documentation, a fast adoption process by the homeassistant repo itself and they are really really fast.

**BUT** when I want to check the details of my pipelines I always get frustrated when I am logged in to Azure DevOps with the wrong user. I have to log out and log in again, maybe use my 2 Factor Auth.... I don't like it!

As Github Actions where released recently I wanted to try them out. I signed up for the beta program and searched for a good template to start. I found one in the workflow which [@frenck](https://twitter.com/Frenck) is using in [his github repo](https://github.com/frenck/home-assistant-config/blob/master/.github/workflows/home-assistant.yml).

# My Github Action Workflow

Frenck tests his configuration against the latest, beta and dev versions of homeassistant. For me it is most important that the configuration works with the version I have currently running. I have not yet come up with a method to set this version other than hardcoding it into the workflow file and changing it when I upgrade. The workflow which test against the installed version is this:

```yaml
---
name: Home Assistant Installed

# yamllint disable-line rule:truthy
on:
  push:
  pull_request:

jobs:
  yamllint:
    runs-on: ubuntu-latest
    steps:
      - name: Getting your configuration from GitHub
        uses: actions/checkout@v1
      - name: Running YAMLlint
        uses: "docker://pipelinecomponents/yamllint:latest"
        with:
          args: yamllint .
  remarklint:
    runs-on: ubuntu-latest
    steps:
      - name: Getting your configuration from GitHub
        uses: actions/checkout@v1
      - name: Running Remark lint
        uses: "docker://pipelinecomponents/remark-lint:latest"
        continue-on-error: true
        with:
          args: "remark --no-stdout --color --frail --use preset-lint-recommended ."
  home_assistant_ci:
    runs-on: ubuntu-latest
    steps:
      - name: Getting configuration from GitHub
        uses: actions/checkout@master
      - name: Create secrets.yaml
        run: mv travis_secrets.yaml secrets.yaml
      - name: Home Assistant Check Installed
        uses: "docker://homeassistant/home-assistant:0.98.5"
        with:
          args: python -m homeassistant --config . --script check_config --info all

```

You can also find this file directly in my repo [here](https://github.com/eifinger/homeassistant-config/blob/master/.github/workflows/homeassistant-installed.yaml).

I copied over the `remarklint` and `yamllint` tasks from Frenck. Now I have to do a ton of cleaning up so my config will pass. I guess I deserve that for being so lazy over the time.

## Also check upcoming versions

As Frenck I also want to know whether my config will work for upcoming versions of homeassistant. But I do want to get notified of that in a separate email because I don't want my workflow to fail when my installed version is working but an upcoming version does not.

The way to get this to work was to crate a separate worflow file which does exactly the same as the previous one, only with the latest version of homeassistant.

You can find the workflow for the latest homeassistant version [here](https://github.com/eifinger/homeassistant-config/blob/master/.github/workflows/homeassistant-latest.yaml).

# Conclusion

I now get two emails whenever I push a change to my repo. One which tells me if the change will work for my current version I have running and one which will tell me if it will keep running if I want to change to a newer version.

A run takes around 2 minutes and 20 seconds. I think thats reasonably fast.
The configuration of the workflow is very similar to Azure DevOps pipelines but currently lacks a good and thorough documentation.

However it was fun setting this up and I am definitely satisfied with the result.

As always you can find the whole configuration in my repo under [https://github.com/eifinger/homeassistant-config](https://github.com/eifinger/homeassistant-config)