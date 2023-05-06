---
title: MySQL Crash Course / After reading
date: 2020-06-12 00:45:25
tags: MySQL
---
## <center>Remarks<center>
1. columnName = cN
0. tableName = tN

## <center>检索数据</center>

### use / show
- `use databaseName;`
- `show databases;`
- `show tables;`
- `show columns from tN;`

### select / distinct
- `select cN,cN2 from tN;`
- `select * from tN;`
- `select distinct cN from tN;`

### limit
- `select cN from tN limit 3;`    返回3行
- `select cN from tN limit 3,4;`返回第3行后面的4行（第一个数为开始的位置，第二个为要检索的行数）
- `limit 3,4` 等同于 `limit 4 offset 3` 都是从第3行后面开始取4行

### order
- `select tNX.cN from databaseName.tNX;`   完全限定列名、表名
- `select cN from tN order by cN;`    按照指定列名排序
- `select cN1,cN2,cN3 from tN order by cN2,cN3;`   按指定多个列名的顺序排序（只有在指定的前面的列值相同情况下，再对后面的列值排序）
<!-- more -->

### desc / asc
- `select cN1,cN2 from tN order by cN2 desc;` 降序排列，默认情况是升序 asc
- `select cN1,cN2 from tN order by cN1 desc ,cN2;`   desc只对它前面的列名生效（先按照 cN1 降序，再按照 cN2 默认的升序）
- `select cN1,cN2 from tN order by cN2 desc limit 1;`

## <center>过滤数据</center>

### where
- `select cN1,cN2 from tN where cN1 = 2;`
- `select cN1,cN2 from tN where cN2 = 'value';`

![](/images/MySQLCrashCourse/01.png) 

### between / is null
- `select cN1,cN2 from tN where cN1 between 3 and 10;`
- `select cN1,cN2 from tN where cN2 is null;`    返回 cN2 为 空值 的行

### and / or / ( ) / 运算符
- `select cN1,cN2,cN3 from tN where cN1 = 2 and cN3 <= 19;`
- `select cN1,cN2,cN3 from tN where cN1 = 2 or cN3 <= 19;`
- `select cN1,cN2,cN3 from tN where cN1 = 2 or cN2 = 'value' and cN3 <= 19;` and的优先级高于or
- 这句就理解为 cN2 等于 value 且 cN3 小于（含）19 或者 cN1 = 2   
-  <u>cN1 = 2 </u>   or  <u>cN2 = 'value' and cN3 <= 19</u> 
- `select cN1,cN2,cN3 from tN where (cN1 = 2 or cN2 = 'value') and cN3 <= 19;`   用括号提高优先级

### in
- `select cN1,cN2 from tN where cN2 in ('value','value2');`
- `select cN1,cN2 from tN where cN1 in (2,4,5);`
- `in (4,5)`等同于`cN1 = 4 or cN1 =5`
- 优点：in 更直观方便，执行快，还可以包括 where 子句

### not 
- `select cN1,cN2 from tN where cN1 not in (2,4,5);`     否定后面的条件

### like / 通配符 
- `select cN1,cN2 from tN where cN2 like 'val%';`    % 表示任何字符出现任意次数
- `select cN1,cN2 from tN where cN2 like '%al%';`    % 无法匹配到 null
- `select cN1,cN2 from tN where cN2 like 'v%e';` 
- `select cN1,cN2 from tN where cN2 like 'valu_';`  _ 只匹配一个字符
- 通配符处理更花时间，尽量用其他操作符，尽量不要把通配符用在搜索模式的开始处，影响效率

### 正则表达式 regexp
- `select cN1,cN2 from tN where cN2 regexp 'value';`  regexp 后面跟的内容作为正则表达式
- `select cN1,cN2 from tN where cN1 regexp '1';`

### like 和 regexp 的区别
- `like 'value'` 和 `regexp 'value'` 返回内容一样
- `like 'alue'` 和 `regexp 'alue'`  like 没有返回内容， regexp 返回含有 value 值的行
- like 匹配整个列，regexp 还对列值内进行匹配
- 这里没有列值为 alue 的行，所以 like 没有返回内容，而 regexp 对列值内匹配，所以有返回内容

### |
- `select cN1,cN2 from tN where cN2 regexp 'value1|value2';`
- `select cN1,cN2 from tN where cN2 regexp 'value1|2';`  匹配含有 value1 或者 2 的值
- `select cN1,cN2 from tN where cN1 regexp '1|2|3|4';`

### [ ] / [^ ]
- `select cN1,cN2 from tN where cN2 regexp 'value[123]';`    匹配特定字符，返回 value1,value2,value3
- []其实是另一种形式的 or ; [123]是[1|2|3]的缩写
- `select cN1,cN2 from tN where cN2 regexp 'value[^123]';`   否定[123],匹配这些字符以外的任意字符

### [0-9] / [a-z]
- `select cN1,cN2 from tN where cN2 regexp 'value[1-3]';` 
- `value[1-3]`等同于`value[123]`    [a-z]还可以匹配人以字母

### 转义字符 \\
- `select cN1,cN2 from tN where cN2 regexp '.';` . 匹配任意字符
- `select cN1,cN2 from tN where cN2 regexp '\\.';` 匹配 .
- `select cN1,cN2 from tN where cN2 regexp '\\-';` 匹配 -
- \\\双反斜杠转义 ，用于匹配特殊字符

![](/images/MySQLCrashCourse/02.png) 

- 多数正则表达式实现使用单个反斜杠转义特殊字符；但是MySQL使用两个反斜杠，MySQL自己解释一个，正则表达式库解释另外一个

### 预定义字符集
- `select cN1,cN2 from tN where cN2 regexp '[:alnum:]';` 使用预定义字符集

![](/images/MySQLCrashCourse/03.png) 

### 重复元字符
- `select cN1,cN2 from tN where cN2 regexp 'valu?';` 匹配多个实例，匹配具体的字符次数

![](/images/MySQLCrashCourse/04.png) 

### 定位符
- `select cN1,cN2 from tN where cN2 regexp '^[v123]';`   匹配特定位置的字符

![](/images/MySQLCrashCourse/05.png) 

- ^ 在集合中 [] 表否定该集合，否则表示串的起点
- 正如前面所说 like 匹配整个串，regexp 匹配子串
- 利用 ^ 和 $ 就可使 regexp 起到 like 的作用
- `select cN1,cN2 from tN where cN2 rehexp '^value$';`  等同于 `select cN1,cN2 from tN where cN2 like 'value';` 

## <center>计算字段</center>
- 直接从数据库中检索出转换、计算或格式化过的数据
- 计算字段是运行时在 select 语句内创建的

### 拼接字段
- 把值联结到一起构成单个值
- `select Concat(cN1,cN2) from tN;` 返回结果为 cN1 和 cN2 的值构成的一个新值 
- `select Concat(cN1,RTrim(cN2)) from tN;`  RTrim()去掉值右边的所有空格
- `select Concat(cN1,LTrim(cN2)) from tN;`  RTrim()去掉值左边的所有空格
- `select Concat(cN1,Trim(cN2)) from tN;`  RTrim()去掉值左右两边的所有空格
- `select Concat(cN1,cN2) as NewcN from tN;` 形成的新值没有名称，需要赋予它一个字段名

### 算数计算
- `select cN1,cN2,cN3,cN1+cN3 as SumcN from tN;;` 同样可以用括号来提高优先级

![](/images/MySQLCrashCourse/06.png) 

## <center>函数处理</center>

### 文本
- `select cN1,Upper(cN2) from tN;` 大写转换

![](/images/MySQLCrashCourse/07.png) 

![](/images/MySQLCrashCourse/08.png) 

![](/images/MySQLCrashCourse/09.png) 

### 时间

![](/images/MySQLCrashCourse/10.png) 

### 数值

![](/images/MySQLCrashCourse/11.png) 

### 聚集
- `select cN1,AVG(cN2) from tN;` 平均值，AVG()函数忽略列值为 null 的行，同理 count(),max(),min(),sum()也是忽略 null 的行

![](/images/MySQLCrashCourse/12.png) 

- `select count(*) from tN;`  行数目计数，无论是否 null 都会计数
- `select count(cN2) from tN;` 列值为 null 的行会被忽略 
- `select cN1,AVG(distinct cN2) from tN;` 忽略相同的列值
- ```sql
  select count(*) as NewcN1,
        min(cN3) as NewcN2,
        max(cN3) as NewcN3,
        avg(cN3) as NewcN4,
  from tN;
  ```

## <center>分组</center>

### group by
- ```sql
  select cN1,count(*) as NewcN 
  from tN 
  group by cN1;
  ```

![](/images/MySQLCrashCourse/13.png) 

### having 
- where 过滤指定行并且没有分组的概念
- where 过滤行，having 过滤分组
- having 支持所有 where 操作符
- ```sql
    select cN1,count(*) as NewcN 
    from tN 
    group by cN1
    having count(*) >= 2;
  ```
- 也可以理解为 where 在 group by 前过滤，having 在 group by 后过滤

### group by 与 order by

![](/images/MySQLCrashCourse/14.png) 

- group by 以分组的顺序输出，但是有时候需要以不同于分组默认的顺序输出
- 这种情况就需要提供 order by 子句 ，以明确输出的顺序方式

### select 子句顺序
- ```sql
    select
    from
    where
    group by
    having 
    order by
    limit
  ```

![](/images/MySQLCrashCourse/15.png) 

![](/images/MySQLCrashCourse/16.png) 

## <center>子查询</center>
- 子查询总是从内向外处理
- ```sql
    select cN1,cN2
    from tN
    where cN5 in (select cN5
                  from tN2
                  where cN7 in (select cN7
                                from tN3
                                where cN9 = 'v'
                                )
                  );
  ```

- 作为计算字段使用子查询
- ```sql
    select cN1,
           cN2,
           (select count(*)
            from tN2
            where tN2.cN1 = tN.cN1) as NewcN
    from tN;
  ```

## <center>联结表</center>
- 关系表：各表通过某些常用值互相关联；在A表中建立了B表中某些字段的列，把两个表联系起来
- 外键：某个表中的一列，它包含另外一个表的主键值，定义了两个表之间的关系

### 内部联结 inner join
- ```sql
    select cN2,cN3
    from tN1,tN2
    where tN1.cN1 = tN2.cN1
  ```
- 以上的联结称为 等值联结，基于两个表之间的相等测试，也成为 内部联结
- 可以用以下更为标准的联结语法
- ```sql
    select cN2,cN3
    from tN1 inner join tN2
    on tN1.cN1 = tN2.cN1
  ```
- 联结表的数目没有限制，但是这种处理非常消耗资源，联结的表越多，性能下降越厉害
- ```sql
    select cN2,cN3,cN4
    from tN1,tN2,tN3,tN4
    where tN1.cN1 = tN2.cN1
      and tN3.cN1 = tN1.cN1
      and tN4.cN1 = tN1.cN1
  ```

### 使用别名
- ```sql
    select cN2,cN3
    from tN1 as a,tN2 as b
    where a.cN1 = b.cN1
  ```

### 自联结 
- ```sql
    select cN2,cN3
    from tN1
    where cN1 = (select cN1
                 from tN1
                 where cN2='x'
                 );
  ```
- 从同一个表从查询内容，上面用了子查询，分了两步进行操作
- 下面用联结的方式进行相同查询
- ```sql
    select cN2,cN3
    from tN1 as a , tN1 as b
    where a.cN1 = b.cN1
      and b.cN2 = 'x';
  ```
- 因为对一个表自己进行联结，相当于每个字段出现了两次，所以要用别名把表的字段给区分开

### 自然联结
- 无论何时对表进行联结，都会出现至少一个列出现在不止一个表中。
- 自然联结可以排除多次出现，使每个列只返回一次
- ```sql
    select a.*,b.cN2,b.cN3
    from tN1 as a , tN2 as b
    where a.cN1 = b.cN1;
  ```
- 对表 a 使用通配符全部检索列，对表 b 明确指出列

### 外部联结 left/right outer join
- ```sql
    select cN2,cN3
    from tN1 left outer join tN2
    where tN1.cN1 = tN2.cN1;
  ```
- 内部联结是把满足条件的两个表的所有行组合起来，
- 外部联结主要区别在于（1）把满足条件的两个表的所有行组合起来（2）还要把未满足条件的 左/右 表的行也要附加组合进去
- `tN1 left outer join tN2;` 左外部联结
- `tN1 right outer join tN2;`    右外部联结
- 左/右 外部联结可以通过颠倒 from 中的表顺序转换，两种类型联结用哪种完全看方便而定

- ```sql
    select cN2,
           cN3
    from tN1 left outer join tN2
    where tN1.cN1 = tN2.cN1;
  ```

## <center>组合查询</center>

### union 
- ```sql
    select cN1,cN2,cN3
    from tN1
    union
    select cN1,cN2,cN3
    from tN2;
  ```
- union 组合的 select 语句出现的字段必须一致，顺序无所谓
- union 组合查询出来的结果为各个查询语句按先后查询的顺序组合
- union 的查询结果会自动去重，保留先查询出的行，去除后面查询出的重复的行

### union all
- 如果想全部保留查询组合结果可使用 union all
- ```sql
    select cN1,cN2,cN3
    from tN1
    union all
    select cN1,cN2,cN3
    from tN2;
  ```
- union 几乎总是完成与多个 where 条件相同的工作
- union all 可以完成匹配全部（包括重复行），而 where 就不行

### 对组合查询结果排序
- 只能用一条 order by 子句，并且必须出现在最后一条 select 语句之后
- ```sql
    select cN1,cN2,cN3
    from tN1
    union all
    select cN1,cN2,cN3
    from tN2
    order by cN1;
  ```
- order by 子句放在最后，是对组合查询的整个结果进行排序

## <center>全文本搜索</center>

### 启用
- 一般在创建表的时候启用 全文本搜索
- ```sql
    create table tN
    (
      id          int       not null auto_increment,
      title       char(10)  not null,
      note_text   text      null,
      primary key(id),
      fulltext(note_text)  
    )engine=MyISAM;
  ```

### 使用
- Match()指定被搜索的列，Against()指定要使用的搜索表达式
- ```sql
    select note_text
    from tN
    where Match(note_text) Against('value');
  ```
- 查询结果为 note_text 列中带有 value 值的行
- 全文本搜索不区分大小写
---
- 下面的 like 子句也可查询同样的结果
- ```sql
    select note_text
    from tN
    where note_text like '%value%';
  ```
- 全文本搜索返回的结果行顺序和 like 子句返回的行顺序稍有区别
- 全文本搜索返回的结果按照 词的出现的次序等级 对每个结果行进行排序（比如：value 出现在第一个词比出现在第三个词的等级高） ；具有较高等级的行先出现，排在前面
- 等级由MySQL根据行中词的数目、唯一词的数目、整个索引中词的总数以及包含该词的行的数目计算出来
- like 子句以不是特别有用的顺序返回数据
---
- ```sql
    select note_text
           Match(note_text) Against('value') as rank
    from tN；
  ```
- 如果在 select 子句中使用 Match() 和 Against(),则会返回一个计算列
- 计算列的值就是词的等级值，不包含检索值的等级值为 0
- 这些值帮助全文本搜索如何排除行（等级为0的行），如何排序结果（按等级降序排列）
- 由于数据是索引的，全文本搜索速度还比较快

### 查询扩展
- `with query expansion`  用来放宽返回文本的搜索结果的范围
- 比如想查询包含 value 和其他包含相关信息的行，即使其它行中不包含 value 
- ```sql
    select note_text
    from tN
    where Match(note_text) Against('value' with query expansion);
  ```
- 查询扩展的执行顺序：
  1. 先执行基本全文本搜索，找出与条件匹配的所有行
  2. 其次，MySQL检查这些匹配行并选择与条件词相关的有用词
  3. 最后，MySQL再次执行全文本搜索，这次不仅使用原来的条件，还附带了相关有用词的条件
- 利用查询扩展，能够尽可能的查询出相关结果，即使它们不是很精确

### 布尔文本搜索
- `in boolean mode`

![](/images/MySQLCrashCourse/17.png) 

- 没有指定操作符，搜索结果匹配 value 或 key 中至少一个词的行
- ```sql
    select note_text
    from tN
    where Match(note_text) Against('value key' in boolean mode);
  ```
- 搜索结果匹配 value key 短语的行
- ```sql
    select note_text
    from tN
    where Match(note_text) Against('"value key"' in boolean mode);
  ```
- 搜索结果匹配包含 value 排除 key 的行
- ```sql
    select note_text
    from tN
    where Match(note_text) Against('"+value -key"' in boolean mode);
  ```
- 在布尔方式中，不按等级值降序返回的行

![](/images/MySQLCrashCourse/18.png) 

![](/images/MySQLCrashCourse/19.png) 

## <center>插入数据</center>

### insert into
- `insert into tN values('key','value','null');` 
- 每个列字段必须提供值，没有值可提供 null 值 （假设该列允许为空值）
- 上面的写法简单，但并不安全，极度依赖表字段的次序
- 应该用以下的标准写法
- `insert into tN(cN2,cN1，cN3) values('value','key','x');` 
- 这种写法不依赖表字段次序，按照自定的列字段次序填充即可

### insert low_priority into
- 降低 insert 语句优先级，因为 insert 操作可以很耗时，而且它可能降低等待处理的 select 语句的性能
- `insert low_priority into tN(cN2,cN1，cN3) values('value','key','x');` 
- 同样使用于 update 和 delete 语句

### 插入多行
- 使用多条 insert 语句，最后一次提交即可
- ```sql
    insert into tN(cN2,cN1，cN3) values('value','key','x');
    insert into tN(cN2,cN1，cN3) values('value1','key1','x1');
  ```
- 如果插入同一个表，并且结构相同，也可以用以下方式
- ```sql
    insert into tN(cN2,cN1，cN3) 
    values('value','key','x')
          ('value1','key1','x1')
          ('value2','key2','x2');
  ```
- MySQL用单条 insert 语句处理多个插入 比 使用多条 insert 语句快

### 插入检索出的数据 insert select 
- 可以从其他表导入数据
- ```sql
    insert into tN(cN2,cN1，cN3) 
    select cN1,cN2,cN3
    from tN2;
  ```
- select 语句的每个列对应插入 insert 语句的每个列中
- 还可以添加 where 子句等条件
- ```sql
    insert into tN(cN2,cN1，cN3) 
    select cN1,cN2,cN3
    from tN2
    where cN1 > 2;
  ```

## <center>更新/删除 数据</center>

### update set
- ```sql
    update tN
    set cN2 = 'value'
    where cN1 = 1;
  ```
- ```sql
    update tN
    set cN2 = 'value',
    set cN3 = 'key'
    where cN1 = 1;
  ```
- 删除列值，可以把它设为 null （假设该列允许为空值）
- ```sql
    update tN
    set cN2 = 'null'
    where cN1 = 1;
  ```

### delete
- `delete from tN where cN1 = 1;` 删除行
- `delete from tN ` 删除表所有内容/删除表中所有行

## <center>操纵表</center>

### create table 
- 建立新表，指定的表名必须不存在，否则需要先手工删除已存在同名的表
- ```sql
    create table tN(
      cN1 int       not null auto_increment,
      cN2 char(10)  not null ,
      cN3 char(19)  null,
      primary key (cN1)
    );
  ```
- 如果仅想在一个表不存在时创建它，可以在表名后给出 `if not exists`
- ```sql
    create table tN if not exists(
      cN1 int       not null auto_increment,
      cN2 char(10)  not null ,
      cN3 char(19)  null,
      cN4 int       null default 20
      primary key (cN1)
    )ENGINE = InnoDB;
  ```
- MySQL 语句中忽略空格

![](/images/MySQLCrashCourse/20.png) 

- `select last_insert_id()` 这个函数可以获取最后插入行的自增id值 

### 引擎类型
- MySQL 有具体管理和处理数据的内部引擎
- 当使用`create table`时，该引擎具体创建表；当使用`select`等语句时，处理数据库操作请求
- 一般在 `ENGINE = `中表明使用的引擎类型
- InnoDB是一个可靠的事务处理引擎，它不支持全文本搜索
- MyISAM是一个性能极高的引擎，它支持全文本搜索，但不支持事务处理
- MEMORY在功能上等同于MyISAM,但由于数据存储在内存中，速度很快（特别适合于临时表）
- 引擎类型可以混用，在不同的表选用适合的引擎
- 外键不能跨引擎

### alter table
- 增加列
- ```sql
    alter table tN
    add cN5 int;
  ```
- 删除列
- ```sql
    alter table tN
    drop cN5 int;
  ```
- `alter table` 常用来定义外键
- ```sql
    alter table tN
    add constraint fk_tN_tN1  
    foreign key (cN9) references tN1 (cN9)
  ```

### drop table
- `drop table tN` 删除表

### rename table
- `rename table tN to NewtN`  重命名表
- ```sql
    rename table tN1 to NewtN1,
                 tN2 to NewtN2,
                 tN3 to NewtN3;
  ```

## <center>视图</center>
- 视图是虚拟的表，视图只包含使用时动态检索数据的查询
- 视图本身不包含数据，它们返回的数据是从其他表中检索出来的
- 视图相当于把 select 语句给封装起来，简化数据处理以及重新格式化基础数据或保护基础数据

![](/images/MySQLCrashCourse/21.png) 

- 视图不能被索引，也不能有关联的触发器或默认值
- 视图可以和表一起使用

### 简化复杂联结
- 视图的最常见应用之一是隐藏复杂的SQL
- 就是把复杂的查询结果作为视图，然后提供给之后的查询使用，提高便利和复用性
- ```sql
    create view viewName as
    select cN1,cN2,cN3
    from tN1,tN2,tN3
    where tN1.cN1 = tN2.cN1
      and tn3.cN1 = tN2.cN1;
  ```
- 有了上面的视图创建之后，下面就可以很方便的利用已经创建好的视图，简化SQL
- ```sql
    select cN1,cN2
    form viewName
    where cN1 = 2;
  ```

### 重新格式化已检索的数据
- 视图另一常见的用途是重新格式化检索出的数据
- ```sql
    select Concat(RTrim(cN1),'(',RTrim(cN2),')') as NewcN
    from tN2
    order by cN1;
  ```
- 如果经常会用到以上的格式的查询结果时，可以把这个结果创建成视图，就不必每次都执行联结
- ```sql
    create view viewName as
    select Concat(RTrim(cN1),'(',RTrim(cN2),')') as NewcN
    from tN2
    order by cN1;
  ```
- 然后就可以很方便的利用它了
- `select * from viewName` 返回和上面一样的结果

### 过滤数据
- ```sql
    create view viewName as
    select cN1,cN2
    from tN
    where cN2 is not null;
  ```
- 上面的可以理解为把 `select cN1,cN2 from tN`创建成视图 viewName
- 然后在 viewName 视图中使用 where 子句过滤
- 视图在处理 where 子句时，会把 where 子句添加到内部语句`select cN1,cN2 from tN`中，形成`select cN1,cN2 from tN where cN2 is not null;`进行查询，以便正确的过滤数据

### 计算字段
- ```sql
    select cN1,cN2,cN3,cN1*cN3 as NewcN
    from tN
    where cN2 = 'value';
  ```
- ```sql
    create view viewName as
    select cN1,cN2,cN3,cN1*cN3 as NewcN
    from tN;
  ```
- ```sql
    select * 
    from viewName  
    where cN2 = 'value';
  ```

### 更新视图
- 视图没有数据，对视图进行增加或删除行，实际上是对其表的增加或删除行
- 通常，视图是可以更新的（insert/update/delete）,但是，并非所有视图都可以更新
- 也就是说，如果MySQL不能正确地确定被更新的基数据，则不允许更新
- 如果视图定义中有以下操作，则不能进行视图的更新
  1. 分组 group by /having
  2. 联结
  3. 子查询
  4. 并
  5. 聚集函数
  6. distinct
  7. 导出（计算）列
- 换句话说，多数视图都是不可更新的
- 一般来说，应该将视图用于检索，而不用于更新

## <center>存储过程</center>
- 存储过程简单来说，就是为以后的使用而保存的一条或多条MySQL语句的集合
- 为什么要使用存储过程
  1. 把处理封装在容易使用的单元中，简化复杂操作
  2. 开发人员都一起用一套存储过程，保证了数据的完整性
  3. 简化对变动的管理，只需要修改存储过程的代码即可
  4. 提高性能，使用存储过程比使用单独的SQL语句要快
  5. 存在一些只能使用在单个请求中的MySQL元素和特性，存储过程可以使用它们来编写功能更强更灵活的代码

### 执行存储过程
- MySQL称存储过程的执行为调用，因此执行存储过程的语句为 call
- ```sql
    call productpricing(@pricelow,
                        @pricehigh,
                        @priceaverage);
  ```
- 执行名为 productpricing 的存储过程，返回最低、最高、平均价格
- 存储过程的结果可以显示，也可以不显示

### 创建存储过程
- ```sql
    create procedure productpricing()
    begin
      select avh(prod_price) as priceaverage
      from products;
    end;
  ```
- `create procedure` 创建存储过程
- `create procedure productpricing()` 如果存储过程接受参数，可以在（）中列举
- begin 和 end 用来限定存储过程体
- 过程体本身就是 SQL 语句

![](/images/MySQLCrashCourse/22.png) 

![](/images/MySQLCrashCourse/23.png) 

- `call productpricing();`  执行刚才创建的存储过程并返回结果
- 存储过程实际上是一直函数，所以存储过程名后需要有（）

### 删除存储过程
- `drop procedure productpricing` 删除存储过程，存储过程名后面不带（）
- 如果指定的存储过程不存在，则产生错误提示
- `drop procedure is exist productpricing` 仅当存储过程存在的时候删除，不存在的时候删除也不会产生错误提示

### 使用参数
- ```sql
    create procedure productpricing(
      out pl decimal(8,2),
      out ph decimal(8,2),
      out pa decimal(8,2)
    )
    begin
      select min(prod_price)
      into pl
      from products;
      select max(prod_price)
      into ph
      from products;
      select avg(prod_price)
      into pa
      from products;
    end;
  ```
- pl 最低价，ph 最高价，pa 平均价
- out 关键字：从存储过程传出一个值给调用者
- into 关键字：指定保存的变量
- 这里的整体意思是，把查询（select）的结果保存（into）到变量（pl/ph/pa）中，然后返回给调用者
- 此外、in 关键字：传递给存储过程；inout 关键字：对存储过程的传入和传出
- 以下调用该存储过程，传递对应数目的参数
- ```sql
    call productpricing(@pricelow,
                        @pricehigh,
                        @priceaverage);
  ```
- 检索返回的值
- `select @pricelow,@pricehigh,@priceaverage;`
---
- ```sql
    create procedure ordertotal(
      in onmuber int,
      out ototal decimal(8,2)
    )
    begin
      select sum(item_price*quantity)
        from orderitems
        where order_num = onumber
        into ototal;
    end;
  ```
- `call ordertotal(20005,@total);`
- `select @total;`
- 想得到另外的结果，需要再次调用存储过程
- `call ordertotal(20009,@total);`
- `select @total;`

### 智能存储过程
- ```sql
  -- Name: ordertotal
  -- Parameters: onumber = order number
  --             taxable = 0 if not taxable, 1 if taxable
                 ototal = order total variable

  create procedure ordertotal(
    in onumber int ,
    in taxable boolean ,
    out ototal decimal(8,2)
  ) comment 'Obtain order total, optiona11y adding tax'
  begin
    -- Declare variable for total
    -- Declare tax percentage

    declare total decimal(8,2);
    declare taxrate int default 6;

    -- Get the order total

    select Sum(item_ price*quantity)
    from orderitems
    where order_ num = onumber
    into total;

    -- Is this taxable?
    -- Yes, so add taxrate to the total

    if taxable then
       select total+(total/100*taxrate) into total;
    end if;

    -- And finally,save to out variable

       select total into ototal;
  end;     
  ```
- 注释（--）
- declare 定义了局部变量
- if , elseif , else 判断

![](/images/MySQLCrashCourse/24.png) 

- 测试执行以上的存储过程
- ```sql
  call ordertotal(20005,0,@total);
  select @total;
  ```
- ```sql
  call ordertotal(20005,1,@total);
  select @total;
  ```

### 检查存储过程
- `show create procedure ordertotal;`
- `show procedure status;`

![](/images/MySQLCrashCourse/25.png) 

## <center>游标</center>
- 游标是一个存储在 MySQL 服务器上的数据库查询，他不是一条 select 语句，而是被该语句检索出来的结果集
- 游标主要用于交互式应用，其中用户需要滚动屏幕上的数据，并对数据进行浏览或做出更改
- MySQL 游标只能用于存储过程

### 使用准则
- 在能够使用前，必须声明它
- 一旦声明后，必须打开游标以供使用
- 对于填有数据的游标，根据需要取出各行
- 在结束游标使用时，必须关闭游标

### 创建游标
- 游标用 declare 语句创建
- ```sql
    create procedure processorders()
    begin
        declare ordernumbers cursor
        for
        select order_num from orders;
    end;
  ```
- 存储过程处理完成后，游标就消失（因为它局限于存储过程）

### 打开/关闭 游标
- `open ordernumbers;`  打开游标
- 处理 open 语句时执行查询，存储检索出的数据以供浏览和滚动
- `close ordernumbers;` 关闭游标
- close 释放游标使用的所有内部内存和资源，因此在每个游标不再需要时都应该关闭
- 声明过的游标不需要再次声明，用 open 语句打开它就可以了

![](/images/MySQLCrashCourse/26.png)

- ```sql
    create procedure processorders()
    begin
        declare ordernumbers cursor
        for
        select order_num from orders;
        open ordernumbers;
        close ordernumbers;
    end;
  ```
- 打开/关闭 游标的操作需要在存储过程中使用，相当于把检索出的数据用游标定位再做一次检索
- 主要操作还是通过 call 存储过程来体现

### 使用游标数据
- fetch 关键字：指定检索什么数据（所需的列），检索出来的数据存储在什么地方；他还向前移动游标中的内部行指针，使下一条 fetch 语句检索下一行（不重复读取同一行）
- ```sql
    create procedure processorders()
    begin
      declare o int;

      declare ordernumbers cursor
      for
      select order_num from orders;

      open ordernumbers;
      fetch ordernumbers into o;
      close ordernumbers;
    end;
  ```
- fetch 检索了当前行 order_num 列（自动从第一行开始）到一个名为 o 的局部变量中
---
- ```sql
    create procedure processorders()
    begin
      declare done boolean default 0;
      declare o int;

      declare ordernumbers cursor
      for
      select order_num from orders;

      declare continue handler for sqlstate '02000' set done=1;

      open ordernumbers;
      repeat
        fetch ordernumbers into o;
      until done end repeat;
      close ordernumbers;
    end;
  ```
- `repeat` 和 `until done end repeat;`之间为循环体，执行到 done 为真
- `  declare continue handler for sqlstate '02000' set done=1;` continu handler 指出当 sqlstate '02000' 出现时，设置 done 为 1 
- sqlstate '02000'是一个未找到条件，当REPEAT由于没有更多的行供循环而不能继续时，出现这个条件

![](/images/MySQLCrashCourse/27.png) 

### 完整实例
- ```sql
  create procedure ordertotal(
    in onumber int ,
    in taxable boolean ,
    out ototal decimal(8,2)
  ) comment 'Obtain order total, optiona11y adding tax'
  begin
    declare total decimal(8,2);
    declare taxrate int default 6;

    select Sum(item_ price*quantity)
    from orderitems
    where order_ num = onumber
    into total;

    if taxable then
       select total+(total/100*taxrate) into total;
    end if;

       select total into ototal;
  end;     
  ```
- ```sql
  create procedure processorders()
  begin
    declare done boolean default 0;
    declare o int;
    declare t decimal(8,2);

    declare ordernumbers cursor
    for
    select order_num from orders;

    declare continue handler for sqlstate '02000' set done=1;

    create table if not exists ordertotals(order_num int,total decimal(8,2));

    open ordernumbers;
    repeat
      fetch ordernumbers into o;
      call ordertotal(o,1,t);
      insert into ordertotals(order_num,total)
      values(o,t);
    until done end repeat;
    close ordernumbers;
  end;
  ```

## <center>触发器</center>
- 触发器：在事件发生的时候自动执行；在某个表发生更改时自动处理
- 触发器响应的语句：（1）delete（2）insert（3）update

### 创建触发器
- 创建触发器的准则
  1. 唯一的触发器名 
  2. 触发器关联的表
  3. 触发器应该响应的活动（delete/insert/update）
  4. 触发器何时执行（处理之前还是之后）
- `create trigger` 创建触发器
- ```sql
    create trigger newproduct after insert on products
    for each row select 'product added'
  ```
- 创建名为 newproduct 的触发器
- after insert 在 insert 语句执行后执行
- on products 对于这个表进行响应
- for each row 代码对每个插入行执行
- 'product added' 对每个插入的行显示一次
- 整个流程为：对 products 表每使用 insert 语句添加一行或多行，会看到对每个成功的插入，都会显示 product added 消息

![](/images/MySQLCrashCourse/28.png) 

- 触发器安每个表每个事件每次地定义
- 每个表每个事件每次只允许一个触发器
- 因此，每个表最多支持6个触发器（每条insert、update、delete的之前和之后）
- 单一触发器不能与多个事件或多个表关联

![](/images/MySQLCrashCourse/29.png) 

### 删除触发器
- `drop trigger newproduct` 删除触发器
- 触发器不能更新或覆盖；修改一个触发器，必须先删除它，然后再重新创建

### 使用触发器

#### insert 触发器
1. 在 insert 触发器代码内，可以引用一个名为 new 的虚拟表，访问被插入的行
2. 在 before insert 触发器中，new 中的值也可以被更新（允许更改被插入的值）
3. 对于 auto_increment 列，new 在 insert 执行之前包含0，在 insert 执行之后包含新的自动生成值
- ```sql
    create trigger neworder after insert on orders
    for each row select new.order_num;
  ```
- order_num 是 orders 中的自增字段
- 每次执行插入操作时，都会引用名为 new 的虚拟表，然后把 orders 中获得的 order_num 值填充到新的虚拟表中
- order_num 是 orders 中的自增字段 ，因此该触发器必须 after insert , 因为 before insert 的话，order_num 还没生成
- ```sql
  insert into orders(order_date,cust_id)
  values(now(),10001);
  ```
- ```sql
  |order_num|
  |—————————|              
  |  20001  |
  ```
![](/images/MySQLCrashCourse/30.png)

#### delete 触发器
1. 在 delete 触发器代码内，可以引用一个名为 old 的虚拟表，访问被删除的行
2. old 中的值全都是只读的，不能更新
- ```sql
    create trigger deleteorder before delete on orders
    for each row
    begin
      insert into archive_orders(order_num,order_date,cust_id)
      values(old.order_num,old.order_date,old.cust_id)
    end;
  ```
![](/images/MySQLCrashCourse/31.png)

#### update 触发器
-	在 update 触发器代码中，可以引用一个名为 old 的虚拟表访问以前（update语句前）的值，引用一个名为 new 的虚拟表访问新更新的值
-	在 before update 触发器中，new 中的值可能也被更新（允许更改将要用于 update 语句中的值）
-	old 中的值全都是只读的，不能更新
- ```sql
    create trigger updatevendor before update on vendors
    for each row set new.vend_state = upper(new.vend_state);
  ```

## <center>事务</center>

### 事务处理
- 并非所有引擎都支持事务处理
- MyISAM 和 InnoDB 是两种最常用的引擎，前者不支持明确的事务处理管理，而后者支持
- 事务处理：可以用来维护数据库的完整性，保证成批的 MySQL 操作要么完全执行，要么完全不执行
1. 事务（transaction）指一组SQL语句
2. 回退（rollback）指撤销指定SQL语句的过程
3. 提交（commit）指将未存储的SQL语句结果写入数据库表
4. 保留点（savepoint）指事务处理中设置的临时占位符（place- holder），可以对它发布回退（与回退整个事务处理不同）

### 控制事务处理
- 管理事务处理的关键在于将SQL语句组分解为逻辑块，并明确规定数据何时应该回退，何时不应该回退
- `start transaction` 标识事务的开始

#### 回退 rollback
- ```sql
    select * from ordertotals;
    start transaction;
    delete from ordertotals;
    select * from ordertotals;
    rollback;
    select * from ordertotals;
  ```
- rollback 语句回退 start transaction 之后的所有语句
- 整个流程为：（1）查看表内容不为空（2）标识事务开始（3）删除表内容（4）查看表内容为空（5）回退（6）查看表内容不为空
- rollback 只能在一个事务处理内使用（在执行一条 start transaction 命令之后）

![](/images/MySQLCrashCourse/32.png)

#### 提交 commit
- 一般的 MySQL 语句都是直接针对数据库表执行和编写的；这就是所谓的隐含提交（implicit commit），即提交（写或保存）操作是自动进行的
- 但是，在事务处理块中，提交不会隐含地提交
- 为进行明确的提交，使用 commit 语句
- ```sql
    start transaction;
    delete from orderitems where order_num = 20010;
    delete from orders where order_num =20010;
    commit;
  ```
![](/images/MySQLCrashCourse/33.png)

#### 保留点 savepoint
- 复杂一点的事务处理可能需要部分提交或回退
- 这个时候就需要在事务处理中合适的位置放置占位符，如果需要回退，就可以回退到占位符的位置，这些占位符就称为 保留点
- `savepoint delete1;` 创建保留点
- `rollback to delete1;` 回退到保留点

![](/images/MySQLCrashCourse/34.png)

![](/images/MySQLCrashCourse/35.png)

#### 更改默认的提交行为
- 默认的 MySQL 行为是自动提交所有更改；换句话说，任何时候你执行一条 MySQL 语句，该语句实际上都是针对表执行的，而且所做的更改立即生效
- `set autocommit = 0;`  为了让 MySQL 不自动提交更改 ，设置 autocommit 为0（假）

![](/images/MySQLCrashCourse/36.png)

## <center>全球化和本地化</center>
- 数据库表用来存储和检索数据
- 不同的语言和字符集需要以不同的方式存储和检索
- 字符集：字母和符号的集合
- 编码：某个字符集成员的内部表示
- 校对：规定字符如何比较的指令

![](/images/MySQLCrashCourse/37.png)

- `show character set;` 显示所有可用的字符集以及每个字符集的描述和默认校对
- `show collation;` 显示所有可用的校对，以及它们适用的字符集；有的字符集具有不止一次的校对
---
- `show variables like 'character%';` 指定默认的字符集和校对
- `show variables like 'collation%';` 
- 给表指定字符集和校对顺序
- ```sql
    create table mytable
    (
      columnn1 int,
      columnn2 varchar(10)
    ) default character set hebrew
      collate hebrew_general_ci;
  ```
- 给列指定字符集和校对顺序
- ```sql
    create table mytable
    (
      columnn1 int,
      columnn2 varchar(10)
      columnn3 varchar(10) character set latinl collate latin1_general_ci  
    ) default character set hebrew
      collate hebrew_general_ci;
  ```
- 指定备用的顺序校对
- ```sql
    select * from customers
    order by lastname,firstname collate latin1_general_cs;
  ```

![](/images/MySQLCrashCourse/38.png)

1. 如果指定 character set 和 collate 两者，则使用这些值
2. 如果只指定 character set ，则使用此字符集及其默认的校对
3. 如果既不指定 character set ，也不指定 collate ，则使用数据库默认

![](/images/MySQLCrashCourse/39.png)

- 如果绝对需要，串可以在字符集之间进行转换；使用 cast() 或 convert() 函数

## <center>安全管理</center>
- MySQL 用户账号和信息存在名为 mysql 的数据库中
- ```sql
    use mysql;
    select user from user;
  ```

### 用户设置
![](/images/MySQLCrashCourse/40.png)

- `create user oreki identified by 'p@$$wOrd'` 创建用户名和密码

![](/images/MySQLCrashCourse/41.png)

![](/images/MySQLCrashCourse/42.png)

![](/images/MySQLCrashCourse/43.png)

- `rename user oreki to elias`  重命名一个用户账号
- `drop user elias` 删除一个用户账号

![](/images/MySQLCrashCourse/44.png)

- `set password for elias = password('n3wp@$$wOrd')`  修改用户的密码
- `set password = password('n3wp@$$wOrd')`  不指定用户名时，更改当前登录用户的密码

### 权限设置
- 在创建用户账号后，必须接着分配访问权限
- 新创建的用户账号没有访问权限
- 它们能登录MySQL，但不能看到数据，不能执行任何数据库操作
- `show grants for elias` 查看用户账号的权限
- grant 语句需要给出的信息： （1）要授予的权限（2）被授予访问权限的数据库或表（3）用户名
- `grant select on crashcourse.* to elias;` 允许用户 elias 在 crashcourse 数据库的所有表上使用 select ; 只授予 select 访问权限，具有 只读 访问权限
- grant 的反操作为 revoke ,撤销特定的权限
- `revoke select on crashcourse.* from elias`

![](/images/MySQLCrashCourse/45.png)

![](/images/MySQLCrashCourse/46.png)

![](/images/MySQLCrashCourse/47.png)

![](/images/MySQLCrashCourse/48.png)

![](/images/MySQLCrashCourse/49.png)

## <center>数据库维护</center>
- `analyze table tN`  检查表键是否正确
- `check table tN` 
- `flush tables`  刷新表
- `flush logs`  刷新日志

![](/images/MySQLCrashCourse/50.png)

