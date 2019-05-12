---
layout: post
title: Pure CSS onclick context menu
date: 2018-02-21
comments: true
categories:
  - javascript
  - css
  - html
published: false
---

If you need a **simple dropdown menu** that:

- Can be triggered with a click/tap on any element
- Is fully cross-browser
- Has no dependencies
- Look ma, no JavaScript!

Then look no further. It's much simpler than you think!

# Demo

We want to **display a context menu when clicking** on the following image: <figure class="doge-demo" tabindex="-1">
  <img class="doge" src="/images/doge.png" width="300" height="300" alt="doge meme" title="Click me to open the menu..." />
  <figcaption>wow, this image is clickable!</figcaption>
  <nav class="menu">
    <ul>
      <li>
        <button onclick="alert('Button clicked!')">Open Image in New Tab</button>
      </li>
      <li>
        <button onclick="console.log(1)">Save Image As...</button>
      </li>
      <li>
        <button>Copy Image Address</button>
      </li>
    </ul>
  </nav>
</figure>

## Step #1 — The HTML

This is the markup I've used on the demo above:

```html
<figure tabindex="-1">
  <img src="/images/doge.png" />

  <nav class="menu">
    <ul>
      <li>
        <button>Open Image in New Tab</button>
      </li>
      <li>
        <button>Save Image As...</button>
      </li>
      <li>
        <button>Copy Image Address</button>
      </li>
    </ul>
  </nav>
</figure>
```

Pretty simple, isn't it? I've used a `<nav>`, but **you can use any elements you want:** a `<div>` in a `<button>`, for example. The important bit is that **the menu has to be inside the clickable element.** Also don't put a button in a button as that's invalid HTML, though it will still work.

You can attach event listeners to the buttons, e.g. using `onclick` or `document.addEventListener` and they'll work as usual.

## Step #2 — Toggle the menu in CSS

This is **all the CSS** you're going to need:

```css
.menu {
    visibility: hidden;
}

figure:active .menu,
figure:focus .menu {
    visibility: visible;
}
```

Why use `visibility` over `display: none`, you may ask? Simply because you may want to play an animation when showing the menu, and while `visibility` is <a href="https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_animated_properties" rel="external nofollow">animatable</a>, `display` is not.

## Step #3 — Make the element focusable

Here's the trick: **the element has to be focusable!** You can do this by using the <a href="https://developer.mozilla.org/en-US/docs/Web/HTML/Global_attributes/tabindex" rel="external nofollow">`tabindex`</a> HTML attribute. Simply add `tabindex="-1"` to the element that will open the menu on click. **This is the key to get the menu visible.**

Note: if the clickable element is a `<button>` or other <a href="https://developer.mozilla.org/en-US/docs/Web/Guide/HTML/Content_categories#Interactive_content" rel="external nofollow">interactive content</a> (i.e. any focusable element), then you don't even need this!

### How to make the menu appear next to the mouse cursor?

You'll need JavaScript. This did the trick for me:

```javascript
const img = document.querySelector('.doge');
const menu = document.querySelector('.menu');

img.addEventListener('mousedown', function ({ offsetX, offsetY }) {
    menu.style.top = offsetY + 'px';
    menu.style.left = offsetX + 'px';
});
```

It's entirely up to you whether you want to do this. Alternatively you could add `position: absolute` to the menu and **just make it appear below the element you clicked** — no need for JS in this case!

### What about browser support?

It may not work in some very old browsers, so do make sure to test it in the browsers you need to support. <a href="" rel="external nofollow">This MDN page</a> has some info about what happens to the focus of a button when being clicked/tapped on different platforms. I did some tests myself and it seems to work well everywhere, including Android and Safari on iOS 12.

And that's it! I hope you found this useful. If you spot any issues, please do let me know by commenting below!

{% include htmlsnippets/pure-css-onclick-context-menu.html %}
