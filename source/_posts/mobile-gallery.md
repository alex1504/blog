---
title: 移动端图片画廊
date: 2016-9-04 10:55:47
tags: [移动端,图片画廊]
---
移动端图片画廊，采用css3的flex布局结合object-fit属性，实现类似Google Photo 等高自适应的图片布局效果
![demo](http://huzerui.com/blog/img/post/2016-09-04-mobile-photo-galleries.gif)
你也可以点击[在线地址](http://huzerui.com/mobile-gallery)  查看预览:


## 关于flex-box布局 
flex布局简直是移动端的神器，因为移动端不存在兼容性问题，几乎所有手机浏览器都采用相同的标准。

## 几分钟快速了解flex-box布局  
1、采用flex布局（作用于容器）
块状元素：
```css
.box{
    display:flex;
}
```

行内元素：
```css
.box{ 
    display: inline-flex;
}
```
2、容器的属性

寻找好基友：
 flex-direction、 flex-wrap、flex-flow
justify-content、align-items、align-content

解释：
 - **flex-direction**：决定主轴的方向（即项目的排列方向）
 - **flex-wrap**：默认情况下，项目都排在一条线（又称"轴线"）上。flex-wrap属性定义，如果一条轴线排不下，如何换行
 - **strong text**flex-flow：flex-direction属性和flex-wrap属性的简写形式，默认值为row nowrap。
 - **justify-content**：定义了项目在主轴上的对齐方式（flex-start | flex-end | center | space-between | space-around）
 - **align-items**：定义项目在交叉轴上如何对齐（flex-start | flex-end | center | baseline | stretch）
 - **align-content**：定义了多根轴线的对齐方式。如果项目只有一根轴线，该属性不起作用。（flex-start | flex-end | center | space-between | space-around | stretch;）

3、项目的属性
基友：
flex-grow、flex-shrink、flex-basis、flex
order   （规整有序）
alignself  （特立独行）

解释：
**flex-grow**：定义项目的放大比例，默认为0，即如果存在剩余空间，也不放大。
**flex-shrink**：定义了项目的缩小比例，默认为1，即如果空间不足，该项目将缩小。
**flex-basis**：定义了在分配多余空间之前，项目占据的主轴空间（main size）。浏览器根据这个属性，计算主轴是否有多余空间。它的默认值为auto，即项目的本来大小。
**flex**：flex-grow, flex-shrink 和 flex-basis的简写，默认值为0 1 auto。后两个属性可选。

**order**：定义项目的排列顺序。数值越小，排列越靠前，默认为0。

**align-self**：属性允许单个项目有与其他项目不一样的对齐方式，可覆盖align-items属性。默认值为auto，表示继承父元素的align-items属性，如果没有父元素，则等同于stretch。

## 关于object-fit属性

适用范围：替换元素

    <img>、<input>、<textarea>、<select>、<object>等
    浏览器根据其标签的元素与属性来判断显示具体的内容
值：
**fill**: 默认值。替换内容拉伸填满整个content box, 不保证保持原有的比例。
**contain**: 保持原有尺寸比例。保证替换内容尺寸一定可以在容器里面放得下。因此，此参数可能会在容器内留下空白。
**cover**: 保持原有尺寸比例。保证替换内容尺寸一定大于容器尺寸，宽度和高度至少有一个和容器一致。因此，此参数可能会让替换内容（如图片）部分区域不可见。
**none**: 保持原有尺寸比例。同时保持替换内容原始尺寸大小。
**scale-down**: 就好像依次设置了none或contain, 最终呈现的是尺寸比较小的那个。

## DEMO解释
html:
```html
<div class="page">
    <div class="m-gallery">
        <!-- <div><img class="animated bounceIn" src="img/1.jpg"></div> -->
    </div>
    <div class="m-viewbox hide">
        <img class="bigimg animated bounceIn" src="">
    </div>
</div>  
```
css:
```css
.m-gallery{
    display: flex; //采用flex布局
    flex-wrap: wrap;  //规定一行放不下flex元素时自动换行
}
.m-gallery div{
    height: 100px;
    flex-grow:1;   //每个flex元素占的宽度相同
    margin: 2px;
}

.m-gallery  img{
    height: 100px;
    min-width: 100%;     
    max-width: 100%;
    object-fit: cover;      //使图片等比拉伸，可能会被裁减
    vertical-align: bottom;
}
@media (max-width: 1000px) and (min-width: 900px) {
  .m-gallery::after {
      content: '';
      flex-grow: 999999999;     //当最后一行图片太少的时候，比如只有一张，因为 grow 的关系，它将占满一整行，通过伪元素来占满剩余空间，防止图片拉伸
   }
}
@media (max-width: 1100px) and (min-width: 1000px) {
 .m-gallery::after {
      content: '';
      flex-grow: 999999999;
   }
}
```

