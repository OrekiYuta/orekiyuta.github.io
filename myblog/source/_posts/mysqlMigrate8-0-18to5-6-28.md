---
title: MySQL Migrate 8.0.18 -> 5.6.28
date: 2021-06-26 17:24:14
tags: MySQL
---

## Scene
- 迁移 MySQL 数据库
- 用 Navicat 转储 SQL 文件
- 再导入新数据库
![](/images/mysqlMigrate8-0-18to5-6-28/Snipaste_2021-06-26_17-30-25.png)
- unkown collation:'utf8mb4_0900_ai_ci'
## Solution
- 这是因为 数据库版本 不一致 导致的


```SQL
-- old db
mysql>  select version();
+-----------+
| version() |
+-----------+
| 8.0.18    |
+-----------+
1 row in set (0.04 sec)
```
```SQL
-- new db
mysql>  select version();
+--------------------+
| version()          |
+--------------------+
| 5.6.28-cdb2016-log |
+--------------------+
1 row in set (0.06 sec)

mysql> 
```
- 把转储 SQL 文件中的所有的 utf8mb4_0900_ai_ci 替换为 utf8_general_ci 
- 把转储 SQL 文件中的所有的 utf8mb4 替换为 utf8
- 再次导入即可
