using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Medical_treatment
{
    public partial class EditPatient : System.Web.UI.Page
    {
        ADOdatNET data = new ADOdatNET();
        protected void Page_Load(object sender, EventArgs e)
        {
            UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;            
            if(!Page.IsPostBack)
            {
                String Patient_ID = Request.QueryString["P_ID"];
                if (Patient_ID == null)
                {
                    Response.Write("<script  LANGUAGE='JavaScript'>alert('參數錯誤');location.href='Home.aspx'</script>");
                }
                else
                {
                    String cmd = "select * from Patient where P_ID=" + Patient_ID;
                    DataSet ds = data.getDataSet(cmd);
                    if (ds.Tables[0].Rows.Count == 0 )
                    {
                        Response.Write("<script  LANGUAGE='JavaScript'>alert('參數錯誤');location.href='Home.aspx'</script>");
                    }
                    else
                    {
                        Name.Value = ds.Tables[0].Rows[0]["Name"].ToString();
                        P_ID.Value = ds.Tables[0].Rows[0]["P_ID"].ToString();
                        Firstvisit_Date.Value = Dateformat(ds.Tables[0].Rows[0]["Firstvisit_Date"].ToString());
                        Sex.SelectedValue = ds.Tables[0].Rows[0]["sex"].ToString();
                        identity.Value = ds.Tables[0].Rows[0]["identity"].ToString();
                        Born_Date.Value = Dateformat(ds.Tables[0].Rows[0]["Born_Date"].ToString());
                        Phone1.Value = ds.Tables[0].Rows[0]["Phone1"].ToString();
                        Phone2.Value = ds.Tables[0].Rows[0]["Phone2"].ToString();
                        Addr.Value = ds.Tables[0].Rows[0]["addr"].ToString();
                        Note.Value = ds.Tables[0].Rows[0]["Note"].ToString();
                    }
                }
            }
            
        }

        protected void Update_Click(object sender, EventArgs e)
        {
            String cmd = "Update Patient Set ";
            cmd += "Name='" + Name.Value + "' , Firstvisit_Date='" + Firstvisit_Date.Value +"', Sex = '" +  Sex.SelectedValue + "' , [identity]='" + identity.Value + "' , Born_Date='"+ Born_Date.Value + "' , Phone1='"+ Phone1 .Value + "', Phone2='"+ Phone2 .Value + "' , Addr='"+ Addr.Value+ "' , Note='"+Note.Value+"'"; 
            cmd += " Where P_ID = '"+ P_ID.Value +"'";
            if (data.execsql(cmd))    Response.Write("<script  LANGUAGE='JavaScript'>alert('修改成功');location.href='Home.aspx'</script>");
            else Response.Write("<script  LANGUAGE='JavaScript'>alert('修改失敗');</script>");
        }

        protected void Cancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("Home.aspx");
        }
        protected string Dateformat(string date)
        {
            return date.Replace(" 上午 12:00:00", "");
        }
    }
}