<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@page import="com.banvien.tpk.core.Constants" %>
<html>
<head>
    <title><fmt:message key="report.liability.title"/></title>
    <meta name="heading" content="<fmt:message key='report.liability.title'/>"/>
</head>
<c:url var="urlForm" value="/whm/report/liability.html"></c:url>
<body>
<div class="row-fluid data_content">
    <div class="content-header"><fmt:message key="report.liability.title"/></div>
    <div class="clear"></div>
    <div class="report-filter">
        <form:form commandName="items" action="${urlForm}" id="itemForm" method="post" autocomplete="off" name="itemForm">
            <table class="tbReportFilter" >
                <caption><fmt:message key="label.search.title"/></caption>
                <tr>
                    <td class="label-field"><fmt:message key="label.to.date"/></td>
                    <td>
                        <div class="input-append date" >
                            <fmt:formatDate var="ngayKeKhaiTo" value="${items.toDate}" pattern="dd/MM/yyyy"/>
                            <input name="toDate" id="effectiveToDate" class="prevent_type text-center width2" value="${ngayKeKhaiTo}" type="text" />
                            <span class="add-on" id="effectiveToDateIcon"><i class="icon-calendar"></i></span>
                        </div>
                    </td>
                    <td colspan="2"></td>
                </tr>
                <tr>
                    <td class="label-field"><fmt:message key="label.user"/></td>
                    <td>
                        <form:select path="userID">
                            <form:option value="">Tất cả</form:option>
                            <form:options items="${users}" itemValue="userID" itemLabel="fullname"/>
                        </form:select>
                    </td>
                    <td class="label-field"><fmt:message key="label.customer"/></td>
                    <td>
                        <form:select path="customerID" cssStyle="width: 360px;">
                            <form:option value="">Tất cả</form:option>
                            <c:forEach items="${customers}" var="customer">
                                <form:option value="${customer.customerID}">${customer.name} - ${customer.province.name}</form:option>
                            </c:forEach>
                        </form:select>
                    </td>
                </tr>

                <tr>
                    <td class="label-field"><fmt:message key="label.region"/></td>
                    <td>
                        <form:select path="regionID" onchange="changeProvince(this.value);">
                            <form:option value="">Tất cả</form:option>
                            <form:options items="${regions}" itemValue="regionID" itemLabel="name"/>
                        </form:select>
                    </td>
                    <td class="label-field"><fmt:message key="whm.province.name"/></td>
                    <td>
                        <form:select path="provinceID" id="slprovince">
                            <form:option value="">Tất cả</form:option>
                            <form:options items="${provinces}" itemValue="provinceID" itemLabel="name"/>
                        </form:select>
                    </td>
                </tr>

                <%--<tr>--%>
                    <%--<td class="label-field"><fmt:message key="label.status"/></td>--%>
                    <%--<td>--%>
                        <%--<form:select path="status">--%>
                            <%--<form:option value="">Tất cả</form:option>--%>
                            <%--<form:option value="${Constants.CUSTOMER_NORMAL}"><fmt:message key="label.normal"/></form:option>--%>
                            <%--<form:option value="${Constants.CUSTOMER_WARNING}"><fmt:message key="label.bad"/></form:option>--%>
                        <%--</form:select>--%>
                    <%--</td>--%>
                    <%--<td class="label-field"><fmt:message key="owe.more.than"/></td>--%>
                    <%--<td>--%>
                        <%--<input type="text" name="oweValue" class="inputNumber"/>--%>
                    <%--</td>--%>
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
            <table class="tableSadlier table-hover" border="1" style="border-right: 1px;margin: 12px 0 0 0;width: 100%;">
                <caption><fmt:message key="report.liability.title"/></caption>
                <tr>
                    <th class="table_header text-center"><fmt:message key="label.stt"/></th>
                    <th class="table_header text-center"><fmt:message key="label.customer"/></th>
                    <th class="table_header text-center"><fmt:message key="whm.region.name"/></th>
                    <th class="table_header text-center"><fmt:message key="label.arising.date"/></th>
                    <th class="table_header text-center"><fmt:message key="label.due.date"/></th>
                    <th class="table_header text-center"><fmt:message key="label.inital.owe"/> <fmt:formatDate value="${items.lastYear}" pattern="dd/MM/yyyy"/></th>
                    <th class="table_header text-center"><fmt:message key="label.total.bought"/> ${items.year}</th>
                    <th class="table_header text-center"><fmt:message key="label.paid"/> ${items.year}</th>
                    <th class="table_header text-center"><fmt:message key="label.remain.owe"/></th>
                </tr>
                <c:set value="0" var="initialOwe"/>
                <c:set value="0" var="totalMoney"/>
                <c:set value="0" var="totalPaid"/>
                <c:forEach items="${results}" var="result" varStatus="status">
                    <c:set value="${initialOwe + result.initialOwe}" var="initialOwe"/>
                    <c:set value="${totalMoney + result.bought}" var="totalMoney"/>
                    <c:set value="${totalPaid + result.paid}" var="totalPaid"/>
                    <tr class="${status.index % 2 == 0 ? "even" : "odd"}">
                        <td>${status.index + 1}</td>
                        <td>${result.customerName}</td>
                        <td>${result.province}</td>
                        <td><fmt:formatDate value="${result.arisingDate}" pattern="dd/MM/yyyy"/></td>
                        <td><fmt:formatDate value="${result.dueDate}" pattern="dd/MM/yyyy"/></td>
                        <td>
                            <c:if test="${!empty result.initialOwe && result.initialOwe ne 0}">
                                <fmt:formatNumber value="${result.initialOwe}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/>
                            </c:if>
                            <c:if test="${result.initialOwe eq 0 || empty result.initialOwe}">
                                -
                            </c:if>
                        </td>
                        <td>
                            <c:if test="${!empty result.bought && result.bought ne 0}">
                                <fmt:formatNumber value="${result.bought}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/>
                            </c:if>
                            <c:if test="${result.bought eq 0 || empty result.bought}">
                                -
                            </c:if>
                        </td>
                        <td>
                            <c:if test="${!empty result.paid && result.paid ne 0}">
                                <fmt:formatNumber value="${result.paid}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/>
                            </c:if>
                            <c:if test="${result.paid eq 0 || empty result.paid}">
                                -
                            </c:if>
                        </td>
                        <td>
                            <c:if test="${(result.initialOwe + result.bought - result.paid) ne 0}">
                                <fmt:formatNumber value="${result.initialOwe + result.bought - result.paid}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/>
                            </c:if>
                            <c:if test="${(result.initialOwe + result.bought - result.paid) eq 0}">
                                -
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
                <tr class="${fn:length(results) + 1 % 2 == 0 ? "even" : "odd"}" style="font-weight: bold">
                    <td colspan="4" style="text-align: center">Tổng cộng</td>
                    <td>
                        <%--<fmt:formatNumber value="${initialOwe}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/>--%>
                    </td>
                    <td></td>
                    <td><fmt:formatNumber value="${totalMoney}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/></td>
                    <td><fmt:formatNumber value="${totalPaid}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/></td>
                    <td>
                        <c:if test="${(totalMoney - totalPaid) ne 0}">
                            <fmt:formatNumber value="${initialOwe + totalMoney - totalPaid}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/>
                        </c:if>
                        <c:if test="${(totalMoney - totalPaid) eq 0}">
                            -
                        </c:if>
                    </td>
                    <%--<td></td>--%>
                </tr>
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
//            var hasInputNumber = false;
//            $('.inputNumber').each(function(){
//                if($(this).val() != '' && $(this).val() != 0 ) {
//                    hasInputNumber = true;
//                    $(this).val(numeral().unformat($(this).val()));
//                }
//            });
//            $("#itemForm").submit();
//        });
    });

    function changeProvince(value) {
        var options = document.getElementById('slprovince').options;
        options.length = 1;
        var url = '<c:url value="/ajax/getProvinceByRegion.html"/>?regionID=' + value;
        $.getJSON(url, function(data) {
            var error = data.error;
            if (error != null) {
                alert(error);
            }else if (data.array != null){
                for (i = 0; i < data.array.length; i++) {
                    var item = data.array[i];
                    options[i + 1] = new Option(item.name, item.provinceID);
                }
            }

        });
    }
</script>
</body>
</html>