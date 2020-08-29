---
layout: post
title: Recursive Reduce in JavaScript and Clojure
date: 2016-07-26 13:00:00 +0000
comments: true
categories:
  - JavaScript
  - Clojure
---

Another fun kata:

> Given an array of arbitrarily nested objects, return a flat array with all the objects marked as "good".

The definition above is quite generic, so I'll provide examples to show
exactly what I mean.

The array in JavaScript looks like this:

``` javascript
var items = [{
    id: 1,
    good: true
}, {
    id: 2,
    children: [{
        id: 3,
        good: true
    }, {
        id: 4,
        good: true
    }, {
        id: 5,
        children: [{
                id: 6,
                good: true
            }
            ...
        ]
    }, {
        id: 9,
        children: [...]
    }, ...]
}, ...]
```

We want the IDs of the good ones.

You might have noticed not all objects are "good". Number 2 for example
is not good. So the result in this case should be:

``` javascript
[1, 3, 4, 6]
```

The only thing to notice here is that **you know it's not good because
it's not marked as such.** In other words, when some object is "bad",
there's no `good: false` nor `bad: true` that tells you that.

So how do we solve this challenge?

Since there's an arbitrary nesting depth, we can once again leverage the
power and simplicity of recursion.

## Solution in JavaScript

I've created the function `goodOnes(items)` that takes the input and
returns what we expect. I'm also using [Ramda.js](https://github.com/ramda/ramda), just because I wanted a clean functional solution and I didn't want to mess around
object mutation.

Here it is:

``` javascript
function goodOnes(items) {
    return R.reduce(theGoodOne, [], items);

    function theGoodOne(acc, item) {
        if (item.good) {
            return acc.concat(item.id);
        } else if (item.children && item.children.length > 0) {
            return R.reduce(theGoodOne, acc, item.children);
        }
        return acc;
    }
}
```

As a side note, you don't really have to use Ramda.js.
`Array.prototype.reduce` does the same, although in a less elegant way.

### Explanation

What this function does is basically just **collecting values**. The
starting point is an empty array, you can see that as the second
argument in the first line. `theGoodOne` is another function (a closure,
to be specific) that is implicitly taking two arguments: `acc` (the
*accumulator*, the empty array) and `item` (the current item in the loop).

If the item is good, we return a **new array** with the item's ID.
Otherwise, we return the accumulator. However, if the item happens to
have some children, we start over doing the same thing (i.e. looping
over its children), also keeping track of the accumulator we already
have this time. It might be still empty, but we don't care yet. We just
return it at the very end.

Now, you might have noticed a bug: what happens if the item is good, but also
has children? ... Yes, that item will be discarded! I did it on purpose
by the way. When I made this function, the original array of items never
had any good item *with* children. Only good items, or items with children.
The algorithm is reflecting this, so it's technically not a bug.

If you're curious about what's the original intent behind this function, it is to
collect values from an **infinitely nestable architecture of UI components**.
There are *text* components, *number* components, *datepickers* etc...
those are all part of a category called *fields*. There are also
*wrappers*, that could be for example a *fieldset* or a *grid*. Wrappers can
contain fields, but also other wrappers.

So what if you have such data structure with so many components and all
you need is just an array of fields? Simple, just **reduce recursively**
on it! ;)

More in general, you can use the **recursive reduce** whenever you have
a nested data structure (such as an array of arrays) and you want to get something out of it.


## Solution in Clojure

This **recursive solution** follows the same logic as the JavaScript
one, but somehow it feels superior. It could probably be rewritten in a
more elegant way I guess, but I'm not very experienced with Clojure so
here we go:

``` clojure
(defn good-one [acc item]
  (if (item :good)
    (conj acc (item :id))
    (if (seq (item :children))
      (reduce good-one acc (item :children))
      acc)))

(defn good-ones [collection]
  (reduce good-one [] collection))
```

## Demo & Download

Everything is on GitHub if you want to fiddle around -- just follow the instructions to get the demos up and running on your computer.

- JavaScript [GitHub source](https://github.com/simonewebdesign/es2015-recursive-reduce/blob/master/main.js) - [Readme instructions](https://github.com/simonewebdesign/es2015-recursive-reduce#readme)
- Clojure [GitHub source](https://github.com/simonewebdesign/clojure-recursive-reduce/blob/master/test/clojure_recursive_reduce/core_test.clj) - [Readme instructions](https://github.com/simonewebdesign/clojure-recursive-reduce#readme)
