---
title: Switch to ES6
date: 2019-12-13 20:01:02
tags: [ES6,ECMAScript]
---

### <center>let</center>

#### 变量i的作用域
```js
//ES5
if (true) {
    var i = 1;
}
console.log(i);

//ES6
if (true) {
    let i = 1;
}
console.log(i); //变量i未找到
```

#### 重复定义
```js
var i = 0;
switch (i) {
  case 0:
    let value = "hello";
    break;
  case 1:
    let value = "world"; //重复定义错误
    break;
}
```
<!-- more -->
### <center>const 定义常量</center>

```js
const data = 10;
console.log(data);
//data = 100; //执行错误 , 不能给常量赋予新值

const list = [10,20,30]; //定义了list常量是数组
console.log(list);

list[0] = 100;          //数组内值可以变
console.log(list);

//list = [1,2,3]; //错误 , 常量list数组不能重新赋值
```
定义常量为数组时 , 常量数组内部值可以改变 , 但是常量不能重新赋值

### <center>进制转换</center>

- 0b:二进制
- 0o:八进制
- 0x:十六进制
```js
console.log(0b10); //2
console.log(0o10); //8
console.log(0x10); //16

console.log(0b11 === 3); //true
console.log(0o10 === 8); //true
console.log(0x10 === 16);//true

let num = 10;
console.log(num.toString(8)); //8进制转换
console.log(num.toString(2)); //2进制转换
console.log(num.toString(16));//16进制转换
console.log(num.toString(5)); //5进制转换
```

### <center>字符串解析</center>

#### 嵌入字符串
```js
let name = "Elias"
let mystr1 = "你好，${name}!"
let mystr2 = `你好，${name}！再见。`  //注意这里是反单引号

console.log(mystr1)     //你好，${name}!
console.log(mystr2)     //你好，Elias！再见。
```

#### 字符串模板
```js
let name = "Elias"

function tagged(formats, ...args){
    console.log(formats)
    console.log(args)
}
tagged`你好，${name}！再见。`

/*  
[ '你好，', '！再见。' ]
[ 'Elias' ]
/*
```
按 `${ }` 模板分割字符串输出形成

```js
let name1 = "Elias"
let name2 = "Mark"
let name3 = "Mier"
let name4 = "Tres"
function tagged(formats, ...args){
    console.log(formats)
    console.log(args)
}

tagged`${name1}你好，${name2}！${name3}再见。${name4}`

/*  
[ '', '你好，', '！', '再见。', '' ]
[ 'Elias', 'Mark', 'Mier', 'Tres' ]
/*
```
当字符串模板出现在首位或末位时, 非模板数组输出空值在首位或末位

```js
let name1 = "Elias"
let name2 = "Mark"
let name3 = "Mier"
let name4 = "Tres"
function tagged(formats, args){ //去掉 ...扩展运算符
    console.log(formats)
    console.log(args)
}

tagged`${name2}你好，${name1}！${name3}再见。${name4}`

/*  
[ '', '你好，', '！', '再见。', '' ]
Mark
/*
```
详细可查 👉[ECMAScript](http://es6.ruanyifeng.com/#docs/array)

#### 模板和表示形式
```js
let name = "Elias"
let address = "网吧"
let fmtstr = markdown`你好，${name}！
晚上一起去${address}玩吗？
等你的回信。`
console.log(fmtstr)

function markdown(formats, ...args){
  console.log(formats)
  console.log(args)
  var result = "# 信息标题\n";
  for(var i = 0; i < formats.length; i++)
//   console.log(args[i] || '')
    result += formats[i] + "**" + (args[i] || '') + "**";
  return result;
}

/*  
[ '你好，', '！\n晚上一起去', '玩吗？\n等你的回信。' ]
[ 'Elias', '网吧' ]
# 信息标题
你好，**Elias**！
晚上一起去**网吧**玩吗？
等你的回信。****
/*
```
把模板和表示形式分离

### <center>Symbol类型</center>

#### 概念
```js
let str1 = String("helloWorld");
let str2 = String("helloWorld");
console.log(str1 == str2);  //结果：true
console.log(str1 === str2); //结果：true

let s1 = Symbol("mySymbol");
let s2 = Symbol("mySymbol");
console.log(typeof s1);     //结果：symbol
console.log(s1.toString()); //结果：Symbol(mySymbol)
console.log(s1 == s2);      //结果：false
console.log(s1 === s2);     //结果：false
```
对于 `s1 == s2` : Symbol类型会分配一个内部哈希值 , 所以在比较的时候是用哈希值作比较 ,而不是用赋予的 value 值作比较 , 所以不相等

#### 作为常量
```js
const Java = Symbol();
const Ruby = Symbol();
const Perl = Symbol();
const Php  = Symbol();
const VB   = Symbol();

var lang = Php;

if (lang === Java) {
    console.log('Java的未来在哪里？');
}
if (lang === Ruby) {
    console.log('再学个Ruby on Rails吧。');
}
if (lang === Php) {
    console.log('再学个Ruby on Rails吧。'); //输出这个
}
```
这样就可以直接根据常量名判断了

#### 作为属性
首先理解下面这个
```js
let s1 = String("mySymbol");
let s2 = String("mySymbol");

var obj = {};
obj[s1] = "hello";
obj[s2] = "world";

console.log(obj);
console.log(obj[s1]);
console.log(obj[s2]);

/*  
{ mySymbol: 'world' }
world
world
*/
```
- 首先 s1 、s2 的值都为 mySymbol
- 然后给对象 obj 的 s1 键（mySymbol）赋 hello 值 
- 然后给对象 obj 的 s2 键（mySymbol）赋 world 值 , 由于是同一个键就把上面的覆盖了

```js
let s1 = Symbol("mySymbol");
let s2 = Symbol("mySymbol");

var obj = {};
obj[s1] = "hello";
obj[s2] = "world";

console.log(obj);
console.log(obj[s1]);
console.log(obj[s2]);

/*  
{ [Symbol(mySymbol)]: 'hello', [Symbol(mySymbol)]: 'world' }
hello
world
*/
```
接着这里就好理解了

#### 半隐藏属性
```js
const MYKEY = Symbol();
class User {
    constructor(key,name,age){
        this[MYKEY] = key;
        this.name = name;
        this.age = age;
    }
    checkKEY(key){
        return this[MYKEY] === key;
    }
}

let user = new User(123, 'Curry', 29);
console.log(user.name, user.age, user[MYKEY]); //Curry 29 123
console.log(user.checkKEY(123));   //true
console.log(user.checkKEY(456));   //false
console.log(Object.keys(user));    //[ 'name', 'age' ]    这里用Object.key列出user对象的所有属性
console.log(JSON.stringify(user)); //{"name":"Curry","age":29}   用JSON字符串化
```

### <center>解构赋值</center>

#### 数组赋值
```js
let [a, b, c] = [10, 20, 30];
console.log(a, b, c); //10 20 30

let [x, y, ...other] = [1,2,3,4,5];
console.log(x, y, other); //1 2 [ 3, 4, 5 ]
```

#### 对象赋值
```js
let {name, age} = { age: 20 , name: 'Elias'}; 
console.log(name, age); //Elias 20
```

#### 函数赋值
```js
function func1() {
    return [10, 20];
}
let [num1, num2] = func1();
console.log(num1, num2); //10 20
```

#### 函数参数名指定
```js
function func2({x=1, y=2}){
    return x+y;
}
console.log(func2({}));           //3
console.log(func2({x:10}));       //12
console.log(func2({y:10}));       //11
console.log(func2({x:10, y:20})); //30
```

### <center>数组循环 for...of</center>

```js
let list = [10, 20, 30];
Array.prototype.Len = function(){};

for(let val of list)
    console.log(val);

for(let val in list)
    console.log(val, list[val]);

/*
10
20
30
0 10
1 20
2 30
Len function(){}
*/
```
- for...of 只关心 list 内的值
- for...in 关心 lis t所有的属性,可根据 `Array.prototype.Len = function(){}` 得出结论
- 前者把 list 当作数组 , 后者把 list 当作变量

### <center>函数默认值</center>

```js
//字符参数
function sayhello(name = "Curry"){
    console.log(`Hello ${name}`);
}
sayhello(); //Hello Curry
sayhello("Elias"); //Hello Elias

//数值计算
function add(a=1, b=a){
    return a+b;
}
console.log(add());  //2
console.log(add(10));  //20
console.log(add(10, 20));  //30

//必须指定参数
function required(){
    throw new Error("参数未制定");
}
function sayBye(name=required()){
    console.log(`${name} bye!`);
}
sayBye('Elias');  
sayBye();

/* 
Elias bye!
C:\Users\OrekiYuta\Desktop\test.js:18
    throw new Error("参数未制定");
    ^

Error: 参数未制定
    at requir1ed (C:\Users\OrekiYuta\Desktop\test.js:18:11)
    at sayBye (C:\Users\OrekiYuta\Desktop\test.js:20:22)
    at Object.<anonymous> (C:\Users\OrekiYuta\Desktop\test.js:24:1)
    at Module._compile (internal/modules/cjs/loader.js:776:30)
    at Object.Module._extensions..js (internal/modules/cjs/loader.js:787:10)
    at Module.load (internal/modules/cjs/loader.js:653:32)
    at tryModuleLoad (internal/modules/cjs/loader.js:593:12)
    at Function.Module._load (internal/modules/cjs/loader.js:585:3)
    at Function.Module.runMain (internal/modules/cjs/loader.js:829:12)
    at startup (internal/bootstrap/node.js:283:19)
*/
```

### <center>可变长参数</center>

```js
function sum(...args) {
    let result = 0;
    args.forEach(val => {
        result += val;
    });
    return result;
}

console.log(sum(1,2,3));  //6
console.log(sum(1,2,3,4,5,6,7,8,9,10));  //55

```
```js
args.forEach(val => {
        result += val;
    });

//相当于
args.forEach(function(val){
        result += val;
    });
```

### <center> 箭头函数 => </center>

```js
let list = [10, 20, 30];

//ES5
let newlist = list.map(function(value, index){ //value 数组值 , index //索引下标
    return value * value;
});
console.log(newlist);

// ES6
//(1)
newlist = list.map((value, index) => {
    return value * value;
});
console.log(newlist);

//(2)
newlist = list.map(value => {
    return value * value;
});
console.log(newlist);
```
let 写不写都可以

### <center>基本对象定义</center>

```js
let title = "ES6从入门到外出";
let price = 25;
let publish = "Elias出版社";

let book = {
    title, price, publish,
    toString(){
        console.log(`<<${this.title}>> is ${price}元。`); //this 加不加都可以
    }
};
book['lang'] = "简体中文"; //给book对象添加了成员变量

console.log(book);
/*
{ title: 'ES6从入门到外出',
  price: 25,
  publish: 'Elias出版社',
  toString: [Function: toString],
  lang: '简体中文' }
*/
book.toString();
//<<ES6从入门到外出>> is 25元。
```

### <center>类定义 class</center>

```js
class Player {
    //关键字 constructor 构造器
    constructor(name, sex) {
        this.name = name; //这里隐式定义了变量 name , sex
        this.sex = sex;
    }
    show(){
        console.log(`${this.name}的性别是${this.sex}。`); //这里必须 this , 否则找不到该变量
    } 
    static info(){  //static 方法 , 不用实例化就可以引用
        console.log("这是一个球员类，您可以使用它建立自己的球员。");
    }
}

let Curryplayer = new Player("库里", "男");
console.log(Curryplayer.name, Curryplayer.sex); //库里 男
Curryplayer.show();//库里的性别是男。
Player.info();//这是一个球员类，您可以使用它建立自己的球员。
```

### <center>getting / setting 定义</center>

```js
class Player {
    constructor(name, sex) { 
        this.name = name;
        this.sex = sex;
    }

    get age(){
        return this.Age;
    }
    set age(val){
        this.Age = val;
    }
}

let Curryplayer = new Player("库里", "男");
console.log(Curryplayer);
Curryplayer.Age = 28;  //设置值,调用了set
console.log(Curryplayer);
console.log(Curryplayer.Age); //取值,调用了get

/* 
Player { name: '库里', sex: '男' }
Player { name: '库里', sex: '男', Age: 28 }
28
*/
```

### <center>类继承</center>

```js
class Car {
    constructor(brand){
        this.brand = brand;
    }
    show(){
        console.log(`本台车的品牌是${this.brand}`);
    }
}

class Lexus extends Car {
    constructor(brand, lineup) {
        super(brand); //调用父类构造器 , 初始化brand属性
        this.lineup = lineup;
    }
    getPrice(){
        switch(this.lineup){
            case "RX":
                return 60;
            case "NX":
                return 40;
            default:
                throw new Error("未知车类别");  //抛出异常
        }
    }
}

let mycar = new Lexus("Lexus", "RX");
mycar.show();  //调用父类方法
console.log("价格是：", mycar.getPrice(), "万"); //调用自己的方法

/*
本台车的品牌是Lexus
价格是： 60 万
*/
```

### <center>循环对象</center>

```js
let list  = [10, 20, 30];
let mystr = '你好啊';
let mymap = new Map();
mymap.set('JS', 'Javascript');
mymap.set('PL', 'Perl');
mymap.set('PY', 'Python');

for(let val of list){
	console.log(val);
}
/* 
10
20
30 
*/
for(let val of mystr){
	console.log(val);
}
/* 
你
好
啊
*/
for(let [key,value] of mymap){
	console.log(key, value);
}
/* 
JS Javascript
PL Perl
PY Python
*/
let it = mymap.values();  //it 迭代器
let tmp;    
while(tmp = it.next()){   //next() : 取mymap对象下一个值 , 如果有下一个值就取出 , 没有就退出
    if (tmp.done) break;   // done : 表明是否最后一个 , false:还有下一个值继续执行 , true , 遍历完成
    console.log(tmp.done)
    console.log(tmp.value);
    console.log(tmp)
    console.log("----------")
}

console.log(tmp)
console.log(tmp.done)

/* 
false
Javascript
{ value: 'Javascript', done: false }
----------
false
Perl
{ value: 'Perl', done: false }
----------
false
Python
{ value: 'Python', done: false }
----------
{ value: undefined, done: true }
true 
*/
```


### <center>实现可迭代对象</center>
普通的数组内的值可以用 for..of 循环出来 , 因为是在数组内部实现了迭代器 , 因为这些在底层就已经定义好了的。平时使用起来没感觉到而已。

但是我们自己定义的对象是没有这种功能的,平常实例化的时候多数只是传递一个参数,但是当我们给对象传递了一个数组的时候呢,如何取去操作多个对象呢。

这里就需要在我们自己定义的类里面去实现迭代器接口

```js
class Player {
	constructor(list){
		this.list = list;
	}
	[Symbol.iterator](){   //[Symbol.iterator](){}
		let current = 0;    //索引
		let that = this;     //this 在不同作用域的里代表的内容不一样 ; this在这里是指整个类对象;所以这个过程是把整个Player对象赋给that
		return {             //因为在后面this的内容会发现变化,所以先把this转移到that中
			next(){         //接口里的一个方法,这里是实现next接口
                return current < that.list.length ? {value:that.list[current++], done:false} : {done:true};
                //当前索引小于传进来的数组的长度就把当前这个值赋给value
			}
		};
	}
}

let player = new Player(['Curry', 'Harden', 'LeBron']);
console.log(player)
for(let tmp of player){
	console.log(tmp);
}
/* 
Player { list: [ 'Curry', 'Harden', 'LeBron' ] }
Curry
Harden
LeBron
*/
```
因为在Player类里面实现了迭代器接口,所以我们才能用 for...of 遍历

`Player { list: [ 'Curry', 'Harden', 'LeBron' ] }` Player 对象里是个键值对
```js
//修改一下构造器,观察结果
class Player {
	constructor(AAA){
		this.BBBlist = AAA;
	}
	[Symbol.iterator](){   
		let current = 0;    
		let that = this;    
		return {            
			next(){         
                return current < that.BBBlist.length ? {value:that.BBBlist[current++], done:false} : {done:true};
			}
		};
	}
}
/* 
Player { BBBlist: [ 'Curry', 'Harden', 'LeBron' ] }
Curry
Harden
LeBron
*/
```
```Js
//修改参数,观察结果
let player = new Player('Curry');
/* 
Player { BBBlist: 'Curry' }
C
u
r
r
y
*/
```
```js
let player = new Player();
/* 
Player { BBBlist: undefined }
*/
```

### <center>简单迭代器</center>
- function* {  } : 迭代生成器
- yield : 迭代返回

```js
function* myGenerator() {
	yield '一';
	yield '条';
	yield '大';
	yield '河';
}

for(let val of myGenerator()){  //注意这里是 myGenerator() 
	console.log(val);
}
/* 
一
条
大
河
*/
```
```js
//这里可以用在读取数据库结果集时
function* countdown(begin){
	while(begin > 0){
		yield begin--; //先返回再自减
	}
}

for(let tmp of countdown(5)){
	console.log(tmp);
}
/* 
5
4
3
2
1
*/
```
yield 就类似方法里的 return , return 一般都是只有一个 , 而 yield 能有多个 , 并且每次能返回不同的内容

👉[理解 ES6 Generator 函数 -- yield](https://zhuanlan.zhihu.com/p/36699390)

### <center>实现可迭代对象 - yield</center>

```js
class MyList {
	constructor(list){
		this.list = list;
		this[Symbol.iterator] = function*(){
			let current = 0;
			let that = this;
			while(current < that.list.length){
				yield that.list[current++];
			}
		}
	}
}

let mylist = new MyList([100, 200, 300, 400, 500]);
for(let val of mylist){
	console.log(val);
}
```