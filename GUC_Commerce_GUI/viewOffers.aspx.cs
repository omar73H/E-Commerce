using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
public partial class viewOffers : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        bool isLoggedIn = (HttpContext.Current.Session["LoggedIn"] == null) ? false : ((bool)HttpContext.Current.Session["LoggedIn"]);

        if (!isLoggedIn)
        {
            Response.Redirect("HomeLogin.aspx");
        }
        else
        {
            string connStr = ConfigurationManager.ConnectionStrings["GUI"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand cmd = new SqlCommand("viewOffers", conn);//<------Add new proc
            cmd.CommandType = CommandType.StoredProcedure;




            conn.Open();
            //Response.Clear();
            //IF the output is a table, then we can read the records one at a time
            int cnt = 0;
            SqlDataReader rdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
            while (rdr.Read())
            {
                cnt++;
                int offerID = rdr.GetInt32(rdr.GetOrdinal("offer_id"));
                int offerAmount = rdr.GetInt32(rdr.GetOrdinal("offer_amount"));
                DateTime exDate = rdr.GetDateTime(rdr.GetOrdinal("expiry_date"));

                //Create a new label and add it to the HTML form
                Label lbl_offerID = new Label();
                lbl_offerID.Text = "Offer ID : " + offerID + "  <br /> <br />";
                form1.Controls.Add(lbl_offerID);

                Label lbl_offerAmount = new Label();
                lbl_offerAmount.Text = "offer amount : " + offerAmount + "  <br /> <br />";
                form1.Controls.Add(lbl_offerAmount);

                Label lbl_exDate = new Label();
                lbl_exDate.Text = "expiry date : " + exDate + "  <br /> <br />";
                form1.Controls.Add(lbl_exDate);

                Label lbl_break = new Label();
                lbl_break.Text = "_______________________________ <br /> <br />";
                form1.Controls.Add(lbl_break);

            }
        }
    }
}