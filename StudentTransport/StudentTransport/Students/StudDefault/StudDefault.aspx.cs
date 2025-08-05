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
    public partial class WebForm3 : System.Web.UI.Page
    {
        private StudentManager studentManager = new StudentManager();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["StudentID"] == null)
                {
                    Response.Redirect("~/Login.aspx");
                    return;
                }

                int studentId = Convert.ToInt32(Session["StudentID"]);

                LoadStudentData(studentId);
            }
        }

        private void LoadStudentData(int studentId)
        {
            // Load student details
            DataRow student = studentManager.GetStudentDetails(studentId);
            if (student != null)
            {
                litStudentName.Text = student["FirstName"] + " " + student["LastName"];
            }

            // Load next ride
            DataRow nextRide = studentManager.GetNextRide(studentId);
            if (nextRide != null)
            {
                // Populate next ride UI elements
                // (Implementation depends on your UI structure)
            }

            // Load active buses
            rptActiveBuses.DataSource = studentManager.GetActiveBuses();
            rptActiveBuses.DataBind();

            // Load recent bookings
            rptRecentBookings.DataSource = studentManager.GetRecentBookings(studentId);
            rptRecentBookings.DataBind();
        }
    }
}
