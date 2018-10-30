<%@ WebHandler Language="C#" Class="change" %>

using System;
using System.Web;
using System.Collections.Generic;
using System.Web.SessionState;
using System.Linq;
using Newtonsoft.Json;

public class change : IHttpHandler, IRequiresSessionState {

    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        string username = context.Request["username"];
        string ip = context.Request["ip"];
        string name = context.Request["name"];
        GetHostInfoHistory ghi = new GetHostInfoHistory();
        if (HttpContext.Current.Session["username"].ToString() == username)
        {
            using (var db = new IDCEntities())
            {
                Host hi = db.Host.SingleOrDefault(a => a.ip == ip);
                hi.name = name;
                db.SaveChanges();
                int Status = 200;
                string json = JsonConvert.SerializeObject(Status);
                context.Response.Write(json);
            }
        }
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}