---
title: How to load jQuery plugins with RequireJS
layout: post
permalink: /blog/how-to-load-jquery-plugins-with-requirejs/
dsq_thread_id:
  - 1725854798
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
---
<div id="jbID-966" class="jbPost">
  <p>
    <a href="http://requirejs.org/" title="Go to the official website" target="_blank">RequireJS</a> is a useful <strong>script loader library</strong>. Even if your site/app isn&#8217;t super big, it&#8217;s usually a good idea to use RequireJS: it makes your code <em>maintainable</em>.
  </p>
  
  <h3>
    The problem
  </h3>
  
  <p>
    Often we need to <strong>include external plugins that depend on <a href="http://jquery.com/" title="Go to jQuery site" target="_blank">jQuery</a></strong>. Those plugins usually do expect to find a global jQuery (<code>$</code>) object, and then they just <em>extend</em> it.
  </p>
  
  <p>
    Of course not <em>all</em> plugins behave like that, but <em>most</em> of them do, and we must deal with it.
  </p>
  
  <p>
    By the way, loading jQuery as a global variable is <em>not</em> really a good idea. Okay, you have <a href="http://stackoverflow.com/a/2866920/801544" target="_blank" rel="nofollow">namespaces</a>, <a href="http://api.jquery.com/jQuery.noConflict/" target="_blank" rel="nofollow">$.noConflict()</a> and <a href="http://benalman.com/news/2010/11/immediately-invoked-function-expression/" target="_blank">IIFEs</a> and whatever but &#8211; hey come on, do you really think you <em>need</em> all this stuff? We can do it better.
  </p>
  
  <h3>
    The solution
  </h3>
  
  <p>
    <a href="http://requirejs.org/docs/jquery.html" title="How to use RequireJS with jQuery" target="_blank">Use RequireJS with jQuery</a> to manage dependencies. More specifically, you can use the <a href="http://requirejs.org/docs/api.html#config-shim" target="_blank">shim config</a> to <strong>specify dependencies for jQuery plugins</strong> that are not <a href="http://requirejs.org/docs/whyamd.html" target="_blank" title="Why AMD?">AMD modules</a>.
  </p>
  
  <p>
    Let&#8217;s suppose you need to include 2 jQuery plugins, <code>foo.js</code> and <code>bar.js</code>. Here&#8217;s a sample configuration:
  </p>
  
  <pre>
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
});</pre>
  
  <p>
    Then, later, when you need to use that <code>Foo</code> plugin, you can just <strong>define a module</strong> by doing:
  </p>
  
  <pre>
// foo.js
// This defines a module named 'foo'
define(function() {
    
    var Foo = function() {
        this.bar = 'baz';
    }
    return Foo;
});</pre>
  
  <p>
    And <strong>require</strong> it when you actually want to execute it:
  </p>
  
  <pre>
require(['foo'], function(Foo) {
    // this is a callback function, and it's optional.
    // the foo module has already been required and executed.
    // Foo and $ are now loaded.
});</pre>
  
  <p>
    Yeah, it&#8217;s that simple.
  </p>
  
  <p>
    Want to see a <strong>working example</strong>? Check out the <a href="https://github.com/requirejs/example-jquery-shim" title="Go to GitHub" target="_blank">official one</a>.
  </p>
</div>