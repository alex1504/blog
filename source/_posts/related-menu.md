---
title: 省、市、区三级联动菜单Demo
date: 2016-06-08 17:12:19
categories: 前端
tags: [js,jQuery]
---
- 前端模拟数据，省略请求数据
- 封装成jQuery插件形式
- 省、市、区选择弹出浮层信息

核心代码：
```javascript
//初始化省
    function province(){
        $.each(areaJson, function(index, val) { 
             temp_option+="<option value="+val.p+">"+val.p+"</option>";
             oProvince.html(temp_option);
        });
    }

    //根据省赋值市
    function city(){
        temp_option=""+chooseC;
        var proIndex=oProvince.get(0).selectedIndex-1;
        if(proIndex>=0){
            $.each(areaJson[proIndex].c, function(index, val) {
                 temp_option+="<option value="+val.ct+">"+val.ct+"</option>";
                 oCity.html(temp_option);
                 oDis.html(chooseD);
            });
        }else{
            oCity.html(chooseC);
            oDis.html(chooseD);
        }
    }
    
    //赋值区|县
    function district(){
        temp_option=""+chooseD;
        var proIndex=oProvince.get(0).selectedIndex-1;
        var cityIndex=oCity.get(0).selectedIndex-1;
        if( proIndex>=0 && cityIndex>=0){
            if(typeof(areaJson[proIndex].c[cityIndex].d)!=="undefined"){
                $.each(areaJson[proIndex].c[cityIndex].d, function(index, val) {
                     temp_option+="<option value="+val.dt+">"+val.dt+"</option>";
                     oDis.html(temp_option);
                });
            }else{
                showInfo();
            }                   
        }else{
            oDis.html(chooseD);
        }
    }
    function showInfo(){
        var proIndex=oProvince.get(0).selectedIndex;
        var cityIndex=oCity.get(0).selectedIndex;
        var disIndex=oDis.get(0).selectedIndex;
        var p=oProvince.get(0).options[proIndex].value;
        var c=oCity.get(0).options[cityIndex].value;
        var d=disIndex>0?oDis.get(0).options[disIndex].value:"";
        oShow.css("display","block").find("p").html(p+c+d);
    }
    function closeInfo(){
        var btnClose=oShow.find(".btn-close");
        var btnOk=oShow.find("button").eq(0);
        var btnReset=oShow.find("button").eq(1);
        var btnArr=[btnClose,btnOk,btnReset];
        $.each(btnArr, function() {
             $(this).click(function() {
                oShow.css("display","none");
             });
        });
    }
    //调用初始化省
    province();
    //省发生变化改变市
    oProvince.change(function() {
        city();
    });
    //市发生变化改变区|县
    oCity.change(function() {
        district();
    });
    //区|县选择完后弹出浮层信息框
    oDis.change(function() {
        showInfo();
    });
```
