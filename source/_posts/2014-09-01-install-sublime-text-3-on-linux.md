---
layout: post
title: "Install Sublime Text 3 on Linux"
description: "Install Sublime Text 3 on Fedora or other Linux distros with this shell script: curl -L git.io/sublimetext | sh"
date: 2014-09-01 13:35:34 +0100
updated: 2020-07-07
comments: true
categories: Bash
tags:
  - linux
  - shell
  - text editor
  - sublime text
  - install
---

There are <a ref="external" href="http://sublime-text-unofficial-documentation.readthedocs.org/en/latest/getting_started/install.html#linux">many ways</a> of **installing Sublime Text 3 on Linux**, but if you're looking for a fast, straightforward way, I believe you are in the right place.

This script will install **the latest build of Sublime Text 3**.

Open your terminal and run:

``` bash
curl -L git.io/sublimetext | sh
```

It will install the <a href="https://sublime.wbond.net/" rel="external">Package Control</a> as well, so you don't have to do it yourself.

If you are interested to see the actual code behind, here we go:

[https://gist.github.com/simonewebdesign/8507139](https://gist.github.com/simonewebdesign/8507139)

It should work on most Linux distros; if not, please let me know by leaving a comment below. I'm here to help.

Enjoy!

**Update**: When I wrote this script, my motivation was that there was no easy way to install Sublime Text on Linux. However, nowadays there is an official repository providing builds for all the major Linux package managers: <a href="https://www.sublimetext.com/docs/3/linux_repositories.html" rel="external">see here</a>.