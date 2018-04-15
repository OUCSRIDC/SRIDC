<%@ WebHandler Language="C#" Class="setHostInfo" %>

using System;
using System.Web;
using Newtonsoft.Json;
public class setHostInfo : IHttpHandler {

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        string username = context.Request["username"];
        string ip = context.Request["ip"];
        string name = context.Request["name"];
        SetHostInfo shi = new SetHostInfo();
        if (HttpContext.Current.Session["username"] != null)
        {
            if (HttpContext.Current.Session["username"].ToString() == username)
            {
                try
                {
                    using (var db = new IDCEntities())
                    {
                        Host host = new Host();
                        host.ip = ip;
                        host.name = name;
                        db.Host.Add(host);
                        db.SaveChanges();
                        shi.Status = 200;
                    }
                }
                catch
                {
                    shi.Status = 1000;
                }

            }
            else
            {
                shi.Status = 1001;
            }

        }
        else
        {
            shi.Status = 1000;
        }
        string json = JsonConvert.SerializeObject(shi);
        context.Response.Write(json);
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}