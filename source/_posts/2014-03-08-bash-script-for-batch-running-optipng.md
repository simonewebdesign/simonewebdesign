---
layout: post
title: "Bash script for batch running OptiPNG"
description: "OptiPNG is a PNG optimizer that recompresses image files to a smaller size, without losing any information."
date: 2014-03-08 16:54:15 +0200
comments: true
categories: Bash
---

<h3>Optimize all your images with a single command:</h3>

<pre id="optipng_script">$ find . -name '*.png' | xargs optipng -nc -nb -o7 -full</pre>

<hr>

<h2>What is OptiPNG?</h2>

<p><a href="http://optipng.sourceforge.net/" title="OptiPNG is a PNG optimizer that recompresses image files to a smaller size, without losing any information. This program also converts external formats (BMP, GIF, PNM and TIFF) to optimized PNG, and performs PNG integrity checks and corrections." target="_blank">OptiPNG</a> is a PNG optimizer tool. If you want your website to be faster, you should consider optimizing images.</p>

<p>When I ran the <a href="http://developers.google.com/speed/pagespeed/insights/" title="PageSpeed Insights" target="_blank" rel="nofollow">Google PageSpeed</a> tool towards my website, I got a score of 81/100 for Desktop, 61/100 for Mobile. Pretty low, I thought. So I decided to go through the "Consider Fixing" issues, and the first one was - guess what? - <strong>optimize images</strong>.</p>

<blockquote>Properly formatting and compressing images can save many bytes of data.</blockquote>

<p><img src="/images/optimize-all-the-images.png" alt="OPTIMIZE ALL THE IMAGES!" width="280" height="210" class="basic-alignment left" />The thing I did immediately next was reading the article that Google suggested: it's a nice reading on Google Developers about <a href="https://developers.google.com/speed/docs/insights/OptimizeImages" title="Optimizing images - Google Developers" target="_blank" rel="nofollow">optimizing images</a>. The first recommendation is: <strong>Use an image compressor</strong>. OptiPNG is one of them.</p>

<p>On the OptiPNG site I realized it works only for one image at a time, so I had the need to write a script that runs the optimizer for all images at the same time.</p>

<p>Luckily enough, after a bit of search, I found a blog post titled <a href="http://www.justpowered.de/blog/shellbatch/optimize-all-png-images-recursively.html" title="Optimize all PNG images recursively" target="_blank">Optimize all PNG images recursively</a>, which finally solved my problem. All the credits belong to that blog.</p>

<p>After running <a href="#optipng_script">the script</a> I got a score of 86/100 for Desktop (before was 81), and 68/100 for Mobile (before was 61), <strong>all without loss of quality</strong>. Definitely worth a try!</p>