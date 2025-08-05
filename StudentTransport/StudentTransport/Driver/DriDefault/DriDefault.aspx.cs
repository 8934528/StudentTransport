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
    public partial class WebForm1 : System.Web.UI.Page
    {
        private DriverManager driverManager = new DriverManager();
        private int driverId = 1; 
        private int busId = 1;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserRole"] as string != "Driver")
            {
                Response.Redirect("~/Account/Login.aspx");
            }

            if (!IsPostBack)
            {
                LoadDriverDashboard();
            }
        }

        private void LoadDriverDashboard()
        {
            // Load driver details
            DataTable driverDetails = driverManager.GetDriverDetails(driverId);
            if (driverDetails.Rows.Count > 0)
            {
                DataRow row = driverDetails.Rows[0];
                litDriverName.Text = row["FirstName"] + " " + row["LastName"];

                // Get bus ID
                busId = 1; // In real app, this would come from driverDetails
            }

            // Load today's schedule
            DataTable schedule = driverManager.GetTodaysSchedule(driverId);
            rptSchedule.DataSource = schedule;
            rptSchedule.DataBind();

            // Load current passengers
            DataTable passengers = driverManager.GetCurrentPassengers(busId);
            rptPassengers.DataSource = passengers;
            rptPassengers.DataBind();
        }
    }
}