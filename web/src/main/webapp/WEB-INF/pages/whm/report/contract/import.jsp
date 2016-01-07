<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@page import="com.banvien.tpk.core.Constants" %>
<html>
<head>
    <title><fmt:message key="report.contract.import"/></title>
    <meta name="heading" content="<fmt:message key='report.contract.import'/>"/>
</head>
<c:url var="urlForm" value="/whm/report/contract/import.html"></c:url>
<body>
<div class="row-fluid data_content">
    <div class="content-header"><fmt:message key="report.contract.import"/></div>
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
                    <td class="label-field" ><fmt:message key="whm.customer.name"/></td>
                    <td>
                        <form:select path="customerID" cssStyle="width: 360px;">
                            <form:option value="-1">Tất cả</form:option>
                            <c:forEach items="${customers}" var="customer">
                                <form:option value="${customer.customerID}">${customer.name} - ${customer.province.name}</form:option>
                            </c:forEach>
                        </form:select>
                    </td>
                    <td class="label-field" ></td>
                    <td>
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

            <table class=" tableSadlier table-hover">
                <caption><fmt:message key="report.contract.import"/></caption>
                <tr>
                    <th class="table_header_center">STT</th>
                    <th class="table_header_center"><fmt:message key="contract.code"/></th>
                    <th class="table_header_center"><fmt:message key="whm.customer.name"/></th>
                    <th class="table_header_center"><fmt:message key="contract.date"/></th>
                    <%--<th class="table_header_center"><fmt:message key="label.no.roll"/></th>--%>
                    <th class="table_header_center"><fmt:message key="label.weight.tan"/></th>
                    <th class="table_header_center"><fmt:message key="imported.roll"/></th>
                    <th class="table_header_center"><fmt:message key="imported.weight.tan"/></th>
                    <th class="table_header_center"></th>
                </tr>
                <c:forEach items="${results}" var="result" varStatus="mainStatus">
                    <tr class="${mainStatus.index % 2 == 0 ? "even" : "odd"}">
                        <td>${mainStatus.index + 1}</td>
                        <td>${result.code}</td>
                        <td>${result.customerName}</td>
                        <td><fmt:formatDate value="${result.startDate}" pattern="dd/MM/yyyy"/></td>
                        <%--<td>${result.noRoll}</td>--%>
                        <td><fmt:formatNumber value="${result.weight}" pattern="###,###.###"/></td>
                        <td>${fn:length(result.importProducts)}</td>
                        <td><fmt:formatNumber value="${result.totalWeight / 1000}" pattern="###,###.###"/></td>
                        <td>
                            <a id="${result.buyContractID}" onclick="viewDetail(this);" class="icon-plus tip-top" title="<fmt:message key="show.detail"/>"></a>
                        </td>
                    </tr>
                    <tr id="detail-${result.buyContractID}" style="display: none;">
                        <td colspan="8">
                            <table class="tableSadlier table-product-list table-hover">
                                <tr id="tbHead">
                                    <th class="table_header_center">STT</th>
                                    <%--<th class="table_header_center"><fmt:message key="whm.productname.name"/></th>--%>
                                    <th class="table_header_center"><fmt:message key="label.code"/></th>
                                    <th class="table_header_center"><fmt:message key="label.size"/> (mmxmm)</th>
                                    <th class="table_header_center" ><fmt:message key="label.quantity.pure"/></th>
                                    <th class="table_header_center" ><fmt:message key="label.quantity.overall"/></th>
                                    <th class="table_header_center" ><fmt:message key="label.quantity.actual"/></th>
                                    <th class="table_header_center" ><fmt:message key="label.difference"/></th>
                                    <th class="table_header_center"><fmt:message key="label.made.in"/></th>
                                    <security:authorize ifAnyGranted="NHANVIENTT,QUANLYTT,LANHDAO">
                                        <th class="table_header_center"><fmt:message key="label.price.vnd"/></th>
                                    </security:authorize>
                                </tr>
                                <c:set var="total" value="0"/>
                                <c:set var="totalPure" value="0"/>
                                <c:set var="totalActual" value="0"/>
                                <c:forEach items="${result.importProducts}" var="importProduct" varStatus="status">
                                    <tr id="prd_${status.index}" class="${status.index % 2 == 0 ? "even" : "odd"}">
                                        <td style="width: 3%">${status.index + 1}</td>
                                        <%--<td class="inputItemInfo0">${importProduct.productname.name}</td>--%>
                                        <td class="inputItemInfo1">${importProduct.productCode}</td>
                                        <td class="inputItemInfo0">${importProduct.size.name}</td>
                                        <td class="inputItemInfo0"><span id="quantity_${status.index}"><fmt:formatNumber value="${importProduct.quantity2Pure}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/></span></td>
                                        <td class="inputItemInfo0"><fmt:formatNumber value="${importProduct.quantity2}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/></td>
                                        <td class="inputItemInfo0"><fmt:formatNumber value="${importProduct.quantity2Actual}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/></td>
                                        <td class="inputItemInfo0">
                                            <c:if test="${not empty importProduct.quantity2 && not empty importProduct.quantity2Actual}">
                                                <fmt:formatNumber value="${importProduct.quantity2Actual - importProduct.quantity2}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/>
                                            </c:if>
                                        </td>
                                        <td class="inputItemInfo0">${importProduct.origin.name}</td>
                                        <security:authorize ifAnyGranted="NHANVIENTT,QUANLYTT,LANHDAO">
                                            <td class="inputItemInfo0">
                                                <fmt:formatNumber value="${importProduct.money}" pattern="###,###.##" maxFractionDigits="2" minFractionDigits="0"/>
                                            </td>
                                        </security:authorize>
                                    </tr>
                                    <c:set var="total" value="${total + importProduct.quantity2}"/>
                                    <c:set var="totalPure" value="${totalPure + importProduct.quantity2Pure}"/>
                                    <c:set var="totalActual" value="${totalActual + importProduct.quantity2Actual}"/>
                                </c:forEach>
                                <tr style="font-weight: bold;">
                                    <td colspan="3" style="text-align: right"><fmt:message key="label.total"/></td>
                                    <td style="text-align: center;">${fn:length(result.importProducts)} CUỘN</td>
                                    <td style="text-align: center;"><fmt:formatNumber value="${totalPure}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/></td>
                                    <td style="text-align: center;"><fmt:formatNumber value="${total}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/></td>
                                    <td style="text-align: center;"><fmt:formatNumber value="${totalActual}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/></td>
                                    <td style="text-align: center;">
                                        <c:if test="${total > 0 && totalActual > 0}">
                                            <fmt:formatNumber value="${totalActual - total}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/>
                                        </c:if>
                                    </td>
                                    <td></td>
                                    <security:authorize ifAnyGranted="NHANVIENTT,QUANLYTT,LANHDAO">
                                        <td><fmt:formatNumber value="${result.totalMoney}" pattern="###,###.##" maxFractionDigits="2" minFractionDigits="0"/></td>
                                    </security:authorize>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </c:forEach>
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
        $('#effectiveToDateIcon').click(function() {
            $('#effectiveToDate').focus();
            return true;
        });
        $('#effectiveFromDateIcon').click(function() {
            $('#effectiveFromDate').focus();
            return true;
        });


//        $("#btnFilter").click(function(){
//            $("#crudaction").val("search");
//            $("#itemForm").submit();
//        });
    });
    function viewDetail(ele){
        var id = $(ele).attr('id');
        if($(ele).hasClass('icon-plus')){
            $('#detail-' + id).show();
            $(ele).removeClass('icon-plus');
            $(ele).addClass('icon-minus');
            $(ele).attr('data-original-title','<fmt:message key="hide.detail"/>');

        }else{
            $('#detail-' + id).hide();
            $(ele).removeClass('icon-minus');
            $(ele).addClass('icon-plus');
            $(ele).attr('data-original-title','<fmt:message key="show.detail"/>');
        }

    }
</script>
</body>
</html>