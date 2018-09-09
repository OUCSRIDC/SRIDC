using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// OtherInfo 的摘要说明
/// </summary>
public class OtherInfo
{
    private string disk;
    private string CPU;
    private string memory;
    private string OS;

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

    public OtherInfo()
    {
        //
        // TODO: 在此处添加构造函数逻辑
        //
    }
}