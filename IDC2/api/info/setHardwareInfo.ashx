<%@ WebHandler Language="C#" Class="setHardwareInfo" %>

using System;
using System.Web;
using System.Linq;
public class setHardwareInfo : IHttpHandler {

    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        string host_ip = context.Request["host_id"];
        string osInfo = context.Request["osInfo"];
        string diskInfo = context.Request["diskInfo"];
        string memoryInfo = context.Request["memoryInfo"];
        string cpuInfo = context.Request["cpuInfo"];
        string portInfo = context.Request["portInfo"];
        string time = context.Request["time"];
        string[] ports = portInfo.Split('\n');
        using (var db = new IDCEntities())
        {
            Host host = db.Host.SingleOrDefault(a => a.ip == host_ip);
            if (host != null)
            {
                HostInfo hostinfo = new HostInfo();
                hostinfo.host_id = host.id;
                hostinfo.osInfo = osInfo;
                hostinfo.diskInfo = diskInfo;
                hostinfo.memoryInfo = memoryInfo;
                hostinfo.cpuInfo = cpuInfo;
                hostinfo.time = Convert.ToDateTime(time);
                db.HostInfo.Add(hostinfo);
     
                foreach(string info in ports)
                {
                    if (info != "")
                    {
                        HostPortInfo hostportinfo = new HostPortInfo();
                        hostportinfo.host_id = host.id;
                        hostportinfo.portInfo = info;
                        int i = 0;
                        for(i = 0; ; i++)
                        {
                            if (info[i] >= 48 && info[i] <= 57)
                            {
                                continue;
                            }
                            else
                            {
                                break;
                            }
                        }
                        string portNum = info.Substring(0, i);
                        hostportinfo.portNum = portNum;
                        hostportinfo.time =  Convert.ToDateTime(time);
                        db.HostPortInfo.Add(hostportinfo);

                    }

                }
                try
                {
                    db.SaveChanges();
                }
                catch(Exception ex)
                {

                }

            }
        }
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}