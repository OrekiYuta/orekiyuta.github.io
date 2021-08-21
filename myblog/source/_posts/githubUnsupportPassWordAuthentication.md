---
title: Github Unsupport PassWord Authentication
date: 2021-08-21 00:23:55
tags: [Github,Hexo]
---

## Sence
```Shell
    remote: Support for password authentication was removed on August 13, 2021. Please use a personal access token instead.
    remote: Please see https://github.blog/2020-12-15-token-authentication-requirements-for-git-operations/ for more information.
    fatal: unable to access 'https://github.com/xxx/xxx.github.io.git/': The requested URL returned error: 403
    [41mFATAL[49m Something's wrong. Maybe you can find the solution here: [4mhttp://hexo.io/docs/troubleshooting.html[24m
```

## Solution
- Hexo => _config.yaml
    ```yaml
    deploy:
        type: git
        # repo: https://github.com/OrekiYuta/OrekiYuta.github.io.git
        repo: git@github.com:OrekiYuta/orekiyuta.github.io.git
        branch: master
    ```
- 👉 [Github SSH](https://www.orekiyuta.cn/archives/Hexo-Install-Migrate/)


