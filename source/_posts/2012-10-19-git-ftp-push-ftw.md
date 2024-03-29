---
title: Git FTP Push FTW!
description: "Learn how to use Git with FTP. A clever technique for synchronizing your local repo with your production repo."
layout: post
permalink: /git-ftp-push-ftw/
date: 2012-10-19 16:11:51 +0000
updated: 2020-02-09
categories:
  - Git
tags:
  - commit
  - deploy
  - ftp
  - push
  - repo
  - ssh
  - sync
article_cta: false
related: 2013-12-03-git-show-latest-file-changes-in-command-line
---

<p>
  <a href="http://git-scm.com/" title="Git official website">Git</a> is a wonderful tool that makes possible having your local repo and your <a href="https://github.com/" title="GitHub" rel="external">GitHub</a> repo <strong>always perfectly synchronized</strong>. This is cool and all, but — what about the production server?
</p>

<p>
  If you are in a shared hosting that doesn&#8217;t have git or <abbr title="Secure Shell">SSH</abbr> support, you&#8217;ll probably find stressful to manually update your application via <abbr title="File Transfer Protocol">FTP</abbr> each time, even for the tiniest of the edits.
</p>

<p>
  Well, if that&#8217;s your case you <em>really</em> should check out <a href="https://github.com/git-ftp/git-ftp" title="git-ftp on GitHub" rel="external">git-ftp</a> by <a href="https://github.com/resmo" title="René Moser's profile on GitHub" rel="external">René Moser</a>.
</p>

<p>
  <a href="https://github.com/git-ftp/git-ftp" title="git-ftp on GitHub" rel="external">Git-ftp</a> is a straightforward way to connect to your <abbr title="File Transfer Protocol">FTP</abbr> and automagically transfer <strong>only the files that changed since the last commit</strong>.
</p>

<p>
  The usage is fairly simple:
</p>

``` bash
git ftp push --user <user> --passwd <password> ftp://example.com/public
```

<p>
  And you can make it even simpler by just setting defaults in your project&#8217;s <code>.git/config</code> file:
</p>

``` bash
git config git-ftp.user john
git config git-ftp.url ftp.example.com
git config git-ftp.password secr3t
```

<p>
  Now you can just do:
</p>

``` bash
git ftp push
```

<p>
  <em>Et voilà!</em> Your production server is up-to-date.
</p>
