<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="include/header.jsp" %>
<head>
    <script src="${pageContext.request.contextPath}/static/js/fore/fore_productBuyCar.js"></script>
    <link href="${pageContext.request.contextPath}/static/css/fore/fore_productBuyCarPage.css" rel="stylesheet"/>
    <title>Cart</title>
    <script>
        $(function () {
            $('#btn-ok').click(function () {
                $.ajax({
                    url: "${pageContext.request.contextPath}/order/orderItem/" + $("#order_id_hidden").val(),
                    type: "DELETE",
                    data: null,
                    dataType: "json",
                    success: function (data) {
                        if (data.success !== true) {
                            alert("The shopping cart item deletion was abnormal, please try again later!");
                        }
                        location.href = "/order/cart";
                    },
                    beforeSend: function () {

                    },
                    error: function () {
                        alert("The shopping cart item deletion was abnormal, please try again later!");
                        location.href = "/order/cart";
                    }
                });
            });
        });

        function removeItem(orderItem_id) {
            if (isNaN(orderItem_id) || orderItem_id === null) {
                return;
            }
            $("#order_id_hidden").val(orderItem_id);
            $('#modalDiv').modal();
        }
    </script>
</head>
<body>
<nav>
    <%@ include file="include/navigator.jsp" %>
    <div class="header">
        <div id="mallLogo">
            <a href="${pageContext.request.contextPath}/"><img
                    src="${pageContext.request.contextPath}/static/images/fore/WebsiteImage/logo-small2.png"><span
                    class="span_tmallBuyCar">Cart</span></a>
        </div>
        <div class="shopSearchHeader">
            <form action="${pageContext.request.contextPath}/product" method="get">
                <div class="shopSearchInput">
                    <input type="text" class="searchInput" name="product_name" placeholder="Search "
                           value="${requestScope.searchValue}" maxlength="50">
                    <input type="submit" value="Search" class="searchBtn">
                </div>
            </form>
            <ul>
                <c:forEach items="${requestScope.categoryList}" var="category" varStatus="i">
                    <li>
                        <a href="${pageContext.request.contextPath}/product?category_id=${category.category_id}">${category.category_name}</a>
                    </li>
                </c:forEach>
            </ul>
        </div>
    </div>
</nav>
<div class="content">
    <c:choose>
        <c:when test="${fn:length(requestScope.orderItemList)<=0}">
            <div id="crumbs">
            </div>
            <div id="empty">
                <h2>Your shopping cart is still empty, take action now! You can:</h2>
                <ul>
                    <li>看看<a href="${pageContext.request.contextPath}/order">已买到的宝贝</a></li>
                </ul>
            </div>
        </c:when>
        <c:otherwise>
            <div id="J_FilterBar">
                <ul id="J_CartSwitch">
                    <li>
                        <a href="${pageContext.request.contextPath}/order/cart" class="J_MakePoint">
                            <em>All product</em>
                        </a>
                    </li>
                </ul>
                <div class="wrap-line">
                    <div class="floater"></div>
                </div>
            </div>
            <table id="J_CartMain">
                <thead>
                <tr>
                    <th class="selectAll_th"><input type="checkbox" class="cbx_select" id="cbx_select_all"><label
                            for="cbx_select_all">Select</label></th>
                    <th width="474px" class="productInfo_th"><span>Product information</span></th>
                    <th width="120px"><span>Price</span></th>
                    <th width="120px"><span>Count</span></th>
                    <th width="120px"><span>Amount</span></th>
                    <th width="84px"><span>Actions</span></th>
                    <th hidden>ID</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${requestScope.orderItemList}" var="orderItem">
                    <tr class="orderItem_category">
                    </tr>
                    <tr class="orderItem_info">
                        <td class="tbody_checkbox"><input type="checkbox" class="cbx_select"
                                                          id="cbx_orderItem_select_${orderItem.productOrderItem_id}"
                                                          name="orderItem_id"><label
                                for="cbx_orderItem_select_${orderItem.productOrderItem_id}"></label></td>
                        <td>
                            <img class="orderItem_product_image"
                                 src="${orderItem.productOrderItem_product.singleProductImageList[0].productImage_src}"
                                 style="width: 80px;height: 80px;"/>
                            <span class="orderItem_product_name">
                                <a href="${pageContext.request.contextPath}/product/${orderItem.productOrderItem_product.product_id}">${orderItem.productOrderItem_product.product_name}</a>
                            </span>
                        </td>
                        <td><span
                                class="orderItem_product_price">$${orderItem.productOrderItem_price/orderItem.productOrderItem_number}</span>
                        </td>
                        <td>
                            <div class="item_amount">
                                <a href="javascript:void(0)" onclick="up(this)"
                                   class="J_Minus <c:if test="${orderItem.productOrderItem_number<=1}">no_minus</c:if>">-</a>
                                <input type="text" value="${orderItem.productOrderItem_number}"/>
                                <a href="javascript:void(0)" onclick="down(this)" class="J_Plus">+</a>
                            </div>
                        </td>
                        <td>
                            <span class="orderItem_product_realPrice">$${orderItem.productOrderItem_price}</span>
                        </td>
                        <td><a href="javascript:void(0)" onclick="removeItem('${orderItem.productOrderItem_id}')"
                               class="remove_order">Delete</a></td>
                        <td>
                            <input type="hidden" class="input_orderItem" name="${orderItem.productOrderItem_id}"/>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <div id="J_FloatBar">
                <div id="J_SelectAll2">
                    <div class="cart_checkbox">
                        <input class="J_checkboxShop" id="J_SelectAllCbx2" type="checkbox" value="true"/>
                        <label for="J_SelectAllCbx2" title="Select ALL"></label>
                    </div>
                    <span class="span_selectAll">&nbsp;Select</span>
                </div>
                <div class="operations">
                    <a href="javascript:void(0)" onclick="remove()">Delete</a>
                </div>
                <div class="float-bar-right">
                    <div id="J_ShowSelectedItems">
                        <span class="txt">Selected</span>
                        <em id="J_SelectedItemsCount">0</em>
                        <span class="txt">items</span>
                    </div>
                    <div class="price_sum">
                        <span class="txt">Total:</span>
                        <strong class="price">
                            <em id="J_Total">
                                <span class="total_symbol">&nbsp;  $</span>
                                <span class="total_value"> 0.00</span>
                            </em>
                        </strong>
                    </div>
                    <div class="btn_area">
                        <a href="javascript:void(0)" id="J_Go" onclick="create(this)">
                            <span>Check Out</span>
                        </a>
                    </div>
                </div>
            </div>
        </c:otherwise>
    </c:choose>
</div>
<%-- 模态框 --%>
<div class="modal fade" id="modalDiv" tabindex="-1" role="dialog" aria-labelledby="modalDiv" aria-hidden="true"
     data-backdrop="static">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="myModalLabel">Tip</h4>
            </div>
            <div class="modal-body">Are you sure you want to cancel this item?</div>
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
