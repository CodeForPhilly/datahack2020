const dataHackTeam11 = 'data-hack-2020-team11';
const assets = [
  '/',
  '/index.html',
  '/css/style.css',
  '/js/index.js',
  '/images/boy.svg',
  '/images/girl.svg',
  '/images/man.svg'
];

self.addEventListener('install', installEvent => {
  installEvent.waitUntil(
    caches.open(dataHackTeam11).then(cache => {
      cache.addAll(assets);
    })
  );
});

self.addEventListener('fetch', fetchEvent => {
  fetchEvent.respondWith(
    caches.match(fetchEvent.request).then(res => {
      return res || fetch(fetchEvent.request);
    })
  );
});
