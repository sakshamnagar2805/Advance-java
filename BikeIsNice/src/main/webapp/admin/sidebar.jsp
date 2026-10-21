<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<div class="card border-0 shadow-sm rounded-3 p-3">
    <div class="d-flex align-items-center gap-2 mb-3 pb-2 border-bottom">
        <i class="bi bi-shield-lock-fill text-danger fs-4"></i>
        <h6 class="fw-bold mb-0 text-uppercase tracking-wider">Store Manager</h6>
    </div>

    <!-- Manager Navigation Links -->
    <div class="list-group list-group-flush small">
        <a href="<c:url value='/admin/dashboard.jsp' />" 
           class="list-group-item list-group-item-action d-flex align-items-center gap-2 rounded-2 ${pageContext.request.requestURI.endsWith('dashboard.jsp') ? 'active fw-bold' : ''}">
            <i class="bi bi-speedometer2"></i> Dashboard Overview
        </a>
        <a href="<c:url value='/admin/products.jsp' />" 
           class="list-group-item list-group-item-action d-flex align-items-center gap-2 rounded-2 ${pageContext.request.requestURI.endsWith('products.jsp') ? 'active fw-bold' : ''}">
            <i class="bi bi-box-seam"></i> Products
        </a>
        <a href="<c:url value='/admin/categories.jsp' />" 
           class="list-group-item list-group-item-action d-flex align-items-center gap-2 rounded-2 ${pageContext.request.requestURI.endsWith('categories.jsp') ? 'active fw-bold' : ''}">
            <i class="bi bi-tags"></i> Categories
        </a>
        <a href="<c:url value='/admin/orders.jsp' />" 
           class="list-group-item list-group-item-action d-flex align-items-center gap-2 rounded-2 ${pageContext.request.requestURI.endsWith('orders.jsp') ? 'active fw-bold' : ''}">
            <i class="bi bi-receipt"></i> Orders
        </a>
        <a href="<c:url value='/admin/customers.jsp' />" 
           class="list-group-item list-group-item-action d-flex align-items-center gap-2 rounded-2 ${pageContext.request.requestURI.endsWith('customers.jsp') ? 'active fw-bold' : ''}">
            <i class="bi bi-people"></i> Customers
        </a>
    </div>

    <div class="mt-4 pt-3 border-top">
        <a href="<c:url value='/products' />" class="btn btn-outline-secondary btn-sm w-100 d-flex align-items-center justify-content-center gap-2">
            <i class="bi bi-box-arrow-up-right"></i> View Storefront
        </a>
    </div>
</div>

