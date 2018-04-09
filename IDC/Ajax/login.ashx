﻿<%@ WebHandler Language="C#" Class="login" %>

using System;
using System.Web;
using System.Linq;
using System.Collections.Generic;
using Newtonsoft.Json;
public class login : IHttpHandler {

    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        string username = context.Request["username"];
        string password = context.Request["password"];
        string code = context.Request["code"];
        Login login = new Login();
        using (var db = new IDCEntities())
        {
            if (code == HttpContext.Current.Session["CheckCode"].ToString())
            {
                //md5哈希
                string passwordMD = Utils.md5(password, 32);

                Users user = db.Users.SingleOrDefault(a => a.username == username && a.password == passwordMD);
                if (user == null)
                {
                    login.setStatus(1000);
                }
                else
                {
                    login.setStatus(200);
                    login.setData(user);
                }

            }
            else
            {
                login.setStatus(1001);
            }
            string json = JsonConvert.SerializeObject(login);
            context.Response.Write(json);
        }
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}