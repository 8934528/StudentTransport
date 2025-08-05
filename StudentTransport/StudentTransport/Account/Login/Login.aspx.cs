using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using StudentTransport.Classes;

namespace StudentTransport.Account.Login
{
    public partial class login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                lblMessage.CssClass = "alert alert-danger mt-3 d-none";
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text;

            UserManager userManager = new UserManager();
            UserManager.UserInfo userInfo = userManager.AuthenticateUser(email, password);

            if (userInfo.IsAuthenticated)
            {
                Session["UserID"] = userInfo.UserId;
                Session["FullName"] = $"{userInfo.FirstName} {userInfo.LastName}";
                Session["UserRole"] = userInfo.Role;

                // Redirect based on role
                switch (userInfo.Role)
                {
                    case "Student":
                        Response.Redirect("~/Student/StudDefault/StudDefault.aspx");
                        break;
                    case "Driver":
                        Response.Redirect("~/Driver/DriDefault/DriDefault.aspx");
                        break;
                    case "TransportManager":
                        Response.Redirect("~/TransportManager/Dashboard/Dashboard.aspx");
                        break;
                    default:
                        Response.Redirect("~/Default.aspx");
                        break;
                }
            }
            else
            {
                lblMessage.Text = userInfo.Message;
                lblMessage.CssClass = "alert alert-danger mt-3";
            }
        }
    }
}