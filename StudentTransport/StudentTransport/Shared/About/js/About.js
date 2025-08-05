document.addEventListener('DOMContentLoaded', function () {
    // Animated Counter for Stats
    const counters = document.querySelectorAll('.stat-number');
    const speed = 200;

    if (counters.length > 0) {
        counters.forEach(counter => {
            const animate = () => {
                const target = +counter.getAttribute('data-count');
                const count = +counter.innerText;
                const increment = target / speed;

                if (count < target) {
                    counter.innerText = Math.ceil(count + increment);
                    setTimeout(animate, 10);
                } else {
                    counter.innerText = target.toLocaleString();
                }
            };

            // Start animation when element is in viewport
            const observer = new IntersectionObserver((entries) => {
                if (entries[0].isIntersecting) {
                    animate();
                    observer.disconnect();
                }
            });

            observer.observe(counter);
        });
    }

    // Team Card Hover Effect
    const teamCards = document.querySelectorAll('.team-card');
    teamCards.forEach(card => {
        card.addEventListener('mouseenter', function () {
            this.style.transform = 'translateY(-10px)';
            this.style.boxShadow = '0 15px 40px rgba(0, 0, 0, 0.15)';
        });

        card.addEventListener('mouseleave', function () {
            this.style.transform = 'translateY(0)';
            this.style.boxShadow = '0 10px 30px rgba(0, 0, 0, 0.08)';
        });
    });

    // Testimonial Carousel (if multiple testimonials)
    let testimonialIndex = 0;
    const testimonials = document.querySelectorAll('.testimonial-card');

    if (testimonials.length > 1) {
        function showTestimonial(index) {
            testimonials.forEach((testimonial, i) => {
                testimonial.style.display = i === index ? 'block' : 'none';
            });
        }

        // Auto-rotate testimonials every 5 seconds
        setInterval(() => {
            testimonialIndex = (testimonialIndex + 1) % testimonials.length;
            showTestimonial(testimonialIndex);
        }, 5000);

        // Initial display
        showTestimonial(testimonialIndex);
    }

    // Smooth Scrolling for Anchor Links
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            e.preventDefault();
            document.querySelector(this.getAttribute('href')).scrollIntoView({
                behavior: 'smooth'
            });
        });
    });
});