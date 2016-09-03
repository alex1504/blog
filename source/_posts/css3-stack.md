---
title: CSS3实现的图片堆叠分散效果
date: 2016-03-11 21:54:11
tags: [css]
---
随着浏览器对CSS3的支持和完善，使用transform、animation、transition制作一些简单的页面动画能达到良好的交互效果。今天通过CSS3的新属性，制作了一个图片堆叠散开的效果。
#### 堆叠效果：
![示例图片](http://7xrw48.com1.z0.glb.clouddn.com/%40%2Fimages%2F2016%2F3%2F11%2F1.jpg)
#### 鼠标悬浮分散效果：
![示例图片](http://7xrw48.com1.z0.glb.clouddn.com/%40%2Fimages%2F2016%2F3%2F11%2F2.jpg)

> 效果演示：http://huzerui.com/photostack

#### 核心代码
HTML:
```html
	<div>
	<ul>
		<a class="li1" href="#"><li ></li></a>
		<a class="li2" href="#"><li ></li></a>
		<a class="li3" href="#"><li ></li></a>
	</ul>
	</div>
```

```css
*{                                            //初始化
	margin: 0;
	padding:0;                 
}
body{
	background: rgba(20,20,20,0.5);
}
div{
	margin: 100px auto;
	width: 300px;
	height: 430px;
	cursor:pointer;
	position: relative;
	transition: all .8s linear;



}
ul{ position: absolute;
	text-decoration: none;
	position: relative;
	list-style: none;
}
ul a{
	position: absolute;
	display: block;
	width: 300px;
	height: 400px;
}
ul li{	          
	position: absolute;
	width: 300px;
	height: 400px;

}
.li1{
	-webkit-transform-origin: left bottom;           //transform-origin设置变换的基点
	transform-origin: left bottom;  
	-webkit-transition: -webkit-transform .8s linear .3s;  
	transition: -webkit-transform .8s linear .3s;  
	transition: transform .8s linear .3s;  
	transition: transform .8s linear .3s, -webkit-transform .8s linear .3s; 
	-webkit-transition: transform .8s linear.3s;               
	background:url(1.jpg);
	-webkit-transform:rotate(6deg);
	transform:rotate(6deg);

}
.li2{
	-webkit-transform-origin: left bottom;
	transform-origin: left bottom;  
	-webkit-transition: -webkit-transform .8s linear .3s;  
	transition: -webkit-transform .8s linear .3s;  
	transition: transform .8s linear .3s;  
	transition: transform .8s linear .3s, -webkit-transform .8s linear .3s;  
	-webkit-transition: transform .8s linear.3s;
	background:url(2.jpg);
	-webkit-transform: rotate(3deg);
	transform: rotate(3deg);


}
.li3{
	-webkit-transform-origin: left bottom;
	transform-origin: left bottom;  
	-webkit-transition: -webkit-transform .8s linear .3s;  
	transition: -webkit-transform .8s linear .3s;  
	transition: transform .8s linear .3s;  
	transition: transform .8s linear .3s, -webkit-transform .8s linear .3s; 
	-webkit-transition: transform .8s linear.3s;
	background:url(3.jpg);
}
div:hover ul li{
	box-shadow: 0 4px 4px #000;
}
div:hover .li2{
	-webkit-transform: rotate(0deg);
	transform: rotate(0deg);
}
div:hover .li3{
	-webkit-transform: translateX(-200px);
	transform: translateX(-200px);
}
div:hover .li1{
	-webkit-transform: translateX(200px);
	transform: translateX(200px);
}
.li1:hover,.li2:hover,.li3:hover{
	border:2px solid white;
}

```

注意：ul下的三个li虽然有些共同的属性，但不能合并写在ul li之内，因为鼠标悬浮发生变换的是具体的li，因此需要在每个li都添加css3变换样式。
另外，对于CSS3最麻烦的就是写浏览器的前缀，以前我也为此烦恼，但现在都有一些比较方便的CSS3prefix在线添加前缀的网站，比如：<http://autoprefixer.github.io/>,大大减少了写前缀的重复代码时间。
