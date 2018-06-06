<%@ WebHandler Language="C#" Class="setHardwareInfo" %>

using System;
using System.Web;

public class setHardwareInfo : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        string host_id = context.Request["host_id"];
        string osInfo = context.Request["osInfo"];
        string diskInfo = context.Request["diskInfo"];
        string memoryInfo = context.Request["memoryInfo"];
        string cpuInfo = context.Request["cpuInfo"];
        string portInfo = context.Request["portInfo"];
        string time = context.Request["time"];
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}