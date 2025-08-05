<%@ Page Title="" Language="C#" MasterPageFile="~/Shared/Site.Master" AutoEventWireup="true" CodeBehind="StudDefault.aspx.cs" Inherits="StudentTransport.Shared.WebForm3" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <link href="css/StudDefault.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="student-dashboard">
        <div class="welcome-section mb-4">
            <h1 class="display-5 fw-bold">Student Dashboard</h1>
            <p class="lead">Welcome back,
                <asp:Literal ID="litStudentName" runat="server"></asp:Literal>!</p>
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
                        <asp:Panel ID="pnlNoNextRide" runat="server" CssClass="text-center py-4">
                            <i class="fas fa-bus fa-3x text-muted mb-3"></i>
                            <p>No upcoming rides scheduled</p>
                        </asp:Panel>

                        <asp:Panel ID="pnlNextRide" runat="server" CssClass="next-ride-card" Visible="false">
                            <div class="ride-header">
                                <div class="bus-info">
                                    <i class="fas fa-bus me-2"></i>
                                    <span>Bus #<asp:Literal ID="litBusNumber" runat="server"></asp:Literal></span>
                                    <span class="badge bg-success ms-2">On Time</span>
                                </div>
                                <div class="time">
                                    <asp:Literal ID="litDepartureTime" runat="server"></asp:Literal>
                                </div>
                            </div>

                            <div class="route-details">
                                <div class="location from">
                                    <div class="location-icon">
                                        <i class="fas fa-map-marker-alt"></i>
                                    </div>
                                    <div class="location-info">
                                        <div class="name">
                                            <asp:Literal ID="litDepartureStation" runat="server"></asp:Literal>
                                        </div>
                                        <div class="time">Departure:
                                            <asp:Literal ID="litDepartureTime2" runat="server"></asp:Literal></div>
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
                                        <div class="name">
                                            <asp:Literal ID="litArrivalStation" runat="server"></asp:Literal>
                                        </div>
                                        <div class="time">Arrival:
                                            <asp:Literal ID="litArrivalTime" runat="server"></asp:Literal></div>
                                    </div>
                                </div>
                            </div>

                            <div class="ride-footer">
                                <div class="driver-info">
                                    <i class="fas fa-user me-2"></i>
                                    Driver:
                                    <asp:Literal ID="litDriverName" runat="server"></asp:Literal>
                                </div>
                                <div class="actions">
                                    <button class="btn btn-sm btn-outline-primary">
                                        <i class="fas fa-map-marked-alt me-1"></i>Track
                                    </button>
                                    <asp:Button ID="btnCancelRide" runat="server" CssClass="btn btn-sm btn-outline-danger"
                                        Text="Cancel" OnClick="btnCancelRide_Click" />
                                </div>
                            </div>
                        </asp:Panel>
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
                        <!-- Bus locations will be added dynamically -->
                    </div>
                </div>

                <div class="table-responsive">
                    <asp:Repeater ID="rptActiveBuses" runat="server">
                        <HeaderTemplate>
                            <table class="table table-hover">
                                <thead>
                                    <tr>
                                        <th>Bus #</th>
                                        <th>Route</th>
                                        <th>Status</th>
                                        <th>Last Update</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <tr>
                                <td><%# Eval("BusNumber") %></td>
                                <td><%# Eval("Route") %></td>
                                <td><span class='badge <%# Eval("StatusClass") %>'><%# Eval("Status") %></span></td>
                                <td><%# Convert.ToDateTime(Eval("StatusTime")).ToString("hh:mm tt") %></td>
                                <td>
                                    <button class="btn btn-sm btn-primary">
                                        <i class="fas fa-eye me-1"></i>View
                                    </button>
                                </td>
                            </tr>
                        </ItemTemplate>
                        <FooterTemplate>
                            </tbody>
                            </table>
                        </FooterTemplate>
                    </asp:Repeater>
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
                    <asp:Repeater ID="rptRecentBookings" runat="server">
                        <ItemTemplate>
                            <div class="timeline-item">
                                <div class="timeline-point <%# Eval("StatusClass") %>"></div>
                                <div class="timeline-content">
                                    <h6><%# Eval("Route") %></h6>
                                    <p class="text-muted">Bus #<%# Eval("BusNumber") %> | Driver: <%# Eval("DriverName") %></p>
                                    <div class="d-flex justify-content-between">
                                        <small class="text-muted">
                                            <%# Convert.ToDateTime(Eval("DepartureTime")).ToString("MMM dd, hh:mm tt") %>
                                        </small>
                                        <span class='badge <%# Eval("StatusClass") %>'><%# Eval("Status") %></span>
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FooterScripts" runat="server">
    <script src="js/StudDefault.js"></script>
</asp:Content>
