using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

public partial class RemoveExpiredOffer : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        bool isLoggedIn = (HttpContext.Current.Session["LoggedIn"] == null) ? false : ((bool)HttpContext.Current.Session["LoggedIn"]);

        if (!isLoggedIn)
        {
            Response.Redirect("HomeLogin.aspx");
        }
    }

    protected void btn_removeEx_Click(object sender, EventArgs e)
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
            SqlCommand cmd = new SqlCommand("checkandremoveExpiredoffer", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            //To read the input from the user
            string offerID = txt_offerID.Text;

            if (System.String.IsNullOrEmpty(offerID))
            {
                Response.Write("You should fill the textbox with the offer ID");
            }
            else
            {
                //pass parameters to the stored procedure
                cmd.Parameters.Add(new SqlParameter("@offerid", offerID));

                SqlParameter expired = cmd.Parameters.Add("@expired", SqlDbType.Int);
                expired.Direction = ParameterDirection.Output;
                //Executing the SQLCommand
                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();

                if (expired.Value.ToString().Equals("1"))
                {
                    Response.Write("The expired offer is removed successfully");
                }
                else
                {
                    Response.Write("The offer is NOT removed as it is not expired yet or does not exist or you entered no ID");
                }
            }
        }
        catch(Exception)
        {
            Response.Write("INVALID INPUT"); 
        }
    }
}