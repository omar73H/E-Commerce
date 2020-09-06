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
    public partial class MyWishlist : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            bool isLoggedIn = HttpContext.Current.Session["LoggedIn"] == null ? false : (bool)HttpContext.Current.Session["LoggedIn"];

            if (!isLoggedIn)
            {
                Response.Redirect("HomeLogin.aspx");
            }
            else
            {
                string connStr = ConfigurationManager.ConnectionStrings["GUI"].ToString();
                SqlConnection conn = new SqlConnection(connStr);

                SqlCommand cmd = new SqlCommand("allWislists", conn);//<------Add new proc
                cmd.CommandType = CommandType.StoredProcedure;
                string username = (string)(Session["currUser"]);
                //pass parameters to the stored procedure
                cmd.Parameters.Add(new SqlParameter("@customername", username));

                conn.Open();

                //IF the output is a table, then we can read the records one at a time
                SqlDataReader rdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
                List<string> list = new List<string>();
                while (rdr.Read())
                {
                    string wishlistName = rdr.GetString(rdr.GetOrdinal("name"));
                    list.Add(wishlistName);


                }
                conn.Close();
                if (list.Count == 0)
                {
                    Label empty = new Label();
                    empty.Text = "You don't have wishlists yet";
                    form1.Controls.Add(empty);
                }
                else
                {
                    int count = 0;
                    for (int i = 0; i < list.Count; i++)
                    {
                        string wishlistName = list[i];

                        Label name = new Label();
                        name.Text = "Wishlist " + wishlistName + " :<br /> <br />";
                        form1.Controls.Add(name);

                        SqlCommand cmd2 = new SqlCommand("showWishlistProductWithSerial", conn);//<------Add new proc
                        cmd2.CommandType = CommandType.StoredProcedure;
                        //pass parameters to the stored procedure
                        cmd2.Parameters.Add(new SqlParameter("@customername", username));
                        cmd2.Parameters.Add(new SqlParameter("@name", wishlistName));
                        conn.Open();

                        //IF the output is a table, then we can read the records one at a time
                        SqlDataReader rdr2 = cmd2.ExecuteReader(CommandBehavior.CloseConnection);
                        int cnt = 0;
                        while (rdr2.Read())
                        {
                            cnt++;
                            count++;
                            int productSerialno = rdr2.GetInt32(rdr2.GetOrdinal("serial_no"));
                            string productName = rdr2.GetString(rdr2.GetOrdinal("product_name"));
                            string productDescription = rdr2.GetString(rdr2.GetOrdinal("product_description"));
                            Decimal productPrice = rdr2.GetDecimal(rdr2.GetOrdinal("price"));
                            Decimal productFinalPrice = rdr2.GetDecimal(rdr2.GetOrdinal("final_price"));
                            string productColor = rdr2.GetString(rdr2.GetOrdinal("color"));

                            //Create a new label and add it to the HTML form
                            Label lbl_product_name = new Label();
                            lbl_product_name.Text = "Name : " + productName + "  <br /> <br />";
                            form1.Controls.Add(lbl_product_name);

                            Label lbl_product_description = new Label();
                            lbl_product_description.Text = "Description : " + productDescription + "  <br /> <br />";
                            form1.Controls.Add(lbl_product_description);

                            Label lbl_product_price = new Label();
                            lbl_product_price.Text = "Price : " + productPrice + "  ";
                            form1.Controls.Add(lbl_product_price);

                            Label lbl_product_final_price = new Label();
                            lbl_product_final_price.Text = "Final price : " + productFinalPrice + "  ";
                            form1.Controls.Add(lbl_product_final_price);

                            Label lbl_product_color = new Label();
                            lbl_product_color.Text = "Color : " + productColor + "  <br /> <br />";
                            form1.Controls.Add(lbl_product_color);

                            Button addProductToCartButton = new Button();
                            addProductToCartButton.CommandName = "" + productSerialno;
                            addProductToCartButton.Text = "Add product to my cart";
                            addProductToCartButton.Click += new EventHandler(addProductToCartButton_Click);
                            form1.Controls.Add(addProductToCartButton);

                            Label space3 = new Label();
                            space3.Text = "<br /> <br />";
                            form1.Controls.Add(space3);

                            Button removeProductFromCartButton = new Button();
                            removeProductFromCartButton.CommandName = "" + productSerialno;
                            removeProductFromCartButton.Text = "Remove product from my cart";
                            removeProductFromCartButton.Click += new EventHandler(removeProductFromCartButton_Click);
                            form1.Controls.Add(removeProductFromCartButton);

                            Label space2 = new Label();
                            space2.Text = "<br /> <br />";
                            form1.Controls.Add(space2);

                            Button removeProductFromWishButton = new Button();
                            removeProductFromWishButton.CommandName = "" + productSerialno;
                            removeProductFromWishButton.CommandArgument = wishlistName;
                            removeProductFromWishButton.Text = "Remove product from this wishlist";
                            removeProductFromWishButton.Click += new EventHandler(removeProductFromWishButton_Click);
                            form1.Controls.Add(removeProductFromWishButton);

                            Label space4 = new Label();
                            space4.Text = "<br />------------------------------------------------------------------------------------- <br />";
                            form1.Controls.Add(space4);
                        }
                        if (cnt == 0)
                        {
                            Label empty2 = new Label();
                            empty2.Text = "There is no products in this wishlist yet<br />------------------------------------------------------------------------------------- <br /> <br />";
                            form1.Controls.Add(empty2);
                        }
                        conn.Close();
                    }
                }
                //this is how you retrive data from session variable.
                string field1 = (string)(Session["field1"]);
                Response.Write(field1);
            }
        }

        protected void addProductToCartButton_Click(object sender, EventArgs e)
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
                SqlCommand cmd = new SqlCommand("addToCart", conn);
                cmd.CommandType = CommandType.StoredProcedure;

                //To read the input from the user
                Button button = (Button)sender;
                string username = (string)(Session["currUser"]);
                string serialno = button.CommandName;

                //pass parameters to the stored procedure
                cmd.Parameters.Add(new SqlParameter("@customername", username));
                cmd.Parameters.Add(new SqlParameter("@serial", serialno));


                //Executing the SQLCommand
                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
                Response.Write("Product added Successfully to your cart");
            }
            catch (Exception ex)
            {
                Response.Write("Product already exists in your cart");
            }

        }
        protected void removeProductFromCartButton_Click(object sender, EventArgs e)
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
                SqlCommand cmd = new SqlCommand("removefromCart", conn);
                cmd.CommandType = CommandType.StoredProcedure;

                //To read the input from the user
                Button button = (Button)sender;
                string username = (string)(Session["currUser"]);
                string serialno = button.CommandName;

                //pass parameters to the stored procedure
                cmd.Parameters.Add(new SqlParameter("@customername", username));
                cmd.Parameters.Add(new SqlParameter("@serial", serialno));

                SqlParameter success = cmd.Parameters.Add("@success", SqlDbType.Int);
                success.Direction = ParameterDirection.Output;

                //Executing the SQLCommand
                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();

                if (success.Value.ToString().Equals("1"))
                {
                    Response.Write("The product removed successfully from your cart");
                }
                else
                {
                    Response.Write("The product is not in your cart yet ");
                }

            }
            catch (Exception exc)
            {
                Response.Write("The product is not in your cart yet ");
            }
        }
        protected void removeProductFromWishButton_Click(object sender, EventArgs e)
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
                SqlCommand cmd = new SqlCommand("removefromWishlist", conn);
                cmd.CommandType = CommandType.StoredProcedure;

                //To read the input from the user
                Button button = (Button)sender;
                string username = (string)(Session["currUser"]);
                string serialno = button.CommandName;
                string wishname = button.CommandArgument;
                //pass parameters to the stored procedure
                cmd.Parameters.Add(new SqlParameter("@customername", username));
                cmd.Parameters.Add(new SqlParameter("@wishlistname", wishname));
                cmd.Parameters.Add(new SqlParameter("@serial", serialno));

                SqlParameter success = cmd.Parameters.Add("@success", SqlDbType.Int);
                success.Direction = ParameterDirection.Output;

                //Executing the SQLCommand
                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();

                if (success.Value.ToString().Equals("1"))
                {
                    Response.Write("Product removed from wishlist " + wishname + " successfully");
                }
                else
                {
                    Response.Write("You didn't make any wishlists with name " + wishname);
                }

            }
            catch (Exception exc)
            {
                Response.Write("You don't have this product in this wishlist " + exc);
            }
        }


    }
}