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
                    <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addDriverModal">
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
                            <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" 
                                placeholder="Search drivers..." AutoPostBack="true" 
                                OnTextChanged="txtSearch_TextChanged"></asp:TextBox>
                            <asp:Button ID="btnSearch" runat="server" CssClass="btn btn-outline-secondary" 
                                Text="Search" OnClick="btnSearch_Click" />
                        </div>
                    </div>
                    <div class="col-md-4">
                        <label for="ddlStatus" class="form-label">Status</label>
                        <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-select" AutoPostBack="true"
                            OnSelectedIndexChanged="ddlStatus_SelectedIndexChanged">
                            <asp:ListItem Text="All Statuses" Value="All" Selected="True" />
                            <asp:ListItem Text="Active" Value="Active" />
                            <asp:ListItem Text="Inactive" Value="Inactive" />
                        </asp:DropDownList>
                    </div>
                    <div class="col-md-4">
                        <label for="ddlBus" class="form-label">Assigned Bus</label>
                        <asp:DropDownList ID="ddlBus" runat="server" CssClass="form-select" AutoPostBack="true"
                            OnSelectedIndexChanged="ddlBus_SelectedIndexChanged">
                            <asp:ListItem Text="All Buses" Value="All" Selected="True" />
                        </asp:DropDownList>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Drivers List -->
        <div class="row">
            <asp:Repeater ID="rptDrivers" runat="server" OnItemCommand="rptDrivers_ItemCommand">
                <ItemTemplate>
                    <div class="col-md-6 col-lg-4 mb-4">
                        <div class="card driver-card">
                            <div class="card-header bg-primary text-white">
                                <h5 class="card-title mb-0"><%# Eval("FullName") %></h5>
                            </div>
                            <div class="card-body">
                                <div class="driver-info">
                                    <div class="driver-avatar">
                                        <img src="https://ui-avatars.com/api/?name=<%# Eval("FullName") %>&background=random" 
                                            class="rounded-circle" alt="Driver">
                                    </div>
                                    <div class="driver-details">
                                        <div class="detail-item">
                                            <i class="fas fa-id-card me-2"></i>
                                            <span><%# Eval("LicenseNumber") %></span>
                                        </div>
                                        <div class="detail-item">
                                            <i class="fas fa-bus me-2"></i>
                                            <span><%# Eval("BusNumber") != DBNull.Value ? Eval("BusNumber") : "Not Assigned" %></span>
                                        </div>
                                        <div class="detail-item">
                                            <i class="fas fa-phone me-2"></i>
                                            <span><%# Eval("PhoneNumber") %></span>
                                        </div>
                                        <div class="detail-item">
                                            <i class="fas fa-envelope me-2"></i>
                                            <span><%# Eval("Email") %></span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="card-footer">
                                <div class="d-flex justify-content-between">
                                    <span class='badge <%# Eval("StatusClass") %>'><%# Eval("Status") %></span>
                                    <div class="actions">
                                        <asp:LinkButton ID="btnEdit" runat="server" CssClass="btn btn-sm btn-outline-primary"
                                            CommandName="Edit" CommandArgument='<%# Eval("UserID") %>'>
                                            <i class="fas fa-edit"></i>
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="btnDelete" runat="server" CssClass="btn btn-sm btn-outline-danger"
                                            CommandName="Delete" CommandArgument='<%# Eval("UserID") %>'
                                            OnClientClick="return confirm('Are you sure you want to delete this driver?');">
                                            <i class="fas fa-trash"></i>
                                        </asp:LinkButton>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
            
            <!-- No Drivers Found Message -->
            <asp:Panel ID="pnlNoDrivers" runat="server" CssClass="col-12 text-center py-5" Visible="false">
                <div class="alert alert-info">
                    <i class="fas fa-info-circle me-2"></i>
                    No drivers found matching your criteria
                </div>
            </asp:Panel>
        </div>
        
        <!-- Pagination -->
        <div class="d-flex justify-content-center mt-4">
            <asp:DataPager ID="dpDrivers" runat="server" PagedControlID="rptDrivers" PageSize="6" 
                QueryStringField="page" OnPreRender="dpDrivers_PreRender">
                <Fields>
                    <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="true" 
                        ShowLastPageButton="true" FirstPageText="<<" PreviousPageText="<" 
                        NextPageText=">" LastPageText=">>" ButtonCssClass="btn btn-outline-primary mx-1" />
                    <asp:NumericPagerField ButtonType="Button" NumericButtonCssClass="btn btn-outline-primary mx-1" 
                        CurrentPageLabelCssClass="btn btn-primary mx-1" />
                </Fields>
            </asp:DataPager>
        </div>
    </div>
    
    <!-- Add Driver Modal -->
    <div class="modal fade" id="addDriverModal" tabindex="-1" aria-labelledby="addDriverModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="addDriverModalLabel">Add New Driver</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <label for="txtFirstName" class="form-label">First Name</label>
                        <asp:TextBox ID="txtFirstName" runat="server" CssClass="form-control" required="required"></asp:TextBox>
                    </div>
                    <div class="mb-3">
                        <label for="txtLastName" class="form-label">Last Name</label>
                        <asp:TextBox ID="txtLastName" runat="server" CssClass="form-control" required="required"></asp:TextBox>
                    </div>
                    <div class="mb-3">
                        <label for="txtEmail" class="form-label">Email</label>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" 
                            TextMode="Email" required="required"></asp:TextBox>
                    </div>
                    <div class="mb-3">
                        <label for="txtPassword" class="form-label">Password</label>
                        <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" 
                            TextMode="Password" required="required"></asp:TextBox>
                    </div>
                    <div class="mb-3">
                        <label for="txtLicense" class="form-label">License Number</label>
                        <asp:TextBox ID="txtLicense" runat="server" CssClass="form-control" required="required"></asp:TextBox>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <asp:Button ID="btnAddDriver" runat="server" Text="Add Driver" 
                        CssClass="btn btn-primary" OnClick="btnAddDriver_Click" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="FooterScripts" runat="server">
    <script src="js/ManageDrivers.js"></script>
</asp:Content>
