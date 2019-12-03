---
title: Hexo-Install+Migrate
date: 2019-09-19 19:20:12
tags: Hexo
---

### 安装Git,Node

![](/images/Hexo-IM/01.png)

### 安装Hexo

先创建一个文件夹，然后cd到这个目录下

```
npm install -g hexo-cli  //安装
hexo -v   //查看版本
```
![](/images/Hexo-IM/02.png)

<!-- more -->
### 初始化Hexo

```
Hexo init myblog  //任意文件夹名 myblog
```
![](/images/Hexo-IM/03.png)


### 启动服务

进入myblog文件夹 启动服务

```
cd myblog
hexo g
hexo server
```
![](/images/Hexo-IM/04.png)


### 检查页面；迁移设备

在浏览器输入`localhost:4000`,即可看到页面

* 迁移更新设备的话，做到这一步，把原来的博客文件复制到此替换即可

### 连接Github

* 创建Github仓库，命名 `xxx.github.io`

    ![](/images/Hexo-IM/05.png)

* 生成SHH

    ```
    git config --global user.name "yourname"
    git config --global user.email "youremail"
    ```
    ![](/images/Hexo-IM/06.png)
    
    ![](/images/Hexo-IM/07.png)

* 添加SSH到github

    将刚才生成的id_rsa.pub的内容复制到key

    ![](/images/Hexo-IM/08.png)

    检查是否建立连接成功
    
    ![](/images/Hexo-IM/09.png)

### Hexo部署到GitHub

* 修改配置文件 `_config.yml`

    ![](/images/Hexo-IM/10.png)

* 安装deploy-git 部署命令

    `npm install hexo-deployer-git --save`

    常用命令
    ```
    hexo clean      //清除之前生成的东西
    hexo g          //更新      
    hexo d          //部署
    hexo s --debug  //本地调试
    ```