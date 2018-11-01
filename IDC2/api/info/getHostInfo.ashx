<%@ WebHandler Language="C#" Class="getHostInfo" %>

using System;
using System.Web;
using System.Collections.Generic;
using System.Web.SessionState;
using System.Linq;
using Newtonsoft.Json;
public class getHostInfo : IHttpHandler, IRequiresSessionState {

    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        string username = context.Request["username"];
        string ip = context.Request["ip"];
        GetHostInfo ghi = new GetHostInfo();
        if (HttpContext.Current.Session["username"].ToString() == username)
        {
            using (var db = new IDCEntities())
            {
                try
                {
                    Host hi = db.Host.SingleOrDefault(a => a.ip == ip);
                    int hostid = hi.id;
                    List<HostInfo> data = (from it in db.HostInfo where it.host_id == hostid orderby it.time descending select it).ToList();
                    ghi.Data = data;
                    ghi.Status = 200;
                }
                catch
                {
                    ghi.Status = 1000;
                }
            }
        }
        else
        {
            ghi.Status = 1001;
        }
        string json = JsonConvert.SerializeObject(ghi);
        context.Response.Write(json);
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}