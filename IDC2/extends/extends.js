/*
** basic extends for sudy
 */
function runJs(a){var b=document.createElement("script");b.type="text/javascript",b.text=a;var c=document.getElementsByTagName("body");c.length?c[0].appendChild(b):document.documentElement.appendChild(b)}function loadJs(a){var b=document.createElement("script");b.type="text/javascript",b.src=a;var c=document.getElementsByTagName("head");c.length?c[0].appendChild(b):document.documentElement.appendChild(b)}function Imgpd(a,b,c,d){this.title=a,this.url=b,this.text=c,this.src=d}function getImgJson(p){var imgJson=[];if("undefined"!==eval("typeof w"+p+"imgJsons"))eval("imgJson = w"+p+"imgJsons");else{eval("var title = imgText"+p+"||[], url = imgLink"+p+"||[], text = imgContent"+p+"||[], img = imgUrl"+p+"||[];");var i;for(i=1;i<title.length;i++)imgJson[i-1]=new Imgpd(title[i]||"",url[i]||"",text[i]||"",img[i]||"")}return imgJson}
/*
** Identification equipment
 */
var os=function(){var ua=navigator.userAgent,isWindowsPhone=/(?:Windows Phone)/.test(ua),isSymbian=/(?:SymbianOS)/.test(ua)||isWindowsPhone,isAndroid=/(?:Android)/.test(ua),isFireFox=/(?:Firefox)/.test(ua),isChrome=/(?:Chrome|CriOS)/.test(ua),isTablet=/(?:iPad|PlayBook)/.test(ua)||(isAndroid&&!/(?:Mobile)/.test(ua))||(isFireFox&&/(?:Tablet)/.test(ua)),isPhone=/(?:iPhone)/.test(ua)&&!isTablet,isPc=!isPhone&&!isAndroid&&!isSymbian;return{isTablet:isTablet,isPhone:isPhone,isAndroid:isAndroid,isPc:isPc}}();
/*
** load jquery and jquery plugins for sudy
 */
var EXTEND_PATH,exScripts=document.getElementsByTagName("script");EXTEND_PATH=exScripts[exScripts.length-1].getAttribute("src").replace('extends.js','');document.write('<link rel="stylesheet" type="text/css" href="'+EXTEND_PATH+'extends.css" >');window.jQuery||document.write('<script type="text/javascript" src="'+EXTEND_PATH+'libs/jquery.min.js"><\/script>');document.write('<script type="text/javascript" src="'+EXTEND_PATH+'libs/jquery.sudy.js"><\/script>');if(os.isAndroid||os.isPhone||os.isTablet){document.write('<script type="text/javascript" src="'+EXTEND_PATH+'libs/jquery.iscroll.js"><\/script>')};
