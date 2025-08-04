// Driver-specific JavaScript
document.addEventListener('DOMContentLoaded', function () {
    const statusButtons = document.querySelectorAll('.status-controls button');

    statusButtons.forEach(button => {
        button.addEventListener('click', function () {
            const status = this.textContent.replace('Set ', '');
            updateBusStatus(status);
        });
    });
});

function updateBusStatus(status) {
    console.log(`Updating bus status to: ${status}`);
    // Implement AJAX call to update bus status
}