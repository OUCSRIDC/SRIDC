using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// GetHostInfoHistory 的摘要说明
/// </summary>
public class GetHostInfoHistory
{
    private int status;
    private List<Ports> data;
    private List<OtherInfo> data2;

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

    public List<Ports> Data
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

    public List<OtherInfo> Data2
    {
        get
        {
            return data2;
        }

        set
        {
            data2 = value;
        }
    }

    public GetHostInfoHistory()
    {
        //
        // TODO: 在此处添加构造函数逻辑
        //
    }
}