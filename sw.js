// GJM Radio — service worker : garde l'interface disponible hors ligne.
// Les flux radio, les vidéos et l'annuaire des stations passent toujours par le réseau.
const VERSION = 'gjm-radio-v18';
const SHELL = ['./', 'index.html', 'manifest.webmanifest', 'icon-192.png', 'icon-512.png', 'icon-maskable-512.png', 'logo.png', 'programme.json', 'config.json', 'gjmtv.json'];

self.addEventListener('install', e => {
  e.waitUntil(caches.open(VERSION).then(c => Promise.all(SHELL.map(f => c.add(f).catch(() => {})))).then(() => self.skipWaiting()));
});

self.addEventListener('activate', e => {
  e.waitUntil(
    caches.keys()
      .then(keys => Promise.all(keys.filter(k => k.startsWith('gjm-radio-') && k !== VERSION).map(k => caches.delete(k))))
      .then(() => self.clients.claim())
  );
});

self.addEventListener('fetch', e => {
  const url = new URL(e.request.url);
  if (e.request.method !== 'GET' || url.origin !== location.origin) return; // flux, API, polices : réseau direct
  if (e.request.headers.has('range') || /\.(mp4|webm|m4v|mov|mp3|m4a|aac|m3u8|ts)$/i.test(url.pathname)) return; // vidéos et sons : réseau direct, jamais en cache
  // Réseau d'abord (pour recevoir les mises à jour), cache si hors ligne
  e.respondWith(
    fetch(e.request)
      .then(res => {
        if (res.ok && res.status === 200) { const copy = res.clone(); caches.open(VERSION).then(c => c.put(e.request, copy)); }
        return res;
      })
      .catch(() => caches.match(e.request).then(r => r || caches.match('index.html')))
  );
});
