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
    public partial class WebForm7 : System.Web.UI.Page
    {
        private DashboardManager manager = new DashboardManager();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadStudents();
            }
        }

        private void LoadStudents()
        {
            DataTable students = manager.GetAllStudents();
            rptStudents.DataSource = students;
            rptStudents.DataBind();
            pnlNoStudents.Visible = students.Rows.Count == 0;
        }

        protected void rptStudents_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int studentId = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "Delete")
            {
                manager.DeleteStudent(studentId);
                LoadStudents();
            }
            else if (e.CommandName == "Edit")
            {
                Response.Redirect($"EditStudent.aspx?id={studentId}");
            }
            else if (e.CommandName == "View")
            {
                Response.Redirect($"StudentDetails.aspx?id={studentId}");
            }
        }

        protected void btnAddStudent_Click(object sender, EventArgs e)
        {
            manager.AddStudent(
                txtStFirstName.Text.Trim(),
                txtStLastName.Text.Trim(),
                txtStEmail.Text.Trim(),
                txtStPassword.Text,
                ddlCampusAdd.SelectedValue,
                ddlResidenceAdd.SelectedValue
            );

            txtStFirstName.Text = "";
            txtStLastName.Text = "";
            txtStEmail.Text = "";
            txtStPassword.Text = "";

            LoadStudents();

            ScriptManager.RegisterStartupScript(this, GetType(), "closeModal",
                "$('#addStudentModal').modal('hide');", true);
        }

        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            FilterStudents();
        }

        protected void ddlCampus_SelectedIndexChanged(object sender, EventArgs e)
        {
            FilterStudents();
        }

        protected void ddlResidence_SelectedIndexChanged(object sender, EventArgs e)
        {
            FilterStudents();
        }

        private void FilterStudents()
        {
            LoadStudents();
        }

        protected void dpStudents_PreRender(object sender, EventArgs e)
        {
            dpStudents.Visible = (rptStudents.Items.Count > 0);
        }
    }
}
