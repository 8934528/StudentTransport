<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="StudentTransport.Account.Register.Register" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Campus Trans - Register</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="css/register.css" rel="stylesheet" />
</head>
<body>
    <div class="container-fluid register-container">
        <div class="row justify-content-center align-items-center min-vh-100">
            <div class="col-md-8 col-lg-6">
                <div class="register-card shadow-lg">
                    <div class="logo-header text-center mb-4">
                        <div class="logo display-4 fw-bold">Campus Trans</div>
                        <div class="tagline fs-5">Create your account</div>
                    </div>

                    <form id="form1" runat="server" class="px-3">
                        <div class="row g-3 mb-3">
                            <div class="col-md-6">
                                <label for="txtFirstName" class="form-label">First Name</label>
                                <asp:TextBox runat="server" ID="txtFirstName" CssClass="form-control"
                                    placeholder="Enter your first name" required="true" />
                            </div>

                            <div class="col-md-6">
                                <label for="txtLastName" class="form-label">Last Name</label>
                                <asp:TextBox runat="server" ID="txtLastName" CssClass="form-control"
                                    placeholder="Enter your last name" required="true" />
                            </div>
                        </div>

                        <div class="mb-3">
                            <label for="txtEmail" class="form-label">Email Address</label>
                            <asp:TextBox runat="server" ID="txtEmail" CssClass="form-control"
                                placeholder="Enter your university email" TextMode="Email" required="true" />
                        </div>

                        <div class="row g-3 mb-3">
                            <div class="col-md-6">
                                <label for="txtPassword" class="form-label">Password</label>
                                <asp:TextBox runat="server" ID="txtPassword" TextMode="Password"
                                    CssClass="form-control" placeholder="Create a password" required="true" />
                            </div>

                            <div class="col-md-6">
                                <label for="txtConfirmPassword" class="form-label">Confirm Password</label>
                                <asp:TextBox runat="server" ID="txtConfirmPassword" TextMode="Password"
                                    CssClass="form-control" placeholder="Confirm your password" required="true" />
                            </div>
                        </div>

                        <div class="mb-3">
                            <label for="ddlRole" class="form-label">I am a</label>
                            <asp:DropDownList runat="server" ID="ddlRole" CssClass="form-select" required="true">
                                <asp:ListItem Value="">Select your role</asp:ListItem>
                                <asp:ListItem Value="Student">Student</asp:ListItem>
                                <asp:ListItem Value="Driver">Bus Driver</asp:ListItem>
                                <asp:ListItem Value="TransportManager">Transport Manager</asp:ListItem>
                            </asp:DropDownList>
                        </div>

                        <div class="mb-3 role-specific p-3 rounded" id="studentFields" style="display: none;">
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label for="txtResidence" class="form-label">Residence</label>
                                    <asp:TextBox runat="server" ID="txtResidence" CssClass="form-control"
                                        placeholder="e.g., Harmony Res" />
                                </div>

                                <div class="col-md-6">
                                    <label for="txtCampus" class="form-label">Campus</label>
                                    <asp:TextBox runat="server" ID="txtCampus" CssClass="form-control"
                                        placeholder="e.g., Main Campus" />
                                </div>
                            </div>
                        </div>

                        <div class="mb-3 role-specific p-3 rounded" id="driverFields" style="display: none;">
                            <div class="mb-3">
                                <label for="txtLicense" class="form-label">Driver's License Number</label>
                                <asp:TextBox runat="server" ID="txtLicense" CssClass="form-control"
                                    placeholder="Enter license number" />
                            </div>
                        </div>

                        <div class="mb-3 form-check">
                            <input type="checkbox" class="form-check-input" id="chkTerms" required="required" />
                            <label class="form-check-label" for="chkTerms">
                                I agree to the <a href="#" class="text-decoration-none">Terms of Service</a> and <a href="#" class="text-decoration-none">Privacy Policy</a>
                            </label>
                        </div>

                        <asp:Button runat="server" ID="btnRegister" Text="Create Account" CssClass="btn-register w-100 mb-3" OnClick="btnRegister_Click" />

                        <div class="text-center login-link">
                            Already have an account? <a href="../Login/Login.aspx">Sign in</a>
                        </div>

                        <asp:Label runat="server" ID="lblMessage" CssClass="alert alert-danger mt-3 d-none"></asp:Label>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function () {
            const roleSelect = document.getElementById('<%= ddlRole.ClientID %>');
            const studentFields = document.getElementById('studentFields');
            const driverFields = document.getElementById('driverFields');

            if (roleSelect) {
                roleSelect.addEventListener('change', function () {
                    studentFields.style.display = this.value === 'Student' ? 'block' : 'none';
                    driverFields.style.display = this.value === 'Driver' ? 'block' : 'none';
                });

                // Trigger on page load if value exists
                if (roleSelect.value) {
                    studentFields.style.display = roleSelect.value === 'Student' ? 'block' : 'none';
                    driverFields.style.display = roleSelect.value === 'Driver' ? 'block' : 'none';
                }
            }
        });
    </script>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="js/register.js"></script>
</body>
</html>
