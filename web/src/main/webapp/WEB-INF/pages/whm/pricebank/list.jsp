<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@page import="com.banvien.tpk.core.Constants" %>
<html>
<head>
    <title><fmt:message key="material.measurement.list.title"/></title>
    <meta name="heading" content="<fmt:message key='material.measurement.list.title'/>"/>
</head>
<c:url var="urlForm" value="/whm/materialmeasurement/list.html"></c:url>
<c:url var="editUrl" value="/whm/materialmeasurement/edit.html"></c:url>
<body>
<div class="row-fluid data_content">
    <div class="content-header"><fmt:message key="material.measurement.list.title"/></div>
    <div class="clear"></div>

    <c:if test="${not empty messageResponse}">
        <div class="alert alert-${alertType}">
            <button aria-hidden="true" data-dismiss="alert" class="close" type="button">x</button>
                ${messageResponse}
        </div>
    </c:if>
    <div class="report-filter">
        <form:form commandName="items" action="${urlForm}" id="listForm" method="post" autocomplete="off" name="listForm">
            <table class="tbReportFilter" >
                <caption><fmt:message key="label.search.title"/></caption>
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
                <tr>
                    <td class="label-field"><fmt:message key="whm.material.name"/></td>
                    <td>
                        <form:select path="pojo.material.materialID">
                            <form:option value="-1">Tất cả</form:option>
                            <form:options items="${materials}" itemValue="materialID" itemLabel="name"/>
                        </form:select>
                    </td>
                    <td class="label-field"><fmt:message key="whm.warehouse"/></td>
                    <td>
                        <form:select path="pojo.warehouse.warehouseID">
                            <form:option value="-1">Tất cả</form:option>
                            <form:options items="${warehouses}" itemValue="warehouseID" itemLabel="name"/>
                        </form:select>
                    </td>
                </tr>
                <tr style="text-align: center;">
                    <td colspan="4">
                        <a id="btnFilter" class="btn btn-primary " onclick="submitForm();"><i class="icon-refresh"></i> <fmt:message key="label.search"/> </a>
                    </td>
                </tr>
            </table>
            <div class="clear"></div>
            <div id="infoMsg"></div>
            <display:table name="items.listResult" cellspacing="0" cellpadding="0" requestURI="${formlUrl}"
                           partialList="true" sort="external" size="${items.totalItems }"
                           uid="tableList" excludedParams="crudaction"
                           pagesize="${items.maxPageItems}" export="false" class="tableSadlier table-hover">
                <display:caption><fmt:message key='material.measurement.list'/></display:caption>
                <display:column headerClass="table_header_center" sortable="false" title="STT" class="text-center" style="width: 2%;">
                    ${tableList_rowNum}
                </display:column>
                <display:column headerClass="table_header large" property="warehouse.name" titleKey="whm.warehouse" sortName="warehouse.name" sortable="true" style="width: 15%;"/>
                <display:column headerClass="table_header large" property="material.name" titleKey="whm.material.name" sortName="material.name" sortable="true"  style="width: 20%;"/>
                <display:column headerClass="table_header_center" sortName="createdDate" sortable="true" titleKey="write.date" class="text-center" style="width: 10%;">
                    <fmt:formatDate value="${tableList.date}" pattern="dd/MM/yyyy"/>
                </display:column>
                <display:column headerClass="table_header_center" property="material.unit.name" sortable="false" titleKey="label.unit" class="text-center" style="width: 5%;"/>
                <display:column headerClass="table_header_center" sortName="value" sortable="true" titleKey="measure.value" class="text-center" style="width: 10%;">
                    <fmt:formatNumber value="${tableList.value}"/>
                </display:column>
                <display:column headerClass="table_header large" property="note" titleKey="label.note" sortable="false"  style="width: 30%;"/>
                <display:column headerClass="table_header_center" sortable="false" titleKey="label.options" style="width: 7%;text-align:center;">
                    <a href="${editUrl}?pojo.materialMeasurementID=${tableList.materialMeasurementID}" class="icon-edit tip-top" title="<fmt:message key="label.edit"/>"></a>
                    <security:authorize ifAnyGranted="ADMIN">
                        <span class="separator"></span>
                        <a name="deleteLink" onclick="warningDelete(this)" id="${tableList.materialMeasurementID}" href="#" class="icon-remove tip-top" title="<fmt:message key="label.delete"/>"></a>
                    </security:authorize>
                </display:column>
                <display:setProperty name="paging.banner.item_name" value="Lần ghi chỉ số"/>
                <display:setProperty name="paging.banner.items_name" value="Lần ghi chỉ số"/>
                <display:setProperty name="paging.banner.placement" value="bottom"/>
                <display:setProperty name="paging.banner.no_items_found" value=""/>
            </display:table>
            <form:hidden path="crudaction" id="crudaction"/>
        </form:form>
    </div>
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
</body>
</html>