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
    public partial class MyCart : System.Web.UI.Page
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

                SqlCommand cmd = new SqlCommand("viewMyCartWithSerial", conn);//<------Add new proc
                cmd.CommandType = CommandType.StoredProcedure;
                string username = (string)(Session["currUser"]);

                //pass parameters to the stored procedure
                cmd.Parameters.Add(new SqlParameter("@customer", username));
                conn.Open();
                //IF the output is a table, then we can read the records one at a time
                SqlDataReader rdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
                int cnt = 0;
                while (rdr.Read())
                {
                    cnt++;
                    int productSerialno = rdr.GetInt32(rdr.GetOrdinal("serial_no"));
                    string productName = rdr.GetString(rdr.GetOrdinal("product_name"));
                    string productDescription = rdr.GetString(rdr.GetOrdinal("product_description"));
                    Decimal productPrice = rdr.GetDecimal(rdr.GetOrdinal("price"));
                    Decimal productFinalPrice = rdr.GetDecimal(rdr.GetOrdinal("final_price"));
                    string productColor = rdr.GetString(rdr.GetOrdinal("color"));

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

                    Button removeProductFromCartButton = new Button();
                    removeProductFromCartButton.CommandName = "" + productSerialno;
                    removeProductFromCartButton.Text = "Remove product from my cart";
                    removeProductFromCartButton.Click += new EventHandler(removeProductFromCartButton_Click);
                    form1.Controls.Add(removeProductFromCartButton);

                    Label space4 = new Label();
                    space4.Text = "<br />------------------------------------------------------------------------------------- <br />";
                    form1.Controls.Add(space4);

                }
                if (cnt == 0)
                {
                    Label empty = new Label();
                    empty.Text = "There is no products in your cart yet";
                    form1.Controls.Add(empty);
                }
                //this is how you retrive data from session variable.
                string field1 = (string)(Session["field1"]);
                Response.Write(field1);
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
    

}
}