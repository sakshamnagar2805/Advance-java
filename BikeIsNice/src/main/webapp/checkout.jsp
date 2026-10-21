<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<c:set var="pageTitle" value="Checkout - BikeIsNice" scope="request" />
<jsp:include page="/fragments/header.jsp" />
<jsp:include page="/fragments/navbar.jsp" />

<main class="py-5">
    <div class="container">
        <!-- Title & Breadcrumb -->
        <div class="mb-4">
            <h2 class="fw-bold"><i class="bi bi-shield-check me-2 text-success"></i>Bicycle Checkout &amp; Payment</h2>
            <p class="text-muted small">Please fill in your delivery details and choose your preferred payment option.</p>
        </div>

        <!-- Bootstrap Validation Alerts (Success & Error) -->
        <c:if test="${not empty successMessage}">
            <div class="alert alert-success alert-dismissible fade show shadow-sm d-flex align-items-center" role="alert">
                <i class="bi bi-check-circle-fill fs-5 me-2"></i>
                <div><c:out value="${successMessage}" /></div>
                <button type="button" class="btn-close ms-auto" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>

        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger alert-dismissible fade show shadow-sm d-flex align-items-center" role="alert">
                <i class="bi bi-exclamation-octagon-fill fs-5 me-2"></i>
                <div><c:out value="${errorMessage}" /></div>
                <button type="button" class="btn-close ms-auto" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>

        <!-- Two-Column Responsive Checkout Form -->
        <form method="POST" action="<c:url value='/checkout' />" id="checkoutForm">
            <div class="row g-4">
                <!-- Left Column: Shipping Address & Coupon Code Input -->
                <div class="col-lg-8">
                    <!-- Shipping Address Card -->
                    <div class="card border-0 shadow-sm rounded-3 p-4 mb-4">
                        <h5 class="fw-bold mb-3 d-flex align-items-center gap-2">
                            <i class="bi bi-geo-alt-fill text-primary"></i> 1. Delivery &amp; Shipping Address
                        </h5>

                        <div class="row g-3">
                            <div class="col-md-6">
                                <label class="form-label small fw-semibold">Recipient Full Name</label>
                                <input type="text" name="recipientName" class="form-control" 
                                       value="<c:out value='${sessionScope.user.firstName} ${sessionScope.user.lastName}' />" required>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label small fw-semibold">Phone Number</label>
                                <input type="tel" name="phoneNumber" class="form-control" 
                                       placeholder="+1 (555) 000-0000" 
                                       value="<c:out value='${sessionScope.user.phoneNumber}' />" required>
                            </div>

                            <div class="col-12">
                                <label class="form-label small fw-semibold">Street Address</label>
                                <input type="text" name="streetAddress" class="form-control" 
                                       placeholder="1234 Main St, Apt 4B" required>
                            </div>

                            <div class="col-md-5">
                                <label class="form-label small fw-semibold">City</label>
                                <input type="text" name="city" class="form-control" placeholder="New York" required>
                            </div>

                            <div class="col-md-4">
                                <label class="form-label small fw-semibold">State / Province</label>
                                <input type="text" name="state" class="form-control" placeholder="NY" required>
                            </div>

                            <div class="col-md-3">
                                <label class="form-label small fw-semibold">Postal Code</label>
                                <input type="text" name="postalCode" class="form-control" placeholder="10001" required>
                            </div>
                        </div>

                        <!-- Fallback / Reference ID for existing database record -->
                        <input type="hidden" name="shippingAddressId" value="1"/>
                        <input type="hidden" name="billingAddressId" value="1"/>
                    </div>

                    <!-- Coupon Code Input Card -->
                    <div class="card border-0 shadow-sm rounded-3 p-4 mb-4">
                        <h5 class="fw-bold mb-3 d-flex align-items-center gap-2">
                            <i class="bi bi-ticket-perforated-fill text-warning"></i> 2. Bike Promotional Coupon
                        </h5>

                        <div class="row g-3 align-items-center">
                            <div class="col-md-8">
                                <label class="form-label small fw-semibold">Have a cycling discount voucher code?</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light"><i class="bi bi-tag"></i></span>
                                    <input type="text" name="couponCode" id="couponCode" class="form-control text-uppercase font-monospace" 
                                           placeholder="e.g. BIKE10 or RIDE50" value="<c:out value='${param.couponCode}' />">
                                </div>
                                <small class="text-muted">Enter code and place order to receive your instant verified discount.</small>
                            </div>
                            <div class="col-md-4 text-md-end mt-md-4">
                                <span class="badge bg-success-subtle text-success p-2 small d-inline-block">
                                    <i class="bi bi-bicycle me-1"></i> Try 'BIKE10' or 'RIDE50'
                                </span>
                            </div>
                        </div>
                    </div>

                    <!-- Payment Method Card -->
                    <div class="card border-0 shadow-sm rounded-3 p-4">
                        <h5 class="fw-bold mb-3 d-flex align-items-center gap-2">
                            <i class="bi bi-credit-card-2-front-fill text-primary"></i> 3. Payment Method
                        </h5>

                        <div class="row g-3">
                            <div class="col-md-4">
                                <div class="form-check border rounded p-3 h-100">
                                    <input class="form-check-input" type="radio" name="paymentMethod" id="payCreditCard" value="credit_card" checked>
                                    <label class="form-check-label fw-bold d-block" for="payCreditCard">
                                        <i class="bi bi-credit-card fs-4 d-block text-primary mb-1"></i>
                                        Credit Card
                                    </label>
                                </div>
                            </div>

                            <div class="col-md-4">
                                <div class="form-check border rounded p-3 h-100">
                                    <input class="form-check-input" type="radio" name="paymentMethod" id="payPayPal" value="paypal">
                                    <label class="form-check-label fw-bold d-block" for="payPayPal">
                                        <i class="bi bi-paypal fs-4 d-block text-primary mb-1"></i>
                                        PayPal
                                    </label>
                                </div>
                            </div>

                            <div class="col-md-4">
                                <div class="form-check border rounded p-3 h-100">
                                    <input class="form-check-input" type="radio" name="paymentMethod" id="payCOD" value="cod">
                                    <label class="form-check-label fw-bold d-block" for="payCOD">
                                        <i class="bi bi-cash-stack fs-4 d-block text-success mb-1"></i>
                                        Cash on Delivery
                                    </label>
                                </div>
                            </div>
                        </div>

                        <div class="mt-3">
                            <label class="form-label small fw-semibold text-muted">Delivery Notes (Optional)</label>
                            <textarea name="notes" class="form-control form-control-sm" rows="2" placeholder="Gate instructions, special delivery notes..."></textarea>
                        </div>
                    </div>
                </div>

                <!-- Right Column: Order Summary Panel -->
                <div class="col-lg-4">
                    <div class="card border-0 shadow-sm rounded-3 p-4 sticky-top" style="top: 90px;">
                        <h5 class="fw-bold mb-3 border-bottom pb-2">Order Summary</h5>

                        <div class="d-flex justify-content-between mb-2">
                            <span class="text-muted">Subtotal</span>
                            <span class="fw-semibold">Calculated from Catalog</span>
                        </div>

                        <div class="d-flex justify-content-between mb-2">
                            <span class="text-muted">Coupon Discount</span>
                            <span class="text-success fw-bold">Applied on submission</span>
                        </div>

                        <div class="d-flex justify-content-between mb-2">
                            <span class="text-muted">Bicycle Freight</span>
                            <span class="text-success small fw-semibold">Free over $100</span>
                        </div>

                        <div class="d-flex justify-content-between mb-3">
                            <span class="text-muted">Estimated Tax</span>
                            <span class="text-muted small">8% Standard Rate</span>
                        </div>

                        <div class="alert alert-light border small text-muted p-2 mb-3">
                            <i class="bi bi-shield-lock-fill text-success me-1"></i>
                            <strong>Verified Checkout:</strong> Ships in reinforced bike carton with tuning instructions and assembly multi-tool.
                        </div>

                        <hr class="my-3">

                        <!-- Place Order Button -->
                        <div class="d-grid gap-2">
                            <button type="submit" class="btn btn-success btn-lg fw-bold d-flex align-items-center justify-content-center gap-2">
                                <i class="bi bi-check2-circle fs-5"></i>
                                <span>Place Order</span>
                            </button>
                        </div>

                        <div class="text-center mt-3 small text-muted">
                            <i class="bi bi-lock me-1"></i> SSL 256-Bit Encrypted Checkout
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
</main>

<jsp:include page="/fragments/footer.jsp" />
