using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Globalization;

namespace Medical_treatment
{
    internal class ADOdatNET
    {

        public ADOdatNET()
        {

        }



        public void RecordReceipt_Date(string Date, string PH_ID)//更新證明日期
        {
            string query = "Update Medical_records";
            query += string.Format(" Set Receipt_Date = {0} ", DateTime.Parse(Date).ToShortDateString());
            query += string.Format(" where PH_ID = '{0}' ", PH_ID);
        }
        public void RecordProveDate(string Date, string PH_ID)//更新證明日期
        {
            string query = "Update Medical_records";
            query += string.Format(" Set Prove_Date = {0} ", DateTime.Parse(Date).ToShortDateString());
            query += string.Format(" where PH_ID = '{0}' ", PH_ID);
        }
        public DataSet QueryMail_records(string startday, string endday, string recipient, bool hasmoney) //查詢郵寄資料
        {
            string query = "select  [dbo].[udfTaiwanDateFormat] (Send_Date,'yy/mm/dd') Send_Date, Datepart(year, Send_Date)-1911 year,Datepart(month, Send_Date) month,Datepart(day, Send_Date) day ,";
            query += "recipient,Cost,Zipcode,Addr,Medicine,Owed,m_id  from Mail_Record ";
            query += " where ";
            if (startday != "") query += " Send_Date >= CONVERT(datetime,'" + ToSimpleUSDate(startday) + "', 111)";
            if (endday != "") query += " and Send_Date <= CONVERT(datetime,'" + ToSimpleUSDate(endday) + "', 111)";
            if (recipient != "") query += string.Format(" and Name like '%{0}%' ", recipient);
            if (hasmoney) query += " Owed not like '0' ";
            return getDataSet(query);
        }

        public String GetBigNumber(int num ) //數字金額轉大寫
        {
            string[] chineseNumber = { "零", "壹", "貳", "參", "肆", "伍", "陸", "柒", "捌", "玖" };
            string[] unit = { "", "拾", "佰", "仟", "萬", "壹拾萬"};
            StringBuilder ret = new StringBuilder();
            string inputNumber = num.ToString();
            int idx = inputNumber.Length;
            bool needAppendZero = false;
            foreach (char c in inputNumber)
            {
                idx--;
                if (c > '0')
                {
                    if (needAppendZero)
                    {
                        ret.Append(chineseNumber[0]);
                        needAppendZero = false;
                    }
                    ret.Append(chineseNumber[(int)(c - '0')] + unit[idx]);
                }
                else
                    needAppendZero = true;
            }
            return ret.Length == 0 ? chineseNumber[0] : ret.ToString();
        }

        public DataSet QueryPrintProve(string ph_id) //列印證明
        {
            string query = "select Datepart(year, a.prove_date)-1911 year,Datepart(month, a.prove_date) month,Datepart(day, a.prove_date) day," +
                             "b.name,(case when b.sex = 0 then '女' else '男' end ) sex , FLOOR(DATEDIFF(DY, b.born_date, GETDATE()) / 365.25) age," +
                             "b.addr,a.wound,Datepart(year, a.hdate)-1911 hdateYear,Datepart(month, a.hdate) hdateMonth,Datepart(day, a.hdate) hdateDate,b.[identity] ";
            query += "from Medical_records a,Patient b";
            query += " where a.P_ID = b.P_ID ";
            query += string.Format(" and a.PH_ID = {0}", ph_id);
            return getDataSet(query);
        }

        public DataSet QueryPrintReceipt(string ph_id) //列印收據
        {
            string query = "select Datepart(year, a.receipt_date)-1911 year,Datepart(month, a.receipt_date) month,Datepart(day, a.receipt_date) day," +
                            "b.name,a.cost,Datepart(year, a.hdate) - 1911 hdateYear,Datepart(month, a.hdate) hdateMonth,Datepart(day, a.hdate) hdateDay ";
            query += "from Medical_records a,Patient b";
            query += " where a.P_ID = b.P_ID ";
            query += string.Format(" and a.PH_ID = {0}", ph_id);
            return getDataSet(query);
        }


        public DataSet QueryMedical_records(string startday, string endday, string name, bool hasmoney) //查詢病歷資料
        {
            string query = "Select PH_ID,[dbo].[udfTaiwanDateFormat] (a.Hdate,'yy/mm/dd') Hdate,a.Hdate seq,a.Wound,a.medicine,a.cost,a.Owed," +
                              "[dbo].[udfTaiwanDateFormat] (a.Prove_Date,'yy/mm/dd') Prove_Date, [dbo].[udfTaiwanDateFormat] (a.Receipt_Date,'yy/mm/dd') Receipt_Date,b.name ";
            query += "from Medical_records a,Patient b";
            query += " where a.P_ID = b.P_ID ";
            if (startday != "") query += " and Hdate >= CONVERT(datetime,'" + ToSimpleUSDate(startday) + "', 111)";
            if (endday != "") query += " and Hdate <= CONVERT(datetime,'" + ToSimpleUSDate(endday) + "', 111)";
            if (name != "") query += string.Format(" and Name like '%{0}%' ", name);
            if (hasmoney) query += " and owed > 0 ";
            query += " order by seq desc";
            return getDataSet(query);
        }

        public String ToSimpleTaiwanDate(DateTime datetime) //轉民國
        {
            TaiwanCalendar taiwanCalendar = new TaiwanCalendar();
            return string.Format("{0}/{1}/{2}",
                taiwanCalendar.GetYear(datetime),
                datetime.Month,
                datetime.Day);
        }

        public String ToSimpleUSDate(String dtx) //轉西元
        {
            if (dtx != "")
            {
                DateTime my_date = DateTime.Parse(dtx);
                string[] datearray = dtx.Split('/');
                if (datearray[0].Length == 2)
                {

                    return string.Format("{0}/{1}/{2}", my_date.Year + 11, my_date.Month, my_date.Day);
                }
                else
                {
                    return string.Format("{0}/{1}/{2}", (Int32.Parse(my_date.Year.ToString()) + 1911), my_date.Month, my_date.Day);
                }

                //return string.Format("{0}/{1}/{2}", my_date.Year , my_date.Month, my_date.Day);
            }
            return "";

        }

        public DataSet getDataSet(String Strcmd)//取得資料庫資料 DataSet
        {
            DataSet ds = new DataSet();

            string connString = WebConfigurationManager.ConnectionStrings["Medical treatment"].ConnectionString;
            SqlConnection conn = new SqlConnection(connString);
            SqlCommand command = new SqlCommand(Strcmd, conn);

            SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(command);
            sqlDataAdapter.Fill(ds);

            return ds;
        }
        public String[,] Getdata(String Strcmd)//取得資料庫資料 DataReader
        {
            string connString = WebConfigurationManager.ConnectionStrings["Medical treatment"].ConnectionString;
            SqlConnection conn = new SqlConnection(connString);
            conn.Open();
            SqlCommand cmd = new SqlCommand(Strcmd, conn);
            SqlDataReader dt = cmd.ExecuteReader();
            if (dt.HasRows)
            {
                int Row = get_sqlcount(Strcmd);
                int Count = dt.FieldCount;
                String[,] table = new String[Row, Count];
                for (int i = 0; i < Row; i++)
                {
                    dt.Read();
                    for (int j = 0; j < Count; j++)
                    {
                        table[i, j] = Re_blank(dt[j].ToString());
                    }
                }
                conn.Close();
                conn.Dispose();
                dt.Close();
                cmd.Dispose();
                cmd.Clone();
                return table;
            }
            conn.Close();
            conn.Dispose();
            dt.Close();
            cmd.Dispose();
            cmd.Clone();
            return null;
        }
        public int get_sqlcount(String Strcmd)//取得資料庫數量
        {
            string connString = WebConfigurationManager.ConnectionStrings["Medical treatment"].ConnectionString;
            SqlConnection conn = new SqlConnection(connString);
            conn.Open();
            SqlCommand cmd = new SqlCommand(Strcmd, conn);
            SqlDataReader dt = cmd.ExecuteReader();
            int count = 0;
            if (dt.HasRows)
            {
                while (dt.Read())
                {
                    count++;
                }
            }
            conn.Close();
            conn.Dispose();
            dt.Close();
            cmd.Dispose();
            cmd.Clone();
            return count;
        }
        public String Re_blank(String str)//去除空白字元
        {
            int n = str.Length;
            for (int i = str.Length - 1; i >= 0; i--)
            {
                if (str.Substring(i, 1) != " ")
                {
                    n = i + 1;
                    break;
                }
            }
            return str.Substring(0, n);
        }
        public bool used(String Strcmd)
        {
            if (get_sqlcount(Strcmd) == 0)
            {
                return false;
            }
            else
            {
                return true;
            }
        }
        public Boolean execsql(String Strcmd)//執行SQL
        {
            string connString = WebConfigurationManager.ConnectionStrings["Medical treatment"].ConnectionString;
            SqlConnection conn = new SqlConnection(connString);
            SqlCommand command = new SqlCommand(Strcmd, conn);
            try
            {
                conn.Open();
                command.ExecuteNonQuery();
                return true;
            }
            catch
            {
                return false;
            }
            finally
            {
                conn.Close();
                conn.Dispose();
            }
        }


    }
}