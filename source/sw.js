self.addEventListener('install', e => {
  e.waitUntil(
    caches.open('v2').then(cache =>
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

self.addEventListener('fetch', e => {
  e.respondWith(
    caches.match(e.request).then(resp => {
      return resp || fetch(e.request).then(response => {
        let responseClone = response.clone()
        caches.open('v1').then((cache) => {
          cache.put(e.request, responseClone)
        })

        return response
      }).catch(() =>
        caches.match('/offline/')
      )
    })
  )
})
