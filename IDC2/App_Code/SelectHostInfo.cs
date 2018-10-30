using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// SelectHostInfo 的摘要说明
/// </summary>
public class SelectHostInfo
{
    private int status;
    private string data;

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

    public string Data
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

    public SelectHostInfo()
    {
        //
        // TODO: 在此处添加构造函数逻辑
        //
    }
}