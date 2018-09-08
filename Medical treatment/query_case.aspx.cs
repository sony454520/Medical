using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Medical_treatment
{
    public partial class query_case : System.Web.UI.Page
    {
        ADOdatNET ADOdata = new ADOdatNET();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Serch_Click(object sender, EventArgs e)
        {
            DataSet data = ADOdata.QueryMedical_records(sDate.Value,eDate.Value,Name.Value,hasmoney.Checked);
            ListView1.DataSource = data;
            ListView1.DataBind();
        }
    }
}