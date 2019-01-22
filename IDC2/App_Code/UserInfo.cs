using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// UserInfo 的摘要说明
/// </summary>
public class UserInfo
{
    private int status;
    private string username;
    private string email;
    private List<LoginInfo> lf;

    public string Username
    {
        get
        {
            return username;
        }

        set
        {
            username = value;
        }
    }

    public string Email
    {
        get
        {
            return email;
        }

        set
        {
            email = value;
        }
    }

    public List<LoginInfo> Lf
    {
        get
        {
            return lf;
        }

        set
        {
            lf = value;
        }
    }

    public int Status
    {
        get
        {
            return status;
        }

        set
        {
            status = value;
        }
    }

    public UserInfo()
    {
        //
        // TODO: 在此处添加构造函数逻辑
        //
    }
}