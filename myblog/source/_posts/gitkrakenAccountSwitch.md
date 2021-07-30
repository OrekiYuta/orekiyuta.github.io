---
title: Gitkraken Account Switch
date: 2021-07-28 21:43:24
tags: [Git,Github]
---

## Sence
- 使用 Gitkraken GUI 工具,想要切换绑定的 github 账号拉取代码 
- 出现错误提示,无法断开当前 github 账户绑定
- ![](/images/gitkrakenAccountSwitch/Snipaste_2021-07-28_21-50-19.png)

<!--more-->

## Solution
- 经过一顿排查,查阅官网文档终于找到答案 
- 👉[How can I use multiple GitHub / GitLab / Bitbucket / Azure DevOps accounts with GitKraken?](https://support.gitkraken.com/faq/)

- ![](/images/gitkrakenAccountSwitch/Snipaste_2021-07-28_21-54-00.png)

- 定位到是 Gitkraken 软件版本的问题,即 Pro 版本才能自由切换账户绑定
- 可知 Gitkraken 在 6.5.1 之前是完全开源免费的,安装 6.5.1 版本即可
    - 在安装之前修改下 hosts 文件
    - 添加`0.0.0.0 release.gitkraken.com` 防止被动更新最新版本
- 更换版本后即可自由切换 github 账户绑定
- ![](/images/gitkrakenAccountSwitch/Snipaste_2021-07-28_21-56-01.png)

