---
title: Git Reset Commit Without Change Code
date: 2021-12-11 02:56:21
tags: [Git,Github]
---

## Scene
- 因为设置了定时提交 github 脚本,偶尔在目录下打包了大的压缩包忘了删除
- 定时任务提交 git commit 到本地仓库了
- 今天手动 push 到 github 发现文件过大
``` shell
F:\Code\Temp>git push
    Enumerating objects: 1193, done.
    Counting objects: 100% (1193/1193), done.
    Delta compression using up to 12 threads
    Compressing objects: 100% (812/812), done.
    Writing objects: 100% (1177/1177), 146.10 MiB | 461.00 KiB/s, done.
    Total 1177 (delta 212), reused 1111 (delta 175), pack-reused 0
    remote: Resolving deltas: 100% (212/212), completed with 14 local objects.
    remote: error: Trace: 64c7aa0d8f24426987252f0fa81b8013929e07d5a0f4f52abfff441e541eee51
    remote: error: See http://git.io/iEPt8g for more information.
    remote: error: File vue/vue.zip is 161.24 MB; this exceeds GitHub's file size limit of 100.00 MB 
    remote: error: GH001: Large files detected. You may want to try Git Large File Storage - https://git-lfs.github.com.
    To github.com:OrekiYuta/Temp.git
    ! [remote rejected]   master -> master (pre-receive hook declined)
    error: failed to push some refs to 'github.com:OrekiYuta/Temp.git'
```
<!-- more -->
## Solution
- 解决方法是 回退本地 commit 到大文件提交记录之前的 commit
- 以下方法只是 回退本地 commit 记录,并不会对本地代码修改回退
```shell
    F:\Code\Temp>git log
    commit 137833d814c302e03e806aa0dd297c66cbfe26f8 (HEAD -> master)
    Author: OrekiYuta <orekiyuta@gmail.com>
    Date:   Sat Dec 11 02:49:13 2021 +0800

        on

    commit 05d5ba83c4d0ee2678ab7ad0fe71f36456b3d548
    Author: OrekiYuta <orekiyuta@gmail.com>
    Date:   Sat Dec 11 02:30:57 2021 +0800

        2021-12-11/ 2:30:54.50 by auto commit

    commit 4d09030accde17e9f9b1551fbbea06511683d635
    Author: OrekiYuta <orekiyuta@gmail.com>
    Date:   Fri Dec 10 23:30:55 2021 +0800

        2021-12-10/23:30:54.05 by auto commit

    commit f0089c3aa837e7fb7a820717f1e5f529f352890e
    Author: OrekiYuta <orekiyuta@gmail.com>
    Date:   Fri Dec 10 02:32:18 2021 +0800

        2021-12-10/ 2:31:49.91 by auto commit

    commit f4fe5830c92e3a0240c6606f6b35bea74b951f35 # commit id 标识
    Author: OrekiYuta <orekiyuta@gmail.com>
    Date:   Thu Dec 9 23:31:11 2021 +0800

        2021-12-09/23:31:01.07 by auto commit

```
- 定位到想要回退 commit 的记录 id 标识
- `git reset id` 执行即可
```shell
    F:\Code\Temp\vue>git reset a389eb06aa841e79c734f361a25b77b4c177e964
    Unstaged changes after reset:
    M       python/amos/.idea/amos.iml
    M       python/amos/.idea/misc.xml
    M       python/amos/.idea/modules.xml
    M       python/amos/.idea/vcs.xml
    M       python/lab/app/service/github_commit_service.py
    D       python/lab/test.md
    D       vue/kasrc/.editorconfig
```
- 最后重新提交 push 代码到 github 即可


