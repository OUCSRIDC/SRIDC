<%@ WebHandler Language="C#" Class="selectHostInfo" %>

using System;
using System.Web;

public class selectHostInfo : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        context.Response.Write("Hello World");
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}