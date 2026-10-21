<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<aside class="sidebar-wrapper">
    <!-- Categories Filter -->
    <div class="sidebar-box shadow-sm mb-4">
        <h6 class="sidebar-title"><i class="bi bi-bicycle me-2 text-primary"></i>Bike Categories</h6>
        <div class="list-group list-group-flush small">
            <a href="<c:url value='/products' />" 
               class="list-group-item list-group-item-action d-flex justify-content-between align-items-center ${empty param.category ? 'active fw-bold' : ''}">
                All Bikes & Gear
                <span class="badge rounded-pill ${empty param.category ? 'bg-light text-dark' : 'bg-secondary'}">All</span>
            </a>
            <a href="<c:url value='/products?category=1' />" 
               class="list-group-item list-group-item-action d-flex justify-content-between align-items-center ${param.category == '1' ? 'active fw-bold' : ''}">
                Mountain Bikes (MTB)
                <span class="badge rounded-pill bg-light text-secondary">Trail</span>
            </a>
            <a href="<c:url value='/products?category=2' />" 
               class="list-group-item list-group-item-action d-flex justify-content-between align-items-center ${param.category == '2' ? 'active fw-bold' : ''}">
                Road & Racing Bikes
                <span class="badge rounded-pill bg-light text-secondary">Speed</span>
            </a>
            <a href="<c:url value='/products?category=3' />" 
               class="list-group-item list-group-item-action d-flex justify-content-between align-items-center ${param.category == '3' ? 'active fw-bold' : ''}">
                Electric Bikes (E-Bikes)
                <span class="badge rounded-pill bg-light text-secondary">750W</span>
            </a>
            <a href="<c:url value='/products?category=4' />" 
               class="list-group-item list-group-item-action d-flex justify-content-between align-items-center ${param.category == '4' ? 'active fw-bold' : ''}">
                Gravel & Hybrid Bikes
                <span class="badge rounded-pill bg-light text-secondary">All-Road</span>
            </a>
            <a href="<c:url value='/products?category=5' />" 
               class="list-group-item list-group-item-action d-flex justify-content-between align-items-center ${param.category == '5' ? 'active fw-bold' : ''}">
                Cycling Gear & Helmets
                <span class="badge rounded-pill bg-light text-secondary">Gear</span>
            </a>
        </div>
    </div>

    <!-- Filter Options -->
    <div class="sidebar-box shadow-sm mb-4">
        <h6 class="sidebar-title"><i class="bi bi-funnel me-2 text-primary"></i>Refine Search</h6>
        <form method="GET" action="<c:url value='/products' />">
            <c:if test="${not empty param.category}">
                <input type="hidden" name="category" value="<c:out value='${param.category}' />"/>
            </c:if>

            <div class="mb-3">
                <label class="form-label small fw-semibold text-secondary">Price Range</label>
                <div class="d-flex gap-2 align-items-center">
                    <input type="number" name="minPrice" class="form-control form-control-sm" placeholder="Min" 
                           value="<c:out value='${param.minPrice}' />" min="0">
                    <span class="text-muted">-</span>
                    <input type="number" name="maxPrice" class="form-control form-control-sm" placeholder="Max" 
                           value="<c:out value='${param.maxPrice}' />" min="0">
                </div>
            </div>

            <div class="form-check form-switch mb-3">
                <input class="form-check-input" type="checkbox" id="inStockOnly" name="inStock" value="true"
                       ${param.inStock == 'true' ? 'checked' : ''}>
                <label class="form-check-label small" for="inStockOnly">In Stock Only</label>
            </div>

            <button type="submit" class="btn btn-outline-primary btn-sm w-100">Apply Filters</button>
        </form>
    </div>

    <!-- Promotional Coupon Callout -->
    <div class="card border-0 bg-dark text-white shadow-sm rounded-3 p-3">
        <div class="d-flex align-items-center gap-2 mb-2">
            <i class="bi bi-ticket-perforated-fill fs-4 text-warning"></i>
            <h6 class="mb-0 fw-bold">Rider Promo!</h6>
        </div>
        <p class="small text-white-50 mb-2">Use voucher code below at checkout for 10% off bikes & gear:</p>
        <div class="bg-warning text-dark py-1 px-2 rounded text-center font-monospace fw-bold small">
            BIKE10
        </div>
    </div>
</aside>

