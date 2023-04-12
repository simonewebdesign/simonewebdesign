---
layout: post
title: Multiple Git Config For Different Folders
description: How to separate 'work' and 'personal' git repos using a directory-level git config.
date: 2020-11-23
categories: Git
article_cta: false
related: 2013-12-03-git-show-latest-file-changes-in-command-line
---

I wanted to have a clean separation between work-related repositories and my personal projects, as I often need to use a different email: for example, I’d like to sign git commits in the work repo with my work email, but keep using my personal email for the rest. How do you achieve this?

It’s actually pretty simple: I’ll show you how.

<!--more-->

## Two folders — one for your projects, one for work

I like the idea of having two folders, each containing _many_ git repositories: I’ll call them `Work` and `Projects`, but you’re naturally free to name them the way you prefer.

The first step is to **create a file** in your home directory, named `.gitconfig`. You probably have it already, and that’s fine. Just **open it and paste this**:

```python
[includeIf "gitdir:~/Work/"]
  path = ~/Work/.gitconfig
[includeIf "gitdir:~/Projects/"]
  path = ~/Projects/.gitconfig
```

It’s pretty self-explanatory, right? We’re essentially saying:

- If the dir matches `~/Work/`, include the config located at path `~/Work/.gitconfig`;
- If the dir matches `~/Projects/`, include the config located at path `~/Projects/.gitconfig` .

Note you don’t even need to create these files — just use `git config` to write in them. For example, to use your work email on all work-related repos, you might do:

``` bash
git config --file ~/Work/.gitconfig user.email john@example.work
```

This is great, because we can now have **completely separate configurations**, each living in their own separate folder, and the right configuration will be applied depending on the location. Awesome!

### Caveats

There are a few little caveats to be aware of, just in case you run into issues. If you do, you may want to read the *Includes* section in the [official docs](https://git-scm.com/docs/git-config#_includes) — for example, you know the trailing slash in `gitdir:~/Work/`? You’d think it wouldn’t matter, but it does: if the path ends with `/`, it matches `Work` and **everything inside, recursively**. Also, don't add a space between `gitdir:` and the path, or it won’t work.

### Sharing common configuration

You’ll likely want to avoid repeating yourself and share the common bits of configuration, such as [git aliases](https://www.git-scm.com/book/en/v2/Git-Basics-Git-Aliases), if you have any.

If that's the case, just keep those in the global config. You can do so by using the `--global` flag, for example:

``` bash
git config --global alias.st status
```

---

I hope you found this useful. If you run into trouble, feel free to leave me a comment below and I’ll try to help. [Remember, git is your friend](https://hades.github.io/2010/01/git-your-friend-not-foe/).
