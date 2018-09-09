<%@ WebHandler Language="C#" Class="getHostInfoHistory" %>

using System;
using System.Web;
using System.Collections.Generic;
using System.Web.SessionState;
using System.Linq;
using Newtonsoft.Json;

public class getHostInfoHistory : IHttpHandler {

    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        string username = context.Request["username"];
        string ip = context.Request["ip"];
        GetHostInfoHistory ghi = new GetHostInfoHistory();
        if (HttpContext.Current.Session["username"].ToString() == username)
        {
            using (var db = new IDCEntities())
            {
                try
                {
                    int hostid = Convert.ToInt32(ip);
                    List<HostPortInfo> port = (from it in db.HostPortInfo where it.host_id == hostid select it).ToList();
                    List<Ports> data = new List<Ports>();
                    List<OtherInfo> otherInfo = new List<OtherInfo>();
                    List<HostInfo> hostinfo = (from it in db.HostInfo where it.host_id == hostid select it).ToList();
                    //var hostinfo = db.HostInfo.FirstOrDefault(a => a.host_id == hostid);
                    foreach(var t in port)
                    {
                        if (t.portInfo == "占用")
                        {
                            Ports hp = new Ports();
                            hp.Uid = t.id;
                            hp.Port = t.portNum;
                            hp.Date = t.time;
                            hp.Status = t.portInfo;
                            data.Add(hp);
                        }
                    }
                    foreach(var t in hostinfo)
                    {
                        OtherInfo oi = new OtherInfo();
                        oi.Disk = t.diskInfo;
                        oi.Memory = t.memoryInfo;
                        oi.OS1 = t.osInfo;
                        oi.CPU1 = t.cpuInfo;
                        otherInfo.Add(oi);
                    }
                    ghi.Data = data;
                    ghi.Data2 = otherInfo;
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