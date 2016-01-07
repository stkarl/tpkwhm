<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@page import="com.banvien.tpk.core.Constants" %>

<head>
    <title><fmt:message key="whm.maintenance.list"/></title>
    <meta name="heading" content="<fmt:message key="whm.maintenance.list"/>"/>
</head>

<c:url var="url" value="/whm/maintenance/list.html"/>
<c:url var="editUrl" value="/whm/maintenance/edit.html"/>
<div id="content">
    <form:form commandName="items" action="${url}" method="post" id="listForm" name="listForm">
        <div id="container-fluid data_content_box">
            <div class="row-fluid data_content">
                <div class="content-header">
                    <fmt:message key="whm.maintenance.list"/>
                </div>
                <div class="clear"></div>
                <c:if test="${not empty messageResponse}">
                    <div class="alert alert-${alertType}">
                        <button aria-hidden="true" data-dismiss="alert" class="close" type="button">x</button>
                            ${messageResponse}
                    </div>
                </c:if>
                <div class="report-filter">
                    <div class="row-fluid report-filter">
                        <table class="tbReportFilter">
                            <caption><fmt:message key="label.search.title"/></caption>
                            <tr>
                                <td class="label-field"><fmt:message key="whm.machine.name"/></td>
                                <td>
                                    <form:select path="pojo.machine.machineID">
                                        <form:option value="-1">Tất cả</form:option>
                                        <form:options items="${machines}" itemValue="machineID" itemLabel="name"/>
                                    </form:select>
                                </td>

                                <td class="label-field"><fmt:message key="whm.machinecomponent.name"/></td>
                                <td>
                                    <form:select path="pojo.machinecomponent.machineComponentID">
                                        <form:option value="-1">Tất cả</form:option>
                                        <c:forEach items="${machineComponents}" var="component">
                                            <form:option value="${component.machineComponentID}">${component.code} - ${component.name}</form:option>
                                        </c:forEach>
                                    </form:select>
                                </td>
                            </tr>

                            <tr>
                                <td class="label-field"><fmt:message key="label.fromdate"/></td>
                                <td>
                                    <div class="input-append date" >
                                        <fmt:formatDate var="ngayKeKhaiFrom" value="${items.fromDate}" pattern="dd/MM/yyyy"/>
                                        <input name="fromDate" id="effectiveFromDate" class="prevent_type text-center width2" value="${ngayKeKhaiFrom}" type="text" />
                                        <span class="add-on" id="effectiveFromDateIcon"><i class="icon-calendar"></i></span>
                                    </div>
                                </td>
                                <td class="label-field"><fmt:message key="label.todate"/></td>
                                <td>
                                    <div class="input-append date" >
                                        <fmt:formatDate var="ngayKeKhaiTo" value="${items.toDate}" pattern="dd/MM/yyyy"/>
                                        <input name="toDate" id="effectiveToDate" class="prevent_type text-center width2" value="${ngayKeKhaiTo}" type="text" />
                                        <span class="add-on" id="effectiveToDateIcon"><i class="icon-calendar"></i></span>
                                    </div>
                                </td>
                            </tr>

                            <tr style="text-align: center;">
                                <td colspan="4">
                                    <form:hidden path="crudaction" id="crudaction" value="doReport"/>
                                    <a id="btnFilter" class="btn btn-primary " onclick="$('#listForm').submit();"><i class="icon-refresh"></i> <fmt:message key="label.search"/> </a>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
                <div class="clear"></div>
                <div class="button-actions">

                    <a class="btn btn-primary " onclick="document.location.href='${editUrl}';"><i class="icon-plus"></i> <fmt:message key="button.add"/></a>
                </div>
                <div class="clear"></div>
                <display:table name="items.listResult" cellspacing="0" cellpadding="0" requestURI="${url}"
                               partialList="true" sort="external" size="${items.totalItems}"  uid="tableList" pagesize="${items.maxPageItems}" class="tableSadlier table-hover" export="false">
                    <display:caption><fmt:message key='whm.maintenance.list'/></display:caption>
                    <display:column headerClass="table_header"  escapeXml="false" titleKey="machine.or.component" style="width: 25%" >
                        <c:if test="${!empty tableList.machine}">
                            ${tableList.machine.code} - ${tableList.machine.name}
                        </c:if>
                        <c:if test="${!empty tableList.machinecomponent}">
                            ${tableList.machinecomponent.code} - ${tableList.machinecomponent.name}
                        </c:if>
                    </display:column>
                    <display:column headerClass="table_header"  escapeXml="false" sortable="true" sortName="description" titleKey="label.description" style="width: 35%" >
                        <str:truncateNicely upper="45">${tableList.note}</str:truncateNicely>
                    </display:column>

                    <display:column headerClass="table_header"  escapeXml="false" sortable="true" sortName="description" titleKey="label.maintenance.date" style="width: 10%" >
                        <fmt:formatDate value="${tableList.maintenanceDate}" pattern="dd/MM/yyyy"/>
                    </display:column>

                    <display:column headerClass="table_header" property="noDay" escapeXml="false" sortable="true" sortName="description" titleKey="whm.no.next.maintenance.day" style="width: 7%" />

                    <display:column sortable="false" headerClass="table_header_center" titleKey="label.options" style="width: 7%; text-align:center">
                        <a href="${editUrl}?pojo.maintenanceHistoryID=${tableList.maintenanceHistoryID}" class="icon-edit tip-top" title="<fmt:message key="label.edit"/>"></a>
                        <span class="separator"></span>
                        <a name="deleteLink" onclick="warningDelete(this)" id="${tableList.maintenanceHistoryID}" href="#" class="icon-remove tip-top" title="<fmt:message key="label.delete"/>"></a>
                    </display:column>
                    <display:setProperty name="paging.banner.item_name"><fmt:message key= "whm.maintenance.name"/></display:setProperty>
                    <display:setProperty name="paging.banner.items_name"><fmt:message key= "whm.maintenance.name"/></display:setProperty>
                    <display:setProperty name="paging.banner.placement" value="bottom"/>
                    <display:setProperty name="paging.banner.no_items_found" value=""/>
                </display:table>
                <div class="clear"></div>
            </div>
        </div>


    </form:form>
</div>

<script type="text/javascript">
    $(document).ready(function(){
        var effectiveToDateVar = $("#effectiveToDate").datepicker({
            format: 'dd/mm/yyyy',
            onRender: function(date){
            }}).on('changeDate', function(ev) {
                    effectiveToDateVar.hide();
                }).data('datepicker');
        var effectiveFromDateVar = $("#effectiveFromDate").datepicker({
            format: 'dd/mm/yyyy',
            onRender: function(date){
            }}).on('changeDate', function(ev) {
                    effectiveFromDateVar.hide();
                }).data('datepicker');
        $('#effectiveToDateIcon').click(function() {
            $('#effectiveToDate').focus();
            return true;
        });
        $('#effectiveFromDateIcon').click(function() {
            $('#effectiveFromDate').focus();
            return true;
        });


        $("#btnFilter").click(function(){
            $("#crudaction").val("search");
            $("#listForm").submit();
        });
    });

</script>


