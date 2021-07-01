---
title: Python Venv Migrate Invalid
date: 2021-06-30 19:51:42
tags: Python
---

## Sence
- Python Flask 项目迁移到其他机器上开发，venv 虚拟环境无法使用
- 在 PyCharm 上指定该项目的虚拟环境 venv 的信息为 invalid 不可用

## Solution
- 因为项目在原机器上的路径和新机器上的路径的虚拟环境位置不同
- 查看可见在 venv 里面的几个文件里写的是旧机器的绝对路径
<!--more-->
- 修改以下几个文件内容

    1. venv/pyvenv.cfg
        ```
            home = 新机器的全局python环境变量绝对路径
            include-system-site-packages = false
            version = 3.7.0
        ```
    0. venv/Scripts/activate
        ```
            VIRTUAL_ENV="新机器的项目里的虚拟环境绝对路径\venv"
            export VIRTUAL_ENV
        ```
    0. venv/Scripts/activate.bat
        ```
            set "VIRTUAL_ENV=新机器的项目里的虚拟环境绝对路径\venv"
        ```
    0. venv/Scripts/Activate.ps1
        ```
            $env:VIRTUAL_ENV="新机器的项目里的虚拟环境绝对路径\venv"
        ```
- 再次尝试 激活/设置 虚拟环境,启动项目
- 然后可能还会遇到以下问题
    ```
        Fatal Python error: Py_Initialize: unable to load the file system codec
        ImportError: No module named 'encodings'
        Current thread 0x00001db4 (most recent call first):
    ```

    ```
        Cannot set up a python SDK at Python 3.7 The SDK seems invalid
    ```
    ```
        python ImportError: DLL load failed: %1 不是有效的 Win32 应用程序。
    ```
- 我的解决方法是:
    - 在新的机器上创建一个新的虚拟环境 venv/
    - 然后把该新的 venv/Script/ 目录下 除了 activate,activate.bat,Activate.ps1 以外的全部文件复制到 我们刚才迁移过来的项目的 venv/Script/ 目录下 并覆盖
    - 再次给该项目指定 虚拟环境 venv 即可
- 最后,以后在每个项目中还是需要添加一下环境依赖 `pip freeze>requirements.txt`

## Other
- 👉 [项目路径变化后virtualenv(venv)无法激活](https://blog.csdn.net/u011580175/article/details/105795665)
- 👉 [Cannot set up a python SDK at Python 2.7 The SDK seems invalid - Python项目迁移时虚拟环境无法成功导入，致依赖包无法识别的问题](https://blog.csdn.net/New_joined_lion/article/details/118053704)
