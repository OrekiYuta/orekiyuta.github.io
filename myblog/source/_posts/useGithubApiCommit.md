---
title: Use Github Api Commit
date: 2021-08-04 00:53:33
tags: [Github,Flask,Python]
---
## Sence
- 使用 github 提供的 API 操作 repo
- 之后可利用该操作,对仓库项目提交,结合 github action 进行自动化部署
<!-- more -->

## Solution
### Read / Input
- 查阅官方文档可见,接口说明 👉 [Create or update file contents](https://docs.github.com/en/rest/reference/repos#create-or-update-file-contents)
    - ![](/images/useGithubApiCommit/Snipaste_2021-08-05_21-15-21.png)  
- 鉴权说明 👉 [Authentication](https://docs.github.com/en/rest/guides/getting-started-with-the-rest-api#authentication)


### Do / Output
- 申请 token   👉 [Settings/Developer settings/Personal access tokens](https://github.com/settings/apps) 
    - 填写必要参数, 勾选需要的权限后, 点击 Generate token
    - ![](/images/useGithubApiCommit/Snipaste_2021-08-05_21-32-31.png)
    - 这里需要注意保存一下 token 值, 只会显示一次 , 如果忘了再创建一个即可
    - ![](/images/useGithubApiCommit/Snipaste_2021-08-05_21-31-17.png)
    - github 会扫描 github 所有用户的 repo , 如果某个文件包含了 “token 值”,都会在此文件中清除掉 , 并在该 token 的持有者配置中 delete 掉该配置 , 就是上图选项 “Personal access tokens” 里

- 利用 Flask 实现一下
- ```py
    # github_pic_api.py
    import base64
    from app.api import pic
    from flask import request
    from flask import jsonify
    from flask_cors import CORS
    from app.service import github_commit_service

    CORS(pic, supports_credentials=True) # 允许跨域请求

    @pic.route("/", methods=["POST"])
    def upload_pic_to_github():
        f = request.files.get('file') # 获取前端传输过来的文件对象

        # 配置仓库参数
        github_repo_config = {
            "token": "x", # 申请得到的 token
            "repo": "asscet", # 公开的仓库名
            "owner": "cat",  # 仓库的拥有者
            "email": "cat@gmail.com", # 仓库拥有者的邮箱
            "base_url": "https://api.github.com/repos/", # github 基础接口地址
            "repo_path": "ccc/", # 公开的仓库里的目录位置
            "file": f  # 要操作的文件对象
        }

        # 配置本次提交的参数
        commit_data = {
            "message": "use github api commit at ", # 提交 message
            "committer": {
                "name": github_repo_config.get("owner"), # 提交者名称
                "email": github_repo_config.get("email") # 提交者邮箱
            },
            "content": base64.b64encode(f.read()).decode('utf-8'), # 需要把文件对象 base64 加密再转成 String
        }

        # 配置请求头参数,用于鉴权
        headers = {
            "Authorization": 'token ' + github_repo_config.get("token"),
            "Accept": "application/vnd.github.v3+json"
        }

        result = github_commit_service.commit_file(github_repo_config, commit_data, headers)
        return jsonify(result)

  ```
- ```py
    # github_commit_service.py
    import json
    import requests


    def commit_file(grc, commit_data, headers):
        repo_url = grc.get("base_url") \
                + grc.get("owner") + "/" \
                + grc.get("repo") + "/contents/" \
                + grc.get("repo_path") \
                + grc.get("file").filename

        fin_result = {
            "req": "",
            "res": ""
        }

        try:
            res = requests.put(repo_url, data=json.dumps(commit_data), headers=headers)
            fin_result["res"] = bytes.decode(res.content)
        except:
            fin_result["req"] = "commit fail! unknown exception!"
            return fin_result
        else:
            # print(result.get("req"))  .get 如果 key 不存在 'req' 不会报错
            # print(result["req"])      [] 如果 key 不存在 'req' 会报错

            if res.status_code == 201:
                fin_result["req"] = "commit success! great!"
                return fin_result
            elif res.status_code == 422:
                # 422 状态码,可能该文件名已经存在仓库中
                fin_result.get("req", "commit fail! content maybe exists!?")
                return fin_result
            else:
                fin_result["req"] = "commit fail! check the res message."
                return fin_result

  ```
- ![](/images/useGithubApiCommit/Snipaste_2021-08-05_22-08-34.png)


## Other
- 👉 [Create or update file contents](https://docs.github.com/en/rest/reference/repos#create-or-update-file-contents)
- 👉 [一篇文章搞定Github API 调用 (v3)](https://segmentfault.com/a/1190000015144126)
- 👉 [python利用github的api实现文件的上传和更新](https://wqian.net/blog/2019/0426-python-github-api-index.html)
- 👉 [使用GitHub API上传文件及GitHub做图床](https://www.bbsmax.com/A/Vx5MDry7JN/)