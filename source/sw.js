self.addEventListener('install', e => {
  e.waitUntil(
    caches.open('20250328').then(cache =>
      cache.addAll(['/archives/', '/projects/', '/about/', '/images/simonewebdesign.webp', '/offline/'])
    )
  )
})

self.addEventListener('fetch', e => {
  e.respondWith(
    caches.match(e.request)
      .then(res =>
        res || fetch(e.request).catch(() => caches.match('/offline/'))
      )
  )
})