<%@ page contentType="text/html;charset=UTF-8" %>
<meta charset="utf-8"/>
<meta name="renderer" content="webkit"/>
<meta http-equiv="X-UA-Compatible" content="IE=Edge"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/fore/fore_nav.css"/>
<style>

#out{
  position:relative;float:left;cursor:pointer;width:50px;height:71px;
  }
 .personal-content{cursor:pointer;display:none;
   position:absolute;border:1px solid #ccc;box-sizing:border-box; width:235px;
 top:70px;background:#fff;box-shadow: 0px 2px 2px 0px rgba(173, 187, 200, 0.19);height:85px;
 padding:15px 0px;
 }
 .personal-account{
 width:150px;
 }
 .personal-content p{
   line-height:20px;
  margin-left:10px;
  font-size:12px; color:#333;
 }
  .headimg{
  margin-left:10px;margin-right: 4px; height: 39px; width: 39px;border-radius: 50px;float:left;
  }

   .hidep{
   width:100px;

   }
</style>
<div id="nav">
    <div class="nav_main">
        <p id="container_login">
            <c:choose>
                <c:when test="${requestScope.user.user_name==null}">
                    <em>Ding，Welcome to ELITE MALL</em>
                    <a href="${pageContext.request.contextPath}/login" style="color:#FA0808">Login</a>
                    <a href="${pageContext.request.contextPath}/register">Register</a>
                </c:when>
                <c:otherwise>
                    <em>Hi，</em>
                    <a href="${pageContext.request.contextPath}/userDetails" class="userName" target="_blank">${requestScope.user.user_name}</a>
                    <a href="${pageContext.request.contextPath}/login/logout">Log out</a>
                    <div id="out" style="display:none;"><img src='${pageContext.request.contextPath}/static/images/fore/WebsiteImage/images/tou.png' class='headimg' style="margin-top:18px;"></div>
                </c:otherwise>
            </c:choose>
        </p>
        <ul class="quick_li">
        <li class="quick_li_cart">
                <a href="${pageContext.request.contextPath}/">Home</a>
            </li>
            <li class="quick_li_MyTaobao">
                <div class="sn_menu">
                 <a href="${pageContext.request.contextPath}/order/0/10">Orders</a>
                </div>
            </li>
            <li class="quick_li_cart">
                <img src="${pageContext.request.contextPath}/static/images/fore/WebsiteImage/buyCar.png">
                <a href="${pageContext.request.contextPath}/order/cart">Cart</a>
            </li>
        </ul>
    </div>
</div>