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
                    int hostid = Convert.ToInt32(hi.id);
                    List<HostPortInfo> port = (from it in db.HostPortInfo where it.host_id == hostid orderby it.time descending select it).ToList();
                    List<Ports> data = new List<Ports>();
                    DateTime t_now = port[0].time;//获取表中最新时间
                    var hostinfo = db.HostInfo.FirstOrDefault(a => a.host_id == hostid);
                    foreach(var t in port)
                    {
                        if (t.time == t_now)
                        {
                            Ports hp = new Ports();
                            hp.Uid = t.id;
                            hp.Port = t.portNum;
                            hp.Date = t.time;
                            hp.Status = t.portInfo;
                            data.Add(hp);
                        }
                    }
                    ghi.Data = data;
                    ghi.Disk = hostinfo.diskInfo;
                    ghi.Memory = hostinfo.memoryInfo;
                    ghi.OS1 = hostinfo.osInfo;
                    ghi.CPU1 = hostinfo.cpuInfo;
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