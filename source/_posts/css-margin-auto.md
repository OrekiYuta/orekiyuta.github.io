---
title: CSS margin:auto;How it Works
date: 2020-11-30 10:53:25
tags: CSS
---

## Auto
- margin:auto 通常用作元素水平居中
- 首先得知道，在定义中 auto 可以随着元素、元素类型和上下文而变化
    - 在 margins 中，auto 可以占用可用空间或者占用 0 px

## margin 水平空间
- 对于 margins , auto 作为 left 和 right 的值的时候，它们会在水平上均分可用空间，因此它们使得元素在中心
- 但是它们也仅仅适用于水平 margins , 并不能和带有 float、inline 的元素共用；也不适用在 absolute 和 fixed position 的元素中

- 当只给 margin 其中一边设置为 auto 时，该元素会向另一边倾向
    - 当 margin-left:auto 时，元素的左边会空出一定的空间，而右边空间被元素占完
<!-- more -->
- 正如前面所说， auto 无法使用在 floated ,inline 和 absolute的元素中，因为它们的布局已经被决定了，所以无法用 margin:auto 使元素居中
    - 如果设置 margin:auto 的话，结果就为 margin:0px

- auto 对于没有宽度的 block 元素也不起作用

## margin 垂直空间

- auto 在 margin 的 top 和 bottom 上始终计算为 0px (除了 absolute 元素)

```
 W3C spec says it like this:

 “If “margin-top” or “margin-bottom” is “auto”, their used value is 0″
```
- 👉[10 Visual formatting model details](https://www.w3.org/TR/CSS21/visudet.html#Computing_heights_and_margins)

- 也可能是垂直页面流的原因，使得元素在页面垂直方向上不居中，因为页面大小会随着高度方向增加
- 但是 absolute 元素可以使得该元素沿着整个页面的高度垂直居中

## 绝对元素居中定位

```
This is where another W3C spec comes in:

"If all three of “left”, “width”, and “right” are “auto”: First set any “auto” values for “margin-left” and “margin-right” to 0… "

"If none of the three is “auto”: If both “margin-left” and “margin-right” are “auto”, solve the equation under the extra constraint that the two margins get equal values"
```

- 说明水平 auto margins 要占用一样的空间，它们的left,width和right都不应该是 auto
- 因此我们要在一个绝对定位的元素中给它们一些值，使得水平居中

```
The spec also mentions something similar for vertical margins.

“If all three of “top”, “height”, and “bottom” are auto, set “top” to the static position…”

“If none of the three are “auto”: If both “margin-top” and “margin-bottom” are “auto”, solve the equation under the extra constraint that the two margins get equal values…”
```
- 要使得绝对元素垂直居中，它的 top,height,bottom的值都不能为 auto

## 结论

- 如果想要某个元素向左或者向右靠，可以设置另一边的 margin:auto
- 可以将某个元素转为绝对定位使其垂直居中，但是这不是个好方法
     - 用 flexbox 和 CSS transform 可能更适合

- 👉[https://www.hongkiat.com/blog/css-margin-auto/](https://www.hongkiat.com/blog/css-margin-auto/)
