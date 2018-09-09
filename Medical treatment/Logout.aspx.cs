using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Medical_treatment
{
    public partial class Logout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["Account"] = null;
            Response.Write("<script >alert('登出成功！'); location.href='Login.aspx';</script>");
        }
    }
}