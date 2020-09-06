using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

public partial class PostProduct : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        bool isLoggedIn = HttpContext.Current.Session["LoggedIn"] == null ? false : (bool)HttpContext.Current.Session["LoggedIn"];

        if (!isLoggedIn)
        {
            Response.Redirect("HomeLogin.aspx");
        }

    }

    protected void postProductButton_Click(object sender, EventArgs e)
    {

        //configuration
        //connection
        //the purpose of the method
        //Get the information of the connection to the databas
        string connStr = ConfigurationManager.ConnectionStrings["GUI"].ToString();

        //create a new connection
        SqlConnection conn = new SqlConnection(connStr);

        /*create a new SQL command which takes as parameters the name of the stored procedure and
        the SQLconnection name*/
        SqlCommand cmd = new SqlCommand("postProduct", conn);
        cmd.CommandType = CommandType.StoredProcedure;

        //To read the input from the user
        string pname = pnameText.Text;
        string cat = categoryText.Text;
        string pDesc = pDescText.Text;
        string price = priceText.Text;
        string color = colorText.Text;

         if (System.String.IsNullOrEmpty(pname) == true || System.String.IsNullOrEmpty(cat) == true
            || System.String.IsNullOrEmpty(pDesc) == true || System.String.IsNullOrEmpty(price) == true ||
                 System.String.IsNullOrEmpty(color) == true)
                Response.Write("Data is not complete try again");
            else
            {
            //Executing the SQLCommand

            //pass parameters to the stored procedure
            string vendor = (string)(Session["currUser"]);
            cmd.Parameters.Add(new SqlParameter("@vendorUsername", vendor));
                cmd.Parameters.Add(new SqlParameter("@product_name ", pname));
                cmd.Parameters.Add(new SqlParameter("@category", cat));
                cmd.Parameters.Add(new SqlParameter("@product_description", pDesc));
                cmd.Parameters.Add(new SqlParameter("@price", price));
                cmd.Parameters.Add(new SqlParameter("@color", color));

            //Save the output from the procedure
            SqlParameter activatedVendor = cmd.Parameters.Add("@activatedVendor", SqlDbType.Int);
            activatedVendor.Direction = ParameterDirection.Output;


            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();


            if (activatedVendor.Value.ToString().Equals("1"))
            {
                Response.Write("The Product is added Successfully");
            }
            else
            {
                Response.Write("You are not activated, you can not add product until you get activated");
            }


            }
        }
}