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
     
### .bat Get admin
- ```bat
    >NUL 2>&1 REG.exe query "HKU\S-1-5-19" || (
        ECHO SET UAC = CreateObject^("Shell.Application"^) > "%TEMP%\Getadmin.vbs"
        ECHO UAC.ShellExecute "%~f0", "%1", "", "runas", 1 >> "%TEMP%\Getadmin.vbs"
        "%TEMP%\Getadmin.vbs"
        DEL /f /q "%TEMP%\Getadmin.vbs" 2>NUL
        Exit /b
    )
  ```
- ```bat
    >nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
    if '%errorlevel%' NEQ '0' (
    goto UACPrompt
    ) else ( goto gotAdmin )
    :UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"
    "%temp%\getadmin.vbs"
    exit /B
    :gotAdmin
    if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )
  ```

## Nslookup
- `nslookup www.baidu.com` 查看域名当前 IP
## Net user
- `net user` 查看当前计算机用户名
## Arp -a
- `arp -a ` 查看当前局域网内的所有 IP
## Net share
- `net share` 查看本机上的共享资源
- `net share [name]/delete` 删除共享资源

## Netsh wlan
- `netsh wlan show profile [wlanName] key=clear` 查看已连接 Wi-Fi 的详细信息，包含密码

## | 
- `ipconfig | clip` 将结果输出到剪贴板

## &&
- `ipconfig && arp -a` 连接多个命令，只有前面一个执行成功，后面的才执行
- & 一个一个执行
