---
title: How to install the Google Code Prettify plugin
description: "Learn how to install the Google Code Prettify plugin for your WordPress blog. Plugins are usually quite simple to set up: just follow this simple guide."
layout: post
permalink: /how-to-install-google-code-prettify/
date: 2012-08-27 00:33:16 +0000
updated: 2014-10-28
comments: true
dsq_thread_id:
  - 860649835
tags:
  - code
  - google
  - install
  - plugin
  - prettify
---

<p>
  If you have a WordPress blog and want to add some cool syntax highlighting for your code, you can try <a title="Google Code Prettify" href="https://code.google.com/p/google-code-prettify/">Google Code Prettify</a>.
</p>
<p>
  WordPress plugins are usually quite simple to use, but there are some little precautions to follow. First of all:
</p>

<ul>
  <li>
    <a title="WP code prettify download" href="https://wordpress.org/extend/plugins/wp-code-prettify/">Download the Google Code Prettify plugin for WordPress</a>
  </li>
  <li>
    <a title="Managing Plugins" href="https://codex.wordpress.org/Managing_Plugins#Installing_Plugins">Install it</a>, but DO NOT activate it.
  </li>
</ul>

<p>
  You shouldn&#8217;t activate it immediately, because if you do an edit while your plugin is activated, you could break it: some files could display an <em>(inactive)</em> label next to the file name, and all you can do to repair it is to delete and reinstall the whole plugin. <a title="What the heck does (inactive) mean when editing a plugin file?" href="https://wordpress.org/support/topic/what-the-heck-does-inactive-mean-when-editing-a-plugin-file" rel="external">Read more about this problem</a>.
</p>

<p>
  Once you enabled your plugin, you should wrap <code>&lt;pre class="prettyprint"&gt;</code> for every instance of code you have in all your articles. This can be tremendously annoying if you already have hundreds of articles in your WordPress blog, so I&#8217;ll tell you 5 quick &#8216;n&#8217; straightforward steps to get around this problem.
</p>


1. Edit <strong>google_code_prettify.php</strong> and search for this line:
  ``` php
  return preg_replace_callback("/&lt;pres+.*classs*="prettyprint"&gt;(.*)&lt;/pre&gt;/siU",
  ```

2. Substitute the above line with the line below:
  ``` php
  return preg_replace_callback("/&lt;pre&gt;&lt;code&gt;(.*)&lt;/code&gt;&lt;/pre&gt;/siU",
  ```
3. Open <strong>prettify.js </strong>and search for this line:
  ``` javascript
  if (cs.className && cs.className.indexOf('prettyprint') &gt;= 0) {
  ```

4. Substitute the above line with the line below:
  ``` javascript
  if (true) {
  ```

5. Go edit your <strong>prettify.css</strong> and delete the reference about the <code>.prettyprint</code> class. Then you&#8217;ll want to add some more code to avoid the awful text overflow, that often causes layout problems. Have a look at this short <a title="Make Pre Text Wrap" href="https://css-tricks.com/snippets/css/make-pre-text-wrap/">article from <abbr title="Cascading Style Sheets">CSS</abbr>-Tricks</a>: you <em>need</em> that code. I&#8217;m (shamelessly) copy pasting it below:
  ``` css
  pre {
    white-space: pre-wrap;       /* css-3 */
    white-space: -moz-pre-wrap;  /* Mozilla, since 1999 */
    white-space: -pre-wrap;      /* Opera 4-6 */
    white-space: -o-pre-wrap;    /* Opera 7 */
    word-wrap: break-word;       /* Internet Explorer 5.5+ */
  }
  ```

<p>
  And that&#8217;s all. You can now enable your plugin and see your cute and readable code. ;-)
</p>

<p>
  However, my solution is a bit hackish. I mean, when a new plugin update will be released, you&#8217;ll lose all the edits. If you don&#8217;t want this to happen, don&#8217;t update your plugin. Or if you&#8217;re looking for a separate, cleaner solution, I suggest you read <del><a title="Syntax Highlighting a la StackOverflow with Google Prettify">this article</a></del> (dead link).
</p>
