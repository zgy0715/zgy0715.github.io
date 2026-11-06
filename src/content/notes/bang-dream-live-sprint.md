---
title: BanG Dream! Live：两天冲刺到演示上线
date: 2026-10-22
updated: 2026-11-05
tags: [SPRING BOOT, VUE 3, SSE, DEEPSEEK, OLLAMA]
star: true
summary: 10.21–10.22 两天 30 个提交冲刺演示上线；11.02–11.05 又完成云端 LLM 联调（DeepSeek 流式 + tool_calls）、复读 bug 根治与一轮工程化大整理，测试口径刷新为 JUnit 149 / Vitest 82 / E2E 20。
source: https://github.com/zgy0715/ave-mygo
---

# BanG Dream! Live：两天冲刺到演示上线

ave-mygo 这个粉丝站从 10.21 到 10.22 密集提交了 30 次，把之前挂着的"清单 9–12、17"全部清零，然后更名定稿、部署演示。这篇按功能块记录真实做了什么、踩了什么坑。

## AI 助手：流式输出 + 规则引擎兜底

之前 AI 助手是一次性返回整段回答，等待感很明显。这次改成流式：

- 后端 `/chat/stream` 用 `SseEmitter` 分片推送，每个分片带 `done` 事件收尾，跑在独立线程池里，不占 Tomcat 工作线程（[89332f5](https://github.com/zgy0715/ave-mygo/commit/89332f5)）
- 模型是本地 Ollama 跑 qwen3:8b，走 OpenAI 兼容端点，前端逐字打字机渲染
- LLM 不可用（没装模型、推理超时）时规则引擎兜底：先做意图识别——推荐歌曲、成员问答、乐队概况三类意图分别注入结构化数据，再按四人格（小灯 / 祥子 / まな / にゃむ）的口吻重写输出，保证格式和 LLM 版本一致（[3ebded8](https://github.com/zgy0715/ave-mygo/commit/3ebded8)、[ec44b72](https://github.com/zgy0715/ave-mygo/commit/ec44b72)）

兜底输出最大的坑是"口吻不一致"：第一版规则引擎的回答像说明书，和人格完全违和。最后是把每类意图的模板拆成人格各自的变体才解决。

## 演出/场次/票档三级删除

管理端此前只能新建和编辑，删不了东西。这次补齐三级删除（[c761fba](https://github.com/zgy0715/ave-mygo/commit/c761fba)）：

- 全部软删；演出删除要级联场次和票档
- 有未完成订单时拦截，业务错误码 40903，前端提示去处理订单

功能一把过，bug 出在前端三连（都修在同一天）：

1. 场次删除成功后列表不刷新（[b04133a](https://github.com/zgy0715/ave-mygo/commit/b04133a)）
2. 「删除中…」按钮文案引用了未声明的 `errMsg`，直接报错（[c054df5](https://github.com/zgy0715/ave-mygo/commit/c054df5)）
3. 删除公开端场次后，SessionView 还在用旧的 eventId 拉数据（[4a608c6](https://github.com/zgy0715/ave-mygo/commit/4a608c6)）

修完顺手补了管理端 Playwright E2E 旅程，把删除链路盖住。

## 数据审计 V45–V49

Flyway 迁移又推进了五个版本，全是数据可信度问题：

| 版本 | 内容 |
|:----|:----|
| V45 | 全量数据审计，修正 4 处事实性错误 |
| V46 | 6 首歌 MV 换成 Bilibili 官方账号源 |
| V47 | 5 首歌音源回填 + 1 处时长修正 |
| V48 | 专辑归属补全 + 日期修正 + 幻影数据清理 |
| V49 | 幂等化重写：加 INFORMATION_SCHEMA 守卫，重复执行不炸 |

V49 幂等化是因为 CloudStudio 演示环境要反复重建，迁移脚本必须能重复跑。

## 上线一课：nginx 反代的 Origin

演示环境用 nginx 同源反代（`/` 走静态、`/api/**` 转 8080）。部署完发现**线上所有 POST 都 403**，本地却正常（[315e3fb](https://github.com/zgy0715/ave-mygo/commit/315e3fb)）。

原因是站点的 CSRF/来源校验拿 `Origin` 头比对白名单，而经 nginx 反代后浏览器发的 `Origin` 是外网域名，后端配置里没有。最终方案是在 nginx 反代层把 `Origin` 置空，让同源请求自然通过——一行 `proxy_set_header Origin ""` 的事，但定位花了不少时间，因为 403 响应体没有给出校验环节的线索。

配套写了 `cloudstudio.sh`，一键部署/更新/重启（[ef7a162](https://github.com/zgy0715/ave-mygo/commit/ef7a162)）。

## 更名定稿

最后一天做了品牌收尾（[ed112ce](https://github.com/zgy0715/ave-mygo/commit/ed112ce)）：

- 项目名从 BANDORI LIVE 更名 **BanG Dream! Live**，Hero 大标题、跑马灯、页脚的 BANDORI 残留全部清掉，重截 5 张站点截图（[ec876ec](https://github.com/zgy0715/ave-mygo/commit/ec876ec)）
- README 全面重写，顶部 17 枚 shields.io 徽章
- 清理失效外链：删掉抖音死链，MyGO 官网换成现行地址（[c473510](https://github.com/zgy0715/ave-mygo/commit/c473510)）

## 云端 LLM 联调与工程化收尾（11.02–11.05）

演示上线之后这一周半，主线是把 AI 助手从"本地 Ollama 才能用"升级成云端也能跑，顺手做了一轮工程化大整理。

### 三个客户端统一成一个基座

项目里 LLM 调用散在三个客户端里（本地流式、本地非流式、云端），行为各不相同。11.05 把 `LlmClient` 并进 `LlmSupport`，端点逻辑彻底归一。合并过程中抓到两个真 bug：

- 云端非流式端点没带鉴权头，导致 v1 兜底路径 401
- 流式协议切到云端 OpenAI 兼容端点后，`tool_calls` 的增量拼接逻辑要按云端返回格式重写

### DeepSeek 上云，P0 清零

11.03 按文档 19 号清单收尾：云上"小灯"（AI 助手人格）实测走 DeepSeek 可用，流式问答在云端环境跑通。中间还修了一个部署坑——Hero 轮播视频之前为了瘦身移出版本库，结果云上 MV 直接 404，只好加回并让首页缺失时自动降级。

### 「一直回答重复」的根治

用户反馈 AI 助手会一直复读。排查下来不是模型问题，是会话管理四件套缺齐：会话要**按人格隔离**（小灯和祥子的历史不能串）、历史请求要**去重**、落库要**幂等**、最后再加一道**复读闸门**兜底。四层一起上才根治（11.05）。

### 测试与仓库的工程化

- 测试 profile 关闭定时调度，消除全量跑必现的 MySQL 死锁
- E2E 歌单用例改成自清理数据，本地后端脚本放宽限流
- 目录重整：`ave-mygo` → `backend/`，素材和备份移出根目录；文档归档瘦身
- 新增 check 基线脚本（后端测试 + Vitest + 可选 E2E）与 148 行幂等的参考种子数据 `db/seed/reference.sql`
- 启动脚本自动定位 JDK 17 与 `mvn.cmd`，不再依赖 `mvnw.cmd`
- 清理 88 个测试账号后刷新口径：3 用户 / 11 订单 / 19 表 / 20 条 E2E

## 现状

曲库 55 首（iTunes 官方 30 秒预览外链）、票务防超卖闭环、收藏与歌单、评论与开售提醒、四人格 AI 助手（本地 Ollama / 云端 DeepSeek 双通道）、管理端看板与三级增删全部可用；测试 JUnit 5（149 用例）+ Vitest（82 用例）+ Playwright E2E（20 条旅程）；Flyway 迁移推进到 V55；CloudStudio 演示环境在线。剩下的是购票体验细节和性能调优。
