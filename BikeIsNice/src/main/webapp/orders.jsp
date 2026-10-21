<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<c:set var="pageTitle" value="My Orders - BikeIsNice" scope="request" />
<jsp:include page="/fragments/header.jsp" />
<jsp:include page="/fragments/navbar.jsp" />

<main class="py-5">
    <div class="container">
        <!-- Header -->
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h2 class="fw-bold mb-1"><i class="bi bi-box-seam-fill me-2 text-primary"></i>My Order History</h2>
                <p class="text-muted small mb-0">Track shipments, verify purchase receipts, and review past cycling orders.</p>
            </div>
            <a href="<c:url value='/products' />" class="btn btn-outline-secondary btn-sm">
                <i class="bi bi-arrow-left me-1"></i> Continue Shopping
            </a>
        </div>

        <!-- Error Alert Message -->
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger alert-dismissible fade show shadow-sm" role="alert">
                <i class="bi bi-exclamation-triangle-fill me-2"></i>
                <c:out value="${errorMessage}" />
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>

        <!-- Selected Order Detailed View (if 'id' was requested) -->
        <c:if test="${not empty selectedOrder}">
            <div class="card border-primary border-2 shadow-sm rounded-3 mb-5">
                <div class="card-header bg-primary text-white d-flex justify-content-between align-items-center py-3">
                    <span class="fw-bold fs-5">
                        <i class="bi bi-receipt me-2"></i>Order Details: <c:out value="${selectedOrder.orderNumber}" />
                    </span>
                    <span class="badge bg-light text-primary fs-6 text-uppercase">
                        <c:out value="${selectedOrder.orderStatus}" />
                    </span>
                </div>
                <div class="card-body p-4">
                    <div class="row mb-4">
                        <div class="col-md-6">
                            <h6 class="text-secondary text-uppercase small fw-bold">Order Information</h6>
                            <p class="mb-1"><strong>Order ID:</strong> #<c:out value="${selectedOrder.orderId}" /></p>
                            <p class="mb-1"><strong>Status:</strong> <span class="badge bg-info text-dark"><c:out value="${selectedOrder.orderStatus}" /></span></p>
                            <p class="mb-1"><strong>Created At:</strong> <c:out value="${selectedOrder.createdAt}" /></p>
                        </div>
                        <div class="col-md-6 text-md-end">
                            <h6 class="text-secondary text-uppercase small fw-bold">Pricing Breakdown</h6>
                            <p class="mb-1">Subtotal: ₹<fmt:formatNumber value="${selectedOrder.subtotal}" minFractionDigits="2" maxFractionDigits="2" /></p>
                            <p class="mb-1 text-success">Discount: -₹<fmt:formatNumber value="${selectedOrder.discountAmount}" minFractionDigits="2" maxFractionDigits="2" /></p>
                            <p class="mb-1">Tax (GST): ₹<fmt:formatNumber value="${selectedOrder.taxAmount}" minFractionDigits="2" maxFractionDigits="2" /></p>
                            <h5 class="fw-bold text-primary mt-2">Total: ₹<fmt:formatNumber value="${selectedOrder.totalAmount}" minFractionDigits="2" maxFractionDigits="2" /></h5>
                        </div>
                    </div>

                    <h6 class="text-secondary text-uppercase small fw-bold mb-3">Purchased Items</h6>
                    <div class="table-responsive">
                        <table class="table table-bordered align-middle">
                            <thead class="table-light">
                                <tr>
                                    <th>Item</th>
                                    <th class="text-center">Quantity</th>
                                    <th class="text-end">Unit Price</th>
                                    <th class="text-end">Line Total</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${orderItems}" var="item">
                                    <c:set var="prod" value="${productMap[item.productId]}" />
                                    <tr>
                                        <td>
                                            <div class="fw-bold"><c:out value="${not empty prod ? prod.name : 'Product #'.concat(item.productId)}" /></div>
                                            <small class="text-muted">SKU: <c:out value="${not empty prod ? prod.sku : '-'}" /></small>
                                        </td>
                                        <td class="text-center"><c:out value="${item.quantity}" /></td>
                                        <td class="text-end">₹<fmt:formatNumber value="${item.unitPrice}" minFractionDigits="2" maxFractionDigits="2" /></td>
                                        <td class="text-end fw-bold">₹<fmt:formatNumber value="${item.totalPrice}" minFractionDigits="2" maxFractionDigits="2" /></td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </c:if>

        <!-- Orders Table List -->
        <c:choose>
            <c:when test="${not empty orders}">
                <div class="card border-0 shadow-sm rounded-3 overflow-hidden">
                    <div class="table-responsive">
                        <table class="table table-hover align-middle mb-0">
                            <thead class="table-light small text-uppercase text-secondary">
                                <tr>
                                    <th scope="col" class="py-3 ps-3">Order Number</th>
                                    <th scope="col" class="py-3">Date</th>
                                    <th scope="col" class="py-3 text-center">Status</th>
                                    <th scope="col" class="py-3 text-end">Items Subtotal</th>
                                    <th scope="col" class="py-3 text-end">Grand Total</th>
                                    <th scope="col" class="py-3 text-center pe-3">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${orders}" var="ord">
                                    <tr>
                                        <td class="ps-3 fw-bold text-dark">
                                            <i class="bi bi-bag-check text-primary me-2"></i>
                                            <c:out value="${ord.orderNumber}" />
                                        </td>
                                        <td class="small text-muted">
                                            <c:out value="${ord.createdAt}" />
                                        </td>
                                        <td class="text-center">
                                            <c:choose>
                                                <c:when test="${'delivered'.equalsIgnoreCase(ord.orderStatus)}">
                                                    <span class="badge bg-success text-uppercase">Delivered</span>
                                                </c:when>
                                                <c:when test="${'shipped'.equalsIgnoreCase(ord.orderStatus)}">
                                                    <span class="badge bg-primary text-uppercase">Shipped</span>
                                                </c:when>
                                                <c:when test="${'processing'.equalsIgnoreCase(ord.orderStatus)}">
                                                    <span class="badge bg-info text-dark text-uppercase">Processing</span>
                                                </c:when>
                                                <c:when test="${'cancelled'.equalsIgnoreCase(ord.orderStatus)}">
                                                    <span class="badge bg-danger text-uppercase">Cancelled</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-warning text-dark text-uppercase">Pending</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="text-end small">
                                            ₹<fmt:formatNumber value="${ord.subtotal}" minFractionDigits="2" maxFractionDigits="2" />
                                        </td>
                                        <td class="text-end fw-bold text-primary">
                                            ₹<fmt:formatNumber value="${ord.totalAmount}" minFractionDigits="2" maxFractionDigits="2" />
                                        </td>
                                        <td class="text-center pe-3">
                                            <a href="<c:url value='/orders?id=${ord.orderId}' />" class="btn btn-outline-primary btn-sm">
                                                <i class="bi bi-eye me-1"></i> View Receipt
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <div class="card border-0 shadow-sm rounded-4 p-5 text-center my-4">
                    <div class="my-4">
                        <i class="bi bi-box-seam text-muted display-1"></i>
                    </div>
                    <h3 class="fw-bold mb-2">No Orders Placed Yet</h3>
                    <p class="text-muted mb-4">You have not completed any purchases yet. Your confirmed orders will show here with live tracking updates.</p>
                    <div>
                        <a href="<c:url value='/products' />" class="btn btn-warning text-dark fw-bold px-4 py-2">
                            <i class="bi bi-bicycle me-2"></i> Start Shopping
                        </a>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</main>

<jsp:include page="/fragments/footer.jsp" />
