---
title: How to install Sublime Text 3 on Debian
description: "Install Sublime Text 3 beta build, the easy way. No effort at all, requires only 30 seconds."
layout: post
permalink: /how-to-install-sublime-text-3-on-debian/
date: 2013-07-21
updated: 2015-04-16
categories:
  - Bash
tags:
  - bash
  - deb
  - debian
  - howto
  - install
  - linux
  - package
  - sh
  - shell
  - sublime
  - sublime text
  - sublime text 3
  - text
  - wget
  - wheezy
article_cta: false
related: 2014-09-01-install-sublime-text-3-on-linux
---

<img src="/images/Sublime_Text_Logo.webp" alt="Sublime Text 3" width="200" height="200" class="basic-alignment left" />

There are many ways of **installing Sublime Text 3 on Linux**, and it's super easy if you are using **Debian** (or another distribution based on it, such as **Linux Mint** or **Kali Linux**).

This little shell script **installs Sublime Text 3** on your Linux machine, with no effort at all.

Open up your **terminal**, then copy and paste:

## x64 version

``` shell
wget http://c758482.r82.cf2.rackcdn.com/sublime-text_build-3083_amd64.deb
sudo dpkg -i sublime-text_build-3083_amd64.deb
```

## i386 version

``` shell
wget http://c758482.r82.cf2.rackcdn.com/sublime-text_build-3083_i386.deb
sudo dpkg -i sublime-text_build-3083_i386.deb
```

The build 3083 was released on 26 March 2015, and it's still the latest stable build at time of writing. In case you're interested in other versions, check out the <a rel="external" href="http://www.sublimetext.com/3">official site</a>.
