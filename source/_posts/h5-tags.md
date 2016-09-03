---
title: HTML5新增标签
date: 2016-06-16 21:50:32
tags: [html5,标签]
---
HTML5 提供了一些新的元素和属性，反映典型的现代用法网站。其中有些是技术上类似 `<div>` 和 `<span>` 标签，但有一定含义，例如 `<nav>`（网站导航块）和 `<footer>`。这种标签将有利于搜索引擎的索引整理、小屏幕装置和视障人士使用。同时为其他浏览要素提供了新的功能，通过一个标准接口，如 `<audio>` 和 `<video>` 标记.

# HTML5提供的一些新的标签用法以及和HTML 4的区别 #
## < article > ##
`<article>`标签定义外部的内容。比如来自一个外部的新闻提供者的一篇新的文章，或者来自 blog 的文本，或者是来自论坛的文本。亦或是来自其他外部源内容。
HTML5:`<article></article>`
HTML4:`<div></div>`
## < aside > ##
`<aside>`标签定义 article 以外的内容。aside 的内容应该与 article 的内容相关。
HTML5:`<aside>`Aside 的内容是独立的内容，但应与文档内容相关。`</aside>`
HTML4:`<div>`Aside 的内容是独立的内容，但应与文档内容相关。`</div>`
## < audio > ##
`<audio>` 标签定义声音，比如音乐或其他音频流。
HTML5:`<audio src="someaudio.wav">`您的浏览器不支持 audio 标签。`</audio>`
HTML4:`<object type="application/ogg" data="someaudio.wav"><param name="src" value="someaudio.wav"></object>`
## < canvas > ##
`<canvas>` 标签定义图形，比如图表和其他图像。这个 HTML 元素是为了客户端矢量图形而设计的。它自己没有行为，但却把一个绘图 API 展现给客户端 JavaScript 以使脚本能够把想绘制的东西都绘制到一块画布上。
HTML5:`<canvas id="myCanvas" width="200" height="200"></canvas>`
HTML4:`<object data="inc/hdr.svg" type="image/svg+xml" width="200" height="200"></object>`
## < command > ##
`<command>` 标签定义命令按钮，比如单选按钮、复选框或按钮。
HTML5: `<command onclick=cut()" label="cut">`
HTML4: none
## < datalist > ##
`<datalist>` 标签定义可选数据的列表。与 input 元素配合使用，就可以制作出输入值的下拉列表。
HTML5: `<datalist></datalist>`
HTML4: see combobox.
## < details > ##
`<details>` 标签定义元素的细节，用户可进行查看，或通过点击进行隐藏。与 `<legend>` 一起使用，来制作 detail 的标题。该标题对用户是可见的，当在其上点击时可打开或关闭 detail。
HTML5: `<details></details>`
HTML4: `<dl style="display:hidden"></dl>`
## < embed > ##
`<embed>` 标签定义嵌入的内容，比如插件。
HTML5: `<embed src="horse.wav" />`
HTML4: `<object data="flash.swf"  type="application/x-shockwave-flash"></object>`
## < figcaption > ##
`<figcaption>` 标签定义 figure 元素的标题。”figcaption” 元素应该被置于 “figure” 元素的第一个或最后一个子元素的位置。
HTML5: `<figure><figcaption>PRC</figcaption></figure>`
HTML4: none
## < figure > ##
`<figure>` 标签用于对元素进行组合。使用 `<figcaption>` 元素为元素组添加标题。
HTML5: `<figure><figcaption>`PRC`</figcaption><p>`The People's Republic of China was born in 1949...`</p></figure>`
HTML4: `<dl><h1>`PRC`</h1><p>`The People's Republic of China was born in 1949...`</p></dl>`
## < footer > ##
`<footer>` 标签定义 section 或 document 的页脚。典型地，它会包含创作者的姓名、文档的创作日期以及/或者联系信息。
HTML5: <`footer></footer>`
HTML4: `<div></div>`
## < header > ##
`<header>` 标签定义 section 或 document 的页眉。
HTML5: `<header></header>`
HTML4: `<div></div>`
## < hgroup > ##
`<hgroup>` 标签用于对网页或区段（section）的标题进行组合。
HTML5: `<hgroup></hgroup>`
HTML4: `<div></div>`
## < keygen > ##
`<keygen>` 标签定义生成密钥。
HTML5: `<keygen>`
HTML4: none
## < mark > ##
`<mark>`主要用来在视觉上向用户呈现那些需要突出的文字。`<mark>`标签的一个比较典型的应用就是在搜索结果中向用户高亮显示搜索关键词。
HTML5: `<mark></mark>`
HTML4: `<span></span>`
## < meter > ##
`<meter>` 标签定义度量衡。仅用于已知最大和最小值的度量。必须定义度量的范围，既可以在元素的文本中，也可以在 min/max 属性中定义。
HTML5: `<meter></meter>`
HTML4: none
## < nav > ##
`<nav>` 标签定义导航链接的部分。
HTML5: `<nav></nav>`
HTML4:`<ul></ul>`
## < output > ##
`<output>` 标签定义不同类型的输出，比如脚本的输出。
HTML5: `<output></output>`
HTML4: `<span></span>`
## < progress > ##
`<progress>` 标签运行中的进程。可以使用 `<progress>` 标签来显示 JavaScript 中耗费时间的函数的进程。
HTML5: `<progress></progress>`
HTML4: none
## < section > ##
`<section>` 标签定义文档中的节（section区段）。比如章节、页眉、页脚或文档中的其他部分。
HTML5: `<section></section>`
HTML4: `<div></div>`
## < source > ##
`<source>` 标签为媒介元素（比如 `<video> 和 <audio>`）定义媒介资源。
HTML5: `<source>`
HTML4: `<param>`
## < summary > ##
`<summary>` 标签包含 details 元素的标题，"details"元素用于描述有关文档或文档片段的详细信息。"summary" 元素应该是 "details"元素的第一个子元素。
HTML5: `<details><summary>`HTML 5`</summary>`This document teaches you everything you have to learn about HTML5。`</details>`
HTML4: none
## < time > ##
`<time>` 标签定义日期或时间，或者两者。
HTML5: `<time></time>`
HTML4: `<span></span>`
## < video > ##
`<video>` 标签定义视频，比如电影片段或其他视频流。
HTML5: `<video src="movie.ogg" controls="controls">`您的浏览器不支持 video 标签。`</video>`
HTML4: `<object type="video/ogg" data="movie.ogv"><param name="src" value="movie.ogv"></object>`

# HTML5表单新增input类型 #
在HTML4等早期版本中，input元素已经有了一些type类型，type可取的值有下面这些：
text文本类型：`<input type="text"/>`
password密码类型：`<input type="password"/>`
radio 单选类型：`<input type="radio"/>`选项
checkbox 多选类型：`<input type="checkbox"/>`选项
file 文件类型：`<input type="file"/>`
submit 提交按钮：`<input type="submit"value="提交"/>`
reset重置按钮：`<input type="reset"value=重置"/>`
button定义按钮：`<input type="button"value="按钮1"/>`
image 定义图片按钮：`<input type="image"src=".."/>`
hidden定义隐藏域：`<inputtype="hidden"/>`
在HTML5中，input元素新增了一些类型，有email邮件类型、number数字类型、range数字滑动条、url地址类型、date日期类型及search搜索类型。下面我们来逐个介绍一下它们。

## email邮件类型 ##
跟文本框类似，但它只接受符合email邮件格式的字符串，当表单提交时会自动检测，若不合法，则会给出提示。
html代码如下：

    <input type="email" name="" value="">

## number数字类型 ##
跟文本框类似，它只接受数字类型的值，表单提交时会自动检测，若不合法，则会给出提示。
html代码如下：

    <input type="number" name="" value="">

## range数字滑动条 ##
它展现出来是一个可以拖拉的滑动条，包含一定的数字范围，如：

    <input type="range" min="1" max="10">

当拖动滑动块时，它的value值会在1到10之间变化。
## url地址类型 ##
跟文本框类似，它只接受网址类型的值，表单提交时会自动检测，若不合法，则会给出提示。
html代码如下：

    <input type="url">

## date日期类型 ##
当此类表单成为焦点时，会自动弹出日历或者是调节按钮，但其样式会由于浏览器内核的不同而不同，此类型有一系列的只可选：
date：选取日、月、年
month：选取月、年
week：选取周、年
time：选取时间（小时和分钟）
datetime：选取时间、日、月、年，为UTC时间
datetime-local：选取时间、日、月、年，为本地时间
html代码如下：

    <input type="date">

其它的只需更改type值就可以了，就不一一列举了。
## search搜索类型 ##
跟文本框类似，它可以接受任意的值作为关键字，我们可以通过value获取这些关键字。
html代码如下：

    <input type="search">
