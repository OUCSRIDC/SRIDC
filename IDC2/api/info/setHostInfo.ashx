<%@ WebHandler Language="C#" Class="setHostInfo" %>

using System;
using System.Web;
using Newtonsoft.Json;
using System.Web.SessionState;
using System.IO;
public class setHostInfo : IHttpHandler, IRequiresSessionState {

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
                        
                        //string filePath = "D:/document/GitHub/SRIDC/IDC2/python/url.txt";
                        //检测文件夹是否存在，不存在则创建
                        //FileStream fs = new FileStream(filePath, FileMode.Create);
                        //StreamWriter sw = File.AppendText(filePath);
                        //开始写入
                        //sw.Write(ip+",");
                        //清空缓冲区
                        //sw.Flush();
                        //关闭流
                        //sw.Close();
                        db.SaveChanges();
                        //fs.Close();
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