---
title: Learn to use Vue.js
date: 2019-12-05 19:17:00
tags: Vue.js
---

## <center> How to use Vue.js </center>

### 引入 Vue.js
![](/images/Vue/01.png)

- 引入Vue.js , 实例化一个对象 myApp,里面的 el , data 为关键字

- el 相当于元素选择器 element，这里 `#App` 选择了 `id="App"` 的元素

- data 里面定义任意名称字段，然后在 *双大括号*  中显示

## <center> v-if 、 v-for </center>

### 基础用法
![](/images/Vue/02.png)

- `v-if="seen"`中的 seen 关联了 data 中 seen , v-if 中的参数为 true 则显示,反之

- `v-for="fruit in fruits"` 中的 fruits 关联了 data 中的 fruits , 遍历fruits 数组中的内容赋给 fruit , 最后在 *双大括号*  取 fruit 对象中的值

### v-if 、v-else-if 、v-else
![](/images/Vue/12.png)

- 这个比较容易理解 , 直接在后面写入表达式 , 然后根据结果真假进行显示与否

![](/images/Vue/12-1.png)
<!-- more -->

### 数组列表渲染-添加索引
![](/images/Vue/14.png)

- 这里对比前面的循环多了个索引 index , 主要表示了当前对象在数组列表中的位置

    ![](/images/Vue/14-1.png)

### 对象迭代
![](/images/Vue/15.png)

- 取出 mygame 对象中的键值对

    ![](/images/Vue/15-1.png)

- 值得注意的是 `(value, key) in mygame` 中键值对的顺序 , 前者必定是值 , 后者必定是键 , 这是设计初就定义好的。

- 命名 value 和 key 只是为了提高可读性而已 , 其实取什么名都不影响结果

    ![](/images/Vue/15-2.png)
        
    ![](/images/Vue/15-3.png)


## <center> v-show </center>

设置元素状态为显示

![](/images/Vue/13.png)

- 这个也好理解 , 根据 result 对象的布尔值进行显示或隐藏

- 这个与 v-if 的区别在于 v-if 是对 DOM 进行操作的 , 而 v-show 只是设置了标签的 display 属性而已 , 并没有操作 DOM

![](/images/Vue/13-1.png)

![](/images/Vue/13-2.png)

## <center> v-model </center>

为元素进行数据绑定

![](/images/Vue/03.png)

- 首先 data 中的 myName 的值是双向绑定到了 `{{myName}}` 中 , 初始文本为 myName 的值

- 然后我想修改 `{{myName}}` 的值怎么办,那就为一个元素设置 `v-model` 属性,属性值就设为想要绑定的那个字段名即可,这里就设置为 `v-model="myName"`

- 最终在input中输入的结果会呈现在 *双大括号*  中

## <center> v-bind:class </center>

### 为元素的 class 属性绑定值
![](/images/Vue/10.png)

- 首先常规的元素 class 一般为 `<p class="xxx" />` 的形式 , 这样的形式只能不断的在其后面添加 class 名才能对元素加以控制,显得不够灵活

- Vue 能够用过 Js 对其 class 属性进行控制 , 提高了 class 属性的复用性

- 这里 `v-bind:class="{active:isActive}"` 意思是首先有一个 `class="active"` 的元素 , 我们突然不想让它的 class 值为 active 了 , 怎么办 ? 但是又不可能随时手工去移除 , 所以就在双引号内写入表达式 `{active:isActive}` 

- `active:isActive` 中的 isActive 可任意取名 , 然后在 data 中给 isActive 字段赋予一个布尔值 , 然后 v-bind:class 就能根据双引号内的表达式进行布尔判断 , 实现显示与移除

- `v-bind:class` 可简写为 `:class`

    ![](/images/Vue/10-1.png)

    ![](/images/Vue/10-2.png)

### 为元素的 class 属性绑定对象
![](/images/Vue/11.png)

- 上面的例子是在 class 属性的双引号内写入表达式 , 然后绑定了样式的属性名

- 这里的话 , 直接在双引号内输入任意字段名 , 然后在 data 中写入该字段名对象 , 接着在该对象内写入布尔参数

- 最终效果为 class 绑定了 myClass 对象 ，class 属性根据对象内容的参数布尔值 , 实现了同时对一个元素添加多个属性值效果
    
    ![](/images/Vue/11-1.png)

    ![](/images/Vue/11-2.png)

## <center> v-on </center>

### 为元素进行事件绑定
![](/images/Vue/04.png)

- `v-on:click` 绑定了一个点击事件,点击事件 `btnClick('Orekiyuta')` 的方法名为 btnClick ,关联了 myApp 实例中的 methods 关键字中的 btnClick 字段 , 然后把方法里的值赋给了 data 中的 myName 

- `v-on:` 可简写为 `@`

- 同理,其他事件也是这样 ( keydown , keyup , dbclick , load , etd . )

### v-on:(event)
![](/images/Vue/16.png)

- `v-on:keyup="txtKeyup($event)"` 在这里 `$event` 为关键字获取事件内容 , 不能修改成其他 

- `v-on:keyup="txtKeyup($event)"` 和 `v-on:keyup="txtKeyup"` 为一样的效果 , 默认为获取事件

- v-on:(event) 可简写为 @(event) , 例如 `@keyup="txtkeyup"`

    - 松开按键

    ![](/images/Vue/16-1.png)

    - 点击按钮

    ![](/images/Vue/16-2.png)

- 修改方法形参不影响结果 , 形参定义成 event 也是便于理解而已 ; `v-on:(evenr)` 获取了键盘的事件传给方法的形参 , 形参接受了数据在函数里做相应的处理

    ![](/images/Vue/16-3.png)   

## <center> Component </center>

组件 , 把当个页面拆分开成各个部件的一种思想,把页面各个部分认为是一个组件,然后操作各个组件元素,最后重新组合为页面;也是一种解耦思想吧

![](/images/Vue/05.png)

- 在这里首先是自定义了一个名为 orekiyuta 的 component , 然后设置了它的 pros 和 template 

- 这个组件在代码中表现为 `<orekiyuta/>` 的形式 , 它的 pros 可理解为接受传入的数据 , template 则是定义了 `<orekiyuta/>` 最终会渲染成何种元素,这里为 `<li/>`

- 最终结果是从数组 fruits 中遍历数据赋给 fruit , 然后 `v-bind` 把 fruit 和 组件的名为 eatfruits 的 props 绑定在一起 , 这样就可以在 template 中通过 `eatfruits.name` 取得数据

## <center> Filters </center>

过滤器 , 把元数据格式化输出,就是把所得到的数据改变下输出格式,常见的日期格式就个例子,
把数据和其表现形式分离操作,也是MVC常用的一种思想

![](/images/Vue/06.png)

- 用法为在需要格式化的数据后加上管道符和过滤器名 ` XXX | filterName `
- filters 和 methods 内容为同样的写法 , 也就关键字不一样而已

## <center> Computed </center>

计算属性 , 用于把从服务端传过来的元数据加以计算处理的,这样有便于各种不同算法处理的同一数据的展示

![](/images/Vue/07.png)

- 和前面 methods 、filters 写法一样 , 差别在于用法
- 用法直接在 *双大括号*  中写入计算属性的方法名

## <center> Watch </center>

监听属性 , 用于监听变量的变化,然后执行相应处理

![](/images/Vue/08.png)

- 用法为在 Watch 关键字内 写入需要监听的变量,这里监听了 data 中的 变量 price 
- 一旦 price 的值发生改变,就触发后面的 `function (newVal, oldVal)` , 方法中的默认形参为新值和旧值
- 和前面的计算属性不一样的是 , 在这里 `{{priceInTax}}` `{{priceChinaRMB}}` 是定义为变量输出的

    ![](/images/Vue/08-1.png)

    ![](/images/Vue/08-2.png)

- 这样一来 priceInTax 和 priceChinaRMB 初始值为 0 , 而我们想在页面第一次加载的时候就让三种价格输出

    ![](/images/Vue/08-3.png)

- 这样就可以在这个Vue对象实例的时候先不给 price 赋值,而在它实例化完成之后再对 price 赋值 , 这样监听属性就能执行一次处理

    ![](/images/Vue/08-4.png)

## <center> Setter </center>

设置计算属性 , 之前的计算属性只是单纯的取出数据 get , 这里多了个存数据方法 set

![](/images/Vue/09.png)

- 首先页面初始化时会先读取 price 、priceInTax 、priceChinaRMB 各自的值 ; priceInTax 触发的是 get 方法 , 根据 price 值计算出了 priceInTax 的值

- 然后点击事件给计算属性中的 priceInTax 赋予了一个新的值 , 触发 priceInTax 的 set 方法 ,根据 priceInTax 的值 计算出 Price 的 值

## <center> 表单 </center>

### 文本框
`input[type="text"]` : 用  `v-model` 为表单文本框绑定变量 , 实现数据同步

![](/images/Vue/17.png)

![](/images/Vue/17-1.png)

### 复选框
`input[type="checkout"]` : 用  `v-model` 绑定复选框 , 并把选中的复选框的值添加到数组对象中 , 数组内顺序由选中顺序决定 

![](/images/Vue/18.png)

![](/images/Vue/18-1.png)

- 取消选中某一元素后 , 数组后一位元素向前移动一位
    
    ![](/images/Vue/18-2.png)

- 需要注意的是 checkedGames 对象为数组对象 [] , 如果修改成变量 "" 就会同时选定 , 且结果是布尔值

    ![](/images/Vue/18-3.png)

    ![](/images/Vue/18-4.png)

### 单选按钮
`input[type="radio"]` : 用  `v-model` 绑定单选按钮 , v-model 的值相同的为一组 , 值对象就用空就行

![](/images/Vue/19.png)

### 下拉列表
`select` : 用  `v-model` 绑定下拉框列表 

![](/images/Vue/20.png)

- 在 `likedNBAStar: "" ` 这里用 `""` 和 `null` 效果一样

- 在 `likedNBAStars: [] ` 这里用 `null` `""` `{}` `[]` 结果一样都是数组 

    ![](/images/Vue/20-1.png)

### 修饰符
表单修饰符

#### .lazy
- `用户名：<input v-model.lazy="username">`
- 用户输入内容时不做绑定数据的更新处理,在控件的 onchange 事件中更新绑定的变量 
- 也就是说用户输入完成后 , 光标离开的瞬间触发 onchange 事件 , 一次性更新内容
- 一般的数据双向绑定都是用户输入的同时更新 , 这样做的话有助于提高性能

#### .number
- `年龄：<input v-model.number="age" type="number">`
- 将用户输入的内容转换为数值类型，如果用户输入非数值的时候，则返回NaN
- 在页面表现为无法输入非数字类型内容

#### .trim
- `意见：<input v-model.trim="content">`
- 自动去掉用户输入内容两端的空格

![](/images/Vue/21.png)

**总结下来 , 基本就是通过 `v-model` 绑定 data 中的一个对象 , 至于对象是什么类型 , 取决于需求**

## <center> 组件⭐ </center>

### 创建全局组件
![](/images/Vue/22.png)

![](/images/Vue/22-1.png)

- 值得注意的是以 ` Vue.component()` 形式创建的是全局组件 , 意思是只要是用到 Vue 对象的地方都可以用到该组件

### 创建局部组件
![](/images/Vue/23.png)

- 首先声明了一个 Js 对象 WeatherComponent , 然后在该对象内部声明了 template 属性 , 这个 template 为关键字

- 然后声明了一个名为 myApp 的 Vue 实例 , 在该实例内部的 components 属性内部写了一个组件名 `my-weather` , 跟在后面的 `WeatherComponent` 意思是用到名为 WeatherComponent 的 Js 对象

- 这样的过程就是局部注册组件

- 这样的写法就是 my-weather 这个组件只能在 myApp 这个实例的作用域里面才能生效 , 意思就是 `<my-weather/>` 只有写在 `<div id="myApp"/>` 内部才生效

    ![](/images/Vue/23-1.png)
    
### 表行组件
首先观察以下内容

![](/images/Vue/24.png)

![](/images/Vue/24-1.png)

- 由于 `<table/>` 内部无法识别 `<my-row*>` , 因此我们定义的组件只能渲染在 table 标签外部

- 我们定义的组件渲染的顺序排在了 table 之前 , ( 个人应该是页面DOM组织时 Js 的优先级高于原生 HTML ) //这里有待研究

如果需要让组件内容正常的显示在 table 中 , 需要用这种写法 `<tr is="my-row1"></tr>`

    ![](/images/Vue/24-2.png)

### 数据函数
![](/images/Vue/25.png)

- 这里需要注意的是 template 属性内的 todayWeather 对象 , 需要在 data 中写成函数形式

### 给组件传递参数
![](/images/Vue/26.png)

- 这里数据传递的关键在于 test-result 组件标签的 `:score` 属性通过 v-bind 和组件内部 props 属性值 score 进行了绑定

- 这样就组件就可以接受从外部传递过来的参数值

### 给组件传递变量
![](/images/Vue/27.png)

- 首先是用 v-model 给 input 的值绑定了 myApp 的 data 方法中的 myname 对象 

- 然后在自定义的组件中用 `:pname` 把 myname 对象和组件中的 props 属性中的 pname 值进行绑定

- 通过 myname 对象把值传递到 template 属性值的 *双大括号中*

### 参数验证
![](/images/Vue/28.png)

- 在 component 中的 props 属性不再是之前的数组 , 而是设置成对象 

- 分别设置了 name , age , detail 对象 , 在各自的对象中进行了相应的参数校验 

- detail 与 name , age 的不同在于 name , age 为单一的属性对象 , 而 datail 设置了 object 对象 , 便可以在其中描述多个内容 ; 在这里的话设置了默认返回值

### 事件传递
#### v-on
- v-on : 侦听组件事件，当组件触发事件后进行事件处理。

#### $emit
- $emit : 触发事件，并将数据提交给事件侦听者。
    
![](/images/Vue/29.png)

1. 首先给组件传递了 a 、 b 值 

2. 然后点击事件触发 add 方法

3. 然后在方法内部用 `$emit` 触发事件 , 给 add_event 事件传递 inResult 参数

4. 组件 `<add-method />` 绑定的 add_event 事件被触发 , 然后调用 getAddResult 方法

5. 将刚才传递过来的 inResult 参数赋给 outResult 参数 , 最终显示在页面 

### slot 
主要作用是将自定义组件标签之间的内容保留到指定位置

- 一般来说没有使用 slot 的情况下 , 组件编译时会忽略组件标签之间的内容

    ![](/images/Vue/30-2.png)

    ![](/images/Vue/30.png)

- 用法为在 template 中指定位置插入 `<slot></slot>`

- 在文章以上的所有内容都是在标签的属性中操作数据显示 , 而这里主要对标签间的内容进行操作

    ![](/images/Vue/30-1.png)

- 观察所得 , slot 不仅保留了字符 , 还保留了空格

- 所以 slot 使用后会对组件标签之间的所有内容进行保留 , 空格当作空字符一起合并

### 组合 slot

在上面使用了 slot 之后 , 或许会有点疑问 , 上面是一次性操作了标签内所有的内容 , 要是我想只对局部内容操作该怎么办呢？那就需要为 slot 命名区分开 , 再对其进行处理

![](/images/Vue/31.png)

- 通过在组件内添加块元素 `<span/>` 为 slot 命名 , 然后在 template 中 再次通过名称对其进行保留处理

- 仔细观察 , 这时如果不给 slot 命名的话 , 使用 `<slot></slot>` 也一样会进行保留操作 , 由于这里组件 `<nba-all-stars/>` 之间无内容 , 所以不显示
    
    ![](/images/Vue/31-1.png)

- 再次观察可知, 标签之间的空格不会被编译器认为是空字符

    ![](/images/Vue/31-1.png)

- 但是一旦标签内有字符 , 空格就被认为和空字符 

- 同时 `<span/>` 标签占据的位置也会被认为是空字符





