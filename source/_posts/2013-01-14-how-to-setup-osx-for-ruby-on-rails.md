---
title: How to setup OS X 10.8 for Ruby on Rails 3.2
description: "Learn how to install Ruby 2 in your Mac OS X for a Ruby on Rails development environment. This guide is aimed at Mac OS X 10.8 Mountain Lion's users."
layout: post
permalink: /how-to-setup-osx-for-ruby-on-rails/
date: 2013-01-14 14:08:36 +0000
comments: true
dsq_thread_id:
  - 1026586953
categories:
  - Ruby
tags:
  - install
  - mountain lion
  - os x 10.8
  - setup
article_cta: false
---

<p>
  Looks like <em>almost</em> every Rails developer is using <abbr title="Operating System">OS</abbr> X as development environment, so in this brief walkthrough I&#8217;ll explain you how to prepare your machine for <strong>Ruby on Rails</strong> development: nothing more, nothing less. I assume you are already running Mac <abbr title="Operating System">OS</abbr> X 10.8 Mountain Lion.
</p>

<h2>
  Install Command Line Tools for Xcode
</h2>

<p>
  <a href="https://developer.apple.com/downloads/index.action" rel="external">Download it from developer.apple.com</a> (you need an Apple ID).
</p>

<p>
  As an alternative you can use <a href="https://github.com/kennethreitz/osx-gcc-installer" rel="external">osx-gcc-installer</a> or install it via the Xcode <abbr title="Graphical User Interface">GUI</abbr>.
</p>

<h2>
  Install <a href="https://mxcl.github.com/homebrew/" rel="external">Homebrew</a>
</h2>

``` bash
$ ruby -e "$(curl -fsSkL raw.github.com/mxcl/homebrew/go)"
```

<h2>
  Install <a href="https://rvm.io/" rel="external"><abbr title="Ruby Version Manager">RVM</abbr></a> (Ruby Version Manager)
</h2> You can:

<ol>
  <li>
    Download and install <a href="http://jewelrybox.unfiniti.com/">JewelryBox</a>
  </li>
  <li>
    Or from the command line:
``` bash
$ curl -L https://get.rvm.io | bash -s stable --ruby
```
  </li>
</ol>

<h2>
  Install and configure <a href="http://git-scm.com/" rel="external">Git</a>
</h2> You can:

<ol>
  <li>
    <a href="http://git-scm.com/downloads" rel="external">Get the latest version from the official website</a>
  </li>
  <li>
    Or install it via Homebrew:
``` bash
$ brew install git
```
  </li>
</ol>

``` bash
$ git config --global user.name "Your Name"
$ git config --global user.email "your@email.com"
```

<h2>
  Install Ruby via <abbr title="Ruby Version Manager">RVM</abbr>
</h2>

``` bash
$ rvm install ruby-2.0.0
```

<h2>
  Install Rails via RubyGem
</h2>

<p>
  <em>Notice: you may need to restart your terminal session before installing Rails.</em>
</p>

``` bash
$ gem install rails -v 3.2.13
```

<p>
  And you&#8217;re ready to ride <strong>Ruby on Rails</strong>! <em>Yee-ha!</em>
</p>

<p>
  Problems? Suggestions? Leave a comment.
</p>
