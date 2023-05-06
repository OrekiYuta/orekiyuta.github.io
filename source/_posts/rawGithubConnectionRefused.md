---
title: Raw Github Connection Refused
date: 2021-12-11 17:38:53
tags: Github
---
## Sence
```shell
    root@raspberrypi /h/pi# curl -sSL 'https://get.archivebox.io' | sh
    curl: (7) Failed to connect to raw.githubusercontent.com port 443: Connection refused
    root@raspberrypi /h/pi# ping raw.githubusercontent.com
    PING raw.githubusercontent.com (127.0.0.1) 56(84) bytes of data.
    64 bytes from localhost (127.0.0.1): icmp_seq=1 ttl=64 time=0.180 ms
    64 bytes from localhost (127.0.0.1): icmp_seq=2 ttl=64 time=0.156 ms
    64 bytes from localhost (127.0.0.1): icmp_seq=3 ttl=64 time=0.114 ms
    64 bytes from localhost (127.0.0.1): icmp_seq=4 ttl=64 time=0.118 ms
    64 bytes from localhost (127.0.0.1): icmp_seq=5 ttl=64 time=0.102 ms
    64 bytes from localhost (127.0.0.1): icmp_seq=6 ttl=64 time=0.105 ms
    64 bytes from localhost (127.0.0.1): icmp_seq=7 ttl=64 time=0.128 ms
    ^C
    --- raw.githubusercontent.com ping statistics ---
    7 packets transmitted, 7 received, 0% packet loss, time 234ms
    rtt min/avg/max/mdev = 0.102/0.129/0.180/0.026 ms
    root@raspberrypi /h/pi#
```
- 由上可知,由于 DNS 污染问题, raw.githubusercontent.com 经常访问不了

<!--more-->
## Solution
- 打开 [ipaddress](https://www.ipaddress.com/) , 输入 `raw.githubusercontent.com` 查看目前 DNS 解析到的 IP
- 如 [ipaddress](https://ipaddress.com/website/raw.githubusercontent.com) ,翻看可见解析到的 IP
- 最后在机器上配置 hosts 解析即可, 刷 DNS 缓存
```shell
185.199.108.133 raw.githubusercontent.com
185.199.109.133 raw.githubusercontent.com
185.199.110.133 raw.githubusercontent.com
185.199.111.133 raw.githubusercontent.com
```

## Other
- on pi 重启网络
```
pi@raspberrypi ~> /etc/init.d/networking restart
[....] Restarting networking (via systemctl): networking.service==== AUTHENTICATING FOR org.freedesktop.systemd1.manage-units ===
Authentication is required to restart 'networking.service'.
Authenticating as: ,,, (pi)
Password:
==== AUTHENTICATION COMPLETE ===
. ok 
```
- 使用工具刷新 DNS
    - `sudo apt-get install nscd`
    - `sudo /etc/init.d/nscd restart`
- 改变机器 DNS 解析服务器 `sudo nano /etc/resolv.conf`
    - `nameserver 8.8.8.8` 修改
