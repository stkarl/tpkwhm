<%--
  Created by IntelliJ IDEA.
  User: KhanhChu
  Date: 12/17/2017
  Time: 8:22 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%--<div id="sp-header">--%>
    <%--<table class="tableSadlier">--%>
        <%--<tr>--%>
            <%--<th rowspan="2" class="table_header text-center col-1"><fmt:message key="label.stt"/></th>--%>
            <%--<th rowspan="2" class="table_header text-center col-2"><fmt:message key="label.staff"/></th>--%>
            <%--<th colspan=2" class="table_header text-center"><fmt:message key="daily.sales"/> <fmt:formatDate value="${items.toDate}" pattern="dd/MM/yyyy"/> </th>--%>
            <%--<th colspan="2" class="table_header text-center"><fmt:message key="label.day.to.month"/></th>--%>
        <%--</tr>--%>
        <%--<tr>--%>
            <%--<th class="table_header text-center col-3"><fmt:message key="label.weight.tan.medium"/></th>--%>
            <%--<th class="table_header text-center col-4"><fmt:message key="label.no.customer"/></th>--%>
            <%--<th class="table_header text-center col-5"><fmt:message key="label.weight.tan.medium"/></th>--%>
            <%--<th class="table_header text-center col-6"><fmt:message key="label.no.customer"/></th>--%>
        <%--</tr>--%>
    <%--</table>--%>
<%--</div>--%>
<div id="sp-content">
    <table class="tableSadlier">
        <tr>
            <th rowspan="2" class="table_header text-center col-1"><fmt:message key="label.stt"/></th>
            <th rowspan="2" class="table_header text-center col-1"><fmt:message key="label.staff"/></th>
            <th colspan=2" class="table_header text-center"><fmt:message key="daily.sales"/> <fmt:formatDate value="${items.toDate}" pattern="dd/MM/yyyy"/> </th>
            <th colspan="2" class="table_header text-center"><fmt:message key="label.day.to.month"/></th>
        </tr>
        <tr>
            <th class="table_header text-center col-3"><fmt:message key="label.weight.tan.medium"/></th>
            <th class="table_header text-center col-4"><fmt:message key="label.no.customer"/></th>
            <th class="table_header text-center col-5"><fmt:message key="label.weight.tan.medium"/></th>
            <th class="table_header text-center col-6"><fmt:message key="label.no.customer"/></th>
        </tr>
        <c:set value="0" var="totalDateWeight"/>
        <c:set value="0" var="totalDateCustomer"/>
        <c:set value="0" var="totalMonthWeight"/>
        <c:set value="0" var="totalMonthCustomer"/>
        <fmt:formatDate var="currentDate" value="${items.toDate}" pattern="ddMMyyyy"/>
        <c:forEach items="${results}" var="result" varStatus="status">
            <c:set value="${result.salesman.userID}_${currentDate}" var="salesDate"/>
            <c:set value="${result.salesByDates[salesDate]}" var="dailySales"/>
            <c:set value="${totalDateWeight + dailySales.weight}" var="totalDateWeight"/>
            <c:set value="${totalDateCustomer + dailySales.noCustomer}" var="totalDateCustomer"/>
            <c:set value="${totalMonthWeight + result.totalWeight}" var="totalMonthWeight"/>
            <c:set value="${totalMonthCustomer + result.totalCustomer}" var="totalMonthCustomer"/>
            <tr class="salesman-row ${status.index % 2 == 0 ? "even" : "odd"} ${status.index == 0 ? 'first' : status.index == 1 ? 'second' : status.index == 2 ? 'third' : ''}">
                <td class="txtc col-1">${status.index + 1}</td>
                <td class="txtl col-2">${result.salesman.fullname}</td>
                <td class="col-3"><fmt:formatNumber value="${dailySales.weight}" pattern="###,###" maxFractionDigits="3" minFractionDigits="0"/></td>
                <td class="col-4">${dailySales.noCustomer}</td>
                <td class="col-5"><fmt:formatNumber value="${result.totalWeight}" pattern="###,###" maxFractionDigits="3" minFractionDigits="0"/></td>
                <td class="col-6">${result.totalCustomer}</td>
            </tr>
            <c:forEach var="monthlyCustomer" items="${result.customerConsumption}">
                <c:set var="customer" value="${monthlyCustomer.key}"/>
                <c:set var="dailyCustomerValue" value="${dailySales.customerConsumption[customer]}"/>
                <tr class="customer-detail hide ${fn:length(result.customerConsumption) > 15 ? 'more-than-15' : 'less-than-15'}">
                    <td colspan="2" class="txtr">${customer.name} - ${customer.province.name}</td>
                    <td><fmt:formatNumber value="${dailyCustomerValue}" pattern="###,###" maxFractionDigits="3" minFractionDigits="0"/></td>
                    <td>
                    </td>
                    <td>
                        <fmt:formatNumber value="${monthlyCustomer.value}" pattern="###,###" maxFractionDigits="3" minFractionDigits="0"/>
                    </td>
                    <td></td>
                </tr>
            </c:forEach>
        </c:forEach>
        <tr class="${fn:length(results) + 1 % 2 == 0 ? "odd": "even"} total" style="font-weight: bold">
            <td colspan="2" style="text-align: center">Tổng cộng</td>
            <td><fmt:formatNumber value="${totalDateWeight}" pattern="###,###" maxFractionDigits="3" minFractionDigits="0"/></td>
            <td>${totalDateCustomer}</td>
            <td><fmt:formatNumber value="${totalMonthWeight}" pattern="###,###" maxFractionDigits="3" minFractionDigits="0"/></td>
            <td>${totalMonthCustomer}</td>
        </tr>
    </table>

</div>


