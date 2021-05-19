---
title: Deamon bat
date: 2021-05-18 23:38:41
tags: Batch
---

## 创建守护进程监控 => 指定进程

- 在 win 中可以通过以下几种方式查看进程状况
    ```BAT
        @REM 查看端口
        netstat -an | find /C "127.0.0.1:1313"

        @REM 查看进程名
        tasklist | find /i "App.exe" 

        @REM 查看进程句柄标题
        tasklist /fi "windowtitle eq App"
    ```
<!-- more -->
- 选择合适的方式监控即可

- 循环监控端口
    ```bat
        @REM fileName, mamoru.bat
        :RESTART
        title mamoru
        netstat -an | find /C "127.0.0.1:1313" > temp.txt 
        set /p num=<temp.txt
        del /F temp.txt
        if %num% == 0 start /D "C:\Users" xx.bat
        @REM echo Wscript.Sleep WScript.Arguments(0) >sleep.vbs
        @REM cscript //b //nologo sleep.vbs 5000
     
        ping 127.1 -n 5 >nul 2>nul
        goto RESTART
    ```
    ```vbs
        ' fileName, mamoru.vbs
        ' 隐藏运行
        set ws = createobject("wscript.shell")
        ws.run "mamoru.bat",vbhide
    ```
    - 创建 mamoru.bat , 每隔 5s 检测端口进程是否存在,不存在就启动 xx.bat

- 监控 XMR
   ```bat
        @echo off
        title XMR_Daemon
        echo. Process Checking...

        set forN = 0

        :start
        set /a forN += 1
        echo %forN%
        tasklist /fi "windowtitle eq XMR" | find "cmd"

        if %forN% equ 3 goto end
        if "%errorlevel%" =="0" (goto exist) else (goto unexist)

        echo %forN%
        :exist
        echo. Process exist . do nothing.
        goto start

        :unexist
        echo. Process unexist . restart XMR
        start /D "C:\Users\" start.cmd
        ping 127.1 -n 5 > nul
        goto start


        :end
        echo. XMR_Daemon exit
        pause
   ```
   - find 会有返回值 errorlevel , 根据该值判断状态
   - 循环 3 次判断 进程标题名等于 XMRig 6.12.0 的进程是否存在, 不存在就启动 start.cmd

- 监控 ethminer 
    ```bat
        @echo off
        title Eth_Daemon
        echo. Process Checking...

        netstat -an | find /C "13333" > temp.txt 
        set /p num=<temp.txt
        del /F temp.txt
        if %num% == 0 (goto unexist) else (goto exist)

        :exist
        echo. Process exist . do nothing.
        goto end

        :unexist
        echo. Process unexist . restart ethminer
        start /D "C:\Users\" start.bat
        goto end

        :end
        echo. Eth_Daemon exit
        pause
    ```

## Other
- find 的更多用法
    ```BAT
        @REM tasklist /fi "imagename eq cmd.exe" /fi "windowtitle eq ethminer.exe" 
        @REM tasklist /fi "windowtitle eq 管理员:  ethminer.exe" | find "cmd"
    ```
- find 的返回值偶尔有点问题,状态不一样还是返回一样的值
    - 这种情况只能换 `netstat` 监控端口
- 以批处理方式启动,也就是 bat 文件启动的进程都是 cmd.exe
    - 这样的进程通过  `tasklist /fi "windowtitle eq"` 监控比较好,在各自的 bat 文件里配置 title
- 以管理员方式启动的 bat , 用 `tasklist /fi "windowtitle eq"` 需要注意 “管理员” 后带着两个字符的空格