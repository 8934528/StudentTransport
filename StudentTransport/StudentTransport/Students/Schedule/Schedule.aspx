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
                        <div class="d-flex justify-content-between align-items-center">
                            <h5 class="card-title mb-0">Weekly Schedule</h5>
                            <div>
                                <asp:Button ID="btnPrevWeek" runat="server" CssClass="btn btn-sm btn-outline-light"
                                    Text="&lt; Prev" OnClick="btnPrevWeek_Click" />
                                <asp:Button ID="btnNextWeek" runat="server" CssClass="btn btn-sm btn-outline-light"
                                    Text="Next &gt;" OnClick="btnNextWeek_Click" />
                            </div>
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="schedule-calendar">
                            <div class="calendar-header">
                                <h4 id="currentWeek" runat="server">Week of May 15, 2023</h4>
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
                                <!-- Slots will be populated dynamically -->
                                <asp:Literal ID="litCalendarSlots" runat="server"></asp:Literal>
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
                            <asp:Panel ID="pnlNoSelection" runat="server" CssClass="no-selection">
                                <i class="fas fa-calendar-alt fa-3x mb-3"></i>
                                <p>Select a time slot to book a ride</p>
                            </asp:Panel>
                            <asp:Panel ID="pnlSelectionDetails" runat="server" CssClass="selection-details d-none">
                                <h5 class="booking-time" id="litBookingTime" runat="server">Monday, May 15 - 8:00 AM</h5>
                                <div class="route-details mb-3">
                                    <div class="location">
                                        <i class="fas fa-map-marker-alt me-2"></i>
                                        <span id="litDepartureStation" runat="server">Harmony Residence</span>
                                    </div>
                                    <div class="location">
                                        <i class="fas fa-flag-checkered me-2"></i>
                                        <span id="litArrivalStation" runat="server">Science Campus</span>
                                    </div>
                                </div>
                                <div class="bus-info mb-3">
                                    <i class="fas fa-bus me-2"></i>
                                    <span id="litBusNumber" runat="server">Bus #S-205</span>
                                </div>
                                <div class="driver-info mb-4">
                                    <i class="fas fa-user me-2"></i>
                                    <span id="litDriverName" runat="server">Driver: Michael Johnson</span>
                                </div>
                                <asp:Button ID="btnConfirmBooking" runat="server" CssClass="btn btn-success w-100"
                                    Text="Confirm Booking" OnClick="btnConfirmBooking_Click" />
                                <button class="btn btn-outline-secondary w-100 mt-2" id="btnCancelSelection">
                                    Cancel Selection
                                </button>
                            </asp:Panel>
                        </div>
                    </div>
                </div>

                <div class="card">
                    <div class="card-header bg-success text-white">
                        <h5 class="card-title mb-0">Upcoming Bookings</h5>
                    </div>
                    <div class="card-body">
                        <div class="upcoming-bookings">
                            <asp:Repeater ID="rptUpcomingBookings" runat="server"
                                OnItemCommand="rptUpcomingBookings_ItemCommand">
                                <ItemTemplate>
                                    <div class="booking-item">
                                        <div class="booking-date"><%# Eval("BookingDate") %></div>
                                        <div class="booking-time"><%# Eval("BookingTime") %></div>
                                        <div class="booking-route"><%# Eval("Route") %></div>
                                        <div class="booking-bus"><%# Eval("BusNumber") %></div>
                                        <asp:Button ID="btnCancelBooking" runat="server" CssClass="btn btn-sm btn-outline-danger"
                                            CommandName="Cancel" CommandArgument='<%# Eval("BookingID") %>' Text="X" />
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>

                            <asp:Panel ID="pnlNoUpcomingBookings" runat="server" CssClass="text-center py-3" Visible="false">
                                <i class="fas fa-calendar-times fa-2x mb-2"></i>
                                <p>No upcoming bookings</p>
                            </asp:Panel>
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
                        <!-- Stops will be added dynamically -->
                    </div>
                </div>

                <div class="route-stops">
                    <!-- Stops will be added dynamically -->
                </div>
            </div>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FooterScripts" runat="server">
    <script src="js/Schedule.js"></script>
</asp:Content>
