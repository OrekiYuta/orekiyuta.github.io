---
title: I got a Raspberry Pi
date: 2020-12-11 22:34:39
tags: [RaspberryPi,Linux]
---

## 通过网络分享连接树莓派
- 确保一台能上网的主机
- 把已经连接的网络通过想要共享的形式共享出去
- ![](/images/IgotaRaspberryPi/Snipaste_2020-12-11_22-49-28.png)
- 开启共享前后的本机 ipv4
- ![](/images/IgotaRaspberryPi/Snipaste_2020-12-11_23-03-18.png)

<!-- more -->

- 开启共享前后的局域网内 ip 变化
    - 我这里之前是连接过了,有缓存记录了，未连接过的情况下，新分配的 ip 就是新连接的设备所属 ip
- ![](/images/IgotaRaspberryPi/Snipaste_2020-12-11_23-06-54.png)
- 然后通过 SSH 连接树莓派即可
    - 树莓派默认用户名 pi , 密码 raspberry
- ![](/images/IgotaRaspberryPi/Snipaste_2020-12-11_23-10-14.png)

## 查看树莓派基本信息
- `pinout` 查看针脚等基本硬件信息
- ![](/images/IgotaRaspberryPi/Snipaste_2020-12-12_03-05-18.png)
- `vcgencmd measure_temp` 查看 cpu 温度
- `cat /proc/cpuinfo` 查看 cpu 信息
- `lscpu`
- ![](/images/IgotaRaspberryPi/Snipaste_2020-12-12_02-29-37.png)
- `free -h` 查看内存
- `lsblk` 查看磁盘
- `df -hT`
- `date` 查看时间
- `cat /proc/device-tree/model` 查看树莓派型号
- `getconf LONG_BIT` 查看树莓派系统位数
- `file /bin/ls`
- ![](/images/IgotaRaspberryPi/Snipaste_2020-12-12_02-39-09.png)
- `lsusb` 查看 usb
- `lsmod` 查看其他硬件
- ![](/images/IgotaRaspberryPi/Snipaste_2020-12-12_02-41-36.png)
- `vcgencmd get_config arm_freq` 查看 CPU 的时钟频率
- `cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq`
- ![](/images/IgotaRaspberryPi/Snipaste_2020-12-12_02-42-21.png)
- `dmesg | more` 查看更多硬件信息

- `ifconfig` 查看 ip 
- ![](/images/IgotaRaspberryPi/Snipaste_2020-12-12_02-45-49.png)

- `sudo ifconfig wlan0 down` 关闭 wlan
- `sudo ifconfig wlan0 up`
- ![](/images/IgotaRaspberryPi/Snipaste_2020-12-12_02-49-22.png)

## Windows 远程桌面连接
- `sudo apt-get purge tightvnc xrdp` 先删除之前系统自带的 xrdp 和 tightvnc
- `sudo apt-get install tightvncserver xrdp` 重新安装
- `sudo apt update && sudo apt upgrade` 如果有错误可以执行这个

- 然后 Win+r , 输入 mstsc 
- 接着在远程桌面连接窗口输入 树莓派 ip , 账户密码

## 开启 SSH 

### 已连接树莓派
- `sudo raspi-config`
- interfacing Options

### 未连接树莓派
- 在内存卡根目录新建 SSH 文件,无后缀

<!-- ## 设置静态 IP
-`sudo nano /etc.dhcpcd.conf`
- ![](/images/IgotaRaspberryPi/Snipaste_2020-12-14_21-53-29.png)
- 修改完毕，ctrl+x ， y 保存 
- `sudo reboot` 重启树莓派，再次 ifconfig 查看 ip -->

### 设置 mariadb 远程连接

- [树莓派4 官方系统 安装mysql](https://www.jianshu.com/p/f440099f056d)
- [解决MariaDB无法远程连接](https://blog.csdn.net/Co_zy/article/details/73923962)

### 开启远程 FTP

- [FTP连接树莓派（Linux）进行文件传输](https://blog.csdn.net/madrabbit1987/article/details/53750272)