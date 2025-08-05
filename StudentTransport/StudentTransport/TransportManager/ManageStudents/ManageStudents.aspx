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
                    <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addStudentModal">
                        <i class="fas fa-plus me-2"></i>Add New Student
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
                                placeholder="Search students..." AutoPostBack="true"
                                OnTextChanged="txtSearch_TextChanged"></asp:TextBox>
                            <asp:Button ID="btnSearch" runat="server" CssClass="btn btn-outline-secondary"
                                Text="Search" OnClick="btnSearch_Click" />
                        </div>
                    </div>
                    <div class="col-md-4">
                        <label for="ddlCampus" class="form-label">Campus</label>
                        <asp:DropDownList ID="ddlCampus" runat="server" CssClass="form-select" AutoPostBack="true"
                            OnSelectedIndexChanged="ddlCampus_SelectedIndexChanged">
                            <asp:ListItem Text="All Campuses" Value="All" Selected="True" />
                            <asp:ListItem Text="Main Campus" Value="Main Campus" />
                            <asp:ListItem Text="Science Campus" Value="Science Campus" />
                            <asp:ListItem Text="Engineering Campus" Value="Engineering Campus" />
                        </asp:DropDownList>
                    </div>
                    <div class="col-md-4">
                        <label for="ddlResidence" class="form-label">Residence</label>
                        <asp:DropDownList ID="ddlResidence" runat="server" CssClass="form-select" AutoPostBack="true"
                            OnSelectedIndexChanged="ddlResidence_SelectedIndexChanged">
                            <asp:ListItem Text="All Residences" Value="All" Selected="True" />
                            <asp:ListItem Text="Harmony Res" Value="Harmony Res" />
                            <asp:ListItem Text="Garden Res" Value="Garden Res" />
                            <asp:ListItem Text="Mountain View" Value="Mountain View" />
                        </asp:DropDownList>
                    </div>
                </div>
            </div>
        </div>

        <!-- Students Table -->
        <div class="card">
            <div class="card-body">
                <div class="table-responsive">
                    <asp:Repeater ID="rptStudents" runat="server" OnItemCommand="rptStudents_ItemCommand">
                        <HeaderTemplate>
                            <table class="table table-hover align-middle">
                                <thead>
                                    <tr>
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
                        </HeaderTemplate>
                        <ItemTemplate>
                            <tr>
                                <td><%# Eval("StudentID") %></td>
                                <td>
                                    <div class="d-flex align-items-center">
                                        <div class="avatar me-3">
                                            <img src="https://ui-avatars.com/api/?name=<%# Eval("FullName") %>&background=random"
                                                class="rounded-circle" alt="Avatar">
                                        </div>
                                        <div><%# Eval("FullName") %></div>
                                    </div>
                                </td>
                                <td><%# Eval("Email") %></td>
                                <td><%# Eval("CampusLocation") %></td>
                                <td><%# Eval("Residence") %></td>
                                <td><span class='badge <%# Eval("StatusClass") %>'><%# Eval("Status") %></span></td>
                                <td>
                                    <div class="d-flex gap-2">
                                        <asp:LinkButton ID="btnEdit" runat="server" CssClass="btn btn-sm btn-outline-primary"
                                            CommandName="Edit" CommandArgument='<%# Eval("UserID") %>'>
                                            <i class="fas fa-edit"></i>
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="btnDelete" runat="server" CssClass="btn btn-sm btn-outline-danger"
                                            CommandName="Delete" CommandArgument='<%# Eval("UserID") %>'
                                            OnClientClick="return confirm('Are you sure you want to delete this student?');">
                                            <i class="fas fa-trash"></i>
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="btnView" runat="server" CssClass="btn btn-sm btn-outline-info"
                                            CommandName="View" CommandArgument='<%# Eval("UserID") %>'>
                                            <i class="fas fa-eye"></i>
                                        </asp:LinkButton>
                                    </div>
                                </td>
                            </tr>
                        </ItemTemplate>
                        <FooterTemplate>
                            </tbody>
                            </table>
                        </FooterTemplate>
                    </asp:Repeater>

                    <!-- No Students Found Message -->
                    <asp:Panel ID="pnlNoStudents" runat="server" CssClass="alert alert-info text-center py-4" Visible="false">
                        <i class="fas fa-info-circle me-2"></i>
                        No students found matching your criteria
                    </asp:Panel>
                </div>

                <!-- Pagination -->
                <div class="d-flex justify-content-center mt-4">
                    <asp:DataPager ID="dpStudents" runat="server" PagedControlID="rptStudents" PageSize="10"
                        QueryStringField="page" OnPreRender="dpStudents_PreRender">
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
        </div>
    </div>

    <!-- Add Student Modal -->
    <div class="modal fade" id="addStudentModal" tabindex="-1" aria-labelledby="addStudentModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="addStudentModalLabel">Add New Student</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <label for="txtStFirstName" class="form-label">First Name</label>
                        <asp:TextBox ID="txtStFirstName" runat="server" CssClass="form-control" required></asp:TextBox>
                    </div>
                    <div class="mb-3">
                        <label for="txtStLastName" class="form-label">Last Name</label>
                        <asp:TextBox ID="txtStLastName" runat="server" CssClass="form-control" required></asp:TextBox>
                    </div>
                    <div class="mb-3">
                        <label for="txtStEmail" class="form-label">Email</label>
                        <asp:TextBox ID="txtStEmail" runat="server" CssClass="form-control"
                            TextMode="Email" required></asp:TextBox>
                    </div>
                    <div class="mb-3">
                        <label for="txtStPassword" class="form-label">Password</label>
                        <asp:TextBox ID="txtStPassword" runat="server" CssClass="form-control"
                            TextMode="Password" required></asp:TextBox>
                    </div>
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="ddlCampusAdd" class="form-label">Campus</label>
                            <asp:DropDownList ID="ddlCampusAdd" runat="server" CssClass="form-select" required>
                                <asp:ListItem Text="Main Campus" Value="Main Campus" />
                                <asp:ListItem Text="Science Campus" Value="Science Campus" />
                                <asp:ListItem Text="Engineering Campus" Value="Engineering Campus" />
                            </asp:DropDownList>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="ddlResidenceAdd" class="form-label">Residence</label>
                            <asp:DropDownList ID="ddlResidenceAdd" runat="server" CssClass="form-select" required>
                                <asp:ListItem Text="Harmony Res" Value="Harmony Res" />
                                <asp:ListItem Text="Garden Res" Value="Garden Res" />
                                <asp:ListItem Text="Mountain View" Value="Mountain View" />
                            </asp:DropDownList>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <asp:Button ID="btnAddStudent" runat="server" Text="Add Student"
                        CssClass="btn btn-primary" OnClick="btnAddStudent_Click" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FooterScripts" runat="server">
    <script src="js/ManageStudents.js"></script>
</asp:Content>
