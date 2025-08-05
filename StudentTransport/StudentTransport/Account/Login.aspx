<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="StudentTransport.Account.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Campus Trans - Login</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/toastify-js/src/toastify.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <link href="css/login.css" rel="stylesheet" />
</head>

<body>
    <div class="container-fluid login-container">
        <div class="row justify-content-center align-items-center min-vh-100">
            <div class="col-lg-10">
                <div class="system-card shadow-lg">
                    <div class="row g-0">
                        <!-- System Info Panel -->
                        <div class="col-md-6 system-info-panel">
                            <div class="system-content">
                                <div class="logo-header mb-5">
                                    <div class="logo display-4 fw-bold"><i class="fa-solid fa-bus me-3"></i>Campus Trans</div>
                                    <div class="tagline fs-5">Student Transport Management System</div>
                                </div>

                                <div class="features">
                                    <div class="feature-item mb-4">
                                        <div class="icon-circle">
                                            <i class="fa-solid fa-route"></i>
                                        </div>
                                        <div>
                                            <h4>Smart Routing</h4>
                                            <p>Optimized routes for efficient student transportation</p>
                                        </div>
                                    </div>

                                    <div class="feature-item mb-4">
                                        <div class="icon-circle">
                                            <i class="fa-solid fa-location-dot"></i>
                                        </div>
                                        <div>
                                            <h4>Real-time Tracking</h4>
                                            <p>Live vehicle tracking for parents and administrators</p>
                                        </div>
                                    </div>

                                    <div class="feature-item">
                                        <div class="icon-circle">
                                            <i class="fa-solid fa-shield-halved"></i>
                                        </div>
                                        <div>
                                            <h4>Secure Access</h4>
                                            <p>Role-based access control for all users</p>
                                        </div>
                                    </div>
                                </div>

                                <a href="../Shared/About/About.aspx" class="btn btn-system mt-5">
                                    <i class="fa-solid fa-circle-info me-2"></i>Learn More About System
                                </a>
                            </div>
                        </div>

                        <!-- Login Form Panel -->
                        <div class="col-md-6 login-form-panel">
                            <div class="login-card">
                                <h3 class="mb-4 text-center">Sign In to Your Account</h3>
                                <p class="text-center mb-4">Enter your credentials to access the system</p>

                                <form id="form1" runat="server">
                                    <div class="mb-3 input-group">
                                        <span class="input-group-text">
                                            <i class="fa-solid fa-envelope"></i>
                                        </span>
                                        <asp:TextBox runat="server" ID="txtEmail" CssClass="form-control"
                                            placeholder="Enter your university email" required="true" />
                                    </div>

                                    <div class="mb-3 input-group">
                                        <span class="input-group-text">
                                            <i class="fa-solid fa-lock"></i>
                                        </span>
                                        <asp:TextBox runat="server" ID="txtPassword" TextMode="Password"
                                            CssClass="form-control" placeholder="Enter your password" required="true" />
                                    </div>

                                    <div class="d-flex justify-content-between mb-3">
                                        <div class="form-check">
                                            <input class="form-check-input" type="checkbox" id="rememberMe" />
                                            <label class="form-check-label" for="rememberMe">Remember me</label>
                                        </div>
                                        <a href="#" class="forgot-password">
                                            <i class="fa-solid fa-key me-1"></i>Forgot Password?
                                        </a>
                                    </div>

                                    <asp:Button runat="server" ID="btnLogin" Text="Login"
                                        CssClass="btn-login w-100 mb-3" OnClick="btnLogin_Click" />

                                    <div class="text-center register-link mt-4">
                                        Don't have an account? <a href="<%= ResolveUrl("~/Account/Register.aspx") %>">
                                            <i class="fa-solid fa-user-plus me-1"></i>Register
                                        </a>
                                    </div>

                                    <asp:Label runat="server" ID="lblMessage" CssClass="alert alert-danger mt-3 d-none"></asp:Label>
                                </form>
                            </div>
                        </div>
                    </div>
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
