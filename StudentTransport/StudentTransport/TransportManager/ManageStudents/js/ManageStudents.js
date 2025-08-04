document.addEventListener('DOMContentLoaded', function () {
    // Initialize components
    initCheckboxes();
    initActionButtons();
    initFilters();
    initPagination();

    // Initialize tooltips
    const tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
    tooltipTriggerList.map(function (tooltipTriggerEl) {
        return new bootstrap.Tooltip(tooltipTriggerEl);
    });
});

// Initialize checkbox functionality
function initCheckboxes() {
    const selectAllCheckbox = document.querySelector('thead .form-check-input');
    const rowCheckboxes = document.querySelectorAll('tbody .form-check-input');

    // Select all functionality
    if (selectAllCheckbox) {
        selectAllCheckbox.addEventListener('change', function () {
            const isChecked = this.checked;
            rowCheckboxes.forEach(checkbox => {
                checkbox.checked = isChecked;
            });
        });
    }

    // Individual row checkbox functionality
    rowCheckboxes.forEach(checkbox => {
        checkbox.addEventListener('change', function () {
            if (!this.checked && selectAllCheckbox.checked) {
                selectAllCheckbox.checked = false;
            }
        });
    });
}

// Initialize action buttons (view, edit, delete)
function initActionButtons() {
    const actionButtons = document.querySelectorAll('.actions button');

    actionButtons.forEach(button => {
        button.addEventListener('click', function () {
            const action = this.querySelector('i').className;
            const row = this.closest('tr');
            const studentId = row.querySelector('td:nth-child(2)').textContent;
            const studentName = row.querySelector('td:nth-child(3) div:last-child').textContent;

            if (action.includes('fa-eye')) {
                // View action
                alert(`View student: ${studentName} (ID: ${studentId})`);
            } else if (action.includes('fa-edit')) {
                // Edit action
                alert(`Edit student: ${studentName} (ID: ${studentId})`);
            } else if (action.includes('fa-trash')) {
                // Delete action
                if (confirm(`Are you sure you want to delete ${studentName}?`)) {
                    row.style.opacity = '0.5';
                    row.style.backgroundColor = '#ffecec';
                    setTimeout(() => {
                        row.remove();
                        showNotification(`${studentName} has been deleted`, 'success');
                    }, 500);
                }
            }
        });
    });
}

// Initialize filter functionality
function initFilters() {
    const searchInput = document.querySelector('.input-group input');
    const searchButton = document.querySelector('.input-group button');
    const campusFilter = document.getElementById('ddlCampus');
    const residenceFilter = document.getElementById('ddlResidence');
    const statusFilter = document.getElementById('ddlStatus');

    // Search button handler
    if (searchButton) {
        searchButton.addEventListener('click', filterStudents);
    }

    // Search input handler (on Enter key)
    if (searchInput) {
        searchInput.addEventListener('keyup', function (e) {
            if (e.key === 'Enter') {
                filterStudents();
            }
        });
    }

    // Filter change handlers
    [campusFilter, residenceFilter, statusFilter].forEach(filter => {
        if (filter) {
            filter.addEventListener('change', filterStudents);
        }
    });
}

// Filter students based on search and filter criteria
function filterStudents() {
    const searchInput = document.querySelector('.input-group input');
    const campusFilter = document.getElementById('ddlCampus');
    const residenceFilter = document.getElementById('ddlResidence');
    const statusFilter = document.getElementById('ddlStatus');

    const searchTerm = searchInput.value.toLowerCase();
    const campusValue = campusFilter.value;
    const residenceValue = residenceFilter.value;
    const statusValue = statusFilter.value;

    const rows = document.querySelectorAll('tbody tr');
    let visibleCount = 0;

    rows.forEach(row => {
        const name = row.querySelector('td:nth-child(3) div:last-child').textContent.toLowerCase();
        const email = row.querySelector('td:nth-child(4)').textContent.toLowerCase();
        const campus = row.querySelector('td:nth-child(5)').textContent;
        const residence = row.querySelector('td:nth-child(6)').textContent;
        const status = row.querySelector('td:nth-child(7) .badge').textContent;

        const matchesSearch = name.includes(searchTerm) || email.includes(searchTerm);
        const matchesCampus = campusValue === 'All Campuses' || campus === campusValue;
        const matchesResidence = residenceValue === 'All Residences' || residence === residenceValue;
        const matchesStatus = statusValue === 'All Statuses' || status === statusValue;

        if (matchesSearch && matchesCampus && matchesResidence && matchesStatus) {
            row.style.display = '';
            visibleCount++;
        } else {
            row.style.display = 'none';
        }
    });

    showNotification(`Found ${visibleCount} students matching your criteria`, 'info');
}

// Initialize pagination
function initPagination() {
    const paginationLinks = document.querySelectorAll('.pagination .page-link');

    paginationLinks.forEach(link => {
        link.addEventListener('click', function (e) {
            e.preventDefault();
            if (this.parentElement.classList.contains('disabled')) return;

            // Remove active class from all items
            paginationLinks.forEach(l => {
                l.parentElement.classList.remove('active');
            });

            // Add active class to clicked item
            if (!this.textContent.includes('Previous') && !this.textContent.includes('Next')) {
                this.parentElement.classList.add('active');
            }

            // Simulate page change
            showNotification(`Loading page ${this.textContent}...`, 'info');
        });
    });
}

// Show notification
function showNotification(message, type = 'success') {
    // Create notification element
    const notification = document.createElement('div');
    notification.className = `alert alert-${type} position-fixed top-0 start-50 translate-middle-x mt-3`;
    notification.style.zIndex = '1060';
    notification.style.opacity = '0';
    notification.style.transition = 'opacity 0.5s, transform 0.5s';
    notification.style.transform = 'translateY(-20px)';
    notification.innerHTML = `
        <div class="d-flex justify-content-between align-items-center">
            <span>${message}</span>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    `;

    // Add to document
    document.body.appendChild(notification);

    // Show notification
    setTimeout(() => {
        notification.style.opacity = '1';
        notification.style.transform = 'translateY(0)';
    }, 10);

    // Auto-remove after 3 seconds
    setTimeout(() => {
        notification.style.opacity = '0';
        setTimeout(() => {
            notification.remove();
        }, 500);
    }, 3000);

    // Close button functionality
    const closeButton = notification.querySelector('.btn-close');
    if (closeButton) {
        closeButton.addEventListener('click', function () {
            notification.style.opacity = '0';
            setTimeout(() => {
                notification.remove();
            }, 500);
        });
    }
}

// Add new student functionality
document.querySelector('.btn-primary').addEventListener('click', function () {
    // In a real app, this would open a modal or redirect to an add student page
    alert('Opening add new student form...');
});