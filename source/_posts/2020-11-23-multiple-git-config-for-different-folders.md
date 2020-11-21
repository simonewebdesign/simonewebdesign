---
layout: post
title: Multiple Git Config For Different Folders
description: How to separate 'work' and 'personal' git repos using a directory-level git config.
date: 2020-11-23
comments: true
categories: Git
---

I wanted to have a clean separation between work-related repositories and my personal projects, as I often need to use a different email: for example, I’d like to sign git commits in the work repo with my work email, but keep using my personal email for the rest. How do you achieve this?

It’s actually pretty simple: I’ll show you how.

<!--more-->

## Two folders — one for your projects, one for work

I like the idea of having two folders, each containing _many_ git repositories: I’ll call them `Work` and `Projects`, but you’re naturally free to name them the way you prefer.

The first step is to **create a file** in your home directory, named `.gitconfig`. You probably have it already, and that’s fine. Just **open it and paste this**:

```python ~/.gitconfig
[includeIf "gitdir:~/Work/"]
  path = ~/Work/.gitconfig
[includeIf "gitdir:~/Projects/"]
  path = ~/Projects/.gitconfig
```

It’s pretty self-explanatory, right? We’re essentially saying:

- If the dir matches `~/Work/`, include the config located at path `~/Work/.gitconfig`;
- If the dir matches `~/Projects/`, include the config located at path `~/Projects/.gitconfig` .

Note you don’t even need to create these files—just use `git config` to write in them. For example, to use your work email on all work-related repos, you might do:

```ruby
git config --file ~/Work/.gitconfig user.email john@example.work
```

This is great, because we can now have **completely separate configurations**, each living in their own separate folder, and the right configuration will be applied depending on the location. Awesome!

---

I hope you found this useful. If you run into trouble, feel free to leave me a comment and I’ll try to help. [Remember, git is your friend](https://hades.github.io/2010/01/git-your-friend-not-foe/).