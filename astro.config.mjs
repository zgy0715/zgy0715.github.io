import { defineConfig } from 'astro/config';

export default defineConfig({
  site: 'https://zgy0715.github.io',
  markdown: {
    shikiConfig: {
      // Astro 默认不在 pre 上保留语言信息，补一个 data-language 供代码块工具条显示
      transformers: [
        {
          pre(node) {
            node.properties['data-language'] = this.options.lang;
          },
        },
      ],
    },
  },
});
