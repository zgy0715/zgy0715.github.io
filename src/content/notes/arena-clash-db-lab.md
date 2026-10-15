---
title: Arena Clash：数据库综合实验
date: 2026-06-07
updated: 2026-10-15
tags: [POSTGRESQL, REDIS, FASTAPI, VUE 3]
summary: 以"多人在线竞技游戏数据管理平台"为题的数据库综合实验：关系库 + 缓存 + FastAPI + Vue 3 的组合实战。
source: https://github.com/zgy0715/arena-clash
---

# Arena Clash：数据库综合实验

> 整理自 [arena-clash](https://github.com/zgy0715/arena-clash) 仓库 README（9.4KB）。`Database` 仓库是同一项目的 MySQL 8.0 版本，两个仓库对照着看正好覆盖两种主流关系库。

## 项目形态

以"多人在线竞技游戏数据管理平台"为业务壳的数据库综合实验，重点在数据层：

- **关系库**：PostgreSQL 12（arena-clash）/ MySQL 8.0（Database 版），含 PLpgSQL 存储过程（4.5 万字节的 PL/pgSQL 代码）
- **缓存**：Redis 7
- **后端**：Python 3.13 + FastAPI 0.115
- **前端**：Vue 3.5 + ECharts 5.6

## 为什么要做两版

同一个业务分别用 PostgreSQL 和 MySQL 实现，是对"SQL 方言差异、特性支持、生态工具"最直观的学习方式——比背对比文章有效得多。

## 值得看的点

PL/pgSQL 的存储过程体量不小，说明不是只建了表跑通 CRUD，而是把业务逻辑下沉到了数据库层做了练习。
