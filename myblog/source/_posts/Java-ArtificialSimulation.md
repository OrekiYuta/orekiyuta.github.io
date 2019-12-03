---
title: Java-ArtificialSimulation
date: 2019-06-10 09:50:57
tags: [Java,Maven,Xpath,Selenium,ChromeDriver]
---

### 0x01 Create a project
Create New Project => Maven => Next => for (Fill in information => Next) => Finish
 ![](/images/Java-AS/0x011.png)
 ![](/images/Java-AS/0x012.png)
 ![](/images/Java-AS/0x013.png)
 ![](/images/Java-AS/0x014.png)


### 0x02 Environment and Tools
1. Java环境 JDK [下载](https://www.oracle.com/technetwork/java/javase/downloads/index.html)
2. IDEA  [下载](https://www.jetbrains.com/idea/)
3. 准备好ChromeDriver [下载](http://npm.taobao.org/mirrors/chromedriver/)
选择好对应版本(我这里选择的是74.0.3729.68 win)
4. Selenium 依赖
```
    <dependencies>
        <dependency>
            <groupId>org.seleniumhq.selenium</groupId>
            <artifactId>selenium-server</artifactId>
            <version>3.141.59</version>
        </dependency>
    </dependencies>
```
<!-- more -->
### 0x03 Get set
1. 在pom.xml中导入Selenium依赖 => 等待下载
2. 在src->main->java中创建Java类,创建main方法.----*在IDEA中输入psvm+回车_快速创建main方法*
3. 把准备好的ChromeDriver.exe放在src->main->resources目录中

### 0x04 Codeing
1. 设置webdriver路径
``` Java
System.setProperty("webdriver.chrome.driver",Scan.class.getClassLoader().getResource("chromedriver.exe").getPath());
```
2. 创建webdriver对象
```Java
 WebDriver webDriver =new ChromeDriver();
```
3. 打开页面(这里我以`www.lagou.com`为操作对象)
```Java
webDriver.get("https://www.lagou.com/zhaopin/Java/?labelWords=label");
```
4. 审查网页元素
在模拟人工操作前,需要先分析页面对象的元素组成,观察到我们需要模拟点击的导航条"工作经验"是在`<li class="muti-chosen">`内的`<span>`之间,这样就确定了第一层筛选,然后再从`<span>`中筛选出`<a>`,根据`Text()`确定了元素位置.
 ![](/images/Java-AS/0x044.png)

5. 选择根据页面结构获取对象(我这里选择了Xpath)
- 首先获取第一层筛选
```Java
webDriver.findElement(By.xpath("//li[@class='multi-chosen']//span[contains(text(),'工作经验')]"));
```
- 然后选择上面的代码提取成对象----*IDEA快捷键(ctrl+alt+V)*
```Java
WebElement chosenElement = webDriver.findElement(By.xpath("//li[@class='multi-chosen']//span[contains(text(),'工作经验')]"))
```
- 接着同样的操作,写出第二层筛选和点击事件
```Java
WebElement chosenElement = webDriver.findElement(By.xpath("//li[@class='multi-chosen']//span[contains(text(),'工作经验')]"));
WebElement optionElement = chosenElement.findElement(By.xpath("../a[contains(text(),'应届毕业生')]"));
optionElement.click();
```
- 再次观察页面,发现各个导航条只有文本描述差异,所以接下来把上面两个文本对象抽成变量(选中"工作经验"和"应届毕业生")
```Java
String chosenTitle = "工作经验";
String optionTitle = "应届毕业生"; //移动代码位置(先选择该行ctrl+shift+↑or↓)

WebElement chosenElement = webDriver.findElement(By.xpath("//li[@class='multi-chosen']//span[contains(text(),'" + chosenTitle + "')]"));
WebElement optionElement = chosenElement.findElement(By.xpath("../a[contains(text(),'" + optionTitle + "')]"));
optionElement.click();
```
- 然后思考,把上面三行抽成方法,之后只需传递两个参数就可以控制了(选中上面三行代码抽成方法----*IDEA快捷键(ctrl+alt+M)*,该操作前需要做第二步的提取变量
```Java
String chosenTitle = "工作经验";
String optionTitle = "应届毕业生";
clickOption(webDriver, chosenTitle, optionTitle);

private static void clickOption(WebDriver webDriver, String chosenTitle, String optionTitle) {
WebElement chosenElement = webDriver.findElement(By.xpath("//li[@class='multi-chosen']//span[contains(text(),'" + chosenTitle + "')]"));
WebElement optionElement = chosenElement.findElement(By.xpath("../a[contains(text(),'" + optionTitle + "')]"));
optionElement.click();
}
```
- 写到这里观察上面变量和方法形参,合并一下优化代码.把文本传回方法参数里.----*IDEA快捷键(ctrl+alt+N)* (选中方法里的参数)
```Java
clickOption(webDriver, "工作经验", "应届毕业生");//接着分析页面,执行五个操作
clickOption(webDriver, "学历要求", "本科");
clickOption(webDriver, "融资阶段", "不限");
clickOption(webDriver, "公司规模", "不限");
clickOption(webDriver, "行业领域", "移动互联网");
```
6. 解析单页元素
![](/images/Java-AS/0x046.png)
- 观察页面元素发现主要信息都是在`<li class="con_list_item default_list">`中
```Java
webDriver.findElements(By.className("con_list_item"));
```
- 这里findElements是因为有多个元素,上面的findElement是只有一个元素,接着依然是抽取变量----*IDEA快捷键(ctrl+alt+V)*
```Java
List<WebElement> jobElements = webDriver.findElements(By.className("con_list_item"));
```
- 页面有多组信息就要用循环了咯,循环遍历对象JobElements;----*在IDEA中输入`jobElemnets.for`+回车_就会补全语法*
```Java
for (WebElement jobElement : jobElements) {
    WebElement moneyElement = jobElement.findElement(By.className("position")).findElement(By.className("money"));
    System.out.println(moneyElement.getText());
    String companyName = jobElement.findElement(By.className("company_name")).getText();//在IDEA中输入sout+回车_快速创建打印方法
    System.out.println(companyName);
}
```
- 优化一下代码_把上面代码抽成方法
```Java
extractJobsByPagination(webDriver);

private static void extractJobsByPagination(WebDriver webDriver) {
List<WebElement> jobElements = webDriver.findElements(By.className("con_list_item"));
for (WebElement jobElement : jobElements) {
    WebElement moneyElement = jobElement.findElement(By.className("position")).findElement(By.className("money"));
    String companyName = jobElement.findElement(By.className("company_name")).getText();
    System.out.println(companyName + " : " + moneyElement.getText());
}
```
- 写到这里可以尝试运行一下了,观察下输出结果.

7. 解析分页元素 
![](/images/Java-AS/0x071.png)
![](/images/Java-AS/0x072.png)
- 观察下一页按钮可点击和不可点击时的变化
![](/images/Java-AS/0x073.png)
- 测试下按钮事件
- 进行逻辑判断,然后触发点击事件.最后在if里进行递归调用

```Java
WebElement nextPageBtn = webDriver.findElement(By.className("pager_next"));
if(!nextPageBtn.getAttribute("class").contains("pager_next_disabled")){
nextPageBtn.click();
System.out.println("--------下一页---------");
//然后这里让线程睡眠一秒钟,以免跳转响应时间不够,再来个异常处理
    try {
            hread.sleep(1000L);
    } catch (InterruptedException e) {
            e.printStackTrace();
    }
        extractJobsByPagination(webDriver);
    }
```
### 0x05 Running
![](/images/Java-AS/0x081.png)
