<%@ Page Title="" Language="C#" MasterPageFile="~/Shared/Site.Master" AutoEventWireup="true" CodeBehind="BusStatus.aspx.cs" Inherits="StudentTransport.Shared.WebForm3" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="driver-status">
        <h2>Bus Status Management</h2>
        
        <div class="bus-info">
            <asp:Literal runat="server" ID="litBusInfo" />
        </div>
        
        <div class="status-controls">
            <asp:Button runat="server" ID="btnSetReady" Text="Set Ready" 
                CssClass="btn-status-ready" OnClick="btnSetReady_Click" />
            <asp:Button runat="server" ID="btnSetOffDuty" Text="Set Off Duty" 
                CssClass="btn-status-offduty" OnClick="btnSetOffDuty_Click" />
        </div>
        
        <div class="status-history">
            <h3>Recent Status Updates</h3>
            <asp:GridView ID="gvStatusHistory" runat="server" CssClass="status-grid" AutoGenerateColumns="false">
                <Columns>
                    <asp:BoundField DataField="Status" HeaderText="Status" />
                    <asp:BoundField DataField="StatusTime" HeaderText="Time" 
                        DataFormatString="{0:g}" />
                </Columns>
            </asp:GridView>
        </div>
    </div>
</asp:Content>
