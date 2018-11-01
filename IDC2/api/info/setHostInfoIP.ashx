<%@ WebHandler Language="C#" Class="setHostInfoIP" %>

using System;
using System.Web;
using System.Linq;

public class setHostInfoIP : IHttpHandler {

    public void ProcessRequest (HttpContext context) {
        string domain = context.Request["domain"];
        string isIPV4 = context.Request["isIPV4"];
        string isIPV6 = context.Request["isIPV6"];
        string isRight = context.Request["isRight"];
        string time = context.Request["time"];
        using (var db = new IDCEntities())
        {
            Host host = db.Host.SingleOrDefault(a => a.ip == domain);
            if (host != null)
            {
                HostInfo newHost = new HostInfo();
                newHost.host_id = host.id;
                newHost.ipv4 = isIPV4 == "True" ? 1 : 0;
                newHost.ipv6 = isIPV6 == "True" ? 1 : 0;
                newHost.isright = isRight == "True" ? 1 : 0;
                newHost.time = Convert.ToDateTime(time);
                db.HostInfo.Add(newHost);

            }
        }

    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}