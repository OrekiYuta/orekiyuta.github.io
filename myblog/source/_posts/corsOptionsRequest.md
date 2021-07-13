---
title: CORS Options Request
date: 2021-07-12 23:47:18
tags:
---

## Sence
- 在查看网络请求的时候发现一个动作发送了两次请求
- ![](/images/Snipaste_2021-07-12_23-48-42.png)
- ![](/images/Snipaste_2021-07-12_23-51-22.png)
- ![](/images/Snipaste_2021-07-12_23-51-39.png)
- 查了一下，得知原因是以为 跨域非简单请求在真正的请求之前，需要先发送一次 OPTIONS 预请求


## Other
- 👉 [跨源资源共享（CORS）](https://developer.mozilla.org/zh-CN/docs/Web/HTTP/CORS)
- 👉 [http请求发生两次（原来是options请求）](https://juejin.cn/post/6850037275708817422)
- 👉 [跨域资源共享 CORS 详解](http://www.ruanyifeng.com/blog/2016/04/cors.html)