---
title: SecurityGroup On TencentCVM
date: 2021-12-04 17:44:09
tags: CloudServer
---
## Scene
- 在云服务器上部署了服务，开放端口配置注意点
<!-- more -->

## Solution
- 以下为 腾讯云CVM 为例说明
1. 先找到自己的机器,并找到安全组选项,并新建一个随意的安全组
    - ![](/images/securityGroupOnTencentCVM/Snipaste_2021-12-04_17-51-56.png)
0. 新建完后,点击修改规则
    - ![](/images/securityGroupOnTencentCVM/Snipaste_2021-12-04_17-53-32.png)
0. 让外部访问,设置入站规则即可
    - ![](/images/securityGroupOnTencentCVM/Snipaste_2021-12-04_17-56-04.png)
    - ![](/images/securityGroupOnTencentCVM/Snipaste_2021-12-04_17-56-52.png)
0. 最后设置一下,关联实例，把需要开放以上规则的机器配置上
    Snipaste_2021-12-04_17-57-56.png

- 以下为机器内的服务的启动配置说明
1. 正常操作了以上的步骤,端口即是正常开放了,
    - telnet 能否连通,还需要机器内的端口监听正确

0. 比如以下情况,在外部是 telnet 不通的
    - ![](/images/securityGroupOnTencentCVM/Snipaste_2021-12-04_18-03-22.png)
    - 因为服务监听的是机器内本地(127.0.0.1)的端口，没法响应外部(0.0.0.0)请求
    - 上图的服务,限制了只有来源IP为127.0.0.1才可以访问，其他IP无法访问，因此是无法telnet成功

0. 正确的方式是把服务启动修改为0.0.0.0，允许所有IP即可
0. 或者保持以上的本地监听(127.0.0.1),再配置 Nginx,通过Nginx代理监听


