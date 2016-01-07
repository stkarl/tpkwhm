<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<head>
    <title><fmt:message key="whm.salereason.title"/></title>
    <meta name="heading" content="<fmt:message key="whm.salereason.title"/>"/>
</head>

<c:url var="url" value="/whm/salereason/edit.html"/>
<c:url var="backUrl" value="/whm/salereason/list.html"/>
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
                    <c:when test="${not empty item.pojo.saleReasonID}">
                        <fmt:message key="whm.salereason.edit"/>
                    </c:when>
                    <c:otherwise>
                        <fmt:message key="whm.salereason.new"/>
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="clear"></div>
            <div class="row-fluid">
                <div class="pane_info">
                    <div class="pane_title"><fmt:message key="whm.salereason.info"/></div>
                    <div class="pane_content">
                        <div class="control-group">
                            <label class="control-label"><fmt:message key="label.reason"/></label>
                            <div class="controls">
                                <form:textarea path="pojo.reason" cssClass="required nohtml nameValidate span11" rows="2"/>
                                <form:errors path="pojo.reason" cssClass="error-inline-validate"/>
                            </div>

                            <label class="control-label"><fmt:message key="label.displayorder"/></label>
                            <div class="controls">
                                <form:input path="pojo.displayOrder" cssClass="required nohtml nameValidate" size="25" maxlength="45"/>
                                <form:errors path="pojo.displayOrder" cssClass="error-inline-validate"/>
                            </div>
                            <div class="controls">
                                <a onclick="$('#itemForm').submit();" class="btn btn-success btn-green" style="cursor: pointer;">
                                    <fmt:message key="button.save"/>
                                </a>
                                <div style="display: inline">
                                    <form:hidden path="crudaction" id="crudaction" value="insert-update"/>
                                    <form:hidden path="pojo.saleReasonID"/>
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
