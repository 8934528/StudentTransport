<%@ Page Title="" Language="C#" MasterPageFile="~/Shared/Site.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="StudentTransport.Shared.WebForm5" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="manager-dashboard">
        <h2>Transport Management Dashboard</h2>
        
        <div class="stats-container">
            <div class="stat-card">
                <h3>Total Students</h3>
                <asp:Literal runat="server" ID="litTotalStudents" Text="0" />
            </div>
            <div class="stat-card">
                <h3>Active Drivers</h3>
                <asp:Literal runat="server" ID="litActiveDrivers" Text="0" />
            </div>
            <div class="stat-card">
                <h3>Buses in Service</h3>
                <asp:Literal runat="server" ID="litActiveBuses" Text="0" />
            </div>
        </div>
        
        <div class="dashboard-actions">
            <asp:Button runat="server" ID="btnManageStudents" Text="Manage Students" 
                CssClass="btn-action" OnClick="btnManageStudents_Click" />
            <asp:Button runat="server" ID="btnManageDrivers" Text="Manage Drivers" 
                CssClass="btn-action" OnClick="btnManageDrivers_Click" />
        </div>
    </div>
</asp:Content>
