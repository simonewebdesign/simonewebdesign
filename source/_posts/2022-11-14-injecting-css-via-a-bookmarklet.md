---
layout: post
title: A CSS debugger
description: ##Is it possible to inject CSS in an external browser?
permalink: ##/1req/
date: ##2022-10-09
comments: false
categories:
  - CSS
published: false
---

Do you ever find yourself building layouts in CSS and adding things like borders or background colors to all elements, for better visibility? You're not alone, I've done it many times as well, but there is a better way: you can inject some CSS directly in the browser.

What if I told you
there is a way to inject some CSS directly in the browser?

One way to do it is via a Bookmarklet, which is essentially a browser bookmark that, instead of containing a link, contains some JavaScript that gets executed on click.

Here's an example:

```js
javascript: (function () { var styleEl = document.getElementById('injected-css'); if (styleEl) { styleEl.remove(); return; } styleEl = document.createElement('style'); styleEl.id = 'injected-css'; styleEl.innerHTML = 'body { background-color: green }'; document.body.append(styleEl); })();
```

Save this string as a bookmark and then click on it, and you should see the body's background color turning green.

You can use bookmarklets for

https://github.com/ausi/respimagelint this is a great one