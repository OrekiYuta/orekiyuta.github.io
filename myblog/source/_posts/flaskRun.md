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


    @app.route('/login', methods=['GET', 'POST'])
    def login():
        if request.method == 'POST':
            return "A"
        else:
            return "B"
    ```


## Reference
- 👉[Flask](https://flask.palletsprojects.com/en/1.1.x/)