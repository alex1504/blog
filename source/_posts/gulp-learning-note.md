---
title: Gulp前端自动化工具笔记
date: 2016-11-07 21:42:28
categories: 前端
tags: [gulp]
---
![gulp](http://huzerui.com/blog/img/post/2016-11-7-gulp-poster.jpg)
某个深夜独自在房间深造，在不断键盘敲击的“Alt+Tab”和“F5”许久，我开始疲惫了，于是从冰箱抡起一杯可乐。畅饮之余，去Google寻求仙人指路，仙人找到了nodejs为我指点了迷津，并递给我一杯可乐和吸管，原来“她”就在这里，她的名字叫“Gulp”。

她虽然只是一杯插着吸管的饮料，可却能在烈日炎炎的夏天舒缓你焦灼的身心，在寒冷的冬天给你雪中送炭似的温暖，给你不一样的编码体验。前端工程师，你想要的，“她”都懂的。

# 拾起一杯Gulp
gulpjs是一个前端构建工具，API简单，基于**任务流**，无需像Grunt复杂的配置。

## 安装
在安装了node.js的基础上使用命令行或git即可安装。
全局安装：
```javascript
$ npm install --global gulp
```
作为项目的**开发依赖安装（-dev）**，如果作为**项目依赖，则只需（--save）**
```javascript
$ npm install --save-dev gulp
```
## 根目录创建gulpfile.js
```javascript
var gulp = require('gulp');

gulp.task('default', function() {
  // 将你的默认的任务代码放在这
});
```

## 运行
如果省略了task参数，则gulp === gulp default
```javascript
gulp [task]?    //  []中存放参数，？参考js正则，代表可有可无
```

# 畅饮Gulp
在了解的Gulp的一些插件和基本使用方法之后，我开始构建自己的gulpfile.js，这个流程可以实现如下功能。
- 实时监听文件的变化，一旦保存浏览器自动刷新。
- 自动编译scss文件
- 合并样式文件、脚本文件
- 压缩样式文件、脚本文件、图片

```javascript
/*============================引入插件===============================*/
var gulp = require('gulp');
var plugins = require('gulp-load-plugins')({
	rename: {
		'gulp-ruby-sass': 'sass',
		'gulp-clean-css': 'cleancss'
	}
});
var browserSync = require('browser-sync').create();
var reload = browserSync.reload;

/*=============================发布任务==============================*/
gulp.task('html',function(){
	return gulp.src('src/*.html')
		.pipe(gulp.dest('dist/'));
});

gulp.task('css',function(){
	// var cssFilter = plugins.filter(['src/**/*.css', '!src/css/vendor'], {restore: true});
	return gulp.src('src/css/**/*.css')
		.pipe(plugins.cleancss())
		.pipe(gulp.dest('dist/css/'));
});

gulp.task('js',function(){
	// var jsFilter = plugins.filter(['src/**/*.js', '!src/js/vendor'], {restore: true});
	return gulp.src('src/**/*.js')
		.pipe(plugins.uglify())
		.pipe(gulp.dest('dist/'));
});
gulp.task('img',function(){
	gulp.src('src/img/*')
		.pipe(plugins.imagemin())
		.pipe(gulp.dest('dist/img'));
});

gulp.task('dist',['html', 'css', 'js' , 'img'], function(){
	return gulp.src(['src/res', 'src/mocks'])
		.pipe(gulp.dest('dist/'));

});
/*=============================合并任务==============================*/

gulp.task('bundle',function(){
	var vendor = {
		css: ['src/css/vendor/jquery.fullpage.css'],
		js: ['src/js/vendor/jquery.js','src/js/vendor/jquery.fullpage.js']
	};
	// 合并库css
	gulp.src(vendor.css)
		.pipe(plugins.concat('bundle.css'))
		.pipe(gulp.dest('src/css/vendor/'));

	// 合并库js
	gulp.src(vendor.js)
		.pipe(plugins.concat('bundle.js'))
		.pipe(gulp.dest('src/js/vendor/'));

});

/*=============================服务器任务==============================*/

// 静态服务器 + 监听 scss/html 文件
gulp.task('server', ['sass','bundle'], function() {
    browserSync.init({
        server: './src'
    });
    gulp.watch('src/scss/**/*.scss', ['sass']);
    gulp.watch('src/**/*.html', ['html']).on('change', reload);
    gulp.watch('src/js/**/*.js', ['js']).on('change', reload);
});

/*=============================编译任务==============================*/
gulp.task('sass', function() {
	// 编译库样式文件
	plugins.sass('src/scss/vendor/*.scss',{sourcemap: true})
    	.on('error', plugins.sass.logError)
    	.pipe(plugins.sourcemaps.write())
        .pipe(gulp.dest('src/css/vendor/'))
        .pipe(reload({stream: true}));
    // 编译项目样式文件    
    plugins.sass('src/scss/main.scss',{sourcemap: true})
    	.on('error', plugins.sass.logError)
    	.pipe(plugins.sourcemaps.write())
        .pipe(gulp.dest('src/css/'))
        .pipe(reload({stream: true}));
    return gulp;
});

/*=============================默认任务==============================*/
gulp.task('default', ['dist']);
```
## 插件介绍
**browserSync：**浏览器实时相应文件更改并进行重新加载
**gulp-load-plugins：**gulp插件加载工具，可对gulp插件进行重命名。当使用插件过多时可以有效管理和组织插件。
**gulp-ruby-sass：** sass编译工具，同时生成sourcemap方便调试
**gulp-clean-css：** 压缩css工具
**gulp-uglify：** 压缩js工具
**gulp-concat:**css、js合并工具
**gulp-imagemin：** 图片压缩工具

## 流程说明
- 在项目开发阶段，只存在src目录，所有开发均在src目录进行，直到项目开发完成，运行gulp命令则生成dist发布目录。
- 项目开发过程中执行gulp server命令，即可实施监听文件变动从而实现浏览器自动刷新。

**gulp server运行时，一旦文件重新保存,则触发以下任务：**

- scss-vendor文件夹中的样式文件会被编译并打包成bundle.css并输出到css-vendor
- js-vendor中的库文件会被打包成bundle.js并输出到js-vendor
- scss目录下同级的scss文件将被合并到main.scss文件中并被编译成main.css打包到css目录下面。

```javascript
-root
	-dist //发布目录，执行gulp默认任务生成
	-src
		-css
			vendor
				...
			main.css   
		-img 
		-js 
			vendor
			main.js
		-scss 
			vendor
				...
			main.scss 
			normalize.scss
		index.html
		...
```
# 品味Gulp
“老妈从她的房间里拿来**一堆作业**，让我在**我的房间**完成后放到**她的房间**，在此过程中，她会一直**监督**我看看我到底有没有偷懒，如果我偷懒了她就...”
- "一堆作业"：gulp.task()
- "我的房间": gulp.src()
- "她的房间": gulp.dist()
- "监督": gulp.watch()

怎么少了gulp.pipe()？
生活中我们每天都在搞事情，事情等同于任务，但这个任务中不同的环节是有依赖关系的，比如完成一幅画涂颜料需要在绘画完成后才能开始，于是gulp.pipe()相当于提供一个管道，让我们将这些环节连接起来，最终完成一个完整的任务。

## Gulp-API
以下为API介绍，[]中的参数为可选，options参数不太常用，故不作详细介绍。

### gulp.task(name[, deps], fn)
定义一个使用 Orchestrator 实现的任务（task）。
name: 任务的名字，如果你需要在命令行中运行你的某些任务，那么，请不要在名字中使用空格。
deps: 一个包含任务列表的数组，这些任务会在你当前任务运行之前完成。
```javascript
gulp.task('somename', function() {
  // 做一些事
});
```

### gulp.src(globs[, options])
输出（Emits）符合所提供的匹配模式（glob）或者匹配模式的数组（array of globs）的文件。 将返回一个 Vinyl files 的 stream 它可以被 piped 到别的插件中。
```javascript
gulp.src('client/templates/*.jade')
  .pipe(jade())
  .pipe(minify())
  .pipe(gulp.dest('build/minified_templates'));
```

### gulp.dest(path[, options])
能被 pipe 进来，并且将会写文件。并且重新输出（emits）所有数据，因此你可以将它 pipe 到多个文件夹。如果某文件夹不存在，将会自动创建它。
```javascript
gulp.src('./client/templates/*.jade')
  .pipe(jade())
  .pipe(gulp.dest('./build/templates'))
  .pipe(minify())
  .pipe(gulp.dest('./build/minified_templates'));
```

### gulp.watch(glob[, opts, cb])
```javascript
gulp.watch('js/**/*.js', function(event) {
  console.log('File ' + event.path + ' was ' + event.type + ', running tasks...');
});
```
## 关于glob参数匹配规则
发起一项任务需要寻找文件对象，这就需要一些规则用于匹配文件。
### 匹配规则
```javascript
*  匹配文件路径中的0个或多个字符，但不会匹配路径分隔符，除非路径分隔符出现在末尾
** 匹配路径中的0个或多个目录及其子目录,需要单独出现，即它左右不能有其他东西了。如果出现在末尾，也能匹配文件。
?  匹配文件路径中的一个字符(不会匹配路径分隔符)
[...] 匹配方括号中出现的字符中的任意一个，当方括号中第一个字符为^或!时，则表示不匹配方括号中出现的其他字符中的任意一个，类似js正则表达式中的用法
!(pattern|pattern|pattern) 匹配任何与括号中给定的任一模式都不匹配的
?(pattern|pattern|pattern) 匹配括号中给定的任一模式0次或1次，类似于js正则中的(pattern|pattern|pattern)?
+(pattern|pattern|pattern) 匹配括号中给定的任一模式至少1次，类似于js正则中的(pattern|pattern|pattern)+
*(pattern|pattern|pattern) 匹配括号中给定的任一模式0次或多次，类似于js正则中的(pattern|pattern|pattern)*
@(pattern|pattern|pattern) 匹配括号中给定的任一模式1次，类似于js正则中的(pattern|pattern|pattern)
```
**示例：**
```javascript
* 能匹配 a.js,x.y,abc,abc/,但不能匹配a/b.js
*.* 能匹配 a.js,style.css,a.b,x.y
*/*/*.js 能匹配 a/b/c.js,x/y/z.js,不能匹配a/b.js,a/b/c/d.js
** 能匹配 abc,a/b.js,a/b/c.js,x/y/z,x/y/z/a.b,能用来匹配所有的目录和文件
**/*.js 能匹配 foo.js,a/foo.js,a/b/foo.js,a/b/c/foo.js
a/**/z 能匹配 a/z,a/b/z,a/b/c/z,a/d/g/h/j/k/z
a/**b/z 能匹配 a/b/z,a/sb/z,但不能匹配a/x/sb/z,因为只有单**单独出现才能匹配多级目录
?.js 能匹配 a.js,b.js,c.js
a?? 能匹配 a.b,abc,但不能匹配ab/,因为它不会匹配路径分隔符
[xyz].js 只能匹配 x.js,y.js,z.js,不会匹配xy.js,xyz.js等,整个中括号只代表一个字符
[^xyz].js 能匹配 a.js,b.js,c.js等,不能匹配x.js,y.js,z.js
```
由上面可以看出gulp匹配的规则和正则大致相同。有一点要注意的是**\*\*匹配符号会深入所有的子目录里面**，而出现路径分割符只会进入**一级子目录**中寻找匹配文件。
### 匹配模式
匹配模式分为：**单一匹配、多种匹配、展开匹配**
#### 单一匹配
精确匹配：
```javascript
gulp.src("./js/main.js")
```
模糊匹配：
```javascript
gulp.src("**/*.js")
```
#### 多种匹配
当有多种匹配模式(多个单一匹配)时可以使用数组
```javascript
gulp.src(['js/*.js','css/*.css','*.html'])
```
使用数组的方式还有一个好处就是可以很方便的使用排除模式，在数组中的单个匹配模式前加上!即是排除模式，它会在匹配的结果中排除这个匹配，要注意一点的是不能在数组中的第一个元素中使用排除模式
```javascript
gulp.src([*.js,'!b*.js']) //匹配所有js文件，但排除掉以b开头的js文件
gulp.src(['!b*.js',*.js]) //不会排除任何文件，因为排除模式不能出现在数组的第一个元素中
```
#### 展开匹配
```javascript
a{b,c}d 会展开为 abd,acd
a{b,}c 会展开为 abc,ac
a{0..3}d 会展开为 a0d,a1d,a2d,a3d
a{b,c{d,e}f}g 会展开为 abg,acdfg,acefg
a{b,c}d{e,f}g 会展开为 abdeg,acdeg,abdeg,abdfg
```




