using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Ajax_addNew : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void button_Click(object sender, EventArgs e)
    {
        string username = name.Text;
        string pwd = password.Text;
        pwd = Utils.md5(pwd, 32);
        using (var db = new IDCEntities())
        {
            Users us = new Users();
            us.username = username;
            us.password = pwd;
            us.email = "77@qq.com";
            us.status = 1;
            db.Users.Add(us);
            db.SaveChanges();
            Response.Write("<script>alert('新建成功！')<script>");
        }
    }
}