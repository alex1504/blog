---
title: Sass使用指南
date: 2016-03-05 22:46:44
categories: 前端
tags: [css,sass]
---
随着对CSS的用法了解比较熟悉，觉得有必要学习一下CSS预编译的语言。有一种是Less，另一种是Sass。科普了一下，两种语言的主要不同是他们的实现方式，Less是基于javascript在客户端处理的，而Sass是基于Ruby在服务端处理的。但它们之间也有共同点
* 混入(Mixins)——class中的class；

* 参数混入——可以传递参数的class，就像函数一样；

* 嵌套规则——Class中嵌套class，从而减少重复的代码；

* 运算——CSS中用上数学；

* 颜色功能——可以编辑颜色；

* 名字空间(namespace)——分组样式，从而可以被调用；

* 作用域——局部修改样式；

* JavaScript 赋值——在CSS中使用JavaScript表达式赋值。

***这篇博客主要记录一下Sass的用法***

Sass用法指南

# 什么是Sass
SASS是一种CSS的开发工具，提供了许多便利的写法，大大节省了设计者的时间，使得CSS的开发，变得简单和可维护。
本文总结了SASS的主要用法。我的目标是，有了这篇文章，日常的一般使用就不需要去看官方文档了。

# 安装和使用
## 安装
SASS是Ruby语言写的，但是两者的语法没有关系。不懂Ruby，照样使用。只是必须先安装Ruby，然后再安装SASS。
假定你已经安装好了Ruby，接着在命令行输入下面的命令：

```ruby
gem install sass
```
然后，就可以使用了。
## 使用
SASS文件就是普通的文本文件，里面可以直接使用CSS语法。文件后缀名是.scss，意思为Sassy CSS。
下面的命令，可以在屏幕上显示.scss文件转化的css代码。（假设文件名为test。）
```sass
sass test.scss
```
如果要将显示结果保存成文件，后面再跟一个.css文件名。
```sass
sass test.scss test.css
```
SASS提供四个编译风格的选项：
```sass
* nested：嵌套缩进的css代码，它是默认值。
* expanded：没有缩进的、扩展的css代码。
* compact：简洁格式的css代码。
* compressed：压缩后的css代码。
```
生产环境当中，一般使用最后一个选项。
```sass
sass --style compressed test.sass test.css
```
你也可以让SASS监听某个文件或目录，一旦源文件有变动，就自动生成编译后的版本。
```sass
// watch a file
sass --watch input.scss:output.css
// watch a directory
sass --watch app/sass:public/stylesheets
```
SASS的官方网站，提供了一个在线转换器。你可以在那里，试运行下面的各种例子。
# 基本用法
## 变量
SASS允许使用变量，所有变量以$开头。
```sass
$blue : #1875e7;　
div {
  color : $blue;
}
```
如果变量需要镶嵌在字符串之中，就必须需要写在#{}之中。
```sass
$side : left;
.rounded {
  border-#{$side}-radius: 5px;
}
```
## 计算功能
SASS允许在代码中使用算式：
```sass
body {
  margin: (14px/2);
  top: 50px + 100px;
  right: $var * 10%;
}
```
## 嵌套
SASS允许选择器嵌套。比如，下面的CSS代码：
```sass
div h1 {
  color : red;
}
```
可以写成：
```sass
div {
  hi {
　　   color:red;
　　 }
}
```
属性也可以嵌套，比如border-color属性，可以写成：
```sass
p {
  border: {
　  color: red;
  }
}
```
注意，border后面必须加上冒号。
在嵌套的代码块内，可以使用&引用父元素。比如a:hover伪类，可以写成：
```sass
a {
  &:hover { color: #ffb3ff; }
}
```
## 注释
SASS共有两种注释风格。
标准的CSS注释 /* comment */ ，会保留到编译后的文件。
单行注释 // comment，只保留在SASS源文件中，编译后被省略。
在/*后面加一个感叹号，表示这是"重要注释"。即使是压缩模式编译，也会保留这行注释，通常可以用于声明版权信息。
```sass
/*! 
  重要注释！
*/
```
# 代码的重用
## 继承
SASS允许一个选择器，继承另一个选择器。比如，现有class1：
```sass
.class1 {
  border: 1px solid #ddd;
}
```
class2要继承class1，就要使用@extend命令：
```sass
class2 {
  @extend .class1;
  font-size:120%;
}
```
## Mixin
Mixin有点像C语言的宏（macro），是可以重用的代码块。
使用@mixin命令，定义一个代码块。
```sass
@mixin left {
  float: left;
  margin-left: 10px;
}
```
使用@include命令，调用这个mixin。
```sass
div {
  @include left;
}
```
mixin的强大之处，在于可以指定参数和缺省值。
```sass
@mixin left($value: 10px) {
  float: left;
  margin-right: $value;
}
```
使用的时候，根据需要加入参数：
```sass
div {
  @include left(20px);
}
```
下面是一个mixin的实例，用来生成浏览器前缀。
```sass
@mixin rounded($vert, $horz, $radius: 10px) {
  border-#{$vert}-#{$horz}-radius: $radius;
  -moz-border-radius-#{$vert}#{$horz}: $radius;
  -webkit-border-#{$vert}-#{$horz}-radius: $radius;
}
```
使用的时候，可以像下面这样调用：
```sass
#navbar li { @include rounded(top, left); }
#footer { @include rounded(top, left, 5px); }
```
## 颜色函数
SASS提供了一些内置的颜色函数，以便生成系列颜色。
```sass
lighten(#cc3, 10%) // #d6d65c
darken(#cc3, 10%) // #a3a329
grayscale(#cc3) // #808080
complement(#cc3) // #33c
```
## 插入文件
@import命令，用来插入外部文件。
```sass
@import "path/filename.scss";
```
如果插入的是.css文件，则等同于css的import命令。
```sass
@import "foo.css";
```
# 高级用法
## 条件语句
@if可以用来判断：
```sass
p {
  @if 1 + 1 == 2 { border: 1px solid; }
  @if 5 < 3 { border: 2px dotted; }
}
```
配套的还有@else命令：
```sass
=@if lightness($color) > 30% {
  background-color: #000;
=} @else {
  background-color: #fff;
}
```
## 循环语句
SASS支持for循环：
```sass
@for $i from 1 to 10 {
  .border-#{$i} {
　  border: #{$i}px solid blue;
  }
}
```
也支持while循环：
```sass
$i: 6;
@while $i > 0 {
  .item-#{$i} { width: 2em * $i; }
  $i: $i - 2;
}
```
each命令，作用与for类似：
```sass
@each $member in a, b, c, d {
  .#{$member} {
　  background-image: url("/image/#{$member}.jpg");
  }
}
```
## 自定义函数
SASS允许用户编写自己的函数。
```sass
@function double($n) {
  @return $n * 2;
}
#sidebar {
  width: double(5px);
}
```