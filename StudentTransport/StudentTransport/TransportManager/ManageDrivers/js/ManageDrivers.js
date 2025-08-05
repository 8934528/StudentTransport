document.addEventListener('DOMContentLoaded', function () {

    initPagination();
    initFilters();
    initModalValidation();

    // Initialize tooltips
    const tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
    tooltipTriggerList.map(function (tooltipTriggerEl) {
        return new bootstrap.Tooltip(tooltipTriggerEl);
    });
});

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

// Initialize filter functionality
function initFilters() {
    const searchInput = document.querySelector('.input-group input');
    const searchButton = document.querySelector('.input-group button');
    const statusFilter = document.getElementById('<%= ddlStatus.ClientID %>');
    const busFilter = document.getElementById('<%= ddlBus.ClientID %>');
     
    if (searchButton) {
        searchButton.addEventListener('click', filterDrivers);
    }
     
    if (searchInput) {
        searchInput.addEventListener('keyup', function (e) {
            if (e.key === 'Enter') {
                filterDrivers();
            }
        });
    }
     
    if (statusFilter) {
        statusFilter.addEventListener('change', filterDrivers);
    }

    if (busFilter) {
        busFilter.addEventListener('change', filterDrivers);
    }
}

// Initialize modal form  
function initModalValidation() {
    const addDriverForm = document.querySelector('#addDriverModal form');
    if (addDriverForm) {
        addDriverForm.addEventListener('submit', function (e) {
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

// Filter drivers based on search and filter criteria
function filterDrivers() {
    const searchInput = document.querySelector('.input-group input');
    const statusFilter = document.getElementById('<%= ddlStatus.ClientID %>');
    const busFilter = document.getElementById('<%= ddlBus.ClientID %>');

    const searchTerm = searchInput ? searchInput.value.toLowerCase() : '';
    const statusValue = statusFilter ? statusFilter.value : 'All';
    const busValue = busFilter ? busFilter.value : 'All';

    const cards = document.querySelectorAll('.driver-card');
    let visibleCount = 0;

    cards.forEach(card => {
        const name = card.querySelector('.card-title').textContent.toLowerCase();
        const license = card.querySelector('.detail-item:first-child span').textContent.toLowerCase();
        const bus = card.querySelector('.detail-item:nth-child(2) span').textContent;
        const email = card.querySelector('.detail-item:last-child span').textContent.toLowerCase();
        const status = card.querySelector('.badge').textContent;

        const matchesSearch = name.includes(searchTerm) ||
            license.includes(searchTerm) ||
            email.includes(searchTerm);
        const matchesStatus = statusValue === 'All' || status === statusValue;
        const matchesBus = busValue === 'All' || bus === busValue;

        if (matchesSearch && matchesStatus && matchesBus) {
            card.style.display = '';
            visibleCount++;
        } else {
            card.style.display = 'none';
        }
    });

    // Show/hide no results 
    const noResults = document.getElementById('<%= pnlNoDrivers.ClientID %>');
    if (noResults) {
        noResults.style.display = visibleCount === 0 ? 'block' : 'none';
    }

    showNotification(`Found ${visibleCount} drivers matching your criteria`, 'info');
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
     
    document.body.appendChild(notification);

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

document.getElementById('<%= btnAddDriver.ClientID %>').addEventListener('click', function () {
    const form = document.querySelector('#addDriverModal form');
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