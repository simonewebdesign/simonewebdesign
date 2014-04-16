---
title: onclick vs addEventListener
author: Simone Vittori
layout: post
permalink: /blog/onclick-vs-addeventlistener/
dsq_thread_id:
  - 1103745801
categories:
  - JavaScript
tags:
  - addEventListener
  - onclick
---
<div id="jbID-278" class="jbPost">
  <p>
    What&#8217;s the difference between these two lines of code?
  </p>
  
  <pre>element.onclick = function() { /* do stuff */ }</pre>
  
  <pre>element.addEventListener('click', function(){ /* do stuff */ }, false);</pre>
  
  <p>
    They apparently do the same thing: listen for the click event and execute a callback function. Nevertheless, they&#8217;re not equivalent. If you ever need to choose between the two, <a href="https://gist.github.com/simonewebdesign/4017724" target="_blank" rel="nofollow">this</a> could help you to figure out which one is the best for you.
  </p>
  
  <p>
    The main difference is that <code>onclick</code> <strong>is just a property</strong>, and like all object properties, if you write on more than once, <strong>it will be overwritten</strong>. With <code>addEventListener()</code> instead, we can simply bind an event handler to the element, and we can call it each time we need it without being worried of any overwritten properties.
  </p>
  
  <p>
    In first place I was tempted to keep using <code>onclick</code>, because it&#8217;s shorter and looks simpler&#8230; and in fact it is. But I don&#8217;t recommend using it anymore. It&#8217;s just like using <strong>inline JavaScript</strong>. Using something like <code>&lt;button onclick="doSomething()"&gt;</code> &#8211; <em>that</em>&#8216;s inline JavaScript &#8211; is highly discouraged nowadays (inline <abbr title="Cascading Style Sheets">CSS</abbr> is discouraged too, but that&#8217;s another topic).
  </p>
  
  <p>
    However, the <code>addEventListener()</code> function, despite it&#8217;s the standard, just <strong>doesn&#8217;t work in old browsers</strong> (Internet Explorer below version 9), and this is another big difference. If you need to support these ancient browsers, you should follow the <code>onclick</code> way. But you could also use <a href="http://jquery.com/" target="_blank" rel="nofollow">jQuery</a> (or one of its <a href="http://www.jscripters.com/popular-jquery-alternatives/" title="Popular jQuery Alternatives" target="_blank" rel="nofollow">alternatives</a>): it basically simplifies your work and reduces the differences between browsers, therefore can save you a lot of time.
  </p>
</div>