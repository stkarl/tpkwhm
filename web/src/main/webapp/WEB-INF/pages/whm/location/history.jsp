<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@page import="com.banvien.tpk.core.Constants" %>
<html>
<head>
    <title><fmt:message key="location.history.title"/></title>
    <meta name="heading" content="<fmt:message key='location.history.title'/>"/>
</head>
<c:url var="urlForm" value="/whm/location/history.html"></c:url>
<body>
<div class="row-fluid data_content">
    <div class="content-header"><fmt:message key="location.history.title"/></div>
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
                    <td class="label-field"><fmt:message key="change.location.from.date"/></td>
                    <td>
                        <div class="input-append date" >
                            <fmt:formatDate var="ngayKeKhaiFrom" value="${items.fromDate}" pattern="dd/MM/yyyy"/>
                            <input name="fromDate" id="effectiveFromDate" class="prevent_type text-center width2" value="${ngayKeKhaiFrom}" type="text" />
                            <span class="add-on" id="effectiveFromDateIcon"><i class="icon-calendar"></i></span>
                        </div>
                    </td>
                    <td class="label-field"><fmt:message key="label.to.import.date"/></td>
                    <td>
                        <div class="input-append date" >
                            <fmt:formatDate var="ngayKeKhaiTo" value="${items.toDate}" pattern="dd/MM/yyyy"/>
                            <input name="toDate" id="effectiveToDate" class="prevent_type text-center width2" value="${ngayKeKhaiTo}" type="text" />
                            <span class="add-on" id="effectiveToDateIcon"><i class="icon-calendar"></i></span>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="label-field"><fmt:message key="whm.productname.name"/></td>
                    <td>
                        <form:select path="productID">
                            <form:option value="-1">Tất cả</form:option>
                            <form:options items="${productNames}" itemValue="productNameID" itemLabel="name"/>
                        </form:select>
                    </td>
                    <td class="label-field"><fmt:message key="whm.material.name"/></td>
                    <td>
                        <form:select path="materialID">
                            <form:option value="-1">Tất cả</form:option>
                            <form:options items="${materials}" itemValue="materialID" itemLabel="name"/>
                        </form:select>
                    </td>
                </tr>
                <tr>
                    <td class="label-field"><fmt:message key="old.location"/></td>
                    <td>
                        <form:select path="oldLocationID">
                            <form:option value="-1">Tất cả</form:option>
                            <form:options items="${warehouseMaps}" itemValue="warehouseMapID" itemLabel="name"/>
                        </form:select>
                    </td>
                    <td class="label-field"><fmt:message key="new.location"/></td>
                    <td>
                        <form:select path="newLocationID">
                            <form:option value="-1">Tất cả</form:option>
                            <form:options items="${warehouseMaps}" itemValue="warehouseMapID" itemLabel="name"/>
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
                <display:caption><fmt:message key='change.location.history.list'/></display:caption>
                <display:column headerClass="table_header_center" sortable="false" title="STT" class="text-center" style="width: 2%;">
                    ${tableList_rowNum}
                </display:column>
                <display:column headerClass="table_header_center" sortable="true" sortName="createdDate" titleKey="change.date" class="text-center" style="width: 10%;">
                    <fmt:formatDate value="${tableList.createdDate}" pattern="dd/MM/yyyy - HH:mm"/>
                </display:column>
                <display:column headerClass="table_header_center" property="createdBy.fullname" sortable="true" sortName="createdBy.fullname" titleKey="user.change" class="text-center" style="width: 10%;"/>

                <display:column headerClass="table_header_center" sortable="false" sortName="label.name" titleKey="whm.productname.name" class="text-center" style="width: 15%;">
                    ${not empty tableList.importProduct ? tableList.importProduct.productname.name : tableList.importMaterial.material.name}
                </display:column>
                <display:column headerClass="table_header_center" titleKey="label.code" class="text-center" style="width: 10%;">
                    ${not empty tableList.importProduct ? tableList.importProduct.productCode : tableList.importMaterial.code}
                </display:column>
                <display:column headerClass="table_header_center" property="oldLocation.name" sortable="true" sortName="oldLocation.name" titleKey="old.location" class="text-center" style="width: 10%;"/>

                <display:column headerClass="table_header_center" property="newLocation.name" sortable="true" sortName="newLocation.name" titleKey="new.location" class="text-center" style="width: 10%;"/>

                

                <display:setProperty name="paging.banner.item_name" value="lần thay đổi"/>
                <display:setProperty name="paging.banner.items_name" value="lần thay đổi"/>
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
            $("#itemForm").submit();
        });
    });
</script>
</body>
</html>