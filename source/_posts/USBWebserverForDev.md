---
title: USBWebserver For Dev
date: 2021-12-04 17:22:55
tags: MySQL
---
## Scene
- 在一台机器上搭建 MySQL 并开放外部使用 
- 常规方式有 （1）直接部署 MySQL （2） 在 Docker 中部署 MySQL
- 以上两种方式有其一定的优势:（1）性能好 （2）容器隔离
- 但是以上两种方式都需要部署成本, 为了寻求更便捷的部署和迁移, 将使用以下方式
<!-- more -->

## Solution
- 利用 可以移植的 USBWebserver => [USBWebserver8](https://usbwebserver.yura.mk.ua/)
```
Most light weight local portable web server with Apache, PHP, MySQL and PHPMyAdmin for Windows on the Web. Just unzip enywhere (including USB flash drive), run and start using.
```

- 部署环境在 win10,解压启动即可
- 设置开机启动，win + r ,`shell:startup`,把启动文件放在该目录即可
- 到此，只能是本地访问，提供给外部访问还需要进去 MySQL 赋予用户权限 
    - ![](/images/USBWebserverForDev/Snipaste_2021-12-04_17-32-09.png)
    - ![](/images/USBWebserverForDev/Snipaste_2021-12-04_17-32-44.png)
    - ![](/images/USBWebserverForDev/Snipaste_2021-12-04_17-33-12.png)
- 最后防火墙开放端口即可