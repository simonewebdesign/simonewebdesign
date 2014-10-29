---
title: How to install Sublime Text 3 on Debian
description: "Install Sublime Text 3 beta build, the easy way. No effort at all, requires only 30 seconds."
layout: post
permalink: /how-to-install-sublime-text-3-on-debian/
date: 2013-07-21
updated: 2014-10-29
comments: true
dsq_thread_id:
  - 1518107300
categories:
  - Bash
  - Web
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
---

<img src="/images/Sublime_Text_Logo.png" alt="Sublime Text 3" width="200" height="200" class="basic-alignment left" />

There are many ways of **installing Sublime Text 3 on Linux**, and it's super easy if you are using **Debian** (or another distribution based on it, such as **Linux Mint** or **Kali Linux**).

This little shell script **installs Sublime Text 3** on your Linux machine, with no effort at all.

Open up your **terminal**, then copy and paste:

## x64 version

```
wget http://c758482.r82.cf2.rackcdn.com/sublime-text_build-3065_amd64.deb
sudo dpkg -i sublime-text_build-3065_amd64.deb
```

## i386 version

```
wget http://c758482.r82.cf2.rackcdn.com/sublime-text_build-3065_i386.deb
sudo dpkg -i sublime-text_build-3065_i386.deb
```

The build 3065 was released on August 29, 2014, and it's still the latest stable build at time of writing (updated on October 29, 2014). In case you're interested in other bleeding-edge versions, check out the <a rel="external nofollow" href="http://www.sublimetext.com/3">official site</a>.
