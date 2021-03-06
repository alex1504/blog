---
title: 正则表达式语法详解
date: 2016-06-02 17:12:19
categories: 前端
tags: [js,正则]
---
# 正则表达式的定义 #
可以使用Regexp（）构造函数来创建Regexp对象，不过更多的是通过一种特殊的直接量语法来创建。直接量定义为包含在一对斜杠（/）之间的字符。例如：
```javascript
    var pattern=/s$/
```
ES3规范规定，一个正则表达式直接量在执行它时转换为一个Regexp对象，同一段代码表示的正则每次运算都指向同一个对象；ES5规范做了相反规定，每次运算都返回新的对象。


# 直接量字符 #

直接量字符包含所有的字母和数字，以及转义字符。
**直接量字符列表：**

| 字符        |匹配          | 
| ------------- |:-------------:|
| 字母和数字组合      | 自身 | 
| \o      | NUL字符（\u0000）      |  
| \t | 制表符（\u0009）     |  
| \n      | 换行符（） | 
| \v      | 垂直制表符      |  
| \f | 换页符      |  
| \r      | 回车符 | 
| \xnn      | 由16进制数nn指定的拉丁字符     |  
| \uxxxx | 由16进制数xxxx指定的Unicode字符      |  
| \cX      | 控制字符^X，例如\cJ等价于换行符\n | 

**在正则表达式中，许多标点符号具有特殊的含义，他们是：**
**^ $ . * + ? = ! : | \ / ( ) [ ] { } **
如果想匹配这些字符，**同样需要\进行转义**。其他标点符号（比如：@  ~  引号  逗号 分号  横杆）没有特殊含义，将按照字面含义进行匹配

# 正则中需要转义的特殊字符 #

| 特别字符        |说明          | 
| -------------   |:-------------:|
| $      | 匹配输入字符串的结尾位置。如果设置了RegExp对象的Multiline属性，则 $ 也匹配\n或\r。要匹配 $字符本身，请使用\| 
| ()      | 标记一个子表达式的开始和结束位置，子表达式可以获取供以后使用。要匹配这些字符，请使用 \ ( 和 \ )    |  
| * | 匹配前面的子表达式零次或多次。要匹配 * 字符，请使用\   |  
| +      | 	匹配前面的子表达式一次或多次。要匹配 + 字符，请使用 \  |
| .      | 匹配除换行符 \n之外的任何单字符。要匹配 "."，请使用 \     |  
| []| 标记一个中括号表达式的开始。要匹配 [，请使用 \ [   |  
| ?     | 匹配前面的子表达式零次或一次，或指明一个非贪婪限定符。要匹配 ? 字符，请使用 \?。 | 
| \     | 将下一个字符标记为或特殊字符、或原义字符、或向后引用、或八进制转义符例如， ‘n' 匹配字符 ‘n'。'\n' 匹配换行符。序列 ‘\ \' 匹配 “\”，而 ‘\ (' 则匹配 “(”。     |  
| ^ | 匹配输入字符串的开始位置，除非在方括号表达式中使用，此时它表示不接受该字符集合。要匹配 ^ 字符本身，请使用 \^。     |  
| {}      | 标记限定符表达式的开始。要匹配 {，请使用 \ {。 | 
| 竖杠      | 	指明两项之间的一个选择。要匹配竖杠，请使用 \竖杠。 | 


# 字符类 #
将字面量字符单独放进放括号内就组成了字符类。
**“^”符号可以否定字符类**
**“-”可以用来表示字符的范围**

| 字符        |匹配          | 
| ------------- |:-------------:|
| [...]      | 方括号内的任意字符| 
| [^...]      | 不在方括号内的任意字符      |  
| . | 除换行符和其他unicode行终止符之外的任意字符）     |  
| \w      | 任何ASCII字符组成的单词，等价于[a-zA-Z0-9_] | 
| \W      | 任何不是ASCII字符组成的单词，等价于[^a-zA-Z0-9_]      |  
| \s | 任何unicode空白字符     |  
| \S      | 任何非unicode空白符的字符，<font color="#16a085">注意\w和\S不同</font> | 
| \d      | 任何ASCII数字，等价于[0-9]     |  
| \D | 除了ASCII数字之外的任何字符，等价于[^0-9]     |  
| [\b]      | 退格直接量（特例） | 

**\w 表示匹配大小写英文字母、数字以及下划线，等价于[a-zA-Z0-9_]。**
**\S 表示匹配非空白字符，范围广，只要不是空格、换行符、制表符、换页符即可**

# 重复 #
正则模式之后跟随用以指定字符重复的标记。由于某些重复种类非常常用，因此就有一些专门用于表示这种情况的特殊字符。
**正则表达式的重复字符语法：**

| 字符        |含义          | 
| ------------- |:-------------:|
| {n,m}      | 匹配前一项至少n次，但不能超过m次| 
| {n,}     | 匹配前一项n次或者更多次      |  
| {n} | 匹配前一项n次    |  
| ?      | 匹配前一项0次或者1次，也就是说**前一项可选**，等价于{0,1} | 
| +      | 匹配前一项1次或者多次，等价于{1,}     |  
| * | 匹配前一项0次或者多次，等价于{0,}     |  
例子：
```javascript
/\d{2,4}/            //匹配2~4个数字
/\w{3}\d?/           //匹配3个单词和一个可选的数字
/\s+java\s+/         //匹配前后带有一个或多个空格的字符串“java”
/[^(]*/			     //匹配0个或者多个非左括号的字符
```
在使用星号和问号时要注意，由于这些字符可能匹配0个字符，因此他们允许什么都不匹配。例如正则/ a*/实际上与字符串“bbbb”匹配，因为这个字符串含有0个a。

**贪婪匹配和非贪婪匹配**
以上的重复匹配属于贪婪的匹配，即尽可能多的匹配；若要尽可能地少匹配，只需在重复字符后面跟随一个“?”即可。
比如正则表达式/a+/可以匹配一个或多个连续的字母a。当使用“aaa”作为匹配字符串时，正则表达式会匹配它的三个字符。但是/a+?/也可以匹配一个或多个连续字母a，同样以“aaa”作为匹配字符串，此时只匹配第一个a。

但是，非贪婪匹配可能和所匹配的预期不一致。**这里提一下正则的机制，它总是会寻找字符串中第一个可能匹配的位置**。比如/a+?b/，当用它来匹配“aaab”时，它实际上匹配了整个字符串，而非匹配一个a和最后一个b。

# 选择、分组和引用 #
**选择字符**：|
说明：选择字符匹配尝试从左到右，直到发现匹配项。如果左边的选择项匹配，就忽略右边匹配项。

**组合字符**：(...) 和(? : ...)

**引用字符**：\n，n为大于等于1的正整数，表示引用与第n个分组相匹配的**文本的引用**,而非子表达式模式的引用。例如：
```javascript
/['"][^'"]*['"]/  
```
匹配的是位于单引号或双引号之内的0个或多个字符，但是，它并不要求左侧和右侧的引号相同。
```javascript
/(['"])[^'"]*\1/ 
```
匹配位于单引号或双引号之内的0个或多个字符，并且左右两侧引号必须相同，这就是**文本引用**产生的结果。

**正则表达式的选择、分组、和引用字符**

| 字符        |含义          | 
| ------------- |:-------------:|
| 竖杠    | 选择，匹配的是该符号左边的子表达式或右边的子表达式| 
| (...)     | 将几个项组合为一个单元，这个单元可以通过“*”，“+”，“?”等符号加以修饰，而且可以记住和这个组合相匹配的字符串以供此后的引用使用。      |  
| (?:...) | 只组合，把项组合成一个单元，但不记忆与改组相匹配的字符    |  
| \n    | 引用第n个分组第一次匹配的字符，组是圆括号中的子表达式（也有可能是嵌套的），组索引是从左到右的左括号数，“?：”形式的分组不编码 | 

