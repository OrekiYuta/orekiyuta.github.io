---
title: Nice to use Vue.js
date: 2019-12-09 15:51:26
tags: Vue.js
---

## <center>Start</center> 

### Vue-cli 版本

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

## <center>吱吱吱吱吱吱吱吱吱吱吱吱吱吱吱吱</center>