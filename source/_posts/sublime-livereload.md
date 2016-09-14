---
title: SublimeText配置LiveReload
date: 2016-09-13 20:21:47
tags: [sublime]
---
无需node.js，解放键盘F5，在sublime中配置LiveReload

# 1、安装浏览器插件
安装浏览器扩展程序LiveReload插件，chrome下需勾选允许访问文件网址，否则无法启动服务。
![plugin](http://7xrw48.com1.z0.glb.clouddn.com/images/2016/9/13/chrome-plugin.jpg/w640)
![tick-enable](http://7xrw48.com1.z0.glb.clouddn.com/images/2016/9/13/tick-enable.jpg/w640)
# 2、SublimeText中安装LiveReload插件并配置
![sublime-setting](http://7xrw48.com1.z0.glb.clouddn.com/images/2016/9/13/sublime.jpg/w640)
将下面的配置同时粘贴到Setting-Default 及 Setting-User下即可
```javascript
{
    "enabled_plugins": [
        "SimpleReloadPlugin",
        "SimpleRefresh"
    ]
}
```
