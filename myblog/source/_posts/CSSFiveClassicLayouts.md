---
title: CSS Five Classic Layouts
date: 2020-11-09 21:34:06
tags: CSS
---

CSS的五种经典布局
<!-- more -->
## 空间居中

![](/images/CSSFiveClassicLayouts/1.png)

```html
<div class="parent" >
    <div class="child" contenteditable>:)</div>
</div>
```

```css
.parent {
  display: grid;
  place-items: center;
  background: lightblue;
  width: 500px;
  height: 500px;
  
  resize: both;
  overflow: auto;
}

.child {
  padding: 0.5rem;
  border-radius: 10px;
  border: 1px solid red;
  background: lightpink;
  font-size: 2rem;
  text-align: center;
}

body {
  font-family: system-ui, serif;
}
```
- 指定 Gird 布局,并且 `place-items:center;`
-  `place-items:center;` 是简写
- 全写为  `place-items:center center;` // `place-items: <align-items> <justify-items>;` 垂直 水平
- `place-items:start;`左上角  `place-items:end`右下角



## 并列式
![](/images/CSSFiveClassicLayouts/2.png)

![](/images/CSSFiveClassicLayouts/3.png)

![](/images/CSSFiveClassicLayouts/4.png)

```html
<!DOCTYPE html>
<html lang="en">
<style>
.parent {
  display: flex;
  flex-wrap: wrap;//可换行
}
.child {
  flex: 0 1 300px; /*初始宽度300px,不可以扩大,宽度不足300px时可缩小*/
 /*flex: 1 1 300px;可扩大可缩小,就是始终占满*/
  border: 1px solid red;
  background: lightpink;
  font-size: 2rem;
  text-align: center;
}
body {
  font-family: system-ui, serif;
}
</style>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
<div class="parent">
  <div class="child">1</div>
  <div class="child">2</div>
  <div class="child">3</div>
</div>
</body>
</html>
```
- 指定 flex 布局, `felx-wrap:wrap;`设置可换行
- `flex: <flex-grow> <flex-shrink> <flex-basis>;`
- flex: <初始宽度>  <足够宽时是否扩大>  <宽度不够时是否缩小> 

## 两栏式
一边保持,另一边伸缩

![](/images/CSSFiveClassicLayouts/5.png)

![](/images/CSSFiveClassicLayouts/6.png)

```html
<!DOCTYPE html>
<html lang="en">
<style>
body {
  display: grid;
  grid-template-columns: minmax(150px, 25%) 1fr;
  padding: 0;
  margin: 0;
}
.sidebar {
  height: 100vh;
  background: lightpink;
  font-size: 2rem;
  text-align: center;
}
.content {
  padding: 2rem;
}
body {
  font-family: system-ui, serif;
}
</style>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
<div class="sidebar" contenteditable>
  Min: 150px
  <br/>
  Max: 25%
</div>
<p class="content" contenteditable>
  Lorem ipsum dolor sit amet consectetur adipisicing elit. Omnis nulla architecto maxime modi nisi. Quas saepe dolorum, architecto quia fugit nulla! Natus, iure eveniet ex iusto tempora animi quibusdam porro?</p>
</body>
</html>
```
- `grid-template-columns: minmax(150px, 25%) 1fr;`
- minmax(150px, 25%) 左边最小150px,最大为总宽度25%
- 1fr 右边为剩余宽度

## 三明治
垂直分为三部分：页眉,内容,页脚;基本上只是内容区在变化

![](/images/CSSFiveClassicLayouts/7.png)

![](/images/CSSFiveClassicLayouts/8.png)

- `grid-template-rows: auto 1fr auto;` 上中下

## 圣杯
页面分为五个部分：页眉,页脚,内容区划分为左边栏,主栏,右边栏

![](/images/CSSFiveClassicLayouts/9.png)

- 指定 Grid 布局
- `grid-template: <grid-template-rows> / <grid-template-columns>`
- `grid-template: auto 1fr auto / auto 1fr auto` 上中下都分成三部分


## 参考站点
- [1linelayouts (https://1linelayouts.glitch.me/)](https://1linelayouts.glitch.me/)
