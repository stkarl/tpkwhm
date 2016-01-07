<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" errorPage="/error.jsp" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@page import="com.banvien.tpk.core.Constants" %>
<head>
    <title><fmt:message key="export.product.by.plan.title"/></title>
    <meta name="heading" content="<fmt:message key="export.product.by.plan.title"/>"/>
    <style media="print">
        table.tbInput,
        table.tbHskt.info,
        .sign-panel{
            font-size: 18px!important;
        }
    </style>
</head>

<c:url var="backUrl" value="/whm/productionplan/productbyplan.html"/>
<form:form commandName="item" action="${url}" method="post" id="itemForm" class="form-horizontal" novalidate="novalidate">
    <div id="container-fluid data_content_box">
        <div class="row-fluid data_content">
            <div class="noscreen company-title" style="margin:50px;">
                <table style="text-align: center;width: 100%">
                    <tr>
                        <td rowspan="5" style="width: 72px"><img src="/images/printlogo.png" style="width:72px;height: 72px;"/></td>
                        <td style="width: 30%;">CTY CỔ PHẦN THƯƠNG MẠI - SẢN XUẤT</td>
                        <td rowspan="4" class="bill-title"><fmt:message key="label.inner.export.bill"/></td>
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
            <div class="content-header noprint"><fmt:message key="export.product.by.plan.title"/></div>
            <div class="clear"></div>
            <table class="tbHskt info">
                <caption><fmt:message key="import.material.generalinfo"/></caption>
                <tr>
                    <td style="width: 25%"><fmt:message key="whm.productionplan.name"/></td>
                    <td colspan="5">${plan.name}</td>
                </tr>
                <tr>
                    <td style="width: 25%"><fmt:message key="label.export.type"/></td>
                    <td colspan="5">Sản xuất</td>
                </tr>
                <tr>
                    <td><fmt:message key="warehouse.export"/></td>
                    <td colspan="5">${plan.warehouse.name}</td>
                </tr>
            </table>
            <table class="tbInput">
                <caption><fmt:message key="export.product.list.by.plan"/></caption>
                <tr id="tbHead">
                    <th>STT</th>
                    <th><fmt:message key="whm.productname.name"/></th>
                    <th><fmt:message key="label.code"/></th>
                    <th><fmt:message key="label.size"/></th>
                    <c:if test="${not empty importproducts[0].quantity1}">
                        <th><fmt:message key="label.quantity.meter"/></th>
                    </c:if>
                    <th><fmt:message key="label.quantity.kg"/></th>
                    <c:if test="${importproducts[0].productname.code eq Constants.PRODUCT_BLACK}">
                        <th><fmt:message key="label.made.in"/></th>
                    </c:if>
                    <c:if test="${importproducts[0].productname.code ne Constants.PRODUCT_BLACK}">
                        <th>Chủng loại SP</th>
                    </c:if>
                </tr>
                <c:set var="totalKg" value="0"/>
                <c:set var="totalM" value="0"/>
                <c:forEach items="${importproducts}" var="importProduct" varStatus="status">
                    <tr id="prd_${status.index}" style="text-align: center">
                        <td style="width: 3%">${status.index + 1}</td>
                        <td class="inputItemInfo0">${importProduct.productname.name}</td>
                        <td class="inputItemInfo1">${importProduct.productCode}</td>
                        <td class="inputItemInfo0">${importProduct.size.name}</td>
                        <c:if test="${not empty importproducts[0].quantity1}">
                            <td class="inputItemInfo0"><fmt:formatNumber value="${importProduct.quantity1}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/></td>
                        </c:if>
                        <td class="inputItemInfo0"><fmt:formatNumber value="${importProduct.quantity2Pure}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/></td>
                        <c:if test="${importproducts[0].productname.code eq Constants.PRODUCT_BLACK}">
                            <td class="inputItemInfo0">${importProduct.origin.name}</td>
                        </c:if>
                        <c:if test="${importproducts[0].productname.code ne Constants.PRODUCT_BLACK}">
                            <td class="inputItemInfo0">${importProduct.thickness.name}</td>
                        </c:if>
                    </tr>
                    <c:set var="totalKg" value="${totalKg + importProduct.quantity2Pure}"/>
                    <c:set var="totalM" value="${totalM + importProduct.quantity1}"/>
                </c:forEach>
                <tr style="font-weight: bold;">
                    <td colspan="3" style="text-align: right"><fmt:message key="label.total"/></td>
                    <td style="text-align: center;">${fn:length(importproducts)} CUỘN</td>
                    <c:if test="${not empty importproducts[0].quantity1}">
                        <td style="text-align: center;"><fmt:formatNumber value="${totalM}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/></td>
                    </c:if>
                    <td style="text-align: center;"><fmt:formatNumber value="${totalKg}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/></td>
                    <c:if test="${importproducts[0].productname.code eq Constants.PRODUCT_BLACK}">
                        <td></td>
                    </c:if>
                    <c:if test="${importproducts[0].productname.code ne Constants.PRODUCT_BLACK}">
                        <td></td>
                    </c:if>
                </tr>
            </table>
            <div class="controls">
                <div style="display: inline">
                    <a href="javascript:window.print();" class="btn btn-primary"><i class="icon-print"></i> <fmt:message key="button.print"/></a>
                    <a class="btn btn-info " onclick="exportExcel();"><i class="icon-arrow-down"></i> <fmt:message key="label.export.excel"/></a>
                    <a href="${backUrl}" class="cancel-link">
                        <fmt:message key="button.cancel"/>
                    </a>
                    <form:hidden path="crudaction" id="crudaction" value="insert-update"/>
                    <form:hidden path="productionPlanID"/>
                </div>
            </div>

            <div class="noscreen sign-panel">
                <table style="width: 100%">
                    <tr>
                        <td colspan="4" style="text-align: right;padding-bottom: 1em;">Ngày......tháng......năm.....</td>
                    </tr>
                    <tr style="text-align: center;font-weight: bold">
                        <td>Người lập phiếu</td>
                        <td>Trưởng ca xác nhận</td>
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
        </div>
    </div>
</form:form>
<script type="text/javascript">
    function exportExcel(){
        $("#crudaction").val("export");
        $("#itemForm").submit();
    }
</script>