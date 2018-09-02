using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Medical_treatment
{
    public partial class Home : System.Web.UI.Page
    {
        ADOdatNET data = new ADOdatNET();
        
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Serch_Click(object sender, EventArgs e)
        {   
            String strcmd = "select P_ID, Name , Sex ,[identity], Phone1 , Phone2 , addr , Note, ";
            strcmd += "[dbo].[udfTaiwanDateFormat] (Firstvisit_Date,'yy/mm/dd') Firstvisit_Date,[dbo].[udfTaiwanDateFormat] (Born_Date,'yy/mm/dd') Born_Date ";
            strcmd += "from Patient where 1=2  ";
            if (Name.Value != "") strcmd += " or Name like '%" + Name.Value + "%' ";
            if(P_ID.Value != "") strcmd += " or P_ID = '" + P_ID.Value + "'";
            if (Phone1.Value != "") strcmd += " or Phone1 like '%" + Phone1.Value + "%'";
            if (Phone2.Value != "") strcmd += " or Phone2 like '%" + Phone2.Value + "%'";
            if (Addr.Value != "") strcmd += " or Addr like '%" + Addr.Value + "%'";
            if (identity.Value != "") strcmd += " or [identity] = '" + identity.Value + "' ";
            if(Note.Value != "") strcmd += " or Note like '" + Note.Value + "'";
            if (Firstvisit_Date.Value != "") strcmd += " or Firstvisit_Date = '" + data.ToSimpleUSDate(Note.Value) + "'";
            if (Born_Date.Value != "") strcmd += " or Born_Date = '" + data.ToSimpleUSDate(Born_Date.Value) + "'";
            DataSet dt = data.getDataSet(strcmd);
            ListView1.DataSource = dt;
            ListView1.DataBind();
        }
        
        protected void Create(object sender, EventArgs e)
        {  
            String cmd = "select * from Patient where [identity]='" + identity.Value + "'";
            if (data.used(cmd)) Response.Write("<script  LANGUAGE='JavaScript'>alert('已註冊過');</script>");
            else
            {
                String firstDate;
                firstDate = DateTime.Today.ToShortDateString().ToString();
                if (Firstvisit_Date.Value != "") firstDate = data.ToSimpleUSDate(Firstvisit_Date.Value);
                cmd = "Insert into Patient(P_ID,Name,Firstvisit_Date,Sex,[identity],Born_Date,Phone1,Phone2,addr,Note) ";                
                cmd += " Values((select ISNULL(max(P_ID)+1,1) from Patient),'" + Name.Value + "',CONVERT(datetime,'" + firstDate + "', 111),'" + Sex.SelectedValue + "','" + identity.Value + "',CONVERT(datetime,'" + data.ToSimpleUSDate(Born_Date.Value) + "', 111),'" + Phone1.Value + "','" + Phone2.Value + "','" + Addr.Value + "','" + Note.Value + "')";
                if (data.execsql(cmd)) Response.Write("<script  LANGUAGE='JavaScript'>alert('新增成功');</script>");
                else Response.Write("<script  LANGUAGE='JavaScript'>alert('新增失敗');</script>");
                ListView1.DataSource = null;
                ListView1.DataBind();
            }            
        }
        public string Checksex(object obj)
        {
            if (obj.ToString() == "0") return "女";
            else return "男";
        }

        protected void SearchMedical_redcords(object sender, CommandEventArgs e)
        {
            string[] info = e.CommandArgument.ToString().Split(',');
            String P_ID = info[0];
            String Name = info[1];
            String querystring = "?Patient=" + P_ID + "&Name=" + Name;
            Response.Redirect("Medical_records.aspx" + querystring);
        }


        protected void update_Click(object sender, CommandEventArgs e)
        {
            String P_ID = e.CommandArgument.ToString();
            String ava = "?P_ID=" + P_ID;
            Response.Redirect("EditPatient.aspx" + ava);
        }

        protected void Delete_Command(object sender, CommandEventArgs e)
        {
            String P_ID = e.CommandArgument.ToString();
            string confirmValue = Request.Form["confirm_value"];
            if (confirmValue == "是")
            {
                string cmd = "delete Patient where P_ID='" + P_ID + "'";
                data.execsql(cmd);
                Response.Redirect("Home.aspx", true);
            }
        }

        protected void ListView1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}
