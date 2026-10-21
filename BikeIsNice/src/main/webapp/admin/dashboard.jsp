<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<c:set var="pageTitle" value="Admin Dashboard - BikeIsNice" scope="request" />
<jsp:include page="/fragments/header.jsp" />
<jsp:include page="/fragments/navbar.jsp" />

<main class="py-4">
    <div class="container-fluid px-lg-5">
        <div class="d-flex justify-content-between align-items-center mb-4 pb-2 border-bottom">
            <div>
                <h2 class="fw-bold mb-1"><i class="bi bi-speedometer2 me-2 text-danger"></i>Manager Dashboard</h2>
                <p class="text-muted small mb-0">Overview of bike sales, warehouse fleet inventory alerts, and orders.</p>
            </div>
            <div>
                <span class="badge bg-danger-subtle text-danger px-3 py-2 fw-semibold">
                    <i class="bi bi-shield-check me-1"></i> Admin Role Verified
                </span>
            </div>
        </div>

        <div class="row g-4">
            <!-- Left: Admin Navigation Sidebar -->
            <div class="col-lg-3 col-xl-2">
                <jsp:include page="/admin/sidebar.jsp" />
            </div>

            <!-- Right: Dashboard Analytics & Tables -->
            <div class="col-lg-9 col-xl-10">
                <!-- High-Level Metric Cards -->
                <div class="row g-3 mb-4">
                    <!-- Total Sales Metric Card -->
                    <div class="col-sm-6 col-xl-3">
                        <div class="card border-0 shadow-sm rounded-3 p-3 bg-white h-100">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <span class="text-muted small text-uppercase fw-bold">Total Sales</span>
                                    <h3 class="fw-bold mb-0 mt-1 text-dark">$48,920.50</h3>
                                    <small class="text-success"><i class="bi bi-arrow-up-right me-1"></i>+12.4% this month</small>
                                </div>
                                <div class="bg-primary-subtle text-primary p-3 rounded-circle">
                                    <i class="bi bi-currency-dollar fs-4"></i>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Active Users Metric Card -->
                    <div class="col-sm-6 col-xl-3">
                        <div class="card border-0 shadow-sm rounded-3 p-3 bg-white h-100">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <span class="text-muted small text-uppercase fw-bold">Active Riders</span>
                                    <h3 class="fw-bold mb-0 mt-1 text-dark">1,428</h3>
                                    <small class="text-primary"><i class="bi bi-people me-1"></i>Verified Cyclists</small>
                                </div>
                                <div class="bg-info-subtle text-info p-3 rounded-circle">
                                    <i class="bi bi-bicycle fs-4"></i>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Total Orders Metric Card -->
                    <div class="col-sm-6 col-xl-3">
                        <div class="card border-0 shadow-sm rounded-3 p-3 bg-white h-100">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <span class="text-muted small text-uppercase fw-bold">Total Orders</span>
                                    <h3 class="fw-bold mb-0 mt-1 text-dark">384</h3>
                                    <small class="text-warning"><i class="bi bi-clock-history me-1"></i>12 Pending Dispatch</small>
                                </div>
                                <div class="bg-warning-subtle text-warning p-3 rounded-circle">
                                    <i class="bi bi-box-seam-fill fs-4"></i>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Low Stock Alerts Metric Card -->
                    <div class="col-sm-6 col-xl-3">
                        <div class="card border-0 shadow-sm rounded-3 p-3 bg-white h-100">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <span class="text-muted small text-uppercase fw-bold">Low-Stock Alerts</span>
                                    <h3 class="fw-bold mb-0 mt-1 text-danger">3 Models</h3>
                                    <small class="text-danger"><i class="bi bi-exclamation-triangle me-1"></i>Action Required</small>
                                </div>
                                <div class="bg-danger-subtle text-danger p-3 rounded-circle">
                                    <i class="bi bi-graph-down-arrow fs-4"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Responsive Low-Stock View Table -->
                <div class="card border-0 shadow-sm rounded-3 overflow-hidden mb-4">
                    <div class="card-header bg-white py-3 d-flex justify-content-between align-items-center">
                        <h5 class="fw-bold mb-0 text-danger d-flex align-items-center gap-2">
                            <i class="bi bi-exclamation-octagon-fill"></i> Low-Stock Fleet Inventory Monitor
                        </h5>
                        <span class="badge bg-danger text-white">Threshold: &le; 15 Units</span>
                    </div>

                    <div class="table-responsive">
                        <table class="table table-hover align-middle mb-0">
                            <thead class="table-light small text-uppercase text-secondary">
                                <tr>
                                    <th scope="col">SKU</th>
                                    <th scope="col">Bike / Component</th>
                                    <th scope="col">Category</th>
                                    <th scope="col" class="text-center">Current Stock</th>
                                    <th scope="col" class="text-end">Price</th>
                                    <th scope="col" class="text-center">Status</th>
                                    <th scope="col" class="text-center">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td class="font-monospace fw-bold">BIKE-EBK-003</td>
                                    <td>
                                        <div class="fw-semibold">VoltDrive Commuter E-Bike 750W</div>
                                        <small class="text-muted">48V 14Ah removable battery with 45-mile pedal assist</small>
                                    </td>
                                    <td>Electric Bikes (E-Bikes)</td>
                                    <td class="text-center">
                                        <span class="badge bg-warning text-dark px-2 py-1 fs-6">8 Units</span>
                                    </td>
                                    <td class="text-end fw-semibold">$1,499.00</td>
                                    <td class="text-center">
                                        <span class="badge bg-success-subtle text-success">Active</span>
                                    </td>
                                    <td class="text-center">
                                        <button class="btn btn-outline-primary btn-sm px-3">
                                            <i class="bi bi-plus-circle me-1"></i> Restock
                                        </button>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="font-monospace fw-bold">BIKE-MTB-002</td>
                                    <td>
                                        <div class="fw-semibold">TrailBlazer Full-Suspension 29er MTB</div>
                                        <small class="text-muted">150mm air travel, hydraulic disc brakes, 1x12 drivetrain</small>
                                    </td>
                                    <td>Mountain Bikes (MTB)</td>
                                    <td class="text-center">
                                        <span class="badge bg-warning text-dark px-2 py-1 fs-6">12 Units</span>
                                    </td>
                                    <td class="text-end fw-semibold">$1,899.00</td>
                                    <td class="text-center">
                                        <span class="badge bg-success-subtle text-success">Active</span>
                                    </td>
                                    <td class="text-center">
                                        <button class="btn btn-outline-primary btn-sm px-3">
                                            <i class="bi bi-plus-circle me-1"></i> Restock
                                        </button>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="font-monospace fw-bold">BIKE-ACC-009</td>
                                    <td>
                                        <div class="fw-semibold">PhotonBeast 1200LM Bike Light Set</div>
                                        <small class="text-muted">IPX6 waterproof USB-C rechargeable headlight &amp; taillight</small>
                                    </td>
                                    <td>Cycling Gear &amp; Accessories</td>
                                    <td class="text-center">
                                        <span class="badge bg-danger text-white px-2 py-1 fs-6">4 Units</span>
                                    </td>
                                    <td class="text-end fw-semibold">$69.99</td>
                                    <td class="text-center">
                                        <span class="badge bg-danger-subtle text-danger">Critical</span>
                                    </td>
                                    <td class="text-center">
                                        <button class="btn btn-danger btn-sm px-3">
                                            <i class="bi bi-arrow-repeat me-1"></i> Urgent Order
                                        </button>
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

