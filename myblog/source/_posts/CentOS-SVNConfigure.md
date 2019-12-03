---
title: 'CentOS:SVN Configure'
date: 2019-06-11 19:36:49
tags: [CentOS,Linux,SVN]
---
 1. `ssh root@xx.xxx.xxx.xxx`   //通过SSH连接服务器
 2. `svn`                      //先查看是否安装了svn
 3. `yum install svn`         //安装svn
 4. `svn --version`          //查看svn版本
 5. 输入`svn`按Tab补全  ; 会出现很多以svn开头的,可以选择使用
 6. `svnadmin create /opt/svn/916213802`      //在根目录下创建SVN仓库
 7. `svnserve -d -r /opt/svn/916213802/`   //启动svn服务
 8. `ps -ef | grep svnserve`   //查看svnserve 是否启动
 <!-- more -->
 9. `netstat -an | grep 3690`   //3690是svn默认端口,查看是否开放
 10. 由于阿里云安全组不开放该端口,所以要去阿里云服务器开启*3690* 端口 
  ![](/images/CentOSSVNConfigure/01.png)
 11. `cd /opt/svn/916213802/conf/`  //进入仓库查看配置文件        
 12. `vim authz`   //设置用户
 ![](/images/CentOSSVNConfigure/02.png)
 13. `vim passwd`  //设置用户和密码
 ![](/images/CentOSSVNConfigure/03.png)
 14. `vim svnserve.conf`  //设置其他参数
 ![](/images/CentOSSVNConfigure/04.png)
 15. `killall svn`   //关闭svn进程也可以在12的基础上`killall pid`
 16. `svnserve -d -r /opt/svn/916213802`  //再次启动svnserve服务
 17. `svn checkout svn://47.107.xxx.xxx/916213802 --username 91621380205 --password 91621380205`  
     //本地连接服务器SVN ,执行后下载svn上的项目到本地当前目录,可不用--username和--password
---
 * `pwd`   //查看当前目录
 * `cd /`  //进入根目录
 * `ls` 查看当前目录下文件
 * `ll` 查看当前目录下文件
 * 执行第*7* 步后,再执行第*17* 步测试连接,如果连接得上就不用操作步骤*8-10* ;
 * 部署项目的话把项目放在本地checkout下来的文件夹里,*同步* 上去就可以了.
 
 