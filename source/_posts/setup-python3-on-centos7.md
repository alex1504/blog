---
title: 如何在CentOS7上安装Python3并设置本地编程环境
date: 2018-07-08 15:12:19
categories: 后端
tags: [python]
---
本文基于引用文章（见尾部）和个人搭建python3.7.0环境的过程进行总结和分享。

## 安装环境说明
- 主机：centos7
- 安装python版本：3.7.0

## 安装依赖环境
```
# yum -y install zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel gdbm-devel db4-devel libpcap-devel xz-devel libffi-devel
```
-y参数：自动选择，不弹出选择对话，默认yes

若不先安装依赖环境，在后面编译的步骤会报错缺少依赖，如：找不到zlib包
```
zipimport.ZipImportError: can't decompress data; zlib not available
```

注意：上面尾部的包libffi-devel，是python3.7版本的新依赖，若此包没安装，编译时会报错
```
ModuleNotFoundError: No module named '_ctypes'
```


## 获取python源文件
```
wget https://www.python.org/ftp/python/3.7.0/Python-3.7.0.tgz
```

## 解压缩
```
tar -zxvf Python-3.7.0.tgz
```

## 执行configure检测安装平台特征
./configure是用来检测你的安装平台的目标特征的。比如它会检测你是不是有CC或GCC，并不是需要CC或GCC，它是个shell脚本。

这一步一般用来生成 Makefile，为下一步的编译做准备

```
cd Python-3.7.0
./configure
```
不出意外，会提示
```
configure: error: no acceptable C compiler found in $PATH
```

原因是没有安装gcc，因为python是用C写的，所以需要用gcc进行编译，所以需要先安装gcc

```
# 顺道把c++编译器也安装了
yum install gcc gcc-c++   
```

## 再次执行./configure
几分钟之内发现一系列的checking日志被打出（觉得检测时间太久此步可忽略）：
```
checking linux/tipc.h presence... yes
checking for linux/tipc.h... yes
checking linux/random.h usability... yes
checking linux/random.h presence... yes
checking for linux/random.h... yes
checking spawn.h usability... yes
checking spawn.h presence... yes
checking for spawn.h... yes
checking util.h usability... no
checking util.h presence... no
checking for util.h... no
checking alloca.h usability... yes
checking alloca.h presence... yes
checking for alloca.h... yes
checking endian.h usability... yes     ....
```
ok，没有报错进入下一步编译

## 执行make进行编译，执行make install进行安装
```
# (注：make install足够的权限)
make && make install  
```

- make：编译，可能遇到的错误：make *** 没有指明目标并且找不到 makefile。 没有Makefile，解决方法是要先./configure 一下生成Makefile。

- make install：将程序安装至系统中。如果原始码编译无误，且执行结果正确，便可以把程序安装至系统预设的可执行文件存放路径。如果用bin_PROGRAMS宏的话，程序会被安装至/usr/local/bin这个目录。

查看是否安装成功：
```
python3 -V    // 输出 Python3.7.0
python -V     // 输出 python2.7.6
```

## 设置虚拟环境
成功安装python后，我们需要为python项目创建虚拟环境。

虚拟环境为Python项目创建一个隔离空间，确保每个项目都有自己的一组依赖项，这些依赖项不会破坏任何其他项目。

设置编程环境使我们能够更好地控制Python项目以及如何处理不同版本的包。在使用第三方软件包时，这一点尤为重要。

新建项目目录
```
cd ~
mkdir myproject
cd myproject
```
运行以下命令来创建独立环境：
```
python3 -m venv my_env
```

本质上，此命令创建一个新目录（在本例中称为my_env），其中包含我们可以使用以下ls命令查看的一些项：
```
bin  include  lib  lib64  pyvenv.cfg
```
到此为止，环境创建完成，要使用该虚拟环境，还需要执行激活虚拟环境命令
```
source my_env/bin/activate
```
可以看到linux操作提示符前缀变为
```
(my_env) [root@localhost myproject]# 
```

这个前缀让我们知道环境my_env当前是活动的，这意味着当我们在这里创建程序时，它们将只使用这个特定环境的设置和包。

注意：我们使用python3创建的虚拟环境，在虚拟环境类，我们的python版本默认为python3.7.0，退出虚拟环境后python默认版本仍为2.7版本。
```
(my_env) [root@localhost bin]# python -V   // 输出Python 3.7.0
```

```
[root@localhost ~]# python -V         // 输出Python 2.7.5
```

想退出python虚拟环境，只需执行deactivate命令
```
(my_env) [root@localhost myproject]# deactivate
```

> 原文链接：https://www.digitalocean.com/community/tutorials/how-to-install-python-3-and-set-up-a-local-programming-environment-on-centos-7
