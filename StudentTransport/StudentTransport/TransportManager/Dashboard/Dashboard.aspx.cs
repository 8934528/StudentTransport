using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using StudentTransport.Shared.Classes;

namespace StudentTransport.Shared
{
    public partial class WebForm5 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["UserRole"] as string != "TransportManager")
                {
                    Response.Redirect("~/Account/Login.aspx");
                }

                LoadDashboardData();
            }
        }

        private void LoadDashboardData()
        {
            DashboardManager manager = new DashboardManager();

            // Set stats
            lblTotalStudents.Text = manager.GetTotalStudents().ToString("N0");
            lblActiveDrivers.Text = manager.GetActiveDrivers().ToString();
            lblActiveBuses.Text = manager.GetActiveBuses().ToString();
            lblTodaysBookings.Text = manager.GetTodaysBookings().ToString("N0");

            // Bind recent bookings
            rptRecentBookings.DataSource = manager.GetRecentBookings();
            rptRecentBookings.DataBind();

            // Bind bus status
            rptBusStatus.DataSource = manager.GetBusStatusOverview();
            rptBusStatus.DataBind();
        }
    }
}