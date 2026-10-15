---
title: AI-ML-Learning 的路线图与真实进度
date: 2026-10-15
updated: 2026-10-15
tags: [AI-ML-LEARNING, MACHINE LEARNING, PYTHON]
star: true
summary: 解读自己仓库里的四阶段路线图和 PROGRESS.md：Phase 1-2 已完成，Phase 3 推进到第 10 课 KNN。数据全部来自仓库文件。
---

# AI-ML-Learning 的路线图与真实进度

[AI-ML-Learning](https://github.com/zgy0715/AI-ML-Learning) 是我 AI 方向的主仓库，README 开头写着目标："从零基础到独立完成 AI 项目，一步一个脚印"。这篇笔记把它的真实结构和进度整理一遍，数据全部来自仓库文件（2026-10-15 通过 GitHub API 拉取）。

## 四阶段路线图

README 里定义了 5 个阶段 22 课：

| 阶段 | 课次 | 内容 |
|:----|:----:|:----|
| Phase 1: Python 基础 | 第 1-4 课 | 变量、条件、列表字典、文件与异常 |
| Phase 2: 数据科学生态 | 第 5-7 课 | NumPy、Pandas、Matplotlib |
| Phase 3: 机器学习算法 | 第 8-14 课 | 线性回归、KNN、模型评估、决策树、朴素贝叶斯、逻辑回归 |
| Phase 4: 深度学习基础 | 第 15-18 课 | 感知机、神经网络、PyTorch 入门 |
| Phase 5: 项目实战 | 第 19-22 课 | 独立完成 AI 项目 |

## 真实进度（截至 PROGRESS.md 最后更新）

- **Phase 1、Phase 2：100%** ✅
- **Phase 3：进行中**，`lessons/python/` 下已有第 8 课 ML 概念、第 9 课线性回归（md + py 配套）、第 10 课 KNN（md + py 配套）
- **Phase 4、5：未开始**

另外仓库里还有一个容易被忽略的部分：`lessons/java/` 下有 7 课 Java 专题（基础、OOP、API、集合、IO、线程网络、反射），Java 和 Markdown 成对出现。这也是为什么这个"Python 学习仓库"在 GitHub 语言统计里 Java 占了更大头——240KB 对 50KB。

## 仓库结构

顶层是 `lessons/`（36 个条目）、`JAVA/`、`data/`、`tests/`（每课的作业，比如第 1 课的作业是输入出生年份算年龄，第 2 课是成绩等级评定）和那份 `PROGRESS.md`。

## 下一步

按 PROGRESS.md 的规划，接下来是第 11-14 课（模型评估、决策树、朴素贝叶斯、逻辑回归），然后进 Phase 4 的 PyTorch。
