<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@page import="com.banvien.tpk.core.Constants" %>
<html>
<head>
    <title><fmt:message key="suggest.price"/></title>
    <meta name="heading" content="<fmt:message key='suggest.price'/>"/>
</head>
<c:url var="urlForm" value="/whm/instock/suggestprice.html"></c:url>
<body>
<div class="row-fluid data_content">
    <div class="content-header"><fmt:message key="suggest.price"/></div>
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
                    <td class="label-field" ><fmt:message key="whm.warehouse"/></td>
                    <td>
                        <form:select path="warehouseID">
                            <form:option value="-1">Tất cả</form:option>
                            <form:options items="${warehouses}" itemValue="warehouseID" itemLabel="name"/>
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
                    <td class="label-field"><fmt:message key="whm.productname.name"/></td>
                    <td>
                        <form:select path="productNameID">
                            <form:option value="-1">Tất cả</form:option>
                            <form:options items="${productNames}" itemValue="productNameID" itemLabel="name"/>
                        </form:select>
                    </td>
                    <td class="label-field"><fmt:message key="whm.size.name"/></td>
                    <td>
                        <form:select path="sizeID">
                            <form:option value="-1">Tất cả</form:option>
                            <form:options items="${sizes}" itemValue="sizeID" itemLabel="name"/>
                        </form:select>
                    </td>
                </tr>
                <tr>
                    <td class="label-field"><fmt:message key="whm.thickness.name"/></td>
                    <td>
                        <form:select path="thicknessID">
                            <form:option value="-1">Tất cả</form:option>
                            <form:options items="${thicknesses}" itemValue="thicknessID" itemLabel="name"/>
                        </form:select>
                    </td>
                    <td class="label-field"><fmt:message key="whm.stiffness.name"/></td>
                    <td>
                        <form:select path="stiffnessID">
                            <form:option value="-1">Tất cả</form:option>
                            <form:options items="${stiffnesses}" itemValue="stiffnessID" itemLabel="name"/>
                        </form:select>
                    </td>
                </tr>
                <tr>
                    <td class="label-field"><fmt:message key="whm.colour.name"/></td>
                    <td>
                        <form:select path="colourID">
                            <form:option value="-1">Tất cả</form:option>
                            <form:options items="${colours}" itemValue="colourID" itemLabel="name"/>
                        </form:select>
                    </td>
                    <td class="label-field"><fmt:message key="whm.overlaytype.name"/></td>
                    <td>
                        <form:select path="overlayTypeID">
                            <form:option value="-1">Tất cả</form:option>
                            <form:options items="${overlayTypes}" itemValue="overlayTypeID" itemLabel="name"/>
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
                    <td class="label-field"><fmt:message key="none.price"/></td>
                    <td>
                        <form:checkbox path="nonePriced"/>
                    </td>
                    <td class="label-field"></td>
                    <td></td>
                </tr>
                <tr style="text-align: center;">
                    <td colspan="4">
                        <a id="btnFilter" class="btn btn-primary " onclick="searchItem();"><i class="icon-refresh"></i> <fmt:message key="label.search"/> </a>
                    </td>
                </tr>
            </table>
            <div class="clear"></div>
            <div id="infoMsg"></div>
            <div style="float: right;">
                <a id="btnSuggest" class="btn btn-info " onclick="suggestPrice();"><i class="icon-check"></i> <fmt:message key="suggest.price"/> </a>
            </div>
            <display:table name="items.listResult" cellspacing="0" cellpadding="0" requestURI="${formlUrl}"
                           partialList="true" sort="external" size="${items.totalItems }"
                           uid="tableList" excludedParams="crudaction"
                           pagesize="${items.maxPageItems}" export="false" class="tableSadlier table-hover">
                <display:caption><fmt:message key='suggest.price.list'/></display:caption>
                <display:column headerClass="table_header_center" sortable="false" title="STT" class="text-center" style="width: 2%;">
                    ${tableList_rowNum}
                </display:column>
                <display:column headerClass="table_header_center" property="productname.name" sortable="true" sortName="productname.name" titleKey="whm.productname.name" class="text-center" style="width: 7%;"/>
                <display:column headerClass="table_header_center" property="productCode" titleKey="label.number" class="text-center" style="width: 7%;"/>

                <display:column headerClass="table_header_center" property="size.name" sortable="true" sortName="size.name" titleKey="whm.size.name" class="text-center" style="width: 7%;"/>
                <display:column headerClass="table_header_center" property="thickness.name" sortable="true" sortName="thickness.name" titleKey="whm.thickness.name" class="text-center" style="width: 7%;"/>
                <display:column headerClass="table_header_center" property="stiffness.name" sortable="true" sortName="stiffness.name" titleKey="whm.stiffness.name" class="text-center" style="width: 7%;"/>
                <display:column headerClass="table_header_center" property="colour.name" sortable="true" sortName="colour.name" titleKey="whm.colour.name" class="text-center" style="width: 7%;"/>
                <display:column headerClass="table_header_center" property="overlaytype.name" sortable="true" sortName="overlaytype.name" titleKey="whm.overlaytype.name" class="text-center" style="width: 7%;"/>
                <display:column headerClass="table_header_center" property="origin.name" sortable="true" sortName="origin.name" titleKey="whm.origin.name" class="text-center" style="width: 7%;"/>
                <display:column headerClass="table_header_center" property="market.name" sortable="true" sortName="market.name" titleKey="whm.market.name" class="text-center" style="width: 7%;"/>

                <display:column headerClass="table_header large" sortName="quantity1" sortable="true" titleKey="label.quantity.meter" style="width: 10%;text-align:right;">
                    <fmt:formatNumber value="${tableList.quantity1}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/>
                </display:column>
                <display:column headerClass="table_header large" sortName="quantity2Pure" sortable="true" titleKey="label.quantity.kg" style="width: 10%;text-align:right;">
                    <fmt:formatNumber value="${tableList.quantity2Pure}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/>
                </display:column>

                <display:column headerClass="table_header large" property="warehouse.name" titleKey="whm.warehouse.name" sortName="warehouse.name" sortable="true" style="width: 10%;"/>
                <display:column headerClass="table_header_center" sortable="false" titleKey="import.warehouse.date" class="text-center" style="width: 7%;">
                    <c:choose>
                        <c:when test="${not empty tableList.importDate}">
                            <fmt:formatDate value="${tableList.importDate}" pattern="dd/MM/yyyy"/>
                        </c:when>
                        <c:when test="${not empty tableList.produceDate}">
                            <fmt:formatDate value="${tableList.produceDate}" pattern="dd/MM/yyyy"/>
                        </c:when>
                        <c:otherwise>-</c:otherwise>
                    </c:choose>
                </display:column>
                <display:column headerClass="table_header_center" sortable="false" titleKey="price.suggest" class="text-center" style="width: 15%;">
                    <input class="inputNumber width2" type="text" value="<fmt:formatNumber value="${tableList.suggestedPrice}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/>" name="suggestedItems[${tableList_rowNum - 1}].price"/>
                    <input class="inputNumber" type="hidden" value="${tableList.importProductID}" name="suggestedItems[${tableList_rowNum - 1}].itemID"/>
                </display:column>

                <display:setProperty name="paging.banner.item_name" value="cuộn tôn"/>
                <display:setProperty name="paging.banner.items_name" value="cuộn tôn"/>
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
    function searchItem(){
        $("#crudaction").val("search");
        $('.inputNumber').each(function(){
            if($(this).val() != '' && $(this).val() != 0 ) {
                $(this).val(numeral().unformat($(this).val()));
            }
        });
        submitForm('itemForm');

    }
    function suggestPrice(){
        $("#crudaction").val("suggest");
        $('.inputNumber').each(function(){
            if($(this).val() != '' && $(this).val() != 0 ) {
                $(this).val(numeral().unformat($(this).val()));
            }
        });
        submitForm('itemForm');
    }
</script>
</body>
</html>