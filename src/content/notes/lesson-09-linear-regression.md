---
title: 第 9 课：线性回归与梯度下降
date: 2026-06-16
updated: 2026-10-15
tags: [AI-ML-LEARNING, MACHINE LEARNING, PYTHON]
summary: y = wx + b、MSE 损失函数、梯度下降的"下山"直觉，以及为什么必须做特征归一化。
source: https://github.com/zgy0715/AI-ML-Learning/blob/main/lessons/python/lesson_9_linear_regression.md
---

# 第 9 课：线性回归与梯度下降

> 本文整理自 [AI-ML-Learning](https://github.com/zgy0715/AI-ML-Learning) 仓库 `lessons/python/lesson_9_linear_regression.md`，配套代码 `lesson_9_linear_regression.py`。

## 核心公式

```
y = wx + b
```

`w` 是权重（x 每增加 1，y 变多少），`b` 是偏置（x=0 时的基础值）。线性回归的目标：**找一条直线，尽可能贴合所有数据点**。

## 损失函数：MSE

```
MSE = 1/n × Σ(预测值 - 真实值)²
```

误差为什么要平方？① 正负误差不互相抵消；② 放大大误差，让模型更在意严重的错误。MSE 越小，拟合越好。

## 梯度下降：下山比喻

蒙眼下山：用脚探最陡方向（算梯度）→ 迈一步（更新参数）→ 重复直到谷底。

```
w = w - 学习率 × ∂loss/∂w
b = b - 学习率 × ∂loss/∂b
```

学习率的三种命运：**太大**直接跳过山谷（发散）；**太小**走半天还在山上（训练慢）；**适中**稳稳到谷底。

## 特征归一化

面积 30~150、卧室数 1~5 两个特征量纲差太多，不归一化就训练不稳定。Z-score 标准化：

```
x_norm = (x - μ) / σ
```

归一化后均值 0、标准差 1。
