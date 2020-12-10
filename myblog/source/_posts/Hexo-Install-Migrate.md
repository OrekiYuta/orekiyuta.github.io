---
title: Hexo-Install+Migrate
date: 2019-09-19 19:20:12
tags: Hexo
---

## <center>安装Git , Node</center>

![](/images/Hexo-IM/01.png)

## <center>安装Hexo</center>

- 先创建一个文件夹，然后cd到这个目录下
- `npm install -g hexo-cli`    安装hexo项目构建工具
- `hexo -v`     查看版本

![](/images/Hexo-IM/02.png)

<!-- more -->
## <center>初始化Hexo</center>

- `Hexo init myblog`    任意文件夹名 myblog

![](/images/Hexo-IM/03.png)


## <center>启动服务</center>

进入myblog文件夹 , 编译生成静态文件 , 启动服务

- `cd myblog`
- `hexo g`
- `hexo server`

![](/images/Hexo-IM/04.png)


## <center>检查页面；迁移设备</center>

在浏览器输入 `localhost:4000` , 即可看到页面

+ 迁移更新设备的话，做到这一步，把原来的博客文件复制到此替换即可

## <center>连接Github</center>

* 创建Github仓库 , 命名 `xxx.github.io`

    ![](/images/Hexo-IM/05.png)

* 生成SSH

    - `git config --global user.name "yourname"`
    - `git config --global user.email "youremail"`
    
    ![](/images/Hexo-IM/06.png)
    
    ![](/images/Hexo-IM/07.png)

* 添加SSH到github

    - 将刚才生成的id_rsa.pub的内容复制到key

        ![](/images/Hexo-IM/08.png)

    - 检查是否建立连接成功
    
        ![](/images/Hexo-IM/09.png)

## <center>Hexo部署到GitHub</center>

* 修改配置文件 `_config.yml`

    ![](/images/Hexo-IM/10.png)

* 安装deploy-git 部署命令

    - `npm install hexo-deployer-git --save`

## <center>常用命令</center>

- `hexo clean`        清除之前编译生成的public文件夹的静态文件
- `hexo g`            编译生成静态文件      
- `hexo d`            部署到远端服务器
- `hexo s --debug`    启动服务并执行本地调试模式