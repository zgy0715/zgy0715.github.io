import { getCollection } from 'astro:content';

export async function GET({ site }) {
  const notes = await getCollection('notes');
  const paths = ['/', '/notes/', ...notes.map((n) => `/notes/${n.id}/`)];
  const urls = paths
    .map((p) => `  <url><loc>${new URL(p, site).href}</loc></url>`)
    .join('\n');
  const xml = `<?xml version="1.0" encoding="UTF-8"?>\n<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">\n${urls}\n</urlset>`;
  return new Response(xml, {
    headers: { 'Content-Type': 'application/xml; charset=utf-8' },
  });
}
