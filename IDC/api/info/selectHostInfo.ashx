<%@ WebHandler Language="C#" Class="selectHostInfo" %>

using System;
using System.Web;
using System.Collections.Generic;
using System.Linq;
using Newtonsoft.Json;
using System.Web.SessionState;
public class selectHostInfo : IHttpHandler, IRequiresSessionState {

    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        string username = context.Request["username"];
        int ip = Convert.ToInt32(context.Request["ip"]);
        string operation = context.Request["operation"];
        SelectHostInfo shi = new SelectHostInfo();
        string[] s = operation.Split(new char[] { '-' });
        if (HttpContext.Current.Session["username"].ToString() == username)
        {
            using (var db = new IDCEntities())
            {
                try
                {
                    if (s.Length == 1)
                    {
                        var hostinfo = db.HostInfo.FirstOrDefault(a => a.host_id == ip);
                        if (operation == "os")
                        {
                            shi.Data = hostinfo.osInfo;
                        }
                        if (operation == "disk")
                        {
                            shi.Data = hostinfo.diskInfo;
                        }
                        if (operation == "memory")
                        {
                            shi.Data = hostinfo.memoryInfo;
                        }
                        if (operation == "CPU")
                        {
                            shi.Data = hostinfo.cpuInfo;
                        }
                    }
                    else
                    {
                        List<HostPortInfo> port = (from it in db.HostPortInfo where it.host_id == ip && it.portNum == s[1] orderby it.time select it).ToList();
                        shi.Data = port[0].portInfo;
                    }
                    shi.Status = 200;
                }
                catch
                {
                    shi.Status = 1000;
                }
            }
        }
        else
        {
            shi.Status = 1001;
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