self.addEventListener('install', e => {
  e.waitUntil(
    caches.open('v7').then(cache =>
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

self.addEventListener('activate', e => {
  ['v1','v2','v3','v4','v5','v6'].forEach(c => {
    caches.delete(c)
  })
})

self.addEventListener('fetch', e => {
  e.respondWith(
    caches.match(e.request).then(resp => {
      return resp || fetch(e.request).then(response => {
        let responseClone = response.clone()
        caches.open('v7').then((cache) => {
          cache.put(e.request, responseClone)
        })

        return response
      }).catch(() =>
        caches.match('/offline/')
      )
    })
  )
})
