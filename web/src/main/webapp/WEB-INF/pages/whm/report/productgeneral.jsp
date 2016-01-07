<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@page import="com.banvien.tpk.core.Constants" %>
<html>
<head>
    <title><fmt:message key="whm.menu.report.in.out.product"/></title>
    <meta name="heading" content="<fmt:message key='whm.menu.report.in.out.product'/>"/>
    <link rel="stylesheet" href="<c:url value='/themes/whm/css/jquery.jscrollpane.css' />" />
    <style>
        .no-roll{
            color: #64b7ff;
        }
        .no-roll:hover{
            cursor: pointer;
            text-decoration: underline;
        }
    </style>
</head>
<c:url var="urlForm" value="/whm/report/productgeneral.html"></c:url>
<body>
<div class="row-fluid data_content">
    <div class="content-header"><fmt:message key="whm.menu.report.in.out.product"/></div>
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
                    <td class="label-field"><fmt:message key="label.from.import.date"/></td>
                    <td>
                        <div class="input-append date" >
                            <fmt:formatDate var="fromDate" value="${items.fromDate}" pattern="dd/MM/yyyy"/>
                            <input name="fromDate" id="effectiveFromDate" class="prevent_type text-center width2" value="${fromDate}" type="text" />
                            <span class="add-on" id="effectiveFromDateIcon"><i class="icon-calendar"></i></span>
                        </div>
                    </td>
                    <td class="label-field"><fmt:message key="label.to.import.date"/></td>
                    <td>
                        <div class="input-append date" >
                            <fmt:formatDate var="toDate" value="${items.toDate}" pattern="dd/MM/yyyy"/>
                            <input name="toDate" id="effectiveToDate" class="prevent_type text-center width2" value="${toDate}" type="text" />
                            <span class="add-on" id="effectiveToDateIcon"><i class="icon-calendar"></i></span>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="label-field"><fmt:message key="main.material.name"/></td>
                    <td>
                        <form:select path="productNameID">
                            <form:options items="${productNames}" itemValue="productNameID" itemLabel="name"/>
                        </form:select>
                    </td>
                    <td class="label-field" ><fmt:message key="whm.warehouse"/></td>
                    <td>
                        <form:select path="warehouseID">
                            <form:options items="${warehouses}" itemValue="warehouseID" itemLabel="name"/>
                        </form:select>
                    </td>
                </tr>
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

            <c:forEach items="${results}" var="result">
                <table class="tableSadlier table-hover" style="border-right: 1px;text-align: center;width: 100%;vertical-align: middle;">
                    <caption>Nhập xuất tồn tôn</caption>
                    <tr>
                        <th class="table_header text-center" colspan="14">${result.specificName} từ ngày <fmt:formatDate value="${items.fromDate}" pattern="dd/MM/yyyy"/> - đến <fmt:formatDate value="${items.toDate}" pattern="dd/MM/yyyy"/> </th>
                    </tr>

                    <tr>
                        <th class="table_header text-center" rowspan="2">STT</th>
                        <th class="table_header text-center" rowspan="2"><fmt:message key="label.size"/></th>
                        <th class="table_header text-center" colspan="3"> Tồn đầu kỳ </th>
                        <th class="table_header text-center" colspan="3"> Nhập trong kỳ </th>
                        <th class="table_header text-center" colspan="3"> Xuất trong kỳ </th>
                        <th class="table_header text-center" colspan="3"> Tồn cuối kỳ </th>
                    </tr>

                    <tr>
                        <th class="table_header text-center">Cuộn</th>
                        <th class="table_header text-center">Mét</th>
                        <th class="table_header text-center">T.Lượng</th>

                        <th class="table_header text-center">Cuộn</th>
                        <th class="table_header text-center">Mét</th>
                        <th class="table_header text-center">T.Lượng</th>

                        <th class="table_header text-center">Cuộn</th>
                        <th class="table_header text-center">Mét</th>
                        <th class="table_header text-center">T.Lượng</th>

                        <th class="table_header text-center">Cuộn</th>
                        <th class="table_header text-center">Mét</th>
                        <th class="table_header text-center">T.Lượng</th>
                    </tr>

                    <c:set var="initRoll" value="0"/>
                    <c:set var="initMet" value="0"/>
                    <c:set var="initKg" value="0"/>

                    <c:set var="inRoll" value="0"/>
                    <c:set var="inMet" value="0"/>
                    <c:set var="inKg" value="0"/>

                    <c:set var="outRoll" value="0"/>
                    <c:set var="outMet" value="0"/>
                    <c:set var="outKg" value="0"/>

                    <c:set var="endRoll" value="0"/>
                    <c:set var="endMet" value="0"/>
                    <c:set var="endKg" value="0"/>



                    <c:forEach items="${result.sizes}" var="size" varStatus="status">

                        <c:set var="initRoll" value="${initRoll + result.mapInitSizeProducts[size.sizeID].noRoll}"/>
                        <c:set var="initMet" value="${initMet + result.mapInitSizeProducts[size.sizeID].met}"/>
                        <c:set var="initKg" value="${initKg + result.mapInitSizeProducts[size.sizeID].kg}"/>

                        <c:set var="inRoll" value="${inRoll + result.mapInSizeProducts[size.sizeID].noRoll}"/>
                        <c:set var="inMet" value="${inMet + result.mapInSizeProducts[size.sizeID].met}"/>
                        <c:set var="inKg" value="${inKg + result.mapInSizeProducts[size.sizeID].kg}"/>

                        <c:set var="outRoll" value="${outRoll + result.mapOutSizeProducts[size.sizeID].noRoll}"/>
                        <c:set var="outMet" value="${outMet + result.mapOutSizeProducts[size.sizeID].met}"/>
                        <c:set var="outKg" value="${outKg + result.mapOutSizeProducts[size.sizeID].kg}"/>


                        <tr class="${status.index % 2 == 0 ? "even" : "odd"}">
                            <td style="width: 30px;padding-left: 1px;">
                                ${status.index + 1}
                            </td>
                            <td style="width: 80px;">
                                    ${size.name}
                            </td>
                            <td style="width: 80px;">
                                <span class="no-roll tip-bottom" title="Mã số tôn">
                                        ${result.mapInitSizeProducts[size.sizeID].noRoll}
                                </span>
                                <div class="product-codes" style="display: none;">
                                    <c:forEach items="${result.mapInitSizeProducts[size.sizeID].importProducts}" var="product" varStatus="countProduct">
                                        <span><c:if test="${countProduct.index != 0}">, </c:if>${product.productCode}</span>
                                    </c:forEach>
                                </div>
                            </td>
                            <td style="width: 80px;">
                                <fmt:formatNumber value="${result.mapInitSizeProducts[size.sizeID].met}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/>

                            </td>
                            <td style="width: 80px;">
                                <fmt:formatNumber value="${result.mapInitSizeProducts[size.sizeID].kg}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/>
                            </td>

                            <td style="width: 80px;">
                                <span class="no-roll">
                                        ${result.mapInSizeProducts[size.sizeID].noRoll}
                                </span>
                                <div class="product-codes" style="display: none;">
                                    <c:forEach items="${result.mapInSizeProducts[size.sizeID].importProducts}" var="product" varStatus="countProduct">
                                        <span><c:if test="${countProduct.index != 0}">, </c:if>${product.productCode}</span>
                                    </c:forEach>
                                </div>
                            </td>
                            <td style="width: 80px;">
                                <fmt:formatNumber value="${result.mapInSizeProducts[size.sizeID].met}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/>
                            </td>
                            <td style="width: 80px;">
                                <fmt:formatNumber value="${result.mapInSizeProducts[size.sizeID].kg}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/>
                            </td>

                            <td style="width: 80px;">
                                <span class="no-roll">
                                        ${result.mapOutSizeProducts[size.sizeID].noRoll}
                                </span>
                                <div class="product-codes" style="display: none;">
                                    <c:forEach items="${result.mapOutSizeProducts[size.sizeID].importProducts}" var="product" varStatus="countProduct">
                                        <span><c:if test="${countProduct.index != 0}">, </c:if>${product.productCode}</span>
                                </c:forEach>
                            </div>
                        </td>
                            <td style="width: 80px;">
                                <fmt:formatNumber value="${result.mapOutSizeProducts[size.sizeID].met}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/>
                            </td>
                            <td style="width: 80px;">
                                <fmt:formatNumber value="${result.mapOutSizeProducts[size.sizeID].kg}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/>
                            </td>

                            <td style="width: 80px;">
                                    ${result.mapInitSizeProducts[size.sizeID].noRoll +  result.mapInSizeProducts[size.sizeID].noRoll - result.mapOutSizeProducts[size.sizeID].noRoll}
                            </td>
                            <td style="width: 80px;">
                                <fmt:formatNumber value="${result.mapInitSizeProducts[size.sizeID].met +  result.mapInSizeProducts[size.sizeID].met - result.mapOutSizeProducts[size.sizeID].met}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/>
                            </td>
                            <td style="width: 80px;">
                                <fmt:formatNumber value="${result.mapInitSizeProducts[size.sizeID].kg +  result.mapInSizeProducts[size.sizeID].kg - result.mapOutSizeProducts[size.sizeID].kg}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/>
                            </td>
                        </tr>
                    </c:forEach>
                    <tr style="font-weight: bold" class="${fn:length(result.sizes) % 2 == 0 ? "even" : "odd"}">
                        <td colspan="2">
                            Tổng
                        </td>

                        <td style="width: 80px;">
                            ${initRoll}
                        </td>
                        <td style="width: 80px;">
                            <fmt:formatNumber value="${initMet}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/>
                        </td>
                        <td style="width: 80px;">
                            <fmt:formatNumber value="${initKg}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/>
                        </td>

                        <td style="width: 80px;">
                            ${inRoll}
                        </td>
                        <td style="width: 80px;">
                            <fmt:formatNumber value="${inMet}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/>
                        </td>
                        <td style="width: 80px;">
                            <fmt:formatNumber value="${inKg}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/>
                        </td>

                        <td style="width: 80px;">
                                ${outRoll}
                        </td>
                        <td style="width: 80px;">
                            <fmt:formatNumber value="${outMet}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/>
                        </td>
                        <td style="width: 80px;">
                            <fmt:formatNumber value="${outKg}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/>
                        </td>

                        <td style="width: 80px;">
                                ${initRoll + inRoll - outRoll}
                        </td>
                        <td style="width: 80px;">
                            <fmt:formatNumber value="${initMet + inMet - outMet}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/>
                        </td>
                        <td style="width: 80px;">
                            <fmt:formatNumber value="${initKg + inKg - outKg}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/>
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
    function showProductCode(ele){
        var content = $(ele).html();
        bootbox.alert('Mã số tôn',content, function() {});
    }

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
        $('.no-roll').on('click',function(){
            showProductCode($(this).siblings('.product-codes'));
        })
    });



</script>
</body>
</html>