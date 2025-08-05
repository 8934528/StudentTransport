using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using StudentTransport.Shared.Classes;
using System.Text;

namespace StudentTransport.Shared
{
    public partial class WebForm4 : System.Web.UI.Page
    {
        private StudentManager studentManager = new StudentManager();
        private DateTime currentWeekStart;
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
                currentWeekStart = GetStartOfWeek(DateTime.Today, DayOfWeek.Monday);
                ViewState["CurrentWeekStart"] = currentWeekStart;
                LoadScheduleData(studentId, currentWeekStart);
                LoadUpcomingBookings(studentId);
            }
        }

        private void LoadScheduleData(int studentId, DateTime weekStart)
        {
            DataTable schedule = studentManager.GetWeeklySchedule(weekStart);
            ViewState["WeeklySchedule"] = schedule;
            lblCurrentWeek.InnerText = "Week of " + weekStart.ToString("MMM dd, yyyy");
        }

        private void LoadUpcomingBookings(int studentId)
        {
            DataTable upcomingBookings = studentManager.GetUpcomingBookings(studentId);
            rptUpcomingBookings.DataSource = upcomingBookings;
            rptUpcomingBookings.DataBind();
            pnlNoUpcomingBookings.Visible = upcomingBookings.Rows.Count == 0;
        }

        private DateTime GetStartOfWeek(DateTime dt, DayOfWeek startOfWeek)
        {
            int diff = (7 + (dt.DayOfWeek - startOfWeek)) % 7;
            return dt.AddDays(-1 * diff).Date;
        }

        protected void rptUpcomingBookings_ItemCommand(object source, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Cancel")
            {
                int bookingId = Convert.ToInt32(e.CommandArgument);
                bool success = studentManager.CancelBooking(bookingId);

                if (success)
                {
                    // Show success message
                    ScriptManager.RegisterStartupScript(this, GetType(), "cancelSuccess",
                        "showNotification('Booking cancelled successfully!', 'success');", true);

                    // Refresh data
                    int studentId = Convert.ToInt32(Session["StudentID"]);
                    LoadScheduleData(studentId, (DateTime)ViewState["CurrentWeekStart"]);
                    LoadUpcomingBookings(studentId);
                }
            }
        }


        protected void btnPrevWeek_Click(object sender, EventArgs e)
        {
            currentWeekStart = (DateTime)ViewState["CurrentWeekStart"];
            currentWeekStart = currentWeekStart.AddDays(-7);
            ViewState["CurrentWeekStart"] = currentWeekStart;
            LoadScheduleData(Convert.ToInt32(Session["StudentID"]), currentWeekStart);
        }

        protected void btnNextWeek_Click(object sender, EventArgs e)
        {
            currentWeekStart = (DateTime)ViewState["CurrentWeekStart"];
            currentWeekStart = currentWeekStart.AddDays(7);
            ViewState["CurrentWeekStart"] = currentWeekStart;
            LoadScheduleData(Convert.ToInt32(Session["StudentID"]), currentWeekStart);
        }

        protected void btnConfirmBooking_Click(object sender, EventArgs e)
        {
            if (ViewState["SelectedScheduleID"] == null) return;

            int studentId = Convert.ToInt32(Session["StudentID"]);
            int scheduleId = Convert.ToInt32(ViewState["SelectedScheduleID"]);

            try
            {
                int bookingId = studentManager.BookRide(studentId, scheduleId);
                if (bookingId > 0)
                {
                    // Show success message
                    ScriptManager.RegisterStartupScript(this, GetType(), "bookingSuccess",
                        "showNotification('Booking confirmed successfully!', 'success');", true);

                    // Refresh data
                    LoadScheduleData(studentId, (DateTime)ViewState["CurrentWeekStart"]);
                    LoadUpcomingBookings(studentId);
                }
            }
            catch (Exception ex)
            {
                // Show error message
                ScriptManager.RegisterStartupScript(this, GetType(), "bookingError",
                    $"showNotification('Error: {ex.Message}', 'danger');", true);
            }
        }
    }
}
