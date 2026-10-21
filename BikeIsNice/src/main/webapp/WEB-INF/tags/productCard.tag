<%@ tag language="java" pageEncoding="UTF-8" description="Reusable Product Card UI Component" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<%@ attribute name="product" type="com.shopsphere.model.Product" required="true" description="Product entity" %>

<div class="card h-100 product-card shadow-sm border-0 rounded-3 overflow-hidden position-relative">
    <!-- Image & Discount Badge -->
    <div class="product-image-wrapper position-relative text-center p-4 bg-light" style="height: 210px; display: flex; align-items: center; justify-content: center;">
        <i class="bi bi-bicycle text-primary opacity-75" style="font-size: 5.5rem;"></i>

        <!-- Calculated Discount Badge -->
        <c:if test="${not empty product.salePrice && product.salePrice gt 0 && product.salePrice lt product.price}">
            <c:set var="savings" value="${((product.price - product.salePrice) / product.price) * 100}" />
            <fmt:formatNumber var="discountPercent" value="${savings}" maxFractionDigits="0" />
            <span class="badge bg-danger position-absolute top-0 start-0 m-3 px-2 py-1 shadow-sm">
                -<c:out value="${discountPercent}" />% OFF
            </span>
        </c:if>

        <!-- Stock Status Pill -->
        <c:choose>
            <c:when test="${product.stockQuantity gt 0}">
                <span class="badge bg-success position-absolute top-0 end-0 m-3 px-2 py-1">
                    In Stock (<c:out value="${product.stockQuantity}" />)
                </span>
            </c:when>
            <c:otherwise>
                <span class="badge bg-secondary position-absolute top-0 end-0 m-3 px-2 py-1">
                    Out of Stock
                </span>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- Product Card Body -->
    <div class="card-body d-flex flex-column p-3">
        <!-- Brand / SKU -->
        <div class="d-flex justify-content-between align-items-center mb-1">
            <span class="text-uppercase text-muted fw-bold small" style="font-size: 0.72rem; letter-spacing: 0.5px;">
                Brand: BikeIsNice
            </span>
            <small class="text-muted font-monospace" style="font-size: 0.72rem;">
                <c:out value="${product.sku}" />
            </small>
        </div>

        <!-- Product Name -->
        <h6 class="card-title fw-bold mb-2">
            <a href="<c:url value='/products/${product.productId}' />" class="text-decoration-none text-dark hover-primary" 
               title="<c:out value='${product.name}' />">
                <c:out value="${product.name}" />
            </a>
        </h6>

        <!-- Reusable Star Rating Tag -->
        <div class="mb-2">
            <tags:rating value="4.5" max="5" />
        </div>

        <!-- Price Display -->
        <div class="mt-auto pt-2">
            <div class="d-flex align-items-baseline gap-2 mb-2">
                <c:choose>
                    <c:when test="${not empty product.salePrice && product.salePrice gt 0 && product.salePrice lt product.price}">
                        <span class="fs-5 fw-bold text-danger">$<c:out value="${product.salePrice}" /></span>
                        <span class="text-decoration-line-through text-muted small">$<c:out value="${product.price}" /></span>
                    </c:when>
                    <c:otherwise>
                        <span class="fs-5 fw-bold text-dark">$<c:out value="${product.price}" /></span>
                    </c:otherwise>
                </c:choose>
            </div>

            <%-- 'Add to Cart' Button (Renders ONLY if product stock > 0 using JSTL c:if) --%>
            <c:if test="${product.stockQuantity gt 0}">
                <form method="POST" action="<c:url value='/cart' />" class="d-grid">
                    <input type="hidden" name="action" value="add"/>
                    <input type="hidden" name="productId" value="<c:out value='${product.productId}' />"/>
                    <input type="hidden" name="quantity" value="1"/>
                    <button type="submit" class="btn btn-primary btn-sm fw-semibold d-flex align-items-center justify-content-center gap-2">
                        <i class="bi bi-cart-plus"></i> Add to Cart
                    </button>
                </form>
            </c:if>

            <c:if test="${product.stockQuantity le 0}">
                <div class="d-grid">
                    <button type="button" class="btn btn-outline-secondary btn-sm" disabled>
                        <i class="bi bi-x-circle me-1"></i> Sold Out
                    </button>
                </div>
            </c:if>
        </div>
    </div>
</div>

