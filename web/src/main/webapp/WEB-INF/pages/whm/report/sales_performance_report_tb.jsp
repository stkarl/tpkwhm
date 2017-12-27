<%--
  Created by IntelliJ IDEA.
  User: KhanhChu
  Date: 12/17/2017
  Time: 8:22 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<div class="tb_left">
    <table class="tableSadlier">
        <tr>
            <th class="table_header text-center stt"><fmt:message key="label.stt"/></th>
            <th class="table_header text-center staff-name"><fmt:message key="label.staff"/></th>
        </tr>
        <tr>
            <th style="color:#97C5A8;" class="table_header text-center stt"><fmt:message key="label.stt"/></th>
            <th style="color:#97C5A8;" class="table_header text-center staff-name"><fmt:message key="label.staff"/></th>
        </tr>
        <c:forEach items="${results}" var="result" varStatus="status">
            <tr class="${status.index % 2 == 0 ? "even" : "odd"} ${status.index == 0 ? 'first' : status.index == 1 ? 'second' : status.index == 2 ? 'third' : ''}">
                <td class="stt txtc">${status.index + 1}</td>
                <td class="txtl staff-name">${result.salesman.fullname}</td>
            </tr>
        </c:forEach>
        <tr class="${fn:length(results) + 1 % 2 == 0 ? "odd": "even"} total" style="font-weight: bold">
            <td colspan="2" style="text-align: center">Tổng cộng</td>
        </tr>
    </table>
</div>
<div id="tbContent">
    <div class="tb_center">
        <table class="tableSadlier">
            <tr>
                <c:forEach var="date" items="${dates}">
                    <th colspan=2" class="table_header text-center">
                        <fmt:formatDate value="${date}" pattern="dd/MM/yyyy"/>
                    </th>
                </c:forEach>
                <th colspan="2" class="table_header text-center"><fmt:message key="label.day.to.month"/></th>
            </tr>
            <tr>
                <c:forEach var="date" items="${dates}">
                    <th class="table_header text-center"><fmt:message key="label.weight.tan.short"/></th>
                    <th class="table_header text-center"><fmt:message key="label.no.customer.short"/></th>
                </c:forEach>
                <th class="table_header text-center"><fmt:message key="label.weight.tan.short"/></th>
                <th class="table_header text-center"><fmt:message key="label.no.customer.short"/></th>
            </tr>
            <%--<c:set value="0" var="totalDateWeight"/>--%>
            <%--<c:set value="0" var="totalDateCustomer"/>--%>
            <%--<c:set value="0" var="totalMonthWeight"/>--%>
            <%--<c:set value="0" var="totalMonthCustomer"/>--%>
            <c:forEach items="${results}" var="result" varStatus="status">

                <tr class="${status.index % 2 == 0 ? "even" : "odd"} ${status.index == 0 ? 'first' : status.index == 1 ? 'second' : status.index == 2 ? 'third' : ''}">
                    <c:forEach var="date" items="${dates}">
                        <fmt:formatDate var="currentDate" value="${date}" pattern="ddMMyyyy"/>
                        <c:set value="${result.salesman.userID}_${currentDate}" var="salesDate"/>
                        <c:set value="${result.salesByDates[salesDate]}" var="dailySales"/>
                        <%--<c:set value="${totalDateWeight + dailySales.weight}" var="totalDateWeight"/>--%>
                        <%--<c:set value="${totalDateCustomer + dailySales.noCustomer}" var="totalDateCustomer"/>--%>
                        <%--<c:set value="${totalMonthWeight + result.totalWeight}" var="totalMonthWeight"/>--%>
                        <%--<c:set value="${totalMonthCustomer + result.totalCustomer}" var="totalMonthCustomer"/>--%>
                        <td>
                            <a data-html="true" class="tip-right" title="${dailySales.consumptionHTML}">
                                <fmt:formatNumber value="${!empty dailySales.weight ? dailySales.weight : 0}" pattern="###,###" maxFractionDigits="3" minFractionDigits="0"/>
                            </a>
                        </td>
                        <td>${!empty dailySales.noCustomer ? dailySales.noCustomer : 0}</td>
                    </c:forEach>
                    <td>
                        <a data-html="true" class="tip-bottom" title="${result.consumptionHTML}">
                            <fmt:formatNumber value="${result.totalWeight}" pattern="###,###" maxFractionDigits="3" minFractionDigits="0"/>
                        </a>
                    </td>
                    <td>${result.totalCustomer}</td>
                </tr>
            </c:forEach>
            <tr class="${fn:length(results) + 1 % 2 == 0 ? "odd": "even"} total" style="font-weight: bold">
                <c:forEach var="date" items="${dates}">
                    <td>
                        0<%--<fmt:formatNumber value="${totalDateWeight}" pattern="###,###" maxFractionDigits="3" minFractionDigits="0"/>--%>
                    </td>
                    <td>
                        0<%--${totalDateCustomer}--%>
                    </td>
                </c:forEach>
                <td>
                    0<%--<fmt:formatNumber value="${totalMonthWeight}" pattern="###,###" maxFractionDigits="3" minFractionDigits="0"/>--%>
                </td>
                <td>
                0<%--${totalMonthCustomer}--%>
                </td>
            </tr>
        </table>
    </div>
</div>
<%--<div class="tb_right">--%>
    <%--<table class="tableSadlier">--%>
        <%--<tr>--%>
            <%--<th colspan="2" class="table_header text-center"><fmt:message key="label.day.to.month"/></th>--%>
        <%--</tr>--%>
        <%--<tr>--%>
            <%--<th class="table_header text-center"><fmt:message key="label.weight.tan.short"/></th>--%>
            <%--<th class="table_header text-center"><fmt:message key="label.no.customer.short"/></th>--%>
        <%--</tr>--%>
        <%--<c:set value="0" var="totalMonthWeight"/>--%>
        <%--<c:set value="0" var="totalMonthCustomer"/>--%>
        <%--<c:forEach items="${results}" var="result" varStatus="status">--%>
            <%--<c:set value="${totalMonthWeight + result.totalWeight}" var="totalMonthWeight"/>--%>
            <%--<c:set value="${totalMonthCustomer + result.totalCustomer}" var="totalMonthCustomer"/>--%>
            <%--<tr class="${status.index % 2 == 0 ? "even" : "odd"} ${status.index == 0 ? 'first' : status.index == 1 ? 'second' : status.index == 2 ? 'third' : ''}">--%>
                <%--<td><fmt:formatNumber value="${result.totalWeight}" pattern="###,###" maxFractionDigits="3" minFractionDigits="0"/></td>--%>
                <%--<td>${result.totalCustomer}</td>--%>
            <%--</tr>--%>
        <%--</c:forEach>--%>
        <%--<tr class="${fn:length(results) + 1 % 2 == 0 ? "odd": "even"} total" style="font-weight: bold">--%>
            <%--<td><fmt:formatNumber value="${totalMonthWeight}" pattern="###,###" maxFractionDigits="3" minFractionDigits="0"/></td>--%>
            <%--<td>${totalMonthCustomer}</td>--%>
        <%--</tr>--%>
    <%--</table>--%>
<%--</div>--%>
<%--<table class="tableSadlier">--%>
    <%--<tr>--%>
        <%--<th rowspan="2" class="table_header text-center"><fmt:message key="label.stt"/></th>--%>
        <%--<th rowspan="2" class="table_header text-center"><fmt:message key="label.staff"/></th>--%>
        <%--<th colspan=2" class="table_header text-center"><fmt:message key="daily.sales"/></th>--%>
        <%--<th colspan="2" class="table_header text-center"><fmt:message key="label.day.to.month"/></th>--%>
    <%--</tr>--%>
    <%--<tr>--%>
        <%--<th class="table_header text-center"><fmt:message key="label.weight.tan"/></th>--%>
        <%--<th class="table_header text-center"><fmt:message key="label.no.customer"/></th>--%>
        <%--<th class="table_header text-center"><fmt:message key="label.weight.tan"/></th>--%>
        <%--<th class="table_header text-center"><fmt:message key="label.no.customer"/></th>--%>
    <%--</tr>--%>
    <%--<c:set value="0" var="totalDateWeight"/>--%>
    <%--<c:set value="0" var="totalDateCustomer"/>--%>
    <%--<c:set value="0" var="totalMonthWeight"/>--%>
    <%--<c:set value="0" var="totalMonthCustomer"/>--%>
    <%--<fmt:formatDate var="currentDate" value="${items.toDate}" pattern="ddMMyyyy"/>--%>
    <%--<c:forEach items="${results}" var="result" varStatus="status">--%>
        <%--<c:set value="${result.salesman.userID}_${currentDate}" var="salesDate"/>--%>
        <%--<c:set value="${result.salesByDates[salesDate]}" var="dailySales"/>--%>
        <%--<c:set value="${totalDateWeight + dailySales.weight}" var="totalDateWeight"/>--%>
        <%--<c:set value="${totalDateCustomer + dailySales.noCustomer}" var="totalDateCustomer"/>--%>
        <%--<c:set value="${totalMonthWeight + result.totalWeight}" var="totalMonthWeight"/>--%>
        <%--<c:set value="${totalMonthCustomer + result.totalCustomer}" var="totalMonthCustomer"/>--%>
        <%--<tr class="${status.index % 2 == 0 ? "even" : "odd"} ${status.index == 0 ? 'first' : status.index == 1 ? 'second' : status.index == 2 ? 'third' : ''}">--%>
            <%--<td class="txtc">${status.index + 1}</td>--%>
            <%--<td class="txtl">${result.salesman.fullname}</td>--%>
            <%--<td><fmt:formatNumber value="${dailySales.weight}" pattern="###,###" maxFractionDigits="3" minFractionDigits="0"/></td>--%>
            <%--<td>${dailySales.noCustomer}</td>--%>
            <%--<td><fmt:formatNumber value="${result.totalWeight}" pattern="###,###" maxFractionDigits="3" minFractionDigits="0"/></td>--%>
            <%--<td>${result.totalCustomer}</td>--%>
        <%--</tr>--%>
    <%--</c:forEach>--%>
    <%--<tr class="${fn:length(results) + 1 % 2 == 0 ? "odd": "even"} total" style="font-weight: bold">--%>
        <%--<td colspan="2" style="text-align: center">Tổng cộng</td>--%>
        <%--<td><fmt:formatNumber value="${totalDateWeight}" pattern="###,###" maxFractionDigits="3" minFractionDigits="0"/></td>--%>
        <%--<td>${totalDateCustomer}</td>--%>
        <%--<td><fmt:formatNumber value="${totalMonthWeight}" pattern="###,###" maxFractionDigits="3" minFractionDigits="0"/></td>--%>
        <%--<td>${totalMonthCustomer}</td>--%>
    <%--</tr>--%>
<%--</table>--%>


