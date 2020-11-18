---
title: Nice to use Vue.js
date: 2019-12-09 15:51:26
tags: Vue.js
---

## <center>Start</center> 

### Vue-cli 版本 (2x)
**下文基于2x版本 , 版本跟进需要查看官方文档 👉[Vue CLI](https://cli.vuejs.org/zh/)**

先查看一下 Vue-cli 项目构建工具版本信息并安装 Vue-cli 
    
- `npm show vue-cli`  查看 Vue-cli 的版本信息
- `npm install -g vue-cli@2.9.6` 选择最新版本
- `vue -V` 版本确认
- `vue -h` 查看帮助

### Vue-cli 模板

由于用 Vue-cli 工具初始化项目是基于某些模板下初始化的 , 所以先查看下官方推荐的模板 👉[vuejs-templates](https://github.com/vuejs-templates)

![](/images/Vue2/01.png)

- 这里就采用生态较好的 webpack  👉[官方说明文档](http://vuejs-templates.github.io/webpack/)

### Vue-cli 初始化项目

查看下如何初始化

![](/images/Vue2/01.png)

- 两种方式初始化 : 一种是基于官方模板 , 另一种基于第三方模板

<!-- more -->

## <center>创建 webpack 工程</center>

### 安装选项

![](/images/Vue2/03.png)

- `Runtime + Compiler` 一般选择这个 , 安装运行时和编译器 , 一般有很多动态组件 , 只安装运行时的话不能动态编译

    ![](/images/Vue2/03-1.png)

- `Install vue-router` 路由
- `Use ESLint to lint your code` ES语法检测器
- `Set up unit tests` 单元测试
- `Setup e2e tests with Nightwatch` e2e测试
- `Should we run npm install for you after the project has been created` 选择包管理器

### 文件结构

```py
    .
    ├── build/                      # webpack config files
    │   └── ...
    ├── config/
    │   ├── index.js                # main project config
    │   └── ...
    ├── src/
    │   ├── main.js                 # app entry file
    │   ├── App.vue                 # main app component
    │   ├── components/             # ui components
    │   │   └── ...
    │   └── assets/                 # module assets (processed by webpack)
    │       └── ...
    ├── static/                     # pure static assets (directly copied)
    ├── test/
    │   └── unit/                   # unit tests
    │   │   ├── specs/              # test spec files
    │   │   ├── eslintrc            # config file for eslint with extra settings only for unit tests
    │   │   ├── index.js            # test build entry file
    │   │   ├── jest.conf.js        # Config file when using Jest for unit tests
    │   │   └── karma.conf.js       # test runner config file when using Karma for unit tests
    │   │   ├── setup.js            # file that runs before Jest runs your unit tests
    │   └── e2e/                    # e2e tests
    │   │   ├── specs/              # test spec files
    │   │   ├── custom-assertions/  # custom assertions for e2e tests
    │   │   ├── runner.js           # test runner script
    │   │   └── nightwatch.conf.js  # test runner config file
    ├── .babelrc                    # babel config
    ├── .editorconfig               # indentation, spaces/tabs and similar settings for your editor
    ├── .eslintrc.js                # eslint config
    ├── .eslintignore               # eslint ignore rules
    ├── .gitignore                  # sensible defaults for gitignore
    ├── .postcssrc.js               # postcss config
    ├── index.html                  # index.html template
    ├── package.json                # build scripts and dependencies
    └── README.md                   # Default README file
```
- 更多详细可查看官方文档 👉[webpack](http://vuejs-templates.github.io/webpack/)

## <center>运行与发布 webpack</center>

### npm run dev / npm start
![](/images/Vue2/04.png)

- `npm run dev` 只是个简写形式 , 实际运行的命令写在项目根目录下的 package.json 中

    ![](/images/Vue2/04-1.png)

- 可见 `npm run dev` 和 `npm start` 是一个效果

    ![](/images/Vue2/04-5.png)   

### 设置依赖

设置生产环境的依赖列表、指定 vue 和 vue-router 版本依赖

![](/images/Vue2/04-2.png)

- 可修改为当前最新版本 v2.6.10 (2019.12.09)

- `^` 符号的意思是使依赖包向后兼容

    - 比如当前我的依赖为 `"vue": "^2.6.10"` 

    - 然后过了一个月 , 假设 vue 的版本更新到了 2.8.10

    - 当我们再次执行 `npm install` 的时候 , 它会更新 **小版本号**  和 **补丁版本号**  , 依赖就变成了 `"vue":"2.8.10"`

    - 然后过了半年 , 假设 vue 的版本更新到了 3.1.0 , 而它的 2.0 版本最后的版本号为 2.9.10

    - 同样执行 `npm install` , 依赖变成 `"vue":"2.9.10"`

    - **大版本号** 不会改变

    - 去掉 `^` 符号可精确指定版本 , 避免版本更新影响

### npm 版本号规范

如果一个项目打算与别人分享，应该从 1.0.0 版本开始。以后要升级版本应该遵循以下标准：

- 补丁版本(修订版本) : 解决了 Bug 或者一些较小的更改，增加最后一位数字，比如 1.0.1

- 小版本(次版本) : 增加了新特性，同时不会影响之前的版本，增加中间一位数字，比如 1.1.0

- 大版本(主版本) : 大改版，无法兼容之前的，增加第一位数字，比如 2.0.0

    ![](/images/Vue2/04-3.png)

了解了提供者的版本规范后， npm 包使用者就可以针对自己的需要填写依赖包的版本规则。

作为使用者，我们可以在 package.json 文件中写明我们可以接受这个包的更新程度（假设当前依赖的是 2.6.1 版本）:

- 如果只打算接受补丁版本的更新（也就是最后一位的改变），就可以这么写：
    ```
    2.6
    2.6.x
    ~2.6.1   //波浪号只会更新补丁版本号
    ```
- 如果接受小版本的更新（第二位的改变），就可以这么写：
    ```
    2
    2.x
    ^2.0.1
    ```
- 如果可以接受大版本的更新（自然接受小版本和补丁版本的改变），就可以这么写：
    ```
    x
    ```

总的来说、三种版本变化类型，接受依赖包哪种类型的更新，就把版本号准确写到前一位。

### 浏览页面

`npm run dev` 运行查看一下

![](/images/Vue2/04-4.png)

### npm run build

`npm run build` 打包发布

![](/images/Vue2/05.png)

- 这个执行过程 把在开发环境写好的**代码** **编译**并**加密**后 打包成 前端页面的**静态文件**

- 打包完成的文件在项目根目录下的 dist文件夹内

    ![](/images/Vue2/05-1.png)

- `code .`  VScode 打开当前目录命令
- `shift + alt + f  格式化代码

## <center>引入组件库</center>
作为个人开发 , 实际写的时候 , 一个个组件去写的话工作量就太大的了。这时不妨采用一些开源的组件库。
- [ElementUI](https://element.eleme.io/#/zh-CN) 
- [ViewUI](https://www.iviewui.com/) 
- [Ant Design of Vue](https://www.antdv.com/docs/vue/introduce-cn/) 
- [Vant](https://youzan.github.io/vant/#/zh-CN/intro) 
- [Vuetify](https://vuetifyjs.com/zh-Hans/) 
- [BootstrapVue](https://bootstrap-vue.js.org/) 
- etc.

### 引入Bootstrap组件

1. `npm install bootstrap --save-exact` 引入后 , 就可在 package.json 中看到依赖的 bootstrap 版本了

0. 在 `/src/main.js` 中添加 `import 'bootstrap/dist/css/bootstrap.min.css'`

    ![](/images/Vue2/06.png)

0. 测试引用是否生效

    在 `/src/App.vue` 中添加测试代码(这里的用法就和普通的用法一样)

    ![](/images/Vue2/06-1.png)

0. `npm run dev` 预览下效果

    ![](/images/Vue2/06-2.png)

0. 熟悉后就可按照官方提供的组件形式使用

##  <center>axios</center>

去官网查看一下👉[axios](https://github.com/axios/axios)

### 安装axios
`npm install --save axios vue-axios`

### 注册组件

在`/src.main.js`中引入 axios 和 vue-axios , 然后注册到 Vue 全局组件中
```
import axios from 'axios'
import VueAxios from 'vue-axios'
Vue.use(VueAxios, axios)
```

### 尝试访问 API

在 /src/components/HelloWorld.vue 中写入
```html
<template>
  <pre>{{content}}</pre>
</template>

<script>

export default {
  name: "HelloWorld",
  data() {
    return {
      content: null
    }
  },
  mounted() {
    this.axios
    .get('https://api.coindesk.com/v1/bpi/currentprice.json')
    .then(response => (this.content = response))
    
  }
};
</script>
```

- 首先设置了个 content 变量来保存数据 
- 然后在 Vue 的生命周期函数 mounted 中通过 axios 请求数据
- 设置了 response 变量接受数据然后再赋给 content

运行一下、可见浏览页面有数据返回了

![](/images/Vue2/06-3.png)

## <center>组件结构</center>

组件同一放在 `/src/components` 中
```html
<template>
    <div class="container">
        <h1>{{ msg }}</h1>
    </div>
</template>

<script>
// import ...
export default {
    name: 'HelloWorld',
    data () {
        return {
            msg: 'Welcome to Your Vue.js App'
        }
    }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
h1 {
    font-weight: normal;
    color: red;
}
</style>
```
一个组件内一般由 `<template/> <script/> <style/>` 组成

### `<template/>`
组件标签

### `<script/>`
Js 脚本用的是 ES6 语法
- `import ...` 导入各种库
- `export default { }` 输出该组件
- `data ()` data 是方法

### `<style/>`
该组件所应用的样式
- `scoped` 属性 : 加上该属性说这个样式单只对该组件产生影响 , 一般还是加上 , 避免影响其他组件和全局设置

## <center>工程结构</center>

webpack模板生成的工程结构 
👉[webpack](https://webpack.js.org/) 
👉[webpack-cn](https://www.webpackjs.com/)

常用结构
```py
    .
    ├── build/                      # webpack config files
    │   └── ...
    ├── config/
    │   ├── index.js                # main project config
    │   └── ...
    ├── src/
    │   ├── main.js                 # app entry file
    │   ├── App.vue                 # main app component
    │   ├── components/             # ui components
    │   │   └── ...
    │   └── assets/                 # module assets (processed by webpack)
    │       └── ...
    ├── static/                     # pure static assets (directly copied)
    ├── .babelrc                    # babel config
    ├── .editorconfig               # indentation, spaces/tabs and similar settings for your editor
    ├── .eslintrc.js                # eslint config
    ├── .eslintignore               # eslint ignore rules
    ├── .gitignore                  # sensible defaults for gitignore
    ├── .postcssrc.js               # postcss config
    ├── index.html                  # index.html template
    ├── package.json                # build scripts and dependencies
    └── README.md                   # Default README file
```
- build : webpack打包工具设置
- config : 整个工程配置文件
- src : 开发源文件 , 基本开发都在这里
- static : 静态文件 , 编译时会自动直接复制到发布文件夹
- index.html : 入口文件

## <center>执行过程⭐</center>
 
关注这个五个文件 :  **index.html**  、 **main.js**  、 **App.vue**  、 **index.js**  、 **HelloWorld.vue**

![](/images/Vue2/06-5.png)

- 首先是在 **main.js** 中实例化 Vue 对象 , Vue 对象 el 属性选择了 id="app" 的元素 , 就是 **index.html** 中的 `<div id="app"></div>`

- 然后定义了 Vue 对象的 template 为 `<App/>` , 这里我们先注释掉 components 观察一下页面元素

    ![](/images/Vue2/06-4.png)

    - 可见 template 中定义的 `<App/>` 标签会替换掉 **index.html** 中的 `<div id="app"></div>`
    - template 中定义的标签 **不区分大小写**

- 同时也指定了路由元素 router , 详写为 `router : router`

- 接着在 Vue 对象中引入 **子组件 App** , 也就是 **App.vue** , 可见 **main.js** 顶部引入的文件

- 同理 , **子组件会替换掉父组件的标签** , 所以最终页面的标签就变成了 App.vue 中的 `<div id="app"></div>`

    ![](/images/Vue2/06-6.png)

    - 整个替换流程为 : **index.html** `<div id="app"></div>` ← **main.js** `<App/>`  ←  **App.vue** `<div id="app"></div>`

- 最后路由的部分就比较明朗了 , 先在 **index.js** 中通过 **组件名** 引入自定义的组件 , 然后显示在预先在 **App.vue** 占位的 `<router-view>` 中

- 对于这些文件的组装方式就是 webpack 需要做的了 , 大概是把 .vue 组件和相关 Js文件统一打包组装起来最终形成单页静态文件 ; 执行 `npm run build` 就可看到生成的哪些文件

## <center>路由⭐⭐⭐</center>

👉[Vue Router](https://router.vuejs.org/) 👉[Vue Router-cn](https://router.vuejs.org/zh/)

### 安装路由
`npm install vue-router`

### 路由设置

![](/images/Vue2/07.png)

- 在 `/src/router/index.js` 中设置
- 首先在 components 文件夹中写好一个组件 , 例如 HelloWorld.vue
- 然后 import 导入该组件 , 最后在 routes 中把该组件绑定 URL , 这样就完成了 URL 对组件的映射

### 静态路由例子

#### 关键点
- **🎈path:''**
- **🎈component:**

#### 代码
先写三个组件 About 、HelloWord 、 News , 然后设置路由预览一下

About.vue
```html
<template>
    <div>
        <h1>About Page</h1>
    </div>
</template>
```

HelloWord.vue
```html
<template>
    <div>
        <h1>Hello World!</h1>
    </div>
</template>
```

News.vue
```html
<template>
    <div>
        <h1>News Page</h1>
    </div>
</template>
```

index.js
```js
import Vue from 'vue'
import Router from 'vue-router'
import HelloWorld from '@/components/HelloWorld'
import About from '@/components/About'
import News from '@/components/News'
Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      name: 'HelloWorld',
      component: HelloWorld
    },
    {
      path: '/about',
      name: 'About',
      component: About
    },
    {
      path: '/news',
      name: 'News',
      component: News
    }
  ]
})

```

App.vue
```html
<template>
  <div id="app">
    <img src="./assets/logo.png" />
    <p>
      <!-- 使用 router-link 组件来导航. -->
      <!-- 通过传入 `to` 属性指定链接. -->
      <!-- <router-link> 默认会被渲染成一个 `<a>` 标签 -->
      <router-link to="/">Home</router-link>
      <router-link to="/news">新闻</router-link>
      <router-link to="/about">关于</router-link>
    </p>
    <!-- 路由出口 -->
    <!-- 路由匹配到的组件将渲染在这里 -->
    <router-view />
  </div>
</template>

<script>
export default {
  name: "App"
};
</script>

<style>
#app {
  font-family: "Avenir", Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>

```

#### 页面

![](/images/Vue2/08.png)

![](/images/Vue2/08-1.png)

![](/images/Vue2/08-2.png)

### 动态路由

指在URL路径中含有动态参数的路由，比如说：/player/1, /player/2, /player/3 ...

#### 关键点
**🎈`path: '/:X '`**

#### 代码
先创建组件并设置路由

Player.vue
```html
<template>
    <div>
        <h1>球员页面</h1>
        <p>{{ detail }}</p>
    </div>
</template>

<script>
    export default {
        name: "Player",
        data() {
            return {
                detail: {}
            };
        },
        mounted() {
            // 接受url参数id
            this.detail = this.getPlayer(this.$route.params.uid);
        },
        /*
        beforeRouteUpdate(to, from, next) {
            this.detail = this.getPlayer(to.params.uid);
            next();
        },
        */
        methods: {
            getPlayer(uid) {
                switch (uid) {
                    case '1':
                        return {uid: 1,name: '库里',point: 26};
                    case '2':
                        return {uid: 2,name: '哈登',point: 30};
                    default:
                        return {uid: -1};
                }
            }
        }
    };
</script>
```

index.js
```js
import Vue from 'vue'
import Router from 'vue-router'
import Player from '@/components/Player'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/player/:uid',
      name: 'Player',
      component: Player
  }
  ]
})
```

App.vue
```html
<template>
  <div id="app">
    <img src="./assets/logo.png" />
    <p>
      <router-link to="/">Home</router-link>
      <router-link to="/player/1">库里</router-link>
      <router-link to="/player/2">哈登</router-link>
    </p>
    <router-view />
    <router-view />
  </div>
</template>

<script>
export default {
  name: "App"
};
</script>

<style>
#app {
  font-family: "Avenir", Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>

```

#### 分析

![](/images/Vue2/09.png)

- 运行测试页面发现在 “库里” 和 “哈登” 之间切换时 , URL有切换但是数据不更新 , 始终为初次选项的数据

- 原因在于进入页面时 , Player 组件还没实例化 

- 当我们点击第一个选项时 , 例如 “库里” ; 此时 Player 组件实例化完成 , 不再实例化了 , 也就是执行过 mounted 方法了

- 然后点击 “哈登” , 也不会再执行 mounted 方法了 , 这是 Vue 设计时考虑到的问题 , 为了提高性能不能总是实例化对象 , 这样会对内存消耗大

- 添加  beforeRouteUpdate 方法即可解决此问题 ; 让第二次点击事件进入该方法


### 嵌套路由

嵌套路由是指在动态路由的基础上再加上附加的嵌套URL（即：组件），比如说：(/player/:uid/*) /player/1/profile , /player/1/stats 等

#### 关键点
**🎈children:[ ]**

#### 代码

Profile.vue
```html
<template>
    <div>
        <h2>球员简介:{{$route.params.uid}}</h2>
    </div>
</template>
```

Stats.vue
```html
<template>
    <div>
        <h2>球员数据:{{$route.params.uid}}</h2>
    </div>
</template>
```

Player.vue
```html
<template>
  <div>
    <h1>球员页面</h1>
    <ul>
      <li>编号：{{detail.uid}}</li>
      <li>名字：{{detail.name}}</li>
      <li>得分：{{detail.point}}</li>
    </ul>
    <router-link :to="profile">简介</router-link>
    <router-link :to="stats">数据</router-link>
    <hr />
    <router-view />
  </div>
</template>

<script>
export default {
  name: "Player",
  data() {
    return {
      detail: {},
      profile: "",
      stats: ""
    };
  },
  mounted() {
    this.detail = this.getPlayer(this.$route.params.uid);
    this.profile = "/player/" + this.$route.params.uid + "/profile";
    this.stats = "/player/" + this.$route.params.uid + "/stats";
  },
  beforeRouteUpdate(to, from, next) {
    this.detail = this.getPlayer(to.params.uid);
    this.profile = "/player/" + to.params.uid + "/profile";
    this.stats = "/player/" + to.params.uid + "/stats";
    next();
  },

  methods: {
    getPlayer(uid) {
      switch (uid) {
        case "1":
          return { uid: 1, name: "库里", point: 26 };
        case "2":
          return { uid: 2, name: "哈登", point: 30 };
        default:
          return { uid: -1 };
      }
    }
  }
};
</script>
```

index.js
```js
import Vue from 'vue'
import Router from 'vue-router'
import Player from '@/components/Player'
import PlayerProfile from '@/components/Profile'
import PlayerStats from '@/components/Stats'
Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/player/:uid',
      name: 'Player',
      component: Player ,
      children: [
        {
            path: 'profile',
            component: PlayerProfile
        },
        {
            path: 'stats',
            component: PlayerStats
        },
    ]
  }
  ]
})
```

App.vue
```html
<template>
  <div id="app">
    <img src="./assets/logo.png" />
    <p>
      <router-link to="/">Home</router-link>
      <router-link to="/player/1">库里</router-link>
      <router-link to="/player/2">哈登</router-link>
    </p>
    <router-view />
  </div>
</template>

<script>
export default {
  name: "App"
};
</script>

<style>
#app {
  font-family: "Avenir", Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>

```
#### 分析

![](/images/Vue2/10.png)

在一个路由对象中基于原有的组件创建子路由对象 , 在 children 属性内添加多个路由对象 , 然后在原有的组件中添加 `<router-view>`

### 路由跳转多种用法

#### 关键点
- **🎈$router.push**
- **🎈`:to=" "`**

#### 代码
现在基于上面的 App.vue 做改进 
App.vue
```html
<template>
  <div id="app">
    <img src="./assets/logo.png" />
    <hr />
    <router-link to="/player/1">库里1</router-link>
    <router-link to="/player/2">哈登1</router-link>
    <hr />
    <button @click="btnClick(1)">库里11</button>
    <button @click="btnClick(2)">哈登22</button>
    <hr />
    <router-link :to="{ name: 'Player', params: { uid: 1 }}">库里111</router-link>
    <router-link :to="{ path: '/player/2/stats' }">哈登222</router-link>
    <hr />
    <router-view />
  </div>
</template>

<script>
export default {
  name: "App",
  methods: {
    btnClick(UID) {
      this.$router.push({ path: `/player/${uid}` });
      //this.$router.push({ path: `/player/${uid}/stats` });
      //this.$router.push({ name: 'Player', params: { uid: UID } });
      //this.$router.push({ path: '/player', query: { uid: UID }}); //url-get参数写法
      //url履历控制
      //this.$router.go(-1);
    }
  }
};
</script>

<style>
#app {
  font-family: "Avenir", Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>

```



#### $router.push 重定向 

1. 传递 path 路径
    
    ```
    this.$router.push({ path: `/player/${uid}` });
    ```
    ```
    this.$router.push({ path: `/player/${uid}/stats` });
    ```

0. 传递 name 组件名 , 重定向到该组件绑定的 URL 同时传递参数

    ```
    this.$router.push({ name: 'Player', params: { uid: UID } });
    ```
    ```
    this.$router.push({ path: '/player', query: { uid: UID }});
    ```

0. 利用浏览器进行前进后退
    - `this.$router.go(-1);`
    - `this.$router.go(1);`

#### `:to=" "` 直接传递对象

:to 也就是 v-bind:to

```
<router-link :to="{ name: 'Player', params: { uid: 1 }}">库里111</router-link>
```
```
<router-link :to="{ path: '/player/2/stats' }">哈登222</router-link>
```

### 多组件整合到同一路由

#### 关键点
- **🎈components**
- **🎈`<router-view name=" ">`**

#### 代码

Header.vue
```html
<template>
    <div>
        <h1>标题栏</h1>
        <div>我是标题栏</div>
    </div>
</template>
```

Sidebar.vue
```html
<template>
    <div>
        <h1>我是侧边栏</h1>
    </div>
</template>
```

Detail.vue
```html
<template>
    <div>
        <h1>详细显示</h1>
        <p>Vue.js是一套用于构建用户界面的渐进式框架。Vue 的核心库只关注视图层，不仅易于上手，还便于与第三方库或既有项目整合。另一方面，当与现代化的工具链以及各种支持类库结合使用时，Vue 也完全能够为复杂的单页应用提供驱动。</p>
    </div>
</template>
```

index.js
```js
import Vue from 'vue'
import Router from 'vue-router'
import SettingDetail from '@/components/Detail'
import SettingHeader from '@/components/Header'
import SettingSidebar from '@/components/Sidebar'
Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      name: 'Home',
      components: {
          myHeader: SettingHeader,
          mySidebar: SettingSidebar,
          myDetail: SettingDetail
      }
  }
  ]
})
```

App.vue
```html
<template>
    <div id="app">
        <table width="100%">
            <tr>
                <td colspan="2" style="background-color:darkgoldenrod">
                    <router-view name="myHeader"></router-view>
                </td>
            </tr>
            <tr>
                <td width="20%" style="background-color:thistle">
                    <router-view name="mySidebar"></router-view>
                </td>
                <td width="80%" style="background-color:aquamarine">
                    <router-view name="myDetail"></router-view>
                </td>
            </tr>
        </table>
    </div>
</template>

<script>
export default {
  name: "App",
 
};
</script>

<style>
#app {
  font-family: "Avenir", Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>
```

#### 分析

![](/images/Vue2/11.png)

这里的关键在于 **components** 和 `<router-view name=" ">` 

### URL 别名与重定向

#### 关键点
- **🎈路由别名 alias**
- **🎈重定向指令 redirect**

#### 代码

在 [嵌套路由](#嵌套路由) 的代码基础上作修改

About.vue
```html
<template>
    <div>
        <h1>About Page</h1>
    </div>
</template>
```

index.js
```js
import Vue from 'vue'
import Router from 'vue-router'
import Player from '@/components/Player'
import PlayerProfile from '@/components/Profile'
import PlayerStats from '@/components/Stats'
import About from '@/components/About'
Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/player/:uid',
      name: 'Player',
      component: Player,
      children: [
        {
          path: 'profile',
          component: PlayerProfile
        },
        {
          path: 'stats',
          component: PlayerStats
        },
      ]
    },
    {
      path: '/about',
      name: 'About',
      component: About,
      alias: '/aboutme'
    },
    {
      path: '/curry',
      redirect: '/player/1'
      //redirect: { name: 'About' }
      //redirect: '/about'
    }
  ]
})
```

App.vue
```html
<template>
    <div id="app">
        <router-link to="/">Home</router-link>
        <router-link to="/about">About</router-link>
        <router-link to="/player/1">Player1</router-link>
        <router-link to="/curry">Curry</router-link>
        <hr>
        <router-view></router-view>
    </div>
</template>
<script>
export default {
  name: "App",
 
};
</script>

<style>
#app {
  font-family: "Avenir", Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>

```

#### 分析

- `alias: '/aboutme'` 就是给 `path: '/about'` 中的 /about 路径起了个别名 , 访问 /aboutme 和 /about 是一个效果

- `path: '/curry'` 和 `redirect: '/player/1'` 组合起来就是 , 当访问 /curry 的时候会重定向到 /player/1 

- `redirect: { name: 'About' }` 也可以用组件的名称
- `redirect: '/about'` 同上
- `redirect: '/aboutme'` 重定向到别名也是可以的
 
### 多参数路由

#### 关键点
**🎈路由属性 props**

#### 代码

User.vue
```html
<template>
    <div>
        <h1>User</h1>
        <p>uid={{ uid }}, {{ nationality }}</p>
        <p>$route.params.uid={{ $route.params.uid }}</p>
        <p>$route.params.uid={{ $route.params.nationality }}</p>
    </div>
</template>

<script>
    export default {
        name: "User",
        props: ['uid', 'nationality']
    };
</script>
```

index.js
```html
import Vue from 'vue'
import Router from 'vue-router'
import User from '@/components/User'
Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      name: 'Home',
  },
    {
      path: '/user/:uid/:nationality',
      name: 'User',
      component: User,
      props: true
    },
  ]
})
```

App.vue
```html
<template>
    <div id="app">
        <router-link to="/">Home</router-link>
        <router-link to="/user/1/usa">User1</router-link>
        <router-link to="/user/2/china">User2</router-link>
        <router-link to="/user/3/korea">User3</router-link>
        <hr>
        <router-view></router-view>
    </div>
</template>

<script>
export default {
  name: "App",
};
</script>

<style>
#app {
  font-family: "Avenir", Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>
```

#### 分析

![](/images/Vue2/12.png)

这里主要在于在路由对象里开启 props 属性 , 同时在对应组件里也要设置 props 变量来接收参数

