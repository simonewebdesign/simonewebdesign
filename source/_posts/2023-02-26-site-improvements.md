---
layout: post
title: Site improvements
description:
published: false
---

- Replaced Disqus with [Utterances][utteranc.es]
- Added Twitter, OpenGraph and Schema.org metadata
- Added link to edit a post on GitHub
- Added expanding mechanism on hover for code snippets that don't fit in the blog column


### Security and performance

- Re-enabled Cloudflare as a reverse proxy (previously I set it to DNS-only, for debugging the migration to Fly.io)
- Enabled end-to-end encryption on Cloudflare
- Enabled [HSTS preload](https://hstspreload.org/) and submitted site to the Chrome preload list
- Forced [HTTPS everywhere](https://developers.cloudflare.com/ssl/edge-certificates/additional-options/always-use-https/), at all times
- Upgraded [minimum TLS version](https://developers.cloudflare.com/ssl/edge-certificates/additional-options/minimum-tls/) to 1.2