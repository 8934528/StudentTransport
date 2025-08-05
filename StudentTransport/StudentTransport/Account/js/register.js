document.addEventListener('DOMContentLoaded', function () {
    const roleSelect = document.getElementById('ddlRole');
    const studentFields = document.getElementById('studentFields');
    const driverFields = document.getElementById('driverFields');
    const form = document.getElementById('form1');
    const errorMessage = document.getElementById('lblMessage');

    // Show/hide role fields
    if (roleSelect) {
        roleSelect.addEventListener('change', function () {
            studentFields.style.display = 'none';
            driverFields.style.display = 'none';

            if (this.value === 'Student') {
                studentFields.style.display = 'block';
            } else if (this.value === 'Driver') {
                driverFields.style.display = 'block';
            }
        });
    }

    // Form validation
    if (form) {
        form.addEventListener('submit', function (e) {
            let isValid = true;
            errorMessage.classList.add('d-none');

            const emailInput = document.getElementById('txtEmail');
            if (emailInput.value && !validateEmail(emailInput.value)) {
                emailInput.classList.add('is-invalid');
                isValid = false;
            }

            const passwordInput = document.getElementById('txtPassword');
            const confirmPasswordInput = document.getElementById('txtConfirmPassword');
            if (passwordInput.value && passwordInput.value.length < 8) {
                passwordInput.classList.add('is-invalid');
                isValid = false;
                showError('Password must be at least 8 characters');
            }

            if (passwordInput.value !== confirmPasswordInput.value) {
                passwordInput.classList.add('is-invalid');
                confirmPasswordInput.classList.add('is-invalid');
                isValid = false;
                showError('Passwords do not match');
            }

            if (roleSelect.value === 'Student') {
                const residenceInput = document.getElementById('txtResidence');
                const campusInput = document.getElementById('txtCampus');

                if (!residenceInput.value.trim() || !campusInput.value.trim()) {
                    residenceInput.classList.add('is-invalid');
                    campusInput.classList.add('is-invalid');
                    isValid = false;
                }
            }

            if (!isValid) {
                e.preventDefault();
                if (!errorMessage.textContent) {
                    showError('Please fill in all required fields');
                }
            }
        });
    }

    function showError(message) {
        errorMessage.textContent = message;
        errorMessage.classList.remove('d-none');

        errorMessage.style.transform = 'scale(0.95)';
        setTimeout(() => {
            errorMessage.style.transform = 'scale(1)';
        }, 50);
    }

    // Email validation 
    function validateEmail(email) {
        const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        return re.test(email);
    }
});