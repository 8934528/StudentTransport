document.addEventListener('DOMContentLoaded', function () {
    // Calendar navigation
    let currentDate = new Date();
    const currentWeekEl = document.getElementById('currentWeek');

    function updateWeekDisplay() {
        const monday = new Date(currentDate);
        monday.setDate(monday.getDate() - monday.getDay() + 1);

        const sunday = new Date(monday);
        sunday.setDate(sunday.getDate() + 6);

        const options = { month: 'short', day: 'numeric' };
        currentWeekEl.textContent = `Week of ${monday.toLocaleDateString([], options)} - ${sunday.toLocaleDateString([], options)}`;
    }

    document.getElementById('btnPrevWeek')?.addEventListener('click', function () {
        currentDate.setDate(currentDate.getDate() - 7);
        updateWeekDisplay();
    });

    document.getElementById('btnNextWeek')?.addEventListener('click', function () {
        currentDate.setDate(currentDate.getDate() + 7);
        updateWeekDisplay();
    });

    updateWeekDisplay();

    // Slot selection functionality
    const availableSlots = document.querySelectorAll('.slot.available');
    const bookingPreview = document.querySelector('.selection-details');
    const noSelection = document.querySelector('.no-selection');

    availableSlots.forEach(slot => {
        slot.addEventListener('click', function () {
            availableSlots.forEach(s => {
                s.classList.remove('selected');
            });

            this.classList.add('selected');

            const dayIndex = Array.from(this.parentElement.children).indexOf(this);
            const days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
            const timeSlot = this.querySelector('span:first-child').textContent;

            document.querySelector('.booking-time').textContent = `${days[dayIndex]}, ${timeSlot}`;

            noSelection.classList.add('d-none');
            bookingPreview.classList.remove('d-none');

            // Store selected schedule ID in hidden field
            const scheduleId = this.getAttribute('data-schedule-id');
            document.getElementById('<%= hfSelectedScheduleID.ClientID %>').value = scheduleId;
        });
    });

    // Cancel selection
    document.getElementById('btnCancelSelection')?.addEventListener('click', function () {
        availableSlots.forEach(s => {
            s.classList.remove('selected');
        });
        bookingPreview.classList.add('d-none');
        noSelection.classList.remove('d-none');
    });

    // Initialize tooltips
    const tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
    tooltipTriggerList.map(function (tooltipTriggerEl) {
        return new bootstrap.Tooltip(tooltipTriggerEl);
    });
});