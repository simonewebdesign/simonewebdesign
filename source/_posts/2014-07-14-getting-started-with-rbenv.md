---
layout: post
title: "Getting started with rbenv"
date: 2014-07-14 11:10:14 +0100
comments: true
categories: Ruby
---

If you are struggling to get rbenv working on your machine, then I believe you landed in the right place: here I'm sharing some gotchas I had while setting up rbenv on Mac OS X 10.9.3.

First of all, **make sure you remove RVM completely. It's not compatible with rbenv.**

``` bash
rm -r ~/.rvm
```

Remove it from your `$PATH` as well.

I'm using [fish shell](http://fishshell.com/), that has its own quirks, such as it doesn't have a `export` command to export variables to `$PATH`. Instead it uses `set`. E.g.:

``` bash
set VARIABLE VALUE
```

For example, in order to call `rbenv`, I set up my `$PATH` this way:

``` bash
set -u fish_user_paths $fish_user_paths ~/.rbenv/bin
```

Fish also handles things a bit differently. If you are using it, you'll probably be burned by the fact it doesn't understand the `$` function that in POSIX shells creates a sub shell. Fortunately I managed to find a fix for that: [see this article](https://coderwall.com/p/hmousw). Basically it says you need to add this code to your `config.fish` file:

``` bash
set -gx RBENV_ROOT /usr/local/var/rbenv
. (rbenv init -|psub)
```

But pay attention and make sure you understand what's going on here. Actually the code above didn't work for me, as **the installation path of my rbenv was different. If you installed rbenv with `git clone`, the right code is:**

``` bash
set -gx RBENV_ROOT ~/.rbenv
. (rbenv init -|psub)
```

In fish it's also possible (albeit not recommended) to use the `config.fish` file in order to set the `$PATH` variable permanently. You can do it with (e.g.):

``` bash
set -x PATH ~/.rbenv/shims /usr/local/bin /usr/bin /bin $PATH
```

A big gotcha here is to have `~/.rbenv/shims` **before** `/bin` and `/usr/bin`, otherwise the shell will load the system's Ruby first (and [you don't want to use the system's Ruby](http://robots.thoughtbot.com/psa-do-not-use-system-ruby) for your projects).

To ensure I was using the right Ruby version, I moved the system Ruby away, in `/tmp`. Of course you need to `sudo` for that:

``` bash
sudo mv /usr/bin/ruby /tmp
```

Another super important thing is: **NEVER EVER install gems using `sudo`**. If you do that you're going to have serious problems/conflicts and weird errors in your shell. Do yourself a favour by installing things in your home (`~`) and avoiding `sudo` at all costs. *Always.*

A good thing to do for ensuring you are going down the right path is to use `which`: `which rbenv`, `which ruby` and `which gem` will tell you if you actually have your stuff in the right place (that is the `.rbenv/shims` on your home folder).

At this stage you may be able to install Ruby (you need the [ruby-build](https://github.com/sstephenson/ruby-build) plugin for that). Run:

``` bash
rbenv install -l
```

The command above will give you a list of all the available rubies to install. Run, for example:

``` bash
rbenv install 2.1.2
rbenv rehash
```

The above will install Ruby 2.1.2 into `~/.rbenv/versions` and will rebuild your shim files. Note that you need to run `rbenv rehash` every time after you install a version of Ruby.

Another useful command is:

``` bash
rbenv global
```

This tells you which version of Ruby you have. It may differ from what `ruby -v` says to you, and if that's your case, you'll probably want to [check your `$PATH`](https://github.com/sstephenson/rbenv#understanding-path).

Hopefully that's enough for getting you started with rbenv. Enjoy!
