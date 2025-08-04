using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace StudentTransport.Shared
{
    public partial class WebForm3 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["CurrentUser"] is User user)
                {
                    LoadBusStatus(user.UserID);
                }
                else
                {
                    Response.Redirect("~/Login/Login.aspx");
                }
            }
        }

        private void LoadBusStatus(int driverId)
        {
            litBusInfo.Text = "Bus #D-102 (Capacity: 40) - Current Status: Ready";

            DataTable dt = new DataTable();
            dt.Columns.Add("Status");
            dt.Columns.Add("StatusTime", typeof(DateTime));

            dt.Rows.Add("Ready", DateTime.Now.AddHours(-1));
            dt.Rows.Add("InProgress", DateTime.Now.AddHours(-3));
            dt.Rows.Add("Ready", DateTime.Now.AddHours(-5));

            gvStatusHistory.DataSource = dt;
            gvStatusHistory.DataBind();
        }

        protected void btnSetReady_Click(object sender, EventArgs e)
        {
            // Update status in database
            ShowStatusMessage("Bus status set to: Ready");
        }

        protected void btnSetOffDuty_Click(object sender, EventArgs e)
        {
            // Update status in database
            ShowStatusMessage("Bus status set to: Off Duty");
        }

        private void ShowStatusMessage(string message)
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "showStatus",
                $"alert('{message}');", true);
        }
    }
}