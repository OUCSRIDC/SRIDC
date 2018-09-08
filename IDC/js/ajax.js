$(document).ready(function(){
  var aj = $.ajax( {    
    url:'api/info/getHostInfoAll.ashx',    
    data:{    
             ip : ip,    
             username : username//username怎么来。从cookie里读取，这个cookie是从登陆的地方获取的
    },    
    type:'post',    
    cache:false,
    async: false,  
    dataType:'json',    
    success:function(data) {    
        //循环后台传过来的Json数组
        for(int i = 0; i < data.length; i++) { 
			var datas = data[i];
            //把数据添加到页面
			$("#table").children("tbody").append("<tr><th>"+ i +"</th><td>"+data.ip+"</td><td>"+data.username+"</td><td><button onclick="window.location.href='detail.html'">"+data.operation+"</button></td></tr>");
		}

		
		
		
		
		
		
		
		
		//存cookie这里，应该是从js获取点击的列表的某行的对应的ip，然后在detail里获取cookie然后再次请求接口，所以下面都要改
		//存cookie
		console.log(data);
         if(data.status =='200'){
            var ip = data.ip;
            var username = data.username;
            var operation = data.operation;
            var cookie_val = $.JSONCookie("hostInfo");
            cookie_val = { "userhost": [{
               "ip": ip,
               "username": username,
               "operation": operation
            }]};
            $.JSONCookie("hostInfo", cookie_val, { path: '/', expires: 7 });//存储json格式cookie

            location.href='index.html';
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