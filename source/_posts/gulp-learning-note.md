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
