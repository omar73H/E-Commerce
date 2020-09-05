using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class VendorProfile : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        bool isLoggedIn = HttpContext.Current.Session["LoggedIn"] == null ? false : (bool)HttpContext.Current.Session["LoggedIn"];

        if (!isLoggedIn)
        {
            Response.Redirect("HomeLogin.aspx");
        }


    }


    protected void addMobile(object sender, EventArgs e)
    {
        //configuration
        //connection
        //the purpose of the method
        try
        {
            //Get the information of the connection to the database
            string connStr = ConfigurationManager.ConnectionStrings["GUI"].ToString();

            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            /*create a new SQL command which takes as parameters the name of the stored procedure and
             the SQLconnection name*/


            SqlCommand cmd = new SqlCommand("addMobile", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            string username = (string)(Session["currUser"]);
            string mobnum = txt_mobilenum.Text;
            if (System.String.IsNullOrEmpty(mobnum))
            {

                Response.Write("Data is not completed, please complete it and try again");
            }
            else
            {
                //To read the input from the user
                //pass parameters to the stored procedure
                cmd.Parameters.Add(new SqlParameter("@username", username));
                cmd.Parameters.Add(new SqlParameter("@mobile_number", mobnum));


                //Executing the SQLCommand
                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();

                Response.Write("Mobile number added successfully");
            }
        }
        catch (Exception)
        {
            Response.Write("You have already added same mobile number before");
        }
    }
}