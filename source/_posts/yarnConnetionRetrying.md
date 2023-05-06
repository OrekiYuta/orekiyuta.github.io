---
title: Yarn Connetion Retrying
date: 2021-12-10 01:06:16
tags: [Quasar,vue.js,Yarn]
---
## Scene
- 创建 quasar 项目的时候,安装依赖的时候网络总是重连
```
yarn install v1.22.10
info No lockfile found.
[1/5] Validating package.json...
[2/5] Resolving packages...
info There appears to be trouble with your network connection. Retrying...
```
<!-- more -->

## Solution
- 改下 yarn 下载源就行
1. `yarn config list` 查看代理
```shell
    info yarn config
    {
    'version-tag-prefix': 'v',
    'version-git-tag': true,
    'version-commit-hooks': true,
    'version-git-sign': false,
    'version-git-message': 'v%s',
    'init-version': '1.0.0',
    'init-license': 'MIT',
    'save-prefix': '^',
    'bin-links': true,
    'ignore-scripts': false,
    'ignore-optional': false,
    registry: 'https://registry.yarnpkg.com', # 默认
    'strict-ssl': true,
    'user-agent': 'yarn/1.22.10 npm/? node/v12.22.3 win32 ia32',
    lastUpdateCheck: 1639062753417
    }
    info npm config
    {}
```
2. 删除代理
```shell
    yarn config delete proxy # 执行这个就行
    npm config rm proxy   # 根据 config 结果, 如果 npm 设置了也删除就行
    npm config rm https-proxy # 同上
```
3. `yarn config set registry https://registry.npm.taobao.org` 更换下载源
```shell
    info yarn config
    {
    'version-tag-prefix': 'v',
    'version-git-tag': true,
    'version-commit-hooks': true,
    'version-git-sign': false,
    'version-git-message': 'v%s',
    'init-version': '1.0.0',
    'init-license': 'MIT',
    'save-prefix': '^',
    'bin-links': true,
    'ignore-scripts': false,
    'ignore-optional': false,
    registry: 'https://registry.npm.taobao.org', # 更换成淘宝镜像
    'strict-ssl': true,
    'user-agent': 'yarn/1.22.10 npm/? node/v12.22.3 win32 ia32',
    lastUpdateCheck: 1639062753417
    }
    info npm config
    {}
    Done i
```

## Other
- Carry On !!!
``` shell
    $ quasar create coza

    ___
    / _ \ _   _  __ _ ___  __ _ _ __
    | | | | | | |/ _` / __|/ _` | '__|
    | |_| | |_| | (_| \__ \ (_| | |
    \__\_\\__,_|\__,_|___/\__,_|_|



    ? Target directory exists. Continue? Yes
    ? Project name (internal usage for dev) coza
    ? Project product name (must start with letter if building mobile apps) coza
    ? Project description lazy sleep
    ? Author OrekiYuta <orekiyuta@gmail.com>
    ? Pick your CSS preprocessor: SCSS
    ? Check the features needed for your project: ESLint (recommended), TypeScript, Vuex, Axios, Vue-i18n
    ? Pick a component style: Composition
    ? Pick an ESLint preset: Prettier
    ? Continue to install project dependencies after the project has been created? (recommended) yarn

    Quasar CLI · Generated "coza".


    [*] Installing project dependencies ...

    yarn install v1.22.10
    info No lockfile found.
    [1/5] Validating package.json...
    [2/5] Resolving packages...
    warning @quasar/app > webpack-dev-server > url > querystring@0.2.0: The querystring API is considered Legacy. new code should use the URLSearchParams API instead.
    [3/5] Fetching packages...
    info fsevents@2.3.2: The platform "win32" is incompatible with this module.
    info "fsevents@2.3.2" is an optional dependency and failed compatibility check. Excluding it from installation.
    [4/5] Linking dependencies...
    warning " > vue-i18n@9.1.9" has unmet peer dependency "vue@^3.0.0".
    warning " > vuex@4.0.2" has unmet peer dependency "vue@^3.0.2".
    warning " > @babel/eslint-parser@7.16.3" has unmet peer dependency "@babel/core@>=7.11.0".
    warning "@typescript-eslint/eslint-plugin > tsutils@3.21.0" has unmet peer dependency "typescript@>=2.8.0 || >= 3.2.0-dev || >= 3.3.0-dev || >= 3.4.0-dev || >= 3.5.0-dev || >= 3.6.0-dev || >=
    3.6.0-beta || >= 3.7.0-dev || >= 3.7.0-beta".
    [5/5] Building fresh packages...
    success Saved lockfile.
    Done in 64.59s.


    [*] Running eslint --fix to comply with chosen preset rules...


    yarn run v1.22.10
    $ eslint --ext .js,.ts,.vue ./ --fix
    Done in 49.61s.

    [*] Quasar Project initialization finished!

    To get started:

    cd coza
    quasar dev

    Documentation can be found at: https://quasar.dev

    Quasar is relying on donations to evolve. We'd be very grateful if you can
    read our manifest on "Why donations are important": https://quasar.dev/why-donate
    Donation campaign: https://donate.quasar.dev
    Any amount is very welcomed.
    If invoices are required, please first contact razvan@quasar.dev

    Please give us a star on Github if you appreciate our work:
    https://github.com/quasarframework/quasar

    Enjoy! - Quasar Team
```