using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Port 的摘要说明
/// </summary>
public class Ports
{
    private int uid;
    private int port;
    private DateTime date;
    private string status;

    public int Uid
    {
        get
        {
            return uid;
        }

        set
        {
            uid = value;
        }
    }

    public int Port
    {
        get
        {
            return port;
        }

        set
        {
            port = value;
        }
    }

    public DateTime Date
    {
        get
        {
            return date;
        }

        set
        {
            date = value;
        }
    }

    public string Status
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

    public Ports()
    {
        //
        // TODO: 在此处添加构造函数逻辑
        //
    }
}