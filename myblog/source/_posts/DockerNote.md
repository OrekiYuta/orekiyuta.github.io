---
title: Docker Note
date: 2019-12-18 22:59:00
tags: Docker
---

### <center>常用命令</center>

- `docker version`
- `systemctl start docker`

#### 镜像
- `docker image ls`
- `docker image rm [imageName]`
- `docker image pull [imageName]`
- `docker inspect [imageName]` 获取元数据

#### 容器
- `docker container run [imageName]`
- `docker container run -it [imageName] bash`
- `docker container kill [containerID]` id不用填完整 , 能够唯一定位到即可
- `docker container ls`
- `docker container ls --all`
- `docker container rm [containerID]`
- `docker container stop [containerID]`  //container 可省略
- `docker container start [containerID]`
- `docker container logs [containerID]`
- `docker container exec -it [containerID] /bin/bash`
- `docker container inspect [containerID/Name]`

<!-- more -->
### <center>Dockerfile</center>

#### .dockerignore 
忽略内容 , 和 git 的 .gitignore 一个意思
```
node_modules
npm-debug.log
```

#### Dockerfile
```
FROM node:8.4
COPY . /app
WORKDIR /app
RUN npm install --registry=https://registry.npm.taobao.org
EXPOSE 3000
```
- FROM node:8.4：该 image 文件继承官方的 node image，冒号表示标签，这里标签是8.4，即8.4版本的 node
- COPY . /app：将当前目录下的所有文件（除了.dockerignore排除的路径），都拷贝进入 image 文件的/app目录
- WORKDIR /app：指定接下来的工作路径为/app
- RUN npm install：在/app目录下，运行npm install命令安装依赖。注意，安装后所有的依赖，都将打包进入 image 文件
- EXPOSE 3000：将容器 3000 端口暴露出来， 允许外部连接这个端口
- `.` 👉[镜像构建上下文](https://yeasy.gitbooks.io/docker_practice/content/image/build.html)

#### 创建 image 镜像

- `docker image build -t [name] .`
- `docker image build -t [name]:0.0.1 .`
- `.` 表示**上下文路径**
- `-t` 指定名称

#### 生成容器

- `docker container run -p 2222:3333 -it [name] /bin/bash`
- `docker container run -p 2222:3333 -it [name]:0.0.1 /bin/bash`
- `-p` 映射端口 , 本机:容器 { **127.0.0.1:2222:3333** / **[ip]:2222:3333** / **[不填]2222:3333** 默认为 **0.0.0.0:2222:3333** } 
- `-it` 容器的 Shell 映射到当前的 Shell，在本机窗口输入的命令，就会传入容器
- `/bin/bash` 启动容器内 bash












### <center>Docker Compose</center>

- `docker-compose --version`
-  docker-compose.yml
    ```
    mysql:
        image: mysql:5.7
        environment:
        - MYSQL_ROOT_PASSWORD=123456
        - MYSQL_DATABASE=wordpress
    web:
        image: wordpress
        links:
        - mysql
        environment:
        - WORDPRESS_DB_PASSWORD=123456
        ports:
        - "127.0.0.3:8080:80"
        working_dir: /var/www/html
        volumes:
        - wordpress:/var/www/html
    ```
- `docker-compose up`
- `docker-compose stop`
- `docker-compose rm`

### <center>修改镜像源</center>

- 在阿里云找到镜像加速器

    ![](/images/DockerNote/01.png)

- 在服务器 `/etc/docker` 下 , 新建 daemon.json , 添加镜像地址

    ```json
    {
        "registry-mirrors": ["https://0f2b6859.mirror.aliyuncs.com"]
    }
    ```

    ![](/images/DockerNote/02.png)

### 参考内容
- [Docker](https://docs.docker.com/get-started/part2/)
- [Docker — 从入门到实践](https://yeasy.gitbooks.io/docker_practice/content/)
- [Docker 入门教程](https://www.ruanyifeng.com/blog/2018/02/docker-tutorial.html)