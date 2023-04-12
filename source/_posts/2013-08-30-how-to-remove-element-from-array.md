---
title: How to remove an element from an array
description: "JavaScript: use Array.splice(). The splice() function removes items from an array, and returns the removed items."
layout: post
permalink: /how-to-remove-element-from-array/
date: 2013-08-30
updated: 2020-10-25
categories:
- JavaScript
tags:
- array
- delete
- element
- extend
- function
- prototype
- remove
- splice
---

## <abbr title="too long; didn't read">tl;dr</abbr>:

``` javascript
const myArray = ['a', 'b', 'c', 'd'];

myArray.splice(3, 1); // ['d']

console.log(myArray); // ['a', 'b', 'c']
```

`myArray.splice(3, 1)` removes the element at index <code>3</code>. <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/splice" title="Go to MDN">See docs</a>.

---

## Explanation:

Let's say we have a simple array of strings, like this one:

``` javascript
var a = ['foo', 'bar', 'baz'];
```

We just want to remove that <code>'bar'</code> element. How can we do this?

For the <a href="https://en.wikipedia.org/wiki/Principle_of_least_astonishment" title="Go to Wikipedia" rel="external">principle of least surprise</a>, you could expect <code>Array</code> to have a <code>remove</code> function:

``` javascript
a.remove('bar');
>>> ['foo', 'baz']
```

The bad news? <strong>JavaScript does not have such a function.</strong>

The good news? <strong>We can create it!</strong>

But, first of all, let's see how this is done in the <strong>standard way:</strong>

``` javascript
a.splice(1, 1);
>>> ['bar']
a
>>> ['foo', 'baz']
```

What does this <code>splice</code> function do? Simple: it just removes the element at index <code>1</code>. The first parameter is, indeed, the index, and the second is the number of elements to remove, starting from that index. This is all you need to know about <code>splice</code>. If you're curious to see what other cool things <code>splice</code> can do, see the <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/splice">MDN documentation</a>.

#### But what if I don't know the index?

Oh well, you can get it. Just use <code><a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/indexOf">indexOf</a></code>, this way:

``` javascript
a.indexOf('bar');
>>> 1
```

<small>Please note that Internet Explorer 8 and below versions don't support it (you can use a <a href="https://gist.github.com/atk/1034425" title="An indexOf polyfill on GitHub" rel="external">polyfill</a>, though).</small>

---

### Extending the Array object

This is the function I finally came up with.

``` javascript
// Removes an element from an array.
// String value: the value to search and remove.
// return: an array with the removed element; false otherwise.
Array.prototype.remove = function(value) {
var idx = this.indexOf(value);
if (idx != -1) {
    return this.splice(idx, 1); // The second parameter is the number of elements to remove.
}
return false;
}
```

I know some folks out there don't feel comfortable with extending <code>Array</code>, because they say Bad Things&trade; could happen. However, I think that a <code>remove</code> function is just a lot more easy to use and remember than <code>splice</code>, and honestly I don't see any drawbacks with this approach; especially if we protect the global <code>Array</code> object, somehow. What do you think?

<strong>Full example</strong> (from the browser's console, as usual):

``` javascript
var myArray = ['foo', 'bar', 'baz'];
>>> undefined
myArray.length
>>> 3
myArray.remove('bar');
>>> ["bar"]
myArray
>>> ["foo", "baz"]
myArray.remove('baz');
>>> ["baz"]
myArray
>>> ["foo"]
myArray.length
>>> 1
myArray.remove('qux');
>>> false
```

#### Awesome! But&#8230; why can't I just use the <code>delete</code> keyword?

Oh, so you've heard of that magical JavaScript keyword too, haven't you? You can do cool things with it, like:

``` javascript
var a = ['foo', 'bar'];
delete a[1];
```

And it will Just Work&trade;. By the way it has a flaw: it <em>doesn't</em> simply remove that element from the array, but it actually <em>replaces</em> it with <code>undefined</code>. Example:

``` javascript
var a = ['foo', 'bar', 'baz'];
>>> undefined
delete a[1];
>>> true
a
>>> ["foo", undefined, "baz"]
```

Leaving place for undesirable things, like:

``` javascript
a.length
>>> 3   // it should be 2!
```

In conclusion, if you don't care about the drawbacks, you can use the <code>delete</code> keyword; otherwise go with the solution explained above.
