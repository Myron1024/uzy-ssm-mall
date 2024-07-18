<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="include/header.jsp" %>
<head>
    <script src="${pageContext.request.contextPath}/static/js/fore/fore_register.js"></script>
    <link href="${pageContext.request.contextPath}/static/css/fore/fore_register.css" rel="stylesheet">
    <title>ELITE -- Register</title>
    <script>
        $(function () {
            $("span.address_province").text($("#select_order_address_province").find("option:selected").text());
            $("span.address_city").text($("#select_order_address_city").find("option:selected").text());
            $("span.address_district").text($("#select_order_address_district").find("option:selected").text());
        })
    </script>
    <style rel="stylesheet">
        #nav {
            width: auto;
            height: 32px;
            font-family: "Microsoft YaHei UI", Tahoma, serif;
            font-size: 12px;
            position: relative !important;
            background: #f2f2f2;
            z-index: 999;
            border-bottom: 1px solid #e5e5e5;
        }
    </style>
</head>
<body>
<nav>
    <div class="header">
        <div id="mallLogo">
            <a href="${pageContext.request.contextPath}/">
                <img src="${pageContext.request.contextPath}/static/images/fore/WebsiteImage/logo-small2.png">
                <span class="span_tmallRegister">Register</span></a>
        </div>
    </div>
</nav>
<div class="content">
    <div class="steps">
        <div class="steps_main">
            <span class="steps_tsl">Account Information</span>
        </div>
    </div>
    <div class="form-list">
<%--        <div class="form-item">--%>
<%--            <label class="form-label form-label-b tsls">设置会员名</label>--%>
<%--        </div>--%>
        <div class="form-item">
            <label class="form-label tsl">Username：</label>
            <input name="user_name" id="user_name" class="form-text err-input" maxlength="20">
            <span class="form_span"></span>
        </div>
<%--        <div class="form-item">--%>
<%--            <label class="form-label form-label-b tsls">设置登录密码</label>--%>
<%--            <label class="form-label tsl">登录时验证，保护账号信息</label>--%>
<%--        </div>--%>
        <div class="form-item">
            <label class="form-label tsl">Password：</label>
            <input name="user_password" type="password" id="user_password" class="form-text err-input" maxlength="20">
            <span class="form_span"></span>
        </div>
        <div class="form-item">
            <label class="form-label tsl">Confirm Password：</label>
            <input name="user_password_one" type="password" id="user_password_one" class="form-text err-input" maxlength="20">
            <span class="form_span"></span>
        </div>
<%--        <div class="form-item">--%>
<%--            <label class="form-label form-label-b tsls">填写基本信息</label>--%>
<%--        </div>--%>
        <div class="form-item">
            <label class="form-label tsl">Nickname：</label>
            <input name="user_nickname" id="user_nickname" class="form-text err-input" maxlength="20">
            <span class="form_span"></span>
        </div>
        <div class="form-item">
            <label class="form-label tsl">Sex：</label>
            <input name="user_gender" type="radio" id="form_radion" value="0" checked="checked">Male
            <input name="user_gender" type="radio" id="form_radions" value="1">Female
        </div>
        <div class="form-item">
            <label class="form-label tsl">Birthday：</label>
            <input type="date" name="user_birthday" id="user_birthday" class="form-text err-input"/>
            <span class="form_span"></span>
        </div>
        <div class="form-item">
            <label class="form-label tsl">Address：</label>
            <select class="selectpicker" id="select_user_address_province" data-size="8" data-live-search="true">
                <c:forEach items="${requestScope.addressList}" var="address" varStatus="i">
                    <option value="${address.address_areaId}"
                            <c:if test="${requestScope.addressId==address.address_areaId}">selected</c:if>>${address.address_name}</option>
                </c:forEach>
            </select>
            <select class="selectpicker" id="select_user_address_city" data-size="8" data-live-search="true">
                <c:forEach items="${requestScope.cityList}" var="address" varStatus="i">
                    <option value="${address.address_areaId}"
                            <c:if test="${requestScope.cityAddressId==address.address_areaId}">selected</c:if>>${address.address_name}</option>
                </c:forEach>
            </select>
            <select name="user_address" class="selectpicker" id="select_user_address_district" data-size="8"
                    data-live-search="true">
                <c:forEach items="${requestScope.districtList}" var="address" varStatus="i">
                    <option value="${address.address_areaId}"
                            <c:if test="${requestScope.districtAddressId==address.address_areaId}">selected</c:if>>${address.address_name}</option>
                </c:forEach>
            </select>
        </div>
        <div class="form-item">
            <input type="button" id="register_sub" class="btns btn-large tsl" value="Register"/>
        </div>
    </div>
</div>
<%@include file="include/footer_two.jsp" %>
<%@include file="include/footer.jsp" %>
<%--<link href="${pageContext.request.contextPath}/static/css/fore/fore_foot_special.css" rel="stylesheet"/>--%>
<div class="msg" style="display: none;">
    <span>Registration succeed, redirecting to login page</span>
</div>
</body>