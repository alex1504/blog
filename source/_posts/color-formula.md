---
title: 前端都了解的配色策略
date: 2017-10-15 19:18:19
tags: [设计,配色]
categories: [前端,设计]
---
在色彩设计应用中，我们对颜色不同程度的理解，影响到设计页面的表现。可是这跟前端有什么联系么？不是设计师的事情么？

可试想一下如果某些情况下我们需要脱离脱离设计师，比如我们需要做些赏心悦目的示例分享，除了将交互、逻辑做好，没有优雅的配色和设计，可能你的分享会显得苍白无力，下面直入正题。

# 颜色理论（Color theory）
三原色：指色彩中不能再分解的三种基本颜色，我们通常说的三原色，即**红、黄、蓝**。三原色可以混合出所有的颜色，同时相加为黑色，黑白灰属于无色系。色彩中颜料调配三原色混合色为黑色。

**红+黄=橙、黄+蓝=绿、蓝+红=紫**

色环（Color  Wheel）：又称色轮、色圈，是**将可见光区域的颜色以圆环来表示**，为色彩学的一个工具，一个基本色环通常包括12种不同的颜色。
![色环形成](http://qiniu.huzerui.com/image/2017-10-15-color-ring.gif)
![色坏](http://qiniu.huzerui.com/image/2017-10-15-color-ring.jpg)

# 配色策略
在理解的色环之后，在前人的总结和指引下，就衍生出了一些配色策略。注意每一种配色策略都可以因饱和度、明度的变化产生数不清的配色方案。比如下面的相似色两种配色方案，**基本颜色就是四种（主色、辅色、点睛、背景）**。

可以发现它们对应颜色的色相变化值都不超过30，在提升或降低饱和度之后形成的颜色变化从而形成不同配色方案。

配色策略提供的一种指引，具体的颜色值确定靠的更多是灵感和视觉审美。

## 单色（Monochromatic）
![Monochromatic](http://qiniu.huzerui.com/image/2017-10-15-formula-monochromatic.jpg)

## 相似色（Analogous）
![Analogous](http://qiniu.huzerui.com/image/2017-10-15-formula-analogous.jpg)
![Analogous](http://qiniu.huzerui.com/image/2017-10-15-formula-analogous-1.jpg)

## 互补色（Complementary）
如：红绿对比、蓝橙、黄紫对比
![Complementary](http://qiniu.huzerui.com/image/2017-10-15-formula-complementary.jpg)

## 分割互补色（Split complementary）
![Split complementary](http://qiniu.huzerui.com/image/2017-10-15-formular-split-complementary.jpg)

## 三角对立（Triadic ）
![Triadic ](http://qiniu.huzerui.com/image/2017-10-15-formula-triadic.jpg)

## 矩形（Tetradic）
![Tetradic](http://qiniu.huzerui.com/image/2017-10-15-formula-tetradic.jpg)

# 关于主色调、辅色调、点睛色、背景色

 主色调
页面色彩的主要色调、总趋势，其他配色不能超过该主要色调的视觉面积。（背景白色不一定根据视觉面积决定，可以根据页面的感觉需要。）

辅色调
仅次与主色调的视觉面积的辅助色，是烘托主色调、支持主色调、起到融合主色调效果的辅助色调。 

点睛色 
在小范围内点上强烈的颜色来突出主题效果，使页面更加鲜明生动。

背景色 
衬托环抱整体的色调，协调、支配整体的作用。

# 配色工具
Adobe出品的一个在线配色工具，上边列出了海量的配色方案供我们使用，如果你不满足，也可以试下上传图片建立自己的配色方案，只需上传一张图片，网站便可自动提取图片颜色生成配色方案。

网页版地址：[https://color.adobe.com/zh/create/color-wheel/](https://color.adobe.com/zh/create/color-wheel/)
除了创建自己的配色方案，可以参考他人的配色方案并且提供下载编辑的功能，十分好用。
![ explore](http://qiniu.huzerui.com/image/2017-10-15-color-explore.jpg)


Kuler也有PS插件，使用方式参考这篇文章[教你使用最受欢迎的配色小工具Kuler](http://www.uisdc.com/adobe-kuler-vc)。

其他配色工具：
[Spectrum](http://www.eigenlogik.com/spectrum/mac)：Mac + iOS 配色工具 
[Paletton](http://paletton.com/)：The Color Scheme Designer
[Color Scheme Designer](http://www.peise.net/tools/web/)：高级在线配色工具

更多的配色工具参考：[推荐配色工具](https://www.zhihu.com/question/23220933)、[国外最好的22个配色网站](http://www.uisdc.com/best-22-color-website)

# 网页设计配色文章
一、[秒变配色高手！怎么都不会错的6条网页设计配色原则](http://www.uisdc.com/6-rules-webdesign-color)
二、[网页设计常用色彩搭配表](http://tool.c7sky.com/webcolor/)
三、[如何巧用色彩打造动人心弦的网页设计](http://www.uisdc.com/color-psychology-web-design)

