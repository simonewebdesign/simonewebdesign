---
title: Fuzzy matching with CSS3
author: Simone Vittori
layout: post
permalink: /blog/fuzzy-matching-with-css3/
dsq_thread_id:
  - 951692722
categories:
  - CSS
tags:
  - css3
  - tricks
  - web design
---
<div id="jbID-195" class="jbPost">
  <p>
    There are special cases where a simple <abbr title="Cascading Style Sheets">CSS</abbr> selector is not enough. Like yesterday, when I wanted to match all the uploaded images in my blog, regardless of the container and the content.<br /><br />Let&#8217;s see an example markup:
  </p>
  
  <pre>&lt;p>
  &lt;a href="/blog/wp-content/uploads/2012/11/cat-eat.gif">
    &lt;img src="/blog/wp-content/uploads/2012/11/cat-eat-300x225.gif" 
         alt="" title="Cat Eat" width="300" height="225"
         class="alignnone size-medium wp-image-361" />
  &lt;/a>
  &lt;a href="/blog/wp-content/uploads/2012/11/cat-help.jpg">
    &lt;img src="/blog/wp-content/uploads/2012/11/cat-help.jpg" 
         alt="" title="Cat Help" width="500" height="457"
         class="aligncenter size-full wp-image-367" />
  &lt;/a>
&lt;/p></pre>
  
  <h3>
    How do we match only the images?
  </h3>
  
  <p>
    Well, there are many solutions. The simplest is certainly to use the <code>img</code> selector; but this way we&#8217;d match <em>all</em> the images, which isn&#8217;t our goal. We just want to match the <em>uploaded</em> ones.<p>
      <p>
        Let&#8217;s examine the markup above. See, WordPress uses some classes in order to apply the correct size or alignment, and finally applies a <em>unique</em> class with a progressive number (<code>wp-image-*</code>), just in case we want to match a single element. So we could do this:
      </p>
      
      <pre>.wp-image-361,
.wp-image-367 {
  /* some fancy <abbr title="Cascading Style Sheets">CSS</abbr> code here */  
}</pre>
      
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
        The official <a href="http://www.w3.org/TR/css3-selectors/" title="W3C Selectors Level 3 specification" target="_blank" rel="nofollow"><abbr title="World Wide Web Consortium">W3C</abbr> Selectors Level 3 specification</a> offers a freaky <a href="http://www.w3.org/TR/css3-selectors/#selectors" title="CSS3 Selectors" target="_blank" rel="nofollow nofollow">set of selectors</a>, for the joy of the craziest web designers!
      </p>
      
      <p>
        In our specific case, this would do the trick:
      </p>
      
      <pre>img[class^="wp-image-"] { 
  /* matches an img element whose "class" attribute value begins exactly with the string "wp-image-" */
}</pre>
      
      <p>
        Note that I&#8217;m talking about CSS3, so if you need to support older browsers, don&#8217;t lean on it.
      </p>
      
      <h3>
        Cool. What else?
      </h3>
      
      <p>
        The <a href="http://www.w3.org/TR/css3-selectors/#selectors" title="CSS3 Selectors" target="_blank" rel="nofollow nofollow">table of selectors</a> presents a whole bunch of possibilities, even though the usefulness isn&#8217;t always evident. But I&#8217;m sure you can find an example for every selector listed there. So, whether you are a <abbr title="Cascading Style Sheets">CSS</abbr> wizard or not, my final advice is: <strong>go create cool stuff</strong>, because practice makes perfect.
      </p></div>