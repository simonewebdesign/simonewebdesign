---
layout: post
title: Perfectly Aligned Typography
categories: CSS
comments: yes
published: false
---

Baseline Perfect
Vertical Rhythm Perfect
Perfectly Aligned Typography
Achieving Vertical Rhythm in Pure CSS

Magic things happen when you apply rules and constraints.
You don't even need that many. Less is more.
It's easier than you think.
You may have noticed

https://wicky.nillia.ms/
https://www.smashingmagazine.com/2012/12/css-baseline-the-good-the-bad-and-the-ugly/
https://pxtorem.w3schools.in/

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
