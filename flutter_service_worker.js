'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "icons/ic-meet-circle-384.png": "3aebe8bec3d9b161042950e81ee09917",
"icons/ic-meet-circle-16.png": "8ec0ce55e5ef26d8e4c954e49f02436f",
"icons/ic-meet-circle-72.png": "7a45a43126a0c4b1af911d8e8e39a6e0",
"icons/ic-meet-circle-256.png": "b280ea56e00c7a43acdfab358a2d73f9",
"icons/ic-meet-circle-48.png": "277f10f492443cbd57d0464e332fa8a7",
"icons/manifest.json": "0a1772ddf60c17863d11ff7e7b5d61b0",
"icons/ic-meet-circle-512.png": "c0666ff707cbf8607be9e3508d86a37b",
"icons/ic-meet-circle-96.png": "e569d1fd2f124b75e0a4ba163ccffca2",
"icons/ic-meet-circle-192.png": "5b228dfcc65f1b927d7b6a6c3eb43c2e",
"icons/ic-meet-circle-144.png": "a51acc6eb210068022c2371a50b6bdd0",
"manifest.json": "1688810cb65ab766c71f8411a4d50831",
"assets/NOTICES": "1a1982742163b4b602b0b6c515d86e80",
"assets/assets/images/app-icon.png": "a0407d6fc0269b96414567750a4d7487",
"assets/assets/images/img-undraw-team-spirit.png": "3a707a66197d67f34c4dc77c18addc5a",
"assets/assets/images/img-undraw-filter.png": "cd8f429e8e2a596aad772a8a5f5f49f8",
"assets/assets/images/img-undraw-meeting.png": "2f7da9bae81653b6b50cc9ef62e08732",
"assets/assets/images/img-undraw-time-management.svg": "1fd2361aa0f53517cb6f360c576f4ca6",
"assets/assets/images/img-undraw-team-spirit.svg": "a05d5fdbf27dd83e44a07988aafe2aac",
"assets/assets/images/img-undraw-meeting.svg": "de0ba5aeba45e35bf5a9329de6567be9",
"assets/assets/images/img-flexiple-virtual-office-girl.svg": "60bb3c74df494c168ce1ec8db43ccfeb",
"assets/assets/images/img-flexiple-virtual-office-girl.png": "f96b4385fdee3f1471415be6b87a4421",
"assets/assets/images/img-undraw-filter.svg": "826e6cdbc728aa1f21bf185b008e257d",
"assets/assets/images/img-undraw-time-management.png": "f6b593b2fe3effcf9fe013736bc68ebb",
"assets/AssetManifest.json": "a1079222c47ba8d9f0e8c441d2fd60bd",
"assets/FontManifest.json": "7b2a36307916a9721811788013e65289",
"assets/fonts/MaterialIcons-Regular.otf": "1288c9e28052e028aba623321f7826ac",
"index.html": "a81849a41a05a955bc804b86765f785e",
"/": "a81849a41a05a955bc804b86765f785e",
"version.json": "cc4d1b379d77484cd8754c0d59785c87",
"main.dart.js": "841e801f64bac3b64e6b1c41205f4943"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "/",
"main.dart.js",
"index.html",
"assets/NOTICES",
"assets/AssetManifest.json",
"assets/FontManifest.json"];
// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value + '?revision=' + RESOURCES[value], {'cache': 'reload'})));
    })
  );
});

// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});

// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache.
        return response || fetch(event.request).then((response) => {
          cache.put(event.request, response.clone());
          return response;
        });
      })
    })
  );
});

self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});

// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey in Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}

// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
