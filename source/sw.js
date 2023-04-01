self.addEventListener('install', e => {
  e.waitUntil(
    caches.open('v8').then(cache =>
      cache.addAll([
        '/archives/',
        '/projects/',
        '/about/',
        '/images/simonewebdesign.webp',
        '/offline/'
      ])
    )
  )
})

self.addEventListener('fetch', event => {
  event.respondWith(
    caches.match(event.request)
    .then(res =>
      res || fetch(event.request)
    )
  )
})
