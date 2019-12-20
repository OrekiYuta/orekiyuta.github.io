---
title: Thinking Shift
date: 2019-12-16 01:17:36
tags: get
---

### <center>一次编程思想的转变</center>

⭐**不能局限于细节 , 还要纵观整体**⭐

- 昨天发现一个很不错的 js 库 👉[tagcanvas](http://www.goat1000.com/tagcanvas.php)

- 所以今天就打算整合到 hexo 博客中,首先是看了 Next 主题的代码格式 , 按照规范写好了对应的文件 , 并且 tagcanvas 也成功显示在页面了

- 但是数据还是固定的 , 需要把 hexo 的 tag 数据引过来输入到 tagcanvas 中

- 通过反复阅读源码 , 先是确定了原始 tagcloud 的位置在 `/next/layout/page.swig` 

    ```html
    <div class="tag-cloud-tags">
        {{ tagcloud({min_font: 15, max_font: 30, amount: 999, color: true, start_color: '#827878', end_color: '#000000'}) }}
    </div>

    ```

- 调试后确定了 tagcloud 是个方法 , 然后查找资料定位到了 `/node_modules/hexo/lib/plugins/helper/tagcloud.js`

- 大概阅读 tagcloud.js 一遍后 , 可见 tagcloud 通过一定的算法处理后会输出 tag标签 `<li/>`

    ```js
    tags.forEach(tag => {
        const ratio = length ? sizes.indexOf(tag.length) / length : 0;
        const size = min + ((max - min) * ratio);
        let style = `font-size: ${parseFloat(size.toFixed(2))}${unit};`;

        if (color) {
        const midColor = startColor.mix(endColor, ratio);
        style += ` color: ${midColor.toString()}`;
        }

        result.push(
        `<a href="${self.url_for(tag.path)}" style="${style}">${transform ? transform(tag.name) : tag.name}</a>`
        );
    });
    ```
<!-- more -->
- 到此我的想法是 **首先 tagcanvas 需要接受 url 参数 和 text 参数 , 应该修改一下 tagcloud.js 源码 , 让它输出想要的参数**

- 想了之后 , 如果这样做 , 之后会不会对其他地方产生影响 , 再加上修改此处的成本也不低 , 之后尝试问题的话维护成本也不低

- 然后想到了一种办法 **不修改 tagcloud.js 源码 , 转为操作 DOM 在页面直接获取已经生成好的数据 , 然后传给 tagcanvas**

- 一波操作后 , 又遇到了一些问题 , 又想了想 , 这样操作 DOM 的话 ; 要是 hexo 的生命周期和我写在文件里的 DOM 操作的生命周期不一致的话也会出现问题 ; 

- 想了想 , hexo 是把代码打包编译成静态文件的 , 那么我写在文件里的 DOM 操作在编译的时候并没有对应的节点 , 对应的节点应该是编译完成后才产生的 , 这样一来这个办法就行不通了

- 最后想了想 , **其实前面早就有结果了 , 只是思维没有转过来**

---

- 前面的 **tagcloud 通过一定的算法处理后会输出 tag标签 `<li/>`** , 其实这里就可以直接利用 `<li/>` , **把输出的一群 `<li/>` 当作个对象去思考** 

- tagcloud 输出的 `<li/>` 是符合了 tagcanvas 输入规范的 ; tagcloud 输出的 `<li/>` 已经具备了 url 参数和 text 参数 , 这样的话 tagcanvas 也能正确处理

- 最后把 `/next/layout/page.swig` 中输出标签的代码迁移到 tagcanvas 页面对应的地方即可

    ```js
    {{ tagcloud({min_font: 15, max_font: 30, amount: 999, color: true, start_color: '#827878', end_color: '#000000'}) }}
    ```



还有个类似的库也值得去尝试一下 👉[jasondavies](https://www.jasondavies.com)