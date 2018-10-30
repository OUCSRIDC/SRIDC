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
    private List<Ports> data;
    private string disk;
    private string CPU;
    private string memory;
    private string OS;

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

    public string Disk
    {
        get
        {
            return disk;
        }

        set
        {
            disk = value;
        }
    }

    public string CPU1
    {
        get
        {
            return CPU;
        }

        set
        {
            CPU = value;
        }
    }

    public string Memory
    {
        get
        {
            return memory;
        }

        set
        {
            memory = value;
        }
    }

    public string OS1
    {
        get
        {
            return OS;
        }

        set
        {
            OS = value;
        }
    }

    public GetHostInfo()
    {
        //
        // TODO: 在此处添加构造函数逻辑
        //
    }
}