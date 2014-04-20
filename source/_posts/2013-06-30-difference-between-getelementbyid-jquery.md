---
title: The difference between document.getElementById() and jQuery()
author: Simone Vittori
layout: post
permalink: /blog/difference-between-getelementbyid-jquery/
dsq_thread_id:
  - 1452080730
categories:
  - JavaScript
tags:
  - DOM
  - getElementById
  - jQuery
---
<div id="jbID-850" class="jbPost">
  <p>
    Assuming we have a super simple markup like this:
  </p>
  
  <pre>&lt;div id="foo">&lt;/div></pre>
  
  <p>
    We just want to get the reference to the element. In classic JavaScript (<a href="http://vanilla-js.com/" title="vanilla JS" target="_blank">vanilla <abbr title="JavaScript">JS</abbr></a>) we used to do:
  </p>
  
  <pre>var foo = document.getElementById('foo');</pre>
  
  <p>
    And now, in the era of modern web development, we simply do:
  </p>
  
  <pre>var foo = $('#foo');</pre>
  
  <p>
    They&#8217;re equivalent, but they&#8217;re not identical. So what&#8217;s the actual <strong>difference</strong> between the two?
  </p>
  
  <p>
    Well, let&#8217;s be honest: there&#8217;s not just one difference. These two <strong>functions</strong> will return a completely different <strong>object</strong>, so you can&#8217;t simply replace every <a href="https://developer.mozilla.org/en-US/docs/Web/API/document.getElementById" title="getElementById() documentation" target="_blank" rel="nofollow"><code>getElementById()</code></a> with <a href="http://api.jquery.com/jquery/" title="jQuery() documentation" target="_blank" rel="nofollow"><code>$('#foo')</code></a>. This will <em>break</em> your code.
  </p>
  
  <p>
    <strong>The main difference is that the jQuery object is just a wrapper around the element.</strong>
  </p>
  
  <p>
    Let&#8217;s see this difference a bit more in detail. Here we play with the console:
  </p>
  
  <pre>document.getElementById('foo')
>>> div#foo
$('#foo')
>>> [div#foo, 
     context: document, 
     selector: "#foo", 
     jquery: "1.10.1", 
     constructor: function,
     init: function …]</pre>
  
  <p>
    As we can see, in the first case we got the tag itself (that is, strictly speaking, an <code>HTMLDivElement</code> object). In the latter we actually don&#8217;t have a plain object, but an array of objects&#8230; including the div we want! In fact, if you call:
  </p>
  
  <pre>$('#foo')[0]
>>> div#foo</pre>
  
  <p>
    You get the right div and nothing more, just as you would if you were calling <code>document.getElementById('foo')</code>.
  </p>
</div>