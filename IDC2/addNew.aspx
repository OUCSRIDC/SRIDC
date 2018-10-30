<%@ Page Language="C#" AutoEventWireup="true" CodeFile="addNew.aspx.cs" Inherits="Ajax_addNew" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    用户名：<asp:TextBox runat="server" ID="name"></asp:TextBox><br />
        密码：<asp:TextBox runat="server" ID="password"></asp:TextBox><br />
        <asp:Button runat="server" ID="button" OnClick="button_Click" />
    </div>
    </form>
</body>
</html>
