---
title: How to load jQuery plugins with RequireJS
layout: post
permalink: /how-to-load-jquery-plugins-with-requirejs/
date: 2013-09-07
categories:
  - JavaScript
tags:
  - dependencies
  - dependency
  - include
  - jQuery
  - libraries
  - library
  - load
  - loader
  - loading
  - module
  - modules
  - plugins
  - require
  - requirejs
article_cta: false
---

<p>
  <a href="https://requirejs.org/" title="Go to the official website" rel="external">RequireJS</a> is a useful <strong>script loader library</strong>. Even if your site/app isn&#8217;t super big, it&#8217;s usually a good idea to use RequireJS: it makes your code <em>maintainable</em>.
</p>

<h3>
  The problem
</h3>

<p>
  Often we need to <strong>include external plugins that depend on <a href="https://jquery.com/" title="Go to jQuery site" rel="external">jQuery</a></strong>. Those plugins usually do expect to find a global jQuery (<code>$</code>) object, and then they just <em>extend</em> it.
</p>

<p>
  Of course not <em>all</em> plugins behave like that, but <em>most</em> of them do, and we must deal with it.
</p>

<p>
  By the way, loading jQuery as a global variable is <em>not</em> really a good idea. Okay, you have <a href="http://stackoverflow.com/a/2866920/801544" rel="external">namespaces</a>, <a href="http://api.jquery.com/jQuery.noConflict/" rel="external">$.noConflict()</a> and <a href="http://benalman.com/news/2010/11/immediately-invoked-function-expression/" rel="external">IIFEs</a> and whatever but &#8211; hey come on, do you really think you <em>need</em> all this stuff? We can do it better.
</p>

<h3>
  The solution
</h3>

<p>
  <a href="https://requirejs.org/docs/jquery.html" title="How to use RequireJS with jQuery" rel="external">Use RequireJS with jQuery</a> to manage dependencies. More specifically, you can use the <a href="https://requirejs.org/docs/api.html#config-shim" rel="external">shim config</a> to <strong>specify dependencies for jQuery plugins</strong> that are not <a href="https://requirejs.org/docs/whyamd.html" title="Why AMD?" rel="external">AMD modules</a>.
</p>

<p>
  Let&#8217;s suppose you need to include 2 jQuery plugins, <code>foo.js</code> and <code>bar.js</code>. Here&#8217;s a sample configuration:
</p>

``` javascript
requirejs.config({
  shim: {
      foo: {
          deps: ['jquery'],
          exports: 'Foo'
      },
      bar: {
          deps: ['jquery']
      }
  }
});
```

<p>
  Then, later, when you need to use that <code>Foo</code> plugin, you can just <strong>define a module</strong> by doing:
</p>

``` javascript
// foo.js
// This defines a module named 'foo'
define(function() {

  var Foo = function() {
      this.bar = 'baz';
  }
  return Foo;
});
```

<p>
  And <strong>require</strong> it when you actually want to execute it:
</p>

``` javascript
require(['foo'], function(Foo) {
  // this is a callback function, and it's optional.
  // the foo module has already been required and executed.
  // Foo and $ are now loaded.
});
```

<p>
  Yeah, it&#8217;s that simple.
</p>

<p>
  Want to see a <strong>working example</strong>? Check out the <a href="https://github.com/requirejs/example-jquery-shim" title="Go to GitHub" rel="external">official one</a>.
</p>
