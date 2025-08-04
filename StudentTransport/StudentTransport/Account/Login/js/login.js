document.addEventListener('DOMContentLoaded', function () {
    const form = document.getElementById('form1');
    const emailInput = document.getElementById('txtEmail');
    const passwordInput = document.getElementById('txtPassword');
    const errorMessage = document.getElementById('lblMessage');
    const loginButton = document.getElementById('btnLogin');

    // Form submission validation
    if (form) {
        form.addEventListener('submit', function (e) {
            let isValid = true;
            errorMessage.classList.add('d-none');

            // Reset error states
            emailInput.classList.remove('is-invalid');
            passwordInput.classList.remove('is-invalid');

            // Email validation
            if (!emailInput.value.trim() || !validateEmail(emailInput.value.trim())) {
                emailInput.classList.add('is-invalid');
                isValid = false;
            }

            // Password validation
            if (!passwordInput.value.trim() || passwordInput.value.trim().length < 6) {
                passwordInput.classList.add('is-invalid');
                isValid = false;
            }

            if (!isValid) {
                e.preventDefault();
                errorMessage.textContent = 'Please enter a valid email and password (min 6 characters)';
                errorMessage.classList.remove('d-none');

                // Animate error message
                errorMessage.style.transform = 'scale(0.95)';
                setTimeout(() => {
                    errorMessage.style.transform = 'scale(1)';
                }, 50);
            }
        });
    }

    // Email validation function
    function validateEmail(email) {
        const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        return re.test(email);
    }

    // Demo login functionality
    if (loginButton) {
        loginButton.addEventListener('click', function (e) {
            // Only run demo if form is valid
            if (form.checkValidity()) {
                this.disabled = true;
                this.textContent = 'Logging in...';

                // Simulate login process
                setTimeout(() => {
                    this.textContent = 'Login Successful!';
                    this.style.background = 'linear-gradient(to right, #2ecc71, #27ae60)';

                    setTimeout(() => {
                        window.location.href = '/Student/StudDefault/StudDefault.aspx';
                    }, 1000);
                }, 1500);
            }
        });
    }
});