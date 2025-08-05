document.addEventListener('DOMContentLoaded', function () {
    const form = document.getElementById('form1');
    const emailInput = document.getElementById('txtEmail');
    const passwordInput = document.getElementById('txtPassword');
    const errorMessage = document.getElementById('lblMessage');

    // Form submission validation
    if (form) {
        form.addEventListener('submit', function (e) {
            let isValid = true;
            errorMessage.classList.add('d-none');

            emailInput.classList.remove('is-invalid');
            passwordInput.classList.remove('is-invalid');

            if (!emailInput.value.trim() || !validateEmail(emailInput.value.trim())) {
                emailInput.classList.add('is-invalid');
                isValid = false;
            }

            if (!passwordInput.value.trim() || passwordInput.value.trim().length < 6) {
                passwordInput.classList.add('is-invalid');
                isValid = false;
            }

            if (!isValid) {
                e.preventDefault();
                errorMessage.textContent = 'Please enter a valid email and password (min 6 characters)';
                errorMessage.classList.remove('d-none');

                errorMessage.style.transform = 'scale(0.95)';
                setTimeout(() => {
                    errorMessage.style.transform = 'scale(1)';
                }, 50);
            }
        });
    }

    // Email validation 
    function validateEmail(email) {
        const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        return re.test(email);
    }
});