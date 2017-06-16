---
title: 关于异步函数的回调问题
date: 2017-03-30 11:37:43
categories: 前端
tags: [js,es6]
---
我们在项目中经常需要根据异步请求结果进行相关操作，以往常用的方法是callback，但现在如果结合babel编译，用promise或者async会更加优雅。如下是错误的做法：

```javascript
// 异步之后进行相关操作的错误做法
function asyncFun(){
	var flag = false;
	$.ajax({
		url: 'https://api.github.com/',
		type: 'get'
	}).done(function(res){
		if(res.code == 1){
			flag = true
		}
	})
	return flag;    // 这里始终返回false，因为异步请求不阻塞后面代码执行
}
if(asyncFun()){
	// 由于flag始终为false，很明显这里永远不会执行
}
```
解决方案有三种：传统回调方式，ES5Promise对象，ES6 async/await方式

# 回调函数方式
```javascript
// 定义一个异步函数
function asyncFun(cb){
	$.ajax({
		url: 'https://api.github.com/',
		type: 'get'
	}).done(function(res){
		cb && cb(res)
	})
}
asyncFun(function(res){
	// 根据异步请求返回的结果进行相关操作
	if(res.code == 1){

	}
})
```
# 使用ES6引入的promise对象
```javascript
function asyncFun(){
	return new Promise(function(resolve, reject){
		$.ajax({
			url: 'https://api.github.com/',
			type: 'get'
		}).done(function(res){
			resolve(res)
		})
	})
}

asyncFun().then(function(res){
	if(res.code == 1){
		// 你要进行相关的操作
	}
})
```
如果后面的操作不只一次，你可以定义多个返回Promise对象的函数，像这样
```javascript
function asyncFun2(res){
	// 这里可以获取asyncFun传过来的res
	return new Promise(function(resolve, reject){
		$.ajax({
			url: 'https://api.github.com/',
			type: 'get'
		}).done(function(res2){
			resolve(res2)
		})
	})
}
function asyncFun3(res2){
	// 这里可以获取asyncFun2传过来的res2
	return new Promise(function(resolve, reject){
		$.ajax({
			url: 'https://api.github.com/',
			type: 'get'
		}).done(function(res3){
			resolve(res3)
		})
	})
}
asyncFun().then(asyncFun2).then(asyncFun3)
```
说明：
- 这种写法十分类似jQuery的链式写法，只要返回**Promise对象，就拥有then()及catch()**方法，后者用于捕捉回调运行时发生的错误。
- Promise构造函数接受一个函数作为参数，该函数的两个参数分别是resolve方法和reject方法。如果异步操作成功，则用resolve方法将Promise对象的状态变为“成功”（即从**pending变为resolved**）；如果异步操作失败，则用reject方法将状态变为“失败”（即从**pending变为rejected**）
- then方法其实有两个参数，**第一个参数**作为上一步操作**resolve时的回调函数**，如果上一步操作后**状态变为rejected**，则以**第二个参数作为回调函数**

# 使用ES7关键字async/await——异步终极解决方案

ES7 中有了更加标准的解决方案，新增了**async/await**两个关键词，async可以声明一个异步函数，此函数需要返回一个 Promise对象。await 可以等待一个 Promise 对象 resolve，并拿到结果。
现在要实现上面的需求，可以这样：

基本规则
- async 表示这是一个async函数，await只能用在这个函数里面。
- await 表示在这里等待promise返回结果了，再继续执行。
- await 后面跟着的应该是一个promise对象（当然，其他返回值也没关系，只是会立即执行，不过那样就没有意义）

```javascript
function getData(){
	return new Promise(function(resolve,reject){
		$.ajax({
			url: 'https://api.github.com/',
			type: 'get'
		}).done(function(res){
			resolve(res)
		})
	})
}

async function asyncFun(){
	var res = await getData();
	if(res.code == 1){
		//进行相关操作
	}
}
```

# 使用async/await捕获异常
这里说下捕获异步操作中的异常问题，既然then不用写，那么catch也可以不用了，可以直接用标准的try/catch语法捕捉错误。

常犯的错误是使用try/catch捕获异步函数的异常，这时候因为try/catch块执行完了，异步函数很可能还没有完成，异常还没有被实际抛出。当异常被抛出的时候，由于catch块已经执行完了，此时就会导致进程崩溃。如下：
```javascript
// 错误的示例
function getData(){
	$.ajax({
		url: 'https://api.github.com/',
		type: 'get'
	}).done(function(){
		// 模拟异常
		null();
	})
}
try{
	getData();
	console.log('我会被打印');
}catch(e){
	console.log('error')
}
// '我会被打印'
// undefined
// Uncaught TypeError: null is not a function
```

可以看到异步请求中的异常无法被正常捕获,'error'并没有被打印出来，console.log('我会被打印')仍然执行了，使用async/await可以很容易解决这个问题

```javascript
function getData(){
	return new Promise(function(resolve,reject){
		$.ajax({
			url: 'https://api.github.com/',
			type: 'get'
		}).done(function(){
			// 模拟异常
			reject('error')
		})
	})
}
async function asyncFun(){
	try{
		await getData();
		// 这里以下的代码不被执行
		console.log('我不会被打印');
	}catch(err){
		console.log(err);
	}
}
async();       // Promise{}
			   // error
```

# 总结：
1. 从回调到promise再到async/await解决步式操作需求的问题，可以看到代码易读性明显增强了，async/await不仅去除了嵌套问题，也不用再用链式写法的then了。
2. async/await只是一套语法糖，其他语言的async/await可能是协程或者多线程编程的语法糖，JS本身是单线程的，async/await与传统的callback或者promise执行起来并无两样
3. ES7 async/await仍未成标准，最新版谷歌已经支持，但大部分浏览器仍没有实现，要使用它可以用babel编译成浏览器支持的ES5。




