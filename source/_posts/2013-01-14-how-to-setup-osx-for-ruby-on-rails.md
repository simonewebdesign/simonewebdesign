---
title: How to setup OS X 10.8 for Ruby on Rails
author: Simone Vittori
layout: post
permalink: /blog/how-to-setup-osx-for-ruby-on-rails/
dsq_thread_id:
  - 1026586953
categories:
  - Rails
tags:
  - install
  - mountain lion
  - os x 10.8
  - setup
---
<div id="jbID-529" class="jbPost">
  <p>
    Looks like <em>almost</em> every Rails developer is using <abbr title="Operating System">OS</abbr> X as development environment, so in this brief walkthrough I&#8217;ll explain you how to prepare your machine for <strong>Ruby on Rails</strong> development: nothing more, nothing less. I assume you are already running Mac <abbr title="Operating System">OS</abbr> X 10.8 Mountain Lion.
  </p>
  
  <h2>
    Install Command Line Tools for Xcode
  </h2>
  
  <p>
    <a href="https://developer.apple.com/downloads/index.action" target="_blank" rel="nofollow">Download it from developer.apple.com</a> (you need an Apple ID).
  </p>
  
  <p>
    As an alternative you can use <a href="https://github.com/kennethreitz/osx-gcc-installer" target="_blank" rel="nofollow">osx-gcc-installer</a> or install it via the Xcode <abbr title="Graphical User Interface">GUI</abbr>.
  </p>
  
  <h2>
    Install <a href="http://mxcl.github.com/homebrew/" target="_blank" rel="nofollow">Homebrew</a>
  </h2>
  
  <pre>$ ruby -e "$(curl -fsSkL raw.github.com/mxcl/homebrew/go)"</pre>
  
  <h2>
    Install <a href="https://rvm.io/" target="_blank" rel="nofollow"><abbr title="Ruby Version Manager">RVM</abbr></a> (Ruby Version Manager)
  </h2> You can: 
  
  <ol>
    <li>
      Download and install <a href="http://jewelrybox.unfiniti.com/" target="_blank">JewelryBox</a>
    </li>
    <li>
      Or from the command line: <pre>$ curl -L https://get.rvm.io | bash -s stable --ruby</pre>
    </li>
  </ol>
  
  <h2>
    Install and configure <a href="http://git-scm.com/" target="_blank" rel="nofollow">Git</a>
  </h2> You can: 
  
  <ol>
    <li>
      <a href="http://git-scm.com/downloads" target="_blank" rel="nofollow">Get the latest version from the official website</a>
    </li>
    <li>
      Or install it via Homebrew: <pre>$ brew install git</pre>
    </li>
  </ol>
  
  <pre>$ git config --global user.name "Your Name"
$ git config --global user.email "your@email.com"</pre>
  
  <h2>
    Install Ruby via <abbr title="Ruby Version Manager">RVM</abbr>
  </h2>
  
  <pre>$ rvm install ruby-2.0.0</pre>
  
  <h2>
    Install Rails via RubyGem
  </h2>
  
  <p>
    <em>Notice: you may need to restart your terminal session before installing Rails.</em>
  </p>
  
  <pre>$ gem install rails -v 3.2.13</pre>
  
  <p>
    And you&#8217;re ready to ride <strong>Ruby on Rails</strong>! <em>Yee-ha!</em>
  </p>
  
  <p>
    Problems? Suggestions? Leave a comment.
  </p>
</div>