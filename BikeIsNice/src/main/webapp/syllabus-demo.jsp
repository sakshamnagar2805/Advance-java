<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<%-- =========================================================================
     RTU ADVANCED JAVA SYLLABUS DIRECT DEMONSTRATION PAGE
     Section 16 & 17: Traditional JSP Syntax + JSTL + Expression Language (EL)
     ========================================================================= --%>

<%!
    // 1. Traditional JSP Declaration (<%! ... %>)
    private int pageVisitCount = 0;
    private String getProjectSlogan() {
        return "Rajasthan Technical University (RTU) - Advanced Java Enterprise Project";
    }
%>

<%
    // 2. Traditional JSP Scriptlet (<% ... %>)
    synchronized(this) {
        pageVisitCount++;
    }
    String studentName = "Saksham Nagar";
    String syllabusCourse = "Advanced Java Programming Laboratory (ADJ Lab)";
    java.time.LocalDateTime renderTime = java.time.LocalDateTime.now();
%>

<c:set var="pageTitle" value="RTU Syllabus Demonstration - ShopSphere" scope="request" />
<jsp:include page="/fragments/header.jsp" />
<jsp:include page="/fragments/navbar.jsp" />

<main class="py-5 bg-light">
    <div class="container">
        <!-- Hero Header -->
        <div class="card border-0 shadow-sm rounded-4 bg-dark text-white p-4 p-md-5 mb-5">
            <div class="row align-items-center">
                <div class="col-lg-8">
                    <span class="badge bg-warning text-dark text-uppercase fw-bold px-3 py-2 mb-3">
                        <i class="bi bi-mortarboard-fill me-1"></i> Viva & Examination Showcase
                    </span>
                    <h1 class="fw-bold display-6 mb-2">RTU Advanced Java Comprehensive Mapping</h1>
                    <p class="text-light opacity-75 lead mb-3">
                        Demonstrating every required syllabus topic: Servlets, JSP, JSTL, EL, Listeners, Filters, Sockets, RMI, Serialization & i18n inside <strong>BikeIsNice (ShopSphere)</strong>.
                    </p>
                    <div class="d-flex flex-wrap gap-3 text-warning small fw-semibold">
                        <span><i class="bi bi-person-badge me-1"></i> Student: <%= studentName %></span>
                        <span><i class="bi bi-book me-1"></i> <%= syllabusCourse %></span>
                        <span><i class="bi bi-clock-history me-1"></i> Page Rendered: <%= renderTime.toString() %></span>
                    </div>
                </div>
                <div class="col-lg-4 text-center d-none d-lg-block">
                    <i class="bi bi-cpu display-1 text-warning"></i>
                </div>
            </div>
        </div>

        <div class="row g-4">
            <!-- Left Column: Syllabus Demonstrations -->
            <div class="col-lg-8">
                <!-- 1. Traditional JSP Syntax Demonstration -->
                <div class="card border-0 shadow-sm rounded-3 mb-4">
                    <div class="card-header bg-white py-3 border-bottom">
                        <h5 class="fw-bold text-dark mb-0">
                            <i class="bi bi-code-square text-primary me-2"></i>1. Traditional JSP Elements (Syllabus Section 16)
                        </h5>
                    </div>
                    <div class="card-body">
                        <p class="text-muted small">
                            Demonstrates traditional JSP syntax side-by-side with modern Expression Language (EL):
                        </p>
                        <div class="table-responsive">
                            <table class="table table-bordered align-middle">
                                <thead class="table-light small text-secondary">
                                    <tr>
                                        <th>JSP Element</th>
                                        <th>Syntax Used</th>
                                        <th>Live Output Evaluated by Container</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td><strong>Declaration</strong></td>
                                        <td><code>&lt;%! int pageVisitCount = 0; %&gt;</code></td>
                                        <td><span class="badge bg-info text-dark">Method: <%= getProjectSlogan() %></span></td>
                                    </tr>
                                    <tr>
                                        <td><strong>Scriptlet</strong></td>
                                        <td><code>&lt;% synchronized(this){ pageVisitCount++; } %&gt;</code></td>
                                        <td>Visit count updated in memory: <strong><%= pageVisitCount %></strong></td>
                                    </tr>
                                    <tr>
                                        <td><strong>Expression</strong></td>
                                        <td><code>&lt;%= studentName %&gt;</code></td>
                                        <td><strong class="text-primary"><%= studentName %></strong></td>
                                    </tr>
                                    <tr>
                                        <td><strong>JSP Comment</strong></td>
                                        <td><code>&lt;%-- Server-side comment (hidden from browser source) --%&gt;</code></td>
                                        <td><em>Stripped out during translation phase (Verified in page source)</em></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

                <!-- 2. JSTL Core & JSTL Functions Demonstration -->
                <div class="card border-0 shadow-sm rounded-3 mb-4">
                    <div class="card-header bg-white py-3 border-bottom">
                        <h5 class="fw-bold text-dark mb-0">
                            <i class="bi bi-tags-fill text-success me-2"></i>2. JSTL Core & JSTL Functions (Syllabus Section 17)
                        </h5>
                    </div>
                    <div class="card-body">
                        <p class="text-muted small">
                            Demonstrating <code>&lt;c:set&gt;</code>, <code>&lt;c:if&gt;</code>, <code>&lt;c:choose&gt;</code>, <code>&lt;c:forEach&gt;</code>, and <code>fn:length()</code>:
                        </p>

                        <!-- JSTL Set -->
                        <c:set var="sampleBikeCategories" value="Mountain,Road & Race,Electric E-Bike,Gravel & Commuter" />
                        <c:set var="categoriesList" value="${fn:split(sampleBikeCategories, ',')}" />

                        <div class="bg-light p-3 rounded-3 mb-3 border">
                            <div class="small fw-bold text-secondary mb-2">JSTL Functions & EL Output:</div>
                            <ul class="mb-0 small">
                                <li><strong>Categories Count (<code>fn:length</code>):</strong> ${fn:length(categoriesList)} categories</li>
                                <li><strong>Uppercase String (<code>fn:toUpperCase</code>):</strong> ${fn:toUpperCase("BikeIsNice Enterprise")}</li>
                                <li><strong>Substring Contains (<code>fn:contains</code>):</strong> ${fn:contains(sampleBikeCategories, 'Electric') ? 'Yes (Found E-Bikes)' : 'No'}</li>
                            </ul>
                        </div>

                        <div class="small fw-bold text-secondary mb-2">JSTL Core Iteration (<code>&lt;c:forEach&gt;</code>):</div>
                        <div class="d-flex flex-wrap gap-2">
                            <c:forEach items="${categoriesList}" var="cat" varStatus="status">
                                <span class="badge bg-secondary px-3 py-2">
                                    #${status.count}: <c:out value="${cat}" />
                                </span>
                            </c:forEach>
                        </div>
                    </div>
                </div>

                <!-- 3. Distributed Systems: Sockets, RMI & Serialization -->
                <div class="card border-0 shadow-sm rounded-3 mb-4">
                    <div class="card-header bg-white py-3 border-bottom">
                        <h5 class="fw-bold text-dark mb-0">
                            <i class="bi bi-diagram-3-fill text-warning me-2"></i>3. Distributed Computing & Networking (Syllabus Sections 18, 19, 20)
                        </h5>
                    </div>
                    <div class="card-body">
                        <p class="text-muted small">
                            ShopSphere includes dedicated standalone client-server modules for oral viva execution:
                        </p>

                        <div class="row g-3">
                            <div class="col-md-6">
                                <div class="border rounded-3 p-3 h-100">
                                    <div class="fw-bold text-dark mb-1">
                                        <i class="bi bi-hdd-network text-primary me-2"></i>TCP Sockets (Text & Binary Object Streams)
                                    </div>
                                    <p class="small text-muted mb-2">
                                        <code>SocketInventoryServer</code> (port 8085) & <code>ObjectSocketInventoryServer</code> (port 8096) transferring serialized <code>Product</code> objects via <code>ObjectOutputStream</code>.
                                    </p>
                                    <div class="bg-dark text-light p-2 rounded small font-monospace">
                                        java com.shopsphere.network.socket.ObjectSocketInventoryServer<br>
                                        java com.shopsphere.network.socket.ObjectSocketInventoryClient
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-6">
                                <div class="border rounded-3 p-3 h-100">
                                    <div class="fw-bold text-dark mb-1">
                                        <i class="bi bi-clouds text-success me-2"></i>Java RMI (Remote Method Invocation)
                                    </div>
                                    <p class="small text-muted mb-2">
                                        <code>InventoryService</code> remote interface published on port 1099 with automatic RMI Registry binding and stub invocation.
                                    </p>
                                    <div class="bg-dark text-light p-2 rounded small font-monospace">
                                        java com.shopsphere.network.rmi.RmiInventoryServer<br>
                                        java com.shopsphere.network.rmi.RmiInventoryClient
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Right Column: Live Container Metrics & Syllabus Checklist -->
            <div class="col-lg-4">
                <!-- Live Application Context Status (From AppListener) -->
                <div class="card border-0 shadow-sm rounded-3 mb-4">
                    <div class="card-header bg-white py-3 border-bottom">
                        <h6 class="fw-bold text-dark mb-0">
                            <i class="bi bi-activity text-danger me-2"></i>Live Container State (AppListener)
                        </h6>
                    </div>
                    <div class="card-body small">
                        <div class="mb-3">
                            <span class="text-muted d-block">App Initialized At:</span>
                            <strong><c:out value="${applicationScope.appStartTime != null ? applicationScope.appStartTime : 'Runtime Active'}" /></strong>
                        </div>
                        <div class="mb-3">
                            <span class="text-muted d-block">Active HttpSessions:</span>
                            <span class="badge bg-success fs-6"><c:out value="${applicationScope.activeSessions != null ? applicationScope.activeSessions : 1}" /> Active</span>
                        </div>
                        <div class="mb-3">
                            <span class="text-muted d-block">Active Language Locale:</span>
                            <span class="badge bg-secondary"><c:out value="${sessionScope.currentLang == 'hi' ? 'Hindi (हिन्दी)' : 'English (en)'}" /></span>
                            <div class="mt-2">
                                <a href="<c:url value='/language?lang=en' />" class="btn btn-outline-secondary btn-sm py-0">EN</a>
                                <a href="<c:url value='/language?lang=hi' />" class="btn btn-outline-secondary btn-sm py-0">हिन्दी</a>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Viva Quick Reference Mapping -->
                <div class="card border-0 shadow-sm rounded-3">
                    <div class="card-header bg-white py-3 border-bottom">
                        <h6 class="fw-bold text-dark mb-0">
                            <i class="bi bi-check2-circle text-success me-2"></i>Viva Quick Checklist
                        </h6>
                    </div>
                    <ul class="list-group list-group-flush small">
                        <li class="list-group-item d-flex justify-content-between align-items-center">
                            Desktop Swing GUI
                            <span class="badge bg-primary">LoginFrame.java</span>
                        </li>
                        <li class="list-group-item d-flex justify-content-between align-items-center">
                            JDBC DAO Layer
                            <span class="badge bg-primary">User/Product/OrderDAO</span>
                        </li>
                        <li class="list-group-item d-flex justify-content-between align-items-center">
                            Security Filters
                            <span class="badge bg-primary">Auth & AdminFilter</span>
                        </li>
                        <li class="list-group-item d-flex justify-content-between align-items-center">
                            Event Handling
                            <span class="badge bg-primary">AppListener.java</span>
                        </li>
                        <li class="list-group-item d-flex justify-content-between align-items-center">
                            Customer Wishlist
                            <span class="badge bg-success">WishlistServlet</span>
                        </li>
                        <li class="list-group-item d-flex justify-content-between align-items-center">
                            Customer Order History
                            <span class="badge bg-success">OrderServlet</span>
                        </li>
                        <li class="list-group-item d-flex justify-content-between align-items-center">
                            Object Serialization
                            <span class="badge bg-warning text-dark">ObjectSocketServer</span>
                        </li>
                        <li class="list-group-item d-flex justify-content-between align-items-center">
                            Internationalization
                            <span class="badge bg-warning text-dark">I18nUtil + ResourceBundle</span>
                        </li>
                        <li class="list-group-item d-flex justify-content-between align-items-center">
                            JNDI & URL Handlers
                            <span class="badge bg-secondary">JndiDemo & UrlProtocolDemo</span>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</main>

<jsp:include page="/fragments/footer.jsp" />
