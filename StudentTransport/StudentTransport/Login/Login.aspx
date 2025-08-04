<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="StudentTransport.Login.Login" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Transport System - Login</title>
    <link href="../Shared/css/site.css" rel="stylesheet" />
    <link href="css/login.css" rel="stylesheet" />
</head>
<body>
    <div class="login-container">
        <form id="form1" runat="server">
            <h2>Transport Management System</h2>
            <div class="form-group">
                <asp:Label runat="server" AssociatedControlID="txtEmail">Email</asp:Label>
                <asp:TextBox runat="server" ID="txtEmail" CssClass="form-control" />
            </div>
            <div class="form-group">
                <asp:Label runat="server" AssociatedControlID="txtPassword">Password</asp:Label>
                <asp:TextBox runat="server" ID="txtPassword" TextMode="Password" CssClass="form-control" />
            </div>
            <asp:Button runat="server" ID="btnLogin" Text="Login" CssClass="btn-primary" OnClick="btnLogin_Click" />
            <asp:Label runat="server" ID="lblMessage" CssClass="error-message"></asp:Label>
        </form>
    </div>
</body>
</html>