---
layout: post
title: Achieving Vertical Rhythm
categories: CSS
comments: yes
published: no
---

I was probably just randomly browsing the web when I stumbled across [wicky.nillia.ms](https://wicky.nillia.ms/).

![](wickynilliams.webp)

I liked the simple design, very neat. However, my attention was immediately drawn to the top right corner. What's that "baseline" thing? Obviously I click it and I get rewarded with a grid, which reveals that the design is perfectly balanced: the vertical spacing between the title, the subtitle and the paragraph just feels right. "How was this achieved?", I wondered.

I went down the rabbit hole and discovered this Smashing Magazine article from 2012, titled [CSS Baseline: The Good, The Bad And The Ugly](https://www.smashingmagazine.com/2012/12/css-baseline-the-good-the-bad-and-the-ugly/). A great article that goes deep into the theory of "pattern recognition" (the *why*), and some of the challenges you might face while trying to get your web design vertically aligned.

The article is definitely worth a read, but here I'll share my approach to achieving what feels like a solid baseline, and hopefully inspire you to make your websites perfectly balanced as well—it's easier than you think.

Let's dive in.

*[insert Thanos's "perfectly balanced" meme here :]*

## [Perfectly Aligned Typography](#perfectly-aligned-typography)

Magic things happen when you apply rules and constraints.

### What's a *baseline*?

A *baseline* is really a typography concept:

> **baseline** _/bās′līn″/_
> <br><small>noun</small><br>
> The line upon which most letters "sit" and below which descenders extend.
> <br><cite>—**Baseline** on Wikipedia (disambiguation page)</cite>

If that went over your head, you're not alone. However, you don't need to understand typography to understand the concept of baseline.

<figure>
    <img src="/images/svg/baseline.svg" alt="" width="100%">
    <figcaption>A diagram showing terms to do with letter height and positioning on the baseline. Alternative terms are italicised.</figcaption>
</figure>

Try this out:

<div class="text-center" style="display: flex; width: 10rem; justify-content: space-between; margin: 2rem auto">
    <input type="checkbox" id="toggle-lines" style="transform:scale(3); margin:0 1rem; text-align: center" /><label for="toggle-lines" style="font-weight: bold; vertical-align: middle">Show baseline</label>
</div>
<noscript>This feature needs JavaScript. Please enable JavaScript in your browser.</noscript>
<script>
    var toggle = document.getElementById('toggle-lines')
    var label = document.querySelector('[for="toggle-lines"]')
    toggle.checked = false
    toggle.addEventListener('click', function () {
        document.body.classList.toggle('baseline')
        label.innerText = document.body.classList.contains('baseline') ? 'Hide baseline' : 'Show baseline'
    })
</script>

With baseline enabled, you should see the baseline. Press and hold anywhere to hide it temporarily.

Baseline Perfect
Vertical Rhythm Perfect
Perfectly Aligned Typography
Achieving Vertical Rhythm in Pure CSS

Magic things happen when you apply rules and constraints.
You don't even need that many. Less is more.
You may have noticed

https://wicky.nillia.ms/
https://www.smashingmagazine.com/2012/12/css-baseline-the-good-the-bad-and-the-ugly/
https://pxtorem.w3schools.in/
https://webkit.org/blog/16831/line-height-units/

1.8px 0.1rem
2.2px 0.1222rem
3.3px 0.1833rem (1/10 of the baseline)
4.125px 0.22916rem (1/8 of the baseline)
4.4px 0.2rem
5.5px 0.25rem (a sixth of the baseline)
6.6px 0.3rem (a fifth of the baseline)
8.25px  0.375rem (a quarter of the baseline)
11px  0.5rem (a third of the baseline)
12px 0.6666rem
13px  0.7222rem
14px  0.7777rem
15px  0.8333rem
16.5px  0.75rem (half of the baseline)
18.8571428571px 0.8571428571409091rem (4/7 of the baseline)
19.8px  0.9rem (3/5 of the baseline)
20.625px  0.9375rem (5/8 of the baseline)
22px  1rem (two thirds of the baseline)
23px  1.0454rem
24px  1.0909rem
24.75px 1.125rem (three quarters of the baseline)
25px  1.1364rem
26px  1.1818rem
27px  1.2273rem
27.5px  1.25rem (5/6 of the baseline)
28px  1.2728rem
29px  1.3182rem
30px  1.3637rem
31px  1.4091rem
32px  1.4545rem
33px  1.5rem (the baseline)
36px  1.6363rem
41.25px 1.875rem (5/4 of the baseline)
44px  2rem (4/3 of the baseline)
49.5px 2.75rem (3/2 of the baseline)
66px  3rem (twice the baseline)



for some reason, 1rem = actually 33px, same as the baseline. I think it's because of line-height: 1.5; but I think this is only true in the context of font size.


22 : 1.5 = 19.8 : x

x = 1.5*19.8/22


Quotes from https://anthonyhobday.com/sideprojects/saferules/

Everything should be aligned with something else

Alignment helps us realise that things are related to each other. If something is not aligned with anything else, it feels like it does not belong in the design. Ideally each element should be aligned with other elements based on some kind of logic.

Measurements should be mathematically related

The spacing you use between elements, and the size of elements, should be determined by some kind of scale. This will help the design to look coherent. In the example below, every element uses multiples of 8. Horizontal and vertical grids based on a scale help if you want to make sure elements like pictures are the right size.
