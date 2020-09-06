using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

public partial class viewMyProducts : System.Web.UI.Page
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

            SqlCommand cmd = new SqlCommand("vendorviewProducts", conn);//<------Add new proc
            cmd.CommandType = CommandType.StoredProcedure;

            string vendorUsername =(string) Session["currUser"];

            cmd.Parameters.Add(new SqlParameter("@vendorname", vendorUsername));



            conn.Open();
            //Response.Clear();
            //IF the output is a table, then we can read the records one at a time
            int cnt = 0;
            SqlDataReader rdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
            while (rdr.Read())
            {
                cnt++;
                int productSerialno = rdr.GetInt32(rdr.GetOrdinal("serial_no"));
                string productName = rdr.GetString(rdr.GetOrdinal("product_name"));
                string category = rdr.GetString(rdr.GetOrdinal("category"));
                string productDescription = rdr.GetString(rdr.GetOrdinal("product_description"));
                Decimal productPrice = rdr.GetDecimal(rdr.GetOrdinal("price"));
                Decimal productFinalPrice = rdr.GetDecimal(rdr.GetOrdinal("final_price"));
                string productColor = rdr.GetString(rdr.GetOrdinal("color"));
                // is there a smaller size integer data type than int
                bool available = rdr.GetBoolean(rdr.GetOrdinal("available"));
                int? rate=null;
                if (!rdr.IsDBNull(rdr.GetOrdinal("rate")))
                    rate = rdr.GetInt32(rdr.GetOrdinal("rate"));
                string vendor = rdr.GetString(rdr.GetOrdinal("vendor_username"));
                int? customerOrderID = null;
                if (!rdr.IsDBNull(rdr.GetOrdinal("customer_order_id")))
                    customerOrderID = rdr.GetInt32(rdr.GetOrdinal("customer_order_id"));
                //Create a new label and add it to the HTML form
                Label lbl_product_snum = new Label();
                lbl_product_snum.Text = "serial number : " + productSerialno + "  <br /> <br />";
                form1.Controls.Add(lbl_product_snum);

                Label lbl_product_name = new Label();
                lbl_product_name.Text = "Name : " + productName + "  <br /> <br />";
                form1.Controls.Add(lbl_product_name);

                Label lbl_product_cat = new Label();
                lbl_product_cat.Text = "category : " + category + "  <br /> <br />";
                form1.Controls.Add(lbl_product_cat);

                Label lbl_product_description = new Label();
                lbl_product_description.Text = "Description : " + productDescription + "  <br /> <br />";
                form1.Controls.Add(lbl_product_description);

                Label lbl_product_price = new Label();
                lbl_product_price.Text = "Price : " + productPrice + "  ";
                form1.Controls.Add(lbl_product_price);

                Label lbl_product_final_price = new Label();
                lbl_product_final_price.Text = "Final price : " + productFinalPrice + "<br /> <br />  ";
                form1.Controls.Add(lbl_product_final_price);

                Label lbl_product_color = new Label();
                lbl_product_color.Text = "Color : " + productColor + "  <br /> <br />";
                form1.Controls.Add(lbl_product_color);

                Label lbl_product_av = new Label();
                lbl_product_av.Text = "Availability : " + available + "  <br /> <br />";
                form1.Controls.Add(lbl_product_av);

                Label lbl_product_rate = new Label();
                lbl_product_rate.Text = rate != null ? "Rate : " + rate + "  <br /> <br />" : "Rate : " + "unrated (not yet rated)" + "  <br /> <br />";
                form1.Controls.Add(lbl_product_rate);

                Label lbl_product_vendor = new Label();
                lbl_product_vendor.Text = "vendor : " + vendor + "  <br /> <br />";
                form1.Controls.Add(lbl_product_vendor);

                Label lbl_product_coID = new Label();
                lbl_product_coID.Text = customerOrderID != null ? "Customer Order ID : " + customerOrderID + "  <br /> <br />" : "Customer Order ID : " + "no one purchased this item yet" + "  <br /> <br />";
                form1.Controls.Add(lbl_product_coID);



                // edit 
                Label lbl_edit = new Label();
                lbl_edit.Text = "enter the fields that you want to edit in your product :<br /> ";
                form1.Controls.Add(lbl_edit);

                Label lbl_pname = new Label();
                lbl_pname.Text = "Product Name : ";
                form1.Controls.Add(lbl_pname);

                TextBox txt_pname = new TextBox();
                txt_pname.ID = "edit_pname" + productSerialno;
                form1.Controls.Add(txt_pname);


                Label lbl_category = new Label();
                lbl_category.Text = "Category : ";
                form1.Controls.Add(lbl_category);

                TextBox txt_category = new TextBox();
                txt_category.ID = "edit_category" + productSerialno;
                form1.Controls.Add(txt_category);

                Label lbl_product_desc = new Label();
                lbl_product_desc.Text = "product description : ";
                form1.Controls.Add(lbl_product_desc);

                TextBox txt_product_desc = new TextBox();
                txt_product_desc.ID = "edit_product_desc" + productSerialno;
                form1.Controls.Add(txt_product_desc);


                Label lbl_price = new Label();
                lbl_price.Text = "price : ";
                form1.Controls.Add(lbl_price);

                TextBox txt_price = new TextBox();
                txt_price.ID = "edit_price" + productSerialno;
                form1.Controls.Add(txt_price);


                Label lbl_color = new Label();
                lbl_color.Text = "color : ";
                form1.Controls.Add(lbl_color);

                TextBox txt_color = new TextBox();
                txt_color.ID = "edit_color" + productSerialno;
                form1.Controls.Add(txt_color);


                Button edit = new Button();
                edit.CommandName = "" + productSerialno;
                edit.Text = "Edit";
                edit.Click += new EventHandler(edit_Click);
                form1.Controls.Add(edit);

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

    protected void edit_Click(object sender, EventArgs e)
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
            SqlCommand cmd = new SqlCommand("EditProduct", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            //To read the input from the user
            Button button = (Button)sender;
            string vendor = (string)(Session["currUser"]);
            string serialno = button.CommandName;
            
            string textboxID = "edit_pname" + serialno;
            TextBox tb = (TextBox)form1.FindControl(textboxID);
            string pname_edited = tb.Text;

            string textboxID2 = "edit_category" + serialno;
            TextBox tb2 = (TextBox)form1.FindControl(textboxID2);
            string category_edited = tb2.Text;

            string textboxID3 = "edit_product_desc" + serialno;
            TextBox tb3 = (TextBox)form1.FindControl(textboxID3);
            string product_desc_edited = tb3.Text;

            string textboxID4 = "edit_price" + serialno;
            TextBox tb4 = (TextBox)form1.FindControl(textboxID4);
            string price_edited = tb4.Text;

            string textboxID5 = "edit_color" + serialno;
            TextBox tb5 = (TextBox)form1.FindControl(textboxID5);
            string color_edited = tb5.Text;


            //pass parameters to the stored procedure
            cmd.Parameters.Add(new SqlParameter("@vendorname", vendor));
            cmd.Parameters.Add(new SqlParameter("@serialnumber", serialno));
            if (System.String.IsNullOrEmpty(pname_edited))
            {
                cmd.Parameters.Add(new SqlParameter("@product_name", DBNull.Value));
            }
            else
            {
                cmd.Parameters.Add(new SqlParameter("@product_name", pname_edited));
            }
            if (System.String.IsNullOrEmpty(category_edited))
            {

                cmd.Parameters.Add(new SqlParameter("@category", DBNull.Value));
            }
            else
            {
                cmd.Parameters.Add(new SqlParameter("@category", category_edited));
            }
            if (System.String.IsNullOrEmpty(product_desc_edited))
            {

                cmd.Parameters.Add(new SqlParameter("@product_description", DBNull.Value));
            }
            else
            {
                cmd.Parameters.Add(new SqlParameter("@product_description", product_desc_edited));
            }
            if (System.String.IsNullOrEmpty(price_edited))
            {

                cmd.Parameters.Add(new SqlParameter("@price", DBNull.Value));
            }
            else
            {
                cmd.Parameters.Add(new SqlParameter("@price", price_edited));
            }
        if (System.String.IsNullOrEmpty(color_edited))
            {

                cmd.Parameters.Add(new SqlParameter("@color", DBNull.Value));
            }
            else
            {
                cmd.Parameters.Add(new SqlParameter("@color", color_edited));
            }
            //Executing the SQLCommand
            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();

            Response.Redirect("viewMyProducts.aspx");
    }

}