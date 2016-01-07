<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@page import="com.banvien.tpk.core.Constants" %>

<head>
    <title><fmt:message key="whm.maintenance.title"/></title>
    <meta name="heading" content="<fmt:message key="whm.maintenance.title"/>"/>
</head>

<c:url var="url" value="/whm/maintenance/edit.html"/>
<c:url var="backUrl" value="/whm/maintenance/list.html"/>
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
                <fmt:message key="whm.maintenance.edit"/>
                <br>
                <c:if test="${!empty item.pojo.machine}">
                    ${item.pojo.machine.code} - ${item.pojo.machine.name}
                </c:if>
                <c:if test="${!empty item.pojo.machinecomponent}">
                    ${item.pojo.machinecomponent.code} - ${item.pojo.machinecomponent.name}
                </c:if>
            </div>
            <div class="clear"></div>
            <div class="row-fluid">
                <div class="pane_info">
                    <div class="pane_title"><fmt:message key="whm.maintenance.info"/></div>
                    <div class="pane_content">
                        <div class="control-group">
                            <label class="control-label"><fmt:message key="label.description"/></label>
                            <div class="controls">
                                <form:textarea path="pojo.note" cssClass="nohtml nameValidate" rows="8" cols="25"/>
                            </div>

                            <label class="control-label"><fmt:message key="label.maintenance.date"/></label>
                            <div class="controls">
                                <div class="input-append date" >
                                    <fmt:formatDate var="maintenanceDate" value="${item.pojo.maintenanceDate}" pattern="dd/MM/yyyy"/>
                                    <input name="pojo.maintenanceDate" id="maintenanceDate" class="prevent_type text-center width5" value="${maintenanceDate}" type="text" />
                                    <span class="add-on" id="maintenanceDateIcon"><i class="icon-calendar"></i></span>
                                </div>
                            </div>

                            <label class="control-label"><fmt:message key="whm.no.next.maintenance.day"/></label>
                            <div class="controls">
                                <form:input path="pojo.noDay" cssClass="nohtml width0" size="3" maxlength="45"/> <fmt:message key="label.no.day"/>
                            </div>

                            <div class="controls">
                                <a onclick="$('#itemForm').submit();" class="btn btn-success btn-green" style="cursor: pointer;">
                                    <fmt:message key="button.save"/>
                                </a>
                                <div style="display: inline">
                                    <form:hidden path="crudaction" id="crudaction" value="insert-update"/>
                                    <form:hidden path="pojo.maintenanceHistoryID"/>
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
    $(document).ready(function(){

        var maintenanceDateVar = $("#maintenanceDate").datepicker({
            format: 'dd/mm/yyyy',
            onRender: function(date){
            }}).on('changeDate', function(ev) {
                    maintenanceDateVar.hide();
                }).data('datepicker');

        $('#maintenanceDateIcon').click(function() {
            $('#maintenanceDate').focus();
            return true;
        });
    });
</script>
