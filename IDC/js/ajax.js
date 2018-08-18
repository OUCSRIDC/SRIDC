$(document).ready(function(){
  var aj = $.ajax( {    
    url:'api/info/selectHostInfo.ashx',    
    data:{    
             ip : ip,    
             username : username,    
             operation : operation
    },    
    type:'post',    
    cache:false,    
    dataType:'json',    
    success:function(data) {    
        for(int i = 0; i < data.length; i++) { //循环后台传过来的Json数组
			var datas = data[i];
			$("#table").children("tbody").append("<tr><th>"+ i +"</th><td>"+data.ip+"</td><td>"+data.username+"</td><td><button onclick="window.location.href='detail.html'">"+data.operation+"</button></td></tr>");
		}

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
           
            //alert(data.error);
            return false;
         }
     },    
     error : function() {    
          // view("异常！");    
          alert("异常！");    
     }    
  });  
});