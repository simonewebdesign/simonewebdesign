---
title: Loop through parameters in Bash
layout: post
permalink: /blog/loop-through-parameters-in-bash/
date: 2013-11-12
comments: true
dsq_thread_id:
  - 1959590963
categories:
  - Bash
tags:
  - arguments
  - bash
  - each
  - input
  - iterate
  - loop
  - over
  - parameters
  - script
  - shell
  - through
---

<p>
  Iterating over the arguments in a Bash script is way simpler than you might expect.<br />See this gist:
</p>

{% gist 5325630 %}

<p>
  In the snippet above, <code>"$@"</code> represents all the parameters. The <code>echo "$i"</code> shall obviously print each argument on a separate line.
</p>

<p>
  It&#8217;s always a good idea to wrap parameters within quotes, because you&#8217;d never know when a parameter might contain spaces or whatever.
</p>
