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
            <c:forEach var="monthlyCustomer" items="${result.customerConsumption}">
                <c:set var="customer" value="${monthlyCustomer.key}"/>
                <c:set var="dailyCustomerValue" value="${dailySales.customerConsumption[customer]}"/>
                <tr class="customer-detail">
                    <td colspan="2" class="txtr">
                        <a class="tip-top" title="${customer.name} - ${customer.province.name}"><str:truncateNicely upper="35" appendToEnd="...">${customer.name} - ${customer.province.name}</str:truncateNicely></a>
                    </td>
                </tr>
            </c:forEach>
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
            <c:forEach items="${results}" var="result" varStatus="status">
                <tr class="${status.index % 2 == 0 ? "even" : "odd"} ${status.index == 0 ? 'first' : status.index == 1 ? 'second' : status.index == 2 ? 'third' : ''}">
                    <c:forEach var="date" items="${dates}">
                        <fmt:formatDate var="currentDate" value="${date}" pattern="ddMMyyyy"/>
                        <c:set value="${result.salesman.userID}_${currentDate}" var="salesDate"/>
                        <c:set value="${result.salesByDates[salesDate]}" var="dailySales"/>
                        <td>
                            <fmt:formatNumber var="fmtWeight" value="${!empty dailySales.weight ? dailySales.weight : 0}" pattern="###,###" maxFractionDigits="3" minFractionDigits="0"/>
                            <span class="dailyWeight${currentDate}" Weight="${fmtWeight}">
                                ${fmtWeight}
                            </span>
                        </td>
                        <td>
                            <c:set var="fmtCustomer" value="${!empty dailySales.noCustomer ? dailySales.noCustomer : 0}"/>
                            <span class="dailyCustomer${currentDate}" Customer="${fmtCustomer}">
                                ${fmtCustomer}
                            </span>
                        </td>
                    </c:forEach>
                    <td>
                        <span class="monthlyWeight" Weight="${result.totalWeight}">
                            <fmt:formatNumber value="${result.totalWeight}" pattern="###,###" maxFractionDigits="3" minFractionDigits="0"/>
                        </span>
                    </td>
                    <td>
                        <span class="monthlyCustomer" Customer="${result.totalCustomer}">
                                ${result.totalCustomer}
                        </span>
                    </td>
                </tr>
                <c:forEach var="monthlyCustomer" items="${result.customerConsumption}">
                    <c:set var="customer" value="${monthlyCustomer.key}"/>
                    <tr class="customer-detail">
                    <c:forEach var="date" items="${dates}">
                        <fmt:formatDate var="currentDate" value="${date}" pattern="ddMMyyyy"/>
                        <c:set value="${result.salesman.userID}_${currentDate}" var="salesDate"/>
                        <c:set value="${result.salesByDates[salesDate]}" var="dailySales"/>
                        <c:set var="dailyCustomerValue" value="${dailySales.customerConsumption[customer]}"/>
                        <td><fmt:formatNumber value="${dailyCustomerValue}" pattern="###,###" maxFractionDigits="3" minFractionDigits="0"/></td>
                        <td></td>
                    </c:forEach>
                        <td>
                            <fmt:formatNumber value="${monthlyCustomer.value}" pattern="###,###" maxFractionDigits="3" minFractionDigits="0"/>
                        </td>
                        <td></td>
                    </tr>
                </c:forEach>
            </c:forEach>
            <tr class="${fn:length(results) + 1 % 2 == 0 ? "odd": "even"} total" style="font-weight: bold">
                <c:forEach var="date" items="${dates}">
                    <fmt:formatDate var="currentDate" value="${date}" pattern="ddMMyyyy"/>
                    <td>
                        <span class="totalDailyWeight" date="${currentDate}">0</span>
                    </td>
                    <td>
                        <span class="totalDailyCustomer"  date="${currentDate}">0</span>
                    </td>
                </c:forEach>
                <td>
                    <span class="totalMonthlyWeight">0</span>
                </td>
                <td>
                    <span class="totalMonthlyCustomer">0</span>
                </td>
            </tr>
        </table>
    </div>
</div>
