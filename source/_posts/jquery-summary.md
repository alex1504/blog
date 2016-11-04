---
title: jQuery核心总结
date: 2016-04-10 22:29:19
categories: 前端
tags: [jQuery]
---

![jQuery](http://huzerui.com/blog/img/post/2016-04-10-jquery-poster.jpg)
最近重温了《锋利的jQuery》这本书，受益匪浅。

**如果你和前端若只如初见，如果你和jQuery一见钟情，一纸文字铺满了你相恋的他（她）的所有。**

我把整理出来的知识点用网状图串联了起来，并且每个部分分点概述，将一些类似的方法和属性排列在一起。其实最重要的区块就是5个部分。

**根据用户交互的基本流程，通常代码是获取元素，然后绑定相应的事件，接着触发这个事件后可以选择不同的交互方式。**比如增加节点改变Dom，或者对某个元素设置动画、亦或者进行aJax与后台进行数据交互。

![知识点串联图](http://huzerui.com/blog/img/post/2016-04-10-jquery-knowledge-map.jpg)

# jQuery 选择器总结（继承CSS风格）# 
----------------------

## 常用的：标签、Id、class选择器、群组选择器、后代选择器、选择器（只有Id返回单个元素）## 

## 层次选择器 ## 

### 后代选择器 ### 
选取祖先所有的后代元素（后代包括孙、曾孙.....）     A  B

### 子元素选择器 ### 
选取父元素的子元素（不包括子元素的子元素）     A>B

### 后一个同辈元素 ### 
选取指定元素元素后一个同辈元素（集合）          A+B   等价于next（）方法

### 后面的所有同辈元素 ###  
选取指定元素后面的所有同辈元素（集合）  A~B  等价于nextAll（）方法

这里将siblings（）方法与next（）和nextAll（）作对比，

siblings（）是选取匹配元素前后所有同辈元素，与位置无关，结果不包含自己本身

## 过滤选择器 ## 
注意：在所有过滤选择其中，只有 :first和 :last和 :eq（index）返回单个元素，其他都返回集合元素

### 基本过滤选择器(index从0算起) ### 

#### 选择首元素 ####

```javascript
:first
```


#### 选择末尾元素 #### 
```javascript
last
```


#### 去除所有与给定选择器匹配的元素 ####   
```javascript
:not(selector)
```


#### 索引匹配 #### 
- 索引从0开始，选择索引是偶数的所有元素 
```javascript
:even //若匹配元素的子元素也匹配，也要计算在内
```
          

- 选择索引是奇数的所有元素 
```javascript
:odd
```

- index从0开始，选择索引等于index的元素 
```javascript
:eq(index)
```

- index从0开始，选择索引大于index的元素 
```javascript
:gt(index)     // gt是greater than的缩写
```
        
- index从0开始，选择索引小于index的元素 
```javascript
:lt(index)
```


#### 选取所有的标题元素 #### 
例如h1,h2,h3等   
```javascript
:header
```


#### 选取当前正在执行动画的函数 ####   
```javascript
:animated
```


#### 选取当前获取焦点的元素 ####         
```javascript
:forcus
```


### 内容过滤选择器 ###

3.21  选取文本内容中含有text的元素 
```javascript
:contain(text)
```


3.22  选取含有选择器所匹配的元素的元素   
```javascript
:has(selector)
```


3.23 选取含有子元素或者文本的元素       
```javascript
:parent  //将文本元素计算在内
```


3.24 选取不包含子元素或者文本的元素    
```javascript
:empty  //将文本元素计算在内
```


### 可见性过滤选择器 ###

#### 选取所有不可见元素 ####      
```javascript
:hidden    //包括display：none 和 visibility：hidden
```


#### 选取所有可见元素 ####        
```javascript
:visible
```


### 属性过滤选择器 ###

#### 选取拥有此属性的元素 ####      
```javascript
[attribute]
```


#### 选取属性值为value的元素 ####    
```javascript
[attribute=value]
```


#### 选取属性值不为value的元素 ####  
```javascript
[attribute!=value]
```


#### 选取属性值以value开始的元素 ####    
```javascript
[attribute^=value]
```


#### 选取属性值以value结束的元素 ####     
```javascript
[attribute$=value]
```


#### 选取属性值中含value的元素 ####         
```javascript
[attribute*=value]
```


#### 选取属性值等于value或者以value作为前缀（value后跟着连字符“-”）的元素 ####   
```javascript
[attribute|=value]
```


####  用属性选择器合并成复合选择器 ####     

 [attribute1][attribute]...

### 子元素过滤选择器（index从1算起）###

#### 选取每个父元素下的第index个子元素或者奇偶元素（index从1算起）####

```javascript
:nth-child(index,odd,even)
```
        //除了这三个参数，也可以写n的表达式，比如3n+1，n从1开始

####  选取每个父元素下的第一个子元素 ####    
```javascript
:first-child
```


####选取每个父元素下的最后一个子元素 ####  
```javascript
:last-child
```


**这里与基本过滤选择器的：first和：last做对比，：first和：last只返回单个元素，且不是针对子元素。**

####  选取某个元素是它父元素中的唯一的子元素 #### 
```javascript
:only-child
```


### 表单对象属性过滤选择器 ###

#### 选取所有可用元素 ####                                      
```javascript
：enabled
```


#### 选取所有不可用元素 ####                                    
```javascript
：disabled
```


#### 选取所有被选中的元素（单选框、复选框） ####    
```javascript
：checked
```


#### 选取所有被选中的选项元素（下拉列表中） ####    
```javascript
：selected
```


## 表单对象选择器 ## 

### 选取所有的input、textarea、select和button元素 ###
匹配表单内上述4种元素
```javascript 
$.('#form1:input')
````
只匹配input元素
```javascript 
$.('#form1 input')
````

### 匹配单行文本框 ###  
```javascript
:text
```


匹配所有密码框   
```javascript
:password
```


匹配所有的单选框  
```javascript
:radio
```


匹配所有的多选框    
```javascript
:checkbox
```


匹配所有的提交按钮   
```javascript
:submit
```


匹配所有的图像按钮 
 ```javascript
:image
```


匹配所有的重置按钮  
```javascript
:rest
```


匹配所有的按钮  
```javascript
:button
```


匹配所有的上传域  
```javascript
:file
```


匹配所有不可见元素  
```javascript
:hidden
```


# jQuery事件总结 # 
------------

## 加载Dom事件 ## 

$(window).load() 或 $(document).ready()

## 事件绑定 ## 

常用绑定方法   bind(type [,data] , fn )             //type类型有blue、focus、load、resize、scroll、unload、click、dbclick、mousedown、mouseup、mousemove、mouseover、mouseout、mouseenter、mouseleave、change、select、submit、keydown、keypress和error等

## 简写的事件 ## 

比如click，mouseover,和mouseout

## 合成事件 ## 

###  hover() 事件 ###
hover() 事件是mouseenter和mouseleave的合成事件
hover()和 mouseover、mouseout有区别。后者光标进入绑定元素的子元素时，会触发mouseout

###  toggle(fn1,fn2...) ###
用于模拟鼠标连续单击事件第一次触发fn1，第二次触发fn2。依次触发到最后一个，随后重复对这几个函数轮番调用

## 事件冒泡--阻止事件冒泡--事件对象 ## 
 
jQuery中不支持事件捕获，需要事件捕获应用js原生方法

### 阻止事件冒泡的方法 ###   
```javascript
bind(type,function(event)) {}  bind方法中传入event对象    //事件对象
```


并使用  event.stopPropagation()

### 阻止默认行为 ###    
```javascript
event.preventDefault()
```


###  两者都阻止 ###
在事件处理函数中return false即可

### 事件对象的属性 ###

获取事件的类型    
```javascript
event.type
```


阻止默认的事件行为  
```javascript
event.preventDefault()
```


阻止事件的冒泡行为  
```javascript
event.stopPropagation
```


获取触发事件的元素  
```javascript
event.target
```


获取光标相对于页面的x坐标和y坐标  
```javascript
event.pageX   和 event.pageY
```


获取鼠标单击事件（click)中鼠标的左、中、右键   event.which      //分别返回1、2、3

或者键盘事件中(keyup)的按键

## 移除事件 ## 
$.unbind( [type] [fn])


### 模拟操作 ### 
有时需要模拟用户操作来达到单击效果，例如在用户进入页面后，就触发click事件，而不需要用户主动单击。

```javascript
$.trigger(type，[data]) //触发绑定的事件，默认执行浏览器操作
```
      

```javascript
$.triggerHandler()  //  触发绑定的事件，而不执行浏览器默认操作
```
            
# jQueryDom总结 # 
-------------

## 基本操作--查找、创建、插入、删除、复制、替换、包裹（7种操作）## 

###  查找元素节点 ###    
jQuery选择器

### 查找属性节点 ###    
```javascript
$.attr()
```


### 创建元素节点  ### 
选择器的形式  
```javascript
$("html")
```

创建文本节点 (与元素节点一起创建)
```javascript
$("html")  //将文本包含在html中
```

创建属性节点(与元素节点一起创建) 
```javascript
$("html") //为元素添加属性
```
     
### 追加元素 ###
在每个匹配元素的内部追加内容    
```javascript
$.append()  或$.appendTo()
```


在每个匹配元素的内部前置内容   
```javascript
$.prepend()  或$.prependTo()
```


在每个匹配元素之后插入内容      
```javascript
$.after()        或$.insertAfter()
```


在每个匹配元素之前插入内容       
```javascript
$.before()    或$.insertBefore()
```


### 删除节点有三个方法 ###

```javascript
remove()、detach()、empty()  //empty()不是真正意义上的删除，只是清空节点内部内容
```             
remove()、detach()   

相同点：清除后会返回该节点的引用，即可以继续插入该节点到Dom

不同点：detach()会保留节点绑定的事件、附加的数据

### 复制节点 ### 
```javascript
$.clone（[true]）           //传入参数true可选，表示同时复制节点的绑定事件
```


### 替换节点 ### 
```javascript
$.replaceWith()     和$.replaceAll()   //前者A用B来替换   后者A替换所有的B
```


### 将匹配元素进行单独的包裹 ###

```javascript
$.wrap() //A用B来包裹
```
                  

### 将匹配元素用一个元素包裹 ###
```javascript
$.wrapAll 和 $.wrapInner
```


## 属性操作--获取与设置属性、删除属性 ## 

###  获取和设置属性 ###

 $.attr()   和    $.attr({ })

### 删除属性 ###    
```javascript
$.removeAttr()
```


## 样式操作--获取与设置样式、添加样式、删除样式、切换样式、判断是否含有某个样式 ## 

### 获取与设置样式 ###
其实就是用属性操作中的$.attr()方法获或设置class的值

### 追加样式 ###     
```javascript
$.addClass()            //设置是替换，追加是保留原来的class基础上增加
```


### 移除样式 ###

$.removeClass([class1] [class2]..)       //可以删除多个class，参数之间空格。无参数表示删除所有的class

### 切换样式 ###   
```javascript
$.toggleClass([class1] [class2].. )          //原来有传入的样式名，则删除；无则添加
```


### 判断元素是否有某个样式 ###    
```javascript
$.hasClass()        //有则返回true  无则返回false
```


## 文本操作--设置与获取HTML、文本和值 ## 

### 设置与获取HTML ###    
```javascript
$.html()
```


### 文本 ###                
```javascript
$.text()       //通常用于内容标签
```


### 值  ###                 
```javascript
$.val()         //通常用于文本框 、下拉列表、单选框、多选框等；如果元素为多选，则返回一个包含所有值得数组
```


## 遍历访问节点（常用于事件处理中）## 

### 获取匹配元素的所有子元素集合 ###          
```javascript
$.children()                 //与$.parent()相反
```


这里还有一个$.parents()的方法，获得每个匹配元素的祖先元素，与parent（）不同，获得第一个父节点时并没有停止查找，而是继续查找最后返回多个节点

另一个$.closet([匹配])与$.parent（）类似，不同的是closet()返回匹配元素的最近的一个父节点

### 取得匹配元素后面紧邻的同辈元素 ###         
```javascript
$.next()            后面紧邻所有   $.nextAll()
```


取得匹配元素前面紧邻的同辈元素
```javascript
$.prev()            前面紧邻所有   $.prevAll()
```


取得匹配元素前后所有的同辈元素         
```javascript
$.siblings()
```


### 在当前选中元素中找到符合条件的后代，返回的是子元素### 
```javascript
$.find()
```


### 在当前选中元素中找到符合条件的当前元素集合，返回的是当前元素 ###    
```javascript
$.filter()
```


### 对 jQuery 对象进行迭代，为每个匹配元素执行函数 ###                 
```javascript
$.each(function(){})
```


...省略的许多方法与jQuery选择器类似

## CSS-DOM操作 ## 

### 获取或设置元素的样式属性 ###   
```javascript
$.css()
```


### 获取或设置元素的宽度或高度 ###  
```javascript
$. width(value)和$.height(value)//  $. css("width")也可以获取元素宽度，但与元素的样式设置有关，可能获取到为auto；
```

而$.width()获取的是元素的实际宽度

### 关于元素定位常用的方法 ###

#### 获取元素在当前视窗的相对偏移 ####       
```javascript
$.offset().dir    //dir 可以为top right bottom left
```


#### 获取元素相对于最近一个position样式属性设置为relative或者absolute父节点的相对偏移 ####

```javascript
$.position().dir  //dir 可以为top right bottom left
```


#### 获取元素的滚动条（假如有的话，通常是那些设置了overflow：auto的元素，而内容过长）距离顶端或左侧的距离 ####    
```javascript
$.scrollTop()
```
```javascript 
$.scrollLeft()       //通常上下布局的页面document一般都会有滚动条，这时候使用  $(document).scrollTop()可以很方便获取滚动条里页面顶部的距离
```


# jQuery动画总结 # 
------------

## 基本动画    （速度参数 slow  normal  fast  自定义毫秒数）## 

```javascript
show()和hide()   //显示隐藏 两者组合 toggle()
```
                   

```javascript
fadeIn() 和 fadeOut() //淡入淡出两者组合 fadeToggle()
```
       
```javascript
slideDown() 和slideUp  //向下滑动显示  向上滑动隐藏两者组合 slideToggle()
```
       

## 自定义动画 ## 

```javascript
animate({ },speed,callback)  //实现累加累减动画只需在px前用+=或-=
```              

注意  :  css()方法并不会加入动画队列中，而会在动画开始就立即执行，要在动画执行完成后改变css样式，可以将css（）写入回调函数中

animate 同时进行的动画    只需传入多个键值对

animate 进行分步动画       只需按jQuery链式写法就好

## 停止正在进行的动画 ## 

```javascript
stop([clearQueue],[gotoEnd])     //默认情况下  clearQueue 接gotoEnd都是false
```
                   
要点：

- stop（）  停止当前正在进行的动画                //只阻止链式动画队列中当前运行的那一步动画

- stop（true，false）  停止当前的动画队列（正在进行+未进行，即链式动画队列）

使用情况：比如用户将光标移入某个元素，动画没结束就移出了。

- stop（true，true）  停止当前的动画队列，并让动画直接到达结束状态

使用情况： 通常用于后一个动画需要基于前一个动画的末状态的情况

## 判断元素是否处于动画状态（避免动画累计导致和用户的行为不一致）## 

*常用方法：
```javascript
if(! $(element).is(":animated")){

//如果当前没有进行动画，则添加新动画

}
```



## 延迟动画的方法 ## 
```javascript           
delay(毫秒)
```

# jQuery-aJax # 
---------------

说明：aJax仅做简要总结，更多可参考jQuery-aJax中文参考文档

## jQuery.aJax([setting])方法参数 ## 

type：类型， "POST"或“GET”，默认为“Get”

url：发送请求的地址

data：是一个对象，连同请求发送到服务器的数据

dataType： 预期服务器返回的数据类型。如果不指定，jQuery将自动根据HTTP包MIME信息来只能判断，一般采用json格式，可以设置为”json“

success：是一个方法，请求成功后的回调函数。传入返回后的数据，以及包含成功代码的字符串

error：是一个方法，请求失败时调用此函数。传入XMLHttpRequest对象










