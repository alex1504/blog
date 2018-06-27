---
title: 移动端H5多页开发拍门砖经验
date: 2018-05-1 15:12:19
categories: 前端
tags: [移动端,H5,javascript]
---
![H5多页][https://segmentfault.com/img/remote/1460000015405042?w=800&h=600]
两年前刚接触移动端开发，刚开始比较疑惑，每次遇到问题都是到社区里提问或者吸取前辈的经验分享，感谢热衷于分享的开发者为前端社区带来欣欣向上的生命力。本文结合先前写的文章和开发经验分享给大家，希望也能帮助刚步入移动端开发的新人解惑。以下会以其中一个以**公积金页面**开发项目作为例子，介绍移动端的一些**常见问题**和使**用Vuejs作为lib进行多页开发**的经验。

# 移动端自适应布局
在项目中移动端最常用的自适应布局方案就是flexbox结合rem。规范的分栏式使用flexbox，其他大部分不规则视图使用rem，对于rem最常用的方案就是淘宝开源的[可伸缩布局方案](https://github.com/amfe/lib-flexible)。

根据设备设备像素比设置scale的值（scale = 1 / deviceRatio），这样可以**保持视口device-width始终等于设备物理像素**，接着根据屏幕大小动态计算根字体大小，具体是将屏幕划分为100等分，每份为a，1rem就等于10a。

## 标注
通常我们会拿到750宽的设计稿，这是基于iPhone6的物理分辨率。有的设计师也许会偷懒，设计图上面没有任何的标注，如果我们边开发边量尺寸，无疑效率是比较低的。要么让设计师标注上，要么自食其力。

如果设计师实在没有时间，推荐使用[markman](http://www.getmarkman.com/)进行标注，免费版阉割了一些功能（比如无法保存本地）不过基本满足了我们的需求了。

后来我发现比markman更好的标注工具[PxCook](http://www.fancynode.com.cn/pxcook)，该工具可以显示**PSD设计图**中的图层的样式代码，对于前端来说简直方便极了。

标注完成后开始写我们的样式，使用了淘宝的**lib-flexible**库之后，我们的根字体基准值就为750/100*10 = 75px。此时我们从图中若某个标注为100px，那么css中就应该设置为100/75 = 1.333333rem。所以为了提高开发效率，可以使用px转化为rem的插件。下面是sublimeText和Vscode的转换插件：

## px转rem插件
- sublimeText插件：[rem-unit](https://packagecontrol.io/packages/rem-unit)
![rem-unit](https://user-gold-cdn.xitu.io/2018/5/22/1638672eb1471718?w=400&h=150&f=gif&s=341881)

- Vscode插件： [cssrem](https://marketplace.visualstudio.com/items?itemName=cipchk.cssrem)
![pxtorem](https://user-gold-cdn.xitu.io/2018/5/22/1638672eb14e93b0?w=467&h=243&f=gif&s=260047)

## 使用rem的几点总结
- 在所有的单位中，font-size推荐使用px，然后结合媒体查询进行重要节点的控制，这样可以满足**突出或者弱化**某些字体的需求，而非整体调整。
- **众向的单位可以全部使用px，横向的使用rem**，因为移动设备宽度有限，而高度可以无限向下滑动。但这也有**特例**，比如对于一些活动注册页面，需要在一屏幕内完全显示，没有下拉，这时候所有众向或者横向都应该使用rem作为单位。如图：

![shili](https://user-gold-cdn.xitu.io/2018/5/22/16386a027d874cad?w=1280&h=1108&f=png&s=405886)

左图的表单高度单位由于下边空距较大，使用px在不同屏幕显示更加；而右边的活动注册页由于不能出现滚动条，所有的众向高度、margin、padding都应该使用rem。
- **border、box-shadow、border-radius**等一些效果应该使用px作为单位。

## 手机状态栏和浏览器导航栏的影响
之前发布的文章中，有个SF的前端小伙伴提出的问题：
文中作者有重点强调布局全部铺满，和下方与很多空隙的处理方案是不同的，在工作中我遇到这种情况，设计师的设计稿宽度为750×1334,但实际的展示高度并没有那么多，因为上方有导航栏还包括手机自己的状态栏展示，所以整体高度就达不到750，但是设计师设计稿是严格按照750进行设计的，这种情况下使用rem，严格按照设计师尺寸进行还原就会出现屏幕出现滚动条情况，请问针对这种情况您是怎么处理的？是从设计稿上规范，还是从开发上有相应的措施

依旧以我的分享界面为例：
展示高度不同通常发生在微信及浏览器端，因为前者没有地址栏和工具栏，这样显示高度通常会和设计师设计的视图吻合。那如果按照纯padding，margin即使全部使用rem，在浏览器端依旧会超出一屏高度，对于分享页面这种不是我们想要看到的。这时候就要做出取舍，我对**主体区域采用绝对定位**，这样上面间隙虽然小，不过仍能保持在一个屏幕高度显示。若采用margin padding在设置，必然已出现滚动条。当然这样的前提是依赖设计图的，通常设计师会为了空间感有保留一定的间隙，也不会将主要对象高度设的过高，否则太撑满也不好看，开发上如果设计图宽高没有在一定界限之内，超出也无法避免，不过我们这种分享界面通常是通过微信分享好友，通过浏览器打开的视图效果出现滚动条其实也不怎么影响不是么？
下面附上微信端和浏览器端的效果图：

微信端：![微信端](https://user-gold-cdn.xitu.io/2018/5/22/163869f629a7588e?w=640&h=1137&f=jpeg&s=200233)

浏览器端： ![浏览器端](https://user-gold-cdn.xitu.io/2018/5/22/163869f94a367bea?w=640&h=1137&f=jpeg&s=206900)

# Vuejs作为lib开发移动端页面

## 为何不使用SPA模式
一般移动端使用vue是为了数据交互频繁而且快速开发的页面，为什么不使用单页SPA开发模式，原因大概几点。
- 为了快速开发，快速上线
- 项目其他成员不熟悉SPA，不熟悉webpack
- 参与项目时项目已使用多页开发，短时间无法重构

抛开使用单页的架构，开发多页应用时，一个页面交互逻辑与一个Vue实例对应。

## 基于接口返回数据的属性注入
"基于接口返回数据的属性注入"是个人创建的话术，抛开此概念，先说一下表单数据的绑定方式。

### 表单的数据绑定
一个重要的点是**有几份表单就分开几个表单对象进行数据绑定**。

以上图公积金查询为例，由于不同城市会有不同的查询要素，可能登陆方式只有一种，也可能有几种。比如上图有三种登陆方式，在使用vue布局时，有两种方案。

- 1、 只建立一个表单用于数据绑定，点击按钮触发判断
- 2、有几种登陆方式建立几个表单，用一个字段标识当前显示的表单

由于使用第三方的接口，一开始也没有先进行接口返回数据结构的查看，采用了第一种错误的方式，错误一是每种登陆方式下面的登陆要素的数量也不同，错误二是数据绑定在同一个表单data下，当用户在用户名登陆方式输入用户名密码后，切换到客户号登陆方式，就会出现数据错乱的情况。

解决完布局问题后，我们需要根据设计图定义一些状态，比如当前登陆方式的切换、同意授权状态的切换、按钮是否可以点击的状态、是否处于请求中的状态。当然还有一些app穿过来的数据，这里就忽略了。
```javascript
 data: {
     tags: {
         arr: [''],
         activeIndex: 0
     },
     isAgreeProxy: true,
     isLoading: false
 }
```
接着审查一下接口返回的数据，推荐使用chrome插件postman，比如呼和浩特的登陆要素如下：
```javascript
{
    "code": 2005,
    "data": [
        {
            "name": "login_type",
            "label": "身份证号",
            "fields": [
                {
                    "name": "user_name",
                    "label": "身份证号",
                    "type": "text"
                },
                {
                    "name": "user_pass",
                    "label": "密码",
                    "type": "password"
                }
            ],
            "value": "1"
        },
        {
            "name": " login_type",
            "label": "公积金账号",
            "fields": [
                {
                    "name": "user_name",
                    "label": "公积金账号",
                    "type": "text"
                },
                {
                    "name": "user_pass",
                    "label": "密码",
                    "type": "password"
                }
            ],
            "value": "0"
        }
    ],
    "message": "登录要素请求成功"
}
```
可以看到呼和浩特有两种授权登陆方式，我们在data中定义了一个loginWays，初始为空数组，接着methods中定义一个请求接口的函数，里面就是基于返回数据的基础上为上面fields对象注入一个input字段用于绑定，这就是所谓的基于接口返回数据的属性注入。
```javascript
methods: {
    queryloginWays: function(channel_type, channel_code) {
        var params = new URLSearchParams();
        params.append('channel_type', channel_type);
        params.append('channel_code', channel_code);
        axios.post(this.loginParamsProxy, params)
            .then(function(res) {
                console.log(res);
                var code = res.code || res.data.code;
                var msg = res.message || res.data.message;
                var loginWays = res.data.data ? res.data.data : res.data;
                // 查询失败
                if (code != 2005) {
                    alert(msg);
                    return;
                }
                // 添加input字段用于v-model绑定
                loginWays.forEach(function(loginWay) {
                    loginWay.fields.forEach(function(field) {
                        field.input = '';
                    })
                })
                this.loginWays = loginWays;
                this.tags.arr = loginWays.map(function(loginWay) {
                    return loginWay.label;
                })
            }.bind(this))
    }
}
```
即使返回的数据有我们不需要的数据也没有关系，这样保证我们不会遗失进行下一步登陆所需要的数据。

这样多个表单绑定数据问题解决了，那么怎么进行页面间数据传递？如果是app传过来，那么通常使用URL拼接的方式，使用window.location.search获得queryString后再进行截取；如果通过页面套入javaWeb中，那么直接使用"${字段名}"就能获取，注意要js中获取java字段需要加双引号。
```javascript
computed: {
        // 真实姓名
        realName: function() {
            return this.getQueryVariable('name') || ''
        },
        // 身份证
        identity: function() {
            return parseInt(this.getQueryVariable('identity')) || ''
        },
        /*If javaWeb
        realName: function() {
            return this.getQueryVariable('name') || ''
        },
        identity: function() {
            return parseInt(this.getQueryVariable('identity')) || ''
        }*/
    },
    methods: {
        getQueryVariable: function(variable) {
            var query = window.location.search.substring(1);
            var vars = query.split('&');
            for (var i = 0; i < vars.length; i++) {
                var pair = vars[i].split('=');
                if (decodeURIComponent(pair[0]) == variable) {
                    return decodeURIComponent(pair[1]);
                }
            }
            console.log('Query variable %s not found', variable);
        }
    }
```

# 关于前端跨域调试
在进行接口请求时，我们的页面通常是在sublime的本地服务器或者vscode本地服务器预览，所以请求接口会遇到跨域的问题，如果使用Gulp进行打包，可以使用插件http-proxy-middleware，或者使用nginx。

## 使用Gulp

在项目构建的时候通常我们源代码会放在src文件夹下，然后使用gulp进行代码的压缩、合并、图片的优化（根据需要）等等，我们会使用gulp。

解决跨域的问题可以用[gulp-connect](https://www.npmjs.com/package/gulp-connect)结合[http-proxy-middleware](https://www.npmjs.com/package/http-proxy-middleware)，此时我们在gulp-connect中的本地服务器进行预览调试。

gulpfile.js如下： 开发过程使用`gulp server:dev`命令，监听文件改动并使用livereload刷新，并且代理src目录；使用`gulp`命令进行打包；使用`gulp server:dist`代理dist生产目录。
```javascript
var gulp = require('gulp');
var concat = require('gulp-concat');
var uglify = require('gulp-uglify');
var autoprefixer = require('gulp-autoprefixer');
var useref = require('gulp-useref');
var connect = require('gulp-connect');
var proxyMiddleware = require('http-proxy-middleware');

// 开发跨域代理  将localhost:8088/api 映射到 https://api.xxxxx.com/
gulp.task('server:dev', ['listen'], function() {
    var middleware = proxyMiddleware(['/api'], {
        target: 'https://api.xxxxx.com/',
        changeOrigin: true,
        pathRewrite: {
            '^/api': '/'
        }
    });
    connect.server({
        root: env == 'dev' ? './src' : './dist',
        port: 8088,
        livereload: true,
        middleware: function(connect, opt) {
            return [middleware]
        }

    });
});

// 打包后跨域代理
gulp.task('server:dist', ['listen'], function() {
    var middleware = proxyMiddleware(['/api'], {
        target: 'https://api.xxxxx.com/',
        changeOrigin: true,
        pathRewrite: {
            '^/api': '/'
        }
    });
    connect.server({
        root: './dist',
        port: 8088,
        livereload: true,
        middleware: function(connect, opt) {
            return [middleware]
        }

    });
});

gulp.task('html', function() {
    gulp.src('src/*.html')
        .pipe(useref())
        .pipe(gulp.dest('dist'));
});
gulp.task('css', function() {
    gulp.src('src/css/main.css')
        .pipe(concat('main.css'))
        .pipe(autoprefixer({
            browsers: ['last 2 versions'],
            cascade: false
        }))
        .pipe(gulp.dest('dist/css/'));

    gulp.src('src/css/share.css')
        .pipe(concat('share.css'))
        .pipe(autoprefixer({
            browsers: ['last 2 versions'],
            cascade: false
        }))
        .pipe(gulp.dest('dist/css/'));

    gulp.src('src/vendors/css/*.css')
        .pipe(concat('vendors.min.css'))
        .pipe(autoprefixer({
            browsers: ['last 2 versions'],
            cascade: false
        }))
        .pipe(gulp.dest('dist/vendors/css'));
    return gulp
});
gulp.task('js', function() {
    return gulp.src('src/vendors/js/*.js')
        .pipe(concat('vendors.min.js'))
        .pipe(uglify())
        .pipe(gulp.dest('dist/vendors/js'));
});
gulp.task('img', function() {
    gulp.src('src/imgs/*')
        .pipe(gulp.dest('dist/imgs'));
});
gulp.task('listen', function() {
    gulp.watch('./src/css/*.css', function() {
        gulp.src(['./src/css/*.css'])
            .pipe(connect.reload());
    });
    gulp.watch('./src/js/*.js', function() {
        gulp.src(['./src/js/*.js'])
            .pipe(connect.reload());
    });
    gulp.watch('./src/*.html', function() {
        gulp.src(['./src/*.html'])
            .pipe(connect.reload());
    });
});
gulp.task('default', ['html', 'css', 'js', 'img']);
```

## 使用nginx
在nginx配置使用proxy_pass，需要注意一点：
如果在proxy_pass后面的url加/，表示绝对根路径；如果没有/，表示相对路径，把匹配的路径部分也给代理走。
```
server {
	listen 80;
	server_name  localhost;
	root   [Your project root];
	index  index.html index.htm default.html default.htm;
	
    location ^~/api { 
      proxy_pass https://api.xxxxx.com/;
    } 
}
```

# 公众号网页的调试
如果你开发的H5基于微信jsSDK，你一定接触过微信授权域名，微信会将授权数据传给一个回调页面，而回调页面必须在你配置的域名下（含子域名）。比如我们获取用户的openid操作。而微信配置域名回去该域名根目录下检测一个`xxx_verify_xxx.txt`文件，确保该域名是属于你的。

所以要想在微信开发调试工具中获取openid，我们需要使用一种叫做内网穿透的工具。下面是自己比较常用的两个工具：
- [ngrok](https://ngrok.com/)
- [花生壳](https://hsk.oray.com/)

## ngrok
ngrok执行命令
```
ngrok -config ngrok.cfg start web
```
在ngrok.exe目录需要一个配置文件`ngrok.cfg`
以下是配置示例：
```
server_addr: "tunnel.cn:4443"
trust_host_root_certs: false
tunnels:
  web:
   subdomain: "xxx" 
   proto:
    http: 8086
    https: 8086
```
启动后xxx.tunnel.cn:4443会指向你本地的8086端口，将`xxx_verify_xxx.txt`文件放到8086端口根目录即可配置授权域名成功。

## 花生壳
花生壳免费版对于个人开通仅需6元，然后每月会提供给你1G的流量，免费版不支持80端口，最多支持两个域名，需要下载桌面客户端。

添加域名映射很简单，免费版无法配置自定义域名，由花生壳自动生成。
![花生壳](https://user-gold-cdn.xitu.io/2018/5/22/1638698584d70582?w=1692&h=685&f=png&s=57366)
配置成功后启动客户端可查看当前的状态

感谢阅读，欢迎任何形式的技术提问和交流！

> - 邮箱：me@huzerui.com
> - 主页：huzerui.com
> - 知乎：[晚风轻拂](https://www.zhihu.com/people/huzerui/activities)
> - 原文：[掘金](https://juejin.im/post/5b03b2ee5188254284525e87)


  [1]: //img.mukewang.com/5b33381a0001c12808000600.png
