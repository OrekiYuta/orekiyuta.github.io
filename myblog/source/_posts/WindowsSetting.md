---
title: 'Windows Setting'
date: 2020-11-14 16:49:01
tags: Windows
---

### Win10 LTSB Add MicrosoftStore

- To : [LTSB-Add-MicrosoftStore](https://github.com/kkkgo/LTSB-Add-MicrosoftStore)
- Run: Add-Store.cmd
<!-- more -->
![](/images/Windows/Win10LTSBAddMicrosoftStore/Snipaste_2020-11-14_16-53-39.png)

### Windows show Windows/File
- `explorer .`
- `explorer ..`
- `explorer [dirName]`
- `start .`
![](/images/Windows/Explorer/Snipaste_2020-11-14_17-06-31.png)

### Desktop Context Menu

- `计算机\HKEY_CLASSES_ROOT\Directory\Background\shell`
- ![](/images/Windows/DesktopContextMenu/Snipaste_2020-11-24_22-36-36.png)
- ![](/images/Windows/DesktopContextMenu/Snipaste_2020-11-24_22-35-15.png)
- ![](/images/Windows/DesktopContextMenu/Snipaste_2020-11-24_22-40-14.png)

### DOS Clean
- `cls`

### Netstat Find/Kill

- `netstat -ano|findstr 8000`  查看占用8000端口的进程

- `tasklist | findstr 8608` 查看进程的信息

- `taskkill /pid 8608 /f`  关闭进程

![](/images/Windows/Netstat/Snipaste_2020-05-23_13-23-00.png)


### Install Chocolatey
- At PowerShell
    - `Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))`
- [https://chocolatey.org/install](https://chocolatey.org/install)
- At CMD
    - `@powershell Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))`

### Choco 
- `choco list -lo` 查看用 chocolatey 安装的软件
- `choco list -li` 查看所有已安装的软件
- `choco uninstall [name]` 卸载软件

### Nslookup
- `nslookup www.baidu.com` 查看域名当前 IP
### Net user
- `net user` 查看当前计算机用户名
### Arp -a
- `arp -a ` 查看当前局域网内的所有 IP
### Net share
- `net share` 查看本机上的共享资源
- `net share [name]/delete` 删除共享资源

### Netsh wlan
- `netsh wlan show profile [wlanName] key=clear` 查看已连接 Wi-Fi 的详细信息，包含密码

### | 
- `ipconfig | clip` 将结果输出到剪贴板

### &&
- `ipconfig && arp -a` 连接多个命令，只有前面一个执行成功，后面的才执行
- & 一个一个执行
- PowerShell 不支持

### VSCode Column edit
- Shift + Alt + 左键

### Google Clean up cache
- Shift + ctrl + R

### Comfortable colors

- #39ff70

### The Lost Worlds 
- `telnet towel.blinkenlights.nl`
![](/images/Windows/Blinkenlights/Snipaste_2020-12-13_02-50-40.png)

### Check WIN Version
- `winver` cmd
- win + R , 输入 winver 

### PowerShell Theme

- `Install-Module posh-git -Scope CurrentUser`
- `Install-Module oh-my-posh -Scope CurrentUser`
- `if (!(Test-Path -Path $PROFILE )) { New-Item -Type File -Path $PROFILE -Force }`
- `notepad $PROFILE`
- 在打开的文件中写入
    - ```
        Import-Module posh-git 
        Import-Module oh-my-posh 
        Set-Theme Paradox
      ```
    - 如果出现 “···无法加载文件 ******.ps1，因为在此系统中禁止执行脚本···”
    - 就执行 `set-ExecutionPolicy RemoteSigned`
- 修改主题,把下面出现的主题名写入上面的文件中
![](/images/Windows/PowerShellTheme/Snipaste_2020-12-27_00-12-42.png)

- 👉[5 个 PowerShell 主题，让你的 Windows 终端更好看](https://zhuanlan.zhihu.com/p/57730843)

#### 在 fluent 打开
- 如有以下错误
```
···PowerShell_profile.ps1 cannot be loaded because running scripts is disabled on this system···
```
-执行 `Set-ExecutionPolicy -Scope "CurrentUser" -ExecutionPolicy "RemoteSigned"`

### MySQL install/linking

- 👉 [MySQL Community Downloads](https://dev.mysql.com/downloads/windows/installer/)
- 👉 [Windows10 MYSQL Installer 安装（mysql-installer-community-5.7.19.0.msi）](https://www.runoob.com/w3cnote/windows10-mysql-installer.html)
- 👉 [解决Navicat for MySQL 连接 Mysql 8.0.11 出现1251- Client does not support authentication protocol 错误](https://blog.csdn.net/seventopalsy/article/details/80195246)
- 👉 [配置mysql允许远程连接的方法](https://www.cnblogs.com/linjiqin/p/5270938.html)
