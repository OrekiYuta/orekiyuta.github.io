---
title: Head First Java / After reading
date: 2020-06-07 00:08:00
tags: Java
---
## <center>Dog d =new Dog();</center>
 
- 在 d 中保存的是存取Dog()对象的方法，存储了指向Dog()对象的地址，存储了引用Dog对象的值。
对象并没有放进变量中。

![](/images/HeadFirstJava/01.png) 
<!-- more -->

## <center>继承</center>
- is a 单方向判断

- 可以用 子类 is a 父类，来判断是否符合继承关系

- super.xx(); 调用父类的方法

![](/images/HeadFirstJava/06.png) 

- JVM从最后的子类开始读取方法，层层向上读取


## <center>存取权限</center>
- private < default < protected < public

- public 的成员会被继承；private 的成员不会被继承

- 继承下来的方法可以被覆盖，但是成员变量无法被覆盖

## <center>抽象与接口</center>
- 抽象类必须要被继承，抽象方法必须要被覆盖

- 如果声明出抽象方法，那必须将类也标记为抽象

- 有抽象方法的类一定是抽象类

- 抽象方法必须被其中的子类，或最后的子类实现

- ArrayList 用到的是 Object 类型 ，所以ArrayList通用

- ArrayList<int> 是限制它的类型，这样 ArrayList只能保存int类型对象

- 没有直接继承过其他类的类是隐含的继承对象。所有类都继承于 Object 类

![](/images/HeadFirstJava/04.png) 

- Object 类主要目的：（1）作为多态让方法可以应对多种类型的机制 （2）提供Java在执行期的所有对象都有需要的基础方法

![](/images/HeadFirstJava/02.png) 

- 编译器只管引用的类型，而不管对象的类型；Animal a =new Dog(); 只根据引用类型 Animal 来判断有哪些方法可以调用

![](/images/HeadFirstJava/03.png) 

![](/images/HeadFirstJava/05.png) 

## <center>堆栈与对象</center>
- JVM启动，从底层操作系统取得一块内存；在此内存执行Java程序

- 在这内存中有两种区域：（1）对象的生存空间堆 （2）方法调用和变量的生存空间栈

![](/images/HeadFirstJava/07.png) 

- 变量在哪个空间要看它属于哪种变量：（1）实例变量（2）局部变量[栈变量]

![](/images/HeadFirstJava/08.png) 

- 调用方法压栈

![](/images/HeadFirstJava/09.png) 

- 局部变量在所属的方法中，所以在栈上；对象始终都是在堆上的

![](/images/HeadFirstJava/10.png) 

- 实例变量在所属的对象里面，所以在堆上

![](/images/HeadFirstJava/11.png) 

- 如果实例变量是个对像的引用，则引用和对象也都是在堆上

- 实例变量默认值：0/0.0/false,引用默认值 null

## <center>构造函数链</center>

![](/images/HeadFirstJava/12.png) 

- 创建子类对象时，父类对象的构造函数也会被层层执行

![](/images/HeadFirstJava/13.png) 

- 执行方法，先压栈，压栈完毕后才逐个从栈顶开始执行

![](/images/HeadFirstJava/14.png) 

- 调用父类构造函数的方法 super()

![](/images/HeadFirstJava/15.png) 

- 对 super() 的调用必须是构造函数的第一个语句

![](/images/HeadFirstJava/16.png) 

- 给父类构造函数传参 super(xxx)

![](/images/HeadFirstJava/17.png) 

- 从一个构造函数中调用另外一个构造函数 this()

![](/images/HeadFirstJava/18.png) 


## <center>对象与垃圾回收器</center>
- 对象的生命周期取决于引用它的变量的生命周期

![](/images/HeadFirstJava/19.png) 

![](/images/HeadFirstJava/20.png) 

- 对象被垃圾收集器回收

    （1）对象所处的方法执行完毕，方法弹出栈，因此里面的对象引用也消亡，所以对象没了引用，等待回收

    ![](/images/HeadFirstJava/21.png) 

    （2）对象引用被赋予新的对象，旧的对象失去了引用，等待回收

    ![](/images/HeadFirstJava/22.png) 

    （3）对象引用被赋予null,旧的对象同样失去了引用，等待回收

![](/images/HeadFirstJava/23.png) 

## <center>静态</center>

- 静态方法内没有变量，不依靠变量做出行为；可以直接通过类型方法调用

- 非静态方法需要先实例化，再依靠引用变量来调用

![](/images/HeadFirstJava/24.png) 

![](/images/HeadFirstJava/25.png) 

- 静态方法内无法调用非静态变量

![](/images/HeadFirstJava/26.png) 

- 静态方法内无法调用非静态方法

![](/images/HeadFirstJava/27.png) 

- 静态变量只会再第一次载入时进行初始化，并被同一个类的所有实例共享

![](/images/HeadFirstJava/28.png) 

- 实例变量：每个实例共享一个

- 静态变量：每个类共享一个

- 静态变量在所属的类的对象创建之前就完成初始化

![](/images/HeadFirstJava/29.png) 

- 同时标记静态 static 和 final 的变量是常数，一般命名都是全大写字母

![](/images/HeadFirstJava/30.png) 

- final 可以用来固定值不变，方法不能被覆盖，类不能被继承

![](/images/HeadFirstJava/31.png) 

