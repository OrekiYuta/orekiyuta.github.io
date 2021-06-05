---
title: Set up Seafile
date: 2021-06-03 21:15:37
tags: [Linux,Windows]
---

## Linux Server
- `yum install docker-compose -y`
- 编写 docker-compose.yml 
- `docker-compose up -d`
- 进入 `http://<您的 IP 地址>:8000` 
- 右上角 System Admin -> Settings 更改 url 为该机器地址
- 👉 [docker-compose.yml](https://github.com/OrekiYuta/Gear/blob/master/Seafile/linux/docker-compose.yml)
-👉 [用 Docker 部署 Seafile 服务](https://cloud.seafile.com/published/seafile-manual-cn/docker/%E7%94%A8Docker%E9%83%A8%E7%BD%B2Seafile.md)
<!-- more -->
##  Windows Server
- 强制要 Python 2.7.11 32位环境
- 下载解压 Seafile 文件
- 启动目录下的 run.bat
- 选择存储位置
- 添加管理员账号
- 进入 `http://<您的 IP 地址>:8000` 
- 右上角 System Admin -> Settings 更改 127.0.0.1 为该机器 ip
- 👉[seafile-server_6.0.7_win32.tar.gz](https://github.com/OrekiYuta/Gear/tree/master/Seafile/win)
- 👉 [Windows 版 Seafile 服务器](https://cloud.seafile.com/published/seafile-manual-cn/deploy_windows/download_and_setup_seafile_windows_server.md)

## Other
### Docker Compose ERROR network has active endpoints
- 删除 container 和 image 之后重新部署不成功
- 因为之前的 network 没删除仍然存在
- 方法一：重启 docker `sudo service docker restart`
- 方法二：删除网络
- ```
    docker network ls
    docker network inspect [网络ID]
    docker network disconnet -f [网络ID] [容器Name]
  ```
- ![](/images/setupSeafile/Snipaste_2021-06-04_21-34-14.png)
- ![](/images/setupSeafile/Snipaste_2021-06-04_21-36-54.png)
- ![](/images/setupSeafile/Snipaste_2021-06-04_21-38-04.png)