---
layout: post
title: How to Disable a Link
categories: CSS
comments: yes
---

The HTML language is pretty awesome. It's constantly evolving, just like CSS and JavaScript, and likely has anything you need out of the box.

This time I'll cover a lesser-known HTML attribute, `inert`. It's kind of like `disabled`, but not quite.

If you need to **disable a link**, you might be tempted to do it this way:

```html
<a href="#" disabled>I am a disabled link</a>
```

Or maybe through CSS:

```css
a[disabled] {
  pointer-events: none;
}
```

These are **both wrong**.

Links *do not* have a `disabled` attribute, so it just won't work.

`pointer-events: none` kind of works, if you happen to be using a _pointer_ (a pointer is the mouse cursor, or if you're on mobile, it's where your finger is touching). It _will_ disable the link, however **it won't work for keyboard users**.

Since it's important to **keep all kinds of users and interfaces in consideration** (in other words, **accessibility matters**), the `inert` property was born.

<blockquote>
  <p><strong>inert</strong> is a boolean value that, when present, makes the browser "ignore" user input events for the element, including focus events and events from assistive technologies.</p>
  <footer>
    <cite>
      — <a href="https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/inert" rel="external noopener noreferrer nofollow">HTMLElement: inert property on MDN</a>
    </cite>
  </footer>
</blockquote>

Why is this important? Because simply hiding a link, or even moving it offscreen, **doesn't automatically make it inaccessible to all users**. A screen reader user, for example, would still be able to access it.

## Working example

This is the modern, "right" way:

```html
<a href="http://example.com" inert>I am an inert link</a>
```

Pretty simple, isn't it? Try it here below:

<a href="http://example.com" inert>I am an inert link</a>

## Styling with CSS

The `inert` attribute **comes with no CSS by default**, but of course you're free to style it in any way you like. For example, to make all the disabled links slightly transparent, you could do this:

```css
a[inert] {
  opacity: .5;
}
```

## Browser compatibility

The attribute is widely supported in all major web browsers, since Chrome 102 (released in April 2022).
You can find more information on the [inert](https://developer.mozilla.org/en-US/docs/Web/HTML/Global_attributes/inert) page on mdn.

---

That's it! I hope you've enjoyed reading and found the solution you were looking for. Happy hacking!