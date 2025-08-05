<%@ Page Title="" Language="C#" MasterPageFile="~/Shared/Site.Master" AutoEventWireup="true" CodeBehind="DriDefault.aspx.cs" Inherits="StudentTransport.Shared.WebForm1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <link href="css/DriDefault.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="driver-dashboard">
        <div class="welcome-section mb-4">
            <h1 class="display-5 fw-bold">Driver Dashboard</h1>
            <p class="lead">Welcome back,
                <asp:Literal ID="litDriverName" runat="server"></asp:Literal>!</p>
        </div>

        <div class="row">
            <!-- Bus Status Card -->
            <div class="col-lg-6 mb-4">
                <div class="card h-100">
                    <div class="card-header bg-primary text-white">
                        <h5 class="card-title mb-0">Current Bus Status</h5>
                    </div>
                    <div class="card-body">
                        <div class="d-flex align-items-center mb-3">
                            <div class="status-indicator bg-success rounded-circle me-3"></div>
                            <div>
                                <h3 class="fw-bold">Active</h3>
                                <p class="text-muted mb-0">Bus #D-102</p>
                            </div>
                        </div>
                        <div class="bus-info">
                            <div class="info-item">
                                <i class="fas fa-bus me-2"></i>
                                <span>Capacity: 40 passengers</span>
                            </div>
                            <div class="info-item">
                                <i class="fas fa-map-marker-alt me-2"></i>
                                <span>Current Location: Main Campus Station</span>
                            </div>
                            <div class="info-item">
                                <i class="fas fa-clock me-2"></i>
                                <span>Last Update: 10:45 AM</span>
                            </div>
                        </div>
                    </div>
                    <div class="card-footer bg-light">
                        <a href="../BusStatus/BusStatus.aspx" class="btn btn-primary w-100">
                            <i class="fas fa-sync-alt me-2"></i>Update Status
                        </a>
                    </div>
                </div>
            </div>

            <!-- Today's Schedule -->
            <div class="col-lg-6 mb-4">
                <div class="card h-100">
                    <div class="card-header bg-success text-white">
                        <h5 class="card-title mb-0">Today's Schedule</h5>
                    </div>
                    <div class="card-body">
                        <div class="schedule-list">
                            <asp:Repeater ID="rptSchedule" runat="server">
                                <ItemTemplate>
                                    <div class='schedule-item <%# Eval("Status").ToString() == "In Progress" ? "active" : "" %>'>
                                        <div class="time"><%# Eval("DepartureTime") %></div>
                                        <div class="route">
                                            <div class="from"><%# Eval("DepartureStation") %></div>
                                            <i class="fas fa-arrow-right mx-2"></i>
                                            <div class="to"><%# Eval("ArrivalStation") %></div>
                                        </div>
                                        <div class="status"><%# Eval("Status") %></div>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Current Passengers -->
        <div class="card mb-4">
            <div class="card-header bg-info text-white">
                <h5 class="card-title mb-0">Current Passengers</h5>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>Student ID</th>
                                <th>Name</th>
                                <th>Boarding Point</th>
                                <th>Destination</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <asp:Repeater ID="rptPassengers" runat="server">
                                <ItemTemplate>
                                    <tr>
                                        <td><%# Eval("StudentID") %></td>
                                        <td><%# Eval("FullName") %></td>
                                        <td><%# Eval("BoardingPoint") %></td>
                                        <td><%# Eval("Destination") %></td>
                                        <td>
                                            <span class='badge <%# Eval("Status").ToString() == "On Board" ? "bg-success" : "bg-warning" %>'>
                                                <%# Eval("Status") %>
                                            </span>
                                        </td>
                                    </tr>
                                </ItemTemplate>
                            </asp:Repeater>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FooterScripts" runat="server">
    <script src="js/DriDefault.js"></script>
</asp:Content>
