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
            //String strcmd = "Select convert(char,departure_date,111) from Patient";
            
            String strcmd = "select P_ID, Name, CONVERT(VARCHAR(3), CONVERT(VARCHAR(4), Firstvisit_Date, 20) - 1911) +'/' + SUBSTRING(CONVERT(VARCHAR(10), Firstvisit_Date, 20), 6, 2) + '/' + SUBSTRING(CONVERT(VARCHAR(10), Firstvisit_Date, 20), 9, 2) as Firstvisit_Date , Sex , [identity] ,CONVERT(VARCHAR(3),CONVERT(VARCHAR(4),Born_Date,20) - 1911) + '/' + SUBSTRING(CONVERT(VARCHAR(10),Born_Date,20),6,2) + '/' + SUBSTRING(CONVERT(VARCHAR(10),Born_Date,20),9,2) as Born_Date , Phone , addr , Note from Patient";
            bool first = true;
            if (Name.Value != null)
            {
                if (first)
                {
                    strcmd += " Where ";
                    first = false;
                }
                strcmd += " Name like '%" + Name.Value + "%' ";
            }
            if (P_ID.Value != null)
            {
                if (first)
                {
                    strcmd += " Where ";
                    first = false;
                }
                else
                {
                    strcmd += " OR ";
                }
                strcmd += " P_ID like '" + P_ID.Value + "'";
            }
            if (identity.Value != null)
            {
                if (first)
                {
                    strcmd += " Where ";
                    first = false;
                }
                else
                {
                    strcmd += " OR ";
                }
                strcmd += " [identity] like '" + identity.Value + "'";
            }
            if (Note.Value != null)
            {
                if (first)
                {
                    strcmd += " Where ";
                    first = false;
                }
                else
                {
                    strcmd += " OR ";
                }
                strcmd += " Note like '" + Note.Value + "'";
            }
            //String[,] dt = data.Getdata(strcmd);
            //if (dt == null)
            //{
            //    Response.Write("<script>alert('查無此資料');</script>");
            //}
            //else
            //{
            //    for (int i = 0; i < dt.GetLength(0); i++)
            //    {
            //        String P_ID = dt[i, 0];
            //        String Name = dt[i, 1];
            //        String Firstvisit_Date = dt[i, 2];
            //        String Sex = dt[i, 3];
            //        String Identity = dt[i, 4];
            //        String Born_Date = dt[i, 5];
            //        String Phone = dt[i, 6];
            //        String addr = dt[i, 7];
            //        String note = dt[i, 8];
            //    }
            //}

            //GridView1.DataSource = data.getDataSet(strcmd);
            //GridView1.DataBind();
            DataSet dt = data.getDataSet(strcmd);

            ListView1.DataSource = dt;
            ListView1.DataBind();
        }

        protected void Clean_Click(object sender, EventArgs e)
        {
            Name.Value = "";
            P_ID.Value = "";
            identity.Value = "";
            Firstvisit_Date.Value = "";
            Born_Date.Value = "";
            Phone1.Value = "";
            Phone2.Value = "";
            Note.Value = "";
            Addr.Value = "";
            ListView1.DataSource = null;
            ListView1.DataBind();
        }

        protected void Insert_Click(object sender, EventArgs e)
        {
            bool iserror = false;
            String errormes = "<Script>alert('";
            if(Name.Value=="")
            {
                errormes += "姓名未填寫\\n";
                iserror = true;
            }
            if(identity.Value == "")
            {
                errormes += "身份證字號未填寫\\n";
                iserror = true;
            }
            if(Born_Date.Value == "")
            {
                errormes += "出生年月日未填寫\\n";
                iserror = true;
            }
            if(Phone1.Value == "" || Phone2.Value == "")
            {
                errormes += "電話未填寫\\n";
                iserror = true;
            }
            if(Addr.Value == "")
            {
                errormes += "地址未填寫\\n";
                iserror = true;
            }
            errormes += "')</Script>";
            
            if(iserror)
            {
                Response.Write(errormes);
            }
            else
            {
                String cmd= "select * from Patient where [identity]='"+ identity.Value + "'";
                if(data.used(cmd))
                {
                    Response.Write("<script  LANGUAGE='JavaScript'>alert('已註冊過');</script>");
                }
                else
                {
                    String firstDate;
                    if (Firstvisit_Date.Value == "")
                    {
                        firstDate = DateTime.Today.ToShortDateString().ToString();
                    }
                    else
                    {
                        firstDate = Firstvisit_Date.Value;
                    }
                    cmd = "Insert into Patient(Name,Firstvisit_Date,Sex,[identity],Born_Date,Phone,addr,Note) Values('" + Name.Value + "','" + firstDate + "','" + Sex.SelectedValue + "','" + identity.Value + "','" + Born_Date.Value + "','" + Phone1.Value + "','" + Addr.Value + "','" + Note.Value + "')";
                    if (data.execsql(cmd))
                    {
                        Response.Write("<script  LANGUAGE='JavaScript'>alert('新增成功');</script>");
                    }
                    {
                        Response.Write("<script  LANGUAGE='JavaScript'>alert('新增失敗');</script>");
                    }
                    ListView1.DataSource = null;
                    ListView1.DataBind();
                }
            }
        }

        public string checksex(object obj)
        {
            string sex = obj.ToString();
            if(sex=="0")
            {
                return "女";
            }
            else
            {
                return "男";
            }
        }

        protected void update_Click(object sender, CommandEventArgs e)
        {
            String P_ID = e.CommandArgument.ToString();
            String ava = "?P_ID="+P_ID;
            Response.Redirect("EditPatient.aspx"+ava);
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
    }
}
