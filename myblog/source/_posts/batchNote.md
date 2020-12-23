---
title: Batch Note
date: 2020-12-13 01:17:13
tags: batch
---

### 搜索当前目录下的所有文件
```bat
    for %%i in (*.*) do echo "%%i"
    pause
```

### 搜索当前目录下被筛选的文件
```bat
    for %%i in (*.md) do echo "%%i"
    pause
```
可用正则表达式
<!-- more -->

```bat
    for %%i in (?.md) do echo "%%i"
    pause
```
上面表示搜索只有一个字符名，且后缀为 md 的文件

### 以管理员身份执行命令
```bat
    %1 mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c %~s0 ::","","runas",1)(window.close)&&exit
```
写在脚本文件顶部即可

```bat
    @echo off
    setlocal EnableDelayedExpansion
    color 3e
    
    PUSHD %~DP0 & cd /d "%~dp0"
    %1 %2
    mshta vbscript:createobject("shell.application").shellexecute("%~s0","goto :runas","","runas",1)(window.close)&goto :eof
    :runas
 
    ::填写自己的脚本
    
    echo 执行完毕,任意键退出
    
    pause >nul
    exit
```
```bat
    >NUL 2>&1 REG.exe query "HKU\S-1-5-19" || (
        ECHO SET UAC = CreateObject^("Shell.Application"^) > "%TEMP%\Getadmin.vbs"
        ECHO UAC.ShellExecute "%~f0", "%1", "", "runas", 1 >> "%TEMP%\Getadmin.vbs"
        "%TEMP%\Getadmin.vbs"
        DEL /f /q "%TEMP%\Getadmin.vbs" 2>NUL
        Exit /b
    )
```
```bat
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

### 在指定目录下打开 git-bash
```bat
    start C:\Program" "Files\Git\git-bash.exe --cd=f:\Code\
```
路径里的空格需要用双引号
```bat
    call f: 
    call cd Code\
    start C:\Program" "Files\Git\git-bash.exe 
```

```bat
    set /p input="输入要在git-bash中打开的项目路径:"
    start c:\Program" "Files\Git\git-bash.exe --cd=%input%
    pause
```
输入的项目路径需要在同一个盘符，因为切换盘符不用 cd


### 输出内容到剪贴板

```bat
PS C:\Windows\System> clip /?

CLIP

描述:
    将命令行工具的输出重定向到 Windows 剪贴板。这个文本输出可以被粘贴
    到其他程序中。

参数列表:
    /?                  显示此帮助消息。

示例:
    DIR | CLIP          将一份当前目录列表的副本放入 Windows 剪贴板。

    CLIP < README.TXT   将 readme.txt 的一份文本放入 Windows 剪贴板。
```

```bat
    echo elias | clip
```
```bat
    set /p="%date%"<nul | clip
```

### 连续执行命令
```bat
    call f: 
    call cd Code\
    call hexo clean
    call hexo g
    call hexo d
```
这里每个命令前面最好保留 call ,没有 call 的话, cmd 会在中途关闭

### 配置 java 环境变量
```bat
    @echo off
    %1 mshta vbscript:CreateObject(“Shell.Application”).ShellExecute(“cmd.exe”,"/c %~s0 ::","",“runas”,1)(window.close)&&exit 
    echo 正在设置 Java 环境变量
    wmic ENVIRONMENT create name="JAVA_HOME",username="<system>",VariableValue="C:\Program Files (x86)\Java\jdk1.7.0_79"
    wmic ENVIRONMENT create name="CLASSPATH",username="<system>",VariableValue=".;%%JAVA_HOME%%\lib;%%JAVA_HOME%%\lib\tools.jar"
    wmic ENVIRONMENT where "name='PATH' and username='<system>'" set VariableValue="%path%;%%JAVA_HOME%%\bin;%%JAVA_HOME%%\jre\bin;"
    echo 设置完成
    call java -version
    pause
```

### 获取时间
```bat
    echo %date% %time%
```

### 截取字符串
```bat
    echo %date:~0,4%
```
开始位置 0，截取字符数 4

```bat
    set str=123456789
    echo %str:~3,4%
```

### 语音读取
```bat
    mshta vbscript:CreateObject("SAPI.SpVoice").speak("elias")(Window.close)
```

### 内容重定向

```bat
    ipconfig > d:ip.txt 
```
- 将内容重定向输出到新的位置
- `>`   覆盖式重定向
- `>>`  增量式重定向
- `>nul` 重定向到空设备 nul,所以没有输出内容