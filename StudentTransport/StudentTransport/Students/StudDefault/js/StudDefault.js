document.addEventListener('DOMContentLoaded', function () {
    // Initialize map bus animations
    const busIcons = document.querySelectorAll('.bus-location i');
    busIcons.forEach(icon => {
        // Add random delay to animations
        const delay = Math.random() * 2;
        icon.style.animationDelay = `${delay}s`;
    });

    // Update bus locations randomly
    function moveBuses() {
        document.querySelectorAll('.bus-location').forEach(bus => {
            const top = 20 + Math.random() * 60;
            const left = 10 + Math.random() * 80;
            bus.style.top = `${top}%`;
            bus.style.left = `${left}%`;
        });
    }

    // Move buses every 15 seconds
    setInterval(moveBuses, 15000);

    // Update real-time information
    function updateRealTime() {
        const now = new Date();
        const timeString = now.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });

        // Update next ride time
        const rideTime = document.querySelector('.next-ride-card .time');
        if (rideTime) {
            rideTime.textContent = `Today, ${timeString}`;
        }

        // Update timeline times
        document.querySelectorAll('.timeline-item small').forEach(el => {
            if (el.textContent.includes('Today')) {
                el.textContent = `Today, ${timeString}`;
            }
        });
    }

    setInterval(updateRealTime, 60000);
    updateRealTime();

    // Add click event to bus table rows
    document.querySelectorAll('.table-hover tbody tr').forEach(row => {
        row.addEventListener('click', function () {
            // Remove active class from all rows
            document.querySelectorAll('.table-hover tbody tr').forEach(r => {
                r.classList.remove('table-active');
            });

            // Add active class to clicked row
            this.classList.add('table-active');

            // Highlight bus on map
            const busNumber = this.cells[0].textContent;
            document.querySelectorAll('.bus-location').forEach(bus => {
                bus.style.opacity = '0.5';
                bus.style.transform = 'scale(0.8)';

                if (bus.querySelector('.bus-number').textContent === busNumber) {
                    bus.style.opacity = '1';
                    bus.style.transform = 'scale(1.2)';
                    bus.style.zIndex = '4';

                    // Add pulse animation
                    bus.querySelector('i').style.animation = 'bounce 0.8s ease infinite';

                    // Remove pulse after 3 seconds
                    setTimeout(() => {
                        bus.querySelector('i').style.animation = 'bounce 2s infinite';
                    }, 3000);
                }
            });
        });
    });

    // Book a ride button functionality
    document.querySelector('.btn-outline-success').addEventListener('click', function () {
        alert('Redirecting to booking system...');
        // In real app: window.location.href = 'BookingPage.aspx';
    });
});