<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <script>
        $(function () {
            if ($("#details_category_id").val() === "") {
                $("#btn_category_save").click(function () {
                    var category_name = $.trim($("#input_category_name").val());
                    var category_image_src = $.trim($("#pic_category").attr("src"));
                    var yn = true;
                   /* if (category_image_src === "" || category_image_src === undefined) {
                        yn = false;
                        $("#btn-ok").unbind("click").click(function () {
                            $("#modalDiv").modal("hide");
                        });
                        $(".modal-body").text("请上传分类图片！");
                        $('#modalDiv').modal();
                    }*/
                    if (category_name === "") {
                        styleUtil.basicErrorShow($("#lbl_category_name"));
                        yn = false;
                    }
                    if (!yn) {
                        return;
                    }

                    var dataList = {
                        "category_name": category_name,
                        "category_image_src": category_image_src
                    };
                    doAction(dataList, "admin/category", "POST");
                });
            } else {
                $("#span_category_id").text('${requestScope.category.category_id}');
                if ($("#pic_category").attr("src") === undefined) {
                    $(".details_picList_fileUpload").css("display", "inline-block");
                } else {
                    $(".details_picList_fileUpload").css("display", "none");
                }
                $("#btn_category_save").click(function () {
                    var category_id = $("#details_category_id").val();
                    var category_name = $.trim($("#input_category_name").val());
                    var category_image_src = $.trim($("#pic_category").attr("src"));

                    var yn = true;
                    /*if (category_image_src === "") {
                        yn = false;
                        $("#btn-ok").unbind("click").click(function () {
                            $("#modalDiv").modal("hide");
                        });
                        $(".modal-body").text("请上传分类图片！");
                        $('#modalDiv').modal();
                    }*/
                    if (category_name === "") {
                        styleUtil.basicErrorShow($("#lbl_category_name"));
                        yn = false;
                    }
                    if (!yn) {
                        return;
                    }

                    var dataList = {
                        "category_name": category_name,
                        "category_image_src": category_image_src
                    };
                    doAction(dataList, "admin/category/" + category_id, "PUT");
                });
            }

            $(".details_picList").on("click", "li:not(.details_picList_fileUpload)", function () {
                var img = $(this);
                var fileUploadInput = $(this).parents("ul").children(".details_picList_fileUpload");
                $("#btn-ok").unbind("click").click(function () {
                    img.remove();
                    fileUploadInput.css("display", "inline-block");
                    $('#modalDiv').modal("hide");
                });
                $(".modal-body").text("Are you sure you want to delete this category image?");
                $('#modalDiv').modal();
            });
            $("#btn_category_cancel").click(function () {
                $(".menu_li[data-toggle=category]").click();
            });
            $("input:text").focus(function () {
                styleUtil.basicErrorHide($(this).prev("label"));
            });
        });

        function uploadImage(fileDom) {
            var file = fileDom.files[0];
            var imageType = /^image\//;
            if (file === undefined || !imageType.test(file.type)) {
                $("#btn-ok").unbind("click").click(function () {
                    $("#modalDiv").modal("hide");
                });
                $(".modal-body").text("请选择图片！");
                $('#modalDiv').modal();
                return;
            }
            if (file.size > 512000) {
                $("#btn-ok").unbind("click").click(function () {
                    $("#modalDiv").modal("hide");
                });
                $(".modal-body").text("图片大小不能超过500K！");
                $('#modalDiv').modal();
                return;
            }
            $(fileDom).val('');
            var formData = new FormData();
            formData.append("file", file);
            $.ajax({
                url: "/admin/uploadCategoryImage",
                type: "post",
                data: formData,
                contentType: false,
                processData: false,
                dataType: "json",
                mimeType: "multipart/form-data",
                success: function (data) {
                    $(fileDom).attr("disabled", false).prev("span").text("Upload Image");
                    if (data.success) {
                        $(fileDom).parent('.details_picList_fileUpload').before("<li><img src='${pageContext.request.contextPath}/static/images/store/" + data.fileName + "' id='pic_category'  width='1190px' height='150px'/></li>").css("display", "none");
                    } else {
                        alert("Image upload error！");
                    }
                },
                beforeSend: function () {
                    $(fileDom).attr("disabled", true).prev("span").text("Uploading...");
                },
                error: function () {

                }
            });
        }

        //分类操作
        function doAction(dataList, url, type) {
            $.ajax({
                url: url,
                type: type,
                data: dataList,
                dataType: "json",
                traditional: true,
                success: function (data) {
                    $("#btn_category_save").attr("disabled", false).val("Save");
                    if (data.success) {
                        $("#btn-ok,#btn-close").unbind("click").click(function () {
                            $('#modalDiv').modal("hide");
                            setTimeout(function () {
                                //ajax请求页面
                                ajaxUtil.getPage("category/" + data.category_id, null, true);
                            }, 170);
                        });
                        $(".modal-body").text("Save Succeed!");
                        $('#modalDiv').modal();
                    }
                },
                beforeSend: function () {
                    $("#btn_product_save").attr("disabled", true).val("Saving...");
                },
                error: function () {

                }
            });
        }
    </script>
    <style rel="stylesheet">
        .details_property_list {

        }

        .details_property_list > li {
            list-style: none;
            padding: 5px 0;
        }

        div.br {
            height: 20px;
        }
    </style>
</head>
<body>
<div class="details_div_first">
    <input type="hidden" value="${requestScope.category.category_id}" id="details_category_id"/>
    <div class="frm_div">
        <label class="frm_label text_info" id="lbl_category_id">Category ID</label>
        <span class="details_value" id="span_category_id">System Generation</span>
    </div>
    <div class="frm_div">
        <label class="frm_label text_info" id="lbl_category_name" for="input_category_name">Category Name</label>
        <input class="frm_input" id="input_category_name" type="text" maxlength="50"
               value="${requestScope.category.category_name}"/>
    </div>
</div>
<div class="details_div">
    <span class="details_title text_info">Category Image</span>
    <ul class="details_picList" id="category_list">
        <c:if test="${requestScope.category.category_image_src != null}">
            <li><img src="${requestScope.category.category_image_src}"
                    id="pic_category" width="300px" height="435px"/></li>
        </c:if>
        <li class="details_picList_fileUpload">
            <svg class="icon" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg" p-id="1528"
                 width="40" height="40">
                <path d="M0 512C0 229.230208 229.805588 0 512 0 794.769792 0 1024 229.805588 1024 512 1024 794.769792 794.194412 1024 512 1024 229.230208 1024 0 794.194412 0 512Z"
                      p-id="1529" fill="#FF7874"></path>
                <path d="M753.301333 490.666667l-219.946667 0L533.354667 270.741333c0-11.776-9.557333-21.333333-21.354667-21.333333-11.776 0-21.333333 9.536-21.333333 21.333333L490.666667 490.666667 270.72 490.666667c-11.776 0-21.333333 9.557333-21.333333 21.333333 0 11.797333 9.557333 21.354667 21.333333 21.354667L490.666667 533.354667l0 219.904c0 11.861333 9.536 21.376 21.333333 21.376 11.797333 0 21.354667-9.578667 21.354667-21.333333l0-219.946667 219.946667 0c11.754667 0 21.333333-9.557333 21.333333-21.354667C774.634667 500.224 765.077333 490.666667 753.301333 490.666667z"
                      p-id="1530" fill="#FFFFFF"></path>
            </svg>
            <span>Click to upload</span>
            <input type="file" onchange="uploadImage(this)" accept="image/*">
        </li>
    </ul>
    <span class="frm_error_msg" id="text_category_image_details_msg"></span>
</div>
<div class="details_div details_div_last">
    <c:if test="${fn:length(requestScope.category.propertyList)!=0}">
        <span class="details_title text_info">Attributes</span>
        <c:forEach items="${requestScope.category.propertyList}" var="property" varStatus="status">
            <c:choose>
                <c:when test="${status.index % 2 == 0}">
                    <input class="frm_input" id="input_category_property_${property.property_id}" type="text"
                           maxlength="50" value="${property.property_name}"
                           data-pvid="${property.property_id}"/>
                </c:when>
                <c:otherwise>
                    <input class="frm_input" id="input_category_property_${property.property_id}" type="text"
                           maxlength="50" value="${property.property_name}"
                           data-pvid="${property.property_id}"/>
                    <div class="br"></div>
                </c:otherwise>
            </c:choose>
        </c:forEach>
    </c:if>
</div>
<div class="details_tools_div">
    <input class="frm_btn" id="btn_category_save" type="button" value="Save"/>
    <input class="frm_btn frm_clear" id="btn_category_cancel" type="button" value="Cancel"/>
</div>

<%-- 模态框 --%>
<div class="modal fade" id="modalDiv" tabindex="-1" role="dialog" aria-labelledby="modalDiv" aria-hidden="true"
     data-backdrop="static">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="myModalLabel">Tip</h4>
            </div>
            <div class="modal-body">Are you sure you want to delete this category image?</div>
            <div class="modal-footer">
                <button type="submit" class="btn btn-primary" id="btn-ok">OK</button>
                <button type="button" class="btn btn-default" data-dismiss="modal" id="btn-close">Close</button>
            </div>
        </div>
        <%-- /.modal-content --%>
    </div>
    <%-- /.modal --%>
</div>
<div class="loader"></div>
</body>
</html>
