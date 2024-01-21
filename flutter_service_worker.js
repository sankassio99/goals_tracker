'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter.js": "7d69e653079438abfbb24b82a655b0a4",
"manifest.json": "9db19c910030e4f242f0112226b4fce8",
"index.html": "011edc64de3ee46dc7290ae2951508df",
"/": "011edc64de3ee46dc7290ae2951508df",
"assets/AssetManifest.bin": "9a53dc2841cd1d3061cc9834e19d7984",
"assets/fonts/MaterialIcons-Regular.otf": "e7069dfd19b331be16bed984668fe080",
"assets/AssetManifest.bin.json": "574fe356857265d2029e711f3208a9c4",
"assets/FontManifest.json": "c85edf511094fc3afd57b99280b39b02",
"assets/shaders/ink_sparkle.frag": "4096b5150bac93c41cbc9b45276bd90f",
"assets/NOTICES": "b32b73362303c0d5a5542afdd018f86c",
"assets/AssetManifest.json": "30cb60ebd4c66f9b4e61775fae776374",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"assets/packages/phosphor_flutter/lib/fonts/Phosphor.ttf": "e56d2e29f64f52cf453a52a92ffc23a7",
"assets/packages/phosphor_flutter/lib/fonts/Phosphor-Fill.ttf": "9aab33bb9d7336d7ac41bf9be77e9dcc",
"assets/packages/phosphor_flutter/lib/fonts/Phosphor-Thin.ttf": "82b7ceac32b97050bd2cd3a9bc1a988b",
"assets/packages/phosphor_flutter/lib/fonts/Phosphor-Light.ttf": "6cba0bb346c4b1a2bd2580d924e01ba0",
"assets/packages/phosphor_flutter/lib/fonts/Phosphor-Duotone.ttf": "ef204da5b25e38cf50168fe91ffc1c2d",
"assets/packages/phosphor_flutter/lib/fonts/Phosphor-Bold.ttf": "8935f86db7bb9a7d31a3458fda3ceb81",
"main.dart.js": "f0ed09755cc0e115cc2a7b6342c2e62d",
"version.json": "27f63870f3f2aae8fe8d7e616b667093",
"canvaskit/canvaskit.wasm": "73584c1a3367e3eaf757647a8f5c5989",
"canvaskit/skwasm.js": "87063acf45c5e1ab9565dcf06b0c18b8",
"canvaskit/skwasm.wasm": "2fc47c0a0c3c7af8542b601634fe9674",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03",
"canvaskit/canvaskit.js": "eb8797020acdbdf96a12fb0405582c1b",
"canvaskit/chromium/canvaskit.wasm": "143af6ff368f9cd21c863bfa4274c406",
"canvaskit/chromium/canvaskit.js": "0ae8bbcc58155679458a0f7a00f66873",
"icons/apple-icon-precomposed.png": "ff0adc23654da7f6273fc86c8fc84715",
"icons/manifest.json": "b58fcfa7628c9205cb11a1b2c3e8f99a",
"icons/apple-icon-114x114.png": "768b87b10e8fdb34ff2ac482029500e4",
"icons/apple-icon-76x76.png": "67c7b36ced15d42088a1d39b19656e17",
"icons/apple-icon-120x120.png": "d0daf3b512cfb3e653ba25beaf47eb55",
"icons/android-icon-192x192.png": "4c4d16ecc3b3bf77580c8c8f17f49bba",
"icons/ms-icon-70x70.png": "9f4f7a186b2fdbe945a364644377a4c6",
"icons/android-icon-36x36.png": "094198a3ddf9253849ecf72c3e5a2ca5",
"icons/browserconfig.xml": "653d077300a12f09a69caeea7a8947f8",
"icons/android-icon-48x48.png": "5b415dd72ea4e5065f20f9c448cf0a9a",
"icons/goal.png": "61720b4427b3cb2a2dfd03bd5097902c",
"icons/apple-icon-72x72.png": "97d938a19c1e74d4933abdc323f67642",
"icons/ms-icon-150x150.png": "266679bd905dd997eee280a07189a7be",
"icons/favicon-32x32.png": "39430f355bf4807ce45cdc7f2a8f5edf",
"icons/apple-icon-152x152.png": "e700441d1cb3881572a7fea037504131",
"icons/apple-icon-180x180.png": "8f42396d5629067f31987af640af351a",
"icons/apple-icon-144x144.png": "4b860a8de28c1534106ae3d0cb7715bc",
"icons/android-icon-144x144.png": "4b860a8de28c1534106ae3d0cb7715bc",
"icons/favicon-16x16.png": "22721defb491c80168ba40e363f91523",
"icons/apple-icon.png": "ff0adc23654da7f6273fc86c8fc84715",
"icons/favicon.ico": "2f28b89f891040f250a03d92b0c168be",
"icons/ms-icon-144x144.png": "4b860a8de28c1534106ae3d0cb7715bc",
"icons/ms-icon-310x310.png": "969da92a5ff87286331fd2f7da7fcfa9",
"icons/apple-icon-60x60.png": "b026e91a8f0e2adfbd0cc894d524bce5",
"icons/apple-icon-57x57.png": "e363ece2d930f1b2c149ca06e55bf83f",
"icons/android-icon-72x72.png": "97d938a19c1e74d4933abdc323f67642",
"icons/favicon-96x96.png": "554490e95d60a64f16d0ef1f2946f216",
"icons/android-icon-96x96.png": "554490e95d60a64f16d0ef1f2946f216"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
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
        // Claim client to enable caching on first launch
        self.clients.claim();
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
      // Claim client to enable caching on first launch
      self.clients.claim();
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
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
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
  for (var resourceKey of Object.keys(RESOURCES)) {
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
