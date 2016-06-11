---
title: 解决Github无法正常显示的问题
date: 2016-04-06 13:06:19
tags: [github]
---
昨天使用Github上传文件后发现在浏览器打开github的主页只有简单的HTML格式，并没有加载css样式和图片，点击F12开发者工具查看console面板发现github的cdn被屏蔽了，伟大的防火长城[GFW](http://baike.baidu.com/link?url=K5hKCK0JXZaB2sbZSQN7uJk1LPECi6MuvZdwlhFmO0RFsEtZKUQ0miDa8fcw2gUukDNjVFVVb8IyGhf_yCgwtWF3fS7_GoJCYfLipn4VMQqKzzQ0C93IwLIBJ9a6WkYvwW8xsfokPjaC8ySBeJz-Ya)（Great Firewall of China）又再次GithubCDN节点进行封闭。
![GFW](http://7xrw48.com1.z0.glb.clouddn.com/@/images/2016/4/6/1.jpg?imageView2/2/w/640/q/75)

下面通过修改hosts文件的方法解决问题，当然也可以选择每次访问github时使用vpn进行翻墙，不过要想一劳永逸，还是前面一种方法比较好，主要是修改hosts文件让访问被墙的资源时不使用cdn地址，而直接解析到github主机的ip处，只需两步即可完成。

**步骤一：打开[站长工具](http://tool.chinaz.com/)搜索上图图中三个（其余的重复）域名对应的ip地址。如图所示：**
![IPSearch](http://7xrw48.com1.z0.glb.clouddn.com/@/images/2016/4/6/2.jpg?imageView2/2/w/640/q/75)
![IPSearch](http://7xrw48.com1.z0.glb.clouddn.com/@/images/2016/4/6/3.jpg?imageView2/2/w/640/q/75)
**步骤二：找到C:\Windows\System32\drivers\etc路径下（通常Windows xp/2003/vista/2008/7/8都是在此目录）hosts文件，复制一份到桌面，然后用文本编辑器进行编辑，我使用sublimetext为域名添加映射，即我们查询后的IP，然后保存将其替换原来的hosts文件即可。**
![enter image description here](http://7xrw48.com1.z0.glb.clouddn.com/@/images/2016/4/6/4.jpg?imageView2/2/w/640/q/75)
![enter image description here](http://7xrw48.com1.z0.glb.clouddn.com/@/images/2016/4/6/5.jpg?imageView2/2/w/640/q/75)