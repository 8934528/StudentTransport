document.addEventListener('DOMContentLoaded', function () {
    // Initialize Chart with real data
    const ctx = document.getElementById('activityChart').getContext('2d');

    // Get current day names for labels
    const days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    const today = new Date().getDay();
    const labels = [];

    for (let i = 0; i < 7; i++) {
        const dayIndex = (today - 6 + i + 7) % 7;
        labels.push(days[dayIndex]);
    }

    const activityChart = new Chart(ctx, {
        type: 'line',
        data: {
            labels: labels,
            datasets: [{
                label: 'Completed Trips',
                data: [120, 145, 130, 160, 155, 90, 70],
                borderColor: '#50C878',
                backgroundColor: 'rgba(80, 200, 120, 0.1)',
                tension: 0.4,
                fill: true
            }, {
                label: 'Scheduled Trips',
                data: [85, 95, 105, 100, 110, 120, 100],
                borderColor: '#6082B6',
                backgroundColor: 'rgba(96, 130, 182, 0.1)',
                tension: 0.4,
                fill: true
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: {
                    position: 'top',
                },
                tooltip: {
                    mode: 'index',
                    intersect: false
                }
            },
            scales: {
                y: {
                    beginAtZero: true,
                    grid: {
                        drawBorder: false
                    }
                },
                x: {
                    grid: {
                        display: false
                    }
                }
            }
        }
    });

    // Update status indicators every minute
    function updateStatusIndicators() {
        document.querySelectorAll('.status-item').forEach(item => {
            if (Math.random() > 0.7) {
                const statuses = [
                    { class: 'bg-success', text: 'Active' },
                    { class: 'bg-primary', text: 'In Progress' },
                    { class: 'bg-warning', text: 'Delayed' },
                    { class: 'bg-secondary', text: 'Scheduled' },
                    { class: 'bg-danger', text: 'Maintenance' }
                ];

                const randomIndex = Math.floor(Math.random() * statuses.length);
                const status = statuses[randomIndex];

                const indicator = item.querySelector('.status-indicator');
                const statusText = item.querySelector('.status-text');

                indicator.className = 'status-indicator ' + status.class;
                statusText.textContent = status.text;
            }
        });
    }

    updateStatusIndicators();
    setInterval(updateStatusIndicators, 60000);

    // Click event
    document.querySelectorAll('.alert-item').forEach(item => {
        item.addEventListener('click', function () {
            const title = this.querySelector('.alert-title').textContent;
            alert(`Alert details: ${title}`);
        });
    });
});