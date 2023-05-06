---
title: Apache Log4j2 Fixbug
date: 2021-12-11 22:25:22
tags: [Java,SRC]
---
## Sence

- Apache Log4j 2.x < 2.15.0 存在远程代码执行
- 结合了 JNDI , 本地利用 Log4j2 构造函数, 调用远程服务端 Log4j2 的函数,导致本地函数可以注入远程服务端代码
- 详细 👉[【漏洞预警】Apache Log4j2 远程代码执行漏洞（CVE-2021-44228）](https://help.aliyun.com/noticelist/articleid/1060971232.html)
<!--more-->

## Solution
- 到 maven 官方仓库下载最新修复该漏洞的 jar 👉 [org/apache/logging/log4j](https://repo.maven.apache.org/maven2/org/apache/logging/log4j/) 
- 在官方站点可查看哪些 jar 引用了 涉及该漏洞版本的log4j2 jar , 如 👉 [mvnrepository/Artifacts using log4j-core version 2.14.1](https://mvnrepository.com/artifact/org.apache.logging.log4j/log4j-core/2.14.1/usages) 
- 在项目里替换一下 已修复漏洞的 jar 的引用即可



