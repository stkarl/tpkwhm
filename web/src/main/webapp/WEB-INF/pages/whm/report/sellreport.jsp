<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@page import="com.banvien.tpk.core.Constants" %>
<html>
<head>
    <title><fmt:message key="summary.sell.report.title"/></title>
    <meta name="heading" content="<fmt:message key='summary.sell.report.title'/>"/>
    <link rel="stylesheet" href="<c:url value='/themes/whm/css/jquery.jscrollpane.css' />" />
</head>
<c:url var="urlForm" value="/whm/report/sellreport.html"></c:url>
<body>
<div class="row-fluid data_content">
    <div class="content-header"><fmt:message key="summary.sell.report.title"/></div>
    <div class="clear"></div>
    <div class="report-filter">
        <form:form commandName="items" action="${urlForm}" id="itemForm" method="post" autocomplete="off" name="itemForm">
            <table class="tbReportFilter" >
                <caption><fmt:message key="label.search.title"/></caption>
                <tr>
                    <td class="label-field"><fmt:message key="label.from.sold.date"/></td>
                    <td>
                        <div class="input-append date" >
                            <fmt:formatDate var="ngayKeKhaiFrom" value="${items.fromDate}" pattern="dd/MM/yyyy"/>
                            <input name="fromDate" id="effectiveFromDate" class="prevent_type text-center width2" value="${ngayKeKhaiFrom}" type="text" />
                            <span class="add-on" id="effectiveFromDateIcon"><i class="icon-calendar"></i></span>
                        </div>
                    </td>
                    <td class="label-field"><fmt:message key="label.to.date"/></td>
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
                    <td class="label-field"><fmt:message key="label.user"/></td>
                    <td>
                        <form:select path="userID">
                            <form:option value="-1">Tất cả</form:option>
                            <form:options items="${users}" itemValue="userID" itemLabel="fullname"/>
                        </form:select>
                    </td>
                    <td class="label-field"><fmt:message key="label.customer"/></td>
                    <td>
                        <form:select path="customerID" cssStyle="width: 360px;">
                            <form:option value="-1">Tất cả</form:option>
                            <c:forEach items="${customers}" var="customer">
                                <form:option value="${customer.customerID}">${customer.name} - ${customer.province.name}</form:option>
                            </c:forEach>
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
            <div id="tbContent" style="width:100%">
            <table class="tableSadlier table-hover" border="1" style="border-right: 1px;margin: 12px 0 0 0;width: 1200px;">
                <caption><fmt:message key="summary.sell.report.title"/></caption>
                <tr>
                    <th rowspan="2" class="table_header text-center"><fmt:message key="label.stt"/></th>
                    <th rowspan="2" class="table_header text-center"><fmt:message key="label.customer"/></th>
                    <th rowspan="2" class="table_header text-center"><fmt:message key="whm.region.name"/></th>
                    <th rowspan="2" class="table_header text-center"><fmt:message key="label.todate"/></th>
                    <th rowspan="2" class="table_header text-center"><fmt:message key="label.initial.owe"/></th>
                    <th colspan="5" class="table_header text-center"><fmt:message key="label.arising"/></th>
                    <th rowspan="2" class="table_header text-center"><fmt:message key="label.pay"/></th>
                    <th rowspan="2" class="table_header text-center"><fmt:message key="remain.paid"/></th>
                    <th rowspan="2" class="table_header text-center"><fmt:message key="label.note"/></th>
                </tr>
                <tr>
                    <th class="table_header text-center"><fmt:message key="label.kem"/></th>
                    <th class="table_header text-center"><fmt:message key="label.lanh"/></th>
                    <th class="table_header text-center"><fmt:message key="label.mau"/></th>
                    <th class="table_header text-center"><fmt:message key="label.quantity"/></th>
                    <th class="table_header text-center"><fmt:message key="label.total.paid"/></th>
                </tr>
                <c:set value="0" var="initialOwe"/>
                <c:set value="0" var="kem"/>
                <c:set value="0" var="lanh"/>
                <c:set value="0" var="mau"/>
                <c:set value="0" var="totalMoney"/>
                <c:set value="0" var="totalPaid"/>
                <c:forEach items="${results}" var="result" varStatus="status">
                    <c:set value="${initialOwe + result.initialOwe}" var="initialOwe"/>
                    <c:set value="${kem + result.kem}" var="kem"/>
                    <c:set value="${lanh + result.lanh}" var="lanh"/>
                    <c:set value="${mau + result.mau}" var="mau"/>
                    <c:set value="${totalMoney + result.totalMoney}" var="totalMoney"/>
                    <c:set value="${totalPaid + result.paid}" var="totalPaid"/>
                    <tr class="${status.index % 2 == 0 ? "even" : "odd"}">
                        <td>${status.index + 1}</td>
                        <td>${result.customerName}</td>
                        <td>${result.province}</td>
                        <td><fmt:formatDate value="${result.toDate}" pattern="dd/MM/yyyy"/></td>
                        <td><fmt:formatNumber value="${result.initialOwe}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/></td>
                        <td><fmt:formatNumber value="${result.kem}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/></td>
                        <td><fmt:formatNumber value="${result.lanh}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/></td>
                        <td><fmt:formatNumber value="${result.mau}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/></td>
                        <td>
                            <c:if test="${(result.kem + result.lanh + result.mau) ne 0}">
                                <fmt:formatNumber value="${result.kem + result.lanh + result.mau}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/>
                            </c:if>
                            <c:if test="${(result.kem + result.lanh + result.mau) eq 0}">
                                -
                            </c:if>
                        </td>
                        <td><fmt:formatNumber value="${result.totalMoney}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/></td>
                        <td><fmt:formatNumber value="${result.paid}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/></td>
                        <td>
                            <c:if test="${(result.initialOwe + result.totalMoney - result.paid) ne 0}">
                                <fmt:formatNumber value="${result.initialOwe + result.totalMoney - result.paid}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/>
                            </c:if>
                            <c:if test="${(result.initialOwe + result.totalMoney - result.paid) eq 0}">
                                -
                            </c:if>
                        </td>
                        <td></td>
                    </tr>
                </c:forEach>
                <tr class="${fn:length(results) + 1 % 2 == 0 ? "even" : "odd"}" style="font-weight: bold">
                    <td colspan="4" style="text-align: center">Tổng cộng</td>
                    <td><fmt:formatNumber value="${initialOwe}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/></td>
                    <td><fmt:formatNumber value="${kem}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/></td>
                    <td><fmt:formatNumber value="${lanh}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/></td>
                    <td><fmt:formatNumber value="${mau}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/></td>
                    <td>
                        <c:if test="${(kem + lanh + mau) ne 0}">
                            <fmt:formatNumber value="${kem + lanh + mau}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/>
                        </c:if>
                        <c:if test="${(kem + lanh + mau) eq 0}">
                            -
                        </c:if>
                    </td>
                    <td><fmt:formatNumber value="${totalMoney}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/></td>
                    <td><fmt:formatNumber value="${totalPaid}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/></td>
                    <td>
                        <c:if test="${(initialOwe + totalMoney - totalPaid) ne 0}">
                            <fmt:formatNumber value="${initialOwe + totalMoney - totalPaid}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/>
                        </c:if>
                        <c:if test="${(initialOwe + totalMoney - totalPaid) eq 0}">
                            -
                        </c:if>
                    </td>
                    <td></td>
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


//        $("#btnFilter").click(function(){
//            $("#crudaction").val("search");
//            $("#itemForm").submit();
//        });
        $('#tbContent').jScrollPane();
    });
</script>
</body>
</html>