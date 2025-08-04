<%@ Page Title="" Language="C#" MasterPageFile="~/Shared/Site.Master" AutoEventWireup="true" CodeBehind="StudDefault.aspx.cs" Inherits="StudentTransport.Shared.WebForm1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="student-dashboard">
        <h2>Welcome, <asp:Literal runat="server" ID="litStudentName" /></h2>
        
        <div class="dashboard-card">
            <h3>Active Buses</h3>
            <asp:GridView ID="gvActiveBuses" runat="server" CssClass="bus-grid" AutoGenerateColumns="false">
                <Columns>
                    <asp:BoundField DataField="BusNumber" HeaderText="Bus #" />
                    <asp:BoundField DataField="FromStation" HeaderText="From" />
                    <asp:BoundField DataField="ToStation" HeaderText="To" />
                    <asp:BoundField DataField="DepartureTime" HeaderText="Departure Time" 
                        DataFormatString="{0:g}" />
                </Columns>
            </asp:GridView>
        </div>
        
        <div class="action-buttons">
            <asp:Button runat="server" ID="btnViewSchedule" Text="View Full Schedule" 
                CssClass="btn-primary" OnClick="btnViewSchedule_Click" />
        </div>
    </div>
</asp:Content>
