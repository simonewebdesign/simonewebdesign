---
layout: post
title: "15 CSS Best Practices for Beginners"
date: 2014-10-26 18:36:24 +0000
comments: true
categories: CSS
published: false
---

Talk about maintainability. is the focus.

This guide borrows the principles of SMACSS, which stands for Scalable and Modular Architecture for CSS.



## Code style conventions


### Multiple lines rather than single lines

Favour multiple lines instead of single line CSS rules, unless it’s only one rule or you think it just makes more sense to be inline in a particular context. The reason is that a single line is usually less readable (hence harder to maintain).

By the way, this is opinionated as some people still prefer to use one liners. It can be tempting to use one line instead of 3; however, readability is more important.

ProTip: you can always use your editor of choice to collapse everything you have between the curly brackets, even at different levels of depth, so you can see the big picture.

**Good:**

```css
body {
  background: red;
  color: white;
}
```

**Good:**

```css
body { background: red }
```

**Bad:**

```css
body { background: red; color: white; }
```


### Separate rules consistently

Still regarding spaces, you may want to separate a rule from each other using new lines. As a general good rule, put new lines:

- after each curly bracket;
- after each semi colon.

It's good also to put an additional new line before the start of a new selector; it doesn't change anything, apart from the fact that your CSS will be more readable.

**Good:**

```css
.widget {
  color: green;
  background: white;
}
```

```css
.stuff {
  color: blue;
}
```

**Bad:**

```css
.widget {
color: green } .stuff {
  color: blue;
}
```

The bad example in this case will still work. But it's pretty confusing! So always use spaces properly.


### Don't use IDs as styling hooks

You were told: "Use IDs only for elements that will appear once". That's true, BUT actually I'd say: "Don't use IDs at all". They are quite handy for targeting with JavaScript, but if you use them for styling, at some point you'll probably have a bad time. There's a lot of discussion about this, so I'm not going to add more to the conversation. Let's make an example. This is our current HTML and CSS:

```html
<div id="widget" class="focusable"></div>
```

```css
#widget {
  color: red;
}
```

Now let's say you want all `.focusable` elements to be black. You'll then write this:


```css
.focusable {
  color: black; // this won't work!
}
```

So the only reason you should just use classes, is because of specificity. You can almost completely forget about it if you use classes.


### Choose your style and be consistent

It doesn't really matter whether you use `.camelCase`, `.snake_case` or `.Hyphens-everywhere` for your class names. The important thing is that you choose a style and stick with it. Conventions can be extremely powerful: take advantage of them.


### Modularity

This is probably the most important point: a modular stylesheet is a scalable stylesheet.

We can achieve such modularity with classes that somehow extend their superclass, just as in OOP.

A clear example is Bootstrap’s `.btn` module, which has submodules called `.btn-success`, `.btn-warning` etc.

**Good:**

```css
.btn-default {
  background: red;
}
```

**Bad:**

```css
/* can be harder to find and to maintain */
.btn.default {
  background: red;
}
```

A module can have submodules.

A submodule is supposed to add some functionality to its base module.

You can use a module as a stand-alone class, but this is not true for submodules, as they should be used in conjunction with the base module (not strictly though).

```html
<a href="#" class="btn btn-default">Read more</a>
<a href="#" class="btn btn-checkout">Checkout</a>
```

The key point to understand is that **writing modular code leads to maintainable stylesheets**. By namespacing your CSS classes, it's just as you are writing server-side code organized in different classes.


### Modules/component should go in separate files

Write your CSS in separate files, then concatenate them and serve them in a single file. This way you'll have maintainable pieces of code, and you'll reduce the overhead of serving many files. HTTP requests might be expensive!


### KISS: Keep it simple, short

A selector should never exceed more than 3 class names, or it will become difficult to read and maintain. Use the least number of selectors required to style an element.

**Good:**

```css
.btn-default {
  background: red;
}
```

**Bad:**

```css
#wrapper .container > .row .col-sm-12 button.btn.btn-default {
  background: red;
}
```

### Remember: IDs are unique

While using IDs, you don’t need to have more than one selector, because CSS works from right to left and will immediately match your desired element.

**Good:**

```css
#wrapper {
  background: red;
}
```

**Bad:**

```css
.container div#wrapper {
  background: red;
}
```


### Use `!important` only on classes that represent states

The `!important` clause is usually very bad, but not in states. By states I mean those classes who represent a temporary state. For example: `.active`, `.hidden`, `.is-open`, `.has-warnings`… you get the point.

**Good:**

```css
.is-active {
  display: block !important;
}
```


### Use semantic names

I believe semantics should represent the actual content rather than the behaviour of the CSS. This may bring many benefits, primarily for search engines.

**Good:**

```css
<form class="has-errors">
  Some content
</form>

<article>
  Some other content
</article>
```

**Bad:**

```css
<form class="red-bg">
  Some content
</form>
```

```css
<div class="article">
  Some other content
</div>
```


### Avoid element selectors at all costs

Always namespace your selector, or bad things will happen. For example, you should never add some rules directly to an `<article>` or a `<section>`. Instead, wrap them in a class. They are bad because they will apply to all elements of that type in the page. And they will probably be overwritten by a class, which has higher CSS specificity. Last but not least, class selectors are more performant than element selectors.

**Good:**

```css
article.post {
  color: gray;
}

footer.sticky-footer {
  height: 100%;
}
```

**Bad:**

```css
article {
  color: gray;
}

footer {
  height: 100%;
}
```


### Decouple HTML & CSS

The style and the markup shouldn’t be tightly coupled, because we lose in scalability. For example, consider this HTML and CSS:

```html
<section class="box">
  <p>Choose a product:</p>
  <ul>
    <li>Boiler repair</li>
    <li>Boiler installation</li>
    <li>Boiler maintenance</li>
  </ul>

  <div>Apply now</div>
</section>
```

```css
.box ul {
  list-style: none;
}

.box p {
  font-size: 1.5em;
}

.box div {
  color: green;
}
```

It’s very clean, but unfortunately it’s not scalable. What if we need to wrap the `<ul>` and the `<p>` in a new `<div>`? That `<div>` will be green coloured, which is definitely something we don’t want.

The solution is to use what I call submodules, so the markup will now look like:

```css
<section class="box">
  <div class="box-body">
    <p>Choose a product:</p>
    <ul>
      <li>Boiler repair</li>
      <li>Boiler installation</li>
      <li>Boiler maintenance</li>
    </ul>
  </div>

  <div class="box-apply">Apply now</div>
</section>
```

```css
.box .box-body {
  /* .box-body is a submodule of .box */
}

.box .box-apply {
  /* .box-apply is a submodule too, and it’s scoped to .box */
}

.box .box-body > p {
  /* this is good, since we are targeting a single element that
     is scoped to its module and will never be overridden */
}
```

Another very good example of decoupling HTML from CSS, written by Jonathan Snook (the author of SMACSS) can be found here.

---

I hope you found useful tips in this article. Any questions or comments are welcome!
