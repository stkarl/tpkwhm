<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" errorPage="/error.jsp" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@page import="com.banvien.tpk.core.Constants" %>

<head>
    <title><fmt:message key="whm.importmaterial.title"/></title>
    <meta name="heading" content="<fmt:message key="whm.importmaterial.title"/>"/>
    <link rel="stylesheet" href="<c:url value='/themes/whm/css/jquery.jscrollpane.css' />" />
</head>

<c:url var="url" value="/whm/importmaterialbill/view.html"/>
<c:url var="backUrl" value="/whm/importmaterialbill/list.html"/>
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
            <div class="content-header noprint"><fmt:message key="whm.importmaterial.view.confirm"/></div>
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
                    <td class="wall noprint"><fmt:message key="import.date"/></td>
                    <td colspan="2" class="noprint"><fmt:formatDate value="${item.pojo.importDate}" pattern="dd/MM/yyyy"/></td>
                </tr>
                <tr>
                    <td><fmt:message key="label.description"/></td>
                    <td colspan="5">${item.pojo.description}</td>
                </tr>
            </table>
            <table class="tbInput">
                <caption><fmt:message key="import.info.material"/></caption>
                <tr id="tbHead">
                    <th ><fmt:message key="label.item.name"/></th>
                    <th ><fmt:message key="label.code"/></th>
                    <th ><fmt:message key="label.unit"/></th>
                    <th ><fmt:message key="label.quantity"/></th>
                    <th ><fmt:message key="label.made.in"/></th>
                    <th ><fmt:message key="label.expiredDate"/></th>
                    <security:authorize ifAnyGranted="NHANVIENTT,QUANLYTT,LANHDAO">
                        <th ><fmt:message key="label.price.vnd"/></th>
                    </security:authorize>
                </tr>
                <c:forEach items="${importMaterials}" var="importMaterial" varStatus="status">
                    <tr id="mtr_${status.index}" style="text-align: center">
                        <td style="width:18%">${importMaterial.material.name}</td>
                        <td style="width:15%;">${importMaterial.code}</td>
                        <td style="width:8%;">${importMaterial.material.unit.name}</td>
                        <td style="width:15%;"><span id="quantity_${status.index}"><fmt:formatNumber value="${importMaterial.quantity}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/></span></td>
                        <td style="width:15%;">${importMaterial.origin.name}</td>
                        <td style="width:15%;"><fmt:formatDate value="${importMaterial.expiredDate}" pattern="dd/MM/yyyy"/></td>
                        <security:authorize ifAnyGranted="NHANVIENTT,QUANLYTT,LANHDAO">
                            <td style="width:14%;">
                                <input id="money_${status.index}" name="materialMoneyMap[${importMaterial.importMaterialID}]" value="<fmt:formatNumber value="${importMaterial.money}" pattern="###,###.##" maxFractionDigits="2" minFractionDigits="0"/>" type="text" class="inputFractionNumber width2" onblur="setTotalMoney();"/>
                            </td>
                        </security:authorize>
                    </tr>
                </c:forEach>
                <security:authorize ifAnyGranted="NHANVIENTT,QUANLYTT,LANHDAO">
                    <input type="hidden" id="noMaterial" value="${fn:length(importMaterials)}"/>
                    <tr>
                        <td colspan="6" style="font-weight: bold; text-align: right"><fmt:message key="label.total.money"/></td>
                    <td><input id="totalMoney" name="pojo.totalMoney" value="<fmt:formatNumber value="${item.pojo.totalMoney}"/>" type="text" class="inputFractionNumber width2" readonly="readonly"/></td>
                    </tr>
                </security:authorize>
            </table>
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
                            <security:authorize ifAnyGranted="QUANLYTT">
                                <c:if test="${item.pojo.status ne Constants.REJECTED}">
                                    <a onclick="saveMoney()" class="btn btn-success" style="cursor: pointer;">
                                        <fmt:message key="button.confirm.money"/>
                                    </a>
                                </c:if>
                            </security:authorize>
                            <div style="display: inline">
                                <form:hidden path="crudaction" id="crudaction" value="insert-update"/>
                                <form:hidden path="pojo.importMaterialBillID"/>
                                <a href="${backUrl}" class="cancel-link">
                                    <fmt:message key="button.cancel"/>
                                </a>
                            </div>
                        </td>
                    </tr>
                </table>
            </security:authorize>
            <%@include file="../common/tablelog.jsp"%>
            <security:authorize ifNotGranted="NHANVIENTT,QUANLYTT,QUANLYKHO,LANHDAO">
            <div class="controls">
                <div style="display: inline">
                    <a href="javascript:window.print();" class="btn btn-primary"><i class="icon-print"></i> <fmt:message key="button.print"/></a>
                    <a href="${backUrl}" class="cancel-link">
                        <fmt:message key="button.cancel"/>
                    </a>
                </div>
            </div>
            </security:authorize>

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
    var noMaterial = $("#noMaterial").val();
    $( document ).ready(function() {
    });
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
        for(var q = 0; q < noMaterial; q++)
        {
            var money = $("#money_" + q).val() != ""  ? $("#money_"+q).val() : "0";
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