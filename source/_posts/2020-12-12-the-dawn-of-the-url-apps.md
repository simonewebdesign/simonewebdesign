---
layout: post
title: The Dawn of the URL Apps
description: !!!ADD SOMETHING HERE FOR SEO!!!! Also dont forget to update date in file name.
date: 2020-12-12
published: false
categories: JavaScript
---

Subtitles:
- how to build a ...
- how I built a color scheme picker that
- how I built an app that is database-free, self-hosted, and can be shared

This article talks about these two techniques fused together:

- data:text/html,htmlfollowshere (/how-to-make-browser-editor-with-html5-contenteditable/)
- https://www.bryanbraun.com/2019/12/07/using-the-url-to-build-database-free-web-apps/ contains its own state

The main point is shareability.

Caveats:
- **cant have comments in javascript**. Like, not at all. Any kind of `//` at any point will essentially comment out the rest of your app.
- **semicolons matter**. blah
- **Can't use a # (hash)**. because blah. _but_ you can get around this by using the ASCII urlencoded version: `%23`. This works also for CSS, so you can even style an element by ID using a selector such as `%23` followed by the ID.
- **syntax errors don't get reported**. meh. Uncaught SyntaxError: unexpected token: identifier. This is NOT true. But it's definitely hard to debug.
- **it is not a valid URL**. the [URL spec](https://url.spec.whatwg.org/) is very clear. This is a major downside, as it reduces the shareability potential on social networks such as Twitter, that constrains the number of characters you can enter. Even without such constraints, it wouldn't be seen as a link. Sure, you can just paste it as plain text elsewhere and ask to copy and paste it in the browser, but that's not very cool.