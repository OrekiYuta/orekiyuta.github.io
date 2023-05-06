---
title: Use ArchiveBox For Daily
date: 2021-12-12 03:20:46
tags: [ArchiveBox,Docker]
---
## Sence
- 由于经常发现一些站点或文章很不错,每次都只是手动保存链接
- 偶尔回头看的话,原本保存的链接的站点或文章已经消失了
- 所以需要一个服务在保存站点链接的时候,把站点抓取保存成文件
- 这样日后翻看就很方便
<!--more-->

## Solution
- ArchiveBox 可以很好的满足这个日常的需求 👉 [ArchiveBox](https://archivebox.io/)
  
### Easy Setup With Docker
- 切换到非 root 账户下安装
- `mkdir ~/archivebox && cd ~/archivebox` ## 创建目录
- `docker run -v $PWD:/data -it archivebox/archivebox init --setup` # 初始化
- `docker run -v $PWD:/data -p 8000:8000 archivebox/archivebox` # 启动容器
![](/images/useArchiveBoxForDaily/Snipaste_2021-12-12_03-21-47.png)

### Account About
- 登录后台需要修改下默认密码
- `docker exec -it [容器id] /bin/bash` 进入容器
- ArchiveBox 修改用户信息需要在非 root 账户下
- 进入容器后默认的是 root 用户,需要创建新用户
  - `useradd -d /home/elias elias`
  - `passwd elias`
- `su elias` 接着切换用户执行操作
- `archivebox manage changepassword USERNAME` 修改账户密码
- `archivebox manage changepassword admin` 修改默认的 admin 密码
![](/images/useArchiveBoxForDaily/Snipaste_2021-12-12_03-21-24.png)

## Other 
- 容器里需要给目录赋权限
```
$ archivebox manage changepassword USERNAME
[i] [2021-12-11 19:17:32] ArchiveBox v0.6.2: archivebox manage changepassword USERNAME
    > /data

Traceback (most recent call last):
  File "/usr/local/lib/python3.9/logging/config.py", line 564, in configure
    handler = self.configure_handler(handlers[name])
  File "/usr/local/lib/python3.9/logging/config.py", line 745, in configure_handler
    result = factory(**kwargs)
  File "/usr/local/lib/python3.9/logging/handlers.py", line 153, in __init__
    BaseRotatingHandler.__init__(self, filename, mode, encoding=encoding,
  File "/usr/local/lib/python3.9/logging/handlers.py", line 58, in __init__
    logging.FileHandler.__init__(self, filename, mode=mode,
  File "/usr/local/lib/python3.9/logging/__init__.py", line 1146, in __init__
    StreamHandler.__init__(self, self._open())
  File "/usr/local/lib/python3.9/logging/__init__.py", line 1175, in _open
    return open(self.baseFilename, self.mode, encoding=self.encoding,
PermissionError: [Errno 13] Permission denied: '/data/logs/errors.log'
```
- 切换到 root 账户, 到 `/data` 目录下 
- `chmod -R 777 ./` 给 data 目录下所有文件赋予权限
  