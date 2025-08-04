<%@ Page Title="" Language="C#" MasterPageFile="~/Shared/Site.Master" AutoEventWireup="true" CodeBehind="DriDefault.aspx.cs" Inherits="StudentTransport.Shared.WebForm1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">    
    <link href="css/DriDefault.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="driver-dashboard">
        <div class="welcome-section mb-4">
            <h1 class="display-5 fw-bold">Driver Dashboard</h1>
            <p class="lead">Welcome back, <asp:Literal ID="litDriverName" runat="server"></asp:Literal>!</p>
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
                            <div class="schedule-item active">
                                <div class="time">08:00 AM</div>
                                <div class="route">
                                    <div class="from">Main Campus</div>
                                    <i class="fas fa-arrow-right mx-2"></i>
                                    <div class="to">Harmony Res</div>
                                </div>
                                <div class="status">In Progress</div>
                            </div>
                            <div class="schedule-item">
                                <div class="time">10:30 AM</div>
                                <div class="route">
                                    <div class="from">Harmony Res</div>
                                    <i class="fas fa-arrow-right mx-2"></i>
                                    <div class="to">Science Campus</div>
                                </div>
                                <div class="status">Upcoming</div>
                            </div>
                            <div class="schedule-item">
                                <div class="time">01:15 PM</div>
                                <div class="route">
                                    <div class="from">Science Campus</div>
                                    <i class="fas fa-arrow-right mx-2"></i>
                                    <div class="to">Engineering Campus</div>
                                </div>
                                <div class="status">Upcoming</div>
                            </div>
                            <div class="schedule-item">
                                <div class="time">03:45 PM</div>
                                <div class="route">
                                    <div class="from">Engineering Campus</div>
                                    <i class="fas fa-arrow-right mx-2"></i>
                                    <div class="to">Main Campus</div>
                                </div>
                                <div class="status">Upcoming</div>
                            </div>
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
                            <tr>
                                <td>S1001</td>
                                <td>Emma Wilson</td>
                                <td>Main Campus</td>
                                <td>Harmony Res</td>
                                <td><span class="badge bg-success">On Board</span></td>
                            </tr>
                            <tr>
                                <td>S1003</td>
                                <td>Olivia Martin</td>
                                <td>Main Campus</td>
                                <td>Harmony Res</td>
                                <td><span class="badge bg-success">On Board</span></td>
                            </tr>
                            <tr>
                                <td>S1005</td>
                                <td>Ava Garcia</td>
                                <td>Main Campus</td>
                                <td>Science Campus</td>
                                <td><span class="badge bg-warning">Pending</span></td>
                            </tr>
                            <tr>
                                <td>S1007</td>
                                <td>Sophia Rodriguez</td>
                                <td>Main Campus</td>
                                <td>Engineering Campus</td>
                                <td><span class="badge bg-warning">Pending</span></td>
                            </tr>
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
