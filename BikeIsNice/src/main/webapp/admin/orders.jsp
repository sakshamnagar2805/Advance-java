<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<c:set var="pageTitle" value="Order Management - BikeIsNice Admin" scope="request" />
<jsp:include page="/fragments/header.jsp" />
<jsp:include page="/fragments/navbar.jsp" />

<main class="py-4">
    <div class="container-fluid px-lg-5">
        <div class="d-flex justify-content-between align-items-center mb-4 pb-2 border-bottom">
            <div>
                <h2 class="fw-bold mb-1"><i class="bi bi-receipt me-2 text-primary"></i>Customer Orders</h2>
                <p class="text-muted small mb-0">Track customer fulfillments, update timelines, and manage order statuses.</p>
            </div>
            <div>
                <button class="btn btn-primary btn-sm d-flex align-items-center gap-2">
                    <i class="bi bi-download"></i> Export CSV
                </button>
            </div>
        </div>

        <div class="row g-4">
            <!-- Left: Admin Sidebar -->
            <div class="col-lg-3 col-xl-2">
                <jsp:include page="/admin/sidebar.jsp" />
            </div>

            <!-- Right: Orders Table & Status Indicators -->
            <div class="col-lg-9 col-xl-10">
                <!-- Status Filter Pills -->
                <div class="d-flex flex-wrap gap-2 mb-3">
                    <button class="btn btn-dark btn-sm rounded-pill px-3">All Orders (384)</button>
                    <button class="btn btn-outline-warning btn-sm rounded-pill px-3 text-dark">Pending (12)</button>
                    <button class="btn btn-outline-info btn-sm rounded-pill px-3 text-dark">Processing (24)</button>
                    <button class="btn btn-outline-primary btn-sm rounded-pill px-3">Shipped (45)</button>
                    <button class="btn btn-outline-success btn-sm rounded-pill px-3">Delivered (285)</button>
                    <button class="btn btn-outline-danger btn-sm rounded-pill px-3">Cancelled (18)</button>
                </div>

                <div class="card border-0 shadow-sm rounded-3 overflow-hidden">
                    <div class="table-responsive">
                        <table class="table table-hover align-middle mb-0">
                            <thead class="table-light small text-uppercase text-secondary">
                                <tr>
                                    <th scope="col">Order ID</th>
                                    <th scope="col">Customer</th>
                                    <th scope="col">Date Placed</th>
                                    <th scope="col" class="text-center">Items</th>
                                    <th scope="col" class="text-end">Total Amount</th>
                                    <th scope="col" class="text-center">Order Status</th>
                                    <th scope="col" class="text-center">Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <!-- Example 1: Delivered (Green) -->
                                <tr>
                                    <td class="font-monospace fw-bold text-primary">ORD-2026-1001</td>
                                    <td>
                                        <div class="fw-semibold">Jane Doe</div>
                                        <small class="text-muted">customer@shopsphere.com</small>
                                    </td>
                                    <td class="small text-muted">Oct 05, 2026 14:22</td>
                                    <td class="text-center">2 items</td>
                                    <td class="text-end fw-bold">$1,049.49</td>
                                    <td class="text-center">
                                        <!-- Colored Badge: Green for Delivered -->
                                        <span class="badge bg-success px-3 py-2 fw-semibold">
                                            <i class="bi bi-check2-circle me-1"></i> Delivered
                                        </span>
                                    </td>
                                    <td class="text-center">
                                        <div class="btn-group btn-group-sm">
                                            <button class="btn btn-outline-secondary" title="View Details"><i class="bi bi-eye"></i></button>
                                            <button class="btn btn-outline-primary" title="Print Invoice"><i class="bi bi-printer"></i></button>
                                        </div>
                                    </td>
                                </tr>

                                <!-- Example 2: Pending (Yellow) -->
                                <tr>
                                    <td class="font-monospace fw-bold text-primary">ORD-2026-1002</td>
                                    <td>
                                        <div class="fw-semibold">Michael Smith</div>
                                        <small class="text-muted">michael.s@example.com</small>
                                    </td>
                                    <td class="small text-muted">Oct 06, 2026 08:15</td>
                                    <td class="text-center">1 item</td>
                                    <td class="text-end fw-bold">$699.00</td>
                                    <td class="text-center">
                                        <!-- Colored Badge: Yellow for Pending -->
                                        <span class="badge bg-warning text-dark px-3 py-2 fw-semibold">
                                            <i class="bi bi-hourglass-split me-1"></i> Pending
                                        </span>
                                    </td>
                                    <td class="text-center">
                                        <div class="btn-group btn-group-sm">
                                            <button class="btn btn-outline-secondary" title="View Details"><i class="bi bi-eye"></i></button>
                                            <button class="btn btn-success" title="Approve Order"><i class="bi bi-check-lg"></i></button>
                                        </div>
                                    </td>
                                </tr>

                                <!-- Example 3: Processing (Blue / Info) -->
                                <tr>
                                    <td class="font-monospace fw-bold text-primary">ORD-2026-1003</td>
                                    <td>
                                        <div class="fw-semibold">Sarah Jenkins</div>
                                        <small class="text-muted">sarah.j@example.com</small>
                                    </td>
                                    <td class="small text-muted">Oct 06, 2026 02:40</td>
                                    <td class="text-center">3 items</td>
                                    <td class="text-end fw-bold">$249.98</td>
                                    <td class="text-center">
                                        <!-- Colored Badge: Blue for Processing -->
                                        <span class="badge bg-info text-dark px-3 py-2 fw-semibold">
                                            <i class="bi bi-gear-fill me-1"></i> Processing
                                        </span>
                                    </td>
                                    <td class="text-center">
                                        <div class="btn-group btn-group-sm">
                                            <button class="btn btn-outline-secondary" title="View Details"><i class="bi bi-eye"></i></button>
                                            <button class="btn btn-primary" title="Mark Shipped"><i class="bi bi-truck"></i></button>
                                        </div>
                                    </td>
                                </tr>

                                <!-- Example 4: Cancelled (Red) -->
                                <tr>
                                    <td class="font-monospace fw-bold text-primary">ORD-2026-1004</td>
                                    <td>
                                        <div class="fw-semibold">Robert Davis</div>
                                        <small class="text-muted">rdavis@example.org</small>
                                    </td>
                                    <td class="small text-muted">Oct 04, 2026 19:10</td>
                                    <td class="text-center">1 item</td>
                                    <td class="text-end fw-bold">$129.99</td>
                                    <td class="text-center">
                                        <!-- Colored Badge: Red for Cancelled -->
                                        <span class="badge bg-danger px-3 py-2 fw-semibold">
                                            <i class="bi bi-x-circle-fill me-1"></i> Cancelled
                                        </span>
                                    </td>
                                    <td class="text-center">
                                        <div class="btn-group btn-group-sm">
                                            <button class="btn btn-outline-secondary" title="View Details"><i class="bi bi-eye"></i></button>
                                            <button class="btn btn-outline-danger" title="Refund Log"><i class="bi bi-arrow-counterclockwise"></i></button>
                                        </div>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>

<jsp:include page="/fragments/footer.jsp" />

