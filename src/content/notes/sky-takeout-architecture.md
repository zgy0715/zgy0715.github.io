---
title: 苍穹外卖的架构拆解
date: 2026-07-02
updated: 2026-10-15
tags: [SPRING BOOT, MAVEN, JWT, JAVA]
summary: 自学苍穹外卖项目时的架构笔记：Maven 多模块划分、三层架构、JWT 拦截器的请求处理流程。
source: https://github.com/zgy0715/sky-takeout
---

# 苍穹外卖的架构拆解

> 整理自 [sky-takeout](https://github.com/zgy0715/sky-takeout) 仓库 README（13KB，含完整流程图）。

## Maven 多模块

```
sky-take-out (父工程)
├── sky-common   —— 公共组件：常量、工具类、异常体系、统一返回结果
├── sky-pojo     —— 数据模型：Entity、DTO、VO
└── sky-server   —— 服务端：Controller、Service、Mapper、配置、拦截器
```

实体、DTO、VO 分开放是这套工程的核心纪律：接口入参用 DTO，出参用 VO，数据库映射用 Entity，互不混用。

## 三层架构与请求流程

经典 Controller → Service → Mapper。请求先过 `JwtTokenAdminInterceptor` 做 JWT 令牌校验，再进 Controller。

JWT 校验放在拦截器而不是每个 Controller 里，是这套架构的关键设计——登录签发 token，之后所有管理端请求自动带 token 校验。

## 为什么值得自学复刻

这个项目把企业级 Java 后端的标配都走了一遍：多模块工程、三层架构、全局异常处理、统一返回结果、拦截器鉴权。README 的流程图画得很全，适合对照源码逐层看。
