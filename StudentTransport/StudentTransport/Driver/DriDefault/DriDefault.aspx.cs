using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace StudentTransport.Shared
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserRole"] as string != "Driver")
            {
                Response.Redirect("~/Account/Login/Login.aspx");
            }

            // Load driver-specific data
        }
    }
}