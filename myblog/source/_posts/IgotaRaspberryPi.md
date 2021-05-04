---
title: I got a Raspberry Pi
date: 2020-12-11 22:34:39
tags: [RaspberryPi,Linux,Nginx]
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

## 设置 mariadb 远程连接

👉 [树莓派4 官方系统 安装mysql](https://www.jianshu.com/p/f440099f056d)
👉 [解决MariaDB无法远程连接](https://blog.csdn.net/Co_zy/article/details/73923962)

## 开启远程 FTP
- `sudo apt-get install vsftpd`
- `sudo service vsftpd start`
- `sudo nano /etc/vsftpd.conf` 赋予上传权限 "write_enable=YES"
- `sudo /etc/init.d/vsftpd restart`

👉 [FTP连接树莓派（Linux）进行文件传输](https://blog.csdn.net/madrabbit1987/article/details/53750272)

## 树莓派磁盘没有占满整个 SD 卡

- `df -h`
- ![](/images/IgotaRaspberryPi/Snipaste_2020-12-24_14-44-40.png)
- `sudo fdisk -l`
- ![](/images/IgotaRaspberryPi/Snipaste_2020-12-24_14-45-17.png)
- 看到了 SD 卡的磁盘空间
- `sudo fdisk /dev/mmcblk0`
- ![](/images/IgotaRaspberryPi/Snipaste_2020-12-24_14-56-29.png)
- `sudo reboot`
- `sudo resize2fs /dev/mmcblk0p2` 更新硬盘大小
- `df -h`
- 上面操作不行的话就切换到管理员用户 `sudo su`,再试一次
- ![](/images/IgotaRaspberryPi/Snipaste_2020-12-24_15-36-11.png)


👉 [解决树莓派磁盘没有占满整个sd卡的方法](https://blog.csdn.net/ourkix/article/details/109445090)
👉 [充分使用树莓派SD卡容量](https://blog.csdn.net/ls0111/article/details/85607792?utm_medium=distribute.pc_relevant.none-task-blog-BlogCommendFromMachineLearnPai2-2.control&depth_1-utm_source=distribute.pc_relevant.none-task-blog-BlogCommendFromMachineLearnPai2-2.control)

## 修正时间
- `date`
- `sudo dpkg-reconfigure tzdata` 选择时区
- `sudo date  --s="2019-11-27 14:54:00"` 强制手动修正

## 离线安装 Redis 
- 下载 arm 架构的安装包
- ftp 到树莓派里
- ```
  tar xzf 4.0-rc2.tar.gz
  cd redis-4.0-rc2
  make
  make install 
  redis-server
  ```
👉 [Redis编译安装及卸载方法](https://www.lxx1.com/2532)

## 设置 Redis 远程连接
- 我这里是修改了 Redis 压缩包解压后的文件里面的 redis.conf
- 进入解压后的 Redis 文件目录下 读取该目录下的配置启动 Redis
- `redis-server redis.conf` redis 启动后,到本地测试连接
- ![](/images/IgotaRaspberryPi/Snipaste_2020-12-25_15-06-33.png)
- 再用可视化客户端测试一下
- ![](/images/IgotaRaspberryPi/Snipaste_2020-12-25_15-28-39.png)
👉 [redis设置远程连接](https://www.cnblogs.com/liuxiutianxia/p/11057120.html)

## Linux 切换用户
- `sudo su` 切换成 root
- `su [username]` 切换成其他用户,如:`sudo pi`
- 👉 [初次使用树莓派并启用root管理员](https://blog.csdn.net/farYang/article/details/50779767)

## 不同网段问题
- 当前内网的网段为 172 
- 而新接入的交换机和树莓派的网段为 192 
- 需要在网络连接的以太网 ipv4 里设置 192 网段 , 如 192.168.137.1 来访问树莓派
- 切换回内网需要切换为 172 网段 或者 设置自动获取ip

## 离线安装 pip 包
- `pip3 freeze >requirements.txt` 在已安装好包的设备上导出依赖列表
- `pip3 download -r requirements.txt -d -d E:\a\`  下载到对应目录
- 用 FTP 把包传到离线的设备上
- `pip3 install ./*` 进入包目录安装全部或者选择安装


## 查看 apt-get 已安装的程序
- `dpkg --get-selections | grep nginx`
- `dpkg -i | grep '^ii'`
- `sudo apt-get install aptitude` 或者使用这个工具
- `sudo aptitude`

## Nginx 无法正常工作相关

- 树莓派上 apt-get 安装的 nginx 的默认配置文件内容很少，从其他设备安装 nginx 然后把配置文件复制过来
- 主要配置就是把通过默认nginx 80 端口的请求转发到自己定义的 upstream 里
- 添加多个服务，配置权重就可以实现负载均衡，就是请求一个地址，按照权重轮询服务
```nginx
    upstream hgo {

        server 127.0.0.1:5000 weight=10;
        server 127.0.0.1:2021 weight=10;
    }

    server {
        listen       80 default_server;
        listen       [::]:80 default_server;
        server_name  _;
        root         /usr/share/nginx/html;

        # Load configuration files for the default server block.
        include /etc/nginx/default.d/*.conf;

        location / {
                proxy_pass http://hgo;
        }

        error_page 404 /404.html;
        location = /404.html {
        }

        error_page 500 502 503 504 /50x.html;
        location = /50x.html {
        }
```
- ![](/images/IgotaRaspberryPi/Snipaste_2021-01-06_20-58-26.png)

- `nginx` 启动
- `nginx -s reopen`重启
- `nginx -s reload` 热加载
- `nginx -t` 检查配置文件是否合法
- `nano /etc/nginx/nginx.conf` 我的树莓派 nginx 配置文件地址
- `nano /etc/nginx/sites-available/default` 这里也有个配置文件
- 👉 [linux彻底删除nginx](https://www.jianshu.com/p/439cd2a7c84e)

- Nginx启动报错[emerg] getpwnam("nginx") failed
    - `groupadd nginx` 
    - `useradd -g nginx nginx -s /sbin/nologin`

    
## 谷歌 chromium 版本更换
- 为了使 chromedriver 和 chromium 版本一致
- `sudo apt-get install chromium-browser` 更新最新
- `chromium-browser --version`
- 👉 [mirrors.tuna.tsinghua.edu.cn](https://mirrors.tuna.tsinghua.edu.cn/raspberrypi/pool/main/c/chromium-browser/)
- `sudo apt-get install chromium-chromedriver`
- 👉 [Launchpad.net](https://launchpad.net/+search?field.text=chromium-chromedriver+armhf)

- 最终要使两者版本一致


## 设置静态ip
- `route -n` 找到网关
- `cat /etc/resolv.conf` 找到 DNS
- `sudo nano /etc/dhcpcd.conf` 在末尾写入
```
    interface eth0
    inform 192.168.137.200/24
    static routers=192.168.137.1
    static domain_name_servers=192.168.137.1
    noipv6
```
- 还可以点击桌面右上角的网络连接进去设置

## 设置 wifi 连接
- Pi 4B - 'No wireless interfaces found'
- 找不到 wifi 图标
- `sudo apt-get install wicd`
- `sudo reboot`
- 进入桌面设置 wifi 连接
- ![](/images/IgotaRaspberryPi/Snipaste_2021-01-19_22-13-01.png)
- 👉 [Raspberry Pi 3 - WiFi Stopped Working - How to debug and fix without restarting](https://raspberrypi.stackexchange.com/questions/46622/raspberry-pi-3-wifi-stopped-working-how-to-debug-and-fix-without-restarting)

## Docker 安装 mongodb
- `docker search rpi-mongodb3`
- `docker pull andresvidal/rpi3-mongodb3`
- `mkdir ~/db/mongo` 创建数据目录
- `docker run -d --name rpi-mongodb3 -v /home/pi/db/mongo:/data.db -p 27017:27017 andresvidal/rpi3-mongodb3 mongod`

## 重装 raspberry 系统
- 👉 [写入系统工具](https://www.raspberrypi.org/software/)
- 👉 [系统](https://www.raspberrypi.org/software/operating-systems/#raspberry-pi-os-32-bit)

## 换下载源
- 👉 [根据架构和版本更换源](https://mirror.tuna.tsinghua.edu.cn/help/raspbian/)

## SSH 认证更新
```
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@    WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!     @
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
IT IS POSSIBLE THAT SOMEONE IS DOING SOMETHING NASTY!
Someone could be eavesdropping on you right now (man-in-the-middle attack)!
It is also possible that a host key has just been changed.
The fingerprint for the ECDSA key sent by the remote host is
SHA256:wFyPv88OeUwo1eUnjPQTUB1PR/O/XLlJMip3BVX5mPU.
Please contact your system administrator.
Add correct host key in C:\\Users\\OrekiYuta/.ssh/known_hosts to get rid of this message.
Offending ECDSA key in C:\\Users\\OrekiYuta/.ssh/known_hosts:14
ECDSA host key for 192.168.1.201 has changed and you have requested strict checking.
Host key verification failed.
```
- 到对应目录下把当前 SSH 要访问的地址信息删除，重新连接即可

## 修改 host
- `sudo nano /etc/hosts`
- 查看域名对应 IP 👉 [ipaddress](https://www.ipaddress.com/)
```
199.232.68.133 raw.githubusercontent.com
```


## <hr>

## Portainer 
```
sudo curl -sSL https://get.docker.com | sh
or 
sudo curl -sSL https://get.daocloud.io/docker | sh

sudo docker pull portainer/portainer
sudo docker volume create portainer_data
sudo docker run -d -p 9000:9000 --name portainer --restart always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer
```
- 浏览器输入 ip:9000
- 👉 [树莓派上 Docker 的安装和使用](https://shumeipai.nxez.com/2019/05/20/how-to-install-docker-on-your-raspberry-pi.html)

## Pi dashboard 树莓派监控页面
- `sudo apt update`
- `sudo apt install docker`
- `sudo docker run -d --name docker-pi-dashboard -e 'LISTEN=1024' --net=host ecat/docker-pi-dashboard`
- 浏览器输入 ip:1024
- 👉 [一行命令部署pi dashboard](https://blog.nocode.site/2018/03/25/docker-pi-dashboard.html)

##  netdata
```
sudo docker run -d --name=netdata \
  -p 19999:19999 \
  -v /proc:/host/proc:ro \
  -v /sys:/host/sys:ro \
  -v /var/run/docker.sock:/var/run/docker.sock:ro \
  --cap-add SYS_PTRACE \
  --security-opt apparmor=unconfined \
  netdata/netdata
```

