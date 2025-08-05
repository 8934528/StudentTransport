document.addEventListener('DOMContentLoaded', function () {

    initFilters();
    initPagination();
    initModalValidation();

    const tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
    tooltipTriggerList.map(function (tooltipTriggerEl) {
        return new bootstrap.Tooltip(tooltipTriggerEl);
    });
});

// Filter functionality
function initFilters() {
    const searchInput = document.querySelector('.input-group input');
    const searchButton = document.querySelector('.input-group button');
    const campusFilter = document.getElementById('<%= ddlCampus.ClientID %>');
    const residenceFilter = document.getElementById('<%= ddlResidence.ClientID %>');

    if (searchButton) {
        searchButton.addEventListener('click', filterStudents);
    }

    if (searchInput) {
        searchInput.addEventListener('keyup', function (e) {
            if (e.key === 'Enter') {
                filterStudents();
            }
        });
    }

    // Filter change 
    if (campusFilter) {
        campusFilter.addEventListener('change', filterStudents);
    }

    if (residenceFilter) {
        residenceFilter.addEventListener('change', filterStudents);
    }
}

// Initialize pagination
function initPagination() {
    const paginationLinks = document.querySelectorAll('.pagination .page-link');

    paginationLinks.forEach(link => {
        link.addEventListener('click', function (e) {
            e.preventDefault();
            if (this.parentElement.classList.contains('disabled')) return;

            paginationLinks.forEach(l => {
                l.parentElement.classList.remove('active');
            });

            if (!this.textContent.includes('Previous') && !this.textContent.includes('Next')) {
                this.parentElement.classList.add('active');
            }

            showNotification(`Loading page ${this.textContent}...`, 'info');
        });
    });
}

// Initialize modal form validation
function initModalValidation() {
    const addStudentForm = document.querySelector('#addStudentModal form');
    if (addStudentForm) {
        addStudentForm.addEventListener('submit', function (e) {
            let isValid = true;
            const requiredFields = this.querySelectorAll('[required]');

            requiredFields.forEach(field => {
                if (!field.value.trim()) {
                    isValid = false;
                    field.classList.add('is-invalid');
                } else {
                    field.classList.remove('is-invalid');
                }
            });

            if (!isValid) {
                e.preventDefault();
                showNotification('Please fill in all required fields', 'danger');
            }
        });
    }
}

// Filter students based on search and filter criteria
function filterStudents() {
    const searchInput = document.querySelector('.input-group input');
    const campusFilter = document.getElementById('<%= ddlCampus.ClientID %>');
    const residenceFilter = document.getElementById('<%= ddlResidence.ClientID %>');

    const searchTerm = searchInput ? searchInput.value.toLowerCase() : '';
    const campusValue = campusFilter ? campusFilter.value : 'All';
    const residenceValue = residenceFilter ? residenceFilter.value : 'All';

    const rows = document.querySelectorAll('tbody tr');
    let visibleCount = 0;

    rows.forEach(row => {
        const name = row.querySelector('td:nth-child(2) div:last-child').textContent.toLowerCase();
        const email = row.querySelector('td:nth-child(3)').textContent.toLowerCase();
        const campus = row.querySelector('td:nth-child(4)').textContent;
        const residence = row.querySelector('td:nth-child(5)').textContent;
        const status = row.querySelector('.badge').textContent;

        const matchesSearch = name.includes(searchTerm) || email.includes(searchTerm);
        const matchesCampus = campusValue === 'All Campuses' || campus === campusValue;
        const matchesResidence = residenceValue === 'All Residences' || residence === residenceValue;

        if (matchesSearch && matchesCampus && matchesResidence) {
            row.style.display = '';
            visibleCount++;
        } else {
            row.style.display = 'none';
        }
    });

    // Show/hide no results
    const noResults = document.getElementById('<%= pnlNoStudents.ClientID %>');
    if (noResults) {
        noResults.style.display = visibleCount === 0 ? 'block' : 'none';
    }

    showNotification(`Found ${visibleCount} students matching your criteria`, 'info');
}

// Show notification
function showNotification(message, type = 'success') {

    const existingAlerts = document.querySelectorAll('.custom-notification');
    existingAlerts.forEach(alert => alert.remove());

    const notification = document.createElement('div');
    notification.className = `custom-notification alert alert-${type} position-fixed top-0 start-50 translate-middle-x mt-3`;
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

// Handle modal form submission
document.getElementById('<%= btnAddStudent.ClientID %>').addEventListener('click', function () {
    const form = document.querySelector('#addStudentModal form');
    let isValid = true;

    form.querySelectorAll('[required]').forEach(field => {
        if (!field.value.trim()) {
            isValid = false;
            field.classList.add('is-invalid');
        }
    });

    if (!isValid) {
        showNotification('Please fill in all required fields', 'danger');
    }
});