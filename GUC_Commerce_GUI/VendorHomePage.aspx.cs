using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GUC_Commerce_GUI
{
    public partial class VendorHomePage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            bool isLoggedIn = HttpContext.Current.Session["LoggedIn"] == null ? false : (bool)HttpContext.Current.Session["LoggedIn"];

            if (!isLoggedIn)
            {
                Response.Redirect("HomeLogin.aspx");
            }


        }

        protected void btn_logout_Click(object sender, EventArgs e)
        {
            Session["currUser"] = null;
            Session["LoggedIn"] = false;
            Session["type"] = null;
            Response.Redirect("Homelogin.aspx");
        }
    }
}