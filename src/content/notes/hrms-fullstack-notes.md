---
title: HRMS 员工管理系统的全栈拆解
date: 2026-08-22
updated: 2026-10-15
tags: [SPRING BOOT 3, VUE 3, RBAC, FULL-STACK]
summary: 从零实现的企业员工管理系统：22 个领域实体、15 个 REST 控制器、RBAC 四角色、固定种子可复现的演示数据。
source: https://github.com/zgy0715/renliguanli
---

# HRMS 员工管理系统的全栈拆解

> 整理自 [renliguanli](https://github.com/zgy0715/renliguanli) 仓库 README（15KB）。

## 规模一览

- 后端 Spring Boot 3（默认 H2 内嵌库，可选 MySQL）：22 个领域实体、15 个 REST 控制器、7 个业务服务、20+ Repository
- 前端 Vue 3 + Element Plus + ECharts：12 个业务页面、5 个通用组件、10+ 可视化图表
- 覆盖员工全生命周期「选、用、育、留」的 8 大业务模块

## RBAC 四角色

系统管理员（ADMIN）/ HR 专员（HR）/ 部门主管（MANAGER）/ 普通员工（EMPLOYEE），权限控制贯穿前后端。

## 演示数据的设计

内置 61 名员工（在职 57）、22 部门、46 岗位、7 个月的考勤与薪酬数据。亮点是用 `Random(42)` 固定随机种子 + `create-drop` 每次重建库表——**结果可复现、可反复演示**，这是很多演示项目做不到的。

## 启动体验

`./start.sh` 一键启动，也支持 CloudStudio 云 IDE 直接运行。内置 HR 智能助手（自然语言问数）和多层数据可视化看板。
