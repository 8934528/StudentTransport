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
                                <h2 class="fw-bold">1,245</h2>
                            </div>
                            <div class="stat-icon">
                                <i class="fas fa-users fa-3x"></i>
                            </div>
                        </div>
                        <div class="stat-footer">
                            <i class="fas fa-arrow-up me-1"></i> 12% from last month
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
                                <h2 class="fw-bold">28</h2>
                            </div>
                            <div class="stat-icon">
                                <i class="fas fa-bus fa-3x"></i>
                            </div>
                        </div>
                        <div class="stat-footer">
                            <i class="fas fa-arrow-up me-1"></i> 3 new this month
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
                                <h2 class="fw-bold">18</h2>
                            </div>
                            <div class="stat-icon">
                                <i class="fas fa-shuttle-van fa-3x"></i>
                            </div>
                        </div>
                        <div class="stat-footer">
                            <i class="fas fa-arrow-down me-1"></i> 2 in maintenance
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
                                <h2 class="fw-bold">342</h2>
                            </div>
                            <div class="stat-icon">
                                <i class="fas fa-ticket-alt fa-3x"></i>
                            </div>
                        </div>
                        <div class="stat-footer">
                            <i class="fas fa-arrow-up me-1"></i> 15% from yesterday
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
                        <div class="header-actions">
                            <button class="btn btn-sm btn-light">View All</button>
                        </div>
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
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>B10023</td>
                                        <td>Emma Wilson</td>
                                        <td>Main Campus → Harmony Res</td>
                                        <td>08:30 AM</td>
                                        <td><span class="badge bg-success">Completed</span></td>
                                        <td>
                                            <button class="btn btn-sm btn-outline-primary">Details</button>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>B10024</td>
                                        <td>Noah Harris</td>
                                        <td>Science Campus → Garden Res</td>
                                        <td>09:15 AM</td>
                                        <td><span class="badge bg-primary">In Progress</span></td>
                                        <td>
                                            <button class="btn btn-sm btn-outline-primary">Details</button>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>B10025</td>
                                        <td>Olivia Martin</td>
                                        <td>Engineering Campus → Mountain View</td>
                                        <td>10:45 AM</td>
                                        <td><span class="badge bg-warning">Scheduled</span></td>
                                        <td>
                                            <button class="btn btn-sm btn-outline-primary">Details</button>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>B10026</td>
                                        <td>Liam Thompson</td>
                                        <td>Harmony Res → Main Campus</td>
                                        <td>11:30 AM</td>
                                        <td><span class="badge bg-warning">Scheduled</span></td>
                                        <td>
                                            <button class="btn btn-sm btn-outline-primary">Details</button>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>B10027</td>
                                        <td>Ava Garcia</td>
                                        <td>Garden Res → Science Campus</td>
                                        <td>01:15 PM</td>
                                        <td><span class="badge bg-secondary">Pending</span></td>
                                        <td>
                                            <button class="btn btn-sm btn-outline-primary">Details</button>
                                        </td>
                                    </tr>
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
                            <div class="status-item active">
                                <div class="bus-info">
                                    <span class="bus-number">B-101</span>
                                    <span class="bus-route">Main Campus → Harmony Res</span>
                                </div>
                                <div class="status-indicator bg-success"></div>
                                <div class="status-text">Active</div>
                            </div>
                            <div class="status-item">
                                <div class="bus-info">
                                    <span class="bus-number">B-102</span>
                                    <span class="bus-route">Science Campus → Garden Res</span>
                                </div>
                                <div class="status-indicator bg-primary"></div>
                                <div class="status-text">In Progress</div>
                            </div>
                            <div class="status-item">
                                <div class="bus-info">
                                    <span class="bus-number">B-103</span>
                                    <span class="bus-route">Engineering Campus → Mountain View</span>
                                </div>
                                <div class="status-indicator bg-warning"></div>
                                <div class="status-text">Delayed</div>
                            </div>
                            <div class="status-item">
                                <div class="bus-info">
                                    <span class="bus-number">B-104</span>
                                    <span class="bus-route">Main Campus → Science Campus</span>
                                </div>
                                <div class="status-indicator bg-secondary"></div>
                                <div class="status-text">Scheduled</div>
                            </div>
                            <div class="status-item">
                                <div class="bus-info">
                                    <span class="bus-number">B-105</span>
                                    <span class="bus-route">Harmony Res → Engineering Campus</span>
                                </div>
                                <div class="status-indicator bg-danger"></div>
                                <div class="status-text">Maintenance</div>
                            </div>
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
                            <button class="btn btn-warning btn-lg">
                                <i class="fas fa-calendar-plus me-2"></i>Create Schedule
                            </button>
                            <button class="btn btn-danger btn-lg">
                                <i class="fas fa-exclamation-triangle me-2"></i>Report Issue
                            </button>
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
                                    <div class="alert-time">10 minutes ago</div>
                                </div>
                            </div>
                            <div class="alert-item warning">
                                <i class="fas fa-clock"></i>
                                <div class="alert-content">
                                    <div class="alert-title">Route 3 delayed by 15 minutes</div>
                                    <div class="alert-time">45 minutes ago</div>
                                </div>
                            </div>
                            <div class="alert-item info">
                                <i class="fas fa-info-circle"></i>
                                <div class="alert-content">
                                    <div class="alert-title">New driver registration pending</div>
                                    <div class="alert-time">2 hours ago</div>
                                </div>
                            </div>
                            <div class="alert-item resolved">
                                <i class="fas fa-check-circle"></i>
                                <div class="alert-content">
                                    <div class="alert-title">Bus B-102 maintenance completed</div>
                                    <div class="alert-time">Yesterday</div>
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
