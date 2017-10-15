---
title: 关于Blob、FileReader、FormData的那些事
date: 2017-07-05 15:12:19
categories: 前端
tags: [Blob,FileReader,FormData]
---
# Blob对象是什么
从[MDN](https://developer.mozilla.org/zh-CN/docs/Web/API/Blob)上有这样一段描述：
> 一个 Blob对象表示一个不可变的, 原始数据的**类似文件对象**。Blob表示的数据不一定是一个JavaScript原生格式。 File 接口基于Blob，继承 blob功能并将其扩展为支持用户系统上的文件。

引用中的关键词是保存着原始数据的类似文件的对象，所谓类似文件的对象可以理解为这种对象本身不是文件，但可以从原始数据解析出文件数据。

既然要解析，就需要知道Blob对象的类型，所以创建Blob的时候第二个参数就是配置项，我们可以配置所有[MIME类型](https://developer.mozilla.org/zh-CN/docs/Web/HTTP/Basics_of_HTTP/MIME_types)，比如将配置项的type制定为'text/xml'，'text/plain'，'text/css'等，Blob构造函数语法如下（参考MDN）：
```javascript
var aBlob = new Blob( array, options );
```
- array 是一个由ArrayBuffer, ArrayBufferView, Blob, DOMString 等对象构成的 Array ，或者其他类似对象的混合体，它将会被放进 Blob.
- options 是一个可选的Blob熟悉字典，它可能会指定如下两种属性：
   - type，默认值为 ""，它代表了将会被放入到blob中的数组内容的MIME类型。
   - endings，默认值为"transparent"，它代表包含行结束符\n的字符串如何被输出。 它是以下两个值中的一个： "native"，代表行结束符会被更改为适合宿主操作系统文件系统的惯例，或者 "transparent", 代表会保持blob中保存的结束符不变 

Blob创建出来，那JS种如何读取或者说从原始数据解析出文件数据呢？从Blob中读取内容的唯一方法是使用[FileReader](https://developer.mozilla.org/zh-CN/docs/Web/API/FileReader)。

# FileReader对象
故名思议，FileReader对象用于读取文件数据，所谓的文件数据其实就是Blob对象和File对象（因为File对象继承于Blob对象）。
由于文件的读取时间基于文件的大小，所以FileReader读取的过程为设计为异步，如下：
```javascript
var fileReader = new FileReader();
FileReader.addEventListener('onload', function(e){
	// 读取的数据保存在fileReader实例的result属性
	var data = e.target.result
	// Todo...
})
fileReader.readAsDataURL(file)
```
这个过程跟预加载图片的过程相同，**生成实例->监听->开始加载**，上面的例子以读取文件为例，使用readAsDataURL的方法，FileRader还有三种读取为其他数据类型的方法：

方法名 | 参数| 描述 |
---- | --- | --- |
readAsBinaryString| file |将文件读取为二进制编码
readAsBinaryArray | file | 将文件读取为二进制数组
readAsText|  file[, encoding] |  按照格式将文件读取为文本，encode默认为UTF-8
readAsDataURL | file| 将文件读取为DataUrl

另外还有一个abort方法用于阻止文件读取

我们知道Image对象读取图像的事件有onload、onerror、onabort，而FileReader除了这三个事件，还新增了三个对过程的监听事件，onloadstart、onprogress、onloadend，但实际上新增的事件使用的并不多，主要用于大文件读取时进度条实现的需求上。	

在onprogress的事件处理器中，有一个ProgressEvent对象，这个事件对象实际上继承了Event对象，提供了三个只读属性：
- lengthComputable
- loaded  （已读取的字节数）  
- - total   （总字节数）  

其中事件的lengthComputable属性代表文件总大小是否可知。如果 lengthComputable 属性的值是 false，那么意味着总字节数是未知并且 total 的值为零。

看到这些是否感觉似曾相识，“蓦然回首，那人却在灯火阑珊处”。没错，使用ajax上传文件的时候也有同样的事件钩子，[XMLHttpRequest Level 2](https://en.wikipedia.org/wiki/XMLHttpRequest)中，xhr的progress事件用于异步请求进度的监听，上传的进度事件绑定在xhr的upload属性中，在异步上传文件时我们可以这样监听进度：

```javascript
var xhr = new XMLHttpRequest();
xhr.upload.onprogress = function(e) {
    if (e.lengthComputable) {
        var percentComplete = (e.loaded / e.total) * 100;
        $progress.css('width', percentComplete + '%');
    }
};
```
同样地，我们只需要为onprogress事件添加处理器就获取文件读取的进度。
```javascript
function progressHandler(e) {
    var percentLoaded = Math.round((e.loaded / e.total) * 100);
    $progress.css('width', percentLoaded + '%');
}
```
FileReader和文件密不可分，既然说到文件上传，就再说一下多文件上传、拖拽上传

# FormData与文件上传
## 多文件上传
```javascript
var fileInput = document.getElementById("myFile");
var files = fileInput.files;
var formData = new FormData();

for(var i = 0; i < files.length; i++) {
    var file = files[i];
    formData.append('files[]', file, file.name);
    xhr.open("POST", "/upload.php");

	xhr.onload = function(){
	    if(this.status === 200){
	        //对请求成功的处理
	    }
	}
	// 如果要监听进度
	xhr.upload.onprogress = progressHandler
	
	xhr.send(formData);
	xhr = null;
}
```
这是将所有的文件发送一次异步请求，而我们监听的进度也是所有文件上传的总进度，如果我们需要单独监听单个文件的上传进度，只需改成递归的方式依次发送请求。
```javascript
var fileInput = document.getElementById("myFile");
var files = fileInput.files;
var i = 0;

var uploadFile = function(){
	var formData = new FormData();
	formData.append(files[i]);

	xhr.open("POST", "/upload.php");

	xhr.onload = function(){
	    if(this.status === 200){
			//进行下一次请求
	        i++;
	        if(i != files.length){
			    uploadFile()
			}  
	    }
	}
	// 如果要监听进度
	xhr.upload.onprogress = progressHandler
	
	xhr.send(formData);
	xhr = null;

}

```
## 拖拽上传
拖拽上传只需了解HTML5基本的拖拽事件即可，参考MDN的[HTML 拖放 API](https://developer.mozilla.org/zh-CN/docs/Web/API/HTML_Drag_and_Drop_API)。
- drag : 元素被拖拽时由**拖拽元素**频繁触发的事件
- dragstart : 拖拽时开始时由**拖拽元素**触发的事件
- dragend : 拖拽结束时触发由**拖拽元素**的事件
- dragover : 当拖拽元素进入放置区域时由**放置元素**频繁触发的事件(每隔几百毫秒就会触发一次)
- dragenter : 当拖拽元素进入放置区域时由**放置元素**触发的事件
- dragleave : 当拖拽元素离开放置区域时由**放置元素**触发的事件
- drop : 当拖拽元素在放置区域放置时由**放置元素**触发的事件

**持续触发的事件**：drag和dragover
**发生在拖拽元素的事件**：drag、dragstart、dragend
**发生在放置元素的事件**：dragover 、dragenter 、dragleave、drop 
**事件触发次序：**dragstart -> drag -> dragenter -> dragover -> dragleave -> drop -> dragend

当我们拖放文件到浏览器中时，浏览器默认的行为是浏览器将当前页面重定向到被拖拽元素所指向的资源上，因此需要阻止dragenter、dragover、drop的默认行为，这样才能使drop事件被触发。（最好同时阻止冒泡）

```javascript
var dropArea;

dropArea = document.getElementById("dropArea");
dropArea.addEventListener("dragenter", handleDragenter, false);
dropArea.addEventListener("dragover", handleDragover, false);
dropArea.addEventListener("drop", handleDrop, false);

function handleDragenter(e) {
	/*若要兼容ie
	window.event? window.event.cancelBubble = true : e.stopPropagation();
	window.event? window.event.returnValue = false : e.preventDefault();*/
    e.stopPropagation();
    e.preventDefault();
}

function handleDragover(e) {
    e.stopPropagation();
    e.preventDefault();
}

function handleDrop(e) {
    e.stopPropagation();
    e.preventDefault();

    var dt = e.dataTransfer;
    var files = dt.files;

    // FileReader将图片读取为dataUrl并立刻展示..省略
}
```

值得注意的是：触发dragstart事件后，其他元素的mousemove、mouseover、mouseenter、mouseleaver、mouseout事件均不会被触发。

上面拖拽回调中的事件对象，继承自 MouseEvent 对象，它的[dataTransfer](https://developer.mozilla.org/zh-CN/docs/Web/API/DataTransfer)属性保存着拖拽对象的相关信息。

DataTransfer对象有几个重要的属性，其中files属性保存文件的数据。
effectAllowed 和 dropEffect 最主要的作用是，用于配置拖拽操作过程中鼠标指针的类型以便提示用户后续可执行怎样的操作；其次的作用是，控制 drop 事件的触发与否。当显示禁止的指针样式时，将无法触发目标元素的 drop 事件。

注意：只能在dragstart中设置effectAllowed，只能在dragover中设置dropEffect 

拖拽后通过FileReader读取立刻显示图片优化体验，因为用户可能需要确定是否更换图片，然后单击按钮才将图片，这样可以防止不必要的请求，接下来就是上文提到的FormData上传文件，这里不再赘述。
