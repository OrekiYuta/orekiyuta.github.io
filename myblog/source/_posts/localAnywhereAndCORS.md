---
title: Local-anywhere and CORS
date: 2021-01-20 01:36:34
tags: CORS
---

## Scene
- 打开一个 html 加载了本地目录下的文件居然跨域了，原因在于本地文件的使用的是 file 协议
- CORS 策略只支持这些协议：http、data、 chrome、chrome-extension 以及 https
- 这样的话，可以直接转个协议就好了

## Solution
- 起个协议服务
- `npm i anywhere -g` 安装 anywhere
- `anywhere -h` 在文件目录启动服务