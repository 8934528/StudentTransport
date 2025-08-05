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
    public partial class WebForm2 : System.Web.UI.Page
    {
        private DriverManager driverManager = new DriverManager();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // In real app, get from session/authentication
                int driverId = 1;
                hdnDriverId.Value = driverId.ToString();

                LoadBusDetails(driverId);
                LoadStatusHistory();
            }
        }

        private void LoadBusDetails(int driverId)
        {
            DataTable busDetails = driverManager.GetDriverDetails(driverId);
            if (busDetails.Rows.Count > 0)
            {
                DataRow row = busDetails.Rows[0];

                // Set bus information
                litBusNumber.Text = row["BusNumber"].ToString();
                litCapacity.Text = $"{row["Capacity"]} Passengers";
                litMileage.Text = $"{row["Mileage"]} km";
                litLocation.Text = row["CurrentLocation"].ToString();

                // Set current status
                string currentStatus = row["CurrentStatus"].ToString();
                hdnCurrentStatus.Value = currentStatus;

                // Set bus ID
                hdnBusId.Value = row["BusID"].ToString();
            }
        }

        private void LoadStatusHistory()
        {
            if (!string.IsNullOrEmpty(hdnBusId.Value))
            {
                int busId = Convert.ToInt32(hdnBusId.Value);
                DataTable statusHistory = driverManager.GetBusStatusHistory(busId);
                rptStatusHistory.DataSource = statusHistory;
                rptStatusHistory.DataBind();
            }
        }

        protected void UpdateBusStatus(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(hdnBusId.Value) &&
                !string.IsNullOrEmpty(hdnDriverId.Value) &&
                !string.IsNullOrEmpty(Request.Form["status"]))
            {
                int busId = Convert.ToInt32(hdnBusId.Value);
                int driverId = Convert.ToInt32(hdnDriverId.Value);
                string status = Request.Form["status"];

                driverManager.UpdateBusStatus(busId, driverId, status);

                // Update current status
                hdnCurrentStatus.Value = status;

                // Reload data
                LoadBusDetails(driverId);
                LoadStatusHistory();

                // Show success message
                ScriptManager.RegisterStartupScript(this, GetType(), "showSuccess",
                    "showNotification('Bus status updated successfully!', 'success');", true);
            }
        }
    }
}
