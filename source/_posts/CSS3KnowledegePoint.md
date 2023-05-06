---
layout: css3
title: CSS3 Knowledge Point
date: 2019-12-15 19:19:05
tags: CSS
---

### <center>属性是否可继承</center>

#### 测试能否继承
```html
<!DOCTYPE html>
<html lang="zh-cmn-Hans">
<head>
    <meta charset="utf-8" />
    <title>Elias</title>
<style>
body {
    color: red; /* 可继承 */
    border: 3px solid green; /* 不可继承 */
}
</style>
</head>
<body>
    <h1>CSS3注意点</h1>
    <p>Hello Elias</p>
</body>
</html>
```
![](/images/CSS3/01.png)

可观察到 `<h1/>`和`<p/>` 继承了 body 的 color 属性 , 而没有继承 border 属性

了解哪些属性可以被继承 👉[MDN web docs](https://developer.mozilla.org/zh-CN/docs/Web/CSS/Reference)

#### 强制继承
```html
<!DOCTYPE html>
<html lang="zh-cmn-Hans">
<head>
    <meta charset="utf-8" />
    <title>Elias</title>
<style>
body {
    color: red; /* 可继承 */
    border: 3px solid green; /* 不可继承 */
}
h1{
    border:inherit;
}
</style>
</head>
<body>
    <h1>CSS3注意点</h1>
    <p>Hello Elias</p>
</body>
</html>
```
设置属性值为 inherit , 可强制继承父级对应属性

![](/images/CSS3/02.png)



### <center>垂直对齐</center>

![](/images/CSS3/03.png)

![](/images/CSS3/04.png)

👉[详细参考](https://developer.mozilla.org/zh-CN/docs/Web/CSS/vertical-align)
