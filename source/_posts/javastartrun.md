---
title: Java:Thread.Start() / run()
date: 2020-11-30 23:19:22
tags: Java
---

## 线程的启动顺序 
- ![](/images/JavaStartRun/1.png)
- testThread 线程实例创建之后,调用 start(),表明这个线程处于就绪状态,等待得到 CPU 的时间片之后才会执行
- 因为 main 方法也是一个线程,所以 testThread 会等待 main() 执行完毕
- main() 执行完毕后，testThread 线程得到 CPU 的时间片,开始执行
<!-- more -->
- ![](/images/JavaStartRun/2.png)
- 当 testThread 启动时，它的状态 threadStatus 被设置为 0 ,然后加入线程组 group
- ![](/images/JavaStartRun/3.png)
- 最后调用 start0()，而 start0() 是私有的 native 方法（Native Method 是一个 java 调用非 java 代码的接口）
- 调用完毕后，testThread 线程就处于就绪状态,获得 CPU 时间之后就会调用 thread 的 run()
- ![](/images/JavaStartRun/5.png)
- ![](/images/JavaStartRun/4.png)
- ![](/images/JavaStartRun/6.png)

### run()
- ![](/images/JavaStartRun/7.png)
- thread.run() 会等待 thread 里面的 run() 执行完毕后才会执行;直接调用 run() 这样的用法就和调用普通方法一样,其实并没有创建新的线程
- ![](/images/JavaStartRun/8.png)
- thread.start() 就会创建新的线程,然后处于就绪状态;让主线程先执行完毕,再轮到自己

### run() 的好处
- 实现了 Runnable 接口的方法 run() ,之后就可以让多个线程调用 run() 共享同一个资源
- 实现 Runnable 接口相对于继承 Thread 类来说,可以避免 Java 单继承的局限性
- start()被多次调用也还是一个线程