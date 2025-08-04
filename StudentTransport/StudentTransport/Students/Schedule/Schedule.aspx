<%@ Page Title="" Language="C#" MasterPageFile="~/Shared/Site.Master" AutoEventWireup="true" CodeBehind="Schedule.aspx.cs" Inherits="StudentTransport.Shared.WebForm4" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <link href="css/Schedule.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="schedule-page">
        <div class="header-section mb-4">
            <h1 class="display-5 fw-bold">Transport Schedule</h1>
            <p class="lead">View and book available bus routes</p>
        </div>
        
        <div class="row mb-4">
            <div class="col-md-8">
                <div class="card">
                    <div class="card-header bg-primary text-white">
                        <h5 class="card-title mb-0">Weekly Schedule</h5>
                    </div>
                    <div class="card-body">
                        <div class="schedule-calendar">
                            <div class="calendar-header">
                                <button class="btn btn-sm btn-outline-secondary" id="btnPrevWeek">
                                    <i class="fas fa-chevron-left"></i>
                                </button>
                                <h4 id="currentWeek">Week of May 15, 2023</h4>
                                <button class="btn btn-sm btn-outline-secondary" id="btnNextWeek">
                                    <i class="fas fa-chevron-right"></i>
                                </button>
                            </div>
                            
                            <div class="calendar-days">
                                <div class="day">Mon</div>
                                <div class="day">Tue</div>
                                <div class="day">Wed</div>
                                <div class="day">Thu</div>
                                <div class="day">Fri</div>
                                <div class="day">Sat</div>
                                <div class="day">Sun</div>
                            </div>
                            
                            <div class="calendar-slots">
                                <!-- Morning Slots -->
                                <div class="time-slot">
                                    <div class="time-label">Morning</div>
                                    <div class="day-slots">
                                        <div class="slot available">
                                            <span>8:00 AM</span>
                                            <span>Bus #S-205</span>
                                        </div>
                                        <div class="slot booked">
                                            <span>8:30 AM</span>
                                            <span>Booked</span>
                                        </div>
                                        <div class="slot available">
                                            <span>9:00 AM</span>
                                            <span>Bus #S-208</span>
                                        </div>
                                        <div class="slot available">
                                            <span>9:30 AM</span>
                                            <span>Bus #S-212</span>
                                        </div>
                                        <div class="slot not-available">
                                            <span>No Service</span>
                                        </div>
                                        <div class="slot not-available">
                                            <span>No Service</span>
                                        </div>
                                        <div class="slot not-available">
                                            <span>No Service</span>
                                        </div>
                                    </div>
                                </div>
                                
                                <!-- Afternoon Slots -->
                                <div class="time-slot">
                                    <div class="time-label">Afternoon</div>
                                    <div class="day-slots">
                                        <div class="slot available">
                                            <span>12:00 PM</span>
                                            <span>Bus #S-205</span>
                                        </div>
                                        <div class="slot available">
                                            <span>12:30 PM</span>
                                            <span>Bus #S-208</span>
                                        </div>
                                        <div class="slot available">
                                            <span>1:00 PM</span>
                                            <span>Bus #S-212</span>
                                        </div>
                                        <div class="slot available">
                                            <span>1:30 PM</span>
                                            <span>Bus #S-205</span>
                                        </div>
                                        <div class="slot available">
                                            <span>2:00 PM</span>
                                            <span>Bus #S-208</span>
                                        </div>
                                        <div class="slot not-available">
                                            <span>No Service</span>
                                        </div>
                                        <div class="slot not-available">
                                            <span>No Service</span>
                                        </div>
                                    </div>
                                </div>
                                
                                <!-- Evening Slots -->
                                <div class="time-slot">
                                    <div class="time-label">Evening</div>
                                    <div class="day-slots">
                                        <div class="slot available">
                                            <span>4:00 PM</span>
                                            <span>Bus #S-205</span>
                                        </div>
                                        <div class="slot available">
                                            <span>4:30 PM</span>
                                            <span>Bus #S-208</span>
                                        </div>
                                        <div class="slot available">
                                            <span>5:00 PM</span>
                                            <span>Bus #S-212</span>
                                        </div>
                                        <div class="slot booked">
                                            <span>5:30 PM</span>
                                            <span>Booked</span>
                                        </div>
                                        <div class="slot available">
                                            <span>6:00 PM</span>
                                            <span>Bus #S-205</span>
                                        </div>
                                        <div class="slot not-available">
                                            <span>No Service</span>
                                        </div>
                                        <div class="slot not-available">
                                            <span>No Service</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="col-md-4">
                <div class="card mb-4">
                    <div class="card-header bg-info text-white">
                        <h5 class="card-title mb-0">Booking Details</h5>
                    </div>
                    <div class="card-body">
                        <div class="booking-preview">
                            <div class="no-selection">
                                <i class="fas fa-calendar-alt fa-3x mb-3"></i>
                                <p>Select a time slot to book a ride</p>
                            </div>
                            <div class="selection-details d-none">
                                <h5 class="booking-time">Monday, May 15 - 8:00 AM</h5>
                                <div class="route-details mb-3">
                                    <div class="location">
                                        <i class="fas fa-map-marker-alt me-2"></i>
                                        <span>Harmony Residence</span>
                                    </div>
                                    <div class="location">
                                        <i class="fas fa-flag-checkered me-2"></i>
                                        <span>Science Campus</span>
                                    </div>
                                </div>
                                <div class="bus-info mb-3">
                                    <i class="fas fa-bus me-2"></i>
                                    <span>Bus #S-205</span>
                                </div>
                                <div class="driver-info mb-4">
                                    <i class="fas fa-user me-2"></i>
                                    <span>Driver: Michael Johnson</span>
                                </div>
                                <button class="btn btn-success w-100" id="btnConfirmBooking">
                                    <i class="fas fa-check me-2"></i>Confirm Booking
                                </button>
                                <button class="btn btn-outline-secondary w-100 mt-2" id="btnCancelSelection">
                                    Cancel Selection
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="card">
                    <div class="card-header bg-success text-white">
                        <h5 class="card-title mb-0">Upcoming Bookings</h5>
                    </div>
                    <div class="card-body">
                        <div class="upcoming-bookings">
                            <div class="booking-item">
                                <div class="booking-date">Mon, May 15</div>
                                <div class="booking-time">8:00 AM</div>
                                <div class="booking-route">Harmony Res → Science Campus</div>
                                <div class="booking-bus">Bus #S-205</div>
                                <button class="btn btn-sm btn-outline-danger">
                                    <i class="fas fa-times"></i>
                                </button>
                            </div>
                            <div class="booking-item">
                                <div class="booking-date">Wed, May 17</div>
                                <div class="booking-time">5:30 PM</div>
                                <div class="booking-route">Science Campus → Harmony Res</div>
                                <div class="booking-bus">Bus #S-212</div>
                                <button class="btn btn-sm btn-outline-danger">
                                    <i class="fas fa-times"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Route Information -->
        <div class="card">
            <div class="card-header bg-dark text-white">
                <h5 class="card-title mb-0">Route Details</h5>
            </div>
            <div class="card-body">
                <div class="route-map mb-4">
                    <div class="map-placeholder">
                        <div class="route-line"></div>
                        <div class="stop" style="top: 20%; left: 10%;">
                            <div class="stop-icon"></div>
                            <div class="stop-label">Harmony Res</div>
                        </div>
                        <div class="stop" style="top: 40%; left: 30%;">
                            <div class="stop-icon"></div>
                            <div class="stop-label">Student Center</div>
                        </div>
                        <div class="stop" style="top: 60%; left: 50%;">
                            <div class="stop-icon"></div>
                            <div class="stop-label">Main Library</div>
                        </div>
                        <div class="stop" style="top: 80%; left: 70%;">
                            <div class="stop-icon"></div>
                            <div class="stop-label">Science Campus</div>
                        </div>
                    </div>
                </div>
                
                <div class="route-stops">
                    <div class="stop-item">
                        <div class="stop-marker bg-primary"></div>
                        <div class="stop-details">
                            <h6>Harmony Residence</h6>
                            <p class="text-muted">Departure point</p>
                        </div>
                        <div class="stop-time">8:00 AM</div>
                    </div>
                    <div class="stop-item">
                        <div class="stop-marker bg-info"></div>
                        <div class="stop-details">
                            <h6>Student Center</h6>
                            <p class="text-muted">Estimated arrival: 8:10 AM</p>
                        </div>
                        <div class="stop-time">8:15 AM</div>
                    </div>
                    <div class="stop-item">
                        <div class="stop-marker bg-info"></div>
                        <div class="stop-details">
                            <h6>Main Library</h6>
                            <p class="text-muted">Estimated arrival: 8:25 AM</p>
                        </div>
                        <div class="stop-time">8:30 AM</div>
                    </div>
                    <div class="stop-item">
                        <div class="stop-marker bg-success"></div>
                        <div class="stop-details">
                            <h6>Science Campus</h6>
                            <p class="text-muted">Final destination</p>
                        </div>
                        <div class="stop-time">8:45 AM</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="FooterScripts" runat="server">
    <script src="js/Schedule.js"></script>
</asp:Content>
