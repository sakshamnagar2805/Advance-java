<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<footer class="mt-auto py-5 bg-dark text-white-50 border-top border-secondary">
    <div class="container">
        <div class="row g-4">
            <!-- Brand Column -->
            <div class="col-lg-4 col-md-6">
                <h5 class="text-white fw-bold d-flex align-items-center gap-2 mb-3">
                    <i class="bi bi-bicycle text-warning fs-4"></i> Bike<span class="text-warning">IsNice</span>
                </h5>
                <p class="small text-muted">
                    Your premier destination for high-performance mountain bikes, aerodynamic road racers, commuter e-bikes, gravel grinders, and certified safety cycling gear. Built with Jakarta EE and MySQL 8.
                </p>
                <div class="d-flex gap-3 fs-5 mt-3">
                    <a href="#" class="text-white-50 hover-light"><i class="bi bi-facebook"></i></a>
                    <a href="#" class="text-white-50 hover-light"><i class="bi bi-twitter-x"></i></a>
                    <a href="#" class="text-white-50 hover-light"><i class="bi bi-instagram"></i></a>
                    <a href="#" class="text-white-50 hover-light"><i class="bi bi-strava"></i></a>
                </div>
            </div>

            <!-- Quick Links -->
            <div class="col-lg-2 col-6">
                <h6 class="text-white fw-semibold mb-3">Bikes & Gear</h6>
                <ul class="list-unstyled small d-flex flex-column gap-2 mb-0">
                    <li><a href="<c:url value='/products?category=1' />" class="text-white-50 text-decoration-none">Mountain (MTB)</a></li>
                    <li><a href="<c:url value='/products?category=2' />" class="text-white-50 text-decoration-none">Road & Racing</a></li>
                    <li><a href="<c:url value='/products?category=3' />" class="text-white-50 text-decoration-none">Electric (E-Bikes)</a></li>
                    <li><a href="<c:url value='/products?category=4' />" class="text-white-50 text-decoration-none">Gravel & Hybrid</a></li>
                    <li><a href="<c:url value='/products?category=5' />" class="text-white-50 text-decoration-none">Gear & Helmets</a></li>
                </ul>
            </div>

            <!-- Customer Service -->
            <div class="col-lg-2 col-6">
                <h6 class="text-white fw-semibold mb-3">Rider Support</h6>
                <ul class="list-unstyled small d-flex flex-column gap-2 mb-0">
                    <li><a href="#" class="text-white-50 text-decoration-none">Bike Sizing Guide</a></li>
                    <li><a href="#" class="text-white-50 text-decoration-none">Shipping & Assembly</a></li>
                    <li><a href="#" class="text-white-50 text-decoration-none">Frame Warranty</a></li>
                    <li><a href="#" class="text-white-50 text-decoration-none">Tune-Up FAQ</a></li>
                    <li><a href="#" class="text-white-50 text-decoration-none">Ride Club Support</a></li>
                </ul>
            </div>

            <!-- Newsletter Subscription -->
            <div class="col-lg-4 col-md-6">
                <h6 class="text-white fw-semibold mb-3">Stay Updated</h6>
                <p class="small text-muted">Subscribe to receive exclusive deals, voucher codes, and weekly discounts.</p>
                <form class="d-flex gap-2">
                    <input type="email" class="form-control form-control-sm bg-secondary border-0 text-white" 
                           placeholder="Enter your email" required>
                    <button class="btn btn-warning btn-sm px-3 fw-semibold text-dark" type="submit">Join</button>
                </form>
            </div>
        </div>

        <hr class="border-secondary my-4">

        <div class="row align-items-center">
            <div class="col-md-6 text-center text-md-start small">
                &copy; 2026 BikeIsNice Inc. All rights reserved.
            </div>
            <div class="col-md-6 text-center text-md-end mt-2 mt-md-0">
                <span class="small me-3">Secure Transactions:</span>
                <i class="bi bi-credit-card-2-front fs-5 me-2 text-light"></i>
                <i class="bi bi-paypal fs-5 me-2 text-light"></i>
                <i class="bi bi-shield-check fs-5 text-success"></i>
            </div>
        </div>
    </div>
</footer>

<!-- Latest Bootstrap 5.3.3 JavaScript Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/bundle.min.js" 
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>

