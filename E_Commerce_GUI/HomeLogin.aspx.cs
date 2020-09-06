using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

namespace GUC_Commerce_GUI
{
    public partial class HomeLogin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            bool isLoggedIn = HttpContext.Current.Session["LoggedIn"] == null ? false : (bool)HttpContext.Current.Session["LoggedIn"];

            if (isLoggedIn)
            {
                if (((string)Session["type"]).Equals("vendor"))
                {
                    Response.Redirect("vendorHomePage.aspx");
                }
                else
                {

                    Response.Redirect("customerHomePage.aspx");
                }
            }
        }

        protected void login(object sender, EventArgs e)
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
            SqlCommand cmd = new SqlCommand("userLogin", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            //To read the input from the user
            string username = txt_username.Text;
            string password = txt_password.Text;

            //pass parameters to the stored procedure
            cmd.Parameters.Add(new SqlParameter("@username", username));
            cmd.Parameters.Add(new SqlParameter("@password", password));

            //Save the output from the procedure
            SqlParameter type = cmd.Parameters.Add("@type", SqlDbType.Int);
            SqlParameter success = cmd.Parameters.Add("@success", SqlDbType.Int);
            type.Direction = ParameterDirection.Output;
            success.Direction = ParameterDirection.Output;
            //Executing the SQLCommand
            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();


            if (success.Value.ToString().Equals("1") && (type.Value.ToString().Equals("0")))
            {//customer
                //redirect to another page


                //To send response data to the client side (HTML)
                //    Response.Write("Passed");
                Session["currUser"] = username;
                Session["LoggedIn"] = true;
                Session["type"] = "customer";
                Response.Redirect("CustomerHomePage.aspx", true);
                /*ASP.NET session state enables you to store and retrieve values for a user
                as the user navigates ASP.NET pages in a Web application.
                This is how we store a value in the session*/
                // to make the username global



                //To navigate to another webpage
                //  Response.Redirect("ourProducts.aspx", true);

            }
            else if ((success.Value.ToString().Equals("1") && (type.Value.ToString().Equals("1"))))
            {//vendor
                Session["currUser"] = username;
                Session["LoggedIn"] = true;
                Session["type"] = "vendor";
                Response.Redirect("VendorHomePage.aspx", true);
            }
            else {
                Response.Write("Please enter right info");
            }
        }
    }
}