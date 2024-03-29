---
title: Fuzzy matching with CSS3
description: "Learn a new awesome CSS3 trick from a special case where a simple CSS selector is not enough."
layout: post
permalink: /fuzzy-matching-with-css3/
date: 2012-11-30 00:56:56 +0000
categories:
  - CSS
tags:
  - css3
  - tricks
  - web design
---

<p>
  There are special cases where a simple <abbr title="Cascading Style Sheets">CSS</abbr> selector is not enough. Like yesterday, when I wanted to match all the uploaded images in my blog, regardless of the container and the content.<br><br>Let&#8217;s see an example markup:
</p>

``` html
<p>
  <a href="/blog/wp-content/uploads/2012/11/cat-eat.gif">
    <img src="/blog/wp-content/uploads/2012/11/cat-eat-300x225.gif"
         alt="" title="Cat Eat" width="300" height="225"
         class="alignnone size-medium wp-image-361" />
  </a>
  <a href="/blog/wp-content/uploads/2012/11/cat-help.jpg">
    <img src="/blog/wp-content/uploads/2012/11/cat-help.jpg"
         alt="" title="Cat Help" width="500" height="457"
         class="aligncenter size-full wp-image-367" />
  </a>
</p>
```

<h3>
  How do we match only the images?
</h3>

<p>
  Well, there are many solutions. The simplest is certainly to use the <code>img</code> selector; but this way we&#8217;d match <em>all</em> the images, which isn&#8217;t our goal. We just want to match the <em>uploaded</em> ones.
</p>

<p>
  Let&#8217;s examine the markup above. See, WordPress uses some classes in order to apply the correct size or alignment, and finally applies a <em>unique</em> class with a progressive number (<code>wp-image-*</code>), just in case we want to match a single element. So we could do this:
</p>

``` css
.wp-image-361,
.wp-image-367 {
  /* some fancy CSS code here */
}
```

<p>
  The solution above works, but it is not handy because &#8211; as you may have guessed &#8211; we should update the selector each time we upload a new image.
</p>

<h3>
  Hey, are we supposed to hard-code all the classes?
</h3>

<p>
  No, absolutely! That&#8217;s an absurd solution. Let&#8217;s explore other options.
</p>

<p>
  The official <a href="http://www.w3.org/TR/css3-selectors/" title="W3C Selectors Level 3 specification" rel="external"><abbr title="World Wide Web Consortium">W3C</abbr> Selectors Level 3 specification</a> offers a freaky <a href="http://www.w3.org/TR/css3-selectors/#selectors" title="CSS3 Selectors" rel="external">set of selectors</a>, for the joy of the craziest web designers!
</p>

<p>
  In our specific case, this would do the trick:
</p>

``` css
img[class^="wp-image-"] {
  /* matches an img element whose "class" attribute value
  begins exactly with the string "wp-image-" */
}
```

<p>
  Note that I&#8217;m talking about CSS3, so if you need to support older browsers, don&#8217;t lean on it.
</p>

<h3>
  Cool. What else?
</h3>

<p>
  The <a href="http://www.w3.org/TR/css3-selectors/#selectors" title="CSS3 Selectors" rel="external">table of selectors</a> presents a whole bunch of possibilities, even though the usefulness isn&#8217;t always evident. But I&#8217;m sure you can find an example for every selector listed there. So, whether you are a <abbr title="Cascading Style Sheets">CSS</abbr> wizard or not, my final advice is: <strong>go create cool stuff</strong>, because practice makes perfect.
</p>
