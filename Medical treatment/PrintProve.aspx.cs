using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Medical_treatment
{
    public partial class PrintProve : System.Web.UI.Page
    {
        ADOdatNET ADOdata = new ADOdatNET();
        protected void Page_Load(object sender, EventArgs e)
        {
            String ID = Request.QueryString["ID"];
            if (ID == null) Response.Write("<script  LANGUAGE='JavaScript'>alert('參數錯誤');location.href='Home.aspx'</script>");
            else
            {
                DataSet data = ADOdata.QueryPrintProve(ID);
                name.Text = data.Tables[0].Rows[0]["Name"].ToString();
                Sex.Text = data.Tables[0].Rows[0]["sex"].ToString();
                Age.Text = data.Tables[0].Rows[0]["age"].ToString();
                Addr.Text = data.Tables[0].Rows[0]["addr"].ToString();
                Hurt.Text = data.Tables[0].Rows[0]["Wound"].ToString();
                HDate.Text = data.Tables[0].Rows[0]["hdateYear"].ToString()+ data.Tables[0].Rows[0]["hdateMonth"].ToString()+ data.Tables[0].Rows[0]["hdateDate"].ToString();
                HDate_1.Text = data.Tables[0].Rows[0]["hdateYear"].ToString() + data.Tables[0].Rows[0]["hdateMonth"].ToString() + data.Tables[0].Rows[0]["hdateDate"].ToString();
                identity.Text = data.Tables[0].Rows[0]["identity"].ToString();
            }
        }
    }
}