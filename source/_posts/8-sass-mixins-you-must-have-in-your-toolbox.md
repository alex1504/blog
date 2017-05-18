---
title: 8个sass mixins快到我的碗里来
date: 2017-05-11 20:43:02
tags: [sass, mixin]
categories: 前端
---
最近看到知乎的一个问题：[英语是否会成为前端工程师的发展瓶颈？](https://www.zhihu.com/question/55998388/answer/167923782?group_id=846021391139627008)，短短几星期浏览量就突破30万，可见前端工程师都是普遍处于有种在瓶颈处的恐慌。个人感觉英语还不赖便试着从正面的角度回答了一翻，后来由于回答人数众多引起尤大大注意，他怼了一句“不仅英语差会成为瓶颈，英语好还能成为优势，因为学习效率会比别人高。像我这样半路出家自学的人，只能靠英语了...”

由此可见英语的重要性，所以有时候多多看看外文博客，逛逛国外程序员社区还是有好处滴。所以从今天起给自己立下的目标是，若见到比较有价值的外文博客文章，便翻译到本博客，原文链接附在文章末尾方便大家参考（摘要去除不必要的翻译）。

Sass mixins是一种可随处重用的预定义代码块，如果你熟悉任何编程语言你可以将它们视为函数使用。mixin可以接收多个参数并被调用，最后输出css代码，它们可以使你的css代码变得十分整洁。以下部分的代码块在compass库中已经有了，但我不想在我的项目中使用compass这样的庞然大物，我决定自己重写它们。

## 1、以rem为单位设置字体大小并且用px作为后备样式
rem单位与em单位非常类似，区别在于em相对于父元素，而rem相对于根元素。
rem单位拥有所有em单位的优势，但缺点是在IE8及以下版本并不支持，但通过mixin我们可以将px作为rem的后备样式进行兼容。
```javascript
@function calculateRem($size) {
  $remSize: $size / 16px;
  @return $remSize * 1rem;
}

@mixin font-size($size) {
  font-size: $size;
  font-size: calculateRem($size);
}
```
使用方法：
```javascript
p {
  @include font-size(14px)
}
```

输出：
```javascript
p {
  font-size: 14px; //如果浏览器支持rem将会被覆盖
  font-size: 0.8rem;
}
```

## 2、生成媒体查询的断点
Sass3.2版本之后允许通过命名媒体查询使代码更加整洁，我们可以不在使用@media (min-width: 600px)，而是给他们一些语义化的名字如"breakpoint-large" 或者 "breakpoint-a-really-large-computer-machine"。
```javascript
@mixin bp-large {
  @media only screen and (max-width: 60em) {
    @content;
  }
}

@mixin bp-medium {
  @media only screen and (max-width: 40em) {
    @content;
  }
}

@mixin bp-small {
  @media only screen and (max-width: 30em) {
    @content;
  }
}
```
使用：
```javascript
.sidebar {
  width: 60%;
  float: left;
  margin: 0 2% 0 0;
  @include bp-small {
    width: 100%;
    float: none;
    margin: 0;
  }
}
```

输出:
```javascript
.sidebar {
  width: 60%;
  float: left;
  margin: 0 2% 0 0;
  @media only screen and (max-width: 30){
    .sidebar{width: 100%; float: none; margin: 0;}
  }
}
```

## 3、设置SVG格式的背景图片并以PNG和retina作为备选
这个mixin需要依赖于[Modernizr](https://modernizr.com/)库，你需要一个svg图作为默认的背景图片，需要一个png图片给不支持svg的浏览器使用，还需要一个@2x的png图片给retina屏幕使用。
所以你需要三张图片资源:
· pattern.svg
··pattern.png
· pattern@2x.png

```javascript
$image-path: '../img' !default;
$fallback-extension: 'png' !default;
$retina-suffix: '@2x';
@mixin background-image($name, $size:false){
    background-image: url(#{$image-path}/#{$name}.svg);
    @if($size){
        background-size: $size;
    }
    .no-svg &{
        background-image: url(#{$image-path}/#{$name}.#{$fallback-extension});

        @media only screen and (-moz-min-device-pixel-ratio: 1.5), only screen and (-o-min-device-pixel-ratio: 3/2), only screen and (-webkit-min-device-pixel-ratio: 1.5), only screen and (min-device-pixel-ratio: 1.5) {
          background-image: url(#{$image-path}/#{$name}#{$retina-suffix}.#{$fallback-extension});
        }
    }
}
```
使用:
```javascript
body {
  @include background-image('pattern');
}
```
注：Modernizr在初始化的时候会寻找"no-js"的节点，如果浏览器支持js，那么该节点的class就变成"js"并且附带了其他它检测后所支持的属性判断。如果类名前带"no-"表示不支持该css属性。

## 4、简化css3动画的书写前缀
```javascript
@mixin keyframes($animation-name) {
    @-webkit-keyframes #{$animation-name} {
        @content;
    }
    @-moz-keyframes #{$animation-name} {
        @content;
    }  
    @-ms-keyframes #{$animation-name} {
        @content;
    }
    @-o-keyframes #{$animation-name} {
        @content;
    }  
    @keyframes #{$animation-name} {
        @content;
    }
}

@mixin animation($str) {
  -webkit-animation: #{$str};
  -moz-animation: #{$str};
  -ms-animation: #{$str};
  -o-animation: #{$str};
  animation: #{$str};      
}
```
使用：
```javascript
@include keyframes(slide-down) {
  0% { opacity: 1; }
  90% { opacity: 0; }
}

.element {
  width: 100px;
  height: 100px;
  background: black;
  @include animation('slide-down 5s 3');
}
```
## 5、简化transition
```javascript
@mixin transition($args...) {
  -webkit-transition: $args;
  -moz-transition: $args;
  -ms-transition: $args;
  -o-transition: $args;
  transition: $args;
}
```
使用：
```javascript
a {
  color: gray;
  @include transition(color .3s ease);
  &:hover {
    color: black;
  }
}

```

## 6、透明度的跨浏览器支持
使得低版本ie5及以上兼容opacity的mixin
```javascript
@mixin opacity($opacity) {
  opacity: $opacity;
  $opacity-ie: $opacity * 100;
  filter: alpha(opacity=$opacity-ie); //IE8
}
```
使用：
```javascript
.faded-text {
  @include opacity(0.8);
}
```

## 7、清除浮动
在web中清除浮动常会有很多异常，这是[Nicolas Gallagher](http://nicolasgallagher.com/micro-clearfix-hack/)创造的比较稳定的写法，支持IE6及以上。
```javascript
%clearfix {
  *zoom: 1;
  &:before, &:after {
    content: " ";
    display: table;
  }
  &:after {
    clear: both;
  }
}
```
使用:
```javascript
.container-with-floated-children {
  @extend %clearfix;
}
```

## 8、直观地隐藏元素
当你将一个元素设置为display: none的时候，将会阻止它们呈现给屏幕阅读器用户。因此我们需要在隐藏元素的同时让元素对于屏幕阅读器是可获知的。
由于输出结果总是一致的，下面这个例子使用sass占位符选择器，这样减少了很多重复的代码。
```javascript
%visuallyhidden {
  margin: -1px;
  padding: 0;
  width: 1px;
  height: 1px;
  overflow: hidden;
  clip: rect(0 0 0 0);
  clip: rect(0, 0, 0, 0);
  position: absolute;
}
```
使用:
```javascript
.visually-hidden {
  @extend %visuallyhidden;
}
```
> 原文链接：[8 Sass mixins you must have in your toolbox](http://zerosixthree.se/8-sass-mixins-you-must-have-in-your-toolbox/)
> 扩展阅读：[Cool Functions to Improve Your Sass](https://webdesign.tutsplus.com/tutorials/bourbon-on-the-rocks-cool-functions-to-improve-your-sass--cms-24798)
