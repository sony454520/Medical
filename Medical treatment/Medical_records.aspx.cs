using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Medical_treatment
{
    public partial class Medical_records1 : System.Web.UI.Page
    {
        ADOdatNET dataconect = new ADOdatNET();
        string Patient, PatientName;

        protected void Page_Load(object sender, EventArgs e)
        {
            Patient = Request.QueryString["Patient"];
            PatientName = Request.QueryString["Name"];
            FullName.Text = PatientName;
            if (!IsPostBack)
            {
                Update_ListView1();
            }
        }

        protected void Update_ListView1()
        {
            string query = "Select PH_ID,[dbo].[udfTaiwanDateFormat] (Hdate,'yy/mm/dd') Hdate,Hdate seq,Wound,medicine,cost,Owed,P_ID," +
                              "[dbo].[udfTaiwanDateFormat] (Prove_Date,'yy/mm/dd') Prove_Date, [dbo].[udfTaiwanDateFormat] (Receipt_Date,'yy/mm/dd') Receipt_Date " +
                              "from Medical_records " +
                              "where P_ID = '" + Patient + "' order by seq desc";
            DataSet data = dataconect.getDataSet(query);
            ListView1.DataSource = data;
            ListView1.DataBind();
        }

        protected void btn_Insert_Click(object sender, EventArgs e)
        {
            // dataconect.ToSimpleUSDate(Firstvisit_Date.Value);
            String cmd = "Insert into Medical_records(PH_ID,HDate,Wound,medicine,cost,Owed,P_ID,Prove_Date,Receipt_Date) ";
            cmd += " Values((select ISNULL(max(PH_ID)+1,1) from Medical_records),CONVERT(datetime,'" + dataconect.ToSimpleUSDate(Hdate.Value) + "', 111),'" + Wound.Value + "','" + medicine.Value + "','" + cost.Value + "','" + Owed.Value +"','" + Patient + "',null,null)";
            if (dataconect.execsql(cmd)) Response.Write("<script  LANGUAGE='JavaScript'>alert('新增成功');</script>");
            else Response.Write("<script  LANGUAGE='JavaScript'>alert('新增失敗');</script>");
            Update_ListView1();
        }

        protected void btn_Update_Click(object sender, EventArgs e)
        {
            String cmd = "update Medical_records set HDate =  '" + dataconect.ToSimpleUSDate(Hdate.Value) + "'," +
                "Wound = '" + Wound.Value + "'," +
                "medicine = '" + medicine.Value + "'," +
                "cost = '" + cost.Value + "'," +
                "Owed = '" + Owed.Value + "'," +
                //"Prove_Date  = CONVERT(datetime,'" + dataconect.ToSimpleUSDate(Prove_Date.Value) + "', 111)," +
                //"Receipt_Date  = CONVERT(datetime,'" + dataconect.ToSimpleUSDate(Receipt_Date.Value) + "', 111)" +
                "Prove_Date  = NULL," +
                "Receipt_Date  = NULL,";
            cmd = cmd.Substring(0, cmd.Length - 1);
               cmd+= " where PH_ID = " + PH_ID.Value;
            if (dataconect.execsql(cmd)) Response.Write("<script  LANGUAGE='JavaScript'>alert('更新成功');</script>");
            else Response.Write("<script  LANGUAGE='JavaScript'>alert('新增失敗');</script>");
            Update_ListView1();
        }

        protected void btn_Delete_Click(object sender, EventArgs e)
        {
            String cmd = "Delete from Medical_records";
            cmd += " where PH_ID = " + PH_ID.Value;
            if (dataconect.execsql(cmd)) Response.Write("<script  LANGUAGE='JavaScript'>alert('刪除成功');</script>");
            else Response.Write("<script  LANGUAGE='JavaScript'>alert('刪除失敗');</script>");
            Update_ListView1();
        }
    }
}