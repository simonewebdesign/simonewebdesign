---
layout: post
title: How to Link to Headings in Markdown
categories: CSS
comments: yes
---

I use [Jekyll](https://jekyllrb.com/) and I wanted to make all of my headings linkable.

In HTML you can achieve this with a simple [link to an element on the same page](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/a#linking_to_an_element_on_the_same_page), except that the link would be self-referencing — for example:

```html
<h2 id="my-heading">
  <a href="#my-heading">My Heading</a>
</h2>
```

In Markdown, it is equivalent to:

```md
## [My Heading](#my-heading)
```

<!--more-->

This works because [Kramdown](https://jekyllrb.com/docs/configuration/markdown/#kramdown), the default Markdown renderer for Jekyll, automatically adds `id` attributes, using a _slugified_ version of your heading text. So, for example:

```md
### Some text
```

Conveniently gets rendered as:

```html
<h3 id="some-text">Some text</h3>
```

## [Appending a symbol to the heading](#appending-a-symbol-to-the-heading)

Often times I've seen a `#` symbol, or maybe a link symbol (🔗) either at the beginning or at the end of the heading.

Consider this example I found on the web:

```html
<h3 id="example-1">
  Example
  <a aria-hidden="true" href="#example-1" hidden>#</a>
</h3>
```

I think hiding the symbol to assistive tech makes a lot of sense — it is more of a presentational thing, after all. However, decorative things like this don't have to belong to the HTML — they can be defined in CSS, like:

```css
h2::after,
h3::after {
  content: ' #';
}
```

Even better, you can make it appear only on hover, or when there is a link. Ultimately I settled with this for my blog:

```css
h2:hover > a::after,
h3:hover > a::after {
    content: ' #';
}
```

## [Should the entire heading be a link, or just the symbol?](#should-the-entire-heading-be-a-link-or-just-the-symbol)

I'm unsure what's best practice here, but it just seems very convenient to be able to link to any section of a document in general. Ultimately I don't think it matters too much, but MDN makes the whole heading a link, and again, the symbol at the end of it is just presentational and should ideally be hidden for accessibility.

## [A future optimization](#a-future-optimization)

It would be cool to be able to keep writing regular headings - i.e. if `## My Heading` would automatically turn into a link. I think this could be done by configuring Kramdown, or maybe via a plugin. If you find a way to enable this, please let me know in the comments below!
