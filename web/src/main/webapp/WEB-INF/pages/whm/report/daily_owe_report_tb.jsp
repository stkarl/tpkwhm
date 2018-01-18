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
            <th class="table_header text-center cus-name"><fmt:message key="label.customer"/></th>
            <th class="table_header text-center"><fmt:message key="label.initial.owe"/></th>
        </tr>
        <tr>
            <th style="color:#97C5A8;" class="table_header text-center stt"><fmt:message key="label.stt"/></th>
            <th style="color:#97C5A8;" class="table_header text-center cus-name"><fmt:message key="label.customer"/></th>
            <th style="color:#97C5A8;" class="table_header text-center"><fmt:message key="label.initial.owe"/></th>
        </tr>
        <c:set var="totalInit" value="0"/>
        <c:forEach items="${results}" var="result" varStatus="status">
            <tr class="${status.index % 2 == 0 ? "even" : "odd"} ${status.index == 0 ? 'first' : status.index == 1 ? 'second' : status.index == 2 ? 'third' : ''}">
                <td class="stt txtc">${status.index + 1}</td>
                <td class="txtl cus-name">
                    <span class="tip-top" cusid="${result.customer.customerID}" title="${result.customer.name} - ${result.customer.province.name}">
                        <str:truncateNicely upper="25">${result.customer.name} - ${result.customer.province.name}</str:truncateNicely>
                    </span>
                </td>
                <td class="txtr"><fmt:formatNumber value="${result.initOwe}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/></td>
                <c:set var="totalInit" value="${totalInit + result.initOwe}"/>

            </tr>
        </c:forEach>
        <tr class="${fn:length(results) + 1 % 2 == 0 ? "odd": "even"} total" style="font-weight: bold">
            <td colspan="2" style="text-align: center">Tổng cộng</td>
            <td class="totalInit txtr"><fmt:formatNumber value="${totalInit}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/></td>
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
                <th colspan="3" class="table_header text-center"><fmt:message key="label.total"/></th>
            </tr>
            <tr>
                <c:forEach var="date" items="${dates}">
                    <th class="table_header text-center"><fmt:message key="label.buy"/></th>
                    <th class="table_header text-center"><fmt:message key="label.pay.short"/></th>
                </c:forEach>
                <th class="table_header text-center"><fmt:message key="label.buy"/></th>
                <th class="table_header text-center"><fmt:message key="label.pay.short"/></th>
                <th class="table_header text-center"><fmt:message key="label.remain.owe"/></th>
            </tr>
            <c:forEach items="${results}" var="result" varStatus="status">

                <tr class="${status.index % 2 == 0 ? "even" : "odd"} ${status.index == 0 ? 'first' : status.index == 1 ? 'second' : status.index == 2 ? 'third' : ''}">
                    <c:forEach var="date" items="${dates}">
                        <fmt:formatDate var="currentDate" value="${date}" pattern="ddMMyyyy"/>
                        <c:set value="${result.customer.customerID}_${currentDate}" var="oweDate"/>
                        <c:set value="${result.oweByDates[oweDate]}" var="dailyOwe"/>
                        <td>
                            <fmt:formatNumber var="fmtBuy" value="${!empty dailyOwe.buy ? dailyOwe.buy : 0}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/>
                            <span class="tip-right daily-buy${currentDate}" buy="${fmtBuy}" title="">
                                ${fmtBuy}
                            </span>
                        </td>
                        <td>
                            <fmt:formatNumber var="fmtPay" value="${!empty dailyOwe.pay ? dailyOwe.pay : 0}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/>
                            <span class="daily-pay${currentDate}" pay="${fmtPay}">
                                ${fmtPay}
                            </span>
                        </td>
                    </c:forEach>
                    <td>
                        <fmt:formatNumber var="fmtTotalBuy" value="${!empty result.totalBuy ? result.totalBuy : 0}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/>
                        <span class="tip-bottom total-buy" buy="${fmtTotalBuy}" title="" >
                            ${fmtTotalBuy}
                        </span>
                    </td>
                    <td>
                        <fmt:formatNumber var="fmtTotalPay" value="${!empty result.totalPay ? result.totalPay : 0}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/>
                        <span class="tip-bottom total-pay" pay="${fmtTotalPay}" title="" >
                            ${fmtTotalPay}
                        </span>
                    </td>
                    <td>
                        <fmt:formatNumber var="fmtFinalOwe" value="${!empty result.finalOwe ? result.finalOwe : 0}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/>
                        <span class="tip-bottom finalOwe" owe="${fmtFinalOwe}" title="" >
                            ${fmtFinalOwe}
                        </span>
                    </td>
                </tr>
            </c:forEach>
            <tr class="${fn:length(results) + 1 % 2 == 0 ? "odd": "even"} total" style="font-weight: bold">
                <c:forEach var="date" items="${dates}">
                    <fmt:formatDate var="currentDate" value="${date}" pattern="ddMMyyyy"/>
                    <td>
                        <span class="total-daily-buy" date="${currentDate}">0</span>
                    </td>
                    <td>
                        <span class="total-daily-pay"  date="${currentDate}">0</span>
                    </td>
                </c:forEach>
                <td>
                    <span class="total-final-buy">0</span>
                </td>
                <td>
                    <span class="total-final-pay">0</span>
                </td>
                <td>
                    <span class="totalFinalOwe">0</span>
                </td>
            </tr>
        </table>
    </div>
</div>



