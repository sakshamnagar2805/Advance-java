<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<c:set var="pageTitle" value="My Wishlist - BikeIsNice" scope="request" />
<jsp:include page="/fragments/header.jsp" />
<jsp:include page="/fragments/navbar.jsp" />

<main class="py-5">
    <div class="container">
        <!-- Header -->
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h2 class="fw-bold mb-1"><i class="bi bi-heart-fill me-2 text-danger"></i>My Wishlist</h2>
                <p class="text-muted small mb-0">Saved bicycles and cycling accessories you plan to purchase later.</p>
            </div>
            <a href="<c:url value='/products' />" class="btn btn-outline-secondary btn-sm">
                <i class="bi bi-arrow-left me-1"></i> Continue Shopping
            </a>
        </div>

        <!-- Success & Error Alert Messages -->
        <c:if test="${not empty sessionScope.wishlistSuccess}">
            <div class="alert alert-success alert-dismissible fade show shadow-sm" role="alert">
                <i class="bi bi-check-circle-fill me-2"></i>
                <c:out value="${sessionScope.wishlistSuccess}" />
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <c:remove var="wishlistSuccess" scope="session" />
        </c:if>

        <c:if test="${not empty sessionScope.wishlistError}">
            <div class="alert alert-danger alert-dismissible fade show shadow-sm" role="alert">
                <i class="bi bi-exclamation-triangle-fill me-2"></i>
                <c:out value="${sessionScope.wishlistError}" />
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <c:remove var="wishlistError" scope="session" />
        </c:if>

        <c:choose>
            <c:when test="${not empty wishlistProducts}">
                <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4">
                    <c:forEach items="${wishlistProducts}" var="product">
                        <div class="col">
                            <div class="card h-100 border-0 shadow-sm rounded-3 overflow-hidden">
                                <div class="bg-light p-4 text-center border-bottom position-relative">
                                    <i class="bi bi-bicycle display-4 text-warning"></i>
                                    <c:if test="${not empty product.salePrice && product.salePrice lt product.price}">
                                        <span class="position-absolute top-0 start-0 m-2 badge bg-danger">
                                            SALE
                                        </span>
                                    </c:if>
                                </div>
                                <div class="card-body d-flex flex-column">
                                    <div class="d-flex justify-content-between align-items-start mb-2">
                                        <span class="badge bg-secondary small"><c:out value="${product.sku}" /></span>
                                        <span class="badge ${product.stockQuantity gt 0 ? 'bg-success' : 'bg-danger'}">
                                            <c:out value="${product.stockQuantity gt 0 ? 'In Stock' : 'Out of Stock'}" />
                                        </span>
                                    </div>
                                    <h5 class="card-title fw-bold text-dark mb-1">
                                        <c:out value="${product.name}" />
                                    </h5>
                                    <p class="card-text text-muted small flex-grow-1 mb-3">
                                        <c:out value="${product.description}" />
                                    </p>
                                    <div class="d-flex align-items-baseline gap-2 mb-3">
                                        <c:choose>
                                            <c:when test="${not empty product.salePrice && product.salePrice lt product.price}">
                                                <span class="fs-4 fw-bold text-primary">₹<fmt:formatNumber value="${product.salePrice}" minFractionDigits="2" maxFractionDigits="2" /></span>
                                                <span class="text-muted text-decoration-line-through small">₹<fmt:formatNumber value="${product.price}" minFractionDigits="2" maxFractionDigits="2" /></span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="fs-4 fw-bold text-primary">₹<fmt:formatNumber value="${product.price}" minFractionDigits="2" maxFractionDigits="2" /></span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>

                                    <!-- Action Buttons -->
                                    <div class="d-grid gap-2">
                                        <form action="<c:url value='/wishlist' />" method="POST" class="d-grid">
                                            <input type="hidden" name="action" value="moveToCart" />
                                            <input type="hidden" name="productId" value="${product.productId}" />
                                            <button type="submit" class="btn btn-warning text-dark fw-bold btn-sm" ${product.stockQuantity le 0 ? 'disabled' : ''}>
                                                <i class="bi bi-cart-plus me-1"></i> Move to Cart
                                            </button>
                                        </form>

                                        <form action="<c:url value='/wishlist' />" method="POST" class="d-grid">
                                            <input type="hidden" name="action" value="remove" />
                                            <input type="hidden" name="productId" value="${product.productId}" />
                                            <button type="submit" class="btn btn-outline-danger btn-sm">
                                                <i class="bi bi-trash3 me-1"></i> Remove from Wishlist
                                            </button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <div class="card border-0 shadow-sm rounded-4 p-5 text-center my-4">
                    <div class="my-4">
                        <i class="bi bi-heart text-muted display-1"></i>
                    </div>
                    <h3 class="fw-bold mb-2">Your Wishlist is Empty</h3>
                    <p class="text-muted mb-4">You haven't saved any bicycles or accessories yet. Explore our latest collection!</p>
                    <div>
                        <a href="<c:url value='/products' />" class="btn btn-warning text-dark fw-bold px-4 py-2">
                            <i class="bi bi-bicycle me-2"></i> Browse Products
                        </a>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</main>

<jsp:include page="/fragments/footer.jsp" />
