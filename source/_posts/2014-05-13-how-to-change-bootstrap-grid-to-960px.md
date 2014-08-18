---
layout: post
title: "How to change Bootstrap grid to 960px"
date: 2014-08-18 21:13:06 +0100
comments: true
categories: css
---

Many people think that changing `.container`'s width to `960px` is sufficient; well, it's not quite true.

As per Bootstrap's docs, you can **disable responsiveness by forcing a fixed width to the container**:

``` css
.container {
  width: 960px !important;
}
```


## But is it what you *really* want?

I love Bootstrap, but personally if I had to build a **fixed-width 960px site**, which is quite old school nowadays, I wouldn't use Bootstrap at all. And you know what? In most cases I wouldn't even use a **grid system**! I'd use plain-old CSS (or SASS), and I'm pretty confident it would be fine. But that's me. Of course you are free to do anything you want. But remember, Bootstrap's focus is on **mobile and responsive design**.

If you need a 960px grid system, you may not want all the stuff that comes with Bootstrap. Also, you may want to think again about what you are going to build; this is way more important than the [front end framework](https://usablica.github.io/front-end-frameworks/compare.html) you will choose.

**Now, this tutorial is for who wants a 960px site, but still preserving responsiveness**.


## The *right* way

What I'm going to explain is not a hack, it's the way Bootstrap works.

When you need to **change Bootstrap's default width**, the best way is to recompile the source code. Yeah that sounds hard and time consuming, but not if you use the online tool.


### 3 simple steps

1. Go to: http://getbootstrap.com/customize/

2. Customize the [Grid system's variables](http://getbootstrap.com/customize/#grid-system);

3. Download your custom version of Bootstrap.

That's it! :)


### The 960px grid system values

These are the correct values for a 960px grid:

``` sass
@container-large-desktop: ((940px + @grid-gutter-width));
// default is ((1140px + @grid-gutter-width))

@grid-gutter-width: 20px;
// default is 30px
```


### What about the media queries?

You may want to disable the media query for large desktops, you don't need it anymore.

Changing `@screen-lg` to be `@screen-md` should do it.

I believe this is the best solution so far. It's far better than removing all stuff related to large desktops, because:

- it's definitely easier;
- you'll be able to upgrade your custom Bootstrap when you'll want to;
- you won't run into any issues.


### What if I'm using SASS/LESS?

If you are using SASS or LESS will be even easier to customize the grid system. However it really depends on what framework you are using. E.g. if you are using Ruby on Rails, chances are you are using the [bootstrap-sass][bootstrap-sass] gem. On the README in GitHub there's already everything you need to know in order to customize Bootstrap.

The only thing you have to be aware is that you should **redefine variables before importing Bootstrap**, otherwise Bootstrap will use the old ones.

Have fun!

[bootstrap-sass]: https://github.com/twbs/bootstrap-sass