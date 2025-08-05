document.addEventListener('DOMContentLoaded', function () {
    // Status selection functionality
    const statusOptions = document.querySelectorAll('.status-option');
    const updateButton = document.getElementById('btnUpdateStatus');
    const selectedStatusInput = document.getElementById('selectedStatus');
    let selectedStatus = '';

    statusOptions.forEach(option => {
        option.addEventListener('click', function () {
            // Remove active class from all options
            statusOptions.forEach(opt => {
                opt.classList.remove('active');
            });

            // Add active class to clicked option
            this.classList.add('active');

            // Update selected status
            selectedStatus = this.dataset.status;
            selectedStatusInput.value = selectedStatus;

            // Enable update button
            updateButton.disabled = false;

            // Update status indicator in current status section
            const indicator = document.querySelector('.current-status .status-indicator');
            const statusText = document.querySelector('.current-status h3');

            // Remove all color classes
            indicator.classList.remove('bg-success', 'bg-secondary', 'bg-warning', 'bg-danger');

            // Add appropriate class based on status
            switch (selectedStatus) {
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
            }
        });
    });

    // Fuel level animation
    const fuelProgress = document.querySelector('.progress-bar');
    let fuelLevel = 75;

    setInterval(() => {
        // Simulate fuel consumption
        fuelLevel -= 0.1;
        if (fuelLevel < 0) fuelLevel = 100;

        // Update progress bar
        fuelProgress.style.width = `${fuelLevel}%`;
        fuelProgress.textContent = `${Math.round(fuelLevel)}%`;

        // Change color based on level
        if (fuelLevel > 50) {
            fuelProgress.classList.remove('bg-warning', 'bg-danger');
            fuelProgress.classList.add('bg-success');
        } else if (fuelLevel > 20) {
            fuelProgress.classList.remove('bg-success', 'bg-danger');
            fuelProgress.classList.add('bg-warning');
        } else {
            fuelProgress.classList.remove('bg-success', 'bg-warning');
            fuelProgress.classList.add('bg-danger');
        }
    }, 5000);
});

// Update status function called from button click
function updateStatus() {
    const btn = document.getElementById('btnUpdateStatus');

    // Show loading state
    btn.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Updating...';
    btn.disabled = true;

    // Get the selected status
    const status = document.getElementById('selectedStatus').value;

    // Submit the form to update status
    __doPostBack('', status);
}

// Show notification function
function showNotification(message, type = 'success') {
    // Remove any existing notifications
    const existingAlerts = document.querySelectorAll('.custom-notification');
    existingAlerts.forEach(alert => alert.remove());

    // Create notification element
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