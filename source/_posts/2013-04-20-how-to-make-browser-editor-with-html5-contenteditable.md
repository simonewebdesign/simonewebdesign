---
title: 'How to make a real-time in-browser editor with the HTML5&#8242;s contenteditable attribute'
layout: post
permalink: /how-to-make-browser-editor-with-html5-contenteditable/
date: 2013-04-20
comments: true
dsq_thread_id:
  - 1223908930
categories:
  - JavaScript
tags:
  - attribute
  - comment
  - contenteditable
  - css3
  - editor
  - html5
  - in-browser
  - real-time
---

<p>
  Lots of fun here. Some days ago I just read <a href="http://html5doctor.com/the-contenteditable-attribute/#comment-21228" target="_blank" rel="nofollow">a very cool comment</a> on <a href="http://html5doctor.com/" target="_blank" rel="nofollow">html5doctor</a>:
</p>

<blockquote>
  <p>
    Here is a fun example with the contenteditable attribute.
  </p>

  <p>
    Just paste this data-url to your browser and then edit the title or the style of the whole page
  </p>

  <p>
    <code>data:text/html,&lt;title contenteditable&gt;Hello World&lt;/title&gt; &lt;style contenteditable&gt;head, title, style {display: block;}&lt;/style&gt;</code>
  </p>

  <p>
    Another thing is that you can create a notepad with just one short url:
  </p>

  <p>
    <code>data:text/html,&lt;html contenteditable&gt;&lt;/html&gt;</code>
  </p>

  <p>
    Pretty cool I think.
  </p>
</blockquote>

<p>
  <img src="/images/cat2.jpg" alt="Cat with eyes shining bright" width="200" height="200" class="basic-alignment right" /></a> This just made my eyes shine brighter than ever. I think there&#8217;s <em>a lot</em> of potential here: do you imagine how many things you could realize with the <code>contenteditable</code> attribute?
</p>

<p>
  For example, you can even do this:
</p>

``` css
script {
  display: block;
}
```

<p>
  The result? A JavaScript in-browser editor.
</p>

<hr />

<h2>
  Can I <em>really</em> build an HTML5 editor in my browser?
</h2>

<p>
  <em>Absolutely</em>. This tutorial is focused on how to build a simple but powerful editor, directly within your browser, making it possible to edit your page content in real time. It may sound like a lot of work, but don&#8217;t worry: actually it&#8217;s easier than it seems, for two main reasons:
</p>

<ol>
  <li>
    <strong>The browser already shows content in real time.</strong> When you open Firebug on Firefox, Chrome DevTools, Opera Dragonfly, or whatever, and you edit the <abbr title="Cascading Style Sheets">CSS</abbr> or <abbr title="JavaScript">JS</abbr>, the browser automatically re-renders its window.
  </li>
  <li>
    <strong>You don&#8217;t need any parser.</strong> Again, and unsurprisingly, the browser is already capable to interpret your code.
  </li>
</ol>

<p>
  In fewer words, this means you already have the tools. Just use your imagination to build something awesome.
</p>

<p>
  In this tutorial I won&#8217;t talk about everything, but only of the problems I&#8217;ve encountered while building an editor, and how to solve them.
</p>

<h3>
  Displaying the <code>&lt;script></code> and <code>&lt;style></code> tags
</h3>

<p>
  This is actually very simple. You only need to match them by <abbr title="Cascading Style Sheets">CSS</abbr>, and apply <code>display: block</code> to them. For example:
</p>

``` css
style, script {
  display: block;
}
```

<p>
  However I&#8217;d recommend to apply this rule only to the elements that have the <code>contenteditable</code> attribute. You can do this with:
</p>

``` css
[contenteditable] {
  /* will match all elements with contenteditable attribute */
  display: block;
}
```

<h3>
  How to make it look like <em>real</em> code
</h3>

<p>
  Real editors use monospace fonts. We can also make <code>&lt;script></code> and <code>&lt;style></code> behave like the <code>&lt;pre></code> tag. All we need is the following code.
</p>

``` css
style, script {
font-family: monospace;  /* monospace font */
white-space: pre;        /* behave like &lt;pre> */
}
```

<p>
  You can even install a syntax highlighter like the <a href="https://code.google.com/p/google-code-prettify/" target="_blank" rel="nofollow">Google code prettify</a>, if you want.
</p>

<h3>
  Make the page title editable
</h3>

<p>
  This one is real fun. It&#8217;s ridicolously easy to show the title directly in the browser, but pay attention because the <code>&lt;title></code> tag is inside <code>&lt;head></code>, that is hidden by default! So you must display the title <em>and</em> the head, as a block:
</p>

``` css
head, title {
  display: block;
}
```

<p>
  Then just make it <code>contenteditable</code> and you&#8217;re done.
</p>

``` html
<title contenteditable>The page title</title>
```

<h3>
  Executing the JavaScript in real time
</h3>

<p>
  Now the tricky part. Your scripts actually get executed only the first time, on page load. So the question is, <strong>how can we re-execute the JavaScript every time it changes?</strong>
</p>

<p>
  Well, I&#8217;m sure there are many solutions. Mine is quite straightforward: I dynamically create a new <code>&lt;script></code> element every time the user adds something new. For the sake of simplicity I&#8217;ve created this function:
</p>

``` javascript
function executeCode() {
  var script = document.createElement("script");
  script.innerHTML = js.innerHTML;
  js.parentNode.insertBefore(script, js);
}
// the code we want to execute is contained here:
var js = document.getElementById('js');
```

<p>
  Why I&#8217;ve put the <code>js</code> variable outside of the function? You&#8217;ll find it out soon.
</p>

<p>
  We need to call the <code>executeCode()</code> function during an event in order make it work properly. I think the <code>onkeyup</code> event will be perfect in this situation: it gets fired as soon as the user has finished typing.
</p>

``` javascript
js.onkeyup = function(event) {
  executeCode();
};
```

<p>
  However, this approach has a flaw. What if I type, say, <code>alert('foobar')</code>? I won&#8217;t see an alert, but&#8230; 15 alerts! This because the <code>onkeyup</code> event would get fired 15 times in this case — one for each character. How can we solve this problem?
</p>

<p>
  Again, there can be many solutions. I chose to use <a href="https://developer.mozilla.org/en-US/docs/DOM/window.setTimeout" target="_blank" rel="nofollow"><code>window.setTimeout()</code></a>. My implementation is fairly simple: I just tell the browser to wait 2000 milliseconds (2 seconds) before executing the new code, <em>but if</em> the user modifies the code in the meanwhile, <strong> I reset the timer</strong>. This is the key to prevent the code getting executed more than once.
</p>

<p>
  Here&#8217;s a full example, feel free to copy-paste and <strong>try it directly in your browser</strong>:
</p>

``` javascript
<h1>Sample JavaScript real-time in-browser execution</h1>

<script id="js" style="display: block" contenteditable>
alert('foo'); // edit me!
</script>

<script>
(function() {

  var timer,
      js = document.getElementById('js'),
      delay = 2000;

  js.onkeyup = function(event) {

    if (typeof timer != "undefined") {

      clearTimeout(timer);
      timer = 0;
    }

    timer = setTimeout(executeCode, delay);
  };

 function executeCode() {
    var script = document.createElement("script");
    script.innerHTML = js.innerHTML;
    js.parentNode.insertBefore(script, js);
 }

})();
</script>
```

<hr />

<h2>
  It&#8217;s your turn now!
</h2>

<p>
  I just demonstrated that it&#8217;s definitely possible to build an <strong>HTML5 editor</strong> that works directly in your browser. Imagine a full-featured <abbr title="What You See Is What You Get">WYSIWYG</abbr> in-browser editor: it could potentially <strong>improve your productivity</strong>, enabling <strong>real-time collaboration</strong> and a lot more. Your only limit is your imagination.
</p>

<h3>
  Need inspiration?
</h3>

<a href="/demo/html5editor/" target="_blank">Demo</a> |
<a href="https://github.com/simonewebdesign/html5editor/archive/master.zip" target="_blank" rel="nofollow">Download</a>
