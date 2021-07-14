---
title: IE Ajax Always Error Callback
date: 2021-07-12 23:13:19
tags: [Ajax,Network]
---

## Sence
- 使用 jQuery 的 $.ajax 发送网络请求 
- 在其他浏览器上返回正常结果
- 但是在 ie 上总是执行 error 回调
- ```js
        <!-- jquery-1.12.4.min.js -->
        $.ajax({
            async:false,
            cache:false,
            type:"POST",
            data:param,
            url:"http://xxx",
            dataType: "json",
            success: function(data){
                    console.log(data);            
                },error : function(error){
                    console.log(error)
                }         
            });
  ```
- 如上代码在 ie 中总是得到 `[object Object]{readyState: 0, responseJSON: undefined, status: 0, statusText: "No Transport"`
<!-- more -->
## Solution

- 在 $.ajax 执行之前加上 `jQuery.support.cors=true;` 即可
- ```js
        <!-- jquery-1.12.4.min.js -->
        jQuery.support.cors=true;
        $.ajax({
            async:false,
            cache:false,
            type:"POST",
            data:param,
            url:"http://xxx",
            dataType: "json",
            success: function(data){
                    console.log(data);            
                },error : function(error){
                    console.log(error)
                }         
            });
  ```

## Other
- `jQuery.support.cors` 查看当前 jQuery 在当前浏览器是否支持跨域
- ![](/images/ieAjaxAlwaysErrorCallback/Snipaste_2021-07-08_14-41-10.png)