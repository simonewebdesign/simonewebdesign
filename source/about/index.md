---
layout: page
title: About Simone
footer: true
---

<style>a::after{width:0 !important;margin-left:0 !important}</style>
<div class="about-intro">
<picture>
    <source type="image/webp" srcset="/images/simonewebdesign.webp">
    <img src="/images/simonewebdesign.png" width="168" height="210" alt="simonewebdesign's avatar" />
</picture>
<p>
<strong>Simone Vittori</strong> is a programmer originally from <a rel="external" href="https://en.wikipedia.org/wiki/Perugia">Perugia</a>, Italy, but now living in London, England. He's obsessed about code: if he's not writing it, he's probably reading, speaking or dreaming about it. He enjoys coding in many different languages, such as <a rel="external" href="https://www.ruby-lang.org/">Ruby</a>, <a rel="external" href="https://elixir-lang.org/">Elixir</a>, <a rel="external" href="https://elm-lang.org/">Elm</a> and <a rel="external" href="https://gleam.run/">Gleam</a>, just to name a few. In his free time, he loves walking in nature, eating pasta and playing video games.</p>
</div>

## {{ site.domain }}

I founded this site in February 2010, back when Flash games and IE6 (<span title="Press F to pay respects" tabindex="-1">🪦</span>) were still a thing. It went through a few iterations since then, going from a humble personal space to a tech blog. I started with WordPress before moving to [Octopress]({% post_url 2014-05-13-bye-bye-wordpress-welcome-octopress %}) and finally Jekyll. It's also my playground: I like to tinker with it, experiment with ideas, and sometimes just mess around for the sake of learning.

Some fun facts:

- **It is free and open source.** It's my way of giving back to the <a rel="external" href="https://indieweb.org/">indie web</a>. It feels good <a rel="external" href="https://github.com/simonewebdesign/simonewebdesign">to share</a>, and it's <a rel="external" href="https://www.gnu.org/philosophy/fs-and-sustainable-development.html">the right thing.</a>

- **There is no backend nor database.** All pages are actually [just HTML & CSS]({% post_url 2022-10-09-one-request %}), resulting in a super fast website that can't be hacked.

- **No advertising or tracking either.**
I write blog posts so that I don't forget stuff I learn and because I enjoy sharing my work with others.

## Let's get in touch!

Find me on social media here below, or just [send me an email](mailto:hello@simonewebdesign.it?subject=Hey Simone!).

<script>
 let grave = document.querySelector('[title="Press F to pay respects"]')

  grave.addEventListener('mousedown', e => {
    e.preventDefault() // prevent focus on click, but not other pointer events
  })

  document.body.addEventListener('keydown', e => {
    if (e.key.toLowerCase() === 'f') {
      grave.focus()
    }
  })
</script>