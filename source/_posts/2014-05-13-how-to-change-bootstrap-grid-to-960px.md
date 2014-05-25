---
layout: post
title: "How to change Bootstrap grid to 960px"
date: 2014-05-13 18:13:06 +0100
comments: true
published: false
categories: 
---

Preface

I'm pretty sure many of you would think changing `.container`'s width to `960px` would suffice; well, it's not quite true.

As per Bootstrap's docs, you can disable responsiveness by forcing a fixed width to the container:

``` css
.container {
  width: 960px !important;
}
```

But is it what you really want? *Really?*

Personally if I have to build a fixed-width 960px old-school site, I wouldn't use Bootstrap at all. You know what? I probably wouldn't even use a grid system! I'd go with plain-old CSS and I'm pretty confident it would be fine.

But that's me. Of course you are free to do anything you want. But please, do yourself a favour: stop for a moment and re-think about what you are going to build.

Now, this tutorial is for people who want a 960px site, but still preserving responsiveness.

