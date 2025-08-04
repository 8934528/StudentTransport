using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace StudentTransport.Shared
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["CurrentUser"] is User user)
                {
                    litStudentName.Text = user.FirstName;

                    string campusLocation = "Main Campus";
                    DataTable dt = DatabaseHelper.GetActiveSchedules(campusLocation);
                    gvActiveBuses.DataSource = dt;
                    gvActiveBuses.DataBind();
                }
                else
                {
                    Response.Redirect("~/Login/Login.aspx");
                }
            }
        }

        protected void btnViewSchedule_Click(object sender, EventArgs e)
        {
            Response.Redirect("Schedule.aspx");
        }
    }
}