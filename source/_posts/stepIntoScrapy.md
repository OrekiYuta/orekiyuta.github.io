---
title: Step into Scrapy 
date: 2020-12-26 19:24:56
tags: [Python,Scrapy]
---

## 配置
- `pip install scrapy`
- `scrapy` 查看用法
- `scrapy startproject getTiobe` 新建 scrapy 项目
- `cd getTiobe\spiders` 进入该目录
- `scrapy genspider tiobe www.tiobe.com/tiobe-index` 生成该链接的爬虫文件
![](/images/stepIntoScrapy/Snipaste_2020-12-26_19-34-43.png)
<!-- more -->
## 获取
- 获取该元素对应的 css 选择器
![](/images/stepIntoScrapy/Snipaste_2020-12-26_19-36-35.png)
- 修改 parse 方法
- ```py
    def parse(self, response):
    for item in response.css('#top20 > tbody > tr'):
        yield {
            'rank_this-year': item.css('td:nth-child(1)::text').get().strip(),
            'rank_last-year': item.css('td:nth-child(2)::text').get().strip(),
            'programming_language': item.css('td:nth-child(4)::text').get().strip(),
            'ratings': item.css('td:nth-child(5)::text').get().strip(),
            'change': item.css('td:nth-child(6)::text').get().strip(),
            'date': time.strftime('%Y/%m/%d %H:%M:%S', time.localtime(time.time()))
        }
  ```

## 实施
- 在 spiders 目录下的 settings.py 设置导出 json 格式
    - ```
        FEED_FORMAT = "json"
        FEED_URI = "tiobe.json"
      ```
- `scrapy crawl tiobe`
- 就可以在项目的目录下找到 tiobe.json 获得的数据了

## 参考
- 👉 [python中yield的用法详解——最简单，最清晰的解释](https://blog.csdn.net/mieleizhi0522/article/details/82142856)
- 👉 [https://scrapy.org/](https://scrapy.org/)

