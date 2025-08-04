using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace StudentTransport.Shared
{
    public partial class WebForm5 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["CurrentUser"] is User user && user.Role == "TransportManager")
                {
                    litTotalStudents.Text = "125"; 
                    litActiveDrivers.Text = "18"; 
                    litActiveBuses.Text = "12";  
                }
                else
                {
                    Response.Redirect("~/Login/Login.aspx");
                }
            }
        }

        protected void btnManageStudents_Click(object sender, EventArgs e)
        {
            Response.Redirect("ManageStudents.aspx");
        }

        protected void btnManageDrivers_Click(object sender, EventArgs e)
        {
            Response.Redirect("ManageDrivers.aspx");
        }
    }
}