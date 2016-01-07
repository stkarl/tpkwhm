<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" errorPage="/error.jsp" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@page import="com.banvien.tpk.core.Constants" %>
<div class="noscreen company-title" style="margin:50px;">
    <table style="text-align: center;width: 100%">
        <tr>
            <td rowspan="5" style="width: 72px"><img src="/images/printlogo.png" style="width:72px;height: 72px;"/></td>
            <td style="width: 30%;">CTY CỔ PHẦN THƯƠNG MẠI - SẢN XUẤT</td>
            <td rowspan="4" class="bill-title"><fmt:message key="label.inner.import.bill"/></td>
        </tr>
        <tr>
            <td style="font-weight: bold">TÔN TÂN PHƯỚC KHANH</td>
        </tr>
        <tr>
            <td>KCN Phú Mỹ 1, H.Tân Thành, Tỉnh BRVT</td>
        </tr>
        <tr>
            <td>Điện thoại: 0643.922762   Fax: 0643.922765</td>
        </tr>
    </table>
</div>
<div class="clear"></div>
<table class="tbHskt info noscreen">
    <caption><fmt:message key="import.material.generalinfo"/></caption>
    <tr>
        <td><fmt:message key="label.number"/></td>
        <td colspan="2">${importBackBill.code}</td>
        <td class="wall"></td>
        <td colspan="2"></td>
    </tr>
    <tr>
        <td><fmt:message key="warehouse.receive"/></td>
        <td colspan="2">${importBackBill.warehouse.name}</td>
        <td class="wall"><fmt:message key="whm.productionplan.name"/></td>
        <td colspan="2">${importBackBill.productionPlan.name}</td>
    </tr>
    <tr>
        <td><fmt:message key="label.description"/></td>
        <td colspan="5">${importBackBill.description}</td>
    </tr>
</table>
<table class="tableSadlier table-hover" border="1" style="width:100%;text-align: center">
    <caption><fmt:message key="product.info"/></caption>
    <tr>
        <th class="table_header text-center">STT</th>
        <th class="table_header text-center"><fmt:message key="label.name"/></th>
        <th class="table_header text-center"><fmt:message key="label.size"/></th>
        <th class="table_header text-center"><fmt:message key="label.specific"/></th>
        <th class="table_header text-center"><fmt:message key="label.code"/></th>
        <th class="table_header text-center"><fmt:message key="label.quantity.kg"/></th>
        <th class="table_header text-center"><fmt:message key="label.import.back.code"/></th>
        <th class="table_header text-center"><fmt:message key="label.import.back.kg"/></th>
    </tr>
    <c:set var="totalKg" value="0"/>
    <c:set var="totalOriginalKg" value="0"/>

    <c:forEach items="${importBackBill.importproducts}" var="importProduct" varStatus="status">
        <tr>
            <td style="width: 3%">${status.index + 1}</td>
            <td>${importProduct.productname.name}</td>
            <td>${importProduct.size.name}</td>
            <td>
                <c:choose>
                    <c:when test="${not empty importProduct.origin}">
                        ${importProduct.origin.name}
                    </c:when>
                    <c:when test="${not empty importProduct.colour}">
                        ${importProduct.colour.name}
                    </c:when>
                    <c:when test="${not empty importProduct.thickness}">
                        ${importProduct.thickness.name}
                    </c:when>
                    <c:otherwise>-</c:otherwise>
                </c:choose>
            </td>
            <td>${importProduct.originalProduct.productCode}</td>
            <td><fmt:formatNumber value="${importProduct.originalProduct.quantity2Pure}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/></td>
            <td>${importProduct.productCode}</td>
            <td><fmt:formatNumber value="${importProduct.quantity2Pure}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/></td>
        </tr>
        <c:set var="totalKg" value="${totalKg + importProduct.quantity2Pure}"/>
        <c:set var="totalOriginalKg" value="${totalOriginalKg + importProduct.originalProduct.quantity2Pure}"/>
    </c:forEach>
    <tr style="font-weight: bold;">
        <td colspan="3" style="text-align: right"><fmt:message key="label.total"/></td>
        <td style="text-align: center;">${fn:length(importBackBill.importproducts)} Cuộn</td>
        <td></td>
        <td style="text-align: center;"><fmt:formatNumber value="${totalOriginalKg}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/></td>
        <td></td>
        <td style="text-align: center;"><fmt:formatNumber value="${totalKg}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/></td>
    </tr>
</table>
<div class="noscreen sign-panel">
    <table style="width: 100%">
        <tr>
            <td colspan="4" style="text-align: right;padding-bottom: 1em;">Ngày......tháng......năm.....</td>
        </tr>
        <tr style="text-align: center;font-weight: bold">
            <td>Người lập phiếu</td>
            <td>Người nhận hàng</td>
            <td>Thủ kho TPK</td>
            <td>BĐH Nhà máy TPK</td>
        </tr>
        <tr style="text-align: center">
            <td>(Ký, ghi rõ họ & tên)</td>
            <td>(Ký, ghi rõ họ & tên)</td>
            <td>(Ký, ghi rõ họ & tên)</td>
            <td>(Ký, ghi rõ họ & tên)</td>
        </tr>
    </table>
</div>