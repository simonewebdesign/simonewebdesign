---
layout: post
title: How to fix “Untracked working tree would be overwritten by merge” error
date: 2020-05-26
comments: true
published: false
categories:
  - git
---

Let's say you have two Git repositories: one on GitHub, and one on your computer.<br>They contain identical (or very similar) files, and what you want to do is "synchronize" them (i.e. make them look exactly the same). Maybe all you need is to download a few missing files from GitHub to your computer, or simply push some changes from your machine to GitHub.

You have tried `git pull`, but you're getting this error:

    error: Untracked working tree file * would be overwritten by merge.
    fatal: read-tree failed

You need the changes, but obviously you don't want to overwrite or lose any files. Don't worry, the fix is actually straightforward!

## Why am I seeing this error?

The reason is probably because you didn't **clone** the repository. In my case, I already had some local files, so instead of running `git clone`, here's what I did:

    git init
    git remote add origin git@github.com/<username>/<reponame>.git

If you try to `git pull origin <branch-name>`, you might get the "untracked working tree" error.

## How do I fix it?

If you have already tried pulling from the remote and it didn't work, **here's the fix**:

    git branch --track <branch-name> origin/<branch-name>

For example, if your branch is named `master`:

    git branch --track master origin/master

What this does is simply tell Git that these two branches, `master` and `origin/master`, are related to each other, and that it should keep track of the changes between them. Turns out it also fixes the error, since Git can now _see_ that nothing would be overwritten.

## Wait — that's it?

Yes! After running the command above, `git status` will indeed reveal the differences between the two repositories: your untracked files (i.e. extra files that you only have on your PC) will still be there, and some other files may have been automatically staged for deletion: these are files that are present in the remote repo, but you don't have locally.

At this point you'll want to double-check that everything is the way it should be. You may also want to run:

    git reset

To get a clean state. Don't worry, this won't delete anything at all, it will simply unstage any modification that was applied automatically by Git. You can stage back the changes you care about using `git add .` — once you are happy, you can finally make a commit and run:

    git push

Note there's no need to specify the origin and the branch name anymore, since the two branches (the local and the remote) are now tracked.

---

Hopefully this article helped you fix your issue; either way, feel free to ask for help by leaving a comment below.

Happy hacking!