<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<head>
    <title><fmt:message key="whm.materialmeasurement.title"/></title>
    <meta name="heading" content="<fmt:message key="whm.materialmeasurement.title"/>"/>
</head>

<c:url var="url" value="/whm/materialmeasurement/edit.html"/>
<c:url var="backUrl" value="/whm/materialmeasurement/list.html"/>
<form:form commandName="item" action="${url}" method="post" id="itemForm" class="form-horizontal" novalidate="novalidate">
    <div id="container-fluid data_content_box">
        <div class="row-fluid data_content">
            <div class="content-header">
                Thay đổi thông tin ghi chỉ số
            </div>
            <div class="clear"></div>
            <div class="row-fluid">
                <div class="pane_info">
                    <div class="pane_title">Thông tin ghi chỉ số</div>
                    <div class="pane_content">
                        <div class="control-group">
                            <label class="control-label"><fmt:message key="whm.warehouse"/></label>
                            <div class="controls text-inline"> ${item.pojo.warehouse.name}</div>
                            <label class="control-label"><fmt:message key="whm.material.name"/></label>
                            <div class="controls text-inline">${item.pojo.material.name}</div>
                            <label class="control-label"><fmt:message key="write.date"/></label>
                            <div class="controls text-inline"><fmt:formatDate value="${item.pojo.date}" pattern="${datePattern}"/></div>

                            <label class="control-label"><fmt:message key="measure.value"/></label>
                            <div class="controls">
                                <input id="measureValue" type="text" name="pojo.value" value="${item.pojo.value}" onchange="checkNumber(this.value, this.id);"/>
                            </div>
                            <label class="control-label"><fmt:message key="label.note"/></label>
                            <div class="controls">
                                <form:textarea path="pojo.note" rows="2"/>
                            </div>
                            <div class="controls">
                                <a onclick="$('#itemForm').submit();" class="btn btn-success btn-green" style="cursor: pointer;">
                                    <fmt:message key="button.save"/>
                                </a>
                                <div style="display: inline">
                                    <form:hidden path="crudaction" id="crudaction" value="insert-update"/>
                                    <form:hidden path="pojo.materialMeasurementID"/>
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
