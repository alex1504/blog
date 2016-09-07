---
title: JavaScript获取DOM尺寸大小和元素位置
date: 2016-06-15 12:46:43
tags: [js,dom]
---
JavaScript处理一些DOM元素的动态效果经常需要一些元素的尺寸大小和位置。body节点主要用于获取页面宽高和滚动条的滚动距离，以下出现body节点可以替换为其他DOM元素表示在该元素下获取或设置这些属性。作为HTML元素，都具有下列属性：
![大小、位置属性](http://7xrw48.com1.z0.glb.clouddn.com/images%2F2016%2F6%2F15%2Fproperty.jpg)
这些属性的笼统特征：
client：元素内容+内边距 大小，不包括边框、外边距、滚动条部分    
offset：元素内容+内边距+边框  不包括外边距和滚动条部分
scroll：与元素的滚动相关
# 尺寸大小 #
一张网页的全部面积，就是它的大小。通常情况下，网页的大小由内容和CSS样式表决定。
视口是指在浏览器窗口中看到的那部分网页面积。
## 获取网页的大小（都不包括外边距、滚动条） ##
**宽（值随窗口大小发生改变）：** document.body.clientWidth（不包括border，只包括内容+padding）  
或者 document.body.offsetWidth（包括border）
或者 document.body.scrollWidth 
**高(值固定)：** document.body.clientHeigth（不包括border，只包括内容+padding）  
或者 document.body.offsetHeight（包括border）
或者 document.body.scrollHeight
**说明：**通常使用document.body.scrollWidth和document.body.scrollHeight
## 获取屏幕相关属性 ##
使用window.screen对象的属性。这些属性有个特点，不会随着窗口的伸缩而改变数值
**屏幕分辨率的高：**window.screen.height
**屏幕分辨率的宽：**window.screen.width
**屏幕可用工作区高度：**window.screen.availHeight（即除去windows任务栏的高度剩余的高度,如图）
![availHeight说明](http://7xrw48.com1.z0.glb.clouddn.com/images%2F2016%2F6%2F15%2FavailHeight.jpg)
**屏幕可用工作区宽度：**window.screen.availWidth=屏幕分辨率的宽
## 获取视口大小 ##
**在声明了DOCTYPE的浏览器中：**
document.documentElement.clientWidth 
document.documentElement.clientHeight
说明：IE，FF，Safari皆支持该方法，opera虽支持该属性，但是返回的是页面尺寸
**除了IE7及以下版本的所有浏览器都将此信息保存在window对象中**
window.innerWidth 
window.innerHeight
说明：包含滚动条
**IE7及以下版本方获取视口方法**
document.body.offsetWidth 
document.body.offsetHeight

# 元素位置 #
## 绝对位置 ##
**绝对位置：**网页元素的绝对位置，指该元素的左上角相对于整张网页左上角的坐标。这个绝对位置要通过计算才能得到。
**获取绝对高度:** DOMElement.offsetTop
**获取绝对宽度：**DOMElement.offsetLeft
## 相对位置 ##
**相对位置：**网页元素的相对位置，指该元素左上角相对于浏览器窗口左上角的坐标。

由此有：元素绝对位置坐标=元素相对位置坐标+滚动条滚动的距离
要知道元素的相对位置就要知道滚动条滚动的距离，那么滚动条的滚动距离怎么获取呢？

### 获取滚动条的滚动距离 ###
**竖：**document.body.scrollTop       或window.scrollY
**横：**document.body.scrollLeft      或window.scrollX
### 窗口相对于屏幕的位置 ###
**窗口相对于屏幕的X坐标：**window.screenLeft（通常为0）
**窗口相对于屏幕的Y坐标：**window.screenTop（如图）
![screenTop说明](http://7xrw48.com1.z0.glb.clouddn.com/images%2F2016%2F6%2F15%2FscrollTop.jpg)

# jQuery对于尺寸和位置封装的函数 #
使用原生的js方法获取DOM尺寸大小和元素位置仍然不太方便，比如兼容性，jQuery封装的函数就很好的解决了这个问题。
## 时下页面大小 ##
当窗口大小改变，宽度值改变，高度值固定 
```javascript
$(document).width()   //浏览器时下窗口文档的宽度  
$(document).height()　//浏览器时下窗口文档的高度   
 ```
## 时下元素大小 ##
当窗口大小改变，宽度值改变，高度值固定
以下以body节点为例，可替换成DOM元素调用方法
```javascript
$(document.body).width()　　　　　　//浏览器时下窗口文档body的宽度   
$(document.body).height()　　　　　 //浏览器时下窗口文档body的高度   
$(document.body).outerWidth(true)　 //浏览器时下窗口文档body的总宽度(包括padding、border) 
$(document.body).outerHeight(true)　//浏览器时下窗口文档body的总高度(包括padding、border)  
```
## 时下可视区大小 ##
当窗口大小改变，宽度、高度皆改变
```javascript
$(window).height() 　//浏览器时下窗口可视区域高度    
$(window).width() 　 //浏览器时下窗口可视区域宽度  
```