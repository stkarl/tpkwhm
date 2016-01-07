<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<head>
    <title><fmt:message key="whm.warehouse.title"/></title>
    <meta name="heading" content="<fmt:message key="whm.warehouse.title"/>"/>
</head>

<c:url var="url" value="/whm/warehouse/edit.html"/>
<c:url var="backUrl" value="/whm/warehouse/list.html"/>
<form:form commandName="item" action="${url}" method="post" id="itemForm" class="form-horizontal" novalidate="novalidate">
    <div id="container-fluid data_content_box">
        <div class="row-fluid data_content">

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

            <div class="content-header">
                <c:choose>
                    <c:when test="${not empty item.pojo.warehouseID}">
                        <fmt:message key="whm.warehouse.edit"/>
                    </c:when>
                    <c:otherwise>
                        <fmt:message key="whm.warehouse.new"/>
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="clear"></div>
            <div class="row-fluid">
                <div class="pane_info">
                    <div class="pane_title"><fmt:message key="whm.warehouse.info"/></div>
                    <div class="pane_content">
                        <div class="control-group">
                            <label class="control-label"><fmt:message key="label.name"/></label>
                            <div class="controls">
                                <form:input path="pojo.name" cssClass="required nohtml nameValidate" warehouse="25" maxlength="45"/>
                                <form:errors path="pojo.name" cssClass="error-inline-validate"/>
                            </div>
                            <label class="control-label"><fmt:message key="label.code"/></label>
                            <div class="controls">
                                <form:input path="pojo.code" cssClass="required nohtml nameValidate" warehouse="25" maxlength="45"/>
                                <form:errors path="pojo.code" cssClass="error-inline-validate"/>
                            </div>
                            <label class="control-label"><fmt:message key="label.address"/></label>
                            <div class="controls">
                                <form:textarea path="pojo.address" cssClass="required nohtml nameValidate" rows="5" cols="25"/>
                                <form:errors path="pojo.address" cssClass="error-inline-validate"/>
                            </div>
                            <label class="control-label">
                                <fmt:message key="label.status"/>
                            </label>
                            <div class="controls">
                                <label class="label-inline"><form:radiobutton path="pojo.status" value="1" cssClass="radioCls"/>&nbsp;<fmt:message key="label.active"/></label>
                                <label class="label-inline"><form:radiobutton path="pojo.status" value="0" cssClass="radioCls"/>&nbsp;<fmt:message key="label.inactive"/></label>
                            </div>
                            <div class="controls">
                                <a onclick="$('#itemForm').submit();" class="btn btn-success btn-green" style="cursor: pointer;">
                                    <fmt:message key="button.save"/>
                                </a>
                                <div style="display: inline">
                                    <form:hidden path="crudaction" id="crudaction" value="insert-update"/>
                                    <form:hidden path="pojo.warehouseID"/>
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
