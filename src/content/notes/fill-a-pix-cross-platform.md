---
title: 像素填空：Android 与鸿蒙的双端同构实践
date: 2026-07-31
updated: 2026-10-15
tags: [KOTLIN, ARKTS, FASTAPI, HARMONYOS]
summary: 一个谜题游戏同时做 Android（Compose）和鸿蒙（ArkUI）两端，共用服务端与协议。关卡由服务端生成并校验唯一解。
source: https://github.com/zgy0715/xiangsuGame
---

# 像素填空：Android 与鸿蒙的双端同构实践

> 整理自 [xiangsuGame](https://github.com/zgy0715/xiangsuGame) 仓库 README（16KB）。

## 游戏本身

Fill-a-Pix（像素填空）是经典逻辑谜题：每个数字提示告诉你以它为中心的 3×3 区域内需要涂黑的格子数，推理涂色最终拼出像素画。

## 双端架构

- **Android**：Kotlin + Jetpack Compose
- **鸿蒙**：ArkTS + ArkUI
- **服务端**：Python FastAPI + SQLite

关键设计是两端逻辑层都是**"纯逻辑、无 UI 依赖"的同构实现**——可以直接在各自平台做单元测试，且两端共用同一服务端与协议，可同房对战。

## 服务端生成关卡

关卡由服务端**即时生成并校验唯一解**，算法与 `tools/` 工具链共用同一个 Python 引擎——谜题游戏最怕多解，把唯一性校验放在服务端是最稳的做法。

## 账号系统细节

邮箱 + 6 位验证码登录（无用户名密码），验证码只存 sha256 哈希不落明文；首次登录自动注册；还有游客/离线兜底入口——连不上服务器也能玩全部内置关。
