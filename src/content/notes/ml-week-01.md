---
title: 机器学习第一周：从 Python 到线性回归
date: 2026-10-10
tags: [PYTHON, MACHINE LEARNING, NUMPY]
summary: AI-ML-Learning 仓库的第一周：补 NumPy、手写第一个线性回归，以及被广播机制背刺的下午。
---

# 机器学习第一周：从 Python 到线性回归

这周正式开始在 [AI-ML-Learning](https://github.com/zgy0715/AI-ML-Learning) 仓库里记录学习。

## 补 NumPy 的正确姿势

一开始想从头刷完 NumPy 文档，两天后就放弃了——太枯燥。改成"用到再查"：写线性回归需要什么就查什么，反而快。目前用得最多的三个：

- `np.array` / 形状操作 `reshape`
- 广播机制（见下面的坑）
- `np.linalg` 里的矩阵运算

## 手写线性回归

梯度下降的公式看懂不难，难的是向量化实现。第一版我用了双重 for 循环，跑得慢还被提醒"这不叫机器学习工程"。向量化之后：

```python
pred = X @ w + b
error = pred - y
grad_w = (X.T @ error) / m
w = w - lr * grad_w
```

四行搞定，运行快了一个数量级。

## 被广播机制背刺的下午

`X` 形状是 `(m, n)`，我拿一个 `(n,)` 的向量直接相减，报错才想起来广播规则：`(m, n) - (n,)` 会把后者当成 `(1, n)` 复制 m 份——这是我想要的；但如果哪天向量形状是 `(m, 1)`，就会静默广播成 `(m, n)`，结果全错还不报错。

**教训**：涉及矩阵运算时先 `print(arr.shape)`，不要信肉眼。

## 下周计划

- 逻辑回归 + 交叉熵损失
- 用 matplotlib 把决策边界画出来
