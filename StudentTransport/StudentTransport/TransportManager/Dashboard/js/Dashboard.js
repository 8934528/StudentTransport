document.addEventListener('DOMContentLoaded', function () {
    // Initialize Chart
    const ctx = document.getElementById('activityChart').getContext('2d');
    const activityChart = new Chart(ctx, {
        type: 'line',
        data: {
            labels: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
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
                const statuses = ['bg-success', 'bg-primary', 'bg-warning', 'bg-secondary', 'bg-danger'];
                const statusTexts = ['Active', 'In Progress', 'Delayed', 'Scheduled', 'Maintenance'];

                // Remove all status classes
                const indicator = item.querySelector('.status-indicator');
                const statusText = item.querySelector('.status-text');
                indicator.classList.remove('bg-success', 'bg-primary', 'bg-warning', 'bg-secondary', 'bg-danger');

                // Get random status
                const randomIndex = Math.floor(Math.random() * statuses.length);
                indicator.classList.add(statuses[randomIndex]);
                statusText.textContent = statusTexts[randomIndex];

                // Randomly add/remove active class
                if (Math.random() > 0.5) {
                    item.classList.add('active');
                } else {
                    item.classList.remove('active');
                }
            }
        });
    }

    setInterval(updateStatusIndicators, 60000);

    // Simulate live updates to stats
    function updateStats() {
        const stats = document.querySelectorAll('.stat-card h2');
        stats.forEach(stat => {
            const currentValue = parseInt(stat.textContent.replace(/,/g, ''));
            const newValue = currentValue + Math.floor(Math.random() * 10) - 3;
            stat.textContent = newValue.toLocaleString();
        });
    }

    setInterval(updateStats, 30000);

    // Add click event to alert items
    document.querySelectorAll('.alert-item').forEach(item => {
        item.addEventListener('click', function () {
            const title = this.querySelector('.alert-title').textContent;
            alert(`Alert details: ${title}`);
        });
    });
});