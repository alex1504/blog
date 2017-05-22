---
title: 常用的Lodash方法
date: 2017-01-22 22:39:31
tags: lodash
catergories: 前端
---
Lodash目前非常流行的JavaScript的工具集合框架，被前端开发者广泛地使用，下面是一些平常开发过程中常用的函数。

在介绍函数前，对lodash函数名应有如下的了解：
- 含sorted的方法接受有序数组
- 同名含By的方法额外接受一个迭代器参数
- 同名含Last的方法返回的是符合筛选条件元素的最后一个

## 对象扩展：
_.assign

```javascript
var foo = { a: "a property" };
var bar = { b: 4, c: "an other property" }

var result = _.assign({ a: "an old property" }, foo, bar);
// result => { a: 'a property', b: 4, c: 'an other property' }
```

## 防抖函数
_.debounce

在触发防抖函数的事件后面加个延迟时间，如果在该延迟时间内没有继续触发事件，那么执行防抖函数。设想一个场景，电梯门打开的时候，如果在2s内陆续有人按电梯按钮，那么每次电梯都会再重新等待2s，直至2s中没人按按钮再触发关门操作。
```javascript
function validateEmail() {
    // Validate email here and show error message if not valid
}

var emailInput = document.getElementById("email-field");
emailInput.addEventListener("keyup", _.debounce(validateEmail, 500));
```

## 迭代函数n次
- 返回：每次返回结果构成的数组
- 应用：生成大量测试数据

```javascript
function getRandomInteger() {
    return Math.round(Math.random() * 100);
}

var result = _.times(5, getRandomNumber);
// result => [64, 70, 29, 10, 23]
```

## 查找数组中的特定对象
接收多个对象属性查找
```javascript
var users = [
  { firstName: "John", lastName: "Doe", age: 28, gender: "male" },
  { firstName: "Jane", lastName: "Doe", age: 5, gender: "female" },
  { firstName: "Jim", lastName: "Carrey", age: 54, gender: "male" },
  { firstName: "Kate", lastName: "Winslet", age: 40, gender: "female" }
];

var user = _.find(users, { lastName: "Doe", gender: "male" });
// user -> { firstName: "John", lastName: "Doe", age: 28, gender: "male" }

var underAgeUser = _.find(users, function(user) {
	return user.age < 18;
});
// underAgeUser -> { firstName: "Jane", lastName: "Doe", age: 5, gender: "female" }
```

## 设置及获取对象属性
根据对象路径进行设置或获取

- _set方法：如果路径不存在，会自动创建路径。像下面的例子，使用该方法不会再出现“Cannot set property ‘items’ of undefined” error.”这种错误
- _get方法：如果对象路径不存在，返回undefined而不会报错，第三个参数接收默认值。

```javascript
var bar = { foo: { key: "foo" } };
_.set(bar, "foo.items[0]", "An item");
// bar => { foo: { key: "foo", items: ["An item"] } }
var name = _.get(bar, "name", "John Doe");
// name => John Doe
```

## 将对象数组重组成对象映射
- 只要服务器返回的是个集合对象，就可以通过该方法将集合转成对象映射
- 第二个参数也可以是函数，函数的第一个参数默认是数组中的一个对象

如从100篇文章中选取出id为34abc的文章，当获取到文章数组后，怎么做？
```javascript
var posts = [
    { id: "1abc", title: "First blog post", content: "..." },
    { id: "2abc", title: "Second blog post", content: "..." },
    // more blog posts
    { id: "34abc", title: "The blog post we want", content: "..." }
    // even more blog posts
];

posts = _.keyBy(posts, "id");

var post = posts["34abc"]
// post -> { id: "34abc", title: "The blog post we want", content: "..." }
```

## 遍历集合元素并返回特定格式的对象
- 通过 iteratee 遍历集合中的每个元素。 每次返回的值会作为下一次 iteratee 使用。 如果没有提供accumulator（第三个参数，即初始值），则集合中的第一个元素作为 accumulator。
- 常见的错误是忽略了返回结果(return result)和没有传入函数的第三个参数(默认值)

下面的例子从数组筛选符合年龄条件并由年龄进行分组的数据
```javascript
var users = [
    { name: "John", age: 30 },
    { name: "Jane", age: 28 },
    { name: "Bill", age: 65 },
    { name: "Emily", age: 17 },
    { name: "Jack", age: 30 }
]

var reducedUsers = _.reduce(users, function (result, user) {
    if(user.age >= 18 && user.age <= 59) {
        (result[user.age] || (result[user.age] = [])).push(user);
    }
  
    return result;
}, {});

// reducedUsers -> { 
//     28: [{ name: "Jane", age: 28 }], 
//     30: [{ name: "John", age: 30 }, { name: "Jack", age: 30 }] 
// }
```

## 深拷贝
_.cloneDeep()
```javascript
var original = { foo: "bar" };
var copy = original;
copy.foo = "new value";
// copy -> { foo: "new value" } Yeah!
// original -> { foo: "new value" } Oops!

var original = { foo: "bar" };
var copy = _.cloneDeep(original);
copy.foo = "new value";
// copy -> { foo: "new value" } Yeah!
// original -> { foo: "bar" } Yeah!
```

## 浅拷贝
_.clone()

对于对象内部的引用类型不会拷贝，而是指向同一个存在堆中的地址
```javascript
var objects = [{ 'a': 1 }, { 'b': 2 }];

var shallow = _.clone(objects);
console.log(shallow[0] === objects[0]);
// => true
```

## 数组去重
_uniq() 与 _. sortedUniq()
```javascript
var sortedArray = [1, 1, 2, 3, 3, 3, 5, 8, 8];
var result = _.sortedUniq(sortedArray);
// -> [1, 2, 3, 5, 8]
```

方法 | 说明
---|---
_.uniq | 数组去重
_.sortedUniq | 对于已排序的数组性能更高


## 向有序数组中插入元素，依旧保证有序
返回：插入元素在数组中的索引

方法：都含有sorted表示接受有序数组
- _.sortedIndex
- _.sortedIndexBy
- _.sortedLastIndex
- _.sortedLastIndexBy

含Last方法和不含Last方法的区别是：
Last方法在保持有序的前提下会把value插进最大的那个位置
```javascript
var objects = [{ 'x': 4 }, { 'x': 5 }];
 
_.sortedLastIndexBy(objects, { 'x': 4 }, function(o) { return o.x; });
// => 1
 
_.sortedLastIndexBy(objects, { 'x': 4 }, 'x');
// => 1
```

## 参考及延伸
> Lodash官方文档(4.17.4)：https://lodash.com/docs/4.17.4
> Lodash中文文档(3.10.1)：http://lodashjs.com/docs/
> Lodash/fp模块：https://github.com/lodash/lodash/wiki/FP-Guide
> 什么是Lodash/fp模块：http://www.cnblogs.com/legendlee/p/5601524.html
> Webpack按需打包lodash：http://www.tuicool.com/articles/niyeMrN