---
title: jQuery Loop Clone
date: 2021-07-20 20:45:04
tags: jQuery
---

## Scene
- 循环 clone() 发现除了第一个元素以后的都不对劲

## Solution
- 使用 clone() 的时候要注意的是 clone 出来的元素标签需要放在 原型标签的后面

<!-- more -->
- ```html
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    　　<script src="http://libs.baidu.com/jquery/2.1.4/jquery.min.js"></script>
        <title>clone</title>
    </head>
    <script>
    $(function() {
        for(var num = 1;num<10;num++){
            /**
             * 取首个 id 为 template 的元素 
             * 如果 DOM 创建的节点插入在👆该元素的前面, 就会取到刚生成的节点
             */
            var template = $("#template").clone(); 
            template.append("<button >"+num+"</button>");
            template.show();
            $("#cloneDiv").append(template);
        }   
    });
    
    </script>
    <body>
        <div  id="template" ></div>
        <div  id="cloneDiv" ></div>
    </body>
</html>
  ```
- 否则就会将第一次 clone 出来的元素标签作为原型，进行后续 clone() ,如下：
- ```html
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    　　<script src="http://libs.baidu.com/jquery/2.1.4/jquery.min.js"></script>
        <title>clone</title>
    </head>
    <script>
    $(function() {
        for(var num = 1;num<10;num++){
            var template = $("#template").clone();
            template.append("<button >"+num+"</button>");
            template.show();
            $("#voteListDiv").append(template);
        }   
    });
    </script>
    <body>
        <div  id="voteListDiv" ></div>
        <div  id="template" ></div>
    </body>
    </html>
  ```