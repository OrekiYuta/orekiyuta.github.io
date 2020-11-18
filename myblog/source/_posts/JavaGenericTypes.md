---
title: Java GenericTypes
date: 2020-11-10 19:53:11
tags: Java
---
## 泛型类
泛型类,是在实例化类的时候, 指明 泛型的具体类型

### 泛型的类型参数不支持基本类型,只能是类对象类型
- ```java
    Generic<int> genericl = new Generic<int>(100);          // ❌
    Generic<Integer> genericl = new Generic<Integer>(100);  // ✔
  ```
👉[为什么Java泛型不支持基本类型？](https://qastack.cn/programming/2721546/why-dont-java-generics-support-primitive-types)
- 主要是为了向后兼容
<!-- more -->

### 泛型类在创建对象的时候,没有指定类型的话,将默认指定为 Object 类型

![](/images/JavaGenericTypes/1.png)

- 由于 基本数据类型 不继承自 Object 因此, 泛型参数不支持基本类型
- 除了8种基本数据类型(byte,short,int,long,float,double,char,boolean)以外都是 Object 的子类

#### 自动装箱

![](/images/JavaGenericTypes/2.png)

- `Object object = 1;` 没有编译问题,因为在赋值过程种自动装箱;
- 8种基本类型都有对应的包装数据类型
- 上图运行结果可见,经过了自动装箱

### 由同一泛型类,创建的不同数据类型的对象,本质上是同一类型

![](/images/JavaGenericTypes/3.png)

- `stringGeneric.getClass() == integerGeneric.getClass()`结果为 true , 说明内存地址相同

### 子类是泛型类的话,子类要和父类的泛型类型保持一致
- `class ChildGeneric<T> extends Generic<T>`
- 由子类来决定具体类型,就是调用的时候来指定的
 
![](/images/JavaGenericTypes/4.png)

- `class ChildGeneric<T,E,k> extends Generic<T>` 可以多个类型,但是至少保证一个类型和父类一致

### 子类不是泛型类,父类要明确泛型的数据类型
- `class ChildGeneric extends Generic<Integer>`

![](/images/JavaGenericTypes/5.png)

## 泛型接口

### 泛型接口的实现类是泛型类,实现类和接口的泛型类型要保持一致

![](/images/JavaGenericTypes/7.png)

### 泛型接口的实现类不是泛型类,接口要明确数据类型

![](/images/JavaGenericTypes/6.png)


## 泛型方法
泛型方法,是在调用方法的时候, 指明 泛型的具体类型

- 前面的例子中 那些诸如 `public E getValue() {}` 只是普通的成员方法,并不是泛型方法
- 只有声明了 `<T>` 的方法才是泛型方法 , T 可以是其他符号（E,K...）

![](/images/JavaGenericTypes/8.png)

- 泛型方法独立于类存在
- 即使 泛型方法的标识符和类标识符一致,泛型方法的类型取决于调用时候的类型
- 下图可以和上图做比较,可得出结论

![](/images/JavaGenericTypes/9.png)

- 泛型方法 和 泛型类里面的成员方法 的区别在于:泛型方法的类型取决于调用时的类型;泛型类里面的成员方法在使用的时候,必须遵从泛型类的类型

### 静态泛型方法
- 泛型类里面的成员方法 不能声明为静态 
- 泛型方法独立于类的存在,可以声明为静态

![](/images/JavaGenericTypes/10.png)

### 可变参数

![](/images/JavaGenericTypes/11.png)

## 类型通配符

![](/images/JavaGenericTypes/12.png)

- 按照多态思想, Integer 继承于 Number , 但是对泛型类型来说不适用

![](/images/JavaGenericTypes/13.png)

- 顺着思路,尝试重载,但是依然不行;同理 `Box<Object>` 同样不行
- 因为,前面说过了; `Box<Number> box`和`Box<Integer> box` 本质上都是 `Box<E>`;所以这两个是同一个方法

![](/images/JavaGenericTypes/14.png)

- 因此为了解决这个问题,引入了通配符`?`

![](/images/JavaGenericTypes/15.png)

### 上限
- `Box<? extends Number>` 指可以传 继承于 Number 的所有子类,最高上限传 Number

![](/images/JavaGenericTypes/16.png)

![](/images/JavaGenericTypes/17.png)

- 这里不允许添加元素,因为确定不了类型

![](/images/JavaGenericTypes/18.png)

- ArrayList 里面的 addAll() 就用了 上限通配符

![](/images/JavaGenericTypes/19.png)

![](/images/JavaGenericTypes/20.png)

### 下限
- 类/接口<? super 实参类型>
- 要求该泛型的类型，只能是实参类型，或实参类型的 父类类型

![](/images/JavaGenericTypes/21.png)

- 遍历元素下限通配符元素的时候,拿 0bject 类型,因为无论是 Cat 还是所有的父类,都来自于 Object

- 这里可以添加元素,但是不保证元素数据类型的约束要求
![](/images/JavaGenericTypes/22.png)

![](/images/JavaGenericTypes/23.png)

- ```java 
    //Animal.java
    public class Animal {
        public String name;

        public Animal(String name) {
            this.name = name;
        }

        @Override
        public String toString() {
            return "Animal{" +
                    "name='" + name + '\'' +
                    '}';
        }
    }

  ```
- ```java
    //Cat.java
    public class Cat extends Animal {
        public int age;

        public Cat(String name, int age) {
            super(name);
            this.age = age;
        }

        @Override
        public String toString() {
            return "Cat{" +
                    "age=" + age +
                    ", name='" + name + '\'' +
                    '}';
        }
    }

  ```
- ```java
    //MiniCat.java
    public class MiniCat extends Cat {

        public int level;

        public MiniCat(String name, int age, int level) {
            super(name, age);
            this.level = level;
        }

        @Override
        public String toString() {
            return "MiniCat{" +
                    "level=" + level +
                    ", age=" + age +
                    ", name='" + name + '\'' +
                    '}';
        }
    }

  ```
- ```java
    //mian.java
    import java.util.Comparator;
    import java.util.TreeSet;

    public class main {
        public static void main(String[] args) {

            TreeSet<Cat> treeSet = new TreeSet<>(new Comparator2());
            treeSet.add(new Cat("Ami",13));
            treeSet.add(new Cat("Bie",25));
            treeSet.add(new Cat("Cna",34));
            treeSet.add(new Cat("Dji",52));
            treeSet.add(new Cat("Ewa",11));
            for (Cat cat : treeSet) {
                System.out.println(cat);
            }
        }
    }

    class Comparator1 implements Comparator<Animal>{

        @Override
        public int compare(Animal o1, Animal o2) {
            return o1.name.compareTo(o2.name);
        }
    }

    class Comparator2 implements Comparator<Cat>{
        @Override
        public int compare(Cat o1, Cat o2) {
            return o1.age - o2.age;
        }
    }

    class Comparator3 implements Comparator<MiniCat>{
        @Override
        public int compare(MiniCat o1, MiniCat o2) {
            return o1.level - o2.level;
        }
    }
  ```

![](/images/JavaGenericTypes/24.png)

- `TreeSet<Cat> treeSet = new TreeSet<>(new Comparator2());` 根据年龄比较排序
- `TreeSet<Cat> treeSet = new TreeSet<>(new Comparator1());` 根据名字比较排序

- `TreeSet<Cat> treeSet = new TreeSet<>(new Comparator3());` 在下限 Cat 以下, MiniCat 达不到下限

![](/images/JavaGenericTypes/25.png)


## 类型擦除

泛型是Java 1.5版本才引进的概念，在这之前是没有泛型的，但是泛型代码能够很好地和之前版本的代码兼容。

那是因为，泛型信息只存在于代码编译阶段，在进入JVM之前，与泛型相关的信息会被擦除掉，我们称之为–类型擦除。

- 在前面的例子中，判断过泛型是否相等
 - 由同一泛型类,创建的不同数据类型的对象,本质上是同一类型 
 - `stringGeneric.getClass() == integerGeneric.getClass()`结果为 true ,其实说明了这点
 - 在进入JVM之前，与泛型相关的信息会被擦除掉
 - ![](/images/JavaGenericTypes/26.png)
 - 在运行结果出来的时候,两者是相等的,说明了编译期间会把泛型的类型给移除掉

### 无限制类型擦除

泛型 T 在运行的时候,会被解释成 Object;就相当于用 Object 来代替

![](/images/JavaGenericTypes/27.png)

![](/images/JavaGenericTypes/28.png)

### 有限制类型擦除

将 泛型 T 转换成 上限类型 Number 
![](/images/JavaGenericTypes/29.png)

![](/images/JavaGenericTypes/30.png)

### 擦除 方法中类型定义的参数

前面的是擦除 泛型类 的类型;这里是擦除 泛型方法 的类型

![](/images/JavaGenericTypes/31.png)

![](/images/JavaGenericTypes/32.png)

### 桥接方法

接口定义 T 转成 Object ; 实现类 Integer 还是 Integer

只是多个了桥接; 为了保持编译后的接口和实现关系

![](/images/JavaGenericTypes/33.png)

![](/images/JavaGenericTypes/34.png)

## 泛型数组

### 可以创建带泛型的数组引用，但是不能 直接 创建带泛型的 数组对象

![](/images/JavaGenericTypes/35.png)

![](/images/JavaGenericTypes/36.png)

跳过原生 ArrayList 对象引用; 直接将 原生ArrayList 数组 赋给 泛型ArrayList; 后面就有类型检查

![](/images/JavaGenericTypes/37.png)

![](/images/JavaGenericTypes/38.png)

主要是因为泛型在编译的时候会做类型擦除，而数组会一直保持它的初始类型

### 可以通过 java.lang.reflect.Array 的 newInstance(Class,int) 创建 T[] 数组

![](/images/JavaGenericTypes/39.png)

## 反射常用的泛型类

- `Class<T>`
- `Constructor<T>`

![](/images/JavaGenericTypes/40.png)

![](/images/JavaGenericTypes/41.png)

class.var IDEA的快捷方式生成引用 和 Ctrl+Alt+V 一个效果

![](/images/JavaGenericTypes/42.png)

![](/images/JavaGenericTypes/43.png)

![](/images/JavaGenericTypes/44.png)

![](/images/JavaGenericTypes/45.png)

![](/images/JavaGenericTypes/46.png)

## 泛型的好处
- 类型安全
- 减少强制类型转换

## 类型参数标识符
- E - Element (在集合中使用，因为集合中存放的是元素)
- T - Type（表示Java 类，包括基本的类和我们自定义的类）
- K - Key（表示键，比如Map中的key）
- V - Value（表示值）
- N - Number（表示数值类型）
- ？ - （表示不确定的java类型）
- S、U、V - 2nd、3rd、4th types