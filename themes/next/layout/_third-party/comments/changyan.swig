{% if theme.changyan.enable and theme.changyan.appid and theme.changyan.appkey %}
  {% if is_home() %}
    <script id="cy_cmt_num" defer src="https://changyan.sohu.com/upload/plugins/plugins.list.count.js?clientId={{theme.changyan.appid}}"></script>
  {% else %}
    <script type="text/javascript">
    (function(){
      var appid = '{{theme.changyan.appid}}';
      var conf = '{{theme.changyan.appkey}}';
      var width = window.innerWidth || documentgit .documentElement.clientWidth;
      if (width < 960) {
      window.document.write('<script id="changyan_mobile_js" defer charset="utf-8" type="text/javascript" src="https://changyan.sohu.com/upload/mobile/wap-js/changyan_mobile.js?client_id=' + appid + '&conf=' + conf + '"><\/script>'); } else { var loadJs=function(d,a){var c=document.getElementsByTagName("head")[0]||document.head||document.documentElement;var b=document.createElement("script");b.setAttribute("type","text/javascript");b.setAttribute("charset","UTF-8");b.setAttribute("src",d);b.setAttribute("defer","1");if(typeof a==="function"){if(window.attachEvent){b.onreadystatechange=function(){var e=b.readyState;if(e==="loaded"||e==="complete"){b.onreadystatechange=null;a()}}}else{b.onload=a}}c.appendChild(b)};loadJs("https://changyan.sohu.com/upload/changyan.js",function(){
        window.changyan.api.config({appid:appid,conf:conf})});
      }
    })();
    </script>
    <script type="text/javascript" defer src="https://assets.changyan.sohu.com/upload/plugins/plugins.count.js"></script>
  {% endif %}
{% endif %}
