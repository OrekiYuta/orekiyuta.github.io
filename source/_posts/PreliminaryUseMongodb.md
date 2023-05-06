---
title: Preliminary use Mongodb
date: 2019-12-19 19:56:48
tags: Mongodb
---

### <center>安装启动</center>

- `docker pull mongo`
- `docker run -d -p 127.0.0.1:27017:27017 --name mymongo mongo`
- `docker exec -it mymongo mongo`


### <center>数据库</center>

- `show dbs`
- `use elias` 建立数据库 elias
- `db` 当前所在数据库
- `db.dropDatabase()`

<!-- more -->

### <center>集合</center>

- `db.createCollection("post")` 建集合(表) post 👉[MongoDB 概念解析](https://www.runoob.com/mongodb/mongodb-databases-documents-collections.html)

- `show collections`
- `db.[collectionsName].drop()`

### <center>文档</center>

#### 插入
- `db.[collectionsName].insertOne()`
- `db.[collectionsName].insert({key:"value"})`
- 也可以把数据先赋给变量 , 再插入变量
    ```
    document=({tiltle:"20191220",by:'elias',tag:'note'})
    db.[collectionsName].insert(document)
    ```
#### 更新
- `db.[collectionName].updateOne({key:"value"} , {$set:{key:"Newvalue"} )` 符合 key=value 的文档的 key 的 value 修改为 Newvalue ; $set 如果该文档没有该域(字段) , 则会追加上去

- `db.[collectionName].updateOne({key:"value"} , {$set:{key:"Newvalue"} , {multi:true})` 修改多条符合条件的值

- `db.[collectionName].updateOne({key:"value"} , {$unset:{key:"Newvalue"} )`  删除符合 key=value 的文档的 key 域(字段)

- `db.[collectionName].updateMany()`
- `db.[collectionName].update( {key:"value"},{$inc: {key2:2}} )` 符合 key=value 的文档的 key2 的 value 加 2

- `db.[collectionName].update( {key:"value"},{$mul: {key2:2}} )` 符合 key=value 的文档的 key2 的 value 乘 2

- `db.[collectionName].update( {key:"value"},{$rename: {key2:key3}} )` 符合 key=value 的文档的 key2 改名为 key3

- `db.[collectionName].updateOne({key:"value"} ,{key:"value",key2:"value2",...} , {upsert:true})` 有符合条件文档的就更新 , 没有则插入该文档

#### 删除
- `db.[collectionName].deleteOne()`
- `db.[collectionName].deleteMany()`

#### 查询
- `db.[collectionsName].find()` 查看文档
- `db.[collectionsName].find().pretty()` 
- `db.[collectionsName].find()`
- `db.[collectionsName].findOne()`
- `db.[collectionsName].find({},{_id:0})` 0 查询结果不包含id , 1 反之
- `db.[collectionsName].find({key:"value"})`
- `db.[collectionsName].find({key:{$gte:3}})` 大于等于3 **$gte**
- `db.[collectionsName].find({key:{$gt:3}})` 大于 **$gt**
- `db.[collectionsName].find({key:{$lte:3}})` 小于等于 **$lte**
- `db.[collectionsName].find({key:{$lt:3}})` 小于 **$lt**
- `db.[collectionsName].find({key:{$regex:" "}})` 正则表达式
- `db.[collectionsName].find({key:/ /})`
- `db.[collectionsName].find({key:{$regex:" "},key2:{$gt:3},...,...})` 复合条件,筛选同时符合条件的数据

- `db.[collectionsName].find({ $or: [{key:/ /},{key2:{$gt:3}}] })`  筛选符合 key 或者 key2 的数据

- `db.[collectionsName].find({key:{$in : [..,..,..]}})` 和 select in 一样
- `db.[collectionsName].distinct("key")` 取出键所含的内容
- `db.[collectionsName].find({...}).sort({key:1})` 1 升序 , -1 降序
- `db.[collectionsName].find({...}).limit(3)` 提取前三条文档
- `db.[collectionsName].find({...}).skip(3)` 跳过三条文档

### <center>索引</center>

- `db.[collectionsName].getIndexes()` 默认索引
- `db.[collectionsName].createIndex({key:1})` 以 key 升序建立索引 ; -1 降序
- `db.[collectionsName].dropIndex({key:1})` 删除索引
- `db.[collectionsName].createIndex({key:1},{unique:true})` 升序唯一索引 , 之后新建文档的 key 的 value 不能与前面的重复



### 参考内容
- [mongo - Docker Hub](https://hub.docker.com/_/mongo/?tab=description)
- [Database Commands - MongoDB Manual](https://docs.mongodb.com/manual/reference/command/)