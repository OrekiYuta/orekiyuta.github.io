---
title: Use jsdeliver Load Static Resources
date: 2021-07-15 20:38:55
tags: [Github,CDN]
---

## Scene
- 向 github 的 README 文件中添加图片链接
- 把图片上传到仓库,然后引用仓库的自动分配给图片的 `raw.githubusercontent.com` 域地址
- 但是这种方式只有能访问 `raw.githubusercontent.com` 的情况下才能加载图片
- 由于网络情况原因, DNS 污染 ,很多时候加载不出来
- 因此这种方式不够完善
<!-- more -->
## Solution
- 解决这个问题的话，有两种方式
    - 利用 github 的仓库建个静态的图库站点,再取该站点的链接; 但这种方式取决于 github 的访问稳定情况
    - 利用 CDN 内容分发服务, 这种方式能够完善的解决问题
- 下面主要介绍利用 jsdelivr 和 github 仓库的 Releases 来部署静态资源
1. 先把静态资源上传到仓库,然后创建 Releases
    - ![](/images/usejsdeliverLoadStaticResources/Snipaste_2021-07-15_21-11-34.png)
0. 填写基本版本信息
    - ![](/images/usejsdeliverLoadStaticResources/Snipaste_2021-07-15_21-12-32.png)
0. 然后 Publish release 即可
0. 最后利用 jsdeliver 提供的服务即可
    - `https://cdn.jsdelivr.net/gh/[github用户名]/[仓库名][可选版本号]/[资源在仓库的路径]`
    - 如: https://cdn.jsdelivr.net/gh/OrekiYuta/OrekiYuta@1.0.0/OrekiYuta.png 
    - 或, https://cdn.jsdelivr.net/gh/OrekiYuta/OrekiYuta@latest/OrekiYuta.png
    - ![OrekiYuta](https://cdn.jsdelivr.net/gh/OrekiYuta/OrekiYuta@1.0.0/OrekiYuta.png)
- 利用这种思想,还可以部署一些静态的服务
## Other
- 👉 [jsdelivr](https://www.jsdelivr.com/)