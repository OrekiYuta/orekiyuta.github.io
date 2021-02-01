---
title: Python Dependency Separation
date: 2021-01-31 04:53:29
tags: Python
---

## Scene
- 由于每个项目之间的引入的依赖版本不同，并且有的依赖库还难以获取
- 因此在开发时，需要把依赖给保存下来，并且指明依赖的版本

## Solution
### freeze
- `pip freeze > requirements.txt`
- 使用这个命令可以导出当前环境的所有依赖

### pipreqs
- `pip install pipreqs`
- `pipreqs ./` 切换到项目根目录下执行，导出当前目录所引用的依赖
- `pipreqs ./ --encoding==utf-8`
- `pipreqs ./ --encoding==utf-8 --force`

### venv
- 使用 python 的虚拟环境
    - `python -m venv -h`
    - `python -m venv venvdemo` 创建虚拟环境
    - 找到虚拟环境的文件夹，进入 Scripts 目录
        - `activate` 激活虚拟环境
        - `activate` 退出虚拟环境
    - 所谓的激活虚拟环境，只不过是把当前系统的环境变量指向该虚拟环境
    - 在环境变量中，一个变量先找到哪个就算哪个
    - ![](/images/pythonDependencySeparation/Snipaste_2021-02-01_00-39-18.png)
    - 如图所示，激活虚拟环境时，会把该虚拟环境路径放在最前面，因此当前 python 的 path 就指向这个路径 ; 后面的 path 就不生效
    - 激活虚拟环境后，可执行 `pip list ` 查看当前的依赖库
    - 激活虚拟环境后，执行的 `pip install ` 都是装到该虚拟环境的目录里的
    - 在 IDE 工具中 ,比如 PyCharm 中,直接把项目设置指向虚拟变量路径即可，本质就是改环境变量的 PATH
- 迁移 虚拟环境
    - 在激活虚拟环境下，导出当前环境依赖库
    - `pip freeze > requirements.txt`
    
## Other 
- 虚拟环境的使用还是很有必要的，
- 因为安装一个依赖的时候，很多时候是会把指定依赖与其相关的其他依赖都安装
- 而卸载的时候只卸载了指定的依赖库
- ![](/images/pythonDependencySeparation/Snipaste_2021-02-01_00-55-30.png)
- 如果不控制一下依赖库，久而久之就很难管理了
