---
title: How To Install Sublime Text 3 on Fedora
layout: post
permalink: /install-sublime-text-3-on-fedora-20/
date: 2014-01-29
updated: 2015-07-12
comments: true
dsq_thread_id:
  - 2188121843
categories:
  - Bash
tags:
  - fedora
  - gist
  - github
  - install
  - linux
  - script
  - sublime text
---

<p>
  Here&#8217;s a simple script to install the latest stable build of <strong>Sublime Text 3</strong> in <strong>Fedora 22 Workstation</strong>.<br /> Should work on other <strong>Linux</strong> distros too. See the <a href="https://gist.github.com/simonewebdesign/8507139" title="Install Sublime Text 3 on Fedora 20" target="_blank">full gist on GitHub</a>.
</p>

<p>It will install the Package Control as well!</p>

<p>
  Just run this command:
</p>

``` bash
$ curl -L git.io/sublimetext | sh
```

- Update (10 March 2014): I made some improvements to the script so I generated a new link.
- Update (16 March 2014): The script stopped working because GitHub is now doing a redirect to another domain (see [their post](https://developer.github.com/changes/2014-04-25-user-content-security/) if you're interested). Added the `-L` flag to fix the issue.
- Update (1 September 2014): I've updated the script to install the latest build and made a new blog post, [check it out](http://simonewebdesign.it/install-sublime-text-3-on-linux/).
- Update (12 July 2015): Updated the script again to work with the latest version of Fedora.
