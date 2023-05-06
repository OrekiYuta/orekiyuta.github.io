---
title: Flask Run
date: 2020-12-28 22:08:59
tags: [Flask,Python]
---

## Quickstart
- On PowerShell
    ```py
    mkdir flk
    cd flk
    py -m venv venv
    pip install flask
    mk hello.py
    New-Item hello.py -type file
    ```
- 在 hello.py 写入 
    ```py
    from flask import Flask
    app = Flask(__name__)

    @app.route('/')
    def hello_world():
    return 'Hello, World!'
    ```
- run
    ```py
    $env:FLASK_APP = "hello.py"
    flask run
    ```

- get / post
    ```py
    @app.route('/')
    def hello_world():
        return 'Hello, World!'


    @app.route('/name')
    def elias():
        return 'Hello, elias!'

    @app.route('/name/<username>')  #<>内默认 String
    def elias(username):
        return 'Hello, %s!' % username

    # @app.route('/name/<float:a>') #float
    @app.route('/name/<int:a>') # int
    def elias(a):
        return 'Hello, %s!' % (a + a)

    @app.route('/login', methods=['GET', 'POST'])
    def login():
        if request.method == 'POST':
            return "A"
        else:
            return "B"
    ```


## Reference
- [flask教程](https://github.com/BeyondLam/bili/blob/master/%E6%96%87%E6%A1%A3%E8%B5%84%E6%96%99%E5%8F%82%E8%80%83/flask%E6%95%99%E7%A8%8B.md)
- 👉[Flask](https://flask.palletsprojects.com/en/1.1.x/)