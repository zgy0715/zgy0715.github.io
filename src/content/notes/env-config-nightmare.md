---
title: 配置 Python 环境的一夜
date: 2026-10-12
tags: [PYTHON, GIT, TOOLS]
summary: venv 没激活就 pip install、Jupyter 选错内核、Git 的 CRLF、GitHub 直连抽风——一个晚上踩完四个坑的完整记录。
---

# 配置 Python 环境的一夜

起因是想在另一台电脑上跑 AI-ML-Learning 的练习代码，按理说 10 分钟的事，结果折腾到半夜。四个坑按时间顺序记录。

## 坑一：venv 没激活就 pip install

PowerShell 里 `python -m venv venv` 建完环境，忘了激活就 `pip install numpy pandas`，装进了全局。后来看 `pip list` 发现实在全局目录才发现。**判断方法**：激活后命令行前面会出现 `(venv)` 前缀，或者 `pip -V` 看 path 是不是在 venv 里。

另外 PowerShell 的激活命令是 `venv\Scripts\Activate.ps1`，和 Linux 的 `source venv/bin/activate` 不一样，第一次执行还报了脚本执行策略错误，需要 `Set-ExecutionPolicy -Scope CurrentUser RemoteSigned`。

## 坑二：pip 默认源超时

`pip install matplotlib` 卡在下载阶段超时两次。换清华镜像解决：

```sh
pip install -i https://pypi.tuna.tsinghua.edu.cn/simple matplotlib
```

然后 `pip config set global.index-url ...` 一劳永逸。这个应该第一天就该配的。

## 坑三：Jupyter 选错内核

装了 jupyter 后新建 notebook，`import numpy` 直接 `ModuleNotFoundError`。明明 pip 装过了！排查半天发现 notebook 右上角的内核还是系统 Python，不是 venv 里的。解法：在 venv 里 `pip install ipykernel`，然后 `python -m ipykernel install --user --name=ml` 注册内核，再切换过去。

## 坑四：Git 的 CRLF 警告

每次提交都刷屏 `warning: LF will be replaced by CRLF`。查了才知道 Windows 的 `core.autocrlf=true` 会在 checkout 时转 CRLF、commit 时转回 LF，仓库里存的其实一直是 LF，**warning 可以无视**。顺手把仓库加了个 `.gitattributes` 的想法记到了待办。

## 顺手记录

这晚还发现 GitHub 直连时断时续（重试 6 次成功 1 次），后来学会了连不上就走 API。结论：环境问题没有一个是难的，但四个叠在一起就是一晚上。写下来，下次 10 分钟搞定。
