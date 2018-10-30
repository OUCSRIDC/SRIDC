      $("#login").click(function () {
          $.ajax({
              type: "POST",
              url: "api/user/login.ashx",
              data: { NumberId: $("#numberId").val(), Password: $("#password").val() },
              async: false,
              dataType: "json",
              success: function (dat) {
                  if (dat.status == 200) {
                      alert("login successfully");
                      self.location = 'index.html';
                  }
                  else if (dat.status == 1001) {
                      alert("login failed, validate is error");
                  }
                  else if (dat.status == 1000) {
                      alert("login failed, numberid or password is error");
                  }
              }
          });
      });