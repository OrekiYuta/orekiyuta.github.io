---
title: Django Run
date: 2021-01-28 20:03:52
tags: [Django,Python]
---


<!-- more -->



## Other
### Error: [WinError 10013] 以一种访问权限不允许的方式做了一个访问套接字的尝试。
``` bash
Starting development server at http://127.0.0.1:8000/
Quit the server with CTRL-BREAK.
Error: [WinError 10013] 以一种访问权限不允许的方式做了一个访问套接字的尝试。
```
- 端口被占用，关闭被占用端口的程序
- `netstat -ano|findstr 8000`
- `tasklist | findstr pid号`
- `taskkill /pid pid号 /f`

![](/images/djangoRun/Snipaste_2021-01-28_20-07-56.png)

- 或者改端口
![](/images/djangoRun/Snipaste_2021-01-28_20-10-41.png)
