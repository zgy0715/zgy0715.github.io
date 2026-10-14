# YZBzgy Personal Archive

一个中文优先的个人网站第一版，采用全屏字标、MENU 导航、横向兴趣流、Projects 展示、抽象 Headquarter 地图与 Contact 区块。使用 Astro 静态构建，可部署到 GitHub Pages。

## 本地运行

需要 Node.js 22.12 或更新版本。

```sh
npm install
npm run dev
```

## 发布到 GitHub Pages

把本项目放进 GitHub 账号 `zgy0715` 的新仓库 `zgy0715.github.io`，推送到 `main`。仓库的 **Settings → Pages → Build and deployment → Source** 选择 **GitHub Actions**。工作流会自动构建并发布到 `https://zgy0715.github.io`。

## 首版内容

- 品牌显示名：YZBzgy
- 全屏 YZBzgy 标题与 MENU 导航
- 横向滚动的兴趣方向展示
- GitHub 项目、抽象线上据点与联系入口
- 已加入公开仓库 `zgy0715/AI-ML-Learning`
- 声音默认关闭，用户可自行开启简短合成音

在 `src/pages/index.astro` 中修改介绍、兴趣词和项目内容。页面采用原创 CSS 图形和排版，借鉴参考页的结构与滚动体验；后续可以替换成你的照片、项目截图或真实配乐。

