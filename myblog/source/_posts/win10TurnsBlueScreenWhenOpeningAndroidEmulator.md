---
title: Win10 turns blue screen when opening Android emulator
date: 2021-04-15 00:13:06
tags: [flutter,Android]
---

## Scene
- 在编写 flutter 启动 emulator 后，关闭 emulator 不完整
- 导致虚拟化一致存在
- 之后一旦启动 emulator/安卓模拟器，win10 就立刻蓝屏
<!-- more -->

## Solution
- win + R 输入 `msinfo32.exe`
- 可见 <基于虚拟化的安全性	正在运行>
- 下载工具 👉[关闭基于虚拟化的安全性](https://github.com/OrekiYuta/Gear/tree/master/Emulator)
- 解压后 cd 到 目录下
```
 1.Set-ExecutionPolicy RemoteSigned
 来允许运行脚本，根据提示输入：y
 
 ##关闭基于虚拟化的安全性
 2.关闭的命令：./DG_Readiness_Tool_v3.6.ps1 -Disable -AutoReboot
    
 ##打开基于虚拟化的安全性
 3.开启的命令：./DG_Readiness_Tool_v3.6.ps1 -Enable -AutoReboot

 4.检查DG是否还在运行: ./DG_Readiness_Tool_v3.6.ps1 -Ready
```
- 稍后系统自动重启，重启过程出现选项 按 F3 跳过
- 进入系统重新查看 <基于虚拟化的安全性	未启用> 即可

## Other Solution
### A
- 控制面板-程序-程序和功能-启用或关闭 Windows 功能
- 关闭 Hyper-V 、沙盒等虚拟化服务
- 或者 执行命令彻底关闭 `bcdedit /set hypervisorlaunchtype off`

### B
- 计算机管理-服务和应用程序-服务- HV主机服务，关闭
- 或者 执行命令彻底关闭 `bcdedit /set hypervisorlaunchtype off`

