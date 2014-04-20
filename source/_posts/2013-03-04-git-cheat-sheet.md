---
title: Git cheat sheet
author: Simone Vittori
layout: post
permalink: /blog/git-cheat-sheet/
dsq_thread_id:
  - 1117190384
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
---
<div id="jbID-645" class="jbPost">
  <p>
    Git is an awesome tool for developers, but can be a bit hard to grasp at a first glance. Fortunately, the concepts you need to learn to be <strong>immediately productive</strong> are very few: I&#8217;ll briefly illustrate them in this <strong>Git cheat sheet</strong>.
  </p>
  
  <h2>
    1. Basics
  </h2>
  
  <pre>
# start a Git repository from scratch
$ git init

# copy an existing repository into the current directory
$ git clone https://github.com/username/repository.git

$ git status  # check current status
</pre>
  
  <h2>
    2. Snapshotting
  </h2>
  
  <pre>
# Add files to staging area
$ git add filename  # add a single file
$ git add .         # add all files, but not deleted ones
$ git add --all     # add everything

# Stashing takes the current state of the working directory and
# puts it on a stack for later
$ git stash        # add current changes to the stack
$ git stash list   # see what's in the stack
$ git stash apply  # bring back the saved changes
</pre>
  
  <h2>
    3. Committing
  </h2>
  
  <pre>
$ git commit            # open the text editor (usually vi)
$ git commit -a         # automatically stage modified files
$ git commit -m "foo"   # commit with message "foo"
$ git commit -am "foo"  # both stage files and commit with message "foo"

# View commits log (in a pretty way)
$ git log --oneline --decorate --graph
</pre>
  
  <h2>
    4. Managing remotes
  </h2>
  
  <pre>
$ git remote add origin https://github.com/user/repo.git
# You can also add your GitHub username and password on the remote URL:
$ git remote add origin https://user:password@github.com/user/repo.git
$ git remote rm origin  # removes the `origin` remote
</pre>
  
  <h2>
    5. Pushing
  </h2>
  
  <pre>
$ git push -u origin master
# -u here tells git to remember the parameters 
# so that next time we can simply run:
$ git push
</pre>
  
  <h2>
    6. Branching
  </h2>
  
  <pre>
$ git checkout -b new_branch
# -b is to checkout and create a branch at the same time.
# This is the same thing as doing:
$ git branch new_branch
$ git checkout new_branch
</pre>
  
  <h2>
    7. Merging
  </h2>
  
  <pre>
$ git checkout master       # return to master branch
$ git merge --no-ff foobar  # merge `master` branch with `foobar` branch 
$ git branch -d foobar      # delete branch locally
$ git push origin :foobar   # delete branch on the origin remote
</pre>
  
  <h2>
    8. Tagging
  </h2>
  
  <pre>
$ git tag -a v1.3.37               # tag the HEAD (most recent commit)
$ git tag -a v0.6b f49a23c         # tag the commit with SHA `f49a23c`
$ git tag -a v4.2 -m "jelly bean"  # append a message
</pre>
  
  <hr />
  
  <p>
    That&#8217;s all, folks. I know I could have explained much more every single command, but that&#8217;s not the point of this article. I just wanted to give you a <strong>quick-start pragmatic reference</strong>; in fact, these are the commands I personally use more frequently.
  </p>
  
  <p>
    Do you think some very useful commands are missing in this <strong>cheat sheet</strong>? Leave a reply.
  </p>
  
  <ul>
    <li>
      <em>Update march 5: added tagging.</em>
    </li>
    <li>
      <em>Update april 23: just made some &#8220;refactoring&#8221; and added <code>git stash</code>.</em>
    </li>
    <li>
      <em>Update dec 3: I&#8217;ve updated the &#8220;merging&#8221; section with the command for deleting the remote branch as well. I&#8217;ve also added the <code>--no-ff</code> option, that disables fast-forwarding (reason explained <a href="http://nvie.com/posts/a-successful-git-branching-model/" title="A successful Git branching model" target="_blank">here</a>).</em>
    </li>
  </ul>
</div>