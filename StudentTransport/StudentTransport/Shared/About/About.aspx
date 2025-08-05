<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="StudentTransport.Shared.About.About" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>About Student Transport</title>
    <link href="css/About.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&family=Montserrat:wght@700;800&display=swap" rel="stylesheet" />
</head>

<body>
    <form id="form1" runat="server">
        <!-- Hero Section -->
        <section class="hero">
            <div class="container">
                <h1>About Our Transport System</h1>
                <p>Connecting students to their destinations safely and efficiently</p>
                <div class="cta-buttons">
                    <a href="Contact.aspx" class="btn btn-primary">Contact Us</a>
                    <a href="Login.aspx" class="btn btn-secondary">Login to System</a>
                </div>
            </div>
            <div class="hero-wave"></div>
        </section>

        <!-- Introduction Section -->
        <section class="intro-section">
            <div class="container">
                <div class="intro-content">
                    <div class="intro-text">
                        <h2>Your Journey, Our Priority</h2>
                        <p>Student Transport Management System is dedicated to providing safe, reliable, and efficient transportation services for students across campus and residence areas. Our innovative platform connects students with transportation resources, ensuring timely arrivals and peace of mind.</p>
                        <p>With real-time tracking, easy booking, and dedicated support, we're transforming student transportation into a seamless experience.</p>
                    </div>
                    <div class="intro-image">
                        <img src="https://images.unsplash.com/photo-1560264280-88b68371db39?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80" alt="Student Transportation" />
                    </div>
                </div>
            </div>
        </section>

        <!-- Stats Section -->
        <section class="stats-section">
            <div class="container">
                <div class="stats-grid">
                    <div class="stat-card">
                        <div class="stat-icon">
                            <i class="fas fa-bus"></i>
                        </div>
                        <div class="stat-number" data-count="50">0</div>
                        <div class="stat-label">Active Buses</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-icon">
                            <i class="fas fa-users"></i>
                        </div>
                        <div class="stat-number" data-count="2500">0</div>
                        <div class="stat-label">Students Served</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-icon">
                            <i class="fas fa-route"></i>
                        </div>
                        <div class="stat-number" data-count="12">0</div>
                        <div class="stat-label">Routes</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-icon">
                            <i class="fas fa-calendar-check"></i>
                        </div>
                        <div class="stat-number" data-count="15000">0</div>
                        <div class="stat-label">Monthly Rides</div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Features Section -->
        <section class="features-section">
            <div class="container">
                <h2 class="section-title">Why Choose Our Transport System?</h2>
                <div class="features-grid">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-shield-alt"></i>
                        </div>
                        <h3>Safety First</h3>
                        <p>All drivers are background-checked and buses are regularly maintained for maximum safety.</p>
                    </div>
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-clock"></i>
                        </div>
                        <h3>Punctual Service</h3>
                        <p>Real-time tracking ensures buses arrive on schedule. 97% on-time arrival rate.</p>
                    </div>
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-mobile-alt"></i>
                        </div>
                        <h3>Easy Booking</h3>
                        <p>Book rides in seconds through our mobile-friendly platform.</p>
                    </div>
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-headset"></i>
                        </div>
                        <h3>24/7 Support</h3>
                        <p>Our support team is always ready to assist with any transportation needs.</p>
                    </div>
                </div>
            </div>
        </section>

        <!-- Team Section -->
        <section class="team-section">
            <div class="container">
                <h2 class="section-title">Meet Our Team</h2>
                <p class="section-subtitle">The dedicated professionals behind our transportation service</p>

                <div class="team-grid">
                    <div class="team-card">
                        <div class="team-image">
                            <img src="https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-4.0.3&auto=format&fit=crop&w=200&q=80" alt="Team Member" />
                            <div class="social-links">
                                <a href="#"><i class="fab fa-linkedin-in"></i></a>
                                <a href="#"><i class="fab fa-twitter"></i></a>
                                <a href="#"><i class="fab fa-facebook-f"></i></a>
                            </div>
                        </div>
                        <h3>Michael Johnson</h3>
                        <p>Transport Director</p>
                    </div>
                    <div class="team-card">
                        <div class="team-image">
                            <img src="https://images.unsplash.com/photo-1544005313-94ddf0286df2?ixlib=rb-4.0.3&auto=format&fit=crop&w=200&q=80" alt="Team Member" />
                            <div class="social-links">
                                <a href="#"><i class="fab fa-linkedin-in"></i></a>
                                <a href="#"><i class="fab fa-twitter"></i></a>
                                <a href="#"><i class="fab fa-facebook-f"></i></a>
                            </div>
                        </div>
                        <h3>Sarah Williams</h3>
                        <p>Operations Manager</p>
                    </div>
                    <div class="team-card">
                        <div class="team-image">
                            <img src="https://images.unsplash.com/photo-1552058544-f2b08422138a?ixlib=rb-4.0.3&auto=format&fit=crop&w=200&q=80" alt="Team Member" />
                            <div class="social-links">
                                <a href="#"><i class="fab fa-linkedin-in"></i></a>
                                <a href="#"><i class="fab fa-twitter"></i></a>
                                <a href="#"><i class="fab fa-facebook-f"></i></a>
                            </div>
                        </div>
                        <h3>David Chen</h3>
                        <p>Technology Lead</p>
                    </div>
                    <div class="team-card">
                        <div class="team-image">
                            <img src="https://images.unsplash.com/photo-1560250097-0b93528c311a?ixlib=rb-4.0.3&auto=format&fit=crop&w=200&q=80" alt="Team Member" />
                            <div class="social-links">
                                <a href="#"><i class="fab fa-linkedin-in"></i></a>
                                <a href="#"><i class="fab fa-twitter"></i></a>
                                <a href="#"><i class="fab fa-facebook-f"></i></a>
                            </div>
                        </div>
                        <h3>James Rodriguez</h3>
                        <p>Driver Coordinator</p>
                    </div>
                </div>
            </div>
        </section>

        <!-- Testimonials -->
        <section class="testimonials-section">
            <div class="container">
                <h2 class="section-title">What Students Say</h2>
                <div class="testimonials-container">
                    <div class="testimonial-card">
                        <div class="quote-icon"><i class="fas fa-quote-left"></i></div>
                        <p class="testimonial-text">This transport system saved me so much time! I never have to worry about being late for classes anymore.</p>
                        <div class="student-info">
                            <img src="https://images.unsplash.com/photo-1534528741775-53994a69daeb?ixlib=rb-4.0.3&auto=format&fit=crop&w=100&q=80" alt="Student" />
                            <div>
                                <h4>Emma Thompson</h4>
                                <p>Computer Science Student</p>
                            </div>
                        </div>
                    </div>
                    <div class="testimonial-card">
                        <div class="quote-icon"><i class="fas fa-quote-left"></i></div>
                        <p class="testimonial-text">The real-time tracking feature is amazing. I know exactly when the bus will arrive so I don't have to wait outside.</p>
                        <div class="student-info">
                            <img src="https://images.unsplash.com/photo-1502823403499-6ccfcf4fb453?ixlib=rb-4.0.3&auto=format&fit=crop&w=100&q=80" alt="Student" />
                            <div>
                                <h4>Alex Johnson</h4>
                                <p>Engineering Student</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Call to Action -->
        <section class="cta-section">
            <div class="container">
                <h2>Ready to Experience Better Transportation?</h2>
                <p>Join thousands of students enjoying stress-free campus transportation</p>
                <div class="cta-buttons">
                    <a href="Register.aspx" class="btn btn-light">Create Account</a>
                    <a href="Contact.aspx" class="btn btn-outline-light">Contact Us</a>
                </div>
            </div>
        </section>

        <!-- Footer -->
        <footer class="footer">
            <div class="container">
                <div class="footer-grid">
                    <div class="footer-about">
                        <h3>Student Transport</h3>
                        <p>Providing safe and reliable transportation solutions for students since 2018.</p>
                        <div class="social-icons">
                            <a href="#"><i class="fab fa-facebook-f"></i></a>
                            <a href="#"><i class="fab fa-twitter"></i></a>
                            <a href="#"><i class="fab fa-instagram"></i></a>
                            <a href="#"><i class="fab fa-linkedin-in"></i></a>
                        </div>
                    </div>
                    <div class="footer-links">
                        <h4>Quick Links</h4>
                        <ul>
                            <li><a href="StudDefault.aspx">Dashboard</a></li>
                            <li><a href="Schedule.aspx">Schedule</a></li>
                            <li><a href="BookingHistory.aspx">My Bookings</a></li>
                            <li><a href="Contact.aspx">Support</a></li>
                        </ul>
                    </div>
                    <div class="footer-contact">
                        <h4>Contact Us</h4>
                        <ul>
                            <li><i class="fas fa-map-marker-alt"></i>123 Campus Drive, University City</li>
                            <li><i class="fas fa-phone"></i>(555) 123-4567</li>
                            <li><i class="fas fa-envelope"></i>transport@university.edu</li>
                        </ul>
                    </div>
                </div>
                <div class="footer-bottom">
                    <p>&copy; 2023 Student Transport Management System. All rights reserved.</p>
                </div>
            </div>
        </footer>
    </form>

    <script src="js/About.js"></script>
</body>
</html>
