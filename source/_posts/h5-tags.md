---
title: HTML5新增input类型
date: 2016-06-16 21:50:32
tags: [html5]
---
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
hidden定义隐藏域：`<input type="hidden"/>`

**在HTML5中，input元素新增了一些类型，有email邮件类型、number数字类型、range数字滑动条、url地址类型、date日期类型及search搜索类型。下面我们来逐个介绍一下它们。**

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
