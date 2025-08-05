<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="StudentTransport.Account.Login.login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Campus Trans - Login</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/toastify-js/src/toastify.min.css" rel="stylesheet" />
    <link href="css/login.css" rel="stylesheet" />

</head>

<body>
    <div class="container-fluid login-container">
        <div class="row justify-content-center align-items-center min-vh-100">
            <div class="col-md-6 col-lg-5">
                <div class="login-card shadow-lg">
                    <div class="logo-header text-center mb-4">
                        <div class="logo display-4 fw-bold">Campus Trans</div>
                        <div class="tagline fs-5">Student Transport Management System</div>
                    </div>

                    <form id="form1" runat="server" class="px-3">
                        <div class="mb-3">
                            <label for="txtEmail" class="form-label">Email Address</label>
                            <asp:TextBox runat="server" ID="txtEmail" CssClass="form-control"
                                placeholder="Enter your university email" required="true" />
                        </div>

                        <div class="mb-3">
                            <label for="txtPassword" class="form-label">Password</label>
                            <asp:TextBox runat="server" ID="txtPassword" TextMode="Password"
                                CssClass="form-control" placeholder="Enter your password" required="true" />
                        </div>

                        <div class="d-flex justify-content-between mb-3">
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" id="rememberMe" />
                                <label class="form-check-label" for="rememberMe">Remember me</label>
                            </div>
                            <a href="#" class="forgot-password">Forgot Password?</a>
                        </div>

                        <asp:Button runat="server" ID="btnLogin" Text="Login" CssClass="btn-login w-100 mb-3" OnClick="btnLogin_Click" />

                        <div class="text-center register-link">
                            Don't have an account? <a href="Register.aspx">Register here</a>
                        </div>

                        <asp:Label runat="server" ID="lblMessage" CssClass="alert alert-danger mt-3 d-none"></asp:Label>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/toastify-js"></script>
    <script src="js/login.js"></script>
    <script src="<%= ResolveUrl("~/Shared/js/common.js") %>"></script>
</body>
</html>
