<%@ WebHandler Language="C#" Class="select" %>

using System;
using System.Web;
using System.Collections.Generic;
using System.Linq;
using Newtonsoft.Json;
using System.Web.SessionState;
public class select :  IHttpHandler, IRequiresSessionState {

    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        string name = context.Request["name"];
        string username = context.Request["username"];
        GetHostInfoAll gha = new GetHostInfoAll();
        if (HttpContext.Current.Session["username"].ToString() == username)
        {
            using (var db = new IDCEntities())
            {
                try
                {
                    List<Host> data = (from it in db.Host where it.name.Contains(name) select it).ToList();
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