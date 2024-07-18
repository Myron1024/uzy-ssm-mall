<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="include/header.jsp" %>
<head>
    <link href="${pageContext.request.contextPath}/static/css/fore/fore_orderConfirmPage.css" rel="stylesheet"/>
    <title>Order Confirmation </title>
    <script>

    </script>
</head>
<body>
<nav>
    <%@ include file="include/navigator.jsp" %>
</nav>
<div class="header">
    <div id="mallLogo">
        <a href="${pageContext.request.contextPath}/"><img
                src="${pageContext.request.contextPath}/static/images/fore/WebsiteImage/logo-small2.png"></a>
    </div>
    <div class="shopSearchHeader">
        <form action="${pageContext.request.contextPath}/product" method="get">
            <div class="shopSearchInput">
                <input type="text" class="searchInput" name="product_name" placeholder="Search "
                       maxlength="50">
                <input type="submit" value="Search" class="searchBtn">
            </div>
        </form>
    </div>
</div>
<div class="headerLayout">
    <div class="headerContext">
        <ol class="header-extra">
            <li class="step-done">
                <div class="step-name">Product Purchased</div>
                <div class="step-no_first"></div>
                <div class="step-time">
                    <div class="step-time-wraper">${productOrder.productOrder_pay_date}</div>
                </div>
            </li>
            <li class="step-done">
                <div class="step-name">Pay to Alipay</div>
                <div class="step-no step-no-select"></div>
                <div class="step-time">
                    <div class="step-time-wraper">${productOrder.productOrder_pay_date}</div>
                </div>
            </li>
            <li class="step-done">
                <div class="step-name">Seller shipped</div>
                <div class="step-no step-no-select"></div>
                <div class="step-time">
                    <div class="step-time-wraper">${productOrder.productOrder_delivery_date}</div>
                </div>
            </li>
            <li class="step-no">
                <div class="step-name">Confirm</div>
                <div class="step-no">4</div>
            </li>
            <li class="step-no">
                <div class="step-name">Evaluate</div>
                <div class="step-no_last">5</div>
            </li>
        </ol>
    </div>
</div>
<div class="content">
    <h1>I have received the goods and agree to pay with Alipay</h1>
    <div class="order_info">
        <h2>Confirm Order Information</h2>
        <table class="table_order_orderItem">
            <thead>
            <tr>
                <th>Product</th>
                <th>Price</th>
                <th>Count</th>
                <th>Total</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${requestScope.productOrder.productOrderItemList}" var="orderItem" varStatus="i">
                <tr class="tr_product_info">
                    <td width="500px"><img
                            src="${orderItem.productOrderItem_product.singleProductImageList[0].productImage_src}"
                            style="width: 50px;height: 50px;"/><span class="span_product_name"><a
                            href="${pageContext.request.contextPath}/product/${orderItem.productOrderItem_product.product_id}"
                            target="_blank">${orderItem.productOrderItem_product.product_name}</a></span>
                    </td>
                    <td><span
                            class="span_product_sale_price">${orderItem.productOrderItem_product.product_sale_price}0</span>
                    </td>
                    <td><span class="span_productOrderItem_number">${orderItem.productOrderItem_number}</span></td>
                    <td><span class="span_productOrderItem_price"
                              style="font-weight: bold">${orderItem.productOrderItem_price}0</span></td>
                </tr>
            </c:forEach>
            <tr class="order-ft">
                <td colspan="4">
                    <div class="total-price">Real pay：$<strong>${requestScope.orderTotalPrice}0</strong></div>
                </td>
            </tr>
            </tbody>
            <tbody class="misc-info">
            <tr class="set-row">
                <td colspan="4"></td>
            </tr>
            <tr>
                <td colspan="4">
                    <span class="info_label">Order ID：</span>
                    <span class="info_value">${requestScope.productOrder.productOrder_code}</span>
                </td>
            </tr>
            <!-- <tr>
                <td colspan="4">
                    <span class="info_label">卖家商铺昵称：</span>
                    <span class="info_value">贤趣模拟旗舰店</span>
                </td>
            </tr> -->
            <tr>
                <td colspan="4">
                    <span class="info_label">Transaction time：</span>
                    <span class="info_value">${requestScope.productOrder.productOrder_pay_date}</span>
                </td>
            </tr>
            </tbody>
        </table>
        <div class="order-dashboard">
            <div class="bd">
                <ul>
                    <li>请收到货后，再确认收货！否则您可能钱货两空！</li>
                    <li class="message">Tip: This system will not conduct real transactions, please rest assured to test</li>
                </ul>
                <script>
                    function confirmOrder() {
                        var yn = confirm("After clicking confirm, the seller will receive the payment. Please be sure to confirm after receiving the goods!");
                        if (yn) {
                            $.ajax({
                                url: "/order/success/${requestScope.productOrder.productOrder_code}",
                                type: "PUT",
                                data: null,
                                dataType: "json",
                                success: function (data) {
                                    if (data.success) {
                                        location.href = "/order/success/${requestScope.productOrder.productOrder_code}";
                                    } else {
                                        alert("Order confirmation is abnormal, please try again later!");
                                        location.href = "/order/0/10";
                                    }
                                },
                                error: function (data) {
                                    alert("Order confirmation is abnormal, please try again later!");
                                    location.href = "/order/0/10";
                                }
                            });
                        }
                    }
                </script>
                <a href="javascript:void(0)" onclick="confirmOrder()">Confirm</a>
            </div>
        </div>
    </div>
</div>
<%@include file="include/footer_two.jsp" %>
<%@include file="include/footer.jsp" %>
</body>
