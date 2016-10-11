---
title: javascript中的call()和apply()方法
date: 2016-06-15 09:29:53
tags: [js]
---
我们知道函数调用有四种方式：**直接调用、作为对象的方法调用、构造函数调用、间接调用**。
而**call()和apply()就是间接调用函数的方法**。这两个方法都允许显示的指示调用上下文(this)的值，也就是说，任何函数可以作为任何对象的方法来调用，哪怕这个函数不是那个对象的方法。

假定有个函数f(),要想以对象o的方法来调用，可以这样使用call()和apply()
```javascript
f.call(o);
f.apply(o);
```
每行代码的功能类似于(假设对象o预先不存在名为m的属性)
```javascript 
o.m=f;       //将f存储为临时方法
o.m();       //调用
delete o.m;  //删除临时方法
```
## call() ##
语法：**call(thisObj, arg1, arg2 ...argN)** 
定义：**调用一个对象的一个方法，以另一个对象替换当前对象**。 
说明： 
1、call 方法可以用来代替另一个对象调用一个方法。
2、call 方法可将一个函数的对象上下文从初始的上下文改变为由 thisObj 指定的新对象。 
3、如果没有提供 thisObj 参数（或者传入null、undefined），那么 Global 对象被用作 thisObj；ES5严格模式则将默认为this的值。
4、arg1、arg2..是待传入调用函数的实参，以逗号分隔。

## apply() ##
语法：**apply(thisObj,argArray)** 
定义：**应用某一对象的一个方法，用另一个对象替换当前对象**。 
说明： 
1、如果 argArray 不是一个有效的数组或者不是 arguments 对象，那么将导致一个 TypeError。 
2、如果没有提供 argArray 和 thisObj 任何一个参数，那么 Global 对象将被用作 thisObj， 并且无法被传递任何参数。
3、argArray是待传入调用函数的参数组成的数组

### 关于apply()的奇淫巧计 ###
#### apply()用来求数组中最大元素 ####
由于Math.max()只能传入逗号分隔的参数，而apply()的第二个参数恰好可以传入数组或类数组元素。
```javascript
var bigest=Math.max.apply(Math, array_of_numbers)
```
#### Array.prototype.push 可以实现两个数组合并 ####
push方法没有提供push一个数组,但是它提供了push(param1,param,…paramN) 所以同样也可以通过apply来使用数组作为参数
```javascript
arr1=[1,2,3];
arr2=[4,5,6];
Array.prototype.push.apply(arr1,arr2);  
```
## 常用实例 ##
### 将某个对象的方法临时借给另一个对象调用 ###
```javascript
function Animal(){    
    this.name = "Animal";    
    this.showName = function(){    
        alert(this.name);    
    }    
}    
function Cat(){    
    this.name = "Cat";    
}    
var animal = new Animal();    
var cat = new Cat();    
//通过call或apply方法，将原本属于Animal对象的showName()方法交给对象cat来使用了。    
//输入结果为"Cat"    
animal.showName.call(cat,",");    
//animal.showName.apply(cat,[]);  
```
### 实现继承 ###
```javascript
function Animal(name){      
    this.name = name;      
    this.showName = function(){      
        alert(this.name);      
    }      
}      
function Cat(name){    
    Animal.call(this, name);      //将Anima函数临时作为this的方法进行调用，并且传入Cat方法的参数name
}           
var cat = new Cat("Black Cat");   //使用new调用Cat函数之后，this指向实例出来的对象cat；如果不使用new调用，则this指向全局对象。
cat.showName();       //"Black Cat"
```
### 多重继承 ###
```javascript
function Class1()  
{  
    this.showSub = function(a,b)  
    {  
        alert(a-b);  
    }  
};   
function Class2()  
{  
    this.showAdd = function(a,b)  
    {  
        alert(a+b);  
    }  
};   
function Class3()  
{  
    Class1.call(this);  
    Class2.call(this);  
};
var obj=new Class3();   //此时obj就多了showSub和showAdd的方法
```