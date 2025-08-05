using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using StudentTransport.Shared.Classes;
using System.Data;

namespace StudentTransport.Shared
{
    public partial class WebForm6 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadDrivers();
                LoadBusList();
            }
        }

        private void LoadDrivers()
        {
            DataTable drivers = manager.GetAllDrivers();
            rptDrivers.DataSource = drivers;
            rptDrivers.DataBind();
            pnlNoDrivers.Visible = drivers.Rows.Count == 0;
        }

        private void LoadBusList()
        {
            ddlBus.Items.Clear();
            ddlBus.Items.Add(new ListItem("All Buses", "All"));

            // In a real implementation, you'd get buses from database
            ddlBus.Items.Add(new ListItem("B-101", "B-101"));
            ddlBus.Items.Add(new ListItem("B-102", "B-102"));
            ddlBus.Items.Add(new ListItem("B-103", "B-103"));
            ddlBus.Items.Add(new ListItem("B-104", "B-104"));
            ddlBus.Items.Add(new ListItem("B-105", "B-105"));
        }

        protected void rptDrivers_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int driverId = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "Delete")
            {
                manager.DeleteDriver(driverId);
                LoadDrivers();
            }
            else if (e.CommandName == "Edit")
            {
                // Redirect to edit page with driver ID
                Response.Redirect($"EditDriver.aspx?id={driverId}");
            }
        }

        protected void btnAddDriver_Click(object sender, EventArgs e)
        {
            manager.AddDriver(
                txtFirstName.Text.Trim(),
                txtLastName.Text.Trim(),
                txtEmail.Text.Trim(),
                txtPassword.Text,
                txtLicense.Text.Trim()
            );

            // Clear form and reload drivers
            txtFirstName.Text = "";
            txtLastName.Text = "";
            txtEmail.Text = "";
            txtPassword.Text = "";
            txtLicense.Text = "";

            LoadDrivers();

            // Close modal via JavaScript
            ScriptManager.RegisterStartupScript(this, GetType(), "closeModal",
                "$('#addDriverModal').modal('hide');", true);
        }

        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            FilterDrivers();
        }

        protected void ddlStatus_SelectedIndexChanged(object sender, EventArgs e)
        {
            FilterDrivers();
        }

        protected void ddlBus_SelectedIndexChanged(object sender, EventArgs e)
        {
            FilterDrivers();
        }

        private void FilterDrivers()
        {
            LoadDrivers();
        }

        protected void dpDrivers_PreRender(object sender, EventArgs e)
        {
            dpDrivers.Visible = (rptDrivers.Items.Count > 0);
        }
    }
}
