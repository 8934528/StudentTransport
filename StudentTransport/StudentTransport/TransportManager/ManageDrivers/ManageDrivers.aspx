<%@ Page Title="" Language="C#" MasterPageFile="~/Shared/Site.Master" AutoEventWireup="true" CodeBehind="ManageDrivers.aspx.cs" Inherits="StudentTransport.Shared.WebForm6" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <link href="css/ManageDrivers.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="manage-drivers">
        <div class="header-section mb-4">
            <div class="d-flex justify-content-between align-items-center">
                <div>
                    <h1 class="display-5 fw-bold">Manage Drivers</h1>
                    <p class="lead">View and manage driver information</p>
                </div>
                <div>
                    <button class="btn btn-primary">
                        <i class="fas fa-plus me-2"></i>Add New Driver
                    </button>
                </div>
            </div>
        </div>
        
        <!-- Filters and Search -->
        <div class="card mb-4">
            <div class="card-body">
                <div class="row g-3">
                    <div class="col-md-4">
                        <label for="txtSearch" class="form-label">Search</label>
                        <div class="input-group">
                            <input type="text" class="form-control" placeholder="Search drivers...">
                            <button class="btn btn-outline-secondary" type="button">
                                <i class="fas fa-search"></i>
                            </button>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <label for="ddlStatus" class="form-label">Status</label>
                        <select class="form-select" id="ddlStatus">
                            <option selected>All Statuses</option>
                            <option>Active</option>
                            <option>On Leave</option>
                            <option>Suspended</option>
                        </select>
                    </div>
                    <div class="col-md-4">
                        <label for="ddlBus" class="form-label">Assigned Bus</label>
                        <select class="form-select" id="ddlBus">
                            <option selected>All Buses</option>
                            <option>B-101</option>
                            <option>B-102</option>
                            <option>B-103</option>
                            <option>B-104</option>
                            <option>B-105</option>
                        </select>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Drivers List -->
        <div class="row">
            <!-- Driver Cards -->
            <div class="col-md-6 col-lg-4 mb-4">
                <div class="card driver-card">
                    <div class="card-header bg-primary text-white">
                        <h5 class="card-title mb-0">David Miller</h5>
                    </div>
                    <div class="card-body">
                        <div class="driver-info">
                            <div class="driver-avatar">
                                <img src="https://via.placeholder.com/100" class="rounded-circle" alt="Driver">
                            </div>
                            <div class="driver-details">
                                <div class="detail-item">
                                    <i class="fas fa-id-card me-2"></i>
                                    <span>DRV-001</span>
                                </div>
                                <div class="detail-item">
                                    <i class="fas fa-bus me-2"></i>
                                    <span>B-101</span>
                                </div>
                                <div class="detail-item">
                                    <i class="fas fa-phone me-2"></i>
                                    <span>(555) 123-4567</span>
                                </div>
                                <div class="detail-item">
                                    <i class="fas fa-envelope me-2"></i>
                                    <span>david.miller@university.edu</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="card-footer">
                        <div class="d-flex justify-content-between">
                            <span class="badge bg-success">Active</span>
                            <div class="actions">
                                <button class="btn btn-sm btn-outline-primary">
                                    <i class="fas fa-edit"></i>
                                </button>
                                <button class="btn btn-sm btn-outline-danger">
                                    <i class="fas fa-trash"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="col-md-6 col-lg-4 mb-4">
                <div class="card driver-card">
                    <div class="card-header bg-primary text-white">
                        <h5 class="card-title mb-0">Lisa Wilson</h5>
                    </div>
                    <div class="card-body">
                        <div class="driver-info">
                            <div class="driver-avatar">
                                <img src="https://via.placeholder.com/100" class="rounded-circle" alt="Driver">
                            </div>
                            <div class="driver-details">
                                <div class="detail-item">
                                    <i class="fas fa-id-card me-2"></i>
                                    <span>DRV-002</span>
                                </div>
                                <div class="detail-item">
                                    <i class="fas fa-bus me-2"></i>
                                    <span>B-102</span>
                                </div>
                                <div class="detail-item">
                                    <i class="fas fa-phone me-2"></i>
                                    <span>(555) 234-5678</span>
                                </div>
                                <div class="detail-item">
                                    <i class="fas fa-envelope me-2"></i>
                                    <span>lisa.wilson@university.edu</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="card-footer">
                        <div class="d-flex justify-content-between">
                            <span class="badge bg-success">Active</span>
                            <div class="actions">
                                <button class="btn btn-sm btn-outline-primary">
                                    <i class="fas fa-edit"></i>
                                </button>
                                <button class="btn btn-sm btn-outline-danger">
                                    <i class="fas fa-trash"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="col-md-6 col-lg-4 mb-4">
                <div class="card driver-card">
                    <div class="card-header bg-primary text-white">
                        <h5 class="card-title mb-0">James Taylor</h5>
                    </div>
                    <div class="card-body">
                        <div class="driver-info">
                            <div class="driver-avatar">
                                <img src="https://placeholder.com/100" class="rounded-circle" alt="Driver">
                            </div>
                            <div class="driver-details">
                                <div class="detail-item">
                                    <i class="fas fa-id-card me-2"></i>
                                    <span>DRV-003</span>
                                </div>
                                <div class="detail-item">
                                    <i class="fas fa-bus me-2"></i>
                                    <span>B-103</span>
                                </div>
                                <div class="detail-item">
                                    <i class="fas fa-phone me-2"></i>
                                    <span>(555) 345-6789</span>
                                </div>
                                <div class="detail-item">
                                    <i class="fas fa-envelope me-2"></i>
                                    <span>james.taylor@university.edu</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="card-footer">
                        <div class="d-flex justify-content-between">
                            <span class="badge bg-warning">On Leave</span>
                            <div class="actions">
                                <button class="btn btn-sm btn-outline-primary">
                                    <i class="fas fa-edit"></i>
                                </button>
                                <button class="btn btn-sm btn-outline-danger">
                                    <i class="fas fa-trash"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="col-md-6 col-lg-4 mb-4">
                <div class="card driver-card">
                    <div class="card-header bg-primary text-white">
                        <h5 class="card-title mb-0">Mary Anderson</h5>
                    </div>
                    <div class="card-body">
                        <div class="driver-info">
                            <div class="driver-avatar">
                                <img src="https://via.placeholder.com/100" class="rounded-circle" alt="Driver">
                            </div>
                            <div class="driver-details">
                                <div class="detail-item">
                                    <i class="fas fa-id-card me-2"></i>
                                    <span>DRV-004</span>
                                </div>
                                <div class="detail-item">
                                    <i class="fas fa-bus me-2"></i>
                                    <span>B-104</span>
                                </div>
                                <div class="detail-item">
                                    <i class="fas fa-phone me-2"></i>
                                    <span>(555) 456-7890</span>
                                </div>
                                <div class="detail-item">
                                    <i class="fas fa-envelope me-2"></i>
                                    <span>mary.anderson@university.edu</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="card-footer">
                        <div class="d-flex justify-content-between">
                            <span class="badge bg-success">Active</span>
                            <div class="actions">
                                <button class="btn btn-sm btn-outline-primary">
                                    <i class="fas fa-edit"></i>
                                </button>
                                <button class="btn btn-sm btn-outline-danger">
                                    <i class="fas fa-trash"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="col-md-6 col-lg-4 mb-4">
                <div class="card driver-card">
                    <div class="card-header bg-primary text-white">
                        <h5 class="card-title mb-0">Daniel Thomas</h5>
                    </div>
                    <div class="card-body">
                        <div class="driver-info">
                            <div class="driver-avatar">
                                <img src="https://via.placeholder.com/100" class="rounded-circle" alt="Driver">
                            </div>
                            <div class="driver-details">
                                <div class="detail-item">
                                    <i class="fas fa-id-card me-2"></i>
                                    <span>DRV-005</span>
                                </div>
                                <div class="detail-item">
                                    <i class="fas fa-bus me-2"></i>
                                    <span>B-105</span>
                                </div>
                                <div class="detail-item">
                                    <i class="fas fa-phone me-2"></i>
                                    <span>(555) 567-8901</span>
                                </div>
                                <div class="detail-item">
                                    <i class="fas fa-envelope me-2"></i>
                                    <span>daniel.thomas@university.edu</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="card-footer">
                        <div class="d-flex justify-content-between">
                            <span class="badge bg-danger">Suspended</span>
                            <div class="actions">
                                <button class="btn btn-sm btn-outline-primary">
                                    <i class="fas fa-edit"></i>
                                </button>
                                <button class="btn btn-sm btn-outline-danger">
                                    <i class="fas fa-trash"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="col-md-6 col-lg-4 mb-4">
                <div class="card driver-card">
                    <div class="card-header bg-primary text-white">
                        <h5 class="card-title mb-0">Jennifer Jackson</h5>
                    </div>
                    <div class="card-body">
                        <div class="driver-info">
                            <div class="driver-avatar">
                                <img src="https://via.placeholder.com/100" class="rounded-circle" alt="Driver">
                            </div>
                            <div class="driver-details">
                                <div class="detail-item">
                                    <i class="fas fa-id-card me-2"></i>
                                    <span>DRV-006</span>
                                </div>
                                <div class="detail-item">
                                    <i class="fas fa-bus me-2"></i>
                                    <span>Not Assigned</span>
                                </div>
                                <div class="detail-item">
                                    <i class="fas fa-phone me-2"></i>
                                    <span>(555) 678-9012</span>
                                </div>
                                <div class="detail-item">
                                    <i class="fas fa-envelope me-2"></i>
                                    <span>jennifer.jackson@university.edu</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="card-footer">
                        <div class="d-flex justify-content-between">
                            <span class="badge bg-secondary">Inactive</span>
                            <div class="actions">
                                <button class="btn btn-sm btn-outline-primary">
                                    <i class="fas fa-edit"></i>
                                </button>
                                <button class="btn btn-sm btn-outline-danger">
                                    <i class="fas fa-trash"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Pagination -->
        <nav aria-label="Page navigation">
            <ul class="pagination justify-content-center">
                <li class="page-item disabled">
                    <a class="page-link" href="#" tabindex="-1" aria-disabled="true">Previous</a>
                </li>
                <li class="page-item active"><a class="page-link" href="#">1</a></li>
                <li class="page-item"><a class="page-link" href="#">2</a></li>
                <li class="page-item"><a class="page-link" href="#">3</a></li>
                <li class="page-item">
                    <a class="page-link" href="#">Next</a>
                </li>
            </ul>
        </nav>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="FooterScripts" runat="server">
    <script src="js/ManageDrivers.js"></script>
</asp:Content>
