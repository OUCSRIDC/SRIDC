<%@ WebHandler Language="C#" Class="getHostInfoAll" %>

using System;
using System.Web;
using System.Collections.Generic;
using System.Linq;
using Newtonsoft.Json;
using System.Web.SessionState;
public class getHostInfoAll : IHttpHandler, IRequiresSessionState {

    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        string username = context.Request["username"];
        GetHostInfoAll gha = new GetHostInfoAll();
        if (HttpContext.Current.Session["username"].ToString() == username)
        {
            using (var db = new IDCEntities())
            {
                try
                {
                    List<Host> data = (from it in db.Host select it).ToList();
                    gha.Data = data;
                    gha.Status = 200;
                }
                catch
                {
                    gha.Status = 1000;
                }
            }
        }
        else
        {
            gha.Status = 1001;
        }
        string json = JsonConvert.SerializeObject(gha);
        context.Response.Write(json);
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}