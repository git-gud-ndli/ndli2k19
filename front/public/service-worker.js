/* eslint-disable */
const API_ENDPOINT = "https://git-gud.fr";
importScripts("scripts/localforage.min.js");

/* Listen to SW update */
self.addEventListener("message", function({ data }) {
  if (data.action === "skipWaiting") {
    console.log("skipping");
    self.skipWaiting();
  }
});

const cacheThenNetworkStrategy = cacheName => {
  return ({ url, event, params }) => {
    event.respondWith(
      caches.open("gitgud").then(cache => {
        return fetch(event.request).then(response => {
          if (response.ok) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    );
  };
};

if (workbox) {
  console.log(`Workbox is loaded`);

  workbox.precaching.precacheAndRoute(self.__precacheManifest);

  /* CACHING */

  /**
   * Cache images using staleWhileRevalidate strategy since these are not
   * critical data and are usually the biggest ones
   */
  workbox.routing.registerRoute(
    /\.(?:png|gif|jpg|jpeg|svg)$/,
    new workbox.strategies.StaleWhileRevalidate({
      cacheName: "images",
      plugins: [
        new workbox.expiration.Plugin({
          maxEntries: 60,
          maxAgeSeconds: 30 * 24 * 60 * 60 // 30 Days
        })
      ]
    })
  );

  /**
   * Cache user details for offline access
   */
  workbox.routing.registerRoute(
    new RegExp(`${API_ENDPOINT}/api/user`),
    new workbox.strategies.StaleWhileRevalidate({
      cacheName: "user"
    })
  );

} else {
  console.log(`Workbox didn't load`);
}

self.addEventListener("push", event => {
  // default data
  let data = {
    title: "Notification!",
    content: "Une nouvelle notification est arrivée !"
  };

  // replace if data is present in the push
  if (event.data) {
    data = JSON.parse(event.data.text());
  }
  console.log(data);

  let options = {
    body: data.content,
    ...data
  };

  event.waitUntil(self.registration.showNotification(data.title, options));
});

/* Notifications actions */
self.addEventListener("notificationclick", ({ notification, action }) => {
  if (action === "close") {
    notification.close();
  } else {
    clients.openWindow(action);
    notification.close();
  }
});

/* BG SYNC */
// self.addEventListener('sync', (event) => {
//   event.waitUntil(
//   localforage.getItem('token')
//     .then(token => {
//       if (event.tag === 'sync-locations') {
//           loc_queue.iterate((val, key) => {
//             fetch(`${API_ENDPOINT}/api/owner/locations/${key.split('-')[0]}`, {
//               headers: {
//                 'Content-Type': 'application/json',
//                 'Accept': 'application/json',
//                 'Authorization': `Bearer ${token}`
//               },
//               method: 'POST',
//               mode: 'cors',
//               cache: 'default',
//               body: JSON.stringify({...val, deferred: true})
//             })
//             .then(() => {
//               console.log('removing', key)
//               loc_queue.removeItem(key)
//             })
//           })
//       }
//     })
//   )
// })