---
title: How To Install Sublime Text 3 on Fedora
layout: post
permalink: /install-sublime-text-3-on-fedora-20/
date: 2014-01-29
updated: 2020-07-07
comments: true
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
article_cta: false
related: 2014-09-01-install-sublime-text-3-on-linux
---

**The following script is obsolete. Find the latest Sublime Text builds for Linux <a href="https://www.sublimetext.com/docs/3/linux_repositories.html" rel="external">here</a>.**

---

<p>
  Here&#8217;s a simple script to install the latest stable build of <strong>Sublime Text 3</strong> in <strong>Fedora</strong>.<br /> Should work on other <strong>Linux</strong> distros too. See the <a href="https://gist.github.com/simonewebdesign/8507139" title="Install Sublime Text 3 on Fedora 20" rel="external">full gist on GitHub</a>.
</p>

<p>It will install the Package Control as well!</p>

<p>
  Just run this command:
</p>

``` bash
curl -L git.io/sublimetext | sh
```

- Update (10 March 2014): I made some improvements to the script so I generated a new link.
- Update (16 March 2014): The script stopped working because GitHub is now doing a redirect to another domain (see <a href="https://developer.github.com/changes/2014-04-25-user-content-security/" rel="external">their post</a> if you're interested). Added the `-L` flag to fix the issue.
- Update (1 September 2014): I've updated the script to install the latest build and made a new blog post, <a href="/install-sublime-text-3-on-linux/" rel="external">check it out</a>.
- Update (12 July 2015): Updated the script again to work with the latest version of Fedora.
- Final update (7 July 2020): I meant to update this ages ago, but Sublime Text now officially provides builds for all common Linux distros. Here's the <a href="https://www.sublimetext.com/docs/3/linux_repositories.html#dnf" rel="external">dnf package</a> for Fedora.