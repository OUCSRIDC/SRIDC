﻿//------------------------------------------------------------------------------
// <auto-generated>
//     此代码已从模板生成。
//
//     手动更改此文件可能导致应用程序出现意外的行为。
//     如果重新生成代码，将覆盖对此文件的手动更改。
// </auto-generated>
//------------------------------------------------------------------------------

using System;
using System.Collections.Generic;

public partial class Host
{
    public int id { get; set; }
    public string ip { get; set; }
    public string name { get; set; }
}

public partial class HostInfo
{
    public int id { get; set; }
    public int host_id { get; set; }
    public string osInfo { get; set; }
    public string diskInfo { get; set; }
    public string memoryInfo { get; set; }
    public string cpuInfo { get; set; }
    public System.DateTime time { get; set; }
}

public partial class HostPortInfo
{
    public int id { get; set; }
    public int host_id { get; set; }
    public string portInfo { get; set; }
    public System.DateTime time { get; set; }
    public string portNum { get; set; }
}

public partial class Users
{
    public int id { get; set; }
    public string username { get; set; }
    public string password { get; set; }
    public string email { get; set; }
}
