<%@ Page Title="" Language="C#" MasterPageFile="~/Shared/Site.Master" AutoEventWireup="true" CodeBehind="BusStatus.aspx.cs" Inherits="StudentTransport.Shared.WebForm2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <link href="css/BusStatus.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="bus-status-page">
        <div class="header-section mb-5">
            <h1 class="display-5 fw-bold">Bus Status Management</h1>
            <p class="lead">Update your bus status in real-time</p>
        </div>

        <div class="row">
            <!-- Bus Status Controls -->
            <div class="col-lg-6 mb-4">
                <div class="card h-100">
                    <div class="card-header bg-primary text-white">
                        <h5 class="card-title mb-0">Update Bus Status</h5>
                    </div>
                    <div class="card-body">
                        <div class="current-status mb-4">
                            <h6 class="text-muted mb-3">Current Status</h6>
                            <div class="d-flex align-items-center">
                                <div id="currentStatusIndicator" class="status-indicator bg-success rounded-circle me-3"></div>
                                <h3 id="currentStatusText" class="fw-bold mb-0">Active</h3>
                            </div>
                        </div>

                        <div class="status-controls">
                            <h6 class="text-muted mb-3">Set New Status</h6>
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <div class="status-option active" data-status="Ready">
                                        <div class="status-icon bg-success">
                                            <i class="fas fa-check"></i>
                                        </div>
                                        <h5>Ready</h5>
                                        <p>Bus is ready for service</p>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="status-option" data-status="OffDuty">
                                        <div class="status-icon bg-secondary">
                                            <i class="fas fa-power-off"></i>
                                        </div>
                                        <h5>Off Duty</h5>
                                        <p>End of shift</p>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="status-option" data-status="Maintenance">
                                        <div class="status-icon bg-warning">
                                            <i class="fas fa-tools"></i>
                                        </div>
                                        <h5>Maintenance</h5>
                                        <p>Bus under repair</p>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="status-option" data-status="OutOfService">
                                        <div class="status-icon bg-danger">
                                            <i class="fas fa-exclamation-triangle"></i>
                                        </div>
                                        <h5>Out of Service</h5>
                                        <p>Unexpected issue</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="card-footer bg-light text-center">
                        <button id="btnUpdateStatus" class="btn btn-primary btn-lg w-100"
                            onclick="updateStatus()" disabled="disabled">
                            <i class="fas fa-sync-alt me-2"></i>Update Status
                        </button>
                    </div>
                </div>
            </div>

            <!-- Bus Information -->
            <div class="col-lg-6 mb-4">
                <div class="card h-100">
                    <div class="card-header bg-info text-white">
                        <h5 class="card-title mb-0">Bus Information</h5>
                    </div>
                    <div class="card-body">
                        <div class="bus-details">
                            <div class="detail-item">
                                <i class="fas fa-bus fa-2x text-primary"></i>
                                <div>
                                    <h6>Bus Number</h6>
                                    <h4 class="fw-bold">
                                        <asp:Literal ID="litBusNumber" runat="server">D-102</asp:Literal></h4>
                                </div>
                            </div>
                            <div class="detail-item">
                                <i class="fas fa-users fa-2x text-success"></i>
                                <div>
                                    <h6>Capacity</h6>
                                    <h4 class="fw-bold">
                                        <asp:Literal ID="litCapacity" runat="server">40 Passengers</asp:Literal></h4>
                                </div>
                            </div>
                            <div class="detail-item">
                                <i class="fas fa-gas-pump fa-2x text-warning"></i>
                                <div>
                                    <h6>Fuel Level</h6>
                                    <div class="progress mt-2" style="height: 20px;">
                                        <div id="fuelProgress" class="progress-bar bg-success" role="progressbar" style="width: 75%">75%</div>
                                    </div>
                                </div>
                            </div>
                            <div class="detail-item">
                                <i class="fas fa-road fa-2x text-danger"></i>
                                <div>
                                    <h6>Mileage</h6>
                                    <h4 class="fw-bold">
                                        <asp:Literal ID="litMileage" runat="server">12,345 km</asp:Literal></h4>
                                </div>
                            </div>
                        </div>

                        <div class="location-section mt-4">
                            <h6 class="text-muted mb-3">Current Location</h6>
                            <div class="map-placeholder">
                                <div class="map-point">
                                    <i class="fas fa-map-marker-alt fa-2x text-danger"></i>
                                </div>
                                <div class="location-text">
                                    <asp:Literal ID="litLocation" runat="server">Main Campus Bus Station</asp:Literal></div>
                            </div>
                            <button class="btn btn-outline-primary mt-3 w-100">
                                <i class="fas fa-location-arrow me-2"></i>Update Location
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Status History -->
        <div class="card">
            <div class="card-header bg-dark text-white">
                <h5 class="card-title mb-0">Status History</h5>
            </div>
            <div class="card-body">
                <div class="timeline">
                    <asp:Repeater ID="rptStatusHistory" runat="server">
                        <ItemTemplate>
                            <div class="timeline-item">
                                <div class='timeline-point <%# Eval("StatusClass") %>'></div>
                                <div class="timeline-content">
                                    <h6><%# Eval("Status") %></h6>
                                    <p class="text-muted">Status updated</p>
                                    <small class="text-muted"><%# Eval("StatusTime") %></small>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>
        </div>
    </div>

    <!-- Hidden fields -->
    <asp:HiddenField ID="hdnDriverId" runat="server" />
    <asp:HiddenField ID="hdnBusId" runat="server" />
    <asp:HiddenField ID="hdnCurrentStatus" runat="server" />
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FooterScripts" runat="server">
    <script src="js/BusStatus.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            const currentStatus = document.getElementById('<%= hdnCurrentStatus.ClientID %>').value;
            updateStatusIndicator(currentStatus);
        });

        function updateStatusIndicator(status) {
            const indicator = document.getElementById('currentStatusIndicator');
            const statusText = document.getElementById('currentStatusText');

            indicator.className = 'status-indicator rounded-circle me-3';
            statusText.className = 'fw-bold mb-0';

            switch (status) {
                case 'Ready':
                    indicator.classList.add('bg-success');
                    statusText.textContent = 'Ready';
                    break;
                case 'OffDuty':
                    indicator.classList.add('bg-secondary');
                    statusText.textContent = 'Off Duty';
                    break;
                case 'Maintenance':
                    indicator.classList.add('bg-warning');
                    statusText.textContent = 'Maintenance';
                    break;
                case 'OutOfService':
                    indicator.classList.add('bg-danger');
                    statusText.textContent = 'Out of Service';
                    break;
                default:
                    indicator.classList.add('bg-success');
                    statusText.textContent = 'Active';
            }
        }
    </script>
</asp:Content>
