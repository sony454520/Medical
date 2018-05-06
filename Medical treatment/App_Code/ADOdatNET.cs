using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;

namespace Medical_treatment
{
    internal class ADOdatNET
    {
        public ADOdatNET()
        {

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
            if(get_sqlcount(Strcmd)==0)
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