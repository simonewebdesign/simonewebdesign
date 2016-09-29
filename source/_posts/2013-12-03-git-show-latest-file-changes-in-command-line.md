---
title: View latest file changes in command line using Git
description: "To view latest file changes in Git, use git diff. Use git log -p if you want to see a patch of what changed in each commit."
layout: post
permalink: /git-show-latest-file-changes-in-command-line
date: 2013-12-03
comments: true
dsq_thread_id:
  - 2034177281
categories:
  - Git
tags:
  - changes
  - code
  - command
  - commit
  - diff
  - line
  - log
  - patch
  - push
---

<p>
  Let&#8217;s say you did some changes to several files, but you don&#8217;t remember which ones. How do you proceed?
</p>

<p>
  A <code>git status</code> will be enough in most cases, but it just shows which files changed &#8211; what if you want to see the actual changes you made?
</p>

<p>
  The answer is:
</p>

``` bash
$ git diff
```

<p>
  It shows every line of code you changed and that you haven&#8217;t committed yet. Useful, isn&#8217;t it?
</p>

<p>
  If you have already committed some code, but not pushed yet, don&#8217;t be afraid: you&#8217;re still in time to check if everything is good, and a <code>git log</code> will come handy:
</p>

``` bash
$ git log -p
```

<p>
  You probably already know the power of <code>git log</code>, but <code>-p</code> makes it even more powerful, because it will also show a patch of what changed in each commit.
</p>
