---
title: GitHub 直连抽风时的三种部署兜底
date: 2026-10-15
updated: 2026-10-15
tags: [GITHUB, GIT, DEPLOYMENT]
summary: 这个网站部署在 GitHub Pages 上，而 GitHub 直连时好时坏。记录三种真实用过的兜底方案：重试、Git Data API、Pages 模式修复。
---

# GitHub 直连抽风时的三种部署兜底

这个网站部署在 GitHub Pages（zgy0715.github.io），而 GitHub 的直连在本地网络下时好时坏：有时一次成功，有时连续八次 `Connection was reset`。这几天真实用过的三个方案，按复杂度排序。

## 方案一：无脑重试

最朴素的方案，经常就够了：

```sh
git -c http.version=HTTP/1.1 push origin main
```

- `http.version=HTTP/1.1` 必须加：HTTP/2 在这条网络路径下会报 `Error in the HTTP2 framing layer`
- 失败就等几秒重试。实测有次第 6 次才成功，也有一天里连续 8 次全挂的

## 方案二：Git Data API 兜底

`github.com` 完全连不上时，`api.github.com` 往往还活着。多文件改动可以用 Git Data API 走一遍等价的提交流程：

1. `GET /repos/{owner}/{repo}/git/ref/heads/main` 拿基线 commit
2. 每个文件 `POST /git/blobs`（内容 base64）
3. `POST /git/trees`（带 `base_tree`，只列变更文件）
4. `POST /git/commits`（tree + parent）
5. `PATCH /git/refs/heads/main` 指到新 commit

一次原子提交多个文件，效果和 `git push` 等价。本地仓库之后 `git pull --rebase` 一次，内容相同的提交会被自动去重。

**踩过的坑**：从 GET 响应里提取 blob sha 时，用 `sed 's/[^a-f0-9]//g'` 清洗整行会把 `"sha"` 这个词里的字母 a 也留下来，导致 sha 多一位、API 报 `does not match`。要用 `"sha": "[a-f0-9]{40}"` 这种精确匹配。

## 方案三：修复 Pages 构建模式

有一次线上突然变成 Jekyll 渲染的 README 页。查 API 发现 `GET /repos/{owner}/{repo}/pages` 里 `build_type` 变成了 `legacy`（分支模式），一次提交触发了 Jekyll 构建，把 Actions 部署的正式版覆盖了。修复：

```sh
PUT /repos/{owner}/{repo}/pages   {"build_type": "workflow"}
POST /repos/{owner}/{repo}/actions/workflows/deploy.yml/dispatches {"ref": "main"}
```

两个 204 之后等一分半，线上恢复。**教训**：线上内容突然"变旧"，先查 Pages 的 build_type。

## 目前的状态

三个方案都真实跑通过。这个网站从 10 月 14 日到现在（写这篇时）经历了：改版重写、双语化、太阳系面板、内容扩充——每一版都是这么发上去的。
