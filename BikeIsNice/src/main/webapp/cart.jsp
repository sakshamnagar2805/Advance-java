<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<c:set var="pageTitle" value="Shopping Cart - BikeIsNice" scope="request" />
<jsp:include page="/fragments/header.jsp" />
<jsp:include page="/fragments/navbar.jsp" />

<main class="py-5">
    <div class="container">
        <!-- Breadcrumb & Header -->
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h2 class="fw-bold mb-1"><i class="bi bi-cart3 me-2 text-primary"></i>Shopping Cart</h2>
                <p class="text-muted small mb-0">Review your selected items before proceeding to secure checkout.</p>
            </div>
            <a href="<c:url value='/products' />" class="btn btn-outline-secondary btn-sm">
                <i class="bi bi-arrow-left me-1"></i> Continue Shopping
            </a>
        </div>

        <!-- Success & Error Alert Messages -->
        <c:if test="${not empty message}">
            <div class="alert alert-success alert-dismissible fade show shadow-sm" role="alert">
                <i class="bi bi-check-circle-fill me-2"></i>
                <c:out value="${message}" />
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>

        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger alert-dismissible fade show shadow-sm" role="alert">
                <i class="bi bi-exclamation-triangle-fill me-2"></i>
                <c:out value="${errorMessage}" />
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>

        <c:choose>
            <c:when test="${not empty cartItems}">
                <div class="row g-4">
                    <!-- Left: Cart Items Table -->
                    <div class="col-lg-8">
                        <div class="card border-0 shadow-sm rounded-3 overflow-hidden">
                            <div class="table-responsive">
                                <table class="table table-hover align-middle mb-0">
                                    <thead class="table-light small text-uppercase text-secondary">
                                        <tr>
                                            <th scope="col" style="min-width: 80px;">Image</th>
                                            <th scope="col" style="min-width: 200px;">Product Name</th>
                                            <th scope="col" class="text-center" style="min-width: 110px;">Unit Price</th>
                                            <th scope="col" class="text-center" style="min-width: 140px;">Quantity</th>
                                            <th scope="col" class="text-end" style="min-width: 120px;">Subtotal</th>
                                            <th scope="col" class="text-center" style="width: 60px;">Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:set var="cartSubtotal" value="0" />
                                        <c:forEach items="${cartItems}" var="item">
                                            <tr>
                                                <!-- Product Image Column -->
                                                <td>
                                                    <div class="bg-light rounded p-2 text-center text-primary d-flex align-items-center justify-content-center" 
                                                         style="width: 64px; height: 64px;">
                                                        <i class="bi bi-bicycle fs-3"></i>
                                                    </div>
                                                </td>

                                                <!-- Product Name Column -->
                                                <td>
                                                    <h6 class="mb-1 fw-bold">
                                                        <a href="<c:url value='/products/${item.productId}' />" class="text-decoration-none text-dark">
                                                            <c:out value="${itemProductMap[item.productId].name != null ? itemProductMap[item.productId].name : 'Product #' += item.productId}" />
                                                        </a>
                                                    </h6>
                                                    <small class="text-muted font-monospace">SKU: <c:out value="${itemProductMap[item.productId].sku != null ? itemProductMap[item.productId].sku : item.productId}" /></small>
                                                </td>

                                                <!-- Unit Price Column -->
                                                <td class="text-center fw-semibold">
                                                    <c:set var="currentPrice" value="${itemProductMap[item.productId].price != null ? itemProductMap[item.productId].price : 0.00}" />
                                                    $<c:out value="${currentPrice}" />
                                                </td>

                                                <!-- Quantity Adjustment Input Column -->
                                                <td class="text-center">
                                                    <form method="POST" action="<c:url value='/cart' />" class="d-inline-flex align-items-center gap-1">
                                                        <input type="hidden" name="action" value="update"/>
                                                        <input type="hidden" name="cartId" value="<c:out value='${item.cartId}' />"/>
                                                        <input type="number" name="quantity" class="form-control form-control-sm text-center fw-bold"
                                                               value="<c:out value='${item.quantity}' />" min="1" max="99" style="width: 70px;" required>
                                                        <button type="submit" class="btn btn-outline-primary btn-sm px-2" title="Update Quantity">
                                                            <i class="bi bi-arrow-repeat"></i>
                                                        </button>
                                                    </form>
                                                </td>

                                                <!-- Subtotal Column -->
                                                <td class="text-end fw-bold text-dark">
                                                    $<c:out value="${currentPrice * item.quantity}" />
                                                    <c:set var="cartSubtotal" value="${cartSubtotal + (currentPrice * item.quantity)}" />
                                                </td>

                                                <!-- Remove Action Column -->
                                                <td class="text-center">
                                                    <form method="POST" action="<c:url value='/cart' />" class="d-inline">
                                                        <input type="hidden" name="action" value="delete"/>
                                                        <input type="hidden" name="cartId" value="<c:out value='${item.cartId}' />"/>
                                                        <button type="submit" class="btn btn-link text-danger p-0" title="Remove Item">
                                                            <i class="bi bi-trash3-fill"></i>
                                                        </button>
                                                    </form>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>

                            <div class="card-footer bg-white d-flex justify-content-between align-items-center py-3">
                                <form method="POST" action="<c:url value='/cart' />" onsubmit="return confirm('Empty your cart?');">
                                    <input type="hidden" name="action" value="clear"/>
                                    <button type="submit" class="btn btn-outline-danger btn-sm">
                                        <i class="bi bi-trash me-1"></i> Clear Cart
                                    </button>
                                </form>
                                <span class="text-muted small">Live calculated inventory stock applied.</span>
                            </div>
                        </div>
                    </div>

                    <!-- Right: Order Summary Sidebar -->
                    <div class="col-lg-4">
                        <div class="card border-0 shadow-sm rounded-3 p-4">
                            <h5 class="fw-bold mb-3 border-bottom pb-2">Order Summary</h5>

                            <div class="d-flex justify-content-between mb-2">
                                <span class="text-muted">Cart Subtotal</span>
                                <span class="fw-bold">$<c:out value="${cartSubtotal}" /></span>
                            </div>

                            <div class="d-flex justify-content-between mb-2">
                                <span class="text-muted">Specialized Bike Freight</span>
                                <span class="small text-success fw-semibold">Free above $100</span>
                            </div>

                            <div class="d-flex justify-content-between mb-3">
                                <span class="text-muted">Estimated Tax (8%)</span>
                                <span class="small text-muted">At Checkout</span>
                            </div>

                            <hr class="my-3">

                            <div class="d-flex justify-content-between align-items-baseline mb-4">
                                <span class="fs-5 fw-bold">Subtotal</span>
                                <span class="fs-4 fw-bold text-primary">$<c:out value="${cartSubtotal}" /></span>
                            </div>

                            <a href="<c:url value='/checkout' />" class="btn btn-primary btn-lg fw-bold d-flex align-items-center justify-content-center gap-2">
                                <span>Proceed to Checkout</span>
                                <i class="bi bi-arrow-right"></i>
                            </a>

                            <div class="mt-3 p-3 bg-light rounded-3 border">
                                <div class="d-flex gap-2 align-items-center text-secondary small">
                                    <i class="bi bi-box-seam text-primary fs-5"></i>
                                    <span><strong>Freight Protection:</strong> Bikes ship 85% pre-assembled in heavy-duty reinforced cartons with multi-tool included.</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <!-- Empty Cart State -->
                <div class="card border-0 shadow-sm rounded-3 p-5 text-center">
                    <i class="bi bi-bicycle fs-1 text-muted" style="font-size: 4rem;"></i>
                    <h4 class="fw-bold mt-4 mb-2">Your Bicycle Cart is Empty</h4>
                    <p class="text-muted mb-4">You have not added any bikes, e-bikes, or cycling gear to your cart yet.</p>
                    <div>
                        <a href="<c:url value='/products' />" class="btn btn-primary px-4 py-2 fw-semibold">
                            <i class="bi bi-bicycle me-2"></i>Explore Bikes &amp; Gear
                        </a>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</main>

<jsp:include page="/fragments/footer.jsp" />
