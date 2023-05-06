---
title: CentOS8 About Docker
date: 2021-12-12 03:03:25
tags: [CentOS,Docker,Podman]
---
## Sence
- 安装 ArchiveBox 遇到了一些问题
- 由于是用 Docker 安装的, 容器启动失败
```shell
    Emulate Docker CLI using podman. Create /etc/containers/nodocker to quiet msg.
    ERRO[0001] unable to get systemd connection to add healthchecks: dial unix /tmp/podman-run-1003/systemd/private: connect: connection refused
    ERRO[0001] unable to get systemd connection to start healthchecks: dial unix /tmp/podman-run-1003/systemd/private: connect: connection refused
    4
```
<!--more-->

## Solution
- 查了一下发现在 CentOS8 里直接使用 `yum install docker -y` ,安装的是 podman-docker
- 虽说命令兼,但是有些问题,所以把它卸了重新装 Docker
- `yum remove docker` 卸载当前装的 podman
- `curl https://download.docker.com/linux/centos/docker-ce.repo -o /etc/yum.repos.d/docker-ce.repo` 下载 docker-ce 源
- `yum install docker-ce -y` 安装 docker-ce


## Other
### docker: Cannot connect to the Docker daemon at unix:///var/run/docker.sock. Is the docker daemon running?.
- 添加用户到 docker 组
- `gpasswd -a $USER docker` root用户下添加当前登录用户(root)到 docker 组
- `gpasswd -a elias docker` root用户下添加 elias 用户到 docker 组
- `systemctl restart docker` 重启 docker 
