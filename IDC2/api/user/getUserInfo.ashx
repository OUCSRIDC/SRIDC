<%@ WebHandler Language="C#" Class="getUserInfo" %>

using System;
using System.Web;
using System.Collections.Generic;
using System.Web.SessionState;
using System.Linq;
using Newtonsoft.Json;
public class getUserInfo : IHttpHandler, IRequiresSessionState {

    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        context.Response.ContentType = "text/plain";
        string username = context.Request["username"];
        UserInfo ui = new UserInfo();
        if (HttpContext.Current.Session["username"].ToString() == username)
        {
            using (var db = new IDCEntities())
            {
                try
                {
                    Users user = db.Users.SingleOrDefault(a => a.username == username);
                    List<LoginInfo> data = (from it in db.LoginInfo where it.username==username orderby it.logintime descending select it).ToList();
                    ui.Status = 200;
                    ui.Username = username;
                    ui.Email = user.email;
                    ui.Lf = data;
                }
                catch
                {
                    ui.Status = 1000;
                }
            }
        }
        else
        {
            ui.Status = 1001;
        }
        string json = JsonConvert.SerializeObject(ui);
        context.Response.Write(json);
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}