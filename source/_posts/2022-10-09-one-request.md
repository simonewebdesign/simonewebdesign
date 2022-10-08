---
layout: post
title: One request
description: A journey through painstakingly optimizing a blog's performance
permalink: /1req/
date: 2022-10-09
comments: false
---

> In an era where 95% of sites are bloated with cookie banners and behavioral tracking scripts, here's a refreshing approach to web development.

Nowadays, loading a website on your device of choice can be painful — both for the browser, which has to parse and render all that stuff, and for you, the user, which has to wait for it (and pay for that data plan).

The issue is only exacerbated by the fact that mobile devices can be slow, the network can be slow, and there's simply too much [cruft](https://en.wikipedia.org/wiki/Cruft) to download.

There is a better way.<!--more-->

**What if you could make your entire website fit into a single page?**

A lot of sites are built as a single page (can we have more of those?), and no, I don't mean a single page app. I'm talking about something radically different here. Essentially, the challenge boils down to this:

> Can I reduce the home page down to a single file?

First of all, _why?_ You may ask. Well, many reasons. I did this to my blog (which you're reading now). I mostly did it just to prove it possible, but it turned out to be a fun challenge that kept me busy for months and resulted in a much faster, more maintainable website, with a pretty small [carbon footprint](https://www.websitecarbon.com/website/simonewebdesign-it/).

<abbr title="too long; didn't read">TL;DR</abbr>: Our planet matters. User experience matters. Speed matters.

## The secret sauce: inline _all the things_

This is essentially how I've done it. I've inlined everything that could've possibly been inlined. Keep reading if you're curious and want to know all the details on how I achieved this.

### Inline styles

This is where the journey started. I refactored some CSS, got rid of a few superfluous HTML tags, and the stylesheet got so small that I thought, why not just inline it? So I looked into that.

I thought I should be able to *inline* the compiled `style.css`'s contents into a `<style>` tag, somehow. This turned out to be a challenge. I couldn't find a tool that did exactly this, so I wrote my own — or, to be more specific, I sent a pull request to [inline-scripts](https://github.com/mahhov/inline-scripts), which seemed like the closest thing I could find. At first, all it was doing was inlining `<script>` tags, so I only had to do the same, but for CSS — a simpler job, figuratively speaking.

Anyway, with some clever Ruby scripting I managed to minify all the HTML, CSS and JS in one go. I would first inline the CSS "on the spot" (i.e. without creating a new file):

```rb
Dir["public/**/*.html"].each do |file|
  puts "Processing #{file}..."
  system "node_modules/.bin/inline-stylesheets #{file} #{file}"
end
```

I would then run [html-minifier](https://github.com/kangax/html-minifier) as such:

```sh
html-minifier --file-ext html --case-sensitive \
 --collapse-boolean-attributes --collapse-whitespace \
 --minify-css true --minify-js true \
 --remove-attribute-quotes --remove-comments \
 --remove-empty-attributes --remove-empty-elements \
 --remove-optional-tags --remove-redundant-attributes \
 --remove-script-type-attributes \
 --remove-style-link-type-attributes \
 --remove-tag-whitespace --sort-attributes \
 --sort-class-name --trim-custom-fragments \
 --use-short-doctype
```

And there you have it — a highly optimized, one-liner HTML file with inline CSS and JS — for every page.

### Inline manifest.json

The [manifest.json](https://developer.mozilla.org/en-US/docs/Mozilla/Add-ons/WebExtensions/manifest.json) is usually pretty small, so it makes sense to inline it.

How did I do this? It was actually pretty simple: I made it into a data URI of type `data:application/manifest+json`, which is then loaded as a `<link rel="manifest">`, just as usual. Here it is, in its full one-line glory:

```html
<link href='data:application/manifest+json,{"name":"Simone Web Design","short_name":"SimoneDesign","theme_color":"%23555","background_color":"%23f6f6f6","display":"minimal-ui","description":"A tech blog"}' rel=manifest>
```

The only catch was that I had to [encodeURIComponent](https://stackoverflow.com/a/67244614/801544).

## Analytics

I got rid of client-side analytics. [Cloudflare](https://www.cloudflare.com/) already gives me enough stats, such as the number of requests, unique visits and page views, grouped by visiting country. I don't really need any more than that.

As an interesting side note, when I check the analytics on Cloudflare, it also shows a Carbon Impact Report, which claims to have saved me 836 grams of carbon (in 2020 vs average data centers) — this is equivalent to turning off one lightbulb for 20 hours, apparently. It sounds an awful lot like [greenwashing](https://en.wikipedia.org/wiki/Greenwashing), if you ask me, but to be fair they do seem to have put effort on reducing the [Internet's environmental impact](https://blog.cloudflare.com/helping-build-a-green-internet/).

## The server

I use [Puma](https://puma.io/). It is a fast server that provides [parallelism](https://en.wikipedia.org/wiki/Parallel_computing) out of the box. This is what my [Procfile](https://devcenter.heroku.com/articles/procfile) looks like:

    web: bundle exec puma --threads 8:32 --workers 3 -p $PORT

Basically what this means is that, at any given time, there are 8 threads ready to serve you a request, over 3 separate clusters.

This may be a little overkill, since I also use Cloudflare as a caching layer on top of this server, which is load balanced and globally distributed. I also don't usually get much traffic, so this definitely achieves the goal of speed.

## Hosting and DNS

I recently switched to a new hosting provider, [Fly.io](https://fly.io/). I had to do that since Heroku, my old provider, unfortunately [discontinued their free plan](https://blog.heroku.com/next-chapter). Sad news, I've used it for 10 years, but it was time to move on.

Fly has a pretty sound infrastructure with modern features:

- Edge TLS termination. By handling TLS _at the edge_, the handshake is handled by the nearest datacenter to the user. As a result, **latency is decreased**.
- High performance micro VMs on bare metal servers. **The server replies faster**.
- HTTP2 and Brotli compression. **The data gets sent faster**.

Last but not the least, I was able to remove a [CNAME record](https://en.wikipedia.org/wiki/CNAME_record) and use an [A record](https://en.wikipedia.org/wiki/List_of_DNS_record_types#A) instead. This resulted in **one less server roundtrip**.

## Other minor optimizations

These are loosely related to the "one request" thing, but still worth mentioning.

### Move to modern media formats

Lots of formats have actually been superseded by more efficient ones: <abbr title="Portable Network Graphics">PNG</abbr> to WebP, <abbr title="Graphics Interchange Format">GIF</abbr> to MP4, <abbr title="Joint Photographic Experts Group">JPEG</abbr> to <abbr title="AV1 Image File Format">AVIF</abbr>... the list likely goes on — these are just the ones I'm aware of.

### The favicon

I went from <abbr title="Portable Network Graphics">PNG</abbr> to <abbr title="Scalable Vector Graphics">SVG</abbr> for the favicon, which I blatantly stole from Peter Selinger, the guy behind [Potrace](https://potrace.sourceforge.net/) <small>(it was public domain, technically)</small>. What I did on my part was optimizing it even further, using Jake Archibald's wonderful [SVGOMG](https://jakearchibald.github.io/svgomg/), powered by [SVGO](https://github.com/svg/svgo).

As for inlining it, I had to serialize it into a data URI using [mini-svg-data-uri](https://github.com/tigt/mini-svg-data-uri). I even ended up making a <abbr title="Command-line interface">CLI</abbr> out of it — it's something I had to do anyway, and [contributing back](https://github.com/tigt/mini-svg-data-uri/pull/19) was the least I could have done.

### The fonts

I got rid of the custom Google font I was using and went for system fonts. This is what I have now:

```css
html {
  font-family: "PT Serif", Georgia, Times, "Times New Roman", serif;
}
```

I don't actually provide PT Serif, however. If your machine happens to have that, great — if not, it'll fall back to the next one. I might reconsider this choice in the future, but for now, this is good enough.


### The JavaScript

I waited until the end to say this, because you probably wouldn't have believed me, but **this site doesn't have any JavaScript**, the only exception being made for the [ServiceWorker](https://developer.mozilla.org/en-US/docs/Web/API/Service_Worker_API):

```js
<script>
  navigator.serviceWorker.controller || navigator.serviceWorker.register("/sw.js")
</script>
```

[The ServiceWorker is actually a separate JS file](https://simonewebdesign.it/sw.js), because I couldn't find a way to inline that (if you do know of a way, please let me know). But, other than that (and Disqus, which I'm planning to remove soon), I don't need JS at all. <span role="img" aria-label="shrugs">¯\\\_(ツ)\_/¯</span>

## Conclusion

I hope you liked this article at least as much as I enjoyed writing it. I hope it tickled your curiosity, to the very least, and that - by shedding a light on the importance of performance - I've inspired you to take action and improve your own site. Either way, it's been a fun ride. For the records, I started writing this on September 20<sup>th</sup>, 2021. Glad I got round to finishing it.
