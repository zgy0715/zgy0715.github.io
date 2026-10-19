import { getCollection } from 'astro:content';

export async function GET({ site }) {
  const notes = (await getCollection('notes'))
    .sort((a, b) => b.data.date.valueOf() - a.data.date.valueOf());
  const esc = (s) => s.replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;');
  const cdata = (s) => s.replace(/\]\]>/g, ']]]]><![CDATA[>');
  const items = notes
    .map((n) => {
      const link = new URL(`/notes/${n.id}/`, site).href;
      return `    <item>
      <title>${esc(n.data.title)}</title>
      <link>${link}</link>
      <guid isPermaLink="true">${link}</guid>
      <pubDate>${n.data.date.toUTCString()}</pubDate>
      ${n.data.summary ? `<description>${esc(n.data.summary)}</description>` : ''}
      <content:encoded><![CDATA[${cdata(n.body ?? '')}]]></content:encoded>
    </item>`;
    })
    .join('\n');
  const xml = `<?xml version="1.0" encoding="UTF-8"?>\n<rss version="2.0" xmlns:content="http://purl.org/rss/1.0/modules/content/"><channel>\n    <title>YZBZGY · 学习笔记</title>\n    <link>${new URL('/', site).href}</link>\n    <description>YZBzgy 的学习笔记：机器学习、编程、造物记录</description>\n${items}\n  </channel></rss>`;
  return new Response(xml, {
    headers: { 'Content-Type': 'application/rss+xml; charset=utf-8' },
  });
}
