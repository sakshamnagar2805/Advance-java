<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>

<c:set var="pageTitle" value="Bicycles &amp; Gear Catalog - BikeIsNice" scope="request" />
<jsp:include page="/fragments/header.jsp" />
<jsp:include page="/fragments/navbar.jsp" />

<main class="py-4">
    <div class="container">
        <!-- Hero Header -->
        <div class="d-flex flex-wrap justify-content-between align-items-center mb-4 pb-3 border-bottom">
            <div>
                <h2 class="fw-bold mb-1"><i class="bi bi-bicycle me-2 text-warning"></i>Bicycles & Gear Catalog</h2>
                <p class="text-muted small mb-0">Explore our performance collection of trail mountain bikes, aerodynamic road racers, commuter e-bikes, gravel explorers, and safety gear.</p>
            </div>
            <!-- Sorting Dropdown -->
            <div class="d-flex align-items-center gap-2 mt-3 mt-md-0">
                <label for="sortBy" class="small text-secondary fw-semibold text-nowrap">Sort By:</label>
                <select id="sortBy" class="form-select form-select-sm" onchange="location = this.value;">
                    <option value="<c:url value='/products?sort=newest' />" ${param.sort == 'newest' ? 'selected' : ''}>Newest First</option>
                    <option value="<c:url value='/products?sort=price_asc' />" ${param.sort == 'price_asc' ? 'selected' : ''}>Price: Low to High</option>
                    <option value="<c:url value='/products?sort=price_desc' />" ${param.sort == 'price_desc' ? 'selected' : ''}>Price: High to Low</option>
                </select>
            </div>
        </div>

        <div class="row g-4">
            <!-- Responsive Sidebar Filter -->
            <div class="col-lg-3">
                <div class="card border-0 shadow-sm rounded-3 p-3 mb-4">
                    <h6 class="fw-bold mb-3 text-uppercase text-secondary small" style="letter-spacing: 0.5px;">
                        <i class="bi bi-bicycle text-primary me-2"></i>Bike Categories
                    </h6>
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

                <!-- Price Range Filter Form -->
                <div class="card border-0 shadow-sm rounded-3 p-3 mb-4">
                    <h6 class="fw-bold mb-3 text-uppercase text-secondary small" style="letter-spacing: 0.5px;">
                        <i class="bi bi-funnel-fill text-primary me-2"></i>Filter by Price
                    </h6>
                    <form method="GET" action="<c:url value='/products' />">
                        <c:if test="${not empty param.category}">
                            <input type="hidden" name="category" value="<c:out value='${param.category}' />"/>
                        </c:if>
                        <div class="row g-2 mb-3">
                            <div class="col-6">
                                <label class="small text-muted">Min ($)</label>
                                <input type="number" name="minPrice" class="form-control form-control-sm" 
                                       placeholder="0" value="<c:out value='${param.minPrice}' />" min="0">
                            </div>
                            <div class="col-6">
                                <label class="small text-muted">Max ($)</label>
                                <input type="number" name="maxPrice" class="form-control form-control-sm" 
                                       placeholder="1000" value="<c:out value='${param.maxPrice}' />" min="0">
                            </div>
                        </div>
                        <button type="submit" class="btn btn-outline-primary btn-sm w-100 fw-semibold">
                            Apply Filter
                        </button>
                    </form>
                </div>
            </div>

            <!-- Dynamic Product Listing Grid -->
            <div class="col-lg-9">
                <c:choose>
                    <c:when test="${not empty products}">
                        <!-- Responsive Product Grid using custom productCard.tag -->
                        <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-4">
                            <c:forEach items="${products}" var="product">
                                <div class="col">
                                    <tags:productCard product="${product}" />
                                </div>
                            </c:forEach>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <!-- Empty State -->
                        <div class="card border-0 shadow-sm rounded-3 p-5 text-center">
                            <i class="bi bi-search fs-1 text-muted mb-3"></i>
                            <h4 class="fw-bold">No Products Found</h4>
                            <p class="text-muted">No items matched your current filter or search criteria.</p>
                            <div>
                                <a href="<c:url value='/products' />" class="btn btn-primary btn-sm px-4">
                                    Reset Filters
                                </a>
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</main>

<jsp:include page="/fragments/footer.jsp" />

