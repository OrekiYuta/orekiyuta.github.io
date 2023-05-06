---
title: JavaScript get/set
date: 2020-12-05 22:03:45
tags: JavaScript
---

## 用原生 JavaScript 实现数据-单向绑定

- 首先得知道,在 JavaScript 中为一个对象赋值会触发对象的 set 属性方法,而获取对象则会触发 get 属性方法

```html
<input  id="inputurl">
<input  id="inputpost">
<input  id="inputparam">
<p id ="texturi"></p>
```
- 实现单向绑定只需要设置 get 属性方法即可
- 通过监听元素的 keyup 动作,然后执行方法,在方法中获取对象即可触发 get 属性方法

```js
var url = {
    get inputValue() { 
        xurl = document.getElementById('inputurl').value;
        return xurl;
    }
}
var post = {
    get inputValue() { 
        return document.getElementById('inputpost').value;
    }
}
var param = {
    get inputValue() { 
        return document.getElementById('inputparam').value;
    }
}

document.getElementById('inputurl').addEventListener('keyup',function() {
    uri = url.inputValue + post.inputValue + param.inputValue
    document.getElementById('texturi').innerHTML = uri
})
document.getElementById('inputpost').addEventListener('keyup',function() {
    uri = url.inputValue + post.inputValue + param.inputValue
    document.getElementById('texturi').innerHTML = uri
})
document.getElementById('inputparam').addEventListener('keyup',function() {
    uri = url.inputValue + post.inputValue + param.inputValue
    document.getElementById('texturi').innerHTML = uri
})
```
<!-- more -->
- ![](/images/JSgetter-setter/1.png)
- ![](/images/JSgetter-setter/2.png)
- ![](/images/JSgetter-setter/3.png)

## 实现数据-双向绑定 / “ 三绑一！？ ” 
- 实现双向绑定就再设置 set 属性方法即可

### DOM 操作

```js
var url = {
    get inputValue() { 
        xurl = document.getElementById('inputurl').value;
        return xurl;
    },
    set inputValue(newVal){     
        document.getElementById('inputurl').value = newVal;
        xpost = document.getElementById('inputpost').value
        xparam = document.getElementById('inputparam').value
        document.getElementById('texturi').innerHTML = newVal + xpost + xparam;        
    }
}
var post = {
    get inputValue() { 
        return document.getElementById('inputpost').value;
    },
    set inputValue(newVal){     
        document.getElementById('inputpost').value = newVal;
        xurl = document.getElementById('inputurl').value
        xparam = document.getElementById('inputparam').value
        document.getElementById('texturi').innerHTML = xurl + newVal + xparam;        
    }
}
var param = {
    get inputValue() { 
        return document.getElementById('inputparam').value;
    },
    set inputValue(newVal){     
        document.getElementById('inputparam').value = newVal;
        xurl = document.getElementById('inputurl').value
        xpost = document.getElementById('inputpost').value
        document.getElementById('texturi').innerHTML = xurl + xpost + newVal;        
    }
}

document.getElementById('inputurl').addEventListener('keyup',function() {
    uri = url.inputValue + post.inputValue + param.inputValue
    document.getElementById('texturi').innerHTML = uri
})
document.getElementById('inputpost').addEventListener('keyup',function() {
    uri = url.inputValue + post.inputValue + param.inputValue
    document.getElementById('texturi').innerHTML = uri
})
document.getElementById('inputparam').addEventListener('keyup',function() {
    uri = url.inputValue + post.inputValue + param.inputValue
    document.getElementById('texturi').innerHTML = uri
})
```
- 双向绑定在这里指的是 input 输入框内的值改变, p 标签的值同时也在变,并且 p 标签的值更改, input 输入框内的值也会更改

- 在这里直接在 console 操作 DOM 的话,并不会触发 input 的监听方法,所以数据没有同步
- ![](/images/JSgetter-setter/4.png)
- 我们可以直接调用对象的 set 属性方法,让数据同步 
- ![](/images/JSgetter-setter/5.png)

- 在这里值得注意的是 url 对象的名称和它 get 方法里的变量名 xurl 最好不要同名
- ![](/images/JSgetter-setter/6.png)
- 因为从 input 输入值后,执行 url 对象的 get 方法,然后里面的变量就被初始化出来了
- 如果 get 方法里面的变量名和对象名一样的话,就会定位不到变量 undefined


- 同名的话就会出现以下问题:
    - ![](/images/JSgetter-setter/7.png)
    - 上图是未在 input 输入之前先在 console 获取了 url , 是一个对象 ,正常
    - ![](/images/JSgetter-setter/8.png)
    - 然后 input 输入内容后, 再次获取 url 就是一个 undefined 
        - 在此我目前猜测可能是:
        - (1)触发 set 属性方法后, url 对象实例化之后 变量 url 也初始化成功了,因为同时存在两个 url 名称,一个为 url 对象,一个为 url 变量,所以 DOM 操作无法分辨出应该赋值给哪个 url ,造成异常抛出,结果 url 就为初始值 undefined
        
    - ![](/images/JSgetter-setter/9.png)
    - 紧接着,上图是先在 input 输入内容后 ,再获取的 url 
        - 结合这两张图的操作,再次猜测:
        - 这两图的区别在于是否先在 console 里获取了 url 对象 , 可能获取 url 对象的过程是一个实例化的过程
        - (1)的猜想就改变了,可能在触发 set 前已经实例化了一个 url 对象,后面触发的时候 url 对象由于已有同名对象,后者 url 对象就被未实例化,因此里面的 url 就没初始化成功
        - (2) 上图的 url 获取到了输入内容的首个字符,多次测试后,发现获取字符也是不确定的,这里猜测在这里实例化了 url 对象,之后 url 变量把 url 对象给覆盖了
        - 这里可能要对浏览器执行过程,加载 DOM 和操作系统有更深的理解才能有结果

### 对象调用

```js
var obj = {};
var inputurl = document.getElementById("inputurl");
var inputpost = document.getElementById("inputpost");
var inputparam = document.getElementById("inputparam");
var texturi = document.getElementById("texturi");

Object.defineProperties(obj, {

    "inputurl":{
        get:function(newVal){
            inputurl.value = newVal;
            texturi.innerHTML = newVal;
        },
        set:function(newVal){

            inputurl.value = newVal.url;
            texturi.innerHTML = newVal.uri;
        }
    },
    "inputpost":{
        get:function(newVal){
            inputpost.value = newVal;
            texturi.innerHTML = newVal;
        },
        set:function(newVal){

            inputpost.value = newVal.post;
            texturi.innerHTML = newVal.uri;
        }
    },
    "inputparam":{
        get:function(newVal){
            inputparam.value = newVal;
            texturi.innerHTML = newVal;
        },
        set:function(newVal){
            inputparam.value = newVal.param;
            texturi.innerHTML = newVal.uri;
        }
    },

});
inputurl.addEventListener('input', function(e){
    inputuri = e.target.value + inputpost.value + inputparam.value;
    obj.inputurl = {uri:inputuri , url:e.target.value}

});
inputpost.addEventListener('input', function(e){
    inputuri = inputurl.value + e.target.value + inputparam.value;
    obj.inputpost = {uri:inputuri , post:e.target.value}
});
inputparam.addEventListener('input', function(e){
    inputuri = inputurl.value + inputpost.value + e.target.value;
    obj.inputparam = {uri:inputuri , param:e.target.value}
});
```
- 在这里的话,问题就在于 set 属性方法只能传递一个值,因此可以通过传对象去传多个值
- ![](/images/JSgetter-setter/10.png)

## 参考文章
- [浅谈 JS 对象添加 getter与 setter 的5种方法以及如何让对象属性不可配置或枚举](https://segmentfault.com/a/1190000003882976)
- [set方法只能接受一个参数吗？](https://www.imooc.com/qadetail/125923)
- [关于javascript：为什么这个函数用括号括起来，后面跟着括号？](https://www.codenong.com/5815757/)
- [关于iife：javascript中的 (function() { } )() 构造是什么？](https://www.codenong.com/8228281/)
- [JavaScript addEventListener : 'input' versus 'keyup' [duplicate]](https://stackoverflow.com/questions/39718122/javascript-addeventlistener-input-versus-keyup)