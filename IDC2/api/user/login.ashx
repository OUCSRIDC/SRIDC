<%@ WebHandler Language="C#" Class="login" %>

using System;
using System.Web;
using System.Linq;
using System.Collections.Generic;
using Newtonsoft.Json;
using System.Web.SessionState;
public class login : IHttpHandler, IRequiresSessionState {

    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        string username = context.Request["username"];
        string password = context.Request["password"];
        string code = context.Request["code"];
        Login login = new Login();
        using (var db = new IDCEntities())
        {
            if (code == HttpContext.Current.Session["CheckCode"].ToString())
            {
                //md5哈希
                string passwordMD = Utils.md5(password, 32);
                IPManager manager = new IPManager();//查看IP是否用得频繁
                //获取当前时间
                System.DateTime currentTime=new System.DateTime();
                currentTime=System.DateTime.Now;
                string IPAddress = manager.GetClientIPv4Address();


                Users user = db.Users.SingleOrDefault(a => a.username == username && a.password == passwordMD);
                if (user == null)
                {
                    login.Status = 1000;
                }
                else
                {
                    //锁定状态
                    if (user.status == 0)
                    {
                        List<LoginInfo> lf = (from it in db.LoginInfo where it.ip == IPAddress orderby it.logintime descending select it).ToList();
                        TimeSpan timeSpan = currentTime - lf[0].logintime;
                        //时间差小于60分钟
                        if(timeSpan.TotalMinutes < 60)
                        {
                            login.Status = 1002;
                        }
                        else
                        {
                            user.status = 1;//解锁
                            db.SaveChanges();
                            LoginInfo newLI = new LoginInfo();
                            newLI.username = username;
                            newLI.ip = IPAddress;
                            newLI.logintime = Convert.ToDateTime(currentTime);
                            newLI.status = 1;//正常
                            db.LoginInfo.Add(newLI);
                            db.SaveChanges();
                            login.Status = 200;
                            login.Data = user;
                            HttpContext.Current.Session["username"] = username;
                        }
                    }
                    else
                    {
                        List<LoginInfo> lf = (from it in db.LoginInfo where it.ip == IPAddress orderby it.logintime descending select it).ToList();
                        int lf_count = 0;//查询到一个小时内登陆次数
                        int lf1_count = 10;//查询次数
                        //小于10次则直接加入
                        if (lf.Count() > 10)
                        {
                            foreach (LoginInfo element in lf)
                            {
                                lf1_count--;
                                if (lf1_count >= 0)
                                {
                                    TimeSpan timeSpan = currentTime - element.logintime;
                                    //时间差小于5分钟
                                    if(timeSpan.TotalMinutes < 5)
                                    {
                                        lf_count++;
                                    }
                                }
                                else
                                {
                                    break;
                                }

                            }
                        }
                        //五分钟登陆十次或以上
                        if (lf_count >= 10)
                        {
                            LoginInfo newLI = new LoginInfo();
                            newLI.username = username;
                            newLI.ip = IPAddress;
                            newLI.logintime = Convert.ToDateTime(currentTime);
                            newLI.status = 0;//不正常
                            db.LoginInfo.Add(newLI);
                            db.SaveChanges();
                            user.status = 0;//锁定用户
                            db.SaveChanges();
                            login.Status = 1002;
                        }
                        else
                        {
                            LoginInfo newLI = new LoginInfo();
                            newLI.username = username;
                            newLI.ip = IPAddress;
                            newLI.logintime = Convert.ToDateTime(currentTime);
                            newLI.status = 1;//正常
                            db.LoginInfo.Add(newLI);
                            db.SaveChanges();
                            login.Status = 200;
                            login.Data = user;
                            HttpContext.Current.Session["username"] = username;
                        }
                    }


                }
            }

            else
            {
                login.Status = 1001;
            }
            string json = JsonConvert.SerializeObject(login);
            context.Response.Write(json);

        }
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}