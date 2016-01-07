<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@page import="com.banvien.tpk.core.Constants" %>
<html>
<head>
    <title><fmt:message key="export.material.report.title"/></title>
    <meta name="heading" content="<fmt:message key='export.material.report.title'/>"/>
</head>
<c:url var="urlForm" value="/whm/report/material/export.html"></c:url>
<body>
<div class="row-fluid data_content">
    <div class="content-header"><fmt:message key="export.material.report.title"/></div>
    <div class="clear"></div>
    <c:if test="${not empty messageResponse}">
        <div class="alert alert-${alertType}">
            <button aria-hidden="true" data-dismiss="alert" class="close" type="button">x</button>
                ${messageResponse}
        </div>
    </c:if>
    <div class="report-filter">
        <form:form commandName="items" action="${urlForm}" id="itemForm" method="post" autocomplete="off" name="itemForm">
            <table class="tbReportFilter" >
                <caption><fmt:message key="label.search.title"/></caption>

                <tr>
                    <td class="label-field"><fmt:message key="whm.material.name"/></td>
                    <td>
                        <form:select path="materialID">
                            <form:option value="-1">Tất cả</form:option>
                            <form:options items="${materials}" itemValue="materialID" itemLabel="name"/>
                        </form:select>
                    </td>
                    <td class="label-field"><fmt:message key="whm.materialcategory.name"/></td>
                    <td>
                        <form:select path="materialCategoryID">
                            <form:option value="-1">Tất cả</form:option>
                            <form:options items="${materialCategories}" itemValue="materialCategoryID" itemLabel="name"/>
                        </form:select>
                    </td>
                </tr>
                <tr>
                    <td class="label-field"><fmt:message key="whm.origin.name"/></td>
                    <td>
                        <form:select path="originID">
                            <form:option value="-1">Tất cả</form:option>
                            <form:options items="${origins}" itemValue="originID" itemLabel="name"/>
                        </form:select>
                    </td>
                    <td class="label-field" ><fmt:message key="whm.warehouse"/></td>
                    <td>
                        <form:select path="warehouseID">
                            <form:option value="-1">Tất cả</form:option>
                            <form:options items="${warehouses}" itemValue="warehouseID" itemLabel="name"/>
                        </form:select>
                    </td>
                </tr>
                <tr>
                    <td class="label-field"><fmt:message key="from.date"/></td>
                    <td>
                        <div class="input-append date" >
                            <fmt:formatDate var="ngayKeKhaiFrom" value="${items.fromDate}" pattern="dd/MM/yyyy"/>
                            <input name="fromDate" id="effectiveFromDate" class="prevent_type text-center width2" value="${ngayKeKhaiFrom}" type="text" />
                            <span class="add-on" id="effectiveFromDateIcon"><i class="icon-calendar"></i></span>
                        </div>
                    </td>
                    <td class="label-field"><fmt:message key="to.date"/></td>
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
                        <a id="btnFilter" class="btn btn-primary"><i class="icon-refresh"></i> <fmt:message key="label.report"/> </a>
                        <a id="btnExport" class="btn btn-info " onclick="submitExport('itemForm');"><i class="icon-arrow-down"></i> <fmt:message key="label.export.excel"/> </a>
                    </td>
                </tr>
            </table>
            <div class="clear"></div>

            <table class=" tableSadlier table-hover">
                <caption><fmt:message key="export.material.report.title"/></caption>
                <tr>
                    <th class="table_header_center"><fmt:message key="whm.origin.name"/></th>
                    <th class="table_header_center"><fmt:message key="whm.material.name"/></th>
                    <th class="table_header_center"><fmt:message key="label.code"/></th>
                    <th class="table_header_center"><fmt:message key="label.unit"/></th>
                    <th class="table_header_center"><fmt:message key="label.init.value"/></th>
                    <th class="table_header_center"><fmt:message key="label.import.value"/></th>
                    <th class="table_header_center"><fmt:message key="label.export.value"/></th>
                    <th class="table_header_center"><fmt:message key="label.final.value"/></th>
                    <th class="table_header_center"><fmt:message key="label.note"/></th>
                    <th class="table_header_center"><fmt:message key="label.import.date"/></th>
                </tr>
                <c:set var="initialValue" value="${exportMaterialReport.initialValue}"/>
                <c:set var="mapImportValue" value="${exportMaterialReport.mapImportValue}"/>
                <c:set var="mapExportUtilDateValue" value="${exportMaterialReport.mapExportUtilDateValue}"/>
                <c:set var="mapExportDuringDateValue" value="${exportMaterialReport.mapExportDuringDateValue}"/>
                <c:if test="${!empty initialValue}">
                    <c:forEach items="${initialValue}" var="initVal" varStatus="status">
                        <c:set var="material" value="${initVal.material}"/>
                        <c:set var="origin" value="${initVal.origin}"/>
                        <c:set var="materialID" value="${material.materialID}"/>
                        <c:set var="originID" value=""/>
                        <c:if test="${!empty origin && !empty origin.originID}">
                            <c:set var="originID" value="${origin.originID}"/>
                        </c:if>
                        <c:set var="key" value='${materialID}_${originID}'/>
                        <tr class="${status.index % 2 == 0 ? "even" : "odd"}">
                            <td>${initVal.origin.name}</td>
                            <td>${material.name}</td>
                            <td>${initVal.code}</td>
                            <td>${material.unit.name}</td>
                            <td><fmt:formatNumber value="${initVal.quantity - mapExportUtilDateValue[key]}" pattern="###,###.##"/></td>
                            <td><fmt:formatNumber value="${mapImportValue[key]}" pattern="###,###.##"/></td>
                            <td><fmt:formatNumber value="${mapExportDuringDateValue[key]}" pattern="###,###.##"/></td>
                            <td><fmt:formatNumber value="${initVal.quantity - mapExportUtilDateValue[key] + mapImportValue[key] - mapExportDuringDateValue[key]}" pattern="###,###.##"/></td>
                            <td></td>
                            <td><fmt:formatDate value="${initVal.importDate}" pattern="dd/MM/yyyy"/></td>
                        </tr>
                    </c:forEach>

                </c:if>
                <c:if test="${empty initialValue && !empty items.crudaction}">
                    <tr>
                        <td colspan="9" style="color: #ff2a18;text-align: center;"><fmt:message key="no.report.result"/></td>
                    </tr>
                </c:if>

            </table>



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
        var effectiveExpiredDateVar = $("#effectiveExpiredDate").datepicker({
            format: 'dd/mm/yyyy',
            onRender: function(date){
            }}).on('changeDate', function(ev) {
                    effectiveExpiredDateVar.hide();
                }).data('datepicker');
        $('#effectiveExpiredDateIcon').click(function() {
            $('#effectiveExpiredDate').focus();
            return true;
        });
        $('#effectiveToDateIcon').click(function() {
            $('#effectiveToDate').focus();
            return true;
        });
        $('#effectiveFromDateIcon').click(function() {
            $('#effectiveFromDate').focus();
            return true;
        });


        $("#btnFilter").click(function(){
            $("#crudaction").val("report");
            $('.inputNumber').each(function(){
                if($(this).val() != '' && $(this).val() != 0 ) {
                    $(this).val(numeral().unformat($(this).val()));
                }
            });
            $("#itemForm").submit();
        });
    });
</script>
</body>
</html>