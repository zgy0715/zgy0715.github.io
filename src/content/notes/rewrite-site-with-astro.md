---
title: 用 Astro 重写个人网站
date: 2026-09-28
updated: 2026-10-15
tags: [ASTRO, HTML, CSS, GITHUB PAGES]
summary: 把 anontokyo.com 的前端打包产物逆向了一遍：269KB CSS、Tailwind 工具类、蓝粉渐变动画，然后全用原生实现。记录三次改版的决策。
---

# 用 Astro 重写个人网站

你现在看到的这个网站，已经是第三代了。第一代是典型的"AI 生成风"：米色纸质感、噪点纹理、卡片加边框，我盯着看了两分钟就删了。目标风格从一开始就定了：[anontokyo.com](https://www.anontokyo.com)，MyGO!!!!! 服装设计公司的官网。

## 逆向它的打包产物

直接抓 `index.html` 引用的 CSS 和 JS 文件分析，几个发现：

- CSS 有 **269KB**，里面是 Tailwind 工具类。真正用到的颜色就四个：`#3388bb`、`#287aac`、`#77bbdd`、`#ff8899`——全是整屏整块地铺，几乎看不到边框和圆角
- 字体只有两个：标题 **Bebas Neue**（超窄大写体），正文 IBM Plex Sans SC
- 签名式的"Scroll down"是蓝粉渐变动画：`linear-gradient(90deg, #7bd, #f89, ...)` 配合 `background-clip: text`，1.2s 无限循环
- 动效全靠 GSAP：ScrollSmoother 平滑滚动、ScrollTrigger 驱动巨大人名横移、Swiper 做产品轮播

## 哪些用原生等价实现

原站 Vue + GSAP + Swiper 一堆依赖，我全部零依赖：

- 横向文字流 → 滚动监听 + `translateX`，20 行（后来据点面板还做了个时间驱动的镜像版）
- 轮播 → CSS `scroll-snap` + 原生滚动事件
- 开场动画 → 纯 CSS keyframes，字母逐个浮现

## 踩过的坑

1. **开场动画两层错位**：第一版用"白幕黑字淡出 + 黑底白字"两层 DOM 叠加，字体加载时序稍有差异就对不齐。第二版改成同一组元素做 background/color 过渡，物理上不可能错位
2. **Git 的 CRLF 警告**：Windows 上每次提交都提示 `LF will be replaced by CRLF`，查了才知道 `core.autocrlf` 的机制，最后决定不管它—— warning 不影响内容
3. **GitHub 直连时断时续**：有一次推送重试了 6 次才成功，后来学会用 Git Data API 兜底，这个值得单独写一篇

## 结论

好网站的核心不是堆功能，是**统一**：字体、颜色、节奏全部服从一个语言。第三代上线后我大概率还会继续改，但方向已经锁死了。
