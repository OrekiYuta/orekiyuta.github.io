---
title: Github Commit Account About
date: 2021-06-29 23:12:11
tags: Git
---

## Scene
- 发现 Github 的 commit 没有显示在主页的记录图表中
- 排查后得出是 commit 的用户不对

## Solution
### git config
- 先调整本地的 git config 
```
    // 设置全局
    git config --global user.name "Author Name"
    git config --global user.email "Author Email"
    
    // 或者设置本地项目库配置
    git config user.name "Author Name"
    git config user.email "Author Email"
```
- **以后每次提交前都检查下用户**
<!-- more -->
### git rebase
- 修改已经 commit 了的历史用户信息记录
- `git rebase -i HEAD~n` n 回溯到指定的位置
- 在想要修改的位置添加 `exec git commit --amend --author="New Author<New Email Address>" -C HEAD`
- ![](/images/githubCommitAccountAbout/Snipaste_2021-06-29_10-51-06.png)
- `git pull`
- `git push`
- 结果如下，并不能完全移除之前的提交历史，只是替换了
- ![](/images/githubCommitAccountAbout/Snipaste_2021-06-29_14-31-56.png)
### git filter-branch
- 同样的修改历史用户信息记录
- shell 脚本循环所有 commit 记录修改
```SHELL
    #!/bin/sh
    git filter-branch --env-filter '
    OLD_EMAIL="your-old-email@example.com"
    CORRECT_NAME="Your Correct Name"
    CORRECT_EMAIL="your-correct-email@example.com"
    if [ "$GIT_COMMITTER_EMAIL" = "$OLD_EMAIL" ]
    then
        export GIT_COMMITTER_NAME="$CORRECT_NAME"
        export GIT_COMMITTER_EMAIL="$CORRECT_EMAIL"
    fi
    if [ "$GIT_AUTHOR_EMAIL" = "$OLD_EMAIL" ]
    then
        export GIT_AUTHOR_NAME="$CORRECT_NAME"
        export GIT_AUTHOR_EMAIL="$CORRECT_EMAIL"
    fi
    ' --tag-name-filter cat -- --branches --tags
```
- `git pull`
- `git push`
- 和前面的 rebase 同样效果

## Other 
- 👉 [Github个人主页不显示提交记录的问题](https://www.cnblogs.com/hiver/p/7891724.html)
- 👉 [How to change the author and committer name and e-mail of multiple commits in Git?](https://stackoverflow.com/questions/750172/how-to-change-the-author-and-committer-name-and-e-mail-of-multiple-commits-in-gi)
