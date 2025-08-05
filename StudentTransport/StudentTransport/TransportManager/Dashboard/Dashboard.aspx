<%@ Page Title="" Language="C#" MasterPageFile="~/Shared/Site.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="StudentTransport.Shared.WebForm5" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <link href="css/Dashboard.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="manager-dashboard">
        <div class="header-section mb-4">
            <h1 class="display-5 fw-bold">Transport Manager Dashboard</h1>
            <p class="lead">Overview of the transport operations</p>
        </div>
        
        <!-- Stats Summary -->
        <div class="row mb-4">
            <div class="col-xl-3 col-md-6 mb-4">
                <div class="card stat-card bg-primary text-white">
                    <div class="card-body">
                        <div class="d-flex justify-content-between">
                            <div>
                                <h5 class="card-title">Total Students</h5>
                                <h2 class="fw-bold"><asp:Literal ID="lblTotalStudents" runat="server" Text="0" /></h2>
                            </div>
                            <div class="stat-icon">
                                <i class="fas fa-users fa-3x"></i>
                            </div>
                        </div>
                        <div class="stat-footer">
                            <i class="fas fa-arrow-up me-1"></i> Registered students
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="col-xl-3 col-md-6 mb-4">
                <div class="card stat-card bg-success text-white">
                    <div class="card-body">
                        <div class="d-flex justify-content-between">
                            <div>
                                <h5 class="card-title">Active Drivers</h5>
                                <h2 class="fw-bold"><asp:Literal ID="lblActiveDrivers" runat="server" Text="0" /></h2>
                            </div>
                            <div class="stat-icon">
                                <i class="fas fa-bus fa-3x"></i>
                            </div>
                        </div>
                        <div class="stat-footer">
                            <i class="fas fa-user-clock me-1"></i> Currently available
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="col-xl-3 col-md-6 mb-4">
                <div class="card stat-card bg-warning text-dark">
                    <div class="card-body">
                        <div class="d-flex justify-content-between">
                            <div>
                                <h5 class="card-title">Active Buses</h5>
                                <h2 class="fw-bold"><asp:Literal ID="lblActiveBuses" runat="server" Text="0" /></h2>
                            </div>
                            <div class="stat-icon">
                                <i class="fas fa-shuttle-van fa-3x"></i>
                            </div>
                        </div>
                        <div class="stat-footer">
                            <i class="fas fa-road me-1"></i> In service now
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="col-xl-3 col-md-6 mb-4">
                <div class="card stat-card bg-info text-white">
                    <div class="card-body">
                        <div class="d-flex justify-content-between">
                            <div>
                                <h5 class="card-title">Today's Bookings</h5>
                                <h2 class="fw-bold"><asp:Literal ID="lblTodaysBookings" runat="server" Text="0" /></h2>
                            </div>
                            <div class="stat-icon">
                                <i class="fas fa-ticket-alt fa-3x"></i>
                            </div>
                        </div>
                        <div class="stat-footer">
                            <i class="fas fa-calendar-day me-1"></i> Confirmed bookings
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Charts and Main Content -->
        <div class="row">
            <!-- Left Column -->
            <div class="col-lg-8">
                <!-- Activity Chart -->
                <div class="card mb-4">
                    <div class="card-header bg-dark text-white">
                        <h5 class="card-title mb-0">Transport Activity</h5>
                    </div>
                    <div class="card-body">
                        <div class="chart-container">
                            <canvas id="activityChart"></canvas>
                        </div>
                    </div>
                </div>
                
                <!-- Recent Bookings -->
                <div class="card mb-4">
                    <div class="card-header bg-secondary text-white">
                        <h5 class="card-title mb-0">Recent Bookings</h5>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-hover">
                                <thead>
                                    <tr>
                                        <th>Booking ID</th>
                                        <th>Student</th>
                                        <th>Route</th>
                                        <th>Time</th>
                                        <th>Status</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <asp:Repeater ID="rptRecentBookings" runat="server">
                                        <ItemTemplate>
                                            <tr>
                                                <td>B<%# Eval("BookingID") %></td>
                                                <td><%# Eval("StudentName") %></td>
                                                <td><%# Eval("Route") %></td>
                                                <td><%# Eval("Time") %></td>
                                                <td>
                                                    <span class='badge <%# Eval("StatusClass") %>'>
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
            
            <!-- Right Column -->
            <div class="col-lg-4">
                <!-- Bus Status Overview -->
                <div class="card mb-4">
                    <div class="card-header bg-danger text-white">
                        <h5 class="card-title mb-0">Bus Status Overview</h5>
                    </div>
                    <div class="card-body">
                        <div class="status-list">
                            <asp:Repeater ID="rptBusStatus" runat="server">
                                <ItemTemplate>
                                    <div class="status-item">
                                        <div class="bus-info">
                                            <span class="bus-number"><%# Eval("BusNumber") %></span>
                                            <span class="bus-route"><%# Eval("Route") %></span>
                                        </div>
                                        <div class='status-indicator <%# Eval("StatusClass") %>'></div>
                                        <div class="status-text"><%# Eval("Status") %></div>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                        </div>
                    </div>
                </div>
                
                <!-- Quick Actions -->
                <div class="card mb-4">
                    <div class="card-header bg-info text-white">
                        <h5 class="card-title mb-0">Quick Actions</h5>
                    </div>
                    <div class="card-body">
                        <div class="d-grid gap-2">
                            <a href="../ManageStudents/ManageStudents.aspx" class="btn btn-primary btn-lg">
                                <i class="fas fa-user-graduate me-2"></i>Manage Students
                            </a>
                            <a href="../ManageDrivers/ManageDrivers.aspx" class="btn btn-success btn-lg">
                                <i class="fas fa-bus me-2"></i>Manage Drivers
                            </a>
                            <a href="../CreateSchedule/CreateSchedule.aspx" class="btn btn-warning btn-lg">
                                <i class="fas fa-calendar-plus me-2"></i>Create Schedule
                            </a>
                            <a href="../ReportIssue/ReportIssue.aspx" class="btn btn-danger btn-lg">
                                <i class="fas fa-exclamation-triangle me-2"></i>Report Issue
                            </a>
                        </div>
                    </div>
                </div>
                
                <!-- System Alerts -->
                <div class="card">
                    <div class="card-header bg-warning text-dark">
                        <h5 class="card-title mb-0">System Alerts</h5>
                    </div>
                    <div class="card-body">
                        <div class="alert-list">
                            <div class="alert-item critical">
                                <i class="fas fa-exclamation-circle"></i>
                                <div class="alert-content">
                                    <div class="alert-title">Bus B-105 requires maintenance</div>
                                    <div class="alert-time"><%# DateTime.Now.AddMinutes(-10).ToString("hh:mm tt") %></div>
                                </div>
                            </div>
                            <div class="alert-item warning">
                                <i class="fas fa-clock"></i>
                                <div class="alert-content">
                                    <div class="alert-title">Route 3 delayed by 15 minutes</div>
                                    <div class="alert-time"><%# DateTime.Now.AddMinutes(-45).ToString("hh:mm tt") %></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="FooterScripts" runat="server">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="js/Dashboard.js"></script>
</asp:Content>
