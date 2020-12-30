'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "icons/ms-icon-310x310.png": "09d230ab6ae2ccb08dfdf9ce6f993741",
"icons/ms-icon-144x144.png": "9f9e31821ad031da65f1c90285fdf632",
"icons/apple-icon-57x57.png": "303494696cb924bf93905239d0985dac",
"icons/ms-icon-70x70.png": "0d310ec8ba68e2f90014ec461ffe9c1f",
"icons/apple-icon-60x60.png": "a5801fafdef28f26b1d7c339823deed7",
"icons/ms-icon-150x150.png": "65910d1d4479b4aff3d38f21785e3866",
"icons/favicon.ico": "8f76fef0c95cd88e1f307197d6abeede",
"icons/favicon-32x32.png": "15005432b8c22c9cb4c03776f4d11649",
"icons/android-icon-36x36.png": "10ca41630a8d4ee502eacdac0e94389f",
"icons/manifest.json": "b58fcfa7628c9205cb11a1b2c3e8f99a",
"icons/apple-icon-76x76.png": "429f2cdbf3c1731ec11db8024e7f4e33",
"icons/apple-icon-114x114.png": "4d1bb3e1411ddb00cf1c9acaa85febc4",
"icons/favicon-16x16.png": "8a277503350d1dbeba8c3f0b9ff8aefa",
"icons/apple-icon-152x152.png": "d81b9049d654dcc50f5530a6d046db3a",
"icons/android-icon-72x72.png": "6735cb0dc0d33d65184f650aeb9cc00d",
"icons/favicon-96x96.png": "a2ae7d299466a5dc9f93ff44ff426aef",
"icons/android-icon-96x96.png": "a2ae7d299466a5dc9f93ff44ff426aef",
"icons/apple-icon-120x120.png": "e9e05ff0215eed846203a60f97abce39",
"icons/apple-icon.png": "8166304776c84961acfe7bc37b315cc8",
"icons/apple-icon-72x72.png": "6735cb0dc0d33d65184f650aeb9cc00d",
"icons/apple-icon-precomposed.png": "8166304776c84961acfe7bc37b315cc8",
"icons/apple-icon-180x180.png": "7f8043f623f99b33527f74638465d27a",
"icons/android-icon-48x48.png": "e9e464870ecbd4ee567f5422677b35cf",
"icons/android-icon-144x144.png": "9f9e31821ad031da65f1c90285fdf632",
"icons/apple-icon-144x144.png": "9f9e31821ad031da65f1c90285fdf632",
"icons/android-icon-192x192.png": "c848d39d29ca29558e88f2204127970e",
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
"index.html": "a042df19842ce9ccdce60d49c885e566",
"/": "a042df19842ce9ccdce60d49c885e566",
"version.json": "cc4d1b379d77484cd8754c0d59785c87",
"main.dart.js": "841e801f64bac3b64e6b1c41205f4943",
"browserconfig.xml": "653d077300a12f09a69caeea7a8947f8"
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
