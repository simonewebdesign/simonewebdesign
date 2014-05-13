---
title: How to install Sublime Text 3 on Debian
layout: post
permalink: /blog/how-to-install-sublime-text-3-on-debian/
date: 2013-07-21
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

<p>
  This little bash script installs Sublime Text 3 (build 3059 released on 17 December 2013) on your Linux machine, with no effort at all.
</p>

<h2>
  x64 version:
</h2>

``` bash
wget http://c758482.r82.cf2.rackcdn.com/sublime-text_build-3047_amd64.deb
sudo dpkg -i sublime-text_build-3047_amd64.deb
```

<h2>
  x86 version:
</h2>

``` bash
wget http://c758482.r82.cf2.rackcdn.com/sublime-text_build-3047_i386.deb
sudo dpkg -i sublime-text_build-3047_i386.deb
```

<p>
  Have fun!
</p>
