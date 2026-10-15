---
title: 第 10 课：K 近邻（KNN）
date: 2026-06-16
updated: 2026-10-15
tags: [AI-ML-LEARNING, MACHINE LEARNING]
summary: 近朱者赤，近墨者黑——看最近 K 个邻居投票分类。K 值大小决定过拟合还是欠拟合。
source: https://github.com/zgy0715/AI-ML-Learning/blob/main/lessons/python/lesson_10_knn.md
---

# 第 10 课：K 近邻（KNN）

> 本文整理自 [AI-ML-Learning](https://github.com/zgy0715/AI-ML-Learning) 仓库 `lessons/python/lesson_10_knn.md`，配套代码 `lesson_10_knn.py`。

## 核心思想

要判断一个新数据属于哪一类，看它**最近的 K 个邻居**投票决定。课程里的例子：新同学（173cm，67kg）最近的 5 个朋友里 3 个打篮球 → 预测他也打篮球。

## K 值怎么选

- **K 太小（K=1）→ 过拟合**：只看最近一个邻居，遇到异常点就分错
- **K 适中（5 或 7）→ 效果最好**：综合多数意见，抗噪声
- **K 太大（K=全体）→ 欠拟合**：只看整体多数，忽略局部信息

## 距离怎么算

欧氏距离，就是初中的两点间距离公式：`d = √[(x₁-x₂)² + (y₁-y₂)²]`。

## 分类 vs 回归

分类用投票（少数服从多数），回归取 K 个邻居的平均值。

## 懒惰学习

KNN 是**懒惰学习**：没有训练过程，直接存储全部训练数据，预测时才算距离。训练零成本，预测开销大——和线性回归正好相反。

## 流程

存储训练数据 → 计算新样本到所有点的欧氏距离 → 排序取前 K 个 → 投票 → 返回结果。
