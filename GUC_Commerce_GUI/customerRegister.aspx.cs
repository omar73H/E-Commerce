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
    public partial class customerRegister : System.Web.UI.Page
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

        protected void register(object sender, EventArgs e)
        {
            //configuration
            //connection
            //the purpose of the method
            //Get the information of the connection to the database
            try
            {
                string connStr = ConfigurationManager.ConnectionStrings["GUI"].ToString();

                //create a new connection
                SqlConnection conn = new SqlConnection(connStr);

                /*create a new SQL command which takes as parameters the name of the stored procedure and
                 the SQLconnection name*/
                SqlCommand cmd = new SqlCommand("customerRegister", conn);
                cmd.CommandType = CommandType.StoredProcedure;

                //To read the input from the user
                string username = txt_username.Text;
                string fname = txt_firstname.Text;
                string lname = txt_lastname.Text;
                string password = txt_password.Text;
                string email = txt_email.Text;

                if (System.String.IsNullOrEmpty(fname) == true || System.String.IsNullOrEmpty(lname) == true
                || System.String.IsNullOrEmpty(password) == true || System.String.IsNullOrEmpty(email) == true ||
                     System.String.IsNullOrEmpty(username) == true)
                    Response.Write("Data is not completed, please complete it and try again");
                else
                {
                    //Executing the SQLCommand

                    //pass parameters to the stored procedure
                    cmd.Parameters.Add(new SqlParameter("@username", username));
                    cmd.Parameters.Add(new SqlParameter("@first_name", fname));
                    cmd.Parameters.Add(new SqlParameter("@last_name", lname));
                    cmd.Parameters.Add(new SqlParameter("@password", password));
                    cmd.Parameters.Add(new SqlParameter("@email", email));

                    conn.Open();
                    cmd.ExecuteNonQuery();
                    conn.Close();


                    Response.Redirect("HomeLogin.aspx", true);


                }
            }
            catch (Exception exception)
            {

                Response.Write("User name already used, try another one "+exception.Message);

            }



        }
    }
}