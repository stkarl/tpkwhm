<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@page import="com.banvien.tpk.core.Constants" %>
<html>
<head>
    <title><fmt:message key="report.produced.product.title"/></title>
    <meta name="heading" content="<fmt:message key='report.produced.product.title'/>"/>
    <link rel="stylesheet" href="<c:url value='/themes/whm/css/jquery.jscrollpane.css' />" />
</head>
<c:url var="urlForm" value="/whm/report/produce/product.html"></c:url>
<body>
<div class="row-fluid data_content">
<div class="content-header"><fmt:message key="report.produced.product.title"/></div>
<div class="clear"></div>
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
        <td class="label-field"><fmt:message key="label.instock.from.date"/></td>
        <td>
            <div class="input-append date" >
                <fmt:formatDate var="ngayKeKhaiFrom" value="${items.fromDate}" pattern="dd/MM/yyyy"/>
                <input name="fromDate" id="effectiveFromDate" class="prevent_type text-center width2" value="${ngayKeKhaiFrom}" type="text" />
                <span class="add-on" id="effectiveFromDateIcon"><i class="icon-calendar"></i></span>
            </div>
        </td>
        <td class="label-field"><fmt:message key="label.instock.to.date"/></td>
        <td>
            <div class="input-append date" >
                <fmt:formatDate var="ngayKeKhaiTo" value="${items.toDate}" pattern="dd/MM/yyyy"/>
                <input name="toDate" id="effectiveToDate" class="prevent_type text-center width2" value="${ngayKeKhaiTo}" type="text" />
                <span class="add-on" id="effectiveToDateIcon"><i class="icon-calendar"></i></span>
            </div>
        </td>
    </tr>
    <tr>
        <td class="label-field"><fmt:message key="main.material.name"/></td>
        <td>
            <form:select path="productNameID">
                <form:option value="-1">Tất cả</form:option>
                <form:options items="${productNames}" itemValue="productNameID" itemLabel="name"/>
            </form:select>
            <form:hidden path="productNameCode"/>
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
        <td class="label-field"><fmt:message key="whm.market.name"/></td>
        <td>
            <form:select path="marketID">
                <form:option value="-1">Tất cả</form:option>
                <form:options items="${markets}" itemValue="marketID" itemLabel="name"/>
            </form:select>
        </td>
        <td class="label-field"></td>
        <td></td>
    </tr>
    <tr style="text-align: center;">
        <td colspan="4">
            <a id="btnFilter" class="btn btn-primary " onclick="submitForm('itemForm');"><i class="icon-refresh"></i> <fmt:message key="label.report"/> </a>
            <c:if test="${fn:length(items.listResult) > 0}">
                <a id="btnExport" class="btn btn-info " onclick="submitExport('itemForm');"><i class="icon-arrow-down"></i> <fmt:message key="label.export.excel"/> </a>
            </c:if>
        </td>
    </tr>
</table>
<div class="clear"></div>
<div id="tbContent" style="width:100%; max-height: 500px;">
    <table class="tableSadlier table-hover" border="1" style="border-right: 1px;margin: 12px 0 0 0;width: 1700px;">
        <caption><fmt:message key="production.report"/></caption>
        <tr>
            <th rowspan="2" class="table_header text-center"><fmt:message key="label.stt"/></th>
            <th rowspan="2" class="table_header text-center"><fmt:message key="label.import.date"/></th>
            <th colspan="6" class="table_header text-center"><fmt:message key="label.main.material"/></th>
            <th colspan="4" class="table_header  text-center"><fmt:message key="label.production"/></th>
            <th colspan="${fn:length(qualities) + 1}" class="table_header  text-center"><fmt:message key="produced.product.quality"/></th>
            <th colspan="2" class="table_header text-center"><fmt:message key="material.stick"/></th>
            <th rowspan="2" class="table_header"><fmt:message key="label.tm.kg.m"/></th>
            <th rowspan="2" class="table_header"><fmt:message key="main.material.note"/></th>
            <th rowspan="2" class="table_header"><fmt:message key="label.produce.team"/></th>
        </tr>
        <tr>
            <th class="table_header"><fmt:message key="label.name"/></th>
            <th class="table_header"><fmt:message key="label.size"/></th>
            <th class="table_header"><fmt:message key="label.code"/></th>
            <th class="table_header"><fmt:message key="label.kg"/></th>
            <th class="table_header"><fmt:message key="label.m"/></th>
            <th class="table_header"><fmt:message key="label.cut.off"/></th>
            <th class="table_header"><fmt:message key="label.name"/></th>
            <th class="table_header"><fmt:message key="label.code"/></th>
            <th class="table_header"><fmt:message key="label.kg"/></th>
            <th class="table_header"><fmt:message key="label.core"/></th>
            <c:forEach items="${qualities}" var="quality">
                <th class="table_header">${quality.name}</th>
            </c:forEach>
            <th class="table_header"><fmt:message key="label.total.m"/></th>
            <th class="table_header"><fmt:message key="label.kg.kg"/></th>
            <th class="table_header"><fmt:message key="label.kg.m2"/></th>
        </tr>
        <c:set value="1" var="stt"/>
        <c:set value="0" var="materialKg"/>
        <c:set value="0" var="materialM"/>
        <c:set value="0" var="materialCutOff"/>
        <c:set value="0" var="productKg"/>
        <c:set value="0" var="overallQuality"/>

        <c:forEach items="${items.listResult}" var="tableList">
            <c:set value="${fn:length(tableList.producedProducts)}" var="counter"/>
            <c:forEach items="${tableList.producedProducts}" var="product" varStatus="status">
                <tr>
                    <td style="text-align: center">${stt}</td>
                    <td style="text-align: center">
                        <c:choose>
                            <c:when test="${not empty product.produceDate}">
                                <fmt:formatDate value="${product.produceDate}" pattern="dd/MM/yyyy"/>
                            </c:when>
                            <c:when test="${not empty product.importDate}">
                                <fmt:formatDate value="${product.importDate}" pattern="dd/MM/yyyy"/>
                            </c:when>
                            <c:otherwise>-</c:otherwise>
                        </c:choose>
                    </td>
                    <c:choose>
                        <c:when test="${status.index == 0}">
                            <td rowspan="${counter}" style="white-space: nowrap;">
                                    ${tableList.mainMaterial.productname.name}
                            </td>
                            <td rowspan="${counter}">
                                    ${tableList.mainMaterial.size.name}
                            </td>
                            <td rowspan="${counter}">
                                    ${tableList.mainMaterial.productCode}
                                (<c:choose>
                                    <c:when test="${not empty tableList.mainMaterial.origin}">${tableList.mainMaterial.origin.name}</c:when>
                                    <c:when test="${not empty tableList.mainMaterial.mainUsedMaterial.origin}">${tableList.mainMaterial.mainUsedMaterial.origin.name}</c:when>
                                    <c:when test="${not empty tableList.mainMaterial.mainUsedMaterial.mainUsedMaterial.origin}">${tableList.mainMaterial.mainUsedMaterial.mainUsedMaterial.origin.name}</c:when>
                                </c:choose>)
                            </td>
                            <td rowspan="${counter}">
                                <c:set value="${empty tableList.mainMaterial.importBack ? tableList.mainMaterial.quantity2Pure : tableList.mainMaterial.quantity2Pure - tableList.mainMaterial.importBack}" var="tempMaterialKg"/>
                                <fmt:formatNumber value="${tempMaterialKg}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/>
                                <c:set value="${materialKg + tempMaterialKg}" var="materialKg"/>
                            </td>
                            <td rowspan="${counter}">
                                <fmt:formatNumber value="${tableList.mainMaterial.quantity1}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/>
                                <c:set value="${materialM + tableList.mainMaterial.quantity1}" var="materialM"/>
                            </td>
                            <td rowspan="${counter}">
                                <fmt:formatNumber value="${tableList.mainMaterial.cutOff}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/>
                                <c:set value="${materialCutOff + tableList.mainMaterial.cutOff}" var="materialCutOff"/>
                            </td>
                        </c:when>
                        <c:when test="${counter <= 1 || status.index != 0}">
                        </c:when>
                    </c:choose>
                    <td style="white-space: nowrap;">
                            ${product.productname.name} <c:if test="${!empty product.thickness}"> (${product.thickness.name}) </c:if>
                    </td>
                    <td>
                            ${product.productCode}
                    </td>
                    <td>
                        <fmt:formatNumber value="${product.quantity2Pure}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/>
                        <c:set value="${productKg + product.quantity2Pure}" var="productKg"/>
                    </td>
                    <td>
                            ${product.core}
                    </td>
                    <c:set var="totalQuality" value="0"/>
                    <c:forEach items="${qualities}" var="quality">
                        <td>
                            <span class="quality-${quality.qualityID}">
                                <fmt:formatNumber value="${product.qualityQuantityMap[quality.qualityID]}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/>
                            </span>
                            <c:set var="totalQuality" value="${totalQuality + product.qualityQuantityMap[quality.qualityID]}"/>
                        </td>
                    </c:forEach>
                    <c:set value="${overallQuality + totalQuality}" var="overallQuality"/>
                    <td ><fmt:formatNumber value="${totalQuality}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/></td>
                    <td>
                        <c:set value="${tableList.totalStick / tempMaterialKg}" var="kgOkg"/>
                        <fmt:formatNumber value="${kgOkg}" pattern="#,###.###" maxFractionDigits="3" minFractionDigits="0"/>
                    </td>
                    <td>
                        <fmt:formatNumber value="${kgOkg * product.quantity2Pure / (tpk:productWidth(product.size.name) * totalQuality)}" pattern="#,###.###" maxFractionDigits="3" minFractionDigits="0"/>
                    <td>
                        <fmt:formatNumber value="${product.quantity2Pure/totalQuality}" pattern="#,###.###" maxFractionDigits="2" minFractionDigits="2"/>
                    </td>
                    <td>
                            ${product.note}
                    </td>
                    <td style="white-space: nowrap;">${product.importproductbill.productionPlan.team.name} - ${product.importproductbill.productionPlan.shift.name}</td>
                    <c:set var="stt" value="${stt + 1}"/>
                </tr>
            </c:forEach>
        </c:forEach>
        <tr style="font-weight: bold">
            <td style="text-align: center" colspan="4">Tổng:</td>
            <td>
                    ${fn:length(items.listResult)} cuộn
            </td>
            <td>
                <fmt:formatNumber value="${materialKg}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/>
            </td>
            <td>
                <fmt:formatNumber value="${materialM}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/>
            </td>
            <td>
                <fmt:formatNumber value="${materialCutOff}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/>
            </td>

            <td style="white-space: nowrap;">
            </td>
            <td>
            </td>
            <td>
                <fmt:formatNumber value="${productKg}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/>
            </td>
            <td>
                <fmt:formatNumber value="${productCore}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/>
            </td>
            <c:set var="totalQuality" value="0"/>
            <c:forEach items="${qualities}" var="quality">
                <td>
                    <span id="total-quality-${quality.qualityID}"></span>
                </td>
            </c:forEach>
            <td>
                <fmt:formatNumber value="${overallQuality}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/>
            </td>
            <td></td>
            <td></td>
            <td>
                <%--<fmt:formatNumber value="${productKg/overallQuality}" pattern="###,###" maxFractionDigits="2" minFractionDigits="0"/>--%>
            </td>
            <td style="white-space: nowrap;">
            </td>
            <td style="white-space: nowrap;">
            </td>
        </tr>
    </table>
</div>
<form:hidden path="crudaction" id="crudaction"/>
</form:form>
</div>
</div>
<script src="<c:url value="/themes/whm/scripts/bootstrap/jscrollpane.js"/>"></script>

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
        <c:forEach items="${qualities}" var="quality">
        var id = ${quality.qualityID};
        var overall = 0;
            $('.quality-' + id).each(function(){
                if($(this).text() != null && $.trim($(this).text()) != ''){
                    overall += numeral().unformat($.trim($(this).text()));
                }
            });
        $('#total-quality-' + id).text(numeral(overall).format('###,###'))
        </c:forEach>
        $('#tbContent').jScrollPane();
    });
    function submitForm(){
        $("#crudaction").val("search");
        $("#itemForm").submit();
    }
</script>
</body>
</html>