using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;



public partial class ApplyOffer : System.Web.UI.Page
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

            SqlCommand cmd = new SqlCommand("showMyProductsAndOffers", conn);//<------Add new proc
            cmd.CommandType = CommandType.StoredProcedure;

            string vendorUsername = (string)Session["currUser"];

            cmd.Parameters.Add(new SqlParameter("@vendor_name", vendorUsername));



            conn.Open();
            //Response.Clear();
            //IF the output is a table, then we can read the records one at a time
            int cnt = 0;
            SqlDataReader rdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
            while (rdr.Read())
            {
                cnt++;
                int productSerialno = rdr.GetInt32(rdr.GetOrdinal("serial_no"));
                string product_name = rdr.GetString(rdr.GetOrdinal("product_name"));
                int? offerid = null;
                if (!rdr.IsDBNull(rdr.GetOrdinal("offer_id")))
                    offerid = rdr.GetInt32(rdr.GetOrdinal("offer_id"));
                DateTime? date = null;
                if (!rdr.IsDBNull(rdr.GetOrdinal("expiry_date")))
                    date = rdr.GetDateTime(rdr.GetOrdinal("expiry_date"));
                int? offer_amount = null;
                if (!rdr.IsDBNull(rdr.GetOrdinal("offer_amount")))
                   offer_amount = rdr.GetInt32(rdr.GetOrdinal("offer_amount"));

                //Create a new label and add it to the HTML form
                Label lbl_product_snum = new Label();
                lbl_product_snum.Text = "serial number : " + productSerialno + "  <br /> <br />";
                form1.Controls.Add(lbl_product_snum);

                Label lbl_product_name = new Label();
                lbl_product_name.Text = "Name : " + product_name + "  <br /> <br />";
                form1.Controls.Add(lbl_product_name);

                Label lbl_offerid = new Label();
                lbl_offerid.Text = offerid != null ? "current Offer id : " + offerid + "  <br /> <br />" : "current Offer id : There is no current active offers <br /> <br /> ";
                form1.Controls.Add(lbl_offerid);

                Label lbl_date = new Label();
                lbl_date.Text = date != null ? "Exipry Date : " + date + "  <br /> <br />" : "Exipry Date : " + "No Active Offer" + "  <br /> <br />";
                form1.Controls.Add(lbl_date);

                Label lbl_offer_amount = new Label();
                lbl_offer_amount.Text = offer_amount == null ? "Offer amount : " + offer_amount + "  <br /> <br />" : "Offer amount : " + "NO Active Offer" + "  <br /> <br />";
                form1.Controls.Add(lbl_offer_amount);



                // edit 
                Label lbl_apply = new Label();
                lbl_apply.Text = "Enter the id of the offer you wish to add :<br /> ";
                form1.Controls.Add(lbl_apply);

                Label lbl_newOfferID = new Label();
                lbl_newOfferID.Text = "new OfferID : ";
                form1.Controls.Add(lbl_newOfferID);

                TextBox txt_newOfferID = new TextBox();
                txt_newOfferID.ID = "newOffer_txt" + productSerialno;
                form1.Controls.Add(txt_newOfferID);


                Button apply = new Button();
                apply.CommandName = ""+productSerialno;
                apply.Text = "Apply Offer";
                apply.Click += new EventHandler(apply_Click);
                form1.Controls.Add(apply);

                Label space3 = new Label();
                space3.Text = "<br /> <br />";
                form1.Controls.Add(space3);

            }
            //this is how you retrive data from session variable.
            if (cnt == 0)
            {
                Label empty = new Label();
                empty.Text = "You have not posted products yet";
                form1.Controls.Add(empty);
            }
            string field1 = (string)(Session["field1"]);
            Response.Write(field1);
        }
    }

    protected void apply_Click(object sender, EventArgs e)
    {
        //configuration
        //connection
        //the purpose of the method
            //Get the information of the connection to the database
            string connStr = ConfigurationManager.ConnectionStrings["GUI"].ToString();

            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            /*create a new SQL command which takes as parameters the name of the stored procedure and
             the SQLconnection name*/
            SqlCommand cmd = new SqlCommand("applyOffer", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            //To read the input from the user
            Button button = (Button)sender;
            string vendor = (string)(Session["currUser"]);
            string serialno = button.CommandName;

            string textboxID = "newOffer_txt" + serialno;
            TextBox tb = (TextBox)(form1.FindControl(textboxID));
            string newOffer = tb.Text;
            if (System.String.IsNullOrEmpty(newOffer))
            {
                Response.Write("You should give the offer ID");
            }
            else
            {
                //pass parameters to the stored procedure
                cmd.Parameters.Add(new SqlParameter("@vendorname", vendor));
                cmd.Parameters.Add(new SqlParameter("@offerid", newOffer));
                cmd.Parameters.Add(new SqlParameter("@serial", serialno));

                //Executing the SQLCommand
                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();

                Response.Redirect("ApplyOffer.aspx");
            }
        }
        
    
}