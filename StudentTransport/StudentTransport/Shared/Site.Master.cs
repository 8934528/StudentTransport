using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace StudentTransport.Shared
{
    public partial class Site : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["CurrentUser"] is User user)
                {
                    litUserName.Text = $"{user.FirstName} {user.LastName} ({user.Role})";
                    BuildNavigation(user.Role);
                }
                else
                {
                    Response.Redirect("~/Login/Login.aspx");
                }
            }
        }

        private void BuildNavigation(string role)
        {
            phNavigation.Controls.Clear();

            switch (role)
            {
                case "Student":
                    AddNavItem("Dashboard", "~/Student/Default.aspx");
                    AddNavItem("Schedule", "~/Student/Schedule.aspx");
                    break;
                case "Driver":
                    AddNavItem("Dashboard", "~/Driver/Default.aspx");
                    AddNavItem("Bus Status", "~/Driver/BusStatus.aspx");
                    break;
                case "TransportManager":
                    AddNavItem("Dashboard", "~/TransportManager/Dashboard.aspx");
                    AddNavItem("Manage Students", "~/TransportManager/ManageStudents.aspx");
                    AddNavItem("Manage Drivers", "~/TransportManager/ManageDrivers.aspx");
                    break;
            }
        }

        private void AddNavItem(string text, string url)
        {
            HyperLink link = new HyperLink
            {
                Text = text,
                NavigateUrl = url,
                CssClass = "nav-link"
            };
            phNavigation.Controls.Add(link);
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect("~/Login/Login.aspx");
        }
    }
}
