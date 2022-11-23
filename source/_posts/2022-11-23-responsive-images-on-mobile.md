---
layout: post
title: Responsive images on mobile
description: A smart technique for serving an optimized image size based on the client viewport width. ##Is it possible to inject CSS in an external browser?
permalink: /responsive-images-on-mobile/
date: ##2022-10-09
comments: false
categories:
  - JavaScript
  - CSS
published: false
---

So you have a Card component and want to make its hero image fully responsive. How would you go about it?

What I usually do on images is simply have CSS like this:

```css
img {
  max-width: 100%;
}
```

This enforces the image to resize automatically, depending on the screen size. It Just Works<sup>TM</sup>, however, how do we ensure the browser will load the image at the size that is needed for the device we're using?

We can use the `srcset` attribute to define which image should be loaded at which screen size. We can even use the same attribute to serve different resolution images to higher pixel density screens. For even more advanced needs, where the art direction is important, we can use the `<picture>` element.

There is definitely a lot in the web platform to cover the vast majority of cases. However, what if we want to serve an image that is exactly as wide as the current viewport? We cannot really do that, because we cannot know the viewport width while rendering the page server-side — we can only detect it client-side, with JavaScript.

## How to

In this blog post I'm going to describe a technique that I believe wor

Enter [responsive images](https://developer.mozilla.org/en-US/docs/Learn/HTML/Multimedia_and_embedding/Responsive_images).



What I'm going to describe in this blog post is a solution

 serve them at 2x <abbr title="Dots Per Inch">DPI</abbr> and then scale them down to 1x, by setting