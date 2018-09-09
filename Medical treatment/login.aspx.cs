using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Medical_treatment
{
    public partial class login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            if (inputEmail.Value != "a" || inputPassword.Value != "a") Response.Write("<script >alert('帳號或密碼錯誤！');</script>");
            else
            {
                Session["Account"] = "a";
                Response.Redirect("Home.aspx");
            }
        }
    }
}