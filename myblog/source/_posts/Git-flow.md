---
title: Git low
date: 2019-06-28 01:29:36
tags: Git
---
## <center>Git工作流<center>

### Flow 
<pre>
for ( =>local-code => 
        submit to local-repository => 
        submit to server-repository => 
        from remote-repository update code => 
    )
</pre>

### Detail 
localfolder -> git Stage -> git local -> git remote

本地工作文件夹 -> 索引区 -> 本地库 -> 远程库（服务器端）


## <center>基础配置</center>

- `git init`         初始化

- `git config -l`   查看配置信息

- `git config --global user.name "XXX"`

- `git config --global user.email "xxx@zz.com"`

- `git config --help`    查看帮助信息

- `git help config`

- `git help commit`

- `git help ...` 
<!-- more -->


## <center>提交本地仓库</center>

### 创建本地仓库
- `mkdir mygit`  建立本地工作文件夹
- `cd mygit`     进入文件夹

### git init
- `git init`     初始化git库

### 更新仓库内容
- `nano 文件名`  编辑本地文件,比如 `nano test.htm` 

    ![](/images/Git/01.png)

    ![](/images/Git/02.png)

### git status
- `git status`  查看本地文件夹状态

    ![](/images/Git/03.png)

     当前状态为 **红色** 提示文件未添加到索引区

### git add FN
- `git add 文件名` 添加文件到索引区，比如 `git add test.htm`

    ![](/images/Git/04.png)

     提交成功再次查看状态为绿色,成功添加到索引区

### git commit -m "RI"
- `git commit -m "备注信息"`  将索引区内容提交至本地仓库

    ![](/images/Git/05.png)

### git log
- `git log`  查看提交日志

    ![](/images/Git/06.png) 


## <center>查看提交日志</center>

1. 首先修改下原有文件内容 `nano test.htm` 

    ![](/images/Git/07.png)

0. 查看状态

    ![](/images/Git/08.png)

0. 添加到索引区

    ![](/images/Git/09.png)

0. 提交到本地库

    ![](/images/Git/10.png)

0. 查看日志

    ![](/images/Git/11.png)

0. 在以后日志必定会越来越多，就可以用以下方法查看

### git log -[number]
* `git log -1`  后面的数字代表最近的几条记录

    ![](/images/Git/12.png)

### git log --oneline
* `git log --oneline`  将日志信息缩短为一行显示 ; ID号也缩短为前7位了

    ![](/images/Git/13.png)

### git log -p
* `git log -p`  查看更改的详细信息

    ![](/images/Git/14.png)

### git log -p -[number]
* `git log -p -1` 和数字组合用法,查看最近一次更改的详细信息

    ![](/images/Git/15.png)

### git log -p -[number]
* `git log -p -1 --online` 加上oneline,对比上图可见头部信息缩短了

    ![](/images/Git/16.png)

### git log --stat
* `git log --stat`  对每次的提交的内容进行统计的信息

    ![](/images/Git/17.png)

### git log --help
* `git log --help`  查看其他命令用法
   

## <center>工作状态回退</center>

### 未添加到索引区
 
1. 修改文件内容

    ![](/images/Git/19.png)

2. 查看状态

    ![](/images/Git/20.png)

#### git checkout -- [FN]
3. `git checkout -- 文件名`  突然不想要已修改的部分内容了，状态回退一下

    ![](/images/Git/21.png)

4. 查看源文件,刚才修改内容已经被回退

    ![](/images/Git/22.png)

### 已添加到索引区

1. 修改内容然后添加到索引区

    ![](/images/Git/23.png)

    ![](/images/Git/24.png)

#### git reset HEAD [FN]
2. `git reset HEAD 文件名` 将添加内容从索引区回退   

    ![](/images/Git/25.png)

3. 接着继续按照 **未添加到索引区** 的步骤即可回退到文件未修改状态  

- `git add .`   Git 不同版本的用法区别

    ![](/images/Git/18.png)  


## <center>比较修改内容</center>

### git diff
- `git diff`  比较工作文件夹

    ![](/images/Git/26.png)

### git diff --cached
- `git diff --cached`  比较索引区

    ![](/images/Git/27.png)


## <center>文件操作</center>

1. 执行多个操作（修改内容，添加文件）

    ![](/images/Git/28.png)

    ![](/images/Git/29.png)    

2. 查看状态并添加到索引区

    ![](/images/Git/30.png)

### git mv OldFN NewFN
3. `git mv 旧文件名 新文件名`   修改文件名

    ![](/images/Git/31.png)

    **修改前缀认为添加新文件，修改后缀认为重命名**

    ![](/images/Git/32.png)

    **同时修改认为添加新文件**

    ![](/images/Git/33.png)

### git rm --cached FN
4. `git rm --cached 文件名`  从索引区删除

    ![](/images/Git/34.png)

5. 查看下日志

    ![](/images/Git/35.png)


## <center>忽略管理</center>

设置Git忽略的文件，这些文件不参与Git库的提交和管理。（动态文件，比如Node.js的 node_modules 文件夹）

1. 新建两个文件;ingnore.tmp为需要被忽略的文件, **.gitignore**为配置文件

    ![](/images/Git/36.png)

0. 查看状态

      目前状态为两个文件都将被Git管理

    ![](/images/Git/37.png)

0. 在 **.gitignore** 中添加 `*.tmp` 忽略这类文件:即使是在同级目录文件夹内的.tmp 都会被忽略

    ![](/images/Git/38.png)

0. 查看状态

     .tmp 已被忽略 ; 

    ![](/images/Git/39.png)


## <center>更新最后的提交记录</center>

在上次提交过一次记录，后来发现内容有误，需要修改下内容但是又不想再提交一条修改记录，而是添加到上次提交的记录中去。

1. 在.gitignore 中再添加一条信息

    ![](/images/Git/40.png)

2. 查看状态

    ![](/images/Git/41.png)

3. 添加到索引区

    ![](/images/Git/42.png)

### git commit --amend
4. `git commit --amend`  提交到最后的一条记录中去
    
    ![](/images/Git/43.png)


## <center>版本回退/切换</center>

### git reset --hard HEAD
- `git reset --hard HEAD`  回退到最新提交版本

- `git reset --hard HEAD~`  回退到最新提交的上一次版本

- `git reset --hard HEAD~n`  回退到倒数第N版本

- `git reset --hard 版本ID号`  回退到指定版本号

1. 先提交几次记录

    ![](/images/Git/44.png)

    ![](/images/Git/45.png)

2. 回退到上个版本

    ![](/images/Git/46.png)

3. 回退到最新版本，指的是此刻版本头HEAD指向的版本

    ![](/images/Git/47.png)

4. 根据版本ID号回到指定版本 ; 通过头指针指向我们需要的版本,其他在头部之上的版本只是未显示而已,但仍在库中。

    ![](/images/Git/48.png)

### git reflog -[number]
5. `git reflog -4`  要是忘记的版本号,可执行该命令查询之前版本切换的操作信息，从而确定需要切换的版本号

    ![](/images/Git/49.png)


## <center>分支使用⭐</center>

以上的操作都是在主分支上执行的,但是在实际应用中不应该多次在主分支操作。

在项目中每个人都有自己的要执行的任务,每个人执行的任务都不同,那么就需要在主分支上建立自己的分支,在自己的分支上不断的完善后再向主分支进行合并。

![](/images/Git/gitbranch.png)


### git branch BN

- `git branch 分支名`   建立新分支

### git checkout BN
- `git checkout 分支名`   切换分支

### Detailed Process
1. 查看下当前已有分支情况

    ![](/images/Git/50.png)

0. 建立分支，切换分支

     建立的分支拥有的内容 与 在建立分支的那个时刻的主分支(被分支的分支)的内容一致
    
    ![](/images/Git/51.png)

0. 添加文件，提交记录

    ![](/images/Git/52.png)

0. 查看当前分支日志

    ![](/images/Git/53.png)

0. 切换到主分支,查看日志

    ![](/images/Git/54.png)

- 在分支修改后没有提交的情况下，是不允许切换分支的

    ![](/images/Git/55.png)

### 分支文件存储位置
- **通过git在本地创建仓库，切换分支时另外一个分支的内容在哪里？**

    &emsp;&emsp;项目文件都保存在.git目录下，始终存在，包括历史的各种版本，只不过不能从文件名字搜索到，因为Git是Content Addresing的。每次切换到一个分支，或者是check out一个历史版本，Git就从数据库（就是.git目录）中把这个版本的文件和目录都找出来，Copy一份放这当前的项目目录下。


## <center>合并分支</center>

### git merge BN
- `git merge 分支名`  先得切换到主分支，再进行合并

    ![](/images/Git/56.png)

### git branch BN 
- `git branch -d 分支名`   删除分支
    
    ![](/images/Git/57.png)


## <center>分支冲突</center>

### git checkout -b BN
1. `git checkout -b 分支名`  建立分支并切换到该分支

    ![](/images/Git/58.png)

0. 修改文件内容，提交

    ![](/images/Git/59.png)

    ![](/images/Git/60.png)

0. 切换分支，继续修改同样文件的内容，提交

    ![](/images/Git/61.png)

    ![](/images/Git/62.png)

0. 在主分支上合并开发分支

     有冲突，需要手动修改

    ![](/images/Git/63.png)

     打开有冲突的文件

    ![](/images/Git/65.png)   

     这是VSCode的功能（当前所处分支|被合并分支|两者都要|比较）

    ![](/images/Git/64.png)

0. 修改完毕后,回到主分支，查看状态并提交

    ![](/images/Git/66.png)


## <center>使用Tag标签</center>

### 简单了解版本号
* 版本号: 1.1.4   （NNN.abc.xxx）

* 有些为四位数 1.1.4.2356 最后的数字为编译次数等其他信息

    * NNN:大版本号
    * abc:每次做出的小更新时，发布的版本号
    * xxx:每次bug修正时发布的版本号

### git tag VersionNumber
1. `git tag 版本号`  把当前代码状态作为一个版本发布

    ![](/images/Git/67.png)   

0. 修复bug，再次发布新版本

    ![](/images/Git/68.png)

0. 新功能追加，再次发布新版本

    ![](/images/Git/69.png)

0. 查看版本

    ![](/images/Git/70.png)


## <center>使用别名</center>

在Git中可以将经常使用的命令以别名缩写的方式简化使用,根据个人习惯或者开发组规范吧。

`git config --global alias.别名 原命令名 `

例如：
* `git config --global alias.co checkout`
* `git config --global alias.br branch`
* `git config --global alias.cm commit`
* `git config --global alias.st status`
*  `...`


## <center>GitHub</center>

1. 创建Github仓库

    ![](/images/Git/71.png)

0. 克隆仓库到本地

    ![](/images/Git/72.png)

0. 进入仓库查看状态

    ![](/images/Git/73.png)

0. 向仓库添加内容后，查看状态，提交到本地仓库

    ![](/images/Git/74.png)   

0. 查看当前状态，所处分支

    ![](/images/Git/75.png)

0. 查看要推送的URL,然后推送到远端

    ![](/images/Git/76.png) 

0. 进入GitHub查看,推送成功！

    ![](/images/Git/77.png)

### 常用命令
* `git branch -a`  查看全部分支情况
* `git branch 分支名1 remotes/origin/分支名2`   以远程分支名2为依据建立本地分支名1 （这两个是同一个东西来的） 
* `git remote -v`  查看获取和推送的URL
* `git push origin 分支名`  推送到指定分支
* `git pull`  拉取远端内容

## <center>Remark</center>

**文章中用到的简写:**
- RI ==Remark Information
- FN == FileName
- BN == branchName