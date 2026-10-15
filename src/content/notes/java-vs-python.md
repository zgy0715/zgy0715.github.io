---
title: 从 Python 切回 Java，手感全无
date: 2026-09-20
tags: [JAVA, PYTHON, OOP]
summary: 写了三个月 Python 再回 Java 课，连 ArrayList<Integer> 都要愣一下。记录两种语言切换时的真实摩擦。
---

# 从 Python 切回 Java，手感全无

暑假三个月基本在写 Python（爬数据、跑练习、做小工具），这周 Java 课恢复，打开 IDE 的第一反应：这些红线是什么。

## 具体的不适应

- **写完变量名才发现没声明类型**——Python 里 `x = 1` 顺手就写了，Java 要先想好 `int` 还是 `double`
- **`ArrayList<Integer>` 泛型**：想往列表里放 `int`，写了 `list.add(1)` 才想起没有自动装箱就不行，反射弧长了半秒
- **每个类一个文件**：Python 习惯一个文件堆到底，Java 的 public 类必须和文件同名，被编译器教育了两次
- **分号**。真的会忘。

## 但有一说一

重新上手半天之后，反而体会到 Java 好的一面：

- IDE 的补全和重构在强类型下好用得多——Python 里改个函数名要全文搜索祈祷，Java 里直接 rename 一路绿灯
- 课设要写多人协作的图书馆系统，接口先定义清楚再分工，比 Python 里"约好函数签名"靠谱

## 结论

Python 让我写得快，Java 让我写得稳。两个都要会，切换时的手感摩擦只能靠多切几次磨平。课设过程里值得记的点（事务、日期边界、三层结构）另开一篇。
