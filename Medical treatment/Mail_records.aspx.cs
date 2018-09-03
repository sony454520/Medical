using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Medical_treatment
{
    public partial class Mail_records : System.Web.UI.Page
    {
        ADOdatNET dataconect = new ADOdatNET();

        protected void Page_Load(object sender, EventArgs e)
        {
            string P_ID = Request.QueryString["P_ID"];
            string PH_ID = Request.QueryString["PH_ID"];
            string query;
            if (PH_ID != null)
            {
                query = string.Format("select * from Medical_records where PH_ID = '{0}'", PH_ID);
                DataSet Medical_recordInfo = dataconect.getDataSet(query);
                medicine.Value = Medical_recordInfo.Tables[0].Rows[0]["medicine"].ToString();
                cost.Value = Medical_recordInfo.Tables[0].Rows[0]["cost"].ToString();
                Owed.Value = Medical_recordInfo.Tables[0].Rows[0]["Owed"].ToString();
                query = string.Format("select * from Patient where P_ID = '{0}'", Medical_recordInfo.Tables[0].Rows[0]["P_ID"]);

                DataSet PatientInfo = dataconect.getDataSet(query);
                Addr.Value = PatientInfo.Tables[0].Rows[0]["addr"].ToString();
                recipient.Value = PatientInfo.Tables[0].Rows[0]["Name"].ToString();
                FullName.Text = PatientInfo.Tables[0].Rows[0]["Name"].ToString();

                query = string.Format("select * from Mail_Record where recipient = '{0}'", PatientInfo.Tables[0].Rows[0]["Name"]);
                ListView1.DataSource = dataconect.getDataSet(query);
                ListView1.DataBind();
            }
            else if (P_ID != null)
            {
                query = string.Format("select * from Patient where P_ID = {0}", P_ID);
                DataSet PatientInfo = dataconect.getDataSet(query);
                Addr.Value = PatientInfo.Tables[0].Rows[0]["addr"].ToString();
                recipient.Value = PatientInfo.Tables[0].Rows[0]["Name"].ToString();
                FullName.Text = PatientInfo.Tables[0].Rows[0]["Name"].ToString();
            }

        }

        protected void Update_ListView1()
        {
        }

        protected void btn_Insert_Click(object sender, EventArgs e)
        {
            string cmd = "insert into Mail_Record(M_ID,Send_Date,recipient,Medicine,Cost,Owed,Zipcode,Addr)";
            cmd += string.Format("Values ((select ISNULL(max(PH_ID) + 1, 1) from Medical_records),{0},{1},{2},{3},{4},{5},{6})", dataconect.ToSimpleUSDate(Send_Date.Value), recipient.Value, medicine.Value, cost.Value, Owed.Value, Zipcode.Value, Addr.Value);
            if (dataconect.execsql(cmd)) Response.Write("<script  LANGUAGE='JavaScript'>alert('新增成功');</script>");
            else Response.Write("<script  LANGUAGE='JavaScript'>alert('新增失敗');</script>");
            Update_ListView1();
        }

        protected void btn_Update_Click(object sender, EventArgs e)
        {
            string cmd = "Update Mail_Record ";
            cmd += string.Format(" Set Send_Date='{0}' ,recipient = '{1}' , Medicine = '{2}' , Cost = '{3}' , Owed = '{4}' ,Zipcode = '{5}', Addr= '{6}' ", dataconect.ToSimpleUSDate(Send_Date.Value), recipient.Value, medicine.Value,cost.Value,Owed.Value,Zipcode.Value,Addr.Value);
            cmd += string.Format(" where M_ID = {0} ", M_ID.Value);
            if (dataconect.execsql(cmd)) Response.Write("<script  LANGUAGE='JavaScript'>alert('更新成功');</script>");
            else Response.Write("<script  LANGUAGE='JavaScript'>alert('更新失敗');</script>");
            Update_ListView1();
        }
        protected void btn_Delete_Click(object sender, EventArgs e)
        {
            String cmd = "Delete from Mail_Record";
            cmd += " where M_ID = " + M_ID.Value;
            if (dataconect.execsql(cmd)) Response.Write("<script  LANGUAGE='JavaScript'>alert('刪除成功');</script>");
            else Response.Write("<script  LANGUAGE='JavaScript'>alert('刪除失敗');</script>");
            Update_ListView1();
        }

    }
}