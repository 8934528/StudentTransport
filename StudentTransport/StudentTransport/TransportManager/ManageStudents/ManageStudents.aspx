<%@ Page Title="" Language="C#" MasterPageFile="~/Shared/Site.Master" AutoEventWireup="true" CodeBehind="ManageStudents.aspx.cs" Inherits="StudentTransport.Shared.WebForm7" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <link href="css/ManageStudents.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="manage-students">
        <div class="header-section mb-4">
            <div class="d-flex justify-content-between align-items-center">
                <div>
                    <h1 class="display-5 fw-bold">Manage Students</h1>
                    <p class="lead">View and manage student information</p>
                </div>
                <div>
                    <button class="btn btn-primary">
                        <i class="fas fa-plus me-2"></i>Add New Student
                    </button>
                </div>
            </div>
        </div>
        
        <!-- Filters and Search -->
        <div class="card mb-4">
            <div class="card-body">
                <div class="row g-3">
                    <div class="col-md-3">
                        <label for="txtSearch" class="form-label">Search</label>
                        <div class="input-group">
                            <input type="text" class="form-control" placeholder="Search students...">
                            <button class="btn btn-outline-secondary" type="button">
                                <i class="fas fa-search"></i>
                            </button>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <label for="ddlCampus" class="form-label">Campus</label>
                        <select class="form-select" id="ddlCampus">
                            <option selected>All Campuses</option>
                            <option>Main Campus</option>
                            <option>Science Campus</option>
                            <option>Engineering Campus</option>
                        </select>
                    </div>
                    <div class="col-md-3">
                        <label for="ddlResidence" class="form-label">Residence</label>
                        <select class="form-select" id="ddlResidence">
                            <option selected>All Residences</option>
                            <option>Harmony Res</option>
                            <option>Garden Res</option>
                            <option>Mountain View</option>
                        </select>
                    </div>
                    <div class="col-md-3">
                        <label for="ddlStatus" class="form-label">Status</label>
                        <select class="form-select" id="ddlStatus">
                            <option selected>All Statuses</option>
                            <option>Active</option>
                            <option>Inactive</option>
                            <option>Suspended</option>
                        </select>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Students Table -->
        <div class="card">
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-hover align-middle">
                        <thead>
                            <tr>
                                <th>
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox">
                                    </div>
                                </th>
                                <th>Student ID</th>
                                <th>Name</th>
                                <th>Email</th>
                                <th>Campus</th>
                                <th>Residence</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox">
                                    </div>
                                </td>
                                <td>S1001</td>
                                <td>
                                    <div class="d-flex align-items-center">
                                        <div class="avatar me-3">
                                            <img src="https://via.placeholder.com/40" class="rounded-circle" alt="Avatar">
                                        </div>
                                        <div>Emma Wilson</div>
                                    </div>
                                </td>
                                <td>emma.wilson@university.edu</td>
                                <td>Main Campus</td>
                                <td>Harmony Res</td>
                                <td><span class="badge bg-success">Active</span></td>
                                <td>
                                    <div class="d-flex gap-2">
                                        <button class="btn btn-sm btn-outline-primary">
                                            <i class="fas fa-edit"></i>
                                        </button>
                                        <button class="btn btn-sm btn-outline-danger">
                                            <i class="fas fa-trash"></i>
                                        </button>
                                        <button class="btn btn-sm btn-outline-info">
                                            <i class="fas fa-eye"></i>
                                        </button>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox">
                                    </div>
                                </td>
                                <td>S1002</td>
                                <td>
                                    <div class="d-flex align-items-center">
                                        <div class="avatar me-3">
                                            <img src="https://via.placeholder.com/40" class="rounded-circle" alt="Avatar">
                                        </div>
                                        <div>Noah Harris</div>
                                    </div>
                                </td>
                                <td>noah.harris@university.edu</td>
                                <td>Science Campus</td>
                                <td>Garden Res</td>
                                <td><span class="badge bg-success">Active</span></td>
                                <td>
                                    <div class="d-flex gap-2">
                                        <button class="btn btn-sm btn-outline-primary">
                                            <i class="fas fa-edit"></i>
                                        </button>
                                        <button class="btn btn-sm btn-outline-danger">
                                            <i class="fas fa-trash"></i>
                                        </button>
                                        <button class="btn btn-sm btn-outline-info">
                                            <i class="fas fa-eye"></i>
                                        </button>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox">
                                    </div>
                                </td>
                                <td>S1003</td>
                                <td>
                                    <div class="d-flex align-items-center">
                                        <div class="avatar me-3">
                                            <img src="https://via.placeholder.com/40" class="rounded-circle" alt="Avatar">
                                        </div>
                                        <div>Olivia Martin</div>
                                    </div>
                                </td>
                                <td>olivia.martin@university.edu</td>
                                <td>Engineering Campus</td>
                                <td>Mountain View</td>
                                <td><span class="badge bg-secondary">Inactive</span></td>
                                <td>
                                    <div class="d-flex gap-2">
                                        <button class="btn btn-sm btn-outline-primary">
                                            <i class="fas fa-edit"></i>
                                        </button>
                                        <button class="btn btn-sm btn-outline-danger">
                                            <i class="fas fa-trash"></i>
                                        </button>
                                        <button class="btn btn-sm btn-outline-info">
                                            <i class="fas fa-eye"></i>
                                        </button>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox">
                                    </div>
                                </td>
                                <td>S1004</td>
                                <td>
                                    <div class="d-flex align-items-center">
                                        <div class="avatar me-3">
                                            <img src="https://via.placeholder.com/40" class="rounded-circle" alt="Avatar">
                                        </div>
                                        <div>Liam Thompson</div>
                                    </div>
                                </td>
                                <td>liam.thompson@university.edu</td>
                                <td>Main Campus</td>
                                <td>Harmony Res</td>
                                <td><span class="badge bg-success">Active</span></td>
                                <td>
                                    <div class="d-flex gap-2">
                                        <button class="btn btn-sm btn-outline-primary">
                                            <i class="fas fa-edit"></i>
                                        </button>
                                        <button class="btn btn-sm btn-outline-danger">
                                            <i class="fas fa-trash"></i>
                                        </button>
                                        <button class="btn btn-sm btn-outline-info">
                                            <i class="fas fa-eye"></i>
                                        </button>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox">
                                    </div>
                                </td>
                                <td>S1005</td>
                                <td>
                                    <div class="d-flex align-items-center">
                                        <div class="avatar me-3">
                                            <img src="https://via.placeholder.com/40" class="rounded-circle" alt="Avatar">
                                        </div>
                                        <div>Ava Garcia</div>
                                    </div>
                                </td>
                                <td>ava.garcia@university.edu</td>
                                <td>Science Campus</td>
                                <td>Garden Res</td>
                                <td><span class="badge bg-warning">Suspended</span></td>
                                <td>
                                    <div class="d-flex gap-2">
                                        <button class="btn btn-sm btn-outline-primary">
                                            <i class="fas fa-edit"></i>
                                        </button>
                                        <button class="btn btn-sm btn-outline-danger">
                                            <i class="fas fa-trash"></i>
                                        </button>
                                        <button class="btn btn-sm btn-outline-info">
                                            <i class="fas fa-eye"></i>
                                        </button>
                                    </div>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                
                <!-- Pagination -->
                <nav aria-label="Page navigation">
                    <ul class="pagination justify-content-end">
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
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="FooterScripts" runat="server">
    <script src="js/ManageStudents.js"></script>
</asp:Content>
