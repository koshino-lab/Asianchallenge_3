'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "be4447835b483499fd8f8813ab852a1c",
"version.json": "09b7b6ccc1021f35fd82e499a8615089",
"index.html": "3f4c8c3597c0df98c33048d08e97c306",
"/": "3f4c8c3597c0df98c33048d08e97c306",
"main.dart.js": "6ef2ed48255cf74b4021111da03a3a9c",
"flutter.js": "83d881c1dbb6d6bcd6b42e274605b69c",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "0b8fecd7f6d47b82d9c859abb1bdd5b9",
"assets/AssetManifest.json": "028e674272a46c136baff210e0022519",
"assets/NOTICES": "75efaf3c69f50bb21aec46d9ac085cec",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/AssetManifest.bin.json": "38fa1f844a0ac3b1f6f8c3d4dff906a2",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/packages/fluttertoast/assets/toastify.js": "56e2c9cedd97f10e7e5f1cebd85d53e3",
"assets/packages/fluttertoast/assets/toastify.css": "a85675050054f179444bc5ad70ffc635",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "9f88f387e77bcc1461e9738f3b729dca",
"assets/fonts/MaterialIcons-Regular.otf": "6b5fa7153ea56aec8cdcb6e6ab4a588c",
"assets/assets/images/red_decorated_button_submit_use.png": "4fdb5ab59dc20dbe050570483dbdcd83",
"assets/assets/images/container.png": "dd19fcec24618ea09e40cabe7f2a45b0",
"assets/assets/images/after_chain.png": "9d22884231f82072890e8faabaf5d9df",
"assets/assets/images/designd_red_buttom.png": "912095cb8b4bd2fc7fccca1c3852aaaa",
"assets/assets/images/key.png": "31b0e90b383d1042527887cd62450064",
"assets/assets/images/letter_dialog_rectangle.png": "eb3dff840046a76250ba1bb8f483feb8",
"assets/assets/images/map.png": "bf6e069d55d8464336fc81a050493e83",
"assets/assets/images/succes_page.jpg": "0435fb328ca9a1844c8671f662054e10",
"assets/assets/images/letter_dialog_rectangle_with_wanted.png": "c7fd33a8ecb7cb9e118fbe5a902dd6dd",
"assets/assets/images/Icon.svg": "0fc79048d5230c758bbd5d1e8840449b",
"assets/assets/images/right_trapezoid_with_start.png": "bea54ac82fdc11c20be74ff3685274fb",
"assets/assets/images/check.svg": "f819380413b725d6c04e789797f78603",
"assets/assets/images/padlock_bottom.png": "1f13e61cf7ee4416b4cf59d093eba8a7",
"assets/assets/images/before_chain.png": "05c1e44e6422947c1e3debd0daf14dc6",
"assets/assets/images/right_trapezoid_with_next.png": "71600137f0b626f7f7630e9e9acb5be2",
"assets/assets/images/story1.png": "2e61e74b14edfcfafc69d804e152a0b8",
"assets/assets/images/padlock_second_top.png": "537d5768039549500470c5bbb86a17e3",
"assets/assets/images/close_red_button.png": "940d8cc0728da33745cad33881ea4b10",
"assets/assets/images/story3.png": "d389cfc37ad265b98f1bd68e0f44343c",
"assets/assets/images/final_question.png": "f9bd346c600b6588cf26e72e05ea6460",
"assets/assets/images/story2.png": "2f53e6b39b44f4c5cedbe6c879aec468",
"assets/assets/images/red_decorated_button_submit.png": "7be0315ff87646f13c5d9fdae609788a",
"assets/assets/images/key_with_shadow.png": "8351bd905f138718112b9ea16c10d6b1",
"assets/assets/images/letter_dialog_rectangle_with_wanted_gold.png": "e642e9ffe839ddfd67c14fe6598c7db7",
"assets/assets/images/letter_dialog_square.png": "b96d069df114d7705660d57a4bb1adc1",
"assets/assets/images/letter_dialog_square_with_quiz.png": "032b4684c573aa5f4582a4f93b2096cb",
"assets/assets/images/pin3.svg": "508b1cd8fccb09250162ca775b6fbe73",
"assets/assets/images/padlock_middle.png": "c22ee386788f9589aaaf2427ecfb4d76",
"assets/assets/images/problem_page_filter.png": "7a0960ec7e37f0c329fbdd0aed6924d6",
"assets/assets/images/pin2.svg": "72d4796985082dc204bc9fb74539334a",
"assets/assets/images/right_trapezoid_with_end.png": "6e639d4d6b779332287540d018536e2b",
"assets/assets/images/succes_page2.png": "ab13784cdbfbfa40b9099fce6e46eda4",
"assets/assets/images/rectangle_back.png": "0bde89dc7aa82209b32c165a9066a1b7",
"assets/assets/images/pin1.svg": "aa9ad379b23150939e98e44fc3939230",
"assets/assets/images/pin5.svg": "8986eea5bfa542a972a2ca7453707abe",
"assets/assets/images/pin4.svg": "89d516be8cdadb8d9b2c20cf2c0bca40",
"assets/assets/images/letter_dialog_rectangle_with_wanted_and_goldrect.png": "6d23fd3456a18b1ad9265850627d4212",
"canvaskit/skwasm.js": "ea559890a088fe28b4ddf70e17e60052",
"canvaskit/skwasm.js.symbols": "e72c79950c8a8483d826a7f0560573a1",
"canvaskit/canvaskit.js.symbols": "bdcd3835edf8586b6d6edfce8749fb77",
"canvaskit/skwasm.wasm": "39dd80367a4e71582d234948adc521c0",
"canvaskit/chromium/canvaskit.js.symbols": "b61b5f4673c9698029fa0a746a9ad581",
"canvaskit/chromium/canvaskit.js": "8191e843020c832c9cf8852a4b909d4c",
"canvaskit/chromium/canvaskit.wasm": "f504de372e31c8031018a9ec0a9ef5f0",
"canvaskit/canvaskit.js": "728b2d477d9b8c14593d4f9b82b484f3",
"canvaskit/canvaskit.wasm": "7a3f4ae7d65fc1de6a6e7ddd3224bc93"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
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
