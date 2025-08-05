using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using StudentTransport.Shared.Classes;

namespace StudentTransport.Account.Register
{
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                lblMessage.CssClass = "alert alert-danger mt-3 d-none";
            }
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            string firstName = txtFirstName.Text.Trim();
            string lastName = txtLastName.Text.Trim();
            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text;
            string role = ddlRole.SelectedValue;
            string residence = txtResidence.Text.Trim();
            string campus = txtCampus.Text.Trim();
            string license = txtLicense.Text.Trim();

            UserManager userManager = new UserManager();

            if (userManager.IsEmailRegistered(email))
            {
                lblMessage.Text = "Email is already registered. Please use a different email.";
                lblMessage.CssClass = "alert alert-danger mt-3";
                return;
            }

            bool success = userManager.RegisterUser(
                firstName, lastName, email, password, role,
                residence, campus, license
            );

            if (success)
            {
                // Show success toast
                ClientScript.RegisterStartupScript(this.GetType(), "Toast",
                    "showToast('success', 'Registration Successful', 'Your account has been created successfully!');", true);

                // Redirect after delay
                ClientScript.RegisterStartupScript(this.GetType(), "Redirect",
                    "setTimeout(function(){ window.location.href = 'Login.aspx'; }, 2000);", true);
            }
            else
            {
                lblMessage.Text = "Registration failed. Please try again.";
                lblMessage.CssClass = "alert alert-danger mt-3";
            }
        }
    }
}