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

    document.getElementById('btnPrevWeek').addEventListener('click', function () {
        currentDate.setDate(currentDate.getDate() - 7);
        updateWeekDisplay();
    });

    document.getElementById('btnNextWeek').addEventListener('click', function () {
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
            // Remove selected class from all slots
            availableSlots.forEach(s => {
                s.classList.remove('selected');
            });

            // Add selected class to clicked slot
            this.classList.add('selected');

            // Update booking preview
            const dayIndex = Array.from(this.parentElement.children).indexOf(this);
            const days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
            const timeSlot = this.querySelector('span:first-child').textContent;

            document.querySelector('.booking-time').textContent = `${days[dayIndex]}, ${timeSlot}`;

            // Show booking details
            noSelection.classList.add('d-none');
            bookingPreview.classList.remove('d-none');
        });
    });

    // Cancel selection
    document.getElementById('btnCancelSelection').addEventListener('click', function () {
        availableSlots.forEach(s => {
            s.classList.remove('selected');
        });
        bookingPreview.classList.add('d-none');
        noSelection.classList.remove('d-none');
    });

    // Confirm booking
    document.getElementById('btnConfirmBooking').addEventListener('click', function () {
        const bookingTime = document.querySelector('.booking-time').textContent;

        // Show loading state
        this.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Processing...';
        this.disabled = true;

        // Simulate booking process
        setTimeout(() => {
            // Reset button
            this.innerHTML = '<i class="fas fa-check me-2"></i>Confirm Booking';
            this.disabled = false;

            // Show success message
            alert(`Your booking for ${bookingTime} has been confirmed!`);

            // Reset selection
            availableSlots.forEach(s => {
                s.classList.remove('selected');
            });
            bookingPreview.classList.add('d-none');
            noSelection.classList.remove('d-none');

            // Update slot to booked
            const selectedSlot = document.querySelector('.slot.selected');
            if (selectedSlot) {
                selectedSlot.classList.remove('available', 'selected');
                selectedSlot.classList.add('booked');
                selectedSlot.innerHTML = '<span>Booked</span>';
            }
        }, 1500);
    });

    // Cancel upcoming booking
    document.querySelectorAll('.upcoming-bookings .btn-outline-danger').forEach(btn => {
        btn.addEventListener('click', function () {
            const bookingItem = this.closest('.booking-item');
            const bookingDate = bookingItem.querySelector('.booking-date').textContent;
            const bookingTime = bookingItem.querySelector('.booking-time').textContent;

            if (confirm(`Are you sure you want to cancel your booking on ${bookingDate} at ${bookingTime}?`)) {
                // Show loading state
                this.innerHTML = '<i class="fas fa-spinner fa-spin"></i>';
                this.disabled = true;

                // Simulate cancellation
                setTimeout(() => {
                    bookingItem.remove();
                    alert('Your booking has been cancelled successfully.');
                }, 1000);
            }
        });
    });

    // Initialize tooltips
    const tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
    tooltipTriggerList.map(function (tooltipTriggerEl) {
        return new bootstrap.Tooltip(tooltipTriggerEl);
    });
});