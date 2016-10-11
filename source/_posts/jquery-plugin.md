---
title: 使用jQuery封装插件
date: 2016-06-12 18:10:19
tags: [js,jQuery]
---
jQuery封装插件的方法有三种：封装对象方法的插件、封装全局函数的插件、选择器插件
# 对象方法的插件 #
这种插件是将对象方法封装起来，用于对通过选择器获取的jQuery对象进行操作，是最常见的一种插件。此类插件可以发挥出jQuery选择器的强大优势，有相当一部分的jQuery的方法，都是在jQuery脚本库内部通过这种形式“插”在内核上的，例如parent()方法，appendTo()方法等。
## 添加一个对象扩展方法 ##
```javascript
 $.fn.changeColor= function() {
    this.css( "color", "red" );
};
   $.fn.changeFont= function() {
    this.css( "font-size", "24px" );
};
```
## 添加多个对象扩展方法 ##
```javascript
(function($){
   $.fn.changeColor= function() {
        this.css( "color", "red" );
};
   $.fn.changeFont=function() {
        this.css( "font-size", "24px" );
};
})(jQuery);
```
## 使用$.fn.extend(obj)方法 ##
插件中不需要默认参数
```javascript
(function($){
    $.fn.extend({
        "pluginName":function(){
            this.each(function() {
                //这里放置插件代码
            });
            return this;
        }
    });
})(jQuery);
```
插件中需要设置一些默认参数，可以使用\$.extend()进行扩展。在后面将对\$.fn.extend()和$.extend()进行详解
```javascript
(function($){
    $.fn.extend({
        "pluginName":function(options){
            options=$.extend({
                //放置默认参数
            },options);
            this.each(function() {
                //这里放置插件代码
            });
            return this;
        }
    });
})(jQuery);
```
# 全局函数的插件 #
可以将独立的函数加到jQuery命名空间下。如常用的jQuery.ajax()方去首尾空格的jQuery.trim()方法，都是jQuery内部作为全局函数的插件附加到内核上去的。 
## 添加单个全局函数 ##
```javascript
$.ltrim = function( str ) {
    return str.replace( /^\s+/, "" );
};
```
## 添加多个全局函数 ##
```javascript
$.ltrim = function( str ) {
    return str.replace( /^\s+/, "" );
};
 
$.rtrim = function( str ) {
    return str.replace( /\s+$/, "" );
};
```
## 使用$.extend()进行扩展(适合全局函数比较多的情况) ##
```javascript
$.extend({
  ltrim:function( str ) {
      return str.replace( /^\s+/, "" );
  },
  rtrim:function( str ) {
      return str.replace( /\s+$/, "" );
  }
});
```
## 独立的命名空间 ##
```javascript
$.myPlugin={
   ltrim:function( str ) {
       return str.replace( /^\s+/, "" );
   },
   rtrim:function( str ) {
       return str.replace( /\s+$/, "" );
   }
};
```
# 选择器插件 #
虽然jQuery的选择器十分强大，但在少数情况下，还是会需要用到选择器插件来扩充一些自己喜欢的选择器。 

## 编写jQuery选择器需要知道jQuery选择器的参数。 ##
jQuery选择器函数一共接收3个参数，代码如下：
```javascript
function(a,i,m){
    //第一个参数为a，指向当前遍历的DOM元素
    //第二个参数为i，指的是当前遍历DOM元素的索引，从0开始
    //第三个参数m比较特别，它是有jQuery正则引擎进一步解析后的产物（用match匹配出来的），结果是一个数组
        //m[0]，以例子$("div:gt(1)")来讲，是:gt(1)这部分
        //m[1]，选择器的引导符，匹配例子中的:号
        //m[2]，例子中的gt，确定是调用哪个选择器函数
        //m[3]，括号里的数字1，是编写选择器函数最重要的参数
        //m[4]，例子没有体现，略
}
}
```
## 构建选择器函数 ##
例如编写$("div:between(2,5)")能实现获取索引值为3,4元素的功能
构建：
```javascript
function(a,i,m){
    var tmp=m[3].split(",");   //将传进来的m[3]以逗号分隔开，转成一个数组
    return tmp[0]-0<i&&i<tmp[1]-0;
}
```
扩展成jQuery选择器
```javascript
(function(){
    $.extend($.expr[":"],{
        between:function(){
            var tmp=m[3].split(",");  
            return tmp[0]-0<i&&i<tmp[1]-0;
        }
    })
})(jQuery)
```
# 插件的基本要点 #
- Query插件的文件名推荐命名为jquery.[插件名].js，以免和其他JS库插件混淆。 
- 所有的对象方法都应当附加到jQuery.fn对象上，而所有的全局函数都应当附加到jQuery对象本身。 
- **在插件的范围里， this关键字代表了这个插件将要执行的jQuery对象；而在其他包含callback的jQuery函数中，this关键字代表了原生的DOM元素**。
```javascript
(function($){
    $.fn.m​​yPlugin =function(){
//此处没有必要将this包在$号中如$(this)，因为this已经是一个jQuery对象。
//$(this)等同于 $($('#element'));
        this.fadeIn('normal',function(){
//此处callback函数中this关键字代表一个DOM元素
        });
    };
})(jQuery);
 
$('#element').myPlugin();
```
- 可以通过this.each方法来遍历所有元素。
- 在插件头部加上一个分号，以免他人的不规范代码给插件带来影响。 
- 所有的方法或函数插件，都应当以分号结尾，以免压缩时出现问题 
- 除非插件需要返回的是一些需要获取的变量，**插件应该返回一个jQuery对象**，以保证插件的可链式操作。 
- 利于jQuery.extend()方法设置插件方法的默认参数，增加插件的可用性。 

# jQuery.fn.extend()与jQuery.extend()的对比 #
- jQuery.fn.extend()是对于jQuery对象（原型）扩展的方法，因为jQuery.fn=jQuery.prototype
- jQuery.extend()除了用于扩展jQuery全局函数和选择器函数之外，还有一个重要的功能，就是扩展已有的Objext对象
**语法：jQuery.extend(target,obj1,...[objN])**

1、例如合并setting对象和options对象，修改并返回settings对象
```javascript
var setting={validate:false,limit:5,name:"foo"}
var options={validate:true,name:"bar"}
var newOptions=jQuery.extend(setting,options)
//结果
newOptions={validate:true,limit:5,name:"bar"}
```
由此可见，内部机制是有扩展对象将覆盖与原对象相同的属性的值；若原对象不存在某属性，则进行扩展
2、jQuery.extend()常被用于设置插件方法的一系列默认参数，如下：
```javascript
    function foo(options){
        options=jQuery.extend({
            name:"bar",
            length:5,
            dataType:"xml"       /*默认参数*/
        },options)               /*options为传递的参数*/
    }
```