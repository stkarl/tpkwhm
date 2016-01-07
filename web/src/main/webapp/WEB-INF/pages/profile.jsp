<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<head>
    <title>Thông tin cá nhân</title>
    <meta name="heading" content="Quản lý thông tin cá nhân"/>
</head>
<c:url var="url" value="/whm/myProfile.html"/>
<c:url var="backUrl" value="/"/>

<div id="content">
    <form:form commandName="item" action="${url}" method="post" id="itemForm" class="form-horizontal">

        <div id="container-fluid data_content_box">
            <div class="row-fluid data_content">
                <div class="content-header">
                    Cập nhật thông tin cá nhân
                </div>
                <div class="clear"></div>
                <c:if test="${!empty messageResponse}">
                    <div class="alert alert-success">
                        <a class="close" data-dismiss="alert" href="#">x</a>
                            ${messageResponse}
                    </div>
                    <div style="clear:both;"></div>
                </c:if>

                <div class="row-fluid">
                    <div class="pane_info">
                        <div class="pane_title"><fmt:message key="whm.user.info"/></div>
                        <div class="pane_content">
                            <div class="control-group">
                                <label class="control-label">Họ và tên</label>
                                <div class="controls">
                                    <form:input path="pojo.fullname" cssStyle="width: 300px; height: 30px;"/>
                                    <form:errors path="pojo.fullname" cssClass="validateError"/>
                                </div>
                                <label class="control-label">Mã số</label>
                                <div class="controls">
                                    <input value="${item.pojo.userCode}" type="text" style="width: 300px; height: 30px;" disabled/>
                                </div>

                                <label class="control-label">Phone</label>
                                <div class="controls">
                                    <form:input path="pojo.phone" cssStyle="width: 300px; height: 30px;"/>
                                    <form:errors path="pojo.phone" cssClass="validateError"/>
                                </div>

                                <label class="control-label">Email</label>
                                <div class="controls">
                                    <form:input path="pojo.email" cssStyle="width: 300px; height: 30px;"/>
                                    <form:errors path="pojo.email" cssClass="validateError"/>
                                </div>

                                <label class="control-label">Vai trò</label>
                                <div class="controls">
                                    <input value="${item.pojo.role}" type="text" style="width: 300px; height: 30px;" disabled/>
                                </div>

                                <label class="control-label">Mật khẩu cũ</label>
                                <div class="controls">
                                    <form:password path="oldPassword" cssStyle="width: 300px; height: 30px;"/>
                                    <form:errors path="oldPassword" cssClass="error-inline-validate"/>
                                </div>

                                <label class="control-label">Mật khẩu mới</label>
                                <div class="controls">
                                    <form:password path="newPassword" cssStyle="width: 300px; height: 30px;"/>
                                    <form:errors path="newPassword" cssClass="error-inline-validate"/>
                                </div>

                                <label class="control-label">Lặp lại mật khẩu mới</label>
                                <div class="controls">
                                    <form:password path="confirmedPassword" cssStyle="width: 300px; height: 30px;"/>
                                    <form:errors path="confirmedPassword" cssClass="error-inline-validate"/>
                                </div>
                                <div class="controls">
                                    <form:hidden path="crudaction" id="crudaction" value="insert-update"/>
                                    <form:hidden path="pojo.userID"/>
                                    <a onclick="$('#crudaction').val('insert-update');$('#itemForm').submit();" class="btn btn-success btn-green" style="cursor: pointer;">
                                        <fmt:message key="button.update"/>
                                    </a>
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
</div>