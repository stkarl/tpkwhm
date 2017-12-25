<%--
  Created by IntelliJ IDEA.
  User: KhanhChu
  Date: 12/17/2017
  Time: 8:22 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<table class="tableSadlier">
    <tr>
        <th rowspan="2" class="table_header text-center"><fmt:message key="label.stt"/></th>
        <th rowspan="2" class="table_header text-center"><fmt:message key="label.staff"/></th>
        <th colspan=2" class="table_header text-center"><fmt:message key="daily.sales"/></th>
        <th colspan="2" class="table_header text-center"><fmt:message key="label.day.to.month"/></th>
    </tr>
    <tr>
        <th class="table_header text-center"><fmt:message key="label.weight.tan"/></th>
        <th class="table_header text-center"><fmt:message key="label.no.customer"/></th>
        <th class="table_header text-center"><fmt:message key="label.weight.tan"/></th>
        <th class="table_header text-center"><fmt:message key="label.no.customer"/></th>
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
        <tr class="${status.index % 2 == 0 ? "even" : "odd"} ${status.index == 0 ? 'first' : status.index == 1 ? 'second' : status.index == 2 ? 'third' : ''}">
            <td class="txtc">${status.index + 1}</td>
            <td class="txtl">${result.salesman.fullname}</td>
            <td><fmt:formatNumber value="${dailySales.weight}" pattern="###,###" maxFractionDigits="3" minFractionDigits="0"/></td>
            <td>${dailySales.noCustomer}</td>
            <td><fmt:formatNumber value="${result.totalWeight}" pattern="###,###" maxFractionDigits="3" minFractionDigits="0"/></td>
            <td>${result.totalCustomer}</td>
        </tr>
    </c:forEach>
    <tr class="${fn:length(results) + 1 % 2 == 0 ? "odd": "even"} total" style="font-weight: bold">
        <td colspan="2" style="text-align: center">Tổng cộng</td>
        <td><fmt:formatNumber value="${totalDateWeight}" pattern="###,###" maxFractionDigits="3" minFractionDigits="0"/></td>
        <td>${totalDateCustomer}</td>
        <td><fmt:formatNumber value="${totalMonthWeight}" pattern="###,###" maxFractionDigits="3" minFractionDigits="0"/></td>
        <td>${totalMonthCustomer}</td>
    </tr>
</table>


