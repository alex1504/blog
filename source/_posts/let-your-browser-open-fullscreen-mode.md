---
title: Javascript开启浏览器全屏模式
date: 2016-11-04 23:38:01
categories: 前端
tags: [javascript]
---
通常在某些情况下，我们需要让浏览器开启全屏模式，以便获得更好的视觉体验，先看下全屏模式简单的几个API。

# 浏览器默认绑定
非全屏模式下， document的F11按键绑定开启全屏模式
全屏模式下， document的esc和F11 按键绑定关闭全屏模式

# 屏幕全屏模式改变事件
当成功进入全屏模式后， document会收到一个fullscreenchange 事件。 当退出全屏状态后， document又会收到fullscreenchange 事件。
```javascript
var screenChange = 'webkitfullscreenchange' || 'mozfullscreenchange' || 'fullscreenchange'
```

# 判断当前是否处于全屏状态
```javascript
var isFullScreen = document.fullScreen || document.mozFullScreen || document.webkitIsFullScreen;
```

# 开启全屏模式
```javascript
function launchFullScreen(element) {
    if (element.requestFullscreen) {
        element.requestFullscreen();
    } else if (element.mozRequestFullScreen) {
        element.mozRequestFullScreen();
    } else if (element.webkitRequestFullscreen) {
        element.webkitRequestFullscreen();
    } else if (element.msRequestFullscreen) {
        element.msRequestFullscreen();
    }
}
```
注意: **requestFullscreen是规范的书写模式（ s是小写）**， 但在Gecko内核中仍使用带前缀的大写模式mozRequestFullScreen。

# 关闭全屏模式
```javascript
function exitFullscreen() {
    if (document.exitFullscreen) {
        document.exitFullscreen();
    } else if (document.mozCancelFullScreen) {
        document.mozCancelFullScreen();
    } else if (document.webkitExitFullscreen) {
        document.webkitExitFullscreen();
}
```

# 全屏模式只能由手势触发
了解API后，假如我们监听window.onload事件执行launchFullScreen方法，Chrome浏览器会提示“开启全屏模式API只能由用户手势触发”。 
```javascript
"Failed to execute 'requestFullScreen' on 'Element': API can only be initiated by a user gesture."
```
原因是浏览器采用安全的机制， 将这种强制全屏模式意为“恶意行为”， **一切非用户主观意愿带来的变化都是不允许的**。

因此如果你的应用有全屏需求，有两种方案。
1.页面初始化给用户一个“F11开启全屏” 的提示， 并且在延迟几秒之后消失。
2.页面设置一个全屏按钮，单击全屏按钮进入全屏模式，并且隐藏按钮（视觉效果最佳）。

对于第二种方案，需要监听键盘事件：
```javascript
document.addEventListener("keydown", function(e) {
    var currKey = 0
    //在FireFox或Opera中，隐藏的变量e是存在的，那么e||event返回e，如果在IE中，隐藏变量e是不存在，则返回event。
    var e = e || event;  
    //IE中，只有keyCode属性，而FireFox中有which和charCode属性，Opera中有keyCode和which属性
    var currKey = e.keyCode || e.which || e.charCode;
    if (currKey == 112) {
        launchFullScreen();
    }
}, false);
```
具备了兼容各种浏览器按键模式的监听，但不知道**keycode**肿么办？你要的都在这里
## 字母和数字键的键码值(keyCode)
| 按键 | 键码 | 按键 | 键码 | 按键 | 键码 | 按键 | 键码 |
|:----:|------|------|------|------|------|------|------|
| A    | 65   | J    | 74   | S    | 83   | 1    | 49   |
| B    | 66   | K    | 75   | T    | 84   | 2    | 50   |
| C    | 67   | L    | 76   | U    | 85   | 3    | 51   |
| D    | 68   | M    | 77   | V    | 86   | 4    | 52   |
| E    | 69   | N    | 78   | W    | 87   | 5    | 53   |
| F    | 70   | O    | 79   | X    | 88   | 6    | 54   |
| G    | 71   | P    | 80   | Y    | 89   | 7    | 55   |
| H    | 72   | Q    | 81   | Z    | 90   | 8    | 56   |
| I    | 73   | R    | 82   | 0    | 48   | 9    | 57   |

## 数字键盘上的键的键码值(keyCode)
| 按键 | 键码 | 按键  | 键码 |
|:----:|------|-------|------|
| 0    | 96   | 8     | 104  |
| 1    | 97   | 9     | 105  |
| 2    | 98   | *     | 106  |
| 3    | 99   | +     | 107  |
| 4    | 100  | Enter | 108  |
| 5    | 101  | -     | 109  |
| 6    | 102  | .     | 110  |
| 7    | 103  | /     | 111  |

## 功能键键码值(keyCode)
| 按键 | 键码 | 按键 | 键码 |
|:----:|------|------|------|
| F1   | 112  | F7   | 118  |
| F2   | 113  | F8   | 119  |
| F3   | 114  | F9   | 120  |
| F4   | 115  | F10  | 121  |
| F5   | 116  | F11  | 122  |
| F6   | 117  | F12  | 123  |

## 控制键键码值(keyCode)
|    按键   | 键码 | 按键       | 键码 | 按键        | 键码 | 按键 | 键码 |
|:---------:|------|------------|------|-------------|------|------|------|
| BackSpace | 8    | Esc        | 27   | Right Arrow | 39   | -_   | 189  |
| Tab       | 9    | Spacebar   | 32   | Dw Arrow    | 40   | .>   | 190  |
| Clear     | 12   | Page Up    | 33   | Insert      | 45   | /?   | 191  |
| Enter     | 13   | Page Down  | 34   | Delete      | 46   | `~   | 192  |
| Shift     | 16   | End        | 35   | Num Lock    | 144  | [{   | 219  |
| Control   | 17   | Home       | 36   | ;:          | 186  | \    | 220  |
| Alt       | 18   | Left Arrow | 37   | =+          | 187  | ]}   | 221  |
| Cape Lock | 20   | Up Arrow   | 38   | ,<          | 188  | '"   | 222  |

# 避免使用非标准化的方法
非标准化的方法指的是进入草案前浏览器实现的一些方法，避免使用。
~~window.fullScreen(Firefox)~~
~~HTMLMediaElement.webkitDisplayingFullscreen~~
~~HTMLMediaElement.webkitEnterFullscreen~~
~~HTMLMediaElement.webkitExitFullscreen~~
~~HTMLMediaElement.webkitSupportsFullscreen~~