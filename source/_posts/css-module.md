---
title: css模块化
date: 2016-06-06 22:22:19
tags: [css]
---
# 模块化定义 #

 - 一系列相关联的结构组成的整体
 - 带有一定语义，而非表现

# 怎么做 #

 1. 为模块分类命名（如m-,md-）
 2. 以一个主选择器开头（模块根节点）
 3. 使用以主选择器开头的后代选择器（模块子节点）
 
## 实例 ##
 Html代码
 ```html
 <!--Nav Module-->
	<div class="m-nav">
		<ul>
			<li class="z-crt"><a href="#">index</a><li>
			<li><a href="#">link1</a></li>...
		</ul>
	</div>
<!--End Nav Module-->
 ```
 Css代码：
 ```css
.m-nav{}   /*模块容器*/
.m-nav li,.m-nav a{}
.m-nav li{}
.m-nav a{}
.m-nav .z-crt a{}
 ```


# 模块扩展 #
 
原模块：Html
 ```html
 <!--Nav Module-->
<div class="m-nav">
	<ul>
		<li class="z-crt"><a href="#">index</a><li>
		<li><a href="#">link1</a></li>...
	</ul>
</div>
<!--End Nav Module-->
```
基于原模块的扩展模块Html：新增一个class类，名为m-nav-n，n为正整数依次递增
```html
 <!--Nav-1 Module-->
<div class="m-nav m-nav-1">
	<ul>
		<li class="z-crt"><a href="#">index</a><li>
		<li><a href="#">link1</a></li>...
	</ul>
	<a class="btn">Login</a>
</div>
<!--End Nav-1 Module-->
 ```
 对模块和拓展模块设置css
 ```css
 /*导航模块*/
.m-nav{}   /*模块容器*/
.m-nav li,.m-nav a{}
.m-nav li{}
.m-nav a{}
.m-nav .z-crt a{}    /*交互状态变化*/
/*导航模块扩展*/
.m-nav-1{}
.m-nav-1 a{border-radius:5px;   //设置扩展模块导航按钮有5px圆角}
.m-nav-1 btn{}
```
# 为什么要模块化 #
 - 利于多人协同开发
 - 便于扩展和重用
 - 可读性、可维护性好

如：
```以下模块
<div class="m-slides">
	<ol>
		<li class="slide z-crt"><img src="" alt=""></li>
		<li class="slide"><img src="" alt=""></li>
		<li class="slide"><img src="" alt=""></li>
		<li class="slide"><img src="" alt=""></li>
		<span class="ctrl"><i class="z-crt"></i><i></i><i></i><i></i></span>
	</ol>
</div>
```
使用了外层div类名为m-slides时css结构清晰
```css
/*模块化样式*/
.m-slides{}
.m-slides slide{}
.m-slides slide img{}
.m-slides li.z-crt{}
.m-slides .ctrl{}
.m-slides .ctrl i{}
.m-slides .ctrl i.z-crt{}
```
去掉外层div时css
```css
/*未模块化样式*/
.slides{}
.slide{}
.slide img{}
li.z-crt{}
.ctrl{}
.ctrl i{}
i.z-crt{}
```