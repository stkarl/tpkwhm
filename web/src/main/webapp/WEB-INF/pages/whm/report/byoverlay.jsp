<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@page import="com.banvien.tpk.core.Constants" %>
<html>
<head>
    <title><fmt:message key="whm.menu.report.by.overlay"/></title>
    <meta name="heading" content="<fmt:message key='whm.menu.report.by.overlay'/>"/>
    <link rel="stylesheet" href="<c:url value='/themes/whm/css/jquery.jscrollpane.css' />" />
</head>
<c:url var="urlForm" value="/whm/report/byoverlay.html"></c:url>
<body>
<div class="row-fluid data_content">
    <div class="content-header"><fmt:message key="whm.menu.report.by.overlay"/></div>
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
                <%--<c:set var="tableWidth" value="1036"/>--%>
                <%--<c:if test="${fn:length(result.overlayTypes) > 1}">--%>
                    <%--<c:set var="tableWidth" value="${fn:length(result.overlayTypes) * 700}"/>--%>
                <%--</c:if>--%>

                <div class="reportTable" style="width: 100%">
                    <table class="tableSadlier table-hover" style="border-right: 1px;margin: 12px 0 24px 0;text-align: center;width: ${fn:length(result.overlayTypes) > 1 ? fn:length(result.overlayTypes) * 400 : 1036}px">
                        <caption>Tổng hợp sản xuất theo quy cách và lớp phủ</caption>
                        <tr>
                            <th class="table_header text-center" colspan="2" rowspan="2"></th>
                            <c:forEach items="${result.overlayTypes}" var="overlay">
                                <th class="table_header text-center" colspan="${qualitySize + 3}">${overlay.name}</th>
                            </c:forEach>
                        </tr>
                        <tr>
                            <c:forEach items="${result.overlayTypes}" var="overlay">
                                <th class="table_header text-center">${result.materialName}</th>
                                <th class="table_header text-center" colspan="${qualitySize + 2}">${result.productName}</th>
                            </c:forEach>
                        </tr>
                        <tr>
                            <th class="table_header text-center">STT</th>
                            <th class="table_header text-center"><fmt:message key="label.size"/></th>
                            <c:forEach items="${result.overlayTypes}" var="overlay">
                                <th class="table_header text-center">T.L(Kg)</th>
                                <th class="table_header text-center">T.L(Kg)</th>
                                <c:forEach items="${qualities}" var="qualitie">
                                    <th class="table_header text-center">${qualitie.name}</th>
                                </c:forEach>
                                <th class="table_header text-center">Mét</th>
                            </c:forEach>
                        </tr>
                        <c:forEach items="${result.sizes}" var="size" varStatus="status">
                            <c:set var="sizeID" value="${size.sizeID}"/>
                            <tr class="${status.index % 2 == 0 ? "even" : "odd"}">
                                <td style="width: 30px;padding-left: 1px;">
                                    ${counter}
                                </td>
                                <td style="width: 80px;">
                                        ${size.name}
                                </td>
                                <c:forEach items="${result.overlayTypes}" var="overlay">
                                    <c:set var="overlayID" value="${overlay.overlayTypeID}"/>
                                    <c:set var="detail" value="${result.mapSizeOverlayDetail[sizeID][overlayID]}"/>
                                    <td style="width: 80px;"><a class="tip-top" title="${detail.originQuantityHTML}"><fmt:formatNumber value="${not empty detail.materialKg ? detail.materialKg : 0}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/></a></td>
                                    <td style="width: 80px;"><fmt:formatNumber value="${not empty detail.productKg ? detail.productKg : 0}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/></td>
                                    <c:forEach items="${qualities}" var="quality">
                                        <td style="width: 60px;"><fmt:formatNumber value="${not empty detail.mapQualityMet[quality.qualityID] ? detail.mapQualityMet[quality.qualityID] : 0}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/></td>
                                    </c:forEach>
                                    <td style="width: 80px;"><fmt:formatNumber value="${not empty detail.productMet ? detail.productMet : 0}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/></td>
                                </c:forEach>
                            </tr>
                            <c:set var="counter" value="${counter + 1}"/>
                        </c:forEach>
                        <tr style="font-weight: bold" class="${fn:length(result.sizes) % 2 == 0 ? "even" : "odd"}">
                            <td colspan="2">
                                Tổng:
                            </td>
                            <c:forEach items="${result.overlayTypes}" var="overlay">
                                <c:set var="detailTotal" value="${result.mapTotalSummary[overlay.overlayTypeID]}"/>
                                <td><a class="tip-top" title="${result.mapOverlaySummaryOriginQuantity[overlay.overlayTypeID]}"><fmt:formatNumber value="${detailTotal.materialKg}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/></a></td>
                                <td><fmt:formatNumber value="${detailTotal.productKg}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/></td>
                                <c:forEach items="${qualities}" var="quality">
                                    <td><fmt:formatNumber value="${not empty detailTotal.mapQualityMet[quality.qualityID] ? detailTotal.mapQualityMet[quality.qualityID] : 0}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/></td>
                                </c:forEach>
                                <td><fmt:formatNumber value="${detailTotal.productMet}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/></td>
                            </c:forEach>
                        </tr>
                    </table>
                </div>
                <div class="clear"></div>
            </c:forEach>
            <form:hidden path="crudaction" id="crudaction"/>
        </form:form>
    </div>
</div>
<script src="<c:url value="/themes/whm/scripts/bootstrap/jscrollpane.js"/>"></script>
<script type="text/javascript">
    $(document).ready(function(){
        $('.reportTable').each(function(){
            $(this).jScrollPane();
        });
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
    function showSummaryByOrigin(form){
        var modal = bootbox.dialog(form, [
            {
                "label" :  "<i class='icon-remove-sign'></i> <fmt:message key="button.cancel"/>",
                "class" : "btn-small btn-primary",
                "callback" : function(){
                    form.remove();
                }
            }],
                {
                    "onEscape": function(){
                        form.remove();
                    }
                });
        modal.modal("show");
    }
</script>
</body>
</html>