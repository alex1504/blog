---
title: 移动端自适应布局解决方案——rem
date: 2016-06-16 13:42:29
tags: [webapp,css,rem]
---
自适应布局方案有**百分比布局、flex布局、弹性flex布局**等，但是都有一些缺点。
- 百分比布局缺点：字体大小需要另外一套自适应方法来调整；当屏幕宽度大于700px后，继续按照百分比元素会偏大，这个时候调整起来会比较麻烦。

- flex布局、弹性flex布局：在移动端会出现一些支持的兼容问题。

# rem #
W3C官网描述是“font size of the root element”，即rem是相对于根元素。
我们只需要在HTML根元素确定一个参考值，css中其他使用rem作为单位的值都基于这个值进行计算。
# rem实现宽度自适应的原理 #
通过JS使页面<html>的fontsize会根据屏幕的宽度自动调整。
具体是根据屏幕宽度和所设字体大小的比值是固定的，获取屏幕宽度后，按照固定比例缩小后作为rem的单位长度实现自适应。

另外值得说的是即使采用了rem布局方案，**页面上不一定所有的元素都是采用rem作为单位。**，比如下面淘宝的案例。底部固定的导航条采用的是高度使用固定的像素值，宽度flex布局的方案。
![淘宝案例](http://qiniu.huzerui.com/image/2016-06-16-rem-adaptive-layout-1.jpg)
```css
footer{
	height:114px;
	
	/*这三个样式需要补充prefix*/
    /*通过一起使用box-align和box-pack属性,对div框的子元素进行居中*/
	display:flex;
	box-pack: justify;
	box-align: center;
    
	justify-content: space-between; //在flex容器内的各项没有占用主轴所有可用的空间时,元素的各项周围留有空白
	align-content: center;  //在flex容器内的各项没有占用纵轴上所有可用的空间时，元素居中对齐

}
```
# 代码详解 #
```javascript
(function (doc, win) {
    var docEl = doc.documentElement,
        resizeEvt = 'orientationchange' in window ? 'orientationchange' : 'resize',
        recalc = function () {
            var clientWidth = docEl.clientWidth;
            if (!clientWidth) return;
            if(clientWidth>=640){
                docEl.style.fontSize = '100px';
            }else{
                docEl.style.fontSize = 100 * (clientWidth / 640) + 'px';
            }
        };

    if (!doc.addEventListener) return;
    win.addEventListener(resizeEvt, recalc, false);
    doc.addEventListener('DOMContentLoaded', recalc, false);
})(document, window);
```
代码解释：
如果页面的宽度超过了640px，那么页面中html的font-size恒为100px，否则，页面中html的font-size的大小为： 100 * (当前页面宽度 / 640) 

## 为什么是640px？ ##
三个概念：屏幕分辨率、设备像素、css像素
屏幕分辨率和设备像素是物理概念，而CSS像素是WEB编程的概念；屏幕分辨率和设备像素的差别在于设备像素显示密度。
当设备屏幕分辨率=100%的时候，浏览器CSS像素尺寸和设备像素相等，而当像素密度(pixel density)为1的时候，屏幕分辨率和设备像素相等。

对于手机屏幕来说，640px的页面宽度是一个安全的最大宽度，保证了移动端页面两边不会留白。注意这里的px是css逻辑像素，与设备的物理像素是有区别的。如iPhone 5使用的是Retina视网膜屏幕，使用2px x 2px的 device pixel 代表 1px x 1px 的 css pixel，所以设备像素数为640 x 1136px，而它的CSS逻辑像素数为320 x 568px。

## 为什么要设置html的font-size？ ##
rem就是根元素（即：html）的字体大小。html中的所有标签样式凡是涉及到尺寸的（如： height,width,padding,margin,font-size。甚至，left,top等）你都可以放心大胆的用rem作单位。
如果你把html的font-size设为20px，前面说过，rem就是html的字体大小，那么1rem = 20px。

浏览器一般都有最小字体限制，比如谷歌浏览器，最小中文字体就是12px，所以实际上没有办法让1rem=1px

根据上面的js代码，如果页面宽度低于640px,那么页面中html的font-size也会按照（当前页面宽度/640）的比例变化。这样，页面中凡是应用了rem的作尺寸单位的元素都会随着页面变化而等比例缩放了。

## 怎么计算出不同分辨率下font-size的值？##
假设页面设计稿是按照640的标准尺寸设计的，（当然这个尺寸肯定不一定是640，可以是320，或者480，又或是375）来看一组表格。
![rem](http://qiniu.huzerui.com/image/2016-06-16-rem-adaptive-layout-2.jpg)

以640的宽度去切的，怎么计算不同宽度下font-site的值，大家看表格上面的数值变化应该能明白。举个例子：384/640 = 0.6，384是640的0.6倍，所以384页面宽度下的font-size也等于它的0.6倍，这时384的font-size就等于12px。在不同设备的宽度计算方式以此类推。

除了上面通过JS去动态计算根元素的font-size，也可采用媒体查询。一般我们在做web app都会先统计自己网站有哪些主流的屏幕设备，然后去针对那些设备去做media query设置也可以实现适配，例如下面这样(参考)：
```css
html{
    font-size:10px
} 
@media screen and (min-width:321px) and (max-width:375px){
    html{
        font-size:11px
    }   
} 
@media screen and (min-width:376px) and (max-width:414px){
    html{
        font-size:12px
    }
} 
@media screen and (min-width:415px) and (max-width:639px){
    html{
        font-size:15px
    }
} 
@media screen and (min-width:640px) and (max-width:719px){
    html{
        font-size:20px
    }
} 
@media screen and (min-width:720px) and (max-width:749px){
    html{
        font-size:22.5px
    }
} 
@media screen and (min-width:750px) and (max-width:799px){
    html{
        font-size:23.5px
    }
} 
@media screen and (min-width:800px){
    html{
        font-size:25px
    }
}
```
使用媒体查询的缺点是不能所有设备全适配，但是用JS是可以实现全适配。具体使用上根据需求来定。