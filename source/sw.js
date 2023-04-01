---
---
self.addEventListener('install', e => {
  e.waitUntil(
    caches.open('v8').then(cache =>
      cache.addAll([
'/',
'/archives/',
'/projects/',
'/about/',
'/images/simonewebdesign.webp',
'/categories/javascript/',
'/categories/ruby/',
'/categories/bash/',
'/categories/git/',
'/categories/css/',
'/categories/elixir/',
'/categories/swift/',
'/categories/php/',
'/categories/elm/',
'/categories/clojure/',
'/categories/rust/',
{% for post in site.posts %}'{{ post.url }}'{% if forloop.last %}{% else %},
{% endif %}{% endfor %}
      ])
    )
  )
})

self.addEventListener('fetch', event => {
  event.respondWith(
    caches.match(event.request)
    .then(res => res || fetch(event.request))
  )
})
