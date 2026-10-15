---
title: Tech Hotspot：多源爬虫与 AI 分析平台
date: 2026-05-18
updated: 2026-10-15
tags: [SCRAPY, FLASK, STREAMLIT, DEEPSEEK]
summary: 自动爬取 GitHub Trending / HN / arXiv / Reddit 四个源，Flask 统一 API，Streamlit 看板 + ECharts 仪表盘，集成 DeepSeek 挖掘趋势。
source: https://github.com/zgy0715/py
---

# Tech Hotspot：多源爬虫与 AI 分析平台

> 整理自 [py](https://github.com/zgy0715/py) 仓库 README（24KB，是所有仓库里最长的）。

## 数据管道

自动采集四个源的热点项目/文章：**GitHub Trending、Hacker News、arXiv、Reddit**，通过统一 API 对外提供数据服务。

## 技术栈

- **采集**：Scrapy 2.15+
- **API**：Flask 3.x
- **可视化**：Streamlit 1.35+ 看板 + ECharts 仪表盘
- **存储**：Redis 7+ 缓存
- **AI 层**：DeepSeek 集成——自动挖掘技术趋势、推荐值得关注的项目、生成学习路径和信号洞察

## 值得学的点

一个"采集 → 存储 → API → 可视化 → AI 增强"的完整闭环，每层用的都是该场景下的主流方案。README 24KB 的文档量也说明这个项目的模块划分和接口文档做得比较认真。
