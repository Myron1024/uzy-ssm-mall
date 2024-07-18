<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="include/header.jsp" %>
<head>
    <link href="${pageContext.request.contextPath}/static/css/fore/fore_orderList.css" rel="stylesheet"/>
    <title>My Orders</title>
    <script>
        function deleteOrder(orderCode){
            if (isNaN(orderCode) || orderCode === null) {
                return;
            }
            $("#modalDiv .modal-body").text('Are you sure to delete order：' + orderCode + ' ？');
            $("#modalDiv").modal();
            $("#btn-ok").click(function () {
                $.ajax({
                    url: "${pageContext.request.contextPath}/order/delete/" + orderCode,
                    type: "GET",
                    data: null,
                    dataType: "json",
                    success: function (data) {
                        if (data.success) {
                            $("#btn-close").click();
                            window.location.reload();
                        } else {
                            alert("Delete failed.");
                        }
                    },
                    beforeSend: function () {

                    },
                    error: function () {
                        alert("Cancel failed, please try again！");
                        location.href = "/order/0/10";
                    }
                });
            })
        }
        //关闭订单
        function closeOrder(orderCode) {
            if (isNaN(orderCode) || orderCode === null) {
                return;
            }
            $("#order_id_hidden").val(orderCode);
            $('#modalDiv').modal();
            $('#btn-ok').click(function () {
                $.ajax({
                    url: "${pageContext.request.contextPath}/order/close/" + $("#order_id_hidden").val(),
                    type: "PUT",
                    data: null,
                    dataType: "json",
                    success: function (data) {
                        if (data.success !== true) {
                            alert("The order processing is abnormal, please try again later!");
                        }
                        location.href = "/order/0/10";
                    },
                    beforeSend: function () {

                    },
                    error: function () {
                        alert("There was a problem canceling your order, please try again later!");
                        location.href = "/order/0/10";
                    }
                });
            });
        }

        function getPage(index) {
            var name = $(".tab_select").children("a").attr("name");
            if (name === undefined) {
                name = "";
            }
            location.href = "${pageContext.request.contextPath}/order/" + index + "/10" + "?" + name;
        }
    </script>
</head>
<body>
<nav>
    <%@ include file="include/navigator.jsp" %>
    <div class="header">
        <div id="mallLogo">
            <a href="${pageContext.request.contextPath}/"><img
                    src="${pageContext.request.contextPath}/static/images/fore/WebsiteImage/logo-small2.png"></a>
        </div>
        <div class="shopSearchHeader">
            <form action="${pageContext.request.contextPath}/product" method="get">
                <div class="shopSearchInput">
                    <input type="text" class="searchInput" name="product_name" placeholder="Search"
                           maxlength="50">
                    <input type="submit" value="Search" class="searchBtn">
                </div>
            </form>
            <ul>
                <c:forEach items="${requestScope.categoryList}" var="category" varStatus="i">
                    <li>
                            <%-- <a href="${pageContext.request.contextPath}/product?category_id=${category.category_id}">${category.category_name}</a> --%>
                    </li>
                </c:forEach>
            </ul>
        </div>
    </div>
</nav>
<div class="content">
    <ul class="tabs_ul">
        <li <c:if test="${requestScope.status == null}">class="tab_select"</c:if>>
            <a href="${pageContext.request.contextPath}/order/0/10">ALL</a>
        </li>
        <li <c:if test="${requestScope.status == 0}">class="tab_select"</c:if>>
            <a href="${pageContext.request.contextPath}/order/0/10?status=0" name="status=0">To Pay</a>
        </li>
        <li <c:if test="${requestScope.status == 1}">class="tab_select"</c:if>>
            <a href="${pageContext.request.contextPath}/order/0/10?status=1" name="status=1">To Ship</a>
        </li>
        <li <c:if test="${requestScope.status == 2}">class="tab_select"</c:if>>
            <a href="${pageContext.request.contextPath}/order/0/10?status=2" name="status=2">To Confirm</a>
        </li>
        <li <c:if test="${requestScope.status == 3}">class="tab_select"</c:if>>
            <a href="${pageContext.request.contextPath}/order/0/10?status=3" name="status=3">To Review</a>
        </li>
    </ul>
    <%@include file="include/page.jsp" %>
    <table class="table_orderList">
        <thead>
        <tr>
            <th>Product</th>
            <th width="80px">Price</th>
            <th width="80px">Amount</th>
            <th width="140px">Paid</th>
            <th width="140px">Status</th>
            <th width="140px">Actions</th>
        </tr>
        </thead>
        <c:choose>
            <c:when test="${requestScope.productOrderList != null && fn:length(requestScope.productOrderList)>0}">
                <c:forEach items="${requestScope.productOrderList}" var="productOrder">
                    <tbody>
                    <tr class="tr_order_info">
                        <td colspan="6">
                            <div class="span_order_title">
                                <span class="span_pay_date">${productOrder.productOrder_pay_date}</span>
                                <span class="span_order_code_title">Order ID:</span>
                                <span class="span_order_code" id="id_order_code">${productOrder.productOrder_code}</span>
                            </div>
                            <c:choose>
                                <c:when test="${productOrder.productOrder_status!=0}">
                                    <div class="span_order_delete">
                                        <button onclick="deleteOrder(${productOrder.productOrder_code})" class="btn btn-link">Delete</button>
                                    </div>
                                </c:when>
                            </c:choose>
                        </td>
                    </tr>
                    <c:forEach items="${productOrder.productOrderItemList}" var="productOrderItem" varStatus="i">
                        <tr class="tr_orderItem_info">
                            <td><img class="orderItem_product_image"
                                     src="${productOrderItem.productOrderItem_product.singleProductImageList[0].productImage_src}"
                                     style="width: 80px;height: 80px;"/><span class="orderItem_product_name"><a
                                    href="${pageContext.request.contextPath}/product/${productOrderItem.productOrderItem_product.product_id}">${productOrderItem.productOrderItem_product.product_name}</a></span>
                            </td>
                            <td><span
                                    class="orderItem_product_price">$${productOrderItem.productOrderItem_price/productOrderItem.productOrderItem_number}</span>
                            </td>
                            <td><span
                                    class="orderItem_product_number">${productOrderItem.productOrderItem_number}</span>
                            </td>
                            <td class="td_order_content"><span
                                    class="orderItem_product_realPrice">$${productOrderItem.productOrderItem_price}</span>
                            </td>
                            <c:if test="${i.count == 1}">
                                <c:choose>
                                    <c:when test="${productOrder.productOrder_status==0}">
                                        <td class="td_order_content"
                                            rowspan="${fn:length(requestScope.productOrderItemList)}">
                                            <span class="span_order_status" title="To Pay">To Pay</span>
                                        </td>
                                        <td class="td_order_content"
                                            rowspan="${fn:length(requestScope.productOrderItemList)}">
                                            <a class="order_btn pay_btn"
                                               href="${pageContext.request.contextPath}/order/pay/${productOrder.productOrder_code}">Pay</a>
                                            <p class="order_close"><a class="order_close" href="javascript:void(0)"
                                                                      onclick="closeOrder('${productOrder.productOrder_code}')">Cancel</a>
                                            </p>
                                        </td>
                                    </c:when>
                                    <c:when test="${productOrder.productOrder_status==1}">
                                        <td class="td_order_content"
                                            rowspan="${fn:length(requestScope.productOrderItemList)}">
                                            <span class="span_order_status" title="To Ship">To Ship</span>
                                        </td>
                                        <td class="td_order_content"
                                            rowspan="${fn:length(requestScope.productOrderItemList)}">
                                            <a class="order_btn delivery_btn"
                                               href="${pageContext.request.contextPath}/order/delivery/${productOrder.productOrder_code}">Remind of delivery</a>
                                        </td>
                                    </c:when>
                                    <c:when test="${productOrder.productOrder_status==2}">
                                        <td class="td_order_content"
                                            rowspan="${fn:length(requestScope.productOrderItemList)}">
                                            <span class="span_order_status" title="To Confirm">To Confirm</span>
                                        </td>
                                        <td class="td_order_content"
                                            rowspan="${fn:length(requestScope.productOrderItemList)}">
                                            <a class="order_btn confirm_btn"
                                               href="${pageContext.request.contextPath}/order/confirm/${productOrder.productOrder_code}">Confirm</a>
                                        </td>
                                    </c:when>
                                    <c:when test="${productOrder.productOrder_status==3}">
                                        <td class="td_order_content"
                                            rowspan="${fn:length(requestScope.productOrderItemList)}">
                                            <span class="span_order_status" title="Order Finished">Order Finished</span>
                                        </td>
                                    </c:when>
                                    <c:otherwise>
                                        <td class="td_order_content"
                                            rowspan="${fn:length(requestScope.productOrderItemList)}">
                                            <span class="td_error" title="Order Closed">Order Closed</span>
                                        </td>
                                        <td class="td_order_content"
                                            rowspan="${fn:length(requestScope.productOrderItemList)}">
                                        </td>
                                    </c:otherwise>
                                </c:choose>
                            </c:if>
                            <c:if test="${productOrder.productOrder_status==3 && productOrderItem.isReview != null && !productOrderItem.isReview}">
                                <td class="td_order_content">
                                    <a class="order_btn review_btn"
                                       href="${pageContext.request.contextPath}/review/${productOrderItem.productOrderItem_id}">Evaluate</a>
                                </td>
                            </c:if>
                        </tr>
                    </c:forEach>
                    </tbody>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <tbody>
                <tr>
                    <td colspan="6" class="no_search_result"><img
                            src="${pageContext.request.contextPath}/static/images/fore/WebsiteImage/find.jpg" height="200"
                            width="200"/><span
                            class="error_msg">No matches，Please try other search criteria.</span></td>
                </tr>
                </tbody>
            </c:otherwise>
        </c:choose>
    </table>
    <%@include file="include/page.jsp" %>
</div>
<%-- 模态框 --%>
<div class="modal fade" id="modalDiv" tabindex="-1" role="dialog" aria-labelledby="modalDiv" aria-hidden="true"
     data-backdrop="static">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="myModalLabel">Tip</h4>
            </div>
            <div class="modal-body">Are you sure you want to cancel this order? Once an order is canceled, it cannot be restored.</div>
            <div class="modal-footer">
                <button type="submit" class="btn btn-primary" id="btn-ok">Yes</button>
                <button type="button" class="btn btn-default" data-dismiss="modal" id="btn-close">Close</button>
                <input type="hidden" id="order_id_hidden">
            </div>
        </div>
        <%-- /.modal-content --%>
    </div>
    <%-- /.modal --%>
</div>
<%@include file="include/footer_two.jsp" %>
<%@include file="include/footer.jsp" %>
</body>
