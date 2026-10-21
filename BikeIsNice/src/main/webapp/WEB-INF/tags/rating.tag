<%@ tag language="java" pageEncoding="UTF-8" description="Star-based rating visualizer component" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ attribute name="value" type="java.lang.Double" required="false" description="Numeric rating value (e.g. 4.5)" %>
<%@ attribute name="max" type="java.lang.Integer" required="false" description="Maximum number of stars, defaults to 5" %>

<c:set var="ratingVal" value="${not empty value ? value : 4.5}" />
<c:set var="maxStars" value="${not empty max ? max : 5}" />

<div class="d-inline-flex align-items-center gap-1 rating-stars" title="Rated ${ratingVal} out of ${maxStars}">
    <c:forEach var="i" begin="1" end="${maxStars}">
        <c:choose>
            <c:when test="${ratingVal ge i}">
                <i class="bi bi-star-fill text-warning" style="font-size: 0.85rem;"></i>
            </c:when>
            <c:when test="${ratingVal ge (i - 0.5)}">
                <i class="bi bi-star-half text-warning" style="font-size: 0.85rem;"></i>
            </c:when>
            <c:otherwise>
                <i class="bi bi-star text-warning" style="font-size: 0.85rem;"></i>
            </c:otherwise>
        </c:choose>
    </c:forEach>
    <span class="text-muted small ms-1" style="font-size: 0.8rem;">
        (<c:out value="${ratingVal}" />)
    </span>
</div>

