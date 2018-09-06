using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Medical_treatment
{
    public partial class query_drug : System.Web.UI.Page
    {
        ADOdatNET dataconect = new ADOdatNET();
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void Serch_Click(object sender, EventArgs e)
        {
            DataSet mailinfo = dataconect.QueryMail_records(sDate.Value, eDate.Value, Name.Value, hasmoney.Checked);
            
        }
    }
}