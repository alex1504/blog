---
title: ajax请求数据（后台PHP）
date: 2016-05-25 15:12:19
tags: [js,ajax]
---
表单数据提交
--------

核心方法：serialize（）：可以将表单中的数据序列化成key=value&key=value...的形式
核心代码：
```javascript
    $("#test").submit(function() {
        $.ajax({
            type: "POST",
            url:"form.php",
            data:$('#test').serialize(),// 你的formid
            success: function(data) {
                $("#res").html(data);
            }，
            error: function(request) {
                alert("Connection error");
            }
        });
            return false;                   // 阻止表单默认提交事件，防止页面跳转
    });
```
PHP获取数据的方式
--------------------------

ajax中data可以提交的数据方式：
**普通键值对的方式**：PHP后台可以通过_POST['键名']或 _GET['键名']获取数据
```javascript
    $.ajax({
		url: 'test2.php',
		type: 'POST',
		data: {"姓名": '张三',"年龄":14},       //等价于"姓名=张三&年龄=14",属于传入基本键值对
		success: function(data){
			$("#content").html(data);
		},
		error:function() {
			alert("connection fail");	
		}
    });
```
**json字符串的方式**（需要制定contentType）：后台通过file_get_contents('php://input')获取数据
```javascript
    $.ajax({
        type: "POST",
        url:"test1.php",	
        **contentType:"application/json;charset=utf-8"**,
        data: JSON.stringify(json),
        error: function(request) {
            alert("Connection error");
        },
        success: function(data) {
        	$("#container").html(data);
        }
    });                
```
PHP输出json字符串数据
----------------

在PHP中比较常用的是数组，而PHP中json不是标准数据格式，所以PHP提供了对json数据进行编码和解码的函数。

 - **json_encode($arr)**:将数组转化为json数据格式（json字符串）
 - **json_decode(json)**:将json解析成PHP对象，通常会添加第二个参数true，此时会解析成PHP数组

```php
	<?php
    	header("Content-type:text/html;charset=utf-8");
    	$arr = array('姓名' => '张三', '年龄' => '14', '性别' => '男');
    	$res =json_encode($arr) ;            
    	//当使用php自带的json_encode对数据进行编码时，中文都会变成unicode，导致不可读。如：对字符串”厦门“进行json_encode后，输出的是"\u53a6\u95e8"。经测试前端通过JSON.parse()解析出json对象后乱码消失
        echo($res);
	?>
```

