---
title: Tmux Manual
date: 2019-11-28 00:08:43
tags: Tmux
---

### 启动会话

- `tmux` 匿名会话
- `tmux new -s <session-name>`

### 退出会话

- `exit`
- Ctrl + d

### 前缀

- Ctrl + b
- Ctrl + b + ?  帮助信息
- ESC / q   退出帮助

### 分离会话

- `tmux detach`
- Ctrl + b + d

### 查看会话列表

- `tmux ls`
- Ctrl + b + s

### 接入会话

- `tmux a` 
- `tmux attach -t <session-name>`

### 关闭会话

- `tmux kill-session -t <session-name>`

### 切换会话

- `tmux switch -t <session-name>`

### 重命名会话

- `tmux rename-session -t <old-name> <new-name>`
- Ctrl + b + $

### 窗格操作

#### 划分上下窗口
- Ctrl + b + "   

#### 划分左右窗口
- Ctrl + b + %

#### 移动光标到其他窗格
- Ctrl + b + ↑↓←→键

#### 调整窗格大小
- Ctrl + b + Ctrl + ↑↓←→

#### 窗格内容上下滚动
- Ctrl + b + [ + ↑↓   

---

### 参考内容
- [Tmux 使用手册](http://louiszhai.github.io/2017/09/30/tmux/)
- [Tmux 使用教程](https://www.ruanyifeng.com/blog/2019/10/tmux.html)