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
            string confirmPassword = txtConfirmPassword.Text;
            string role = ddlRole.SelectedValue;
            string residence = txtResidence.Text.Trim();
            string campus = txtCampus.Text.Trim();
            string license = txtLicense.Text.Trim();

            // Validate inputs
            if (string.IsNullOrEmpty(firstName) || string.IsNullOrEmpty(lastName) ||
                string.IsNullOrEmpty(email) || string.IsNullOrEmpty(password) ||
                string.IsNullOrEmpty(role))
            {
                ShowToast("error", "Validation Error", "Please fill in all required fields");
                return;
            }

            if (password != confirmPassword)
            {
                ShowToast("error", "Validation Error", "Passwords do not match");
                return;
            }

            if (role == "Student" && (string.IsNullOrEmpty(residence) || string.IsNullOrEmpty(campus)))
            {
                ShowToast("error", "Validation Error", "Please fill in residence and campus details");
                return;
            }

            if (role == "Driver" && string.IsNullOrEmpty(license))
            {
                ShowToast("error", "Validation Error", "Please enter license number");
                return;
            }

            UserManager userManager = new UserManager();

            if (userManager.IsEmailRegistered(email))
            {
                ShowToast("error", "Registration Failed", "Email is already registered");
                return;
            }

            bool success = userManager.RegisterUser(
                firstName, lastName, email, password, role,
                residence, campus, license
            );

            if (success)
            {
                ShowToast("success", "Registration Successful", "Your account has been created! Redirecting to login...");

                // Redirect after delay
                ClientScript.RegisterStartupScript(GetType(), "Redirect",
                    "setTimeout(function(){ window.location.href = 'Login.aspx'; }, 3000);", true);
            }
            else
            {
                ShowToast("error", "Registration Failed", "Account creation failed. Please try again.");
            }
        }

        private void ShowToast(string type, string title, string message)
        {
            ClientScript.RegisterStartupScript(GetType(), "Toast",
                $"showToast('{type}', '{title}', '{message.Replace("'", "\\'")}');", true);
        }
    }
}