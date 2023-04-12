---
title: How to create a web bug (aka beacon image)
description: "Tutorial: learn how to build a hidden web bug. To create a beacon image, you need to enable the Apache’s URL rewriting module (mod_rewrite)."
layout: post
permalink: /how-to-create-web-bug-aka-beacon-image/
date: 2012-09-23 15:22:30 +0000
updated: 2020-09-19
categories:
  - PHP
tags:
  - beacon
  - bug
  - htaccess
  - image
  - pixel
  - rewrite
  - tag
  - url
  - web
---

<p>
  Have you ever wondered why some web pages include a 1&#215;1 <abbr title="Graphics Interchange Format">GIF</abbr> image? Well, they&#8217;re called <strong>web bugs</strong>, and they <strong>track you</strong>.
</p>

<p>
  The beacon images (better known as <a href="https://en.wikipedia.org/wiki/Web_bug" title="Web bug on Wikipedia">web bugs</a>) are basically just hidden scripts behind images. They can easily be spotted because they usually don&#8217;t end with a common image format, like <abbr title="Graphics Interchange Format">gif</abbr>, <abbr title="Joint Photographic Experts Group">jpeg</abbr> or <abbr title="Portable Network Graphics">png</abbr>.<br />An example of web beacon could be this:
</p>

``` html
<img src="beacon.php" width="1" height="1" alt="">
```

<p>
  As you can see, the <code>src</code> attribute contains a <abbr title="PHP: Hypertext Preprocessor (recursive acronym)">PHP</abbr> script. It&#8217;s easy to find (and <a href="http://www.ghostery.com/" title="Ghostery" rel="external">block</a>) web bugs when you see that an image is served as <abbr title="PHP: Hypertext Preprocessor (recursive acronym)">PHP</abbr>.
</p>

<p>
  By the way, more generally speaking, if you see that a file ends with <em>.jpg</em> (it&#8217;s an image, you think) or just doesn&#8217;t have an extension (I&#8217;m inside a folder, you think)&#8230; well, <strong>you could be wrong</strong>. I can easily execute a script when an user requests a simple image ending with <em>.jpg</em>, and I&#8217;ll explain you how.
</p>

<p>
  In order to create a <strong>hidden web bug</strong>, you need to enable the Apache&#8217;s <abbr title="Uniform Resource Locator">URL</abbr> rewriting module (mod_rewrite). Create a new <code>.htaccess</code> file and put the following code in it:
</p>

``` apache
RewriteEngine On
RewriteRule ^(.*).(png|jpg|gif)$ script.php
```

<p>
  Now create the <code>script.php</code> file and write some random code:
</p>

``` php
<?php
$fullpath  = $_SERVER['REQUEST_URI'];
$filename  = basename($fullpath);
$ip        = $_SERVER['REMOTE_ADDR'];
$useragent = $_SERVER['HTTP_USER_AGENT'];

echo "Path: $fullpath;<br>
File: $filename;<br>
IP address: $ip;<br>
User agent: $useragent";
```

<p>
  <video width="300" height="208" autoplay loop muted="muted" poster="/images/omg-cat.jpg" class="basic-alignment left">
    <source type="video/mp4" src="/videos/omg-cat.mp4">
  </video>
  And now try to navigate through an image, let&#8217;s say <code>cat.gif</code>. You&#8217;ll go to <em>http://yoursite.com/path/to/cat.gif</em> and you&#8217;ll expect to see a cat. Instead, you&#8217;ll see something like this:
</p>

```yaml
Path: /path/to/cat.gif;
File: cat.gif;
IP address: 127.0.0.1;
User agent: Mozilla/5.0 [...];
```

<p>
  Take a quick look at the <abbr title="Uniform Resource Locator">URL</abbr> in your browser&#8217;s address bar. You requested a <code>cat.gif</code>, but <code>script.php</code> has been executed instead. <strong>Kind of creepy, isn&#8217;t it?</strong> Imagine what else you could do. <strong>You can execute code. Possibilities are infinite.</strong>
</p>
