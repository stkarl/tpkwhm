<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<head>
    <title><fmt:message key="whm.overlaytype.title"/></title>
    <meta name="heading" content="<fmt:message key="whm.overlaytype.title"/>"/>
</head>

<c:url var="url" value="/whm/overlaytype/edit.html"/>
<c:url var="backUrl" value="/whm/overlaytype/list.html"/>
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
                    <c:when test="${not empty item.pojo.overlayTypeID}">
                        <fmt:message key="whm.overlaytype.edit"/>
                    </c:when>
                    <c:otherwise>
                        <fmt:message key="whm.overlaytype.new"/>
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="clear"></div>
            <div class="row-fluid">
                <div class="pane_info">
                    <div class="pane_title"><fmt:message key="whm.overlaytype.info"/></div>
                    <div class="pane_content">
                        <div class="control-group">
                            <label class="control-label"><fmt:message key="label.name"/></label>
                            <div class="controls">
                                <form:input path="pojo.name" cssClass="required nohtml nameValidate" size="25" maxlength="45"/>
                                <form:errors path="pojo.name" cssClass="error-inline-validate"/>
                            </div>
                            <label class="control-label"><fmt:message key="label.code"/></label>
                            <div class="controls">
                                <form:input path="pojo.code" cssClass="required nohtml nameValidate" size="25" maxlength="45"/>
                                <form:errors path="pojo.code" cssClass="error-inline-validate"/>
                            </div>
                            <label class="control-label"><fmt:message key="label.sign"/></label>
                            <div class="controls">
                                <form:input path="pojo.sign" cssClass="required nohtml nameValidate" size="25" maxlength="45"/>
                                <form:errors path="pojo.sign" cssClass="error-inline-validate"/>
                            </div>
                            <label class="control-label"><fmt:message key="label.description"/></label>
                            <div class="controls">
                                <form:textarea path="pojo.description" cssClass="required nohtml nameValidate" rows="5" cols="25"/>
                                <form:errors path="pojo.description" cssClass="error-inline-validate"/>
                            </div>
                            <div class="controls">
                                <a onclick="$('#itemForm').submit();" class="btn btn-success btn-green" style="cursor: pointer;">
                                    <fmt:message key="button.save"/>
                                </a>
                                <div style="display: inline">
                                    <form:hidden path="crudaction" id="crudaction" value="insert-update"/>
                                    <form:hidden path="pojo.overlayTypeID"/>
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
