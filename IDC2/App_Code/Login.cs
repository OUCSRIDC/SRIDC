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

    public Users Data
    {
        get
        {
            return data;
        }

        set
        {
            data = value;
        }
    }

    public Login()
    {
        //
        // TODO: 在此处添加构造函数逻辑
        //
    }
}