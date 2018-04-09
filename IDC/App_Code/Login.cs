using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Login 的摘要说明
/// </summary>
public class Login
{
    private int status;
    private Users data;
    public Login()
    {
        //
        // TODO: 在此处添加构造函数逻辑
        //
    }
    public void setStatus(int status)
    {
        this.status = status;
    }
    public void setData(Users data)
    {
        this.data = data;
    }
}