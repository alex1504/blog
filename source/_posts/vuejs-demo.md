---
title: Vuejs2.0 Demo
date: 2017-02-04 15:12:19
categories: 前端
tags: [js,vuejs]
---
前段时间利用闲暇时间学习Vuejs并且做了一个实例，主要使用vue-router实现路由控制，vuex对程序进行状态管理，axios发送http请求。对数据在组件间的传递、webpack打包工具、数据的双向绑定有更深刻的了解和认识。
![预览图](http://qiniu.huzerui.com/image/2017-02-04-vue2.0-demo-poster.gif)

项目在线地址：http://www.huzerui.com/vue2.0-demo/
Github地址：https://github.com/alex1504/vue2.0-demo

扫描二维码预览：
![二维码地址](/img/post/2017-03-04-vuejs-demo-qrcode.png)

# 更新记录：
2017.1.13 主导航电影、音乐、图书、图片使用router跳转电影模块使用tab菜单切换各个列表模块下拉滚动加载图片模块使用flex布局实现瀑布流效果
2017.1.17 增加了电影详情模块，优化路由跳转
2017.1.18 增加了登录、登出模块，使用leancloud数据存储功能
2017.1.19 增加了图片详情模块，增加了新的生产依赖vue-touch
2017.2.6 新增用户注册模块

# 开发依赖：
```javascript
"babel-core": "^6.0.0",
"babel-loader": "^6.0.0",
"babel-preset-es2015": "^6.0.0",
"cross-env": "^3.0.0",
"css-loader": "^0.25.0",
"file-loader": "^0.9.0",
"mockjs": "^1.0.1-beta3",
"node-sass": "^4.2.0",
"sass": "^0.5.0",
"sass-loader": "^4.0.0",
"style-loader": "^0.13.1",
"vue-loader": "^10.0.0",
"vue-style-loader": "^1.0.0",
"vue-template-compiler": "^2.1.0",
"webpack": "^2.1.0-beta.25",
"webpack-dev-server": "^2.1.0-beta.9"
```
# 生产环境依赖：
```javascript
"axios": "^0.15.3",
"vue": "^2.1.0",
"vue-material": "^0.5.2",
"vue-router": "^2.1.1",
"vue-swipe": "^2.0.2",
"vue-touch": "^2.0.0-beta.3",
"vuex": "^2.1.1"
```

# 使用的接口：
[豆瓣电影图书接口](https://developers.douban.com/wiki/?title=api_v2)、gankio图片接口、网易云音乐专辑及搜索接口（见[components](https://github.com/alex1504/vue2.0-demo/tree/gh-pages/src/components)中请求部分）

# 说明：
- Vue-material中的spinner组件在某些浏览器无法正常显示，在chrome以及微信中体验效果较好。
- 由于众所周知的原因，Vue-material中的原生icon使用了阿里的[iconfont](http://www.iconfont.cn/)替代。（已经在许多歌项目使用，表示图标非常丰富，调用方式多样）
- 由于ithub访问速度原因，初次加载需稍等片刻。
- 登录及注册使用了Leancloud的后端云服务，关于如何使用你可以点[这里](https://leancloud.cn/docs/demo.html)查看LeanCloud搭建的各类应用演示。

# 关于使用Leancloud接口
细心的小伙伴应该会发现，使用LN接口必须使用AV.init对接口进行初始化，接收的参数是你的APPID和APPScret，也就是说即使我们的项目不开源，通过前端审查脚本也可以知道你的应用id及密钥，进而可以轻松调取你的接口做坏坏的事情。
为此如果你需要纯前后端分离的进行接口调用，LN给予的安全方案是配置web安全域名，也就是只有安全域名才能访问你的接口。
![安全域名](/img/post/2017-02-04-leancloud-web-security.png)
另外更稳妥的做法是传统开发APP的方式，将APPID和APPScret在后台代码中对接口进行初始化，前端就审查不到了，比如koa就可以单独为静态文件设置公开访问的静态目录，对于敏感数据文件可以设置存放在安全的前端无法访问的目录下面。
在有后端对接口实现复杂的逻辑封装的时候，推荐LN官方推出的[LeanEngine](https://leancloud.cn/docs/leanengine_overview.html)运行方案，有Nodejs、Pythod、PHP、Java四个版本。

# 感触：
1. MVVM三分天下，如果你希望一个轻巧、易上手、文档详尽的框架，选择[Vuejs](https://cn.vuejs.org/)
2. 如果你十分熟练jQuery的用法，在Vuejs中你很容易发现一些遗传着“经典”的足迹
3. 仔细发现，如果你学习过js设计模式，你会觉得Vuejs的设计很像其中一种模式——单例模式
4. 如果你需要做一个小型应用，不妨使用后端云服务（比如[LeanCloud](https://leancloud.cn/)、[Bomb](http://www.bmob.cn/)、[maxLeap](https://maxleap.cn/s/web/zh_cn/index.html)），既减少你的开发时间也减少开发成本；但大型的应用和数据敏感型的应用肯定是不推荐用别人的服务器的。
5. ES6还没完全支持，ES7就发布了，关于js逐渐融合各种语言优良特性不断发展的前景个人是十分看好的，毕竟js创始人Brendan Eich仅用几天时间就完成了它的设计。在开发过程中也确实因为js的某些缺陷增大了开发的代码量，不得不用一些设计模式去弥补。关于ES6、ES7的新特性，会在今后逐渐学习并记录。
6. 见过一些reactNative制作的应用，体验和原生APP无任何差别，有Vue Native么？不妨给它加层包装，叫做[weex](https://weex.incubator.apache.org/cn/)，后面也会慢慢地了解和学习。
