---
layout: post
title: How to make an HTML element keyboard focusable
date: 2025-05-13
categories: JavaScript
comments: yes
related: 2019-05-13
---

If you have an HTML element that you want to make interactive, but **only via the keyboard**, there might be a few ways to achieve it, depending on your objective.

## [`tabindex="0"`](#tabindex0)

[Tabindex](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Global_attributes/tabindex) is an HTML attribute that makes HTML elements _tabbable_—as in, focusable by pressing <kbd>Tab</kbd>.

It's primarily intended to enhance accessibility. However, if you find yourself needing to use it, consider whether a more semantic, inherently **interactive element**—like a `<button>` or an `<a>`—might be more appropriate. These elements are **naturally focusable** and better communicate intent to users and assistive technologies.

## [`tabindex="-1"`](#tabindex-1)

This is the other allowed value of `tabindex` (anything other than `0` and `-1` is discouraged), and it's used to make an element focusable, but only programmatically (i.e. via JavaScript).

In practice this makes the element no longer tabbable, but actually it **can still be focused via a mouse click**, in some browsers.

## [`pointer-events: none;`](#pointer-events-none)

This CSS rule will disable any kind of interactivity via _pointers_ (e.g. a mouse click, or a tap on mobile), but will retain the ability to focus the interactive element via the keyboard.

However, it might have unintended consequences: let's say your element has a `title` attribute, which you'd like to display on mouse hover: with `pointer-events: none`, this won't work anymore.

## [How to prevent click focusing via JavaScript](#how-to-prevent-click-focusing-via-javascript)

If you want to focus your element only via JavaScript, and prevent click focusing, one reliable approach is to intercept mouse events (on the element itself):

```js
element.addEventListener('mousedown', event => {
  event.preventDefault()
})
```

This works because preventing the mousedown event stops the browser from giving the element focus when clicked.

You'll then need to focus your element manually, by listening for a key press.

## [Full example](#full-example)

If what you want is an element that can be focused programmatically, but **only via a specific key, and not by a mouse click**, here's a full working example:

```html
<div id="myDiv" tabindex="-1">Focus me</div>

<script>
  const el = document.getElementById('myDiv')

  el.addEventListener('mousedown', e => {
    e.preventDefault() // Prevent focus on click
  })

  // You can still focus it programmatically,
  // for example by listening for a key press
  document.body.addEventListener('keydown', event => {
    if (event.key.toLowerCase() === 'f') { // only true when pressing 'F'
      el.focus()
    }
  })
</script>
```

The example above has a `<div>` that is:

- ❌ Not tabbable;
- ❌ Not clickable;
- ✅ Focusable (via key press).

Feel free to check out [this pen](https://codepen.io/simone/pen/WbbLYEX) for a live example.

---

Hopefully this lets you achieve what you want, but let me know if you're targeting a specific element type or browser; I'll be happy to help.

Happy hacking!
