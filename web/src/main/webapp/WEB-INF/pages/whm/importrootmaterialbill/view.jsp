<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" errorPage="/error.jsp" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@page import="com.banvien.tpk.core.Constants" %>

<head>
    <title><fmt:message key="whm.importproduct.material.title"/></title>
    <meta name="heading" content="<fmt:message key="whm.importproduct.material.title"/>"/>
    <link rel="stylesheet" href="<c:url value='/themes/whm/css/jquery.jscrollpane.css' />" />
    <style media="print">
        table.tbInput.table-product-list,
        table.tbHskt.info,
        .sign-panel{
            font-size: 18px!important;
        }
    </style>


</head>

<c:url var="url" value="/whm/importrootmaterialbill/view.html"/>
<c:url var="backUrl" value="/whm/importrootmaterialbill/list.html"/>
<form:form commandName="item" action="${url}" method="post" id="itemForm" class="form-horizontal" novalidate="novalidate">
    <div id="container-fluid data_content_box">
        <div class="row-fluid data_content">
            <div class="noscreen company-title" style="margin:50px;">
                <table style="text-align: center;width: 100%">
                    <tr>
                        <td rowspan="5" style="width: 72px"><img src="/images/printlogo.png" style="width:72px;height: 72px;"/></td>
                        <td style="width: 30%;">CTY CỔ PHẦN THƯƠNG MẠI - SẢN XUẤT</td>
                        <td rowspan="4" class="bill-title"><fmt:message key="label.import.bill"/></td>
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
            <div class="content-header noprint"><fmt:message key="whm.importproduct.material.declare"/></div>
            <div class="clear"></div>
            <div class="alert alert-error" style="display: none;">
                Hãy nhập đủ thông tin bắt buộc trước khi lưu.
            </div>
            <table class="tbHskt info">
                <caption><fmt:message key="import.material.generalinfo"/></caption>
                <tr>
                    <td><fmt:message key="label.number"/></td>
                    <td colspan="2">${item.pojo.code}</td>
                    <td class="wall"><fmt:message key="label.used.market"/></td>
                    <td colspan="2">${item.pojo.market.name}</td>
                </tr>
                <tr>
                    <td><fmt:message key="import.material.supplier"/></td>
                    <td colspan="2">${item.pojo.customer.name} - ${item.pojo.customer.province.name}</td>
                    <td class="wall"><fmt:message key="import.material.receive.warehouse"/></td>
                    <td colspan="2">${item.pojo.warehouse.name}</td>
                </tr>
                <tr>
                    <td><fmt:message key="label.location"/></td>
                    <td colspan="2">${item.pojo.warehouseMap.name}</td>
                    <td class="wall"><fmt:message key="import.date"/></td>
                    <td colspan="2"><fmt:formatDate value="${item.pojo.importDate}" pattern="dd/MM/yyyy"/></td>
                </tr>
                <tr>
                    <td><fmt:message key="label.description"/></td>
                    <td colspan="5">${item.pojo.description}</td>
                </tr>
            </table>
            <table class="tbInput table-product-list">
                <caption><fmt:message key="import.info.product.material.base"/></caption>
                <tr id="tbHead">
                    <th>STT</th>
                    <th><fmt:message key="whm.productname.name"/></th>
                    <th><fmt:message key="label.code"/></th>
                    <th><fmt:message key="label.size"/> (mmxmm)</th>
                    <th ><fmt:message key="label.quantity.pure"/></th>
                    <th ><fmt:message key="label.quantity.overall"/></th>
                    <th ><fmt:message key="label.quantity.actual"/></th>
                    <th ><fmt:message key="label.difference"/></th>
                    <th><fmt:message key="label.made.in"/></th>
                    <security:authorize ifAnyGranted="NHANVIENTT,QUANLYTT,LANHDAO">
                    <th><fmt:message key="label.price.vnd"/></th>
                    </security:authorize>
                </tr>
                <c:set var="total" value="0"/>
                <c:set var="totalPure" value="0"/>
                <c:set var="totalActual" value="0"/>
                <c:forEach items="${importProducts}" var="importProduct" varStatus="status">
                    <tr id="prd_${status.index}">
                        <td style="width: 3%">${status.index + 1}</td>
                        <td class="inputItemInfo0">${importProduct.productname.name}</td>
                        <%--<td class="inputItemInfo1">${tpk:productCodeWhenPrint(importProduct.productCode)}</td>--%>
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
                            <input id="money_${status.index}" name="rootMaterialMoneyMap[${importProduct.importProductID}]" value="<fmt:formatNumber value="${importProduct.money}" pattern="###,###.##" maxFractionDigits="2" minFractionDigits="0"/>" type="text" class="inputFractionNumber width2" onblur="setTotalMoney();"/>
                        </td>
                        </security:authorize>
                    </tr>
                    <c:set var="total" value="${total + importProduct.quantity2}"/>
                    <c:set var="totalPure" value="${totalPure + importProduct.quantity2Pure}"/>
                    <c:set var="totalActual" value="${totalActual + importProduct.quantity2Actual}"/>
                </c:forEach>
                <tr style="font-weight: bold;">
                    <td colspan="3" style="text-align: right"><fmt:message key="label.total"/></td>
                    <td style="text-align: center;">${fn:length(importProducts)} CUỘN</td>
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
                    <td></td>
                    </security:authorize>
                </tr>
                <security:authorize ifAnyGranted="NHANVIENTT,QUANLYTT,LANHDAO">
                <input type="hidden" id="noRootMaterial" value="${fn:length(importProducts)}"/>
                <tr>
                    <td colspan="9" style="font-weight: bold; text-align: right"><fmt:message key="label.total.money"/></td>
                    <td style="text-align: center;"><input id="totalMoney" name="pojo.totalMoney" value="<fmt:formatNumber value="${item.pojo.totalMoney}" pattern="###,###.##" maxFractionDigits="2" minFractionDigits="0"/>" type="text" class="inputFractionNumber width2" readonly="readonly"/></td>
                </tr>
                </security:authorize>
            </table>

            <security:authorize ifAnyGranted="NHANVIENTT,QUANLYTT,LANHDAO">
                <table class="tbHskt info noprint">
                    <caption><fmt:message key="add.buy.contract"/></caption>
                    <tr>
                        <td style="width:20%;"><fmt:message key="whm.buycontract.name"/></td>
                        <td style="width:80%;">
                            <form:select path="pojo.buyContract.buyContractID" cssStyle="width: 480px;">
                                <form:option value=""><fmt:message key="label.select"/></form:option>
                                <c:forEach items="${buyContracts}" var="buyContract">
                                    <form:option value="${buyContract.buyContractID}">${buyContract.code} | <fmt:formatDate value="${buyContract.date}" pattern="dd/MM/yyyy"/> | ${buyContract.customer.name} </form:option>
                                </c:forEach>
                            </form:select>
                        </td>
                    </tr>
                </table>
            </security:authorize>

            <security:authorize ifAnyGranted="NHANVIENTT,QUANLYTT,QUANLYKHO,LANHDAO">
            <table class="tbHskt info noprint">
                <caption><fmt:message key="label.confirmation"/></caption>
                <tr>
                    <td style="width:20%;"><fmt:message key="label.note"/></td>
                    <td style="width:80%;"><form:textarea path="pojo.note" cssClass="nohtml nameValidate span11" rows="2"/></td>
                </tr>
                <tr>
                    <td class="ctrl-btn" colspan="2">
                        <a href="javascript:window.print();" class="btn btn-primary"><i class="icon-print"></i> <fmt:message key="button.print"/></a>
                        <a class="btn btn-info " onclick="exportExcel();"><i class="icon-arrow-down"></i> <fmt:message key="label.export.excel"/></a>
                        <security:authorize ifAnyGranted="QUANLYKHO,LANHDAO">
                            <c:if test="${item.pojo.status == Constants.WAIT_CONFIRM}">
                                <a onclick="rejectBill()" class="btn btn-danger" style="cursor: pointer;">
                                    <fmt:message key="button.reject"/>
                                </a>
                                <a onclick="saveBill()" class="btn btn-success" style="cursor: pointer;">
                                    <fmt:message key="button.confirm"/>
                                </a>
                            </c:if>
                        </security:authorize>
                        <security:authorize ifAnyGranted="NHANVIENTT">
                            <c:if test="${empty item.pojo.totalMoney && item.pojo.status ne Constants.REJECTED}">
                                <a onclick="saveMoney()" class="btn btn-success" style="cursor: pointer;">
                                    <fmt:message key="button.confirm.money"/>
                                </a>
                            </c:if>
                        </security:authorize>
                        <security:authorize ifAnyGranted="QUANLYTT,LANHDAO">
                            <c:if test="${item.pojo.status ne Constants.REJECTED}">
                                <a onclick="saveMoney()" class="btn btn-success" style="cursor: pointer;">
                                    <fmt:message key="button.confirm.money"/>
                                </a>
                            </c:if>
                        </security:authorize>
                        <div style="display: inline">
                            <form:hidden path="crudaction" id="crudaction" value="insert-update"/>
                            <form:hidden path="pojo.importProductBillID"/>
                            <a href="${backUrl}" class="cancel-link">
                                <fmt:message key="button.cancel"/>
                            </a>
                        </div>
                    </td>
                </tr>
            </table>
            </security:authorize>
            <security:authorize ifNotGranted="NHANVIENTT,QUANLYTT,QUANLYKHO,LANHDAO">
                <div class="controls">
                    <div style="display: inline">
                        <a href="javascript:window.print();" class="btn btn-primary"><i class="icon-print"></i> <fmt:message key="button.print"/></a>
                        <a class="btn btn-info " onclick="exportExcel();"><i class="icon-arrow-down"></i> <fmt:message key="label.export.excel"/></a>
                        <form:hidden path="crudaction" id="crudaction" value="insert-update"/>
                        <form:hidden path="pojo.importProductBillID"/>
                        <a href="${backUrl}" class="cancel-link">
                            <fmt:message key="button.cancel"/>
                        </a>
                    </div>
                </div>
            </security:authorize>

            <%@include file="../common/tablelog.jsp"%>

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
        </div>
    </div>
</form:form>
<script type="text/javascript">
    var noRootMaterial = $("#noRootMaterial").val();
    $( document ).ready(function() {
    });
    function exportExcel(){
        $("#crudaction").val("export");
        unformatNumber();
        $("#itemForm").submit();
    }
    function saveBill(){
        $("#crudaction").val("insert-update");
        unformatNumber();
        $("#itemForm").submit();
    }
    function saveMoney(){
        $("#crudaction").val("update-money");
        unformatNumber();
        $("#itemForm").submit();
    }
    function rejectBill(){
        $("#crudaction").val("reject");
        unformatNumber();
        $("#itemForm").submit();
    }
    function unformatNumber(){
        $('.inputFractionNumber').each(function(){
            if($(this).val() != '' && $(this).val() != 0 ) {
                $(this).val(numeral().unformat($(this).val()));
            }
        });
    }
    function setTotalMoney(){
        var tong = 0;
        for(var q = 0; q < noRootMaterial; q++)
        {
            var money = $("#money_" + q).val() != ""  ? $("#money_" + q).val() : "0";
            var quantity = $('#quantity_' + q).text() != '' ? numeral().unformat($('#quantity_' + q).text()) : 0;

            if(money == undefined){ money = "0"}
            money = numeral().unformat(money);
            if(money!="")
            {
                tong += parseFloat(money) * parseFloat(quantity);
            }
        }
        var string = numeral(parseFloat(tong)).format('###,###.##');
        $("#totalMoney").val(string);
    }
</script>