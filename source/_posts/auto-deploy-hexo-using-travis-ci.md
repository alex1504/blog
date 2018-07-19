---
title: 使用Travis CI自动部署Hexo【转载修订版】
date: 2018-07-19 15:06:19
categories: 前端
tags: [Hexo,TravisCI,自动化部署]
---

## 什么是Travis CI
Travis CI 是目前新兴的开源持续集成构建项目，它与jenkins，GO的很明显的特别在于采用yaml格式，同时他是在在线的服务，不像jenkins需要你本地打架服务器，简洁清新独树一帜。目前大多数的github项目都已经移入到Travis CI的构建队列中，据说Travis CI每天运行超过4000次完整构建。对于做开源项目或者github的使用者，如果你的项目还没有加入Travis CI构建队列，那么我真的想对你说out了。

## Hexo
我的博客是使用Hexo来搭建的，托管到Github提供的GithubPage服务上的
每次写完博客git push到github，然后Travis自动构建，构建完成后自动推送到Gitpage服务上
生成后的HTML文件和博客的源文件我是放到一个仓库的，只是使用了不同的分支
master：博客的静态文件，也就是hexo生成后的HTML文件，我把GithubPage服务定义在master分支，这在后台可以修改
![enter image description here](http://7qnc6h.com1.z0.glb.clouddn.com/mdbs462v6bm4pphrayjr9u36dp.png)

而blog-source分支保存的是我的博客源代码

![enter image description here](http://7qnc6h.com1.z0.glb.clouddn.com/103fmyn6887rda4snck0iiso9w.png)

当然这样做有隐私问题，因为任何人都能哪的你的博客源码，当然既然是博客，所以就没有这些问题了

## 启用要构建的项目
首先如果你要使用Travis CI，你必须要GIthub账号（好像Travis CI只支持构建github的项目）和一个项目

使用Github账号登录Travis CI官网，如下图
![enter image description here](http://7qnc6h.com1.z0.glb.clouddn.com/i58ol9sq6si3s6bhmbm858e86k.png)


登录完后会进入如下界面

![enter image description here](http://7qnc6h.com1.z0.glb.clouddn.com/spqw1qkvkozxsgklnb8xq7h8pk.png)

当然如果你以前没用使用过，所以你登录完是没有上图红框内的内容的，这里是因为我在写这篇博客前已经使用了，所以会有这些内容

接下来我们点击My Repositories旁边的+，意思是添加一个要自动构建的仓库，如下图：
![enter image description here](http://7qnc6h.com1.z0.glb.clouddn.com/x1n4nsusznfxna03gcp439xoe0.png)


点击后就会来到如下界面：

![enter image description here](http://7qnc6h.com1.z0.glb.clouddn.com/u7krkfr4gzc40cqz4higd1x1ai.png)

可以看到这个界面会显示当前github账号的所以项目，如果没有显示，点击右上角的“Sync account”按钮，就可以同步过来了（ps：上次用windows电脑始终同步不过来项目，最后换成mac可以同步了，最后又换回windows也可以了，汗(⊙﹏⊙)b，不太懂，什么个情况）

居然仓库都同步过来了，那么下一步肯定是要开启你需要构建的仓库，可以看到我开启了lifengsofts.github.io这个项目，当然这个也是我就是我的博客啦
![enter image description here](http://7qnc6h.com1.z0.glb.clouddn.com/eayug7kt8dkot47whznauxs8um.png)


开启后我们还需要进行一些配置，操作如下
![enter image description here](http://7qnc6h.com1.z0.glb.clouddn.com/9wh810z4nckma9tdcj3kvuslwh.png)


点击红框的那个菜单按钮，就会出现这样的下拉菜单，我们选择设置，来到这个界面，我们按照如下勾选
![enter image description here](http://7qnc6h.com1.z0.glb.clouddn.com/4f9p4cx4kotj4l0qi42kunq257.png)


Build only if .travis.yml is present：是只有在.travis.yml文件中配置的分支改变了才构建 
Build pushes：当推送完这个分支后开始构建

到这一步， 我们已经开启了要构建的仓库，但是还有个问题就是，构建完后，我们怎么将生成的文件推送到github上呢，如果不能推送那我们就不需要倒腾一番来使用Travis CI服务了，我们要的结果就是，我们只要想github一push，他就自动构建并push静态文件到gitpages呢，那么下面要解决的就是Travis CI怎么访问github了

在Travis CI配置Github的Access Token
标题已经说得很明白了吧，我们需要在Travis上配置Access Token，这样我们就可以在他构建完后自动push到gitpgaes了，到这里肯定有人要问了，咋你把用户名密码直接写文件里呢，如果你真有这样的问题，那我只能说呵呵~，但我要告诉你的是写里面肯定是可以push成功的

在github上生成Access Token
首先我们来到github的设置界面，点击到Personal access tokens页面，点击右上角的Generate new token按钮会重新生成一个，点击后他会叫你输入密码，然后来到如下界面，给他去一个名字，下面是勾选一些权限
![enter image description here](http://7qnc6h.com1.z0.glb.clouddn.com/somyqjl13rhbm2zjgg47hlu3an.png)

![enter image description here](http://7qnc6h.com1.z0.glb.clouddn.com/somyqjl13rhbm2zjgg47hlu3an.png)
生成完后，你需要拷贝下来，只有这时候他才显示，下载进来为了安全他就不会显示了，如果忘了只能重新生成一个了，拷贝完以后我们需要到Travis CI网站配置下

## Travis CI配置
配置界面还是在项目的setting里面，如下图

![enter image description here](http://7qnc6h.com1.z0.glb.clouddn.com/asl8qurxkanst1uus1wc1opxk1.png)

至于为什么我们要在这里配置，我想大家肯定应该明白了，写在程序里不安全，配置到这里相当于一个环境变量，我们在构建的时候就可以引用他。 
到这里我已经配置了要构建的仓库和要访问的Token，但是问题来了，他知道怎么构建，怎么生成静态文件吗，怎么push的gitpages，又push到那个仓库吗，所以这里我们还需要在源代码的仓库里创建一个.travis.yml配置文件，放到源代码的根目录，如下图
![enter image description here](http://7qnc6h.com1.z0.glb.clouddn.com/z2wwfwluzv6ajgx6qwbjtlf2yb.png)


其中内容如下：

```yml
language: node_js  #设置语言

node_js: stable  #设置相应的版本

cache:
    apt: true
    directories:
        - node_modules # 缓存不经常更改的内容

install:
  - npm install  #安装hexo及插件

script:
  - hexo clean  #清除
  - hexo g  #生成

after_script:
  - cd ./public
  - git init
  - git config --global user.name "alex1504"  #修改name
  - git config --global user.email "alex1504@163.com"  #修改email
  - git add ./
  - git commit -m "update"
  - git push --force --quiet "https://${Travis_Token}@${GH_REF}" blog-source:master  #GH_TOKEN是在Travis中配置token的名称

branches:
  only:
    - blog-source #只监测blog-source分支，blog-source是我的博客源码分支的名称，可根据自己情况设置
env:
  global:
    - GH_REF: github.com/alex1504/blog.git  #设置GH_REF，注意更改yourname
```


其中给你需要更换的又git config后面的配置信息 
GH_REF的值更改为你的仓库地址

到这一步我们配置已经完成了，现在就是见证奇迹的时候了

## Push文章到Github
commit文章到源码分支发现travisCI后台执行自动部署程序
![enter image description here](http://7qnc6h.com1.z0.glb.clouddn.com/kjt11qm44i49r81r763w4tmym0.png)

然后访问网站就能看到自己的新文章了，至此，你可以在github在线修改或者新增文章，几分钟后网站就重新部署了，似乎静态博客有点接近动态博客的味道了呢...

> 原文地址：https://blog.csdn.net/woblog/article/details/51319364
