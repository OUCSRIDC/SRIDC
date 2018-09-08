$(document).ready(function(){
  var aj = $.ajax( {    
    url:'api/info/getHostInfoAll.ashx',
    data:{    
             ip : ip,    
             username : sessionStorage.getItem("NumberId")//username怎么来。从cookie里读取，这个cookie是从登陆的地方获取的
    },    
    type:'post',    
    cache:false,
    async: false,  
    dataType:'json',    
    success:function(data) {    
		console.log(data);
         if(data.status =='200'){
            //循环后台传过来的Json数组
            for(var i = 0; i < data.length; i++) { 
                var datas = data[i];
                //把数据添加到页面
                $("#table").children("tbody").append("<tr><th>"+ i +"</th><td id='"+ data.ip +"'>"+data.ip+"</td><td>"+data.username+"</td><td><button onclick="window.location.href='detail.html'">"+data.operation+"</button></td></tr>");
            }
         }
         if(data.status =='404'){
            alert(data.error);
            return false;
         }
     },    
     error : function() {    
          // view("异常！");    
          alert("异常！");    
     }    
  });  
});