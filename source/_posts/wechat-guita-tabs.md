---
title: 基于bmob后端云微信小程序开发
date: 2017-10-14 18:18:19
tags: [微信小程序]
categories: 前端
---
人的一生90%的时间都在做着无聊的事情，社会的发展使得我们的闲暇时间越来越多，我们把除了工作的其他时间放在各种娱乐活动上    。

程序员有点特殊，他们把敲代码看成娱乐活动的一部分，以此打发时间的不占少数。这不最近无聊搞了一个口袋吉他小程序，使用[bmob后端云](http://www.bmob.cn/)提供数据存储服务，除吉他谱图片，其他图片存储在[七牛](https://www.qiniu.com/)。

关于bmob小程序开发文档请戳[这里](https://docs.bmob.cn/data/wechatApp/a_faststart/doc/index.html)，文档详细简练，主要是缩短了开发周期，不过对于复杂的项目，还是推荐使用自己服务器提供数据服务。

# 使用微信扫描二维码预览
![qrcode](http://upload-images.jianshu.io/upload_images/1709462-a09843e9084bcd98.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
源码地址：[https://github.com/alex1504/wx-guita_tab](https://github.com/alex1504/wx-guita_tab)

下面分点分享下小程序的开发过程中的关键点及感受，说明：
1. 小程序标签统称组件，Html标签统称元素。
2. 部分内容会与vuejs及jQuery作对比

# 使用iconfont字体图标
新建项目并添加图标
![iconfont](http://upload-images.jianshu.io/upload_images/1709462-75640d57eb7658e8.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
在app.wxss中以unicode方式引入
```
@font-face {
  font-family: 'iconfont';  /* project id 431644 */
  src: url('//at.alicdn.com/t/font_431644_aahynh26y6lp7gb9.eot');
  src: url('//at.alicdn.com/t/font_431644_aahynh26y6lp7gb9.eot?#iefix') format('embedded-opentype'),
  url('//at.alicdn.com/t/font_431644_aahynh26y6lp7gb9.woff') format('woff'),
  url('//at.alicdn.com/t/font_431644_aahynh26y6lp7gb9.ttf') format('truetype'),
  url('//at.alicdn.com/t/font_431644_aahynh26y6lp7gb9.svg#iconfont') format('svg');
}
```
定义通用icon样式，定义伪元素
```css
.icon{
  display: inline-block;
  font-family: 'iconfont';
}
.icon-home::before{
  content: "\e600";
}
```
使用
```
<view class="icon icon-home"</view>
```


# 小程序事件绑定及处理器
小程序并没有类似vuejs的v-model进行双向绑定，使用bindinput类似jQuery监听input事件在事件处理器中更新数据，通过event对象e.data.value即可获得input的值。
```html
// bindconfirm监听键盘回车事件，focus属性聚焦渲染组件时会自动弹出手机软键盘
<input type='text' placeholder='歌曲名 / 歌手' bindinput='bindSearchInput' bindconfirm='onSearch' focus></input>
```
```javascript
bindSearchInput(e) {
  this.setData({
    searchTxt: e.detail.value
  })
}
```
小程序中的事件处理器并不能像vue一样传入参数，因为事件处理器只有一个默认的参数event对象，在for循环的组件中如果要想获取元素绑定的id，可以通过和jQuery相同的方式绑定data属性。
```
<!-- 轮播图 -->
<swiper indicator-dots="{{indicatorDots}}" autoplay="{{autoplay}}" interval="{{interval}}" duration="{{duration}}">
  <block wx:for="{{banner_list}}" wx:key="{{index}}">
    <swiper-item bindtap="navigateToDetail"  data-id="{{item.href}}">
      <image src="{{item.image}}" class="slide-image" mode="widthFix"></image>
    </swiper-item>
  </block>
</swiper>
```
获取id：
```javascript
//事件处理函数
navigateToDetail: function (e) {
  const id = e.currentTarget.dataset.id;
}
```
# 阻止事件冒泡
```
bindtap、bindlongtap、bindtouchstart、bindtouchmove、bindtouchend、bindtouchcancle
```
对应阻止冒泡事件将bind用catch替代


# setData
小程序的视图更新需要调用setData修改绑定数据，直接对数据进行修改是不会触发视图层更新的。setData接受一个对象，为需要添加或修改的属性。属性名有点特殊，[]中的值会被识别为变量，因此如果要对对象数组中的某个属性进行修改，只能预先拼接好属性名。
错误做法：
```javascript
// 视图不更新
this.data.searchSongs[index].love_flag': 2
// SyntaxError: unknown: Unexpected token
this.setData({
  'searchSongs[' + index + '].love_flag': 2
})
```
正确做法：
```javascript
setSongFlag(e) {
// 注意setData属性名[]中的非整数值会被识别为变量
let key = 'searchSongs[' + index + '].love_flag'
this.setData({
  [key]: 2
})
```
# 关于image组件
小程序wxss的background-image及image组件都不支持本地url
在H5的开发中，通常我们会将页面一些不需要根据容器大小来选择显示方式的图片使用img标签，需要一些特殊显示方式的使用background。但小程序只需要image组件便可。它提供的mode属性和背景定义图片及img元素控制图片显示方式对比

| mode属性 | background-size|  html img元素|
| --------   | -----:   |	 -----:   |	
| scaleToFill | 100%,100%(默认)      |  width:100%;height:100%      | 
| aspectFit | contain      |  js实现  | 
| aspectFill        | cover    |  js实现 |
| widthFix         | 100%, auto   |  width: 100%;|
其他的top、bottom、right、left等不缩放图片调整位置的属性与background-position作用相同，img元素则只能通过定位控制。

# 小程序API异步方案
如果没有强迫症，小程序API使用默认回调的方式即可；另外由于小程序只支持es6，不支持async及await，也可以将API封装成promise的方式，参考funnycoder的[这篇文章](http://wangyaxing.top/2017/09/01/wxapp/)。
```javascript
function promiseify(func) {
    return (args = {}) => {
        return new Promise((resolve, reject) => {
            func.call(wx, Object.assign(args, {
                success: resolve,
                fail: reject,
            }));
        })
    }
}
for (const key in wx) {
    if (Object.prototype.hasOwnProperty.call(wx, key) && typeof wx[key] === 'function') {
        wx[`_${key}`] = promiseify(wx[key]);
    }
}
```

# 小程序问题
- 调试器没有css快捷提示功能和颜色面板，影响布局及颜色调整效率（随性派）
- 无法引入第三方js库
- 内置组件单调，没有考虑字体数量比较多时的自适应情况
- 不支持跳转外部链接
- 背景图片或者image组件不能用本地图片

# 关于小程序审发布或更新
小程序上线需要经过审核、发布两个过程。
审核通过后有全量更新、或者分阶段发布，小程序才会更新，首次发布没有选项。

全量发布：即时向全量微信用户发布新版小程序。
分阶段发布：新版小程序将在15天内以开发者自定义比例，向微信用户发布更新
详情见知乎：[发布小程序时选择全量发布和分阶段发布是什么意思？](https://www.zhihu.com/question/65215216/answer/228639943)

不得不说小程序审核速度是非常快的，即便是个人申请（相比以企业账号申请会有应用服务类型限制），通常小程序没有涉及政策不允许的内容或者超过小程序允许的应用服务类型，都是可以顺利通过，初次体验，即便在国庆期间，也是有工作团队进行审核，审核时间通常在几小时内。

# 未完待续
一直关注着小程序，一直处于不愠不火的状态，但微信团队一直坚持在更新。从小程序的[历史更新日志](https://mp.weixin.qq.com/debug/wxadoc/dev/devtools/uplog.html)可以看到，无论是开发工具、基础库、与原生硬件交互API都在不断的更新或者修复异常bug，有时间希望做些与硬件交互更有趣的小程序和大家分享。

这个简易小程序将加入评论功能，用户系统功能、曲谱本地收藏、分享、改善图片加载、滑动位置保存等功能及问题，借此熟悉小程序开发以便做出更有趣的东西出来，因此本篇文章随开发过程持续更新。
希望这篇分享对你有所帮助，更希望能与同样热爱前端的你交流心得体会抑或工作经历、困扰等，欢迎知乎私信或邮件交流。

知乎：[https://www.zhihu.com/people/huzerui](https://www.zhihu.com/people/huzerui)
邮箱：me@huzerui.com