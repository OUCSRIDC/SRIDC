using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// GetHostInfo 的摘要说明
/// </summary>
public class GetHostInfo
{
    private int status;
    private List<HostInfo> data;

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

    public List<HostInfo> Data
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


    public GetHostInfo()
    {
        //
        // TODO: 在此处添加构造函数逻辑
        //
    }
}