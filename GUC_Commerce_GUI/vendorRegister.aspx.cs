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
    public partial class vendorRegister : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            bool isLoggedIn = HttpContext.Current.Session["LoggedIn"] == null ? false : (bool)HttpContext.Current.Session["LoggedIn"];

            if (isLoggedIn)
            {
                if(((string)Session["type"]).Equals("vendor"))
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
                SqlCommand cmd = new SqlCommand("vendorRegister", conn);
                cmd.CommandType = CommandType.StoredProcedure;

                //To read the input from the user
                string username = txt_username.Text;
                string fname = txt_firstname.Text;
                string lname = txt_lastname.Text;
                string password = txt_password.Text;
                string email = txt_email.Text;
                string company_name = txt_company_name.Text;
                string bank_acc_no = txt_bank_acc_no.Text;
                if (System.String.IsNullOrEmpty(username) || System.String.IsNullOrEmpty(fname) || System.String.IsNullOrEmpty(lname)
                    || System.String.IsNullOrEmpty(password) || System.String.IsNullOrEmpty(email) ||
                         System.String.IsNullOrEmpty(company_name) || System.String.IsNullOrEmpty(bank_acc_no))
                {

                    Response.Write("Data is not completed, please complete it and try again");
                }
                else
                {
                    //pass parameters to the stored procedure
                    cmd.Parameters.Add(new SqlParameter("@username", username));
                    cmd.Parameters.Add(new SqlParameter("@first_name", fname));
                    cmd.Parameters.Add(new SqlParameter("@last_name", lname));
                    cmd.Parameters.Add(new SqlParameter("@password", password));
                    cmd.Parameters.Add(new SqlParameter("@email", email));
                    cmd.Parameters.Add(new SqlParameter("@company_name", company_name));
                    cmd.Parameters.Add(new SqlParameter("@bank_acc_no", bank_acc_no));


                    //Executing the SQLCommand
                    conn.Open();
                    cmd.ExecuteNonQuery();
                    conn.Close();
                    Response.Redirect("HomeLogin.aspx", true);

                    // if valid registration 
                }
            }
            catch(Exception)
            {
                Response.Write("Username already Used, Try another one");
            }
        }
    }
}