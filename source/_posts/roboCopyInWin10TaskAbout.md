---
title: RoboCopy In Win10 Task About(0x1/0x10)
date: 2021-12-18 18:58:13
tags: [RoboCopy,Windows]
---
## Scene
- RoboCopy bat 脚本添加到 win10 定时任务中
- 出现 上次运行结果为 0x1,0x10

## Solution
- 因为脚本中使用到 网络磁盘 的原因
- 手动执行脚本没问题,但是添加到定时任务就不行
- 原因是在 定时任务 中的网络磁盘账户信息和 本地执行的网络磁盘账户 并不是一致的
- 解决方法:
  1. 在定时任务的 常规-安全选项-选择【只在用户登录时运行】,这样就使用了和本地执行一致的网络磁盘账户信息
  2. 在脚本中添加 网络磁盘账户信息 ` net use j: \\RemoteHost\Files RemotePassword /user:RemoteUser `
<!-- more -->

## Other
- 👉 [计划的Robocopy任务失败，出现0x10错误](https://yo.zgserver.com/robocopy0x10.html)
- 👉 [批处理脚本手动双击可以执行，但计划任务中执行失败](https://blog.csdn.net/u010033674/article/details/115034957)