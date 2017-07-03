---
title: vuejs开发H5页面总结
date: 2017-07-03 15:12:19
categories: 前端
tags: [vuejs]
---
最近参与了APP内嵌H5页面的开发，这次使用vuejs替代了以外的jQuery，仅仅把vuejs当做一个库来使用，效率提高之外代码可读性更强，再次分享一下自己的一些开发经验。

# 关于布局方案
当拿到设计师给的UI设计图，前端的首要任务就是布局和样式，相信这对于大部分前端工程师来说已经不是什么难题了。移动端的布局相对PC较为简单，关键在于**对不同设备的适配**。之前介绍了一篇关于移动端[rem布局方案](http://www.huzerui.com/blog/2016/06/16/mobile-rem/)，这大致是网易H5的适配方案。不过实践中发现淘宝开源的[可伸缩布局方案](https://github.com/amfe/lib-flexible)效果更好且更容易使用。

网易云的方案总结为：根据**屏幕大小 / 750 = 所求字体 / 基准字体大小**比值相等，动态调节html的font-size大小。

淘宝的方案总结为：根据设备设备像素比设置scale的值，保持视口device-width始终等于设备物理像素，接着根据屏幕大小动态计算根字体大小，具体是将屏幕划分为10等分，每份为a，1rem就等于10a。

通常我们会拿到750宽的设计稿，这是基于iPhone6的物理分辨率。有的设计师也许会偷懒，设计图上面没有任何的标注，如果我们边开发边量尺寸，无疑效率是比较低的。要么让设计师 标注上，要么自食其力。科技技术是第一生产力，而技术衍生了工具，工具提升了效率。如果设计师实在没有时间，推荐使用[markman](http://www.getmarkman.com/)，免费版阉割了一些功能（比如无法保存）不过基本满足了我们的需求了。

布局完成后开始写我们的样式，使用了淘宝的lib-flexible库之后，我们的根字体基准值就为750/100*10 = 75px。此时我们从图中量的某个宽度加入为100px，那么css中就应该设置为100/75 = 1.333333rem。所以为了提高开发效率，可以使用px转化为rem的插件。如果你使用sublimeText，可以用 [rem-unit](https://packagecontrol.io/packages/rem-unit)
![rem-unit](http://qiniu.huzerui.com/image/2017-07-03-rem-unit.gif)
如果你用vscode编辑器，推荐 [cssrem](https://marketplace.visualstudio.com/items?itemName=cipchk.cssrem)
![pxtorem](http://qiniu.huzerui.com/image/2017-07-03-css-to-rem.gif)

使用rem单位注意以下几点：
1. 在所有的单位中，font-size推荐使用px，然后结合媒体查询进行重要节点的控制，这样可以满足突出或者弱化某些字体的需求，而非整体调整
2. 众向的单位可以全部使用px，横向的使用rem，因为移动设备宽度有限，而高度可以无限向下滑动。但这也有特例，比如对于一些活动注册页面，需要在一屏幕内完全显示，没有下拉，这时候所有众向或者横向都应该使用rem作为单位。如图：
![rem-desc](http://qiniu.huzerui.com/image/2017-07-03-rem-description.jpg)
左图的表单高度单位由于下边空距较大，使用px在不同屏幕显示更加；而右边的活动注册页由于不能出现滚动条，所有的众向高度、margin、padding都应该使用rem。
3. border、box-shadow、border-radius等一些效果应该使用px作为单位。

# 基于接口返回数据的属性注入
可能大家不明白什么叫"基于接口返回数据的属性注入"，在此之前，先说一下表单数据的绑定方式，一个重要的点是**有几份表单就分开几个表单对象进行数据绑定**。

已上图公积金查询为例，由于不同城市会有不同的查询要素，可能登陆方式只有一种，也可能有几种。比如上图有三种登陆方式，在使用vue布局时，有两种方案。一是只建立一个表单用于数据绑定，点击按钮触发判断；而是有几种登陆方式建立几个表单，用一个字段标识当前显示的表单。由于使用第三方的接口，一开始也没有先进行接口返回数据结构的查看，采用了第一种错误的方式，错误一是每种登陆方式下面的登陆要素的数量也不同，错误二是数据绑定在同一个表单data下，当用户在用户名登陆方式输入用户名密码后，切换到客户号，就会出现数据错乱的情况。

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
首先我们整理一下首先我们需要得到接口返回的数据，比如呼和浩特的登陆要素如下：
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
可以看到有两种登陆方式，然后我在data中定义了一个loginWays，初始为空数组，接着method有个查询登陆要素的函数，里面就是基于返回数据的基础上为上面fields对象注入一个input用于绑定，这就是所谓的基于接口返回数据的循环注入。
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

这样多个表单绑定数据问题也解决了，还有页面间数据传递的方式，如果是app传过来，那么通常使用URL拼接的方式，使用window.location.search获得queryString后再进行截取；如果通过页面套入javaWeb中，那么直接使用"${字段名}"就能获取，注意要js获取控制器传来字段需要加双引号。
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
在进行接口请求时，我们的页面通常是在sublime的本地服务器或者vscode本地服务器预览，所以请求接口会遇到跨域的问题。
在项目构建的时候通常我们源代码会放在src文件夹下，然后使用gulp进行代码的压缩、合并、图片的优化（根据需要）等等，我们会使用gulp。这里解决跨域的问题可以用[gulp-connect](https://www.npmjs.com/package/gulp-connect)结合[http-proxy-middleware](https://www.npmjs.com/package/http-proxy-middleware)。
gulpfile.js如下： 开发过程使用gulp server命令，监听文件改动并使用liveReload刷新；使用gulp命令进行打包。
```javascript
var gulp = require('gulp');
var concat = require('gulp-concat');
var uglify = require('gulp-uglify');
var autoprefixer = require('gulp-autoprefixer');
var useref = require('gulp-useref');
var connect = require('gulp-connect');
var proxyMiddleware = require('http-proxy-middleware');

// 定义环境变量，若为 dev，则代理src目录； 若为prod，则代理dist目录
var env = 'prod'

// 跨域代理  将localhost:8088/api 映射到 https://api.shujumohe.com/
gulp.task('server', ['listen'], function() {
    var middleware = proxyMiddleware(['/api'], {
        target: 'https://api.shujumohe.com/',
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