<%@ Page Title="" Language="C#" MasterPageFile="~/Shared/Site.Master" AutoEventWireup="true" CodeBehind="StudDefault.aspx.cs" Inherits="StudentTransport.Shared.WebForm3" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <link href="css/StudDefault.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="student-dashboard">
        <div class="welcome-section mb-4">
            <h1 class="display-5 fw-bold">Student Dashboard</h1>
            <p class="lead">Welcome back, <asp:Literal ID="litStudentName" runat="server"></asp:Literal>!</p>
        </div>
        
        <div class="row">
            <!-- Quick Actions -->
            <div class="col-lg-4 mb-4">
                <div class="card h-100">
                    <div class="card-header bg-primary text-white">
                        <h5 class="card-title mb-0">Quick Actions</h5>
                    </div>
                    <div class="card-body">
                        <div class="d-grid gap-3">
                            <a href="../Schedule/Schedule.aspx" class="btn btn-outline-primary text-start">
                                <i class="fas fa-calendar-alt me-3"></i>View Schedule
                            </a>
                            <button class="btn btn-outline-success text-start">
                                <i class="fas fa-ticket-alt me-3"></i>Book a Ride
                            </button>
                            <button class="btn btn-outline-info text-start">
                                <i class="fas fa-map-marker-alt me-3"></i>Track Bus
                            </button>
                            <button class="btn btn-outline-warning text-start">
                                <i class="fas fa-history me-3"></i>Ride History
                            </button>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Next Ride -->
            <div class="col-lg-8 mb-4">
                <div class="card h-100">
                    <div class="card-header bg-success text-white">
                        <h5 class="card-title mb-0">Your Next Ride</h5>
                    </div>
                    <div class="card-body">
                        <div class="next-ride-card">
                            <div class="ride-header">
                                <div class="bus-info">
                                    <i class="fas fa-bus me-2"></i>
                                    <span>Bus #S-205</span>
                                    <span class="badge bg-success ms-2">On Time</span>
                                </div>
                                <div class="time">Today, 10:30 AM</div>
                            </div>
                            
                            <div class="route-details">
                                <div class="location from">
                                    <div class="location-icon">
                                        <i class="fas fa-map-marker-alt"></i>
                                    </div>
                                    <div class="location-info">
                                        <div class="name">Harmony Residence</div>
                                        <div class="time">Departure: 10:30 AM</div>
                                    </div>
                                </div>
                                
                                <div class="route-line">
                                    <div class="line"></div>
                                    <div class="stops">2 stops (15 mins)</div>
                                </div>
                                
                                <div class="location to">
                                    <div class="location-icon">
                                        <i class="fas fa-flag-checkered"></i>
                                    </div>
                                    <div class="location-info">
                                        <div class="name">Science Campus</div>
                                        <div class="time">Arrival: 10:45 AM</div>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="ride-footer">
                                <div class="driver-info">
                                    <i class="fas fa-user me-2"></i>
                                    Driver: Michael Johnson
                                </div>
                                <div class="actions">
                                    <button class="btn btn-sm btn-outline-primary">
                                        <i class="fas fa-map-marked-alt me-1"></i> Track
                                    </button>
                                    <button class="btn btn-sm btn-outline-danger">
                                        <i class="fas fa-times me-1"></i> Cancel
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Active Buses -->
        <div class="card mb-4">
            <div class="card-header bg-info text-white">
                <h5 class="card-title mb-0">Active Buses Near You</h5>
            </div>
            <div class="card-body">
                <div class="map-container mb-4">
                    <div class="map-placeholder">
                        <div class="user-location">
                            <i class="fas fa-user-circle"></i>
                            <div class="pulse-ring"></div>
                        </div>
                        <div class="bus-location" style="top: 40%; left: 30%;">
                            <i class="fas fa-bus"></i>
                            <span class="bus-number">S-205</span>
                        </div>
                        <div class="bus-location" style="top: 60%; left: 70%;">
                            <i class="fas fa-bus"></i>
                            <span class="bus-number">S-208</span>
                        </div>
                        <div class="bus-location" style="top: 30%; left: 80%;">
                            <i class="fas fa-bus"></i>
                            <span class="bus-number">S-212</span>
                        </div>
                    </div>
                </div>
                
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>Bus #</th>
                                <th>Route</th>
                                <th>Next Stop</th>
                                <th>Status</th>
                                <th>Estimated Arrival</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>S-205</td>
                                <td>Harmony Res → Science Campus</td>
                                <td>Main Library</td>
                                <td><span class="badge bg-success">On Time</span></td>
                                <td>10:30 AM</td>
                                <td>
                                    <button class="btn btn-sm btn-primary">
                                        <i class="fas fa-eye me-1"></i> View
                                    </button>
                                </td>
                            </tr>
                            <tr>
                                <td>S-208</td>
                                <td>Garden Res → Engineering Campus</td>
                                <td>Student Center</td>
                                <td><span class="badge bg-warning">Delayed</span></td>
                                <td>10:45 AM</td>
                                <td>
                                    <button class="btn btn-sm btn-primary">
                                        <i class="fas fa-eye me-1"></i> View
                                    </button>
                                </td>
                            </tr>
                            <tr>
                                <td>S-212</td>
                                <td>Mountain View → Main Campus</td>
                                <td>Sports Complex</td>
                                <td><span class="badge bg-success">On Time</span></td>
                                <td>11:15 AM</td>
                                <td>
                                    <button class="btn btn-sm btn-primary">
                                        <i class="fas fa-eye me-1"></i> View
                                    </button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        
        <!-- Recent Bookings -->
        <div class="card">
            <div class="card-header bg-dark text-white">
                <h5 class="card-title mb-0">Recent Bookings</h5>
            </div>
            <div class="card-body">
                <div class="timeline">
                    <div class="timeline-item">
                        <div class="timeline-point bg-success"></div>
                        <div class="timeline-content">
                            <h6>Science Campus → Harmony Res</h6>
                            <p class="text-muted">Bus #S-205 | Driver: Michael Johnson</p>
                            <div class="d-flex justify-content-between">
                                <small class="text-muted">Today, 08:30 AM</small>
                                <span class="badge bg-success">Completed</span>
                            </div>
                        </div>
                    </div>
                    <div class="timeline-item">
                        <div class="timeline-point bg-info"></div>
                        <div class="timeline-content">
                            <h6>Engineering Campus → Garden Res</h6>
                            <p class="text-muted">Bus #S-208 | Driver: Sarah Williams</p>
                            <div class="d-flex justify-content-between">
                                <small class="text-muted">Yesterday, 05:15 PM</small>
                                <span class="badge bg-info">In Progress</span>
                            </div>
                        </div>
                    </div>
                    <div class="timeline-item">
                        <div class="timeline-point bg-primary"></div>
                        <div class="timeline-content">
                            <h6>Main Campus → Mountain View</h6>
                            <p class="text-muted">Bus #S-212 | Driver: Robert Davis</p>
                            <div class="d-flex justify-content-between">
                                <small class="text-muted">Yesterday, 03:45 PM</small>
                                <span class="badge bg-primary">Upcoming</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="FooterScripts" runat="server">
    <script src="js/StudDefault.js"></script>
</asp:Content>
