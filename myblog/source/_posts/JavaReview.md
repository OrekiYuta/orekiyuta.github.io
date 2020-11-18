---
title: Java Review
date: 2020-11-05 20:20:57
tags: Java
---

## 对象创建

- `Car carKey` 创建了引用实例
- `new Car()` 创建了对象
- `Car carKey = new Car();` 把对象赋给引用它的实例

## 初始化顺序
- 静态属性 > 静态方法 > 普通属性 > 普通方法 > 构造函数 

## this
- this 指向当前的对象
- this 可以调用方法、调用属性、和指向对象本身
- ![](/images/JavaReview/1.png)
<!-- more -->
## 封装(访问控制权限)
- ![](/images/JavaReview/2.png)

## 多态实现
- 继承
- 重写父类方法
- 父类引用指向子类对象 `Fruit fruit = new Apple();`

## 组合
就是将对象应用放在新的类中就可以了
- 多用组合，少用继承
- ```java
    public class SoccerPlayer{
        private String name;
        private Soccer soccer;
    }

    public class Soccer{
        private String soccerName;
    }
  ```
- ![](/images/JavaReview/3.png)

## 接口和抽象类
- 抽象等级: 接口 > 抽象类
- 接口定义了方法，抽象类定义了稍微具体点的方法
- 接口的实现必须实现全部方法，否则就该使用抽象类定义

## 异常
- 编译期异常、运行期异常
- Throwable 类是 Java 语言中所有 errors 和 exceptions 的父类
- 除了 RuntimeException 和它的子类，以及 error 和它的子类，其他所有异常都是 checkedException
- ![](/images/JavaReview/4.png)
- ![](/images/JavaReview/5.png)

## 内部类
就是将一个类的定义放在另一个类的内部
- ```java
    public class OuterClass {
        private String name ;     
        private int age;
        
        class InnerClass{
            public InnerClass(){
                name = "elias";
                age = 25;
            }
        }
    }
  ```
- 每个内部类都能独立地继承一个（接口）的实现，无论外部类是否已经继承了某个（接口的）实现，隐藏了内部实现的细节
- 内部类拥有外部类的访问权限
- 内部类还可以定义在方法和作用域内部，称为 局部内部类
- 内部类可以实现 Java 中的多重继承
- ![](/images/JavaReview/6.png)

## 集合
- ![](/images/JavaReview/7.png)
- ![](/images/JavaReview/8.png)

## 泛型
泛型是一种参数化的集合，限制了你添加进集合的类型
- ![](/images/JavaReview/9.png)

### 用泛型表示类
- 泛型可以加到类上面，来表示这个类的类型
- ![](/images/JavaReview/10.png)

### 用泛型表示接口
- ```java
    public interface Generator<T>{
        public T next();
    }
  ```
- 一般泛型接口常用于 生成器（generator），生成器相当于对象工厂，是一种专门用来创建对象的类

### 用泛型来表示方法
- ```java
    public class GenericMethods{
        public <T> void f(T x){
            System.out.println(x.getClass.getName());
        }
    }
  ```

### 泛型通配符
List 是泛型类，为了表示各种泛型 List 的父类，可以使用通配符（?）表示，它的元素类型可以匹配任何类型
- ```java
    public static void main(String[] args) {
        List<String> name = new ArrayList<String>();     
        List<Integer> age = new ArrayList<Integer>();     
        List<Number> number = new ArrayList<Number>();     
        name.add("elias");
        age.add(22);
        number.add(824);
        generic(name);
        generic(age);
        generic(number);   
    }

    public static void generic(List<?> data) {
        System.out.println("Test cxuan :" + data.get(0));
    }
  ```        
- 上界通配符：<? extends ClassType> 该通配符为 ClassType 的所有子类型。他表示的是任何类型都是 ClassType 类型的子类
- 下界通配符：<? super ClassType> 该通配符为 ClassType 的所有超类型。他表示的是任何类型的父类都是 ClassType

## 反射
反射主要提供了以下几个功能
- 在运行时，判断任意一个对象所属的类
- 在运行时，构造任意一个类的对象 
- 在运行时，判断任意一个类所有的成员变量和方法
- 在运行时，调用任意一个对象的方法
- `java.lang.reflect`所涉及的类
- ![](/images/JavaReview/11.png)
以下实例验证了一下
- ![](/images/JavaReview/12.png)
- ![](/images/JavaReview/13.png)

## 枚举
- 编辑器会为创建好的枚举自动添加 toString(),ordinal(),values()
- ordinal()表示Enum常量的声明顺序
- values(）显示顺序的值
- ![](/images/JavaReview/14.png)
- `Family father = Family.FATHER;` 枚举可以直接调用 

一般 switch 可以和 enum  一起连用，来构造一个小型的状态转换机
- ```java 
    enum Signal{
        GREEN,YELLOW,RED
    }
    public class Trafficlight{
        Signal color = Signal.GREEN;

        public void change(){
            switch (color){
                case GREEN:
                    color = Signal.YELLOW;
                    break;
                case YELLOW:
                    color = Signal.RED;
                    break;
                case RED:
                    color = Signal.GREEN;
                    break;
            }
        }
    }
  ```

## I/O
- ![](/images/JavaReview/15.png)
- ![](/images/JavaReview/16.png)

- 路径分隔符（Window 是 ; linux 是 :）
- 路径名称分隔符（Window 是 \ linux 是 /）
- ![](/images/JavaReview/17.png)

对文件操作
- ![](/images/JavaReview/18.png)

对文件夹操作
- ![](/images/JavaReview/19.png)
- 三种创建方式
- ```java
    File(String directoryPath);
    File(String directoryPath, String filename); 
    File(File dirObj, String filename);
  ```
- ```java
    File file = new File("D:\\java\\file1.txt"); 
    System.out.println(file);
    File file2 = new File("D:\\java","file2.txt");
    File parent = new File("D:\\java");
    File file3 = new File(parent,"file3.txt");
    System.out.println(file3);
  ```
- ![](/images/JavaReview/20.png)

### InputStream
- ![](/images/JavaReview/21.png)
### OutputStream
- ![](/images/JavaReview/22.png)
### Reader
- ![](/images/JavaReview/23.png)
### Writer
- ![](/images/JavaReview/24.png)

## java.io/lang/math/net
- ![](/images/JavaReview/25.png)
- ![](/images/JavaReview/26.png)
- ![](/images/JavaReview/27.png)
- ![](/images/JavaReview/28.png)