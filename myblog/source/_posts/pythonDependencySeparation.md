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