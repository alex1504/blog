---
title: javascript字符串对象方法
date: 2016-06-14 16:04:41
tags: [js,string]
---
# 字符方法 #
## chatAt()和chatCodeAt ##
charAt()和charCodeAt()
这两个方法接收一个参数，即基于0的字符位置。
chatAt()以单字符字符串的形式返回给定位置的那个字符。
chatCodeAt()返回给定位置的那个字符的字符编码。
```javascript
var stringValue="hellow";
stringValue.chatAt(1);      //"e"
stringValue.chatCodeAt(1);  //"101"
```
# 字符串操作方法 #
## concat() ##
concat()用于将一个或多个字符串拼接起来，返回拼接得到的新创建的字符串。
但实践中大多数情况还是使用(+)加号操作符，比concat()简单易行。
## slice()、substring()、substr() ##
三个基于子字符串创建新字符串的方法，创建并返回被操作字符串的子字符串。**注意方法名称都是小写**
**共同点：**
参数1：必选，指定子字符串开始位置。
参数2：可选，不指定时将字符串的长度作为结束位置。
**差异：**
**1、当指定参数2时**

| 方法        | 参数2含义           | 
| ------------- |:-------------:| 
| slice()、substring()      | 指定子字符串最后一个字符的位置 | 
| substr    | 返回或截取的字符个数     |  
```javascript
var stringValue="hello world";
stringValue.length;         //11
stringValue.slice(3);       //"lo world"
stringValue.substring(3);   //"lo world"
stringValue.substr(3);		//"lo world"
stringValue.slice(3,7);		//"lo wo"
stringValue.substring(3,7); //"lo wo"
stringValue.substr(3,7);    //"lo worl"
```
**2、当传递这些方法的参数是负数时**

| 方法        | 行为           | 
| ------------- |:-------------:| 
| slice()     | 所有传入的负值与字符串的长度相加 | 
| substring()    | 所有的负值参数都转化为0    |  
| substr()    | 将负的第一个参数加上字符串的长度，将负的第二个参数转换为0    |  
```javascript
var stringValue="hello world";
stringValue.length;             //11
stringValue.slice(-3);          //"rld"
stringValue.substring(-3);      //"hello world"
stringValue.substr(-3);			//"rld"
stringValue.slice(3,-4);		//"lo wo"
stringValue.substring(3,-4);    //"hel"
stringValue.substr(3,-4);       //""
```
# 字符串位置方法 #
## indexOf()和lastIndexOf ##
从字符串中查找子字符串的位置，如果找到返回子字符串的位置；找不到返回-1
参数1：指定检索的子字符串
参数2：可选，指定开始检索的位置
indexOf()从开头向末尾搜索
lastIndexOf()从末尾向开头搜索
```javascript
stringValue="hello world";
stringValue.indexOf('o',6);           //7
stringValue.lastIndexOf('o',6);       //4,此时从指定位置向前检索
```
# trim()方法 #
创建一个字符串的副本，删除前置及后缀的所有空格，然后返回结果。
注意：字符串中的空格不管
```javascript
stringValue=" hellow world  ";
stringValue.trim();         //"hellow world"
stringValue;                //" hellow world  ";
```
# 字符串大小写转换方法 #
toLowerCase()和toUpperCase()

# 字符串模式匹配方法 #
## match() ##
在字符串调用这个方法，本质上与调用RegExp对象的exec()方法相同。
参数：match()接收一个参数，要么是正则表达式，要么是正则对象。
返回值：matches返回一个数组，数组的第一项是与整个模式匹配的字符串，之后的每一项（如果有）保存着与正则表达式中捕获组匹配的字符串。
```javascript
var text="cat,bat,hat";
var pattern=/.at/;
var matches=text.match(pattern);
matches.index              //0
matches[0]                 //"cat"
pattern.lastIndex          //0
```
## search() ##
参数：search()接收一个参数，要么是正则表达式，要么是正则对象。
返回值：返回字符串中第一个匹配项的索引，如果没有找到匹配项，则返回-1.
注意：search()方法始终从字符串开头向后查找模式
例子：
```javascript
var text="cat,bat,hat";
var pos=text.search(/cat/);    //0
```
## replace() ##
诞生原因：为了简化替换子字符串的操作，ECMAScript提供了replace()方法
参数：第一个参数正则对象或者字符串，第二个参数是一个字符串或者函数。
返回值：生成的替换后的字符串
注意
```javascript
text="cat,bat,hat";
result=text.replace("at","ond")     //"cond,bat,hat"
result=text.replace(/at/g,"ond")    //"cond,cont,hont"
```
更精细的替换操作，使用函数作为replace()的第二个参数
在只有一个匹配项的情况下，会向这个函数传递3个参数：模式的匹配项、模式的匹配项在字符串中的位置、原始字符串。
在正则表达式中定义了多个捕获组的情况下，这个函数的参数依次是：模式的匹配项、第一个捕获组的匹配项、第二个捕获组的匹配项...，最后两个参数是模式的匹配项在字符串中的位置、原始字符串。
这个函数应该返回一个字符串，表示准备替换的预备项。
例子：
```javascript
function htmlEscape(text){
	return text.replace(/[<>"&]/g,function(match,pos,originText){
		switch(case){
			case "<":
				return &lt;
			case ">":
				return &gt;
			case "\"":
				return &quot;
			case "&":
				return &amp;
		}
	})
}
htmlEscape("<p class=\"desc\">hellow</p>")  
//输出 &lt;p class=&quot;desc;&quot;&gt;hellow&lt;/p&gt;
```
## split() ##
基于指定的分割符将字符串分割成多个子字符串，并将结果存放在一个数组中。
参数：第一个参数是字符串或者正则表达式,匹配的项将作为分隔符
	  第二个参数可选，用于指定数组的大小
```javascript
color="red,blue,pink";
colors1=color.split(",");   //["red","blue","pink"]
colors2=color.split(",",2); //["red","blue"]
colors3=color.split(/[^,]+/);   
//["",",",",",""]   由于/^,/匹配的是除逗号以外的一个或多个字符，而"red"和"pink"刚好在开头和结尾，因此数组第一个元素和最后一个为空字符
```