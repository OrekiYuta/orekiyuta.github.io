---
title: MySQL Sync to Mariadb
date: 2021-01-20 20:43:04
tags: [MySQL,Mariadb]
---
## Unkown collation:'utf8mb4_0900_ai_ci'

- 把 MySQL 数据同步到 Mariadb 出现排序规则不一致
- MySQL 数据库默认字符集和排序规则
![](/images/mysqlSyncToMariadb/Snipaste_2021-01-20_21-07-07.png)
- MySQL 转储的 SQL 文件默认`DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci`
- Mariadb 数据库默认字符集和排序规则
![](/images/mysqlSyncToMariadb/Snipaste_2021-01-20_20-47-17.png)
- Mariadb 转储的 SQL 文件默认`DEFAULT CHARSET=utf8mb4;`

## Solution
- 在 Mariadb 中排序规则没有 utf8mb4_0900_ai_ci 
- 解决方法是 ：转储 MySQL 数据，然后把 SQL 文件里的 `COLLATE=utf8mb4_0900_ai_ci`全部替换成 `COLLATE=utf8mb4_general_ci` 即可
    - 或者是把 SQL 文件里的 `COLLATE=utf8mb4_0900_ai_ci` 去掉
- 总的来说就是把设置配成一致就可以了