using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace GUC_Commerce_GUI
{
    public partial class MyProfile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            bool isLoggedIn = HttpContext.Current.Session["LoggedIn"] == null ? false : (bool)HttpContext.Current.Session["LoggedIn"];

            if (!isLoggedIn)
            {
                Response.Redirect("HomeLogin.aspx");
            }
        }
        protected void addCC1(object sender, EventArgs e)
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
                SqlCommand cmd = new SqlCommand("AddCreditCard", conn);
                cmd.CommandType = CommandType.StoredProcedure;

                //To read the input from the user
                string username = (string)(Session["currUser"]);
                string num = ccnumber.Text;
                string date = ccexpirydate.Text;
                string cvv1 = cvv.Text; //not sure <-----------------
                if (System.String.IsNullOrEmpty(num) || System.String.IsNullOrEmpty(date)
                || System.String.IsNullOrEmpty(cvv1))
                {

                    Response.Write("Data is not completed, please complete it and try again");
                }
                else
                {
                    //pass parameters to the stored procedure
                    cmd.Parameters.Add(new SqlParameter("@customername", username));
                    cmd.Parameters.Add(new SqlParameter("@creditcardnumber", num));
                    cmd.Parameters.Add(new SqlParameter("@expirydate", date));
                    cmd.Parameters.Add(new SqlParameter("@cvv", cvv1));

                    //Executing the SQLCommand
                    conn.Open();
                    cmd.ExecuteNonQuery();
                    conn.Close();

                    Response.Write("Credit card successfully added to your account");
                }
            }
            catch (Exception ex)
            {
                Response.Write("You should follow the specified format");
            }
        }
        protected void createWishlist(object sender, EventArgs e)
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
                SqlCommand cmd = new SqlCommand("createWishlist", conn);
                cmd.CommandType = CommandType.StoredProcedure;

                //To read the input from the user
                string username = (string)(Session["currUser"]);
                string wlname = txt_wishlistname.Text;
                if (System.String.IsNullOrEmpty(wlname))
                {

                    Response.Write("Data is not completed, please complete it and try again");
                }
                else
                {
                    //pass parameters to the stored procedure
                    cmd.Parameters.Add(new SqlParameter("@customername", username));
                    cmd.Parameters.Add(new SqlParameter("@name", wlname));


                    //Executing the SQLCommand
                    conn.Open();
                    cmd.ExecuteNonQuery();
                    conn.Close();

                    Response.Write("Wishlist " + wlname + " successfully created");
                }
            }
            catch (Exception)
            {
                Response.Write("You have already created a wishlist with the same name before");
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
}