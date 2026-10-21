<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<header>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark sticky-top shadow-sm py-3">
        <div class="container">
            <!-- Brand Logo -->
            <a class="navbar-brand d-flex align-items-center gap-2 fw-bold fs-4" href="<c:url value='/products' />">
                <i class="bi bi-bicycle text-warning fs-3"></i>
                <span>Bike<span class="text-warning">IsNice</span></span>
            </a>

            <!-- Mobile Toggle Button -->
            <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" 
                    data-bs-target="#shopSphereNavbar" aria-controls="shopSphereNavbar" 
                    aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <!-- Navbar Collapsible Content -->
            <div class="collapse navbar-collapse" id="shopSphereNavbar">
                <!-- Navigation Links for Bike Categories -->
                <ul class="navbar-nav me-auto mb-2 mb-lg-0 small fw-semibold">
                    <li class="nav-item">
                        <a class="nav-link ${empty param.category ? 'active text-warning' : ''}" href="<c:url value='/products' />">
                            <i class="bi bi-grid-fill me-1"></i> All Bikes
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link ${param.category == '1' ? 'active text-warning' : ''}" href="<c:url value='/products?category=1' />">
                            Mountain (MTB)
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link ${param.category == '2' ? 'active text-warning' : ''}" href="<c:url value='/products?category=2' />">
                            Road & Race
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link ${param.category == '3' ? 'active text-warning' : ''}" href="<c:url value='/products?category=3' />">
                            E-Bikes
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link ${param.category == '4' ? 'active text-warning' : ''}" href="<c:url value='/products?category=4' />">
                            Gravel
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link ${param.category == '5' ? 'active text-warning' : ''}" href="<c:url value='/products?category=5' />">
                            Gear & Helmets
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link text-info fw-bold" href="<c:url value='/syllabus-demo.jsp' />">
                            <i class="bi bi-mortarboard-fill me-1"></i> RTU Syllabus Demo
                        </a>
                    </li>
                </ul>

                <!-- Mobile-Responsive Search Bar -->
                <form class="d-flex mx-lg-3 my-2 my-lg-0 flex-grow-1" style="max-width: 380px;" 
                      method="GET" action="<c:url value='/products' />" role="search">
                    <div class="input-group">
                        <input class="form-control form-control-sm bg-light border-0" type="search" name="q" 
                               placeholder="Search bikes by model, gear, SKU..." 
                               value="<c:out value='${param.q}' />" aria-label="Search">
                        <button class="btn btn-warning btn-sm px-3 text-dark fw-bold" type="submit" title="Search">
                            <i class="bi bi-search"></i>
                        </button>
                    </div>
                </form>

                <!-- Right Side Actions: Language, Wishlist, Cart & Auth Dropdown -->
                <div class="d-flex align-items-center gap-2 mt-3 mt-lg-0 ms-auto">
                    <!-- Language Switcher (RTU Section 23 i18n) -->
                    <div class="btn-group btn-group-sm me-1" role="group" aria-label="Language Switcher">
                        <a href="<c:url value='/language?lang=en' />" 
                           class="btn ${sessionScope.currentLang == 'hi' ? 'btn-outline-secondary text-white-50' : 'btn-warning text-dark fw-bold'} btn-sm py-1 px-2" 
                           title="Switch to English">EN</a>
                        <a href="<c:url value='/language?lang=hi' />" 
                           class="btn ${sessionScope.currentLang == 'hi' ? 'btn-warning text-dark fw-bold' : 'btn-outline-secondary text-white-50'} btn-sm py-1 px-2" 
                           title="Switch to Hindi (हिन्दी)">हिन्दी</a>
                    </div>

                    <!-- Customer Wishlist Icon with Dynamic Item Counter -->
                    <a href="<c:url value='/wishlist' />" class="btn btn-outline-light btn-sm position-relative me-1" title="Wishlist">
                        <i class="bi bi-heart text-danger fs-6"></i>
                        <span class="d-none d-md-inline ms-1">Wishlist</span>
                        <c:choose>
                            <c:when test="${not empty sessionScope.wishlistCount && sessionScope.wishlistCount gt 0}">
                                <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
                                    <c:out value="${sessionScope.wishlistCount}" />
                                </span>
                            </c:when>
                            <c:otherwise>
                                <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-secondary">
                                    0
                                </span>
                            </c:otherwise>
                        </c:choose>
                    </a>

                    <!-- Shopping Cart Icon with Dynamic Item Counter -->
                    <a href="<c:url value='/cart' />" class="btn btn-outline-light btn-sm position-relative me-2" title="Shopping Cart">
                        <i class="bi bi-cart3 fs-6"></i>
                        <span class="d-none d-md-inline ms-1">Cart</span>
                        <c:choose>
                            <c:when test="${not empty sessionScope.cartCount && sessionScope.cartCount gt 0}">
                                <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
                                    <c:out value="${sessionScope.cartCount}" />
                                </span>
                            </c:when>
                            <c:otherwise>
                                <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-secondary">
                                    0
                                </span>
                            </c:otherwise>
                        </c:choose>
                    </a>

                    <!-- User Profile Dropdown & Conditional Auth Links -->
                    <c:choose>
                        <c:when test="${not empty sessionScope.user}">
                            <!-- Logged In User Dropdown -->
                            <div class="dropdown">
                                <button class="btn btn-secondary btn-sm dropdown-toggle d-flex align-items-center gap-2" 
                                        type="button" id="userMenuButton" data-bs-toggle="dropdown" aria-expanded="false">
                                    <i class="bi bi-person-circle"></i>
                                    <span><c:out value="${sessionScope.user.firstName}" /></span>
                                </button>
                                <ul class="dropdown-menu dropdown-menu-end shadow border-0" aria-labelledby="userMenuButton">
                                    <li>
                                        <h6 class="dropdown-header">
                                            Signed in as<br>
                                            <strong class="text-dark"><c:out value="${sessionScope.user.email}" /></strong>
                                        </h6>
                                    </li>
                                    <li><hr class="dropdown-divider"></li>
                                    <li>
                                        <a class="dropdown-item" href="<c:url value='/orders' />">
                                            <i class="bi bi-box-seam me-2 text-primary"></i> My Orders
                                        </a>
                                    </li>
                                    <li>
                                        <a class="dropdown-item" href="<c:url value='/wishlist' />">
                                            <i class="bi bi-heart me-2 text-danger"></i> My Wishlist
                                        </a>
                                    </li>
                                    <c:if test="${'ADMIN'.equalsIgnoreCase(sessionScope.user.role)}">
                                        <li>
                                            <a class="dropdown-item text-danger fw-semibold" href="<c:url value='/admin/dashboard.jsp' />">
                                                <i class="bi bi-speedometer2 me-2"></i> Admin Dashboard
                                            </a>
                                        </li>
                                    </c:if>
                                    <li><hr class="dropdown-divider"></li>
                                    <li>
                                        <!-- Logout Action -->
                                        <a class="dropdown-item text-danger" href="<c:url value='/logout' />">
                                            <i class="bi bi-box-arrow-right me-2"></i> Logout
                                        </a>
                                    </li>
                                </ul>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <!-- Guest User: Conditional Login / Register Buttons -->
                            <a href="<c:url value='/login' />" class="btn btn-outline-light btn-sm">
                                <i class="bi bi-box-arrow-in-right me-1"></i> Login
                            </a>
                            <a href="<c:url value='/register' />" class="btn btn-warning btn-sm text-dark fw-semibold">
                                Register
                            </a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </nav>
</header>
