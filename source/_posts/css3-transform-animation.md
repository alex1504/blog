---
title: css3动画属性总结
date: 2016-06-16 22:21:23
tags: [css3]
---
# transform  #
## 指定三维视角 ##
perspective 属性定义 3D 元素距视图的距离，以像素计。
当为元素定义 perspective 属性时，其子元素会获得透视效果，而不是元素本身。


## 三维变形 ##
三维变形的变形方式：四种方法 
旋转——缩放——平移——扭曲——指定变形基点
## 旋转 ##
transform:rotate(45deg);
该语句使div元素顺时针旋转45度。
## 缩放 ##
transform:scale(0.8,1);
使用缩放的方法实现文字或图像的缩放效果，在参数中指定缩放倍率。该语句使用scale方法使该元素在水平方向上缩小了20%，垂直方向上不缩放。
## 平移 ##
translate(50px,50px);
使用translate方法来将文字或图像在水平方向和垂直方向上分别垂直移动50像素。
## 扭曲 ##
transform:skew(30deg,0deg);
该实例通过skew方法把元素水平方向上倾斜30度，处置方向保持不变。
## 指定变形基点 ##
在使用transform方法进行文字或图像的变形时，是以元素的中心点为基准点进行的。使用transform-orign属性，可以改变变形的基准点。
transorm-origin:left bottom;
left和bottom是基准点在元素水平方向和垂直方向上的位置。

# 背对屏幕元素是否可见 #
backface-visibility: visible | hidden;  定义当元素不面向屏幕时是否可见。

# CSS3过渡transition #
transition属性是一个简写属性，用于设置四个过渡属性：
transition-property  哪个属性实现过渡如：width
transition-duration  完成过渡效果需要多少秒/毫秒
transition-timing-function  速度效果的运动曲线，如linear 、ase-in 、ease 、 ease-out 、ease-in-out 、 cube-bezier（贝塞尔曲线） 
transition-delay  规定过渡开始前等待几秒

# CSS3动画 animation  #
animation属性值：

| 属性       | 说明     | 
| ------------- |:-------------:| 
| @keyframes     | 定义动画名称| 
| animation  | 所有动画属性的简写属性，除了animation-play-state属性。    |  
| animation-name| 规定 @keyframes 动画的名称。    |  
| animation-duration | 规定动画完成一个周期所花费的时间。默认是0s。    |  
| animation-timing-function | 规定动画的速度曲线。默认是 "ease"。  |  
| animation |规定动画何时开始。默认是0s。 |  
| animation-iteration-count | 规定动画被播放的次数。默认是1。      |  
| animation-direction | 规定动画是否在下一周期逆向地播放。默认是 "normal" 。逆向alternate    |  
| animation-play-state | 规定动画是否正在运行或暂停。默认是 "running"，暂停时pause    |  
| animation-fill-mode | 规定对象动画时间之外的状态。forwards：设置对象状态为动画结束时的状态；backwards：设置对象状态为动画开始时的状态；both：设置对象状态为动画开始或结束的状态      |  

# CSS3过渡与动画的区别 #
1、animation多两个参数，循环和动画的方式
2、transition不能自行触发，通过hover等动作或结合JS进行触发。anmiation可以自行运行。
3、transition可控性较弱，只能指定起始状态和结束状态，而animation可以定义多个关键帧。
4、动画在运行结束之后，需要回到初始状态
5、transition的作用在于平滑的改变CSS样式

# 推荐样式书写顺序 #
显示属性-->自身属性-->文本属性
**显示属性 ：**display，list-style，position，float，clear [注意按照横着的顺序]
**自身属性（合模型）：**width，height，margin，padding，border，background（第3点）
**背景：**background
**行高：**line-height
**文本属性：**color,font，text-decoration，text-align，vertical-align，white-space，content
**其他** cursor/z-index/zoom
**css3属性：**trandsform/transition/animation/box-shadow/border-radius
**链接的样式顺序：**a:link-->a:visited-->a:hover-->a:active


