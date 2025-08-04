document.addEventListener('DOMContentLoaded', function () {
    // Initialize components
    initDriverCards();
    initPagination();
    initFilters();

    // Initialize tooltips
    const tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
    tooltipTriggerList.map(function (tooltipTriggerEl) {
        return new bootstrap.Tooltip(tooltipTriggerEl);
    });
});

// Initialize driver card functionality
function initDriverCards() {
    const driverCards = document.querySelectorAll('.driver-card');

    driverCards.forEach(card => {
        const editBtn = card.querySelector('.btn-outline-primary');
        const deleteBtn = card.querySelector('.btn-outline-danger');
        const driverName = card.querySelector('.card-title').textContent;

        // Edit button functionality
        if (editBtn) {
            editBtn.addEventListener('click', function (e) {
                e.stopPropagation();
                alert(`Editing driver: ${driverName}`);
            });
        }

        // Delete button functionality
        if (deleteBtn) {
            deleteBtn.addEventListener('click', function (e) {
                e.stopPropagation();
                if (confirm(`Are you sure you want to delete ${driverName}?`)) {
                    card.style.opacity = '0.5';
                    card.style.transform = 'scale(0.98)';
                    setTimeout(() => {
                        card.remove();
                        showNotification(`${driverName} has been deleted`, 'success');
                    }, 500);
                }
            });
        }

        // Card click functionality (view details)
        card.addEventListener('click', function (e) {
            // Don't trigger if clicking on action buttons
            if (!e.target.closest('.actions')) {
                const driverId = card.querySelector('.detail-item:first-child span').textContent;
                alert(`Viewing details for driver: ${driverName} (ID: ${driverId})`);
            }
        });
    });
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

// Initialize filter functionality
function initFilters() {
    const searchInput = document.querySelector('.input-group input');
    const searchButton = document.querySelector('.input-group button');
    const statusFilter = document.getElementById('ddlStatus');
    const busFilter = document.getElementById('ddlBus');

    // Search button handler
    if (searchButton) {
        searchButton.addEventListener('click', filterDrivers);
    }

    // Search input handler (on Enter key)
    if (searchInput) {
        searchInput.addEventListener('keyup', function (e) {
            if (e.key === 'Enter') {
                filterDrivers();
            }
        });
    }

    // Filter change handlers
    [statusFilter, busFilter].forEach(filter => {
        if (filter) {
            filter.addEventListener('change', filterDrivers);
        }
    });
}

// Filter drivers based on search and filter criteria
function filterDrivers() {
    const searchInput = document.querySelector('.input-group input');
    const statusFilter = document.getElementById('ddlStatus');
    const busFilter = document.getElementById('ddlBus');

    const searchTerm = searchInput.value.toLowerCase();
    const statusValue = statusFilter.value;
    const busValue = busFilter.value;

    const cards = document.querySelectorAll('.driver-card');
    let visibleCount = 0;

    cards.forEach(card => {
        const name = card.querySelector('.card-title').textContent.toLowerCase();
        const driverId = card.querySelector('.detail-item:first-child span').textContent.toLowerCase();
        const email = card.querySelector('.detail-item:last-child span').textContent.toLowerCase();
        const bus = card.querySelector('.detail-item:nth-child(2) span').textContent;
        const status = card.querySelector('.badge').textContent;

        const matchesSearch = name.includes(searchTerm) ||
            driverId.includes(searchTerm) ||
            email.includes(searchTerm);
        const matchesStatus = statusValue === 'All Statuses' || status === statusValue;
        const matchesBus = busValue === 'All Buses' || bus === busValue;

        if (matchesSearch && matchesStatus && matchesBus) {
            card.style.display = '';
            visibleCount++;
        } else {
            card.style.display = 'none';
        }
    });

    showNotification(`Found ${visibleCount} drivers matching your criteria`, 'info');
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

// Add new driver functionality
document.querySelector('.btn-primary').addEventListener('click', function () {
    // In a real app, this would open a modal or redirect to an add driver page
    alert('Opening add new driver form...');
});