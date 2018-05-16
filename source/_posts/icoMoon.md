---
title: IcoMoon将图标转换成web字体
date: 2016-06-16 11:22:52
categories: 前端
tags: [css, 图标]
---
本文总结一款免费开源的Web应用程序[IcoMoon](https://icomoon.io/app/#/select)制作web图标字体。
# 使用web字体图标优势 #
适用性：一个图标字体比一系列的图像（特别是在Retina屏中使用双倍大小的图像）要小。一旦图标字体加载了，你的图标就会马上渲染出来，不需要下载一个图像。

可扩展性：图标字体可以用过font-size属性设置其任何大小。这使您能够随时输出不同大小的图标，然而，使用位图，你必须得为每个不同大小的图像输出一个不同文件。

灵活性：文字效果可以很容易地应用到你的图标上，包括**颜色，阴影和翻转**等效果。他们还可以在任何背景下显示。

兼容性：网页字体支持所有现代浏览器，包括IE低版本。详细兼容性可以点击这里。

# IconMoon优势 #
提供完整图标解决方案：
600+字符，您可以根据自己需求定制（如就选两个）；可以导入其他字体，也进行特别定制（类似fontforge功能）；定制字体提供打包导出功能（省去了字体转换），兼容IE6+，现代浏览器以及各类手机设备，且有demo实例，并对字符进行了HTML转化。

# IconMoon使用方法 #
导入或选择图标、对图标进行编辑、生成并输出成zip文件（含字体本身、HTML实例页面和相应的CSS）

## 导入或选择图标 ##
选择内置图标只需在界面单击相应图标，图标高亮即为选中。
![选择](http://qiniu.huzerui.com/image/2016-06-16-how-to-use-iconmoon-1.jpg)
如果你通过AI做好了一个图标想导入，只需点击“Imorticons”按钮，然后选择您想要添加的SVG文件——您也可以一次添加多个文件。这些图标将会出现在“Your Custom Icons”区域中。如果他们是高亮的黄色显示，表示这些图标是你将要创建的图标字体。

## 对图标进行编辑 ##
![编辑](http://qiniu.huzerui.com/image/2016-06-16-how-to-use-iconmoon-2.gif)
如果你想调整图标的位置、大小或旋转，你可以点击“Edit”按钮。可以使用“Save Copy”按钮来创建图片的变化（例如，一个镜像的衅标）。添加一个有意义的图标标记，因为这将被用来生成类名。


## 生成并输出成zip文件 ##
点击屏幕底部的“Font”按钮开始生成字体。这样你就可以指定哪个图标映射到哪个字符上，例如，如果你要设置一套六个旋转的球，你可以每 这六个球分别指定字符：q、w、e、r、t和y。你也可以根据你自己的爱好选择一个字体的名字。
![输出](http://qiniu.huzerui.com/image/2016-06-16-how-to-use-iconmoon-3.jpg)
单击“Download”下载字体包到你的电脑上。他有一个字文件夹包含了字体本身（woff,eot,ttf格式），以及一个HTML示例页面和相应的CSS。甚至还有一个javascript文件和一个解决方法，如果你需要支持IE或IE7。

# 如何使用这些图标字体 #
@font-face引入字体库、调用图标字体
## @font-face引入字体库 ##

语法：
```css
@font-face {
   font-family: <YourWebFontName>;
   src: <source> [<format>][,<source> [<format>]]*;
   [font-weight: <weight>];
   [font-style: <style>];
}
```
兼容多种浏览器示例；如果只需兼容现代浏览器，可以按需删除src一些代码。
```css
@font-face {
    font-family: 'icomoon';
    src: url('fonts/icomoon.eot?1h4iu7'); /* IE9 Compat Modes */
    src: url('fonts/icomoon.eot?1h4iu7#iefix') format('embedded-opentype'),/* IE6-IE8 */
         url('fonts/icomoon.ttf?1h4iu7') format('truetype'), /* Modern Browsers */
         url('fonts/icomoon.woff?1h4iu7') format('woff'), /* Safari, Android, iOS */
         url('fonts/icomoon.svg?1h4iu7#icomoon') format('svg');  /* Legacy iOS */
    font-weight: normal;
    font-style: normal;
}
```
## 调用图标字体 ##
通过css属性选择器指定类为"icon-"开头的元素的font-family，并为icon-创建的图标类名定义content。与fontAwesome图标字体使用方法是相同的
css
```css
[class^="icon-"], [class*=" icon-"] {
    /* 使用!important 使样式获得最高优先级  */
    font-family: 'icomoon' !important;
    speak: none;
    font-style: normal;
    font-weight: normal;
    font-variant: normal;
    text-transform: none;
    line-height: 1;

    /* 使字体变得平滑 =========== */
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
}
.icon-home:before {
    content: "\e900";
}
.icon-office:before {
    content: "\e904";
}
```
然后html中定义类名调用即可：
```html
<span class="icon-home"></span>
```
最简单的方法就是将文件夹中的style.css样式文件粘贴到自己项目中的样式表即可。
