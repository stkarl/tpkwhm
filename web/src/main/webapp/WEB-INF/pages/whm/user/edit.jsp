<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>


<head>
    <title><fmt:message key="whm.user"/></title>
    <meta name="heading" content="<fmt:message key="whm.user"/>"/>
</head>
<c:url var="url" value="/whm/user/edit.html"/>
<c:url var="backUrl" value="/whm/user/list.html"/>
<form:form commandName="item" action="${url}" method="post" id="itemForm" class="form-horizontal" novalidate="novalidate">

    <div id="container-fluid data_content_box">
        <div class="row-fluid data_content">
            <div class="content-header">
                <c:choose>
                    <c:when test="${not empty item.pojo.userID}">
                        <fmt:message key="whm.user.edit"/>
                    </c:when>
                    <c:otherwise>
                        <fmt:message key="whm.user.new"/>
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="clear"></div>
            <c:if test="${!empty errorMessage}">
                <div class="alert alert-error">
                    <a class="close" data-dismiss="alert" href="#">x</a>
                        ${errorMessage}
                </div>
                <div style="clear:both;"></div>
            </c:if>
            <c:if test="${!empty successMessage}">
                <div class="alert alert-success">
                    <a class="close" data-dismiss="alert" href="#">x</a>
                        ${successMessage}
                </div>
                <div style="clear:both;"></div>
            </c:if>

            <div class="row-fluid">
                <div class="pane_info">
                    <div class="pane_title"><fmt:message key="whm.user.info"/></div>
                    <div class="pane_content">
                        <div class="control-group">
                            <label class="control-label">
                                <fmt:message key="label.username"/>
                            </label>
                            <div class="controls">
                                <form:input path="pojo.userName" cssClass="required nohtml nameValidate" size="50"/>
                                <form:errors path="pojo.userName" cssClass="error-inline-validate"/>
                            </div>

                            <label class="control-label">
                                <fmt:message key="label.password"/>
                            </label>
                            <div class="controls">
                                <form:password path="pojo.password" cssClass="nohtml nameValidate" size="50"/>
                                <form:errors path="pojo.password" cssClass="error-inline-validate"/>
                            </div>

                            <label class="control-label">
                                <fmt:message key="label.fullname"/>
                            </label>
                            <div class="controls">
                                <form:input path="pojo.fullname" cssClass="required nohtml nameValidate" size="50"/>
                                <form:errors path="pojo.fullname" cssClass="error-inline-validate"/>
                            </div>
                            <label class="control-label">
                                <fmt:message key="label.usercode"/>
                            </label>
                            <div class="controls">
                                <form:input path="pojo.userCode" size="50"/>
                                <form:errors path="pojo.userCode" cssClass="error-inline-validate"/>
                            </div>

                            <label class="control-label">
                                <fmt:message key="label.phone"/>
                            </label>
                            <div class="controls">
                                <form:input path="pojo.phone" size="50"/>
                                <form:errors path="pojo.phone" cssClass="error-inline-validate"/>
                            </div>

                            <label class="control-label">
                                <fmt:message key="label.email"/>
                            </label>
                            <div class="controls">
                                <form:input path="pojo.email" size="50"/>
                                <form:errors path="pojo.email" cssClass="error-inline-validate"/>
                            </div>


                            <label class="control-label">
                                <fmt:message key="label.role"/>
                            </label>
                            <div class="controls">
                                <form:select path="pojo.role" cssStyle="width: 220px;">
                                    <form:option value="NHANVIENKHO">Nhân viên kho</form:option>
                                    <form:option value="NHANVIENTT">Nhân viên trung tâm</form:option>
                                    <form:option value="TRUONGCA">Trưởng ca sản xuất</form:option>
                                    <form:option value="QUANLYKT">Quản lý kỹ thuật</form:option>
                                    <form:option value="NHANVIENKD">Nhân viên kinh doanh</form:option>
                                    <form:option value="QUANLYNO">Quản lý công nợ</form:option>
                                    <form:option value="QUANLYKHO">Quản lý kho</form:option>
                                    <form:option value="QUANLYTT">Quản lý trung tâm</form:option>
                                    <form:option value="QUANLYKD">Quản lý kinh doanh</form:option>
                                    <form:option value="LANHDAO">Lãnh đạo </form:option>
                                    <form:option value="ADMIN">Admin</form:option>
                                </form:select>
                            </div>

                            <label class="control-label">
                                <fmt:message key="whm.warehouse"/>
                            </label>
                            <div class="controls">
                                <form:select path="pojo.warehouse.warehouseID" cssStyle="width: 220px;">
                                    <form:option value="">Trung Tâm</form:option>
                                    <form:options itemLabel="name" itemValue="warehouseID" items="${warehouses}"/>
                                </form:select>
                                <form:errors path="pojo.warehouse.warehouseID" cssClass="error-inline-validate"/>
                            </div>

                            <label class="control-label">
                                <fmt:message key="label.status"/>
                            </label>
                            <div class="controls">
                                <label class="label-inline"><form:radiobutton path="pojo.status" value="1" cssClass="radioCls"/>&nbsp;<fmt:message key="label.active"/></label>
                                <label class="label-inline"><form:radiobutton path="pojo.status" value="0" cssClass="radioCls"/>&nbsp;<fmt:message key="label.inactive"/></label>
                            </div>

                            <div class="controls">
                                <form:hidden path="crudaction" id="crudaction" value="insert-update"/>
                                <form:hidden path="pojo.userID"/>
                                <security:authorize ifAnyGranted="ADMIN">
                                <a onclick="$('#crudaction').val('insert-update');$('#itemForm').submit();" class="btn btn-success btn-green" style="cursor: pointer;">
                                    <fmt:message key="button.save"/>
                                </a>
                                </security:authorize>
                                <div style="display: inline">
                                    <a href="${backUrl}" class="cancel-link">
                                        <fmt:message key="button.cancel"/>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
            
        </div>
    </div>


</form:form>

<script type="text/javascript">
    $(function() {
        $("#deleteConfirmLink").click(function() {
            $('#crudaction').val('delete');
            document.forms['listForm'].submit();
        });
        $('a[name="deleteLink"]').click(function(eventObj) {
            //document.location.href = eventObj.target.href;
            return true;

        });

    });
    function confirmDeleteItem(){
        var fb = checkSelected4ConfirmDelete('listForm', 'checkList');
        if(fb) {
            $("#deleteConfirmLink").trigger('click');
        }else {
            $("#hidenWarningLink").trigger('click');
        }
    }

</script>
