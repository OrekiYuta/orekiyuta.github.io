---
title: Preliminary use Mongodb
date: 2019-12-19 19:56:48
tags: Mongodb
---

### <center>基本操作</center>

#### 安装启动
- `docker pull mongo`
- `docker run -d -p 127.0.0.1:27017:27017 --name mymongo mongo`
- `docker exec -it mymongo mongo`

### <center>常用命令</center>
#### 数据库
- `show dbs`
- `use elias` 建立数据库 elias
- `db` 当前所在数据库
- `db.dropDatabase()`
<!-- more -->
#### 集合
- `db.createCollection("post")` 建集合(表) post 👉[MongoDB 概念解析](https://www.runoob.com/mongodb/mongodb-databases-documents-collections.html)
- `show collections`
- `db.[collectionsName].drop()`

- `db.[collectionsName].insert({[key]:"[value]"})`

    - 也可以把数据先赋给变量,再插入变量
        ```
        document=({tiltle:"20191220",by:'elias',tag:'note'})
        db.[collectionsName].insert(document)
        ```
- `db.[collectionsName].find()` 查看插入的文档
- `db.[collectionsName].find().pretty()`
- `db.[collectionsName].insertOne()`
- 
    ```
    db.[collectionName].updateOne({{[key]:"[value]"},{$set:{key:"[Newvalue]"}})
    ```
- `db.[collectionName].updateMany()`
- `db.[collectionName].deleteOne()`
- `db.[collectionName].deleteMany()`
  

### 参考内容
- [mongo - Docker Hub](https://hub.docker.com/_/mongo/?tab=description)

- [Database Commands-MongoDB Manual](https://docs.mongodb.com/manual/reference/command/)