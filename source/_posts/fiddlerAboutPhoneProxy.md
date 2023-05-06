---
title: Fiddler About Phone Proxy
date: 2021-12-20 22:13:40
tags: [Fiddler,Proxy]
---

## Scene
- Fiddler 手机抓包的一些设置
- 通过 Fiddler 获取手机应用的网络请求数据
- 不通端网络的设置方式

<!-- more -->
## Solution
### 外部网络 / Fiddler 宿主机网络
- 手机和 Fiddler 宿主机连接在同一个外部网络中
- Fiddler 宿主机连接外部网络,然后宿主机开放热点, 手机连接该热点
1. 然后在手机的 WLAN 连接里配置宿主机上 Fiddler 的代理地址和端口
   - ![](/images/fiddlerAboutPhoneProxy/Screenshot_2021-12-20-22-31-01-945_com.android.se.jpg)
0. 连上后,手机浏览器打开该 代理地址和端口 下载证书
0. 最后打开手机应用,即可在 Fiddler 里看到网络数据了 

### 手机共享网络
- 手机通过开启热点,把移动网络分享出来,然后宿主机连接该网络
1. 打开手机移动网络设置,找到 APN , 设置代理地址和端口为宿主机上 Fiddler 的代理地址和端口
   - ![](/images/fiddlerAboutPhoneProxy/Screenshot_2021-12-20-22-36-09-186_com.android.ph.jpg)
   - ![](/images/fiddlerAboutPhoneProxy/Screenshot_2021-12-20-22-36-22-323_com.android.se.jpg)
   - ![](/images/fiddlerAboutPhoneProxy/Screenshot_2021-12-20-22-36-43-946_com.android.se.jpg)
0. 最后打开手机应用,同样的可以在 Fiddler 里看到网络请求包了

## Other
- Fiddler 抓包的常规配置开启
- ![](/images/fiddlerAboutPhoneProxy/Snipaste_2021-12-20_22-05-08.png)
- ![](/images/fiddlerAboutPhoneProxy/Snipaste_2021-12-20_22-07-17.png)
- 下图右上角查看该代理地址信息
- ![](/images/fiddlerAboutPhoneProxy/Snipaste_2021-12-20_22-07-49.png)
  


