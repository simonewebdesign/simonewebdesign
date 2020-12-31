self.addEventListener("install", function(event) {
  event.waitUntil(preLoad());
});

var preLoad = function(){
  return caches.open("offline").then(function(cache) {
    return cache.addAll([
      "/",
      "/archives/",
      "/projects/",
      "/about/",
      "/offline/",
      "/404/",
    ]);
  });
};

self.addEventListener("fetch", function(event) {
  if (event.request.method != 'GET') return;
  event.respondWith(checkResponse(event.request).catch(function() {
    return returnFromCache(event.request);
  }));
  event.waitUntil(addToCache(event.request));
});

var checkResponse = function(request){
  return new Promise(function(fulfill, reject) {
    fetch(request).then(function(response){
      if(response.status !== 404) {
        fulfill(response);
      } else {
        reject();
      }
    }, reject);
  });
};

var addToCache = function(request){
  return caches.open("offline").then(function (cache) {
    return fetch(request).then(function (response) {
      return cache.put(request, response);
    });
  });
};

var returnFromCache = function(request){
  return caches.open("offline").then(function (cache) {
    return cache.match(request).then(function (matching) {
      if(!matching || matching.status == 404) {
        if (navigator.onLine) {
          return cache.match("404/");
        } else {
          return cache.match("offline/");
        }
      } else {
        return matching;
      }
    });
  });
};
