using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace StudentTransport.Login 
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text;

            User user = DatabaseHelper.AuthenticateUser(email, password);

            if (user != null)
            {
                Session["CurrentUser"] = user;

                switch (user.Role)
                {
                    case "Student":
                        Response.Redirect("~/Student/Default.aspx");
                        break;
                    case "Driver":
                        Response.Redirect("~/Driver/Default.aspx");
                        break;
                    case "TransportManager":
                        Response.Redirect("~/TransportManager/Dashboard.aspx");
                        break;
                    default:
                        lblMessage.Text = "Invalid role assigned.";
                        break;
                }
            }
            else
            {
                lblMessage.Text = "Invalid email or password.";
            }
        }
    }