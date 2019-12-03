---
title: AzureLaneCrack
date: 2019-05-13 00:40:33
tags: AzureLane
---

[资源](#资源获取) | [提取立绘](#立绘) | [提取语音](#语音) | [提取SD小人](#SD小人)
***

### 资源获取 
碧蓝航线的资源主要来源于起始安装包/游戏增量更新   
(1)官网下载安装包,解压后资源在assets\AssetBundles   
(2)从模拟器或者手机内获取增量内容, 资源在同样路径   
***

### 立绘
(1)	解压AssetStudio.x64.0.12.46,运行AssetStudioGUI.exe  
GitHub地址：https://github.com/Perfare/AssetStudio  
点击release,下载最新版本.   
 ![](/images/AzureLaneCrack/image1.png)

(2)	点击File-Load folder 选择资源名为Painting的文件夹(安装包和增量更新的操作都是一样的),等待载入.  
 ![](/images/AzureLaneCrack/image2.png)
 
(3)	点击Asset List 下方Name排列的就是各个加密立绘  
 ![](/images/AzureLaneCrack/image3.png)

(4)	点击Export-All assets 导出全部资源文件到一个新文件夹里.  
 ![](/images/AzureLaneCrack/image4.png)
<!-- more -->
(5)	Mesh文件夹里面是立绘的骨骼序列, Texture2D是文件夹里是加密后的立绘.  
 ![](/images/AzureLaneCrack/image5.png)

(6)	立绘还原,解压AzurLanePaintingExtract.v0.7.2,运行.exe
 GitHub地址：https://github.com/Goodjooy/AzurLinePaintingRestore     
 ![](/images/AzureLaneCrack/image6.png)  
                                     
(7)	点击加载文件夹,选择刚才导出的Mesh和Texture2D文件夹,即可看到完整的立绘.  
 ![](/images/AzureLaneCrack/image7.png)
 
(8)	点击设置-工具,如果出现空白弹窗,表示没有需要添加的新舰娘名,如果有,双击每个选项可以添加舰娘名,完成后确认.   
 ![](/images/AzureLaneCrack/image8.png)
 
(9)	点击导出-导出全部,等待导出.  
 ![](/images/AzureLaneCrack/image9.png)
 ![](/images/AzureLaneCrack/image10.png)
 ***
 

### 语音
(1)	解压 碧蓝航线语音提取.rar  

(2)	语音路径为assets\AssetBundles\cue()  

(3)	新建一个输出语音文件夹(cue-output).  
 ![](/images/AzureLaneCrack/image11.png)  

(4)	将cue与cue-output一起拖向BlhxCueDecoder.exe.等待导出.  
 ![](/images/AzureLaneCrack/image12.png) 

(5)	导出时间较长,导出完毕后对照语音表即可识别对应舰娘语音.  
 ![](/images/AzureLaneCrack/image13.png) 
***


### SD小人
(1)	SD小人立绘文件夹为char.打开AssetStudio,导入文件夹.  
 ![](/images/AzureLaneCrack/image14.png)
 
(2)	得到如图加密过后的SD小人立绘.  
 ![](/images/AzureLaneCrack/image15.png)
 
(3)	同理Export-All asset导出到一个文件夹里.  
 ![](/images/AzureLaneCrack/image16.png)
 
(4)	TextAsset文件夹里为SD小人部件序列.  
 ![](/images/AzureLaneCrack/image17.png)
 
(5)	批量改名去掉txt,将bat文件拖入TextAsset文件夹,双击运行.  
 ![](/images/AzureLaneCrack/image18.png)
 ![](/images/AzureLaneCrack/image19.png)
  
(6)	将TextAsset文件夹里的内容,复制到Texture2D文件夹里.  
 ![](/images/AzureLaneCrack/image20.png)
 
(7)	还原SD小人,需要Java环境和skeletonViewer.jar,运行jar. 
 ![](/images/AzureLaneCrack/image21.png) 
 
(8)	点击Open,在Texture2D文件夹里选择.skel文件.  
 ![](/images/AzureLaneCrack/image22.png)
 
(9)	得到SD小人立绘,Animation中的则是对应拥有的动作.  
 ![](/images/AzureLaneCrack/image23.png)
 




