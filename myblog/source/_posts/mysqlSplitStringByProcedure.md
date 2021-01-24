---
title: MySQL Split String By Procedure
date: 2021-01-21 00:17:23
tags: MySQL
---
## Scene
- 有这样一个场景，需要把一个表中的某个字段内的字符串分割成列

|roleCode|users|
| :---: | :---:|
|4dc51344e6674c03ae0a176d3d0ae14e_20865 | xb,guojinyu,jiangyuan,ly_bmcc,wwm,lck,wusuihua |   
|4dc51344e6674c03ae0a176d3d0ae14e_20866 | zlj,mashaomeng                                 |
|4dc51344e6674c03ae0a176d3d0ae14e_20867 | tianye2                                        |
|4dc51344e6674c03ae0a176d3d0ae14e_20869 | wangyinju,liu_yan                              |

- 就是把上面的表格拆分成下面的样子

|roleCode|users|
| :---: | :---:|
|4dc51344e6674c03ae0a176d3d0ae14e_20865	| xb        |
|4dc51344e6674c03ae0a176d3d0ae14e_20865	| guojinyu  |
|4dc51344e6674c03ae0a176d3d0ae14e_20865	| jiangyuan |
|4dc51344e6674c03ae0a176d3d0ae14e_20865	| ly_bmcc   |
|4dc51344e6674c03ae0a176d3d0ae14e_20865	| wwm       |
|4dc51344e6674c03ae0a176d3d0ae14e_20865	| lck       |
|4dc51344e6674c03ae0a176d3d0ae14e_20865	| wusuihua  |
|4dc51344e6674c03ae0a176d3d0ae14e_20866	| zlj       |
|4dc51344e6674c03ae0a176d3d0ae14e_20866	| mashaomeng|
|4dc51344e6674c03ae0a176d3d0ae14e_20867	| tianye2   |
|4dc51344e6674c03ae0a176d3d0ae14e_20869	| wangyinju |
|4dc51344e6674c03ae0a176d3d0ae14e_20869	| liu_yan   |

<!-- more -->
## Solution
- 因为要用到循环，所以得用存储过程去解决这个问题
```sql
BEGIN
    DECLARE i INT;
    DECLARE j INT;
    -- 创建表存储结果
    CREATE TABLE IF NOT EXISTS result(roleCode VARCHAR(255),users VARCHAR(255));
    -- 使用临时表执行速度会快些
    -- CREATE TEMPORARY TABLE IF NOT EXISTS result(roleCode VARCHAR(255),users VARCHAR(255));
    -- 获取行数，用于第一层循环
    SET @cols_num = (SELECT count(users) FROM `user`); 
	SET i = 0;

    WHILE i < @cols_num DO
        SET j = 0;

        -- 获取 users 字段内的被 “,” 分割的字符串数目
        -- LENGTH(users) - LENGTH(REPLACE(users,',',''))+1 AS userNums
        -- 将字符串数目赋给变量 @str_num ,用于第二层循环
        -- 同时取得当前记录的 roleCode,把值赋给变量 @roleCode
        SELECT roleCode,LENGTH(users) - LENGTH(REPLACE(users,',',''))+1 AS userNums  
        INTO @roleCode,@str_num FROM `user` LIMIT i,1;

        WHILE j < @str_num DO
            -- 取得当前查询的记录的 users 字段被分割的最后一个字符串
            SELECT SUBSTRING_INDEX(SUBSTRING_INDEX(users,',',j+1),',',-1) AS users 
            INTO @users FROM `user` LIMIT i,1;

            INSERT INTO result(roleCode,users) VALUES (@roleCode,@users);
                        
            SET j = j+1;

        END WHILE;
                
        SET i = i+1;
    END WHILE;
		
    -- 查询结果
    SELECT * FROM result;

END
```
## Other
- 如果要逆向还原，只需执行下面语句即可
```sql
SELECT roleCode,GROUP_CONCAT(users) AS users FROM result GROUP BY roleCode;
```

## Reference
- 存储过程基本用法
```sql
drop table if exists test_tbl;
create table test_tbl (name varchar(20), status int(2));
insert into test_tbl values('abc', 1),('edf', 2),('xyz', 3);
 
drop procedure IF EXISTS pro_test_3;
delimiter //
create procedure pro_test_3()
begin
--  方式 1
    DECLARE cnt INT DEFAULT 0;
    select count(*) into cnt from test_tbl;
    select cnt;
 
--  方式 2
    set @cnt = (select count(*) from test_tbl);
    select @cnt;

--  方式 3
    select count(*) into @cnt1 from test_tbl;
    select @cnt1;

--  多个列的情况下似乎只能用 into 方式
    select max(status), avg(status) into @max, @avg from test_tbl;
    select @max, @avg;
end

//

delimiter ;
 
call pro_test_3();
```

- 👉 [MySQL（7）---存储过程](https://www.cnblogs.com/qdhxhz/category/1222307.html)


