<%@ WebHandler Language="C#" Class="delete" %>

using System;
using System.Web;
using System.Collections.Generic;
using System.Web.SessionState;
using System.Linq;
using Newtonsoft.Json;

public class delete : IHttpHandler {

    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        string username = context.Request["username"];
        string ip = context.Request["ip"];
        GetHostInfoHistory ghi = new GetHostInfoHistory();
        if (HttpContext.Current.Session["username"].ToString() == username)
        {
            using (var db = new IDCEntities())
            {
                Host person = (from it in db.Host where it.ip == ip select it).FirstOrDefault();
                db.Host.Remove(person);
            }
        }
    }


    public bool IsReusable {
        get {
            return false;
        }
    }

}