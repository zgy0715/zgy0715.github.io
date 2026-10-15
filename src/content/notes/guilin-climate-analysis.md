---
title: 桂林气候舒适度与旅游影响分析
date: 2026-06-01
updated: 2026-10-15
tags: [PYTHON, PANDAS, SCIKIT-LEARN, PYECHARTS]
summary: 用真实气候数据做的一次完整数据分析：Pandas/NumPy/SciPy/scikit-learn 建模，pyecharts 可视化，Jupyter 与 HTML 报告双输出。
source: https://github.com/zgy0715/guilin-climate-tourism
---

# 桂林气候舒适度与旅游影响分析

> 整理自 [guilin-climate-tourism](https://github.com/zgy0715/guilin-climate-tourism) 仓库 README（10KB）。6.7MB 的仓库，是所有仓库里数据量最大的。

## 分析主题

桂林的气候舒适度与旅游影响的关系——用数据回答"什么时候去桂林最舒服"这类问题。

## 技术路线

- **数据处理**：Pandas 1.5+ / NumPy 1.24+
- **统计与建模**：SciPy 1.10+（假设检验）、scikit-learn 1.2+
- **可视化**：pyecharts 1.9+（交互式图表）
- **交付形态**：Jupyter Notebook 分析过程 + HTML 报告双输出

## 值得注意的完整性

从 README 的徽章配置就能看出这条链的完整度：数据清洗 → 统计检验 → 建模 → 可视化 → 报告。相比一次性的分析脚本，这个项目把"分析结论如何交付给别人"也当成了工程问题来解。
