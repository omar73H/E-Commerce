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
    public partial class CustomerHomePage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            bool isLoggedIn = HttpContext.Current.Session["LoggedIn"] == null ? false : (bool)HttpContext.Current.Session["LoggedIn"];

            if (!isLoggedIn)
            {
                Response.Redirect("HomeLogin.aspx");
            }


        }
        protected void CancelOrder(object sender, EventArgs e) {
            try
            {
                //Get the information of the connection to the database
                string connStr = ConfigurationManager.ConnectionStrings["GUI"].ToString();

                //create a new connection
                SqlConnection conn = new SqlConnection(connStr);

                /*create a new SQL command which takes as parameters the name of the stored procedure and
                 the SQLconnection name*/

                int orderID = (int)(Session["id"]);

                SqlCommand cmd = new SqlCommand("CHECKORDER", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@orderid", orderID));
                SqlParameter success = cmd.Parameters.Add("@success", SqlDbType.Int);
                success.Direction = ParameterDirection.Output;

                conn.Open();

                cmd.ExecuteNonQuery();
                conn.Close();

                connStr = ConfigurationManager.ConnectionStrings["GUI"].ToString();

                //create a new connection
                conn = new SqlConnection(connStr);

                /*create a new SQL command which takes as parameters the name of the stored procedure and
                 the SQLconnection name*/
                if (success.Value.ToString().Equals("0"))
                {
                    Response.Write("Cant cancel the order");
                }
                else
                {
                    orderID = (int)(Session["id"]);

                    cmd = new SqlCommand("cancelorder", conn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add(new SqlParameter("@orderid", orderID));

                    //Executing the SQLCommand
                    conn.Open();

                    cmd.ExecuteNonQuery();
                    conn.Close();

                    conn.Open();
                    Session["id"] = null;

                    Response.Write("Order Cancelled");


                }
            }
            catch (Exception) {
                Response.Write("Cart is empty ");

            }
        }
        protected void makeOrder(object sender, EventArgs e)
        {
            //configuration
            //connection
            //the purpose of the method
            try
            {
                string connStr = ConfigurationManager.ConnectionStrings["GUI"].ToString();

                //create a new connection
                SqlConnection conn = new SqlConnection(connStr);
                int there = 0;
                
                /*create a new SQL command which takes as parameters the name of the stored procedure and
                 the SQLconnection name*/
                if ((Session["id"] != null))
                {
                    int orderID = (int)(Session["id"]);

                    SqlCommand cmd1 = new SqlCommand("CHECKIFPAYED", conn);
                    cmd1.CommandType = CommandType.StoredProcedure;
                    cmd1.Parameters.Add(new SqlParameter("@order_id", orderID));
                    SqlParameter success = cmd1.Parameters.Add("@success", SqlDbType.Int);
                    success.Direction = ParameterDirection.Output;

                    conn.Open();

                    cmd1.ExecuteNonQuery();
                    conn.Close();

                    connStr = ConfigurationManager.ConnectionStrings["GUI"].ToString();

                    //create a new connection
                    conn = new SqlConnection(connStr);


                    /*create a new SQL command which takes as parameters the name of the stored procedure and
                     the SQLconnection name*/
                    if (success.Value.ToString().Equals("0"))
                    {
                        there = 1;
                        Response.Write("You must pay the order before ordering another one");
                    }

                }
                if (there == 0)
                {   




                    //Get the information of the connection to the database
                    connStr = ConfigurationManager.ConnectionStrings["GUI"].ToString();

                    //create a new connection
                    conn = new SqlConnection(connStr);

                    /*create a new SQL command which takes as parameters the name of the stored procedure and
                     the SQLconnection name*/


                    SqlCommand cmd = new SqlCommand("makeorder", conn);
                    cmd.CommandType = CommandType.StoredProcedure;

                    string username = (string)(Session["currUser"]);

                    //To read the input from the user
                    //pass parameters to the stored procedure
                    cmd.Parameters.Add(new SqlParameter("@customername", username));


                    //Executing the SQLCommand
                    conn.Open();

                    cmd.ExecuteNonQuery();
                    conn.Close();

                    conn.Open();

                    conn = new SqlConnection(connStr);

                    cmd = new SqlCommand("reviewOrders", conn);
                    cmd.CommandType = CommandType.StoredProcedure;

                    conn.Open();
                    SqlDataReader rdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
                    Decimal total = 0;
                    int orderid = 0;

                    while (rdr.Read())
                    {

                        Decimal orderamount = 0;
                        int order_no = rdr.GetInt32(rdr.GetOrdinal("order_no"));
                        //Get the value of the attribute field in the Company table
                        String custname = rdr.GetString(rdr.GetOrdinal("customer_name"));


                        if (!rdr.IsDBNull(rdr.GetOrdinal("total_amount")))
                            orderamount = rdr.GetDecimal(rdr.GetOrdinal("total_amount"));

                        if (custname == username)
                        {
                            if (orderid < order_no)
                            {
                                orderid = order_no;
                                total = orderamount;
                            }
                            //Create a new label and add it to the HTML form

                        }

                    }
                    if (total != 0)
                    {

                        Label lbl_CompanyName = new Label();
                        lbl_CompanyName.Text = "Order_id  " + orderid;
                        form1.Controls.Add(lbl_CompanyName);

                        Label lbl_CompanyField = new Label();
                        lbl_CompanyField.Text = "Orderamount " + total + "  <br /> <br />";
                        form1.Controls.Add(lbl_CompanyField);

                        Session["id"] = orderid;
                    }
                    else
                    {
                        Response.Write("Cart is empty add items to your cart ");

                    }

                }
            }
            catch (Exception ex)
            {
                Response.Write("Cart is empty "+ex.StackTrace);

            }
        }


        protected void logout_Click(object sender, EventArgs e)
        {
                Session["currUser"] = null;
                Session["LoggedIn"] = false;
                Session["type"] = null;
                Response.Redirect("Homelogin.aspx");
            
        }
    }
}