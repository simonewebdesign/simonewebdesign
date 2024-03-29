---
title: Git cheat sheet
description: "Quick-start reference for GitHub. Learn Git quickly and be immediately productive with this very pragmatic Git cheat sheet!"
layout: post
permalink: /git-cheat-sheet/
date: 2013-03-04 14:47:22 +0000
categories:
  - Git
tags:
  - add
  - area
  - branch
  - branching
  - cheat
  - cheatsheet
  - check
  - checkout
  - clone
  - cloning
  - commands
  - commit
  - github
  - guide
  - initialize
  - log
  - merge
  - merging
  - push
  - reference
  - remote
  - remove
  - sheet
  - staging
  - status
  - tag
  - tagging
article_cta: false
related: 2012-10-19-git-ftp-push-ftw
---

<p>
  Git is an awesome tool for developers, but can be a bit hard to grasp at a first glance. Fortunately, the concepts you need to learn to be <strong>immediately productive</strong> are very few: I&#8217;ll briefly illustrate them in this <strong>Git cheat sheet</strong>.
</p>

<h2>
  1. Basics
</h2>

``` bash
# start a Git repository from scratch
$ git init

# copy an existing repository into the current directory
$ git clone https://github.com/username/repository.git

$ git status  # check current status
```

<h2>
  2. Snapshotting
</h2>

``` bash
# Add files to staging area
$ git add filename  # add a single file
$ git add .         # add all files, but not deleted ones
$ git add --all     # add everything

# Stashing takes the current state of the working directory and
# puts it on a stack for later
$ git stash        # add current changes to the stack
$ git stash list   # see what's in the stack
$ git stash apply  # bring back the saved changes
```

<h2>
  3. Committing
</h2>

``` bash
$ git commit            # open the text editor (usually vi)
$ git commit -a         # automatically stage modified files
$ git commit -m "foo"   # commit with message "foo"
$ git commit -am "foo"  # both stage files and commit with message "foo"

# View commits log (in a pretty way)
$ git log --oneline --decorate --graph
```

<h2>
  4. Managing remotes
</h2>

``` bash
$ git remote add origin https://github.com/user/repo.git
# You can also add your GitHub username and password on the remote URL:
$ git remote add origin https://user:password@github.com/user/repo.git
$ git remote rm origin  # removes the `origin` remote
```

<h2>
  5. Pushing
</h2>

``` bash
$ git push -u origin master
# -u here tells git to remember the parameters
# so that next time we can simply run:
$ git push
```

<h2>
  6. Branching
</h2>

``` bash
$ git checkout -b new_branch
# -b is to checkout and create a branch at the same time.
# This is the same thing as doing:
$ git branch new_branch
$ git checkout new_branch
```

<h2>
  7. Merging
</h2>

``` bash
$ git checkout master       # return to master branch
$ git merge --no-ff foobar  # merge `master` branch with `foobar` branch
$ git branch -d foobar      # delete branch locally
$ git push origin :foobar   # delete branch on the origin remote
```

<h2>
  8. Tagging
</h2>

``` bash
$ git tag -a v1.3.37               # tag the HEAD (most recent commit)
$ git tag -a v0.6b f49a23c         # tag the commit with SHA `f49a23c`
$ git tag -a v4.2 -m "jelly bean"  # append a message
```

<hr />

<p>
  That&#8217;s all, folks. I know I could have explained much more every single command, but that&#8217;s not the point of this article. I just wanted to give you a <strong>quick-start pragmatic reference</strong>; in fact, these are the commands I personally use more frequently.
</p>

<p>
  Do you think some very useful commands are missing in this <strong>cheat sheet</strong>? Leave a reply.
</p>

<ul>
  <li>
    <em>Update March 5th: added tagging.</em>
  </li>
  <li>
    <em>Update April 23rd: just made some &#8220;refactoring&#8221; and added <code>git stash</code>.</em>
  </li>
  <li>
    <em>Update Dec 3rd: I&#8217;ve updated the &#8220;merging&#8221; section with the command for deleting the remote branch as well. I&#8217;ve also added the <code>--no-ff</code> option, that disables fast-forwarding (reason explained <a href="http://nvie.com/posts/a-successful-git-branching-model/" title="A successful Git branching model">here</a>).</em>
  </li>
</ul>
