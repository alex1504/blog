---
title: Javascript数组方法
date: 2016-06-14 12:00:10
tags: [js,数组]
---
# ECMAScript3定义的数组方法 #
转换：join()
排序: reverse()、sort()
连接：concat()
裁剪: slice()
插入、删除：splice()、push()、pop()、unshift()、shift()
对象方法：toString()、toLocaleString()
### join() ###
将数组中所有元素转化为字符串并连接在一起，返回最后生成的字符串。可以指定一个可选的字符串在生成的字符串中来分隔数组中的各个元素。如果不指定分隔符，默认使用逗号。
### reverse() ###
将数组中的元素顺序颠倒，返回逆序的数组。它不通过创建新的数组重新排列，而是在原先的数组中排列它们。
### sort() ###
将数组中的元素排序并返回排序后的数组。当不带参数调用sort()时，数组元素以字母表顺序排序。
如果包含undefined的元素，它们会被排到数组的尾部。
如果要按照其他方式排序，必须给sort()方法传递一个比较函数，该函数的返回值决定了该函数所传入参数a,b在排序好的数组中的先后顺序。假设第一个参数在前，则应该返回一个小于0的数；相反，则返回一个大于0的数。
```javascript
//按数值升序
a.sort(function(a,b){
	return a-b;
})
//按数组降序
a.sort(function(a,b){
	return b-a;
})
//随机排序
a.sort(function(){
	return 0.5-Math.random();
})
```
### concat() ###
Array.concat()方法创建并返回一个新的数组，元素包括调用concat()的原始数组的元素和concat()的每个参数。如果这些参数中的任何一个自身是数组，则连接的是数组的元素；但是，concat
()不会扁平化数组的数组，可以理解为只能解剖一层。
```javascript
var a=[1,2,3];
a.concat(4,5);            //返回[1,2,3,4,5]
a.concat([4,5]);		  //返回[1,2,3,4,5]
a.concat([4,5],[6,7])     //返回[1,2,3,4,5,6,7]
a.concat(4,[5,[6,7]])     //返回[1,2,3,4,5,[6,7]]
```
由于返回的是新数组，该方法可用于实现数组复制
```javascript
var b=a.concat();
console.log(b)            //返回[1,2,3]             
```
### slice() ###
Array.slice()方法创建并返回指定数组的子数组。
slice(start,end)  参数start为必须，end为可选，分别指定截取的数组的起、止位置；如果出现负数，它表示相对于数组最后一个元素的位置。
slice(start)   截取start开始到数组结束的所有元素
slice(start,end) 截取[start,end)闭开区间的数组元素
```javascript
var a=[1,2,3,4,5];       
a.slice(0,3);        //返回[1,2,3]
a.slice(3);			 //返回[4,5]
a.slice(1,-1);	 	 //返回[2,3,4]
a.slice(-3,-2);		 //返回[3]
```
slice()方法可用于实现数组复制
```javascript
a.slice(0);          //返回[1,2,3,4,5]
```
### splice() ###
Array.splice()是数组中插入或删除元素的通用方法。不同于concat()和slice()，splice()会修改调用的数组
splice(index,howmany,item1,item2...)
第一个参数指定了插入或删除的起始位置
第二个参数指定了应该从数组中删除的元素的个数，如果省略，从起始点开始到数组结尾的所有元素都将被删除
返回值：splice()返回一个由删除元素组成的数组，或者没有删除元素，就返回空数组。
删除：
```javascript
var a=[1,2,3,4,5];
a.splice(3);           //返回[4,5],a是[1,2,3]
a.splice(1,2);		   //返回[2,3],a是[1]
```
插入：注意区别于concat()，splice()会插入数组本身而非数组的元素
```javascript
var a=[1,2,3,4,5];
a.splice(2,0,'a','b')  //返回[],a是[1,2,'a','b',3,4,5]
a.splice(2,2,[1,2],3)  //返回[3,4],a是[1,2,[1,2],3,3,4,5]
```
```push(),pop()以及unshift(),shift()
在数组的尾部插入元素、删除元素-->push()、pop()
在数组的头部插入元素、删除元素-->unshift()、shift()
这些方法都可以被splice()替代；
### toString()和toLocaleString() ###
toString()方法将数组的每个元素转化为字符串，返回用逗号分隔的字符串列表。注意，输出不包括方括号或其他任何形式包裹数组数值的分隔符。
```javascript
[1,2,3].toString();       //返回'1,2,3'
["a","b","c"].toString(); //返回'a,b,c'
[1,[2,'c']].toString();   //返回'1,2,c'
```
这里与不使用任何参数调用join()方法返回的字符串是一样的。

toLocaleString()是数组对象的本地字符串表示，返回结果随机器不同而不同，最好不要在脚本中用来基本运算。

# ECMAScript5中的数组方法 #
ECMAScript5中数组方法概述：
大多数方法第一个参数接收一个函数，并且对数组中的每个元素调用一次该函数。对不存在的元素不调用该函数。大多数情况下，调用提供的函数使用三个参数：数组元素、元素的索引和数组本身，通常只需要使用第一个参数，忽略后面两个参数。
大多数ECMASscript数组方法第一个参数是一个函数，第二个参数可选。如果有第二个参数，则调用的函数被看成第二个参数的方法，即第二个参数可以在调用函数时将作为它的this关键字的值来使用，起到修改指针的作用。
### forEach() ###
array1.forEach(callbackfn[, thisArg])

| 参数        | 定义           | 
| ------------- |:-------------:| 
| array1      | 必需。 一个数组对象。| 
| callbackfn     | 必需。 一个接受最多三个参数的函数。 对于数组中的每个元素，forEach 都会调用 callbackfn 函数一次。     |  
| thisArg可选 |  可在 callbackfn 函数中为其引用 this 关键字的对象。 如果省略 thisArg，则 undefined 将用作 this 值。      |  

如果 callbackfn 参数不是函数对象，则将引发 TypeError 异常。

对于数组中的每个元素，forEach 方法都会调用 callbackfn 函数一次（采用升序索引顺序）。 不为数组中缺少的元素调用该回调函数。

除了数组对象之外，forEach 方法可由具有 length 属性且具有已按数字编制索引的属性名的任何对象使用。

### map() ###
map()方法将调用数组的每个元素传递给指定的函数，并返回一个数组，它包含该函数的返回值。
map()方法返回的是新数组，它不修改调用的数组；如果是稀疏数组，返回的也是相同方式的稀疏数组。它具有相同的长度，相同的缺失元素。
```javascript
a=[1,2,3];
b=a.map(function(x){
	return x*x;          //b是[1,4,9]    
})
```
### filter() ###
filter()方法创建并返回调用数组的一个子集。传递的函数时用来进行逻辑判定的，该函数返回true或false。
返回true的元素将被添加成为这个子集的成员。
```javascript
a=[1,2,3,4,5];
b=a.filter(function(x){
	return x>3
})                 //b是[4,5]
c=a.filter(function(x,i){
	return i%2==0；
})                 //c是[1,3,5]
```
### every()和some()方法 ###
所有：every()每个数组元素回调函数都返回true的时候才会返回true，当遇到false的时候终止执行，返回false；
```javascript
a=[1,2,3,4];
a.every(function(x){
	return x < 10;      //返回true
});
a.every(function(x){
	return x % 2 == 0;  //返回false,并非所有元素都能被2整除   
})
```
存在：some()
存在有一个数组元素的回调函数返回true的时候终止执行并返回true，否则返回false。
```javascript
a=[1,2,3,4];
a.some(function(x){
	return x % 2 == 0;  //返回true 
});
a.some(isNaN);    //false
```
### reduce()和reduceRight()方法 ###
遍历数组，调用回调函数，将数组元素组合成一个值
参数1：回调函数：把两个值合为一个
参数2：value，一个初始值，可选
reduce从索引最小值开始
reduceRight反向，方法有两个参数
```javascript
var a=new Array(1,2,3,4,5,6);
console.log(a.reduce(function(v1,v2){
   return v1+v2;
}));              // 21
console.log(a.reduceRight(function(v1,v2){
   return v1-v2;
},100));          // 79

```
### indexOf()lastIndexOf()方法 ###
用于查找数组内指定元素位置，查找到第一个后返回其索引，没有查找到返回-1，indexOf从头至尾搜索，lastIndexOf反向搜索。
```javascript
var a=new Array(1,2,3,3,2,1);
console.log(a.indexOf(2));     //1
console.log(a.lastIndexOf(2)); //4
console.log(a.IndexOf(4));     //-1，找不到
```