using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Medical_treatment
{
    public partial class PrintReceipt : System.Web.UI.Page
    {
        ADOdatNET ADOdata = new ADOdatNET();
        protected void Page_Load(object sender, EventArgs e)
        {
            String ID = Request.QueryString["ID"];
            if (ID == null) Response.Write("<script  LANGUAGE='JavaScript'>alert('參數錯誤');location.href='Home.aspx'</script>");
            else
            {   
                DataSet data = ADOdata.QueryPrintReceipt(ID);
                name.Text = data.Tables[0].Rows[0]["name"].ToString();
                year.Text = data.Tables[0].Rows[0]["year"].ToString();
                month.Text = data.Tables[0].Rows[0]["month"].ToString();
                day.Text = data.Tables[0].Rows[0]["Day"].ToString();
                hdateYear.Text = data.Tables[0].Rows[0]["hdateYear"].ToString();
                hdateMonth.Text = data.Tables[0].Rows[0]["hdateMonth"].ToString();
                hdateDay.Text = data.Tables[0].Rows[0]["hdateDay"].ToString();
                hdateYear1.Text = hdateYear.Text;
                hdateMonth1.Text = hdateMonth.Text;
                hdateDay1.Text = hdateDay.Text;
                int n = int.Parse(data.Tables[0].Rows[0]["cost"].ToString());
                cost.Text = ADOdata.GetBigNumber(n);
                //cost.Text = "X　萬　X　仟　X　佰_零_拾_零_元_零_角　整";
            }
        }
    }
}