document.addEventListener('DOMContentLoaded', function () {
    // Update the clock every second
    function updateClock() {
        const now = new Date();
        const timeString = now.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
        document.querySelectorAll('.schedule-item .time').forEach(el => {
            if (el.textContent === 'Now') return;

            const scheduleTime = el.textContent;
            const [hours, minutes] = scheduleTime.split(':').map(Number);
            const scheduleDate = new Date();
            scheduleDate.setHours(hours, minutes, 0, 0);

            if (now >= scheduleDate) {
                el.textContent = 'Now';
                el.parentElement.classList.add('active');
            }
        });
    }

    setInterval(updateClock, 60000);
    updateClock();

    // Add click event to schedule items
    document.querySelectorAll('.schedule-item').forEach(item => {
        item.addEventListener('click', function () {
            // Remove active class from all items
            document.querySelectorAll('.schedule-item').forEach(i => {
                i.classList.remove('active');
            });

            // Add active class to clicked item
            this.classList.add('active');

            // Show confirmation message
            const time = this.querySelector('.time').textContent;
            const from = this.querySelector('.from').textContent;
            const to = this.querySelector('.to').textContent;

            alert(`You've selected the route from ${from} to ${to} at ${time}. Press OK to confirm.`);
        });
    });

    // Initialize tooltips
    const tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
    tooltipTriggerList.map(function (tooltipTriggerEl) {
        return new bootstrap.Tooltip(tooltipTriggerEl);
    });
});