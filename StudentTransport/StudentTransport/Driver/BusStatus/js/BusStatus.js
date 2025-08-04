document.addEventListener('DOMContentLoaded', function () {
    // Status selection functionality
    const statusOptions = document.querySelectorAll('.status-option');
    const updateButton = document.getElementById('btnUpdateStatus');
    let selectedStatus = 'active';

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

            // Enable update button
            updateButton.disabled = false;

            // Update status indicator in current status section
            const indicator = document.querySelector('.current-status .status-indicator');
            const statusText = document.querySelector('.current-status h3');

            // Remove all color classes
            indicator.classList.remove('bg-success', 'bg-secondary', 'bg-warning', 'bg-danger');

            // Add appropriate class based on status
            switch (selectedStatus) {
                case 'active':
                    indicator.classList.add('bg-success');
                    statusText.textContent = 'Active';
                    break;
                case 'offduty':
                    indicator.classList.add('bg-secondary');
                    statusText.textContent = 'Off Duty';
                    break;
                case 'maintenance':
                    indicator.classList.add('bg-warning');
                    statusText.textContent = 'Maintenance';
                    break;
                case 'out':
                    indicator.classList.add('bg-danger');
                    statusText.textContent = 'Out of Service';
                    break;
            }
        });
    });

    // Update status button functionality
    updateButton.addEventListener('click', function () {
        // Show loading state
        this.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Updating...';
        this.disabled = true;

        // Simulate API call
        setTimeout(() => {
            // Show success message
            const statusNames = {
                'active': 'Active',
                'offduty': 'Off Duty',
                'maintenance': 'Maintenance',
                'out': 'Out of Service'
            };

            // Add to timeline
            const timeline = document.querySelector('.timeline');
            const now = new Date();
            const timeString = now.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });

            const statusColors = {
                'active': 'bg-success',
                'offduty': 'bg-secondary',
                'maintenance': 'bg-warning',
                'out': 'bg-danger'
            };

            const newItem = document.createElement('div');
            newItem.className = 'timeline-item';
            newItem.innerHTML = `
                <div class="timeline-point ${statusColors[selectedStatus]}"></div>
                <div class="timeline-content">
                    <h6>${statusNames[selectedStatus]}</h6>
                    <p class="text-muted">Status updated</p>
                    <small class="text-muted">Today, ${timeString}</small>
                </div>
            `;

            timeline.insertBefore(newItem, timeline.firstChild);

            // Reset button
            this.innerHTML = '<i class="fas fa-sync-alt me-2"></i>Update Status';
            this.disabled = false;

            // Show notification
            alert(`Bus status updated to "${statusNames[selectedStatus]}" successfully!`);
        }, 1500);
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