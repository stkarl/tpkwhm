<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@page import="com.banvien.tpk.core.Constants" %>
<html>
<head>
    <title><fmt:message key="whm.menu.report.summary.production"/></title>
    <meta name="heading" content="<fmt:message key='whm.menu.report.summary.production'/>"/>
    <link rel="stylesheet" href="<c:url value='/themes/whm/css/jquery.jscrollpane.css' />" />
</head>
<c:url var="urlForm" value="/whm/report/summaryproduction.html"></c:url>
<body>
<div class="row-fluid data_content">
    <div class="content-header"><fmt:message key="whm.menu.report.summary.production"/></div>
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
                    <td class="label-field"><fmt:message key="main.material.name"/></td>
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
                <%--<tr>--%>
                    <%--<td class="label-field"><fmt:message key="label.location"/></td>--%>
                    <%--<td>--%>
                        <%--<form:select path="warehouseMapID">--%>
                            <%--<form:option value="-1">Tất cả</form:option>--%>
                            <%--<form:options items="${warehouseMaps}" itemValue="warehouseMapID" itemLabel="name"/>--%>
                        <%--</form:select>--%>
                    <%--</td>--%>
                    <%--<td class="label-field" ></td>--%>
                    <%--<td></td>--%>
                <%--</tr>--%>
                <tr style="text-align: center;">
                    <td colspan="4">
                        <a id="btnFilter" class="btn btn-primary " onclick="submitReport('itemForm');"><i class="icon-refresh"></i> <fmt:message key="label.search"/> </a>
                        <c:if test="${fn:length(results) > 0}">
                            <a id="btnExport" class="btn btn-info " onclick="submitExport('itemForm');"><i class="icon-arrow-down"></i> <fmt:message key="label.export.excel"/> </a>
                        </c:if>
                    </td>
                </tr>
            </table>
            <div class="clear"></div>
            <c:set var="qualitySize" value="${fn:length(qualities)}"/>
            <c:forEach items="${results}" var="result">
                <c:set var="counter" value="1"/>
                <table class="tableSadlier table-hover" style="border-right: 1px;text-align: center;width: 100%;vertical-align: middle;">
                    <caption>Tổng hợp sản xuất</caption>
                    <tr>
                        <th class="table_header text-center" rowspan="2">STT</th>
                        <th class="table_header text-center" rowspan="2"><fmt:message key="label.size"/> (mmxmm)</th>
                        <th class="table_header text-center" rowspan="2">Phân loại</th>
                        <th class="table_header text-center" colspan="2">${result.materialName}</th>
                        <th class="table_header text-center" colspan="2">${result.productName}</th>
                        <th class="table_header text-center" colspan="${qualitySize + 1}">Chất lượng sản phẩm</th>
                        <th class="table_header text-center" rowspan="2">Quy m2</th>
                    </tr>
                    <tr>
                        <th class="table_header text-center">Số cuộn</th>
                        <th class="table_header text-center">T.Lượng(kg)</th>
                        <th class="table_header text-center">Số cuộn</th>
                        <th class="table_header text-center">T.Lượng(kg)</th>
                        <c:forEach items="${qualities}" var="quality">
                            <th class="table_header text-center">${quality.name}</th>
                        </c:forEach>
                        <th class="table_header text-center">Tổng</th>

                    </tr>
                    <c:forEach items="${result.summaryProductionDetails}" var="detail" varStatus="status">
                        <tr class="${status.index % 2 == 0 ? "even" : "odd"}">
                            <td style="width: 30px;padding-left: 1px;">
                                    ${counter}
                            </td>
                            <td style="width: 80px;">
                                    ${detail.size}
                            </td>
                            <td style="width: 80px;">
                                    ${detail.specific}
                            </td>
                            <td style="width: 80px;">
                                    ${detail.noMaterialRoll}
                            </td>
                            <td style="width: 80px;">
                                <a class="tip-top" title="${detail.originQuantityHTML}"><fmt:formatNumber value="${not empty detail.materialKg ? detail.materialKg : 0}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/></a>
                            </td>
                            <td style="width: 80px;">
                                    ${detail.noProductRoll}
                            </td>
                            <td style="width: 80px;">
                                <fmt:formatNumber value="${not empty detail.productKg ? detail.productKg : 0}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/>
                            </td>
                            <c:forEach items="${qualities}" var="quality">
                                <td style="width: 60px;"><fmt:formatNumber value="${not empty detail.mapQualityMet[quality.qualityID] ? detail.mapQualityMet[quality.qualityID] : 0}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/></td>
                            </c:forEach>
                            <td style="width: 80px;">
                                <fmt:formatNumber value="${not empty detail.totalMet ? detail.totalMet : 0}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/>
                            </td>
                            <td style="width: 80px;">
                                <fmt:formatNumber value="${not empty detail.totalMet2 ? detail.totalMet2 : 0}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/>
                            </td>
                        </tr>
                        <c:set var="counter" value="${counter + 1}"/>
                    </c:forEach>
                    <tr style="font-weight: bold" class="${fn:length(result.summaryProductionDetails) % 2 == 0 ? "even" : "odd"}">
                        <c:set var="overallDetail" value="${result.overallDetail}"/>

                        <td colspan="3">
                            Tổng:
                        </td>
                        <td style="width: 80px;">
                                ${overallDetail.noMaterialRoll}
                        </td>
                        <td style="width: 80px;">
                            <a class="tip-top" title="${overallDetail.originQuantityHTML}"><fmt:formatNumber value="${not empty overallDetail.materialKg ? overallDetail.materialKg : 0}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/></a>
                        </td>
                        <td style="width: 80px;">
                                ${overallDetail.noProductRoll}
                        </td>
                        <td style="width: 80px;">
                            <fmt:formatNumber value="${not empty overallDetail.productKg ? overallDetail.productKg : 0}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/>
                        </td>
                        <c:forEach items="${qualities}" var="quality">
                            <td style="width: 60px;"><fmt:formatNumber value="${not empty overallDetail.mapQualityMet[quality.qualityID] ? overallDetail.mapQualityMet[quality.qualityID] : 0}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/></td>
                        </c:forEach>
                        <td style="width: 80px;">
                            <fmt:formatNumber value="${not empty overallDetail.totalMet ? overallDetail.totalMet : 0}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/>
                        </td>
                        <td style="width: 80px;">
                            <fmt:formatNumber value="${not empty overallDetail.totalMet2 ? overallDetail.totalMet2 : 0}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/>
                        </td>
                    </tr>
                </table>
            </c:forEach>
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
    });
</script>
</body>
</html>