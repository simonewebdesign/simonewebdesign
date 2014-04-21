---
title: How to remove an element from an array
layout: post
permalink: /blog/how-to-remove-element-from-array/
date: 2013-08-30
dsq_thread_id:
- 1672169047
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

<h2>
  tl;dr version:
</h2>

<pre>myArray.splice(3, 1);</pre>

<p>
  The function above will remove the element at index <code>3</code>. <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/splice" title="Go to MDN" target="_blank">See docs</a>.
</p>

<hr />

<h2>
  Detailed version:
</h2>

<p>
  Let&#8217;s say we have a simple array of strings, like this one:
</p>

<pre>
var a = ['foo', 'bar', 'baz'];
</pre>

<p>
  We just want to remove that <code>'bar'</code> element. How can we do this?
</p>

<p>
  For the <a href="http://en.wikipedia.org/wiki/Principle_of_least_astonishment" title="Go to Wikipedia" target="_blank" rel="nofollow">principle of least surprise</a>, you could expect <code>Array</code> to have a <code>remove</code> function:
</p>

<pre>a.remove('bar');
>>> ['foo', 'baz']
</pre>

<p>
  The bad news? <strong>JavaScript does not have such a function.</strong>
</p>

<p>
  The good news? <strong>We can create it!</strong>
</p>

<p>
  But, first of all, let&#8217;s see how this is done in the <strong>standard way:</strong>
</p>

<pre>
a.splice(1, 1);
>>> ['bar']
a
>>> ['foo', 'baz']
</pre>

<p>
  What does this <code>splice</code> function do? Simple: it just removes the element at index <code>1</code>. The first parameter is, indeed, the index, and the second is the number of elements to remove, starting from that index. This is all you need to know about <code>splice</code>. If you&#8217;re curious to see what other cool things <code>splice</code> can do, see the <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/splice" target="_blank">MDN documentation</a>.
</p>

<h4>
  But what if I don&#8217;t know the index?
</h4>

<p>
  Oh well, you can get it. Just use <code>&lt;a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/indexOf" target="_blank">indexOf&lt;/a></code>, this way:
</p>

<pre>
a.indexOf('bar');
>>> 1
</pre>

<p>
  <small>Please note that Internet Explorer 8 and below versions doesn&#8217;t support it (you can use a <a href="https://gist.github.com/atk/1034425" target="_blank" title="An indexOf polyfill on GitHub" rel="nofollow">polyfill</a>, though).</small>
</p>

<hr />

<h3>
  Extending the Array object
</h3>

<p>
  This is the function I finally came up with.
</p>

<pre>
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
</pre>

<p>
  I know some folks out there doesn&#8217;t feel comfortable with extending <code>Array</code>, because they say Bad Things&trade; could happen. However, I think that a <code>remove</code> function is just a lot more easy to use and remember than <code>splice</code>, and honestly I don&#8217;t see any drawbacks with this approach; especially if we protect the global <code>Array</code> object, somehow. What do you think?
</p>

<p>
  <strong>Full example</strong> (from the browser&#8217;s console, as usual):
</p>

<pre>
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
</pre>

<h4>
  Awesome! But&#8230; why can&#8217;t I just use the <code>delete</code> keyword?
</h4>

<p>
  Oh, so you&#8217;ve heard of that magical JavaScript keyword too, isn&#8217;t it? You can do cool things with it, like:
</p>

<pre>
var a = ['foo', 'bar'];
delete a[1];
</pre>

<p>
  And it will Just Work&trade;. By the way it has a flaw: it <em>doesn&#8217;t</em> simply remove that element from the array, but it actually <em>replaces</em> it with <code>undefined</code>. Example:
</p>

<pre>
var a = ['foo', 'bar', 'baz'];
>>> undefined
delete a[1];
>>> true
a
>>> ["foo", undefined, "baz"]
</pre>

<p>
  Leaving place for undesirable things, like:
</p>

<pre>
a.length
>>> 3   // it should be 2!
</pre>

<p>
  In conclusion, if you don&#8217;t care about the drawbacks, you can use the <code>delete</code> keyword; otherwise go with the solution explained above.
</p>
