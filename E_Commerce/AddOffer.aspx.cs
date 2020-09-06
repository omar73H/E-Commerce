using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

public partial class AddOffer : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        bool isLoggedIn = (HttpContext.Current.Session["LoggedIn"] == null) ? false : ((bool)HttpContext.Current.Session["LoggedIn"]);

        if (!isLoggedIn)
        {
            Response.Redirect("HomeLogin.aspx");
        }
    }

    protected void btn_addOffer_Click(object sender, EventArgs e)
    {
        try
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
            SqlCommand cmd = new SqlCommand("addOffer", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            //To read the input from the user
            string amount = txt_amount.Text;
            string ex_date = txt_ex_date.Text;
            if (System.String.IsNullOrEmpty(amount) || System.String.IsNullOrEmpty(ex_date))
            {
                Response.Write("You should fill all the fields");
            }
            else
            {
                //pass parameters to the stored procedure
                cmd.Parameters.Add(new SqlParameter("@offeramount", amount));
                cmd.Parameters.Add(new SqlParameter("@expiry_date", ex_date));

                //Executing the SQLCommand
                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
                Response.Write("The Offer is Added successfully");
            }
        }
        catch (Exception)
        {
            Response.Write("INVALID INPUT : please follow the specified format or enter correct data");
        }
    }
}