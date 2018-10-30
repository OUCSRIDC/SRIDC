using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// GetHostInfoAll 的摘要说明
/// </summary>
public class GetHostInfoAll
{
    private int status;
    private List<Host> data;

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

    public List<Host> Data
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

    public GetHostInfoAll()
    {
        //
        // TODO: 在此处添加构造函数逻辑
        //
    }
}