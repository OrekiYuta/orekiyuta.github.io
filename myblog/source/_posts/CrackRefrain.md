---
title: CrackRefrain
date: 2019-05-28 11:15:44
tags: Crack
---
#### 思路
1. 在局域网内先扫描端口
2. 看开启了哪些服务
3. 搜索看哪些服务可以利用(window smb ,数据库)
4. 尝试破解,漏洞不需要
5. 进入成功.执行命令操作

<!-- more -->
#### MySQL
1. 登录 `mysql -h#ip地址# -u#用户名# -p#密码#`
2. 自己的 `mysql -u#root(默认)# -p密码`
3. `select * from mysql.user;` 查询系统用户表
4. 由于host='localhost',所以别人连不进来; 修改host='%',就是所有人都可以连进来;
    `update mysql.user set host='%' where  user='root';`
5. 修改完毕后 刷新 `flsuh privileges;`
6. 可以重新登录mysql 查看修改后情况

7. 查看任务进程 `tasklist`
8. 关闭任务进程 `taskkill /f /pid #pid号#`
9. 启动mysql服务 `net start mysql` 停止mysql服务 `net stop mysql`

10. 进去别人的MySQL 首先看下数据库`show databases;`
11. 选择数据库 use xxx; 
12. 看下表 show tables;
13. 执行表操作 select * from xxx;