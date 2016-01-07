<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@page import="com.banvien.tpk.core.Constants" %>
<html>
<head>
    <title><fmt:message key="change.material.location.title"/></title>
    <meta name="heading" content="<fmt:message key='change.material.location.title'/>"/>
</head>
<c:url var="urlForm" value="/whm/instock/location/material.html"></c:url>
<body>
<div class="row-fluid data_content">
    <div class="content-header"><fmt:message key="change.material.location.title"/></div>
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
                    <td class="label-field" ><fmt:message key="label.number"/></td>
                    <td><form:input path="code" size="25" maxlength="45" /></td>
                    <td class="label-field"><fmt:message key="label.location"/></td>
                    <td>
                        <form:select path="warehouseMapID">
                            <form:option value="-1">Tất cả</form:option>
                            <form:options items="${warehouseMaps}" itemValue="warehouseMapID" itemLabel="name"/>
                        </form:select>
                    </td>
                </tr>
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
                    <td class="label-field"><fmt:message key="whm.market.name"/></td>
                    <td>
                        <form:select path="marketID">
                            <form:option value="-1">Tất cả</form:option>
                            <form:options items="${markets}" itemValue="marketID" itemLabel="name"/>
                        </form:select>
                    </td>
                </tr>
                <tr>
                    <td class="label-field"><fmt:message key="label.from.import.date"/></td>
                    <td>
                        <div class="input-append date" >
                            <fmt:formatDate var="ngayKeKhaiFrom" value="${items.fromImportedDate}" pattern="dd/MM/yyyy"/>
                            <input name="fromImportedDate" id="effectiveFromDate" class="prevent_type text-center width2" value="${ngayKeKhaiFrom}" type="text" />
                            <span class="add-on" id="effectiveFromDateIcon"><i class="icon-calendar"></i></span>
                        </div>
                    </td>
                    <td class="label-field"><fmt:message key="label.to.import.date"/></td>
                    <td>
                        <div class="input-append date" >
                            <fmt:formatDate var="ngayKeKhaiTo" value="${items.toImportedDate}" pattern="dd/MM/yyyy"/>
                            <input name="toImportedDate" id="effectiveToDate" class="prevent_type text-center width2" value="${ngayKeKhaiTo}" type="text" />
                            <span class="add-on" id="effectiveToDateIcon"><i class="icon-calendar"></i></span>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="label-field"><fmt:message key="label.to.expire.date"/></td>
                    <td>
                        <div class="input-append date" >
                            <fmt:formatDate var="ngayHetHanTo" value="${items.expiredDate}" pattern="dd/MM/yyyy"/>
                            <input name="expiredDate" id="effectiveExpiredDate" class="prevent_type text-center width2" value="${ngayHetHanTo}" type="text" />
                            <span class="add-on" id="effectiveExpiredDateIcon"><i class="icon-calendar"></i></span>
                        </div>
                    </td>
                    <td></td>
                    <td></td>
                </tr>
                <tr style="text-align: center;">
                    <td colspan="4">
                        <a id="btnFilter" class="btn btn-primary " onclick="submitForm('itemForm');"><i class="icon-refresh"></i> <fmt:message key="label.search"/> </a>
                    </td>
                </tr>
            </table>
            <div class="clear"></div>
            <div id="infoMsg"></div>
            <div class="process-control">
                <a id="btnBook" class="btn btn-info " onclick="changeLocation();"><i class="icon-check"></i> <fmt:message key="change.location"/> </a>
            </div>
            <display:table name="items.listResult" cellspacing="0" cellpadding="0" requestURI="${formlUrl}"
                           partialList="true" sort="external" size="${items.totalItems }"
                           uid="tableList" excludedParams="crudaction"
                           pagesize="${items.maxPageItems}" export="false" class="tableSadlier table-hover">
                <display:caption><fmt:message key='in.stock.material.list'/></display:caption>
                <display:column headerClass="table_header_center" sortable="false" title="STT" class="text-center" style="width: 2%;">
                    ${tableList_rowNum}
                </display:column>
                <display:column headerClass="table_header_center" property="material.name" sortable="true" sortName="material.name" titleKey="whm.material.name" class="text-center" style="width: 7%;"/>
                <display:column headerClass="table_header_center" property="code" titleKey="label.number" class="text-center" style="width: 7%;"/>
                <display:column headerClass="table_header_center" property="origin.name" sortable="true" sortName="origin.name" titleKey="whm.origin.name" class="text-center" style="width: 7%;"/>
                <display:column headerClass="table_header_center" property="market.name" sortable="true" sortName="market.name" titleKey="whm.market.name" class="text-center" style="width: 7%;"/>

                <display:column headerClass="table_header large" sortName="remainQuantity" sortable="true" titleKey="label.quantity" style="width: 10%;text-align:right;">
                    <fmt:formatNumber value="${tableList.remainQuantity}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/> (${tableList.material.unit.name})
                </display:column>

                <display:column headerClass="table_header large" property="warehouse.name" titleKey="whm.warehouse.name" sortName="warehouse.name" sortable="true" style="width: 10%;"/>
                <display:column headerClass="table_header_center" sortable="false" titleKey="import.warehouse.date" class="text-center" style="width: 7%;">
                    <fmt:formatDate value="${tableList.importDate}" pattern="dd/MM/yyyy"/>
                </display:column>

                <display:column headerClass="table_header_center" sortable="false" titleKey="label.expiredDate" class="text-center" style="width: 7%;">
                    <fmt:formatDate value="${tableList.expiredDate}" pattern="dd/MM/yyyy"/>
                </display:column>
                
                <display:column headerClass="table_header_center" sortable="false" titleKey="label.location" class="text-center" style="width: 15%;">
                    <select name="selectedItems[${tableList_rowNum - 1}].warehouseMap.warehouseMapID" onchange="checkSelectBox(${tableList.importMaterialID});" style="width: 150px;">
                        <option value="-1">-<fmt:message key="label.select"/>-</option>
                        <c:forEach items="${warehouseMaps}" var="warehouseMap">
                            <option value="${warehouseMap.warehouseMapID}" <c:if test="${warehouseMap.warehouseMapID == tableList.warehouseMap.warehouseMapID}">selected</c:if>>${warehouseMap.name}</option>
                        </c:forEach>
                    </select>
                </display:column>
                <display:column headerClass="table_header_center" sortable="false" titleKey="<input type=\"checkbox\" onclick=\"checkAllByClass('checkMtr', this);\"/>" style="width: 5%;text-align:center;">
                    <input id="chk_${tableList.importMaterialID}" class="checkMtr" type="checkbox" name="selectedItems[${tableList_rowNum - 1}].itemID" value="${tableList.importMaterialID}"/>
                </display:column>

                <display:setProperty name="paging.banner.item_name" value="loại vật tư"/>
                <display:setProperty name="paging.banner.items_name" value="loại vật tư"/>
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
            $("#crudaction").val("search");
            $("#itemForm").submit();
        });
    });
    function changeLocation(){
        var hasMtr = false;
        if($(".checkMtr:checkbox:checked").length > 0){
            hasMtr = true;
        }
        if(hasMtr){
            $("#crudaction").val("location");
            submitForm('itemForm');
        }else{
            bootbox.alert("<fmt:message key="label.title.confirm"/>", "<fmt:message key="message.chooseAtLeastOne"/>");
        }
    }
    function checkSelectBox(id){
        $('#chk_' + id).attr("checked","checked");
        $('#chk_' + id).parent().addClass('checked');
    }
</script>
</body>
</html>