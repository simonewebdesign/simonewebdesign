---
layout: post
title: How to fix “Untracked working tree would be overwritten by merge” error
description: A common Git error, the fix is explained in this blog post. It happens because files aren't tracked locally, but the same files are present remotely.
date: 2020-06-25
published: true
categories:
  - Git
article_cta: false
---

Let's say you have two Git repositories: one on GitHub, and one on your computer.<br>They contain **identical** (or very similar) files, and what you want to do is "synchronize" them (i.e. make them look exactly the same). Maybe all you need is to download a few missing files from GitHub to your computer, or simply push some changes from your machine to GitHub.

You have tried `git pull`, but you're getting this error:

    error: Untracked working tree file * would be overwritten by merge.
    fatal: read-tree failed

You need the changes, but obviously you don't want to overwrite or lose any files. Don't worry, the fix is actually straightforward!

<!--more-->

## Why am I seeing this error?

The reason is probably because you didn't **clone** the repository. In my case, I already had some local files, so instead of running `git clone`, here's what I did:

``` bash
git init
git remote add origin git@github.com:<username>/<reponame>.git
```

If you try to `git pull origin <branch-name>`, you might get the "untracked working tree" error.

## How do I fix it?

If you have already tried pulling from the remote and it didn't work, **here's the fix**:

``` bash
git branch --track <branch-name> origin/<branch-name>
```

For example, if your branch is named `main`:

``` bash
git branch --track main origin/main
```

What this does is simply tell Git that these two branches, `main` and `origin/main`, are related to each other, and that it should keep track of the changes between them. Turns out it also fixes the error, since Git can now _see_ that nothing would be overwritten.

## Wait — that's it?

Yes! After running the command above, `git status` will indeed reveal the differences between the two repositories: your untracked files (i.e. extra files that you only have on your PC) will still be there, and some other files may have been automatically staged for deletion: these are files that are present in the remote repo, but you don't have locally.

At this point you'll want to double-check that everything is the way it should be. You may also want to run:

``` bash
git reset
```

To get a clean state. Don't worry, this won't delete anything at all, it will simply unstage any modification that was applied automatically by Git. You can stage back the changes you care about using `git add .` — once you are happy, you can finally make a commit and run:

``` bash
git push
```

Note there's no need to specify the origin and the branch name anymore, since the two branches (the local and the remote) are now tracked.

---

Hopefully this article helped you fix your issue; either way, feel free to ask for help by leaving a comment below.

Happy hacking!
