// Student-specific JavaScript
document.addEventListener('DOMContentLoaded', function () {
    // Refresh bus schedule every 60 seconds
    setInterval(refreshBusSchedule, 60000);
});

function refreshBusSchedule() {
    console.log('Refreshing bus schedule...');
    // Implement AJAX call to update bus schedule
}