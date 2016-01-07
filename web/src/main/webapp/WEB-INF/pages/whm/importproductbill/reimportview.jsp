<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" errorPage="/error.jsp" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@page import="com.banvien.tpk.core.Constants" %>

<head>
    <title><fmt:message key="whm.reimportproduct.title"/></title>
    <meta name="heading" content="<fmt:message key="whm.reimportproduct.title"/>"/>
    <link rel="stylesheet" href="<c:url value='/themes/whm/css/jquery.jscrollpane.css' />" />


</head>

<c:url var="url" value="/whm/importproductbill/reimportview.html"/>
<c:url var="backUrl" value="/whm/importproductbill/reimportlist.html"/>
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
            <div class="content-header noprint"><fmt:message key="whm.reimportproduct.title"/></div>
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
                <caption><fmt:message key="import.info.product.base"/></caption>
                <tr id="tbHead">
                    <th>STT</th>
                    <th class="table_header text-center"><fmt:message key="whm.productname.name"/></th>
                    <th class="table_header text-center"><fmt:message key="label.code"/></th>
                    <th class="table_header text-center"><fmt:message key="label.size"/></th>
                    <th class="table_header text-center thickness"><fmt:message key="whm.thickness.name"/></th>
                    <th class="table_header text-center overlay"><fmt:message key="whm.overlaytype.name"/></th>
                    <th class="table_header text-center stiffness"><fmt:message key="whm.stiffness.name"/></th>
                    <th class="table_header text-center colour"><fmt:message key="whm.colour.name"/></th>
                    <th class="table_header text-center core"><fmt:message key="label.core"/></th>
                    <th class="table_header text-center"><fmt:message key="label.kg"/></th>
                    <th class="table_header text-center"><fmt:message key="label.m"/></th>
                </tr>
                <c:set var="totalMet" value="0"/>
                <c:set var="totalPure" value="0"/>
                <c:set var="thickness" value="false"/>
                <c:set var="overlay" value="false"/>
                <c:set var="stiffness" value="false"/>
                <c:set var="colour" value="false"/>
                <c:set var="core" value="false"/>

                <c:forEach items="${importProducts}" var="importProduct" varStatus="status">
                    <tr id="prd_${status.index}">
                        <td style="width: 3%">${status.index + 1}</td>
                        <td class="inputItemInfo10">${importProduct.productname.name}</td>
                        <%--<td class="inputItemInfo10">${tpk:productCodeWhenPrint(importProduct.productCode)}</td>--%>
                        <td class="inputItemInfo10">${importProduct.productCode}</td>
                        <td class="inputItemInfo10">${importProduct.size.name}</td>
                        <td class="inputItemInfo10 thickness">${importProduct.thickness.name}</td>
                        <td class="inputItemInfo10 overlay">${importProduct.overlaytype.name}</td>
                        <td class="inputItemInfo10 stiffness">${importProduct.stiffness.name}</td>
                        <td class="inputItemInfo10 colour">${importProduct.colour.name}</td>
                        <td class="inputItemInfo10 core">${importProduct.core}</td>
                        <td class="inputItemInfo10"><fmt:formatNumber value="${importProduct.quantity2Pure}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/></td>
                        <td class="inputItemInfo10"><fmt:formatNumber value="${importProduct.quantity1}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/></td>
                    </tr>
                    <c:if test="${not empty importProduct.thickness}"><c:set var="thickness" value="true"/></c:if>
                    <c:if test="${not empty importProduct.overlaytype}"><c:set var="overlay" value="true"/></c:if>
                    <c:if test="${not empty importProduct.stiffness}"><c:set var="stiffness" value="true"/></c:if>
                    <c:if test="${not empty importProduct.colour}"><c:set var="colour" value="true"/></c:if>
                    <c:if test="${not empty importProduct.core}"><c:set var="core" value="true"/></c:if>
                    <c:set var="totalMet" value="${totalMet + importProduct.quantity1}"/>
                    <c:set var="totalPure" value="${totalPure + importProduct.quantity2Pure}"/>
                </c:forEach>
                <tr style="font-weight: bold;">
                    <td colspan="3" style="text-align: right"><fmt:message key="label.total"/></td>
                    <td style="text-align: center;">${fn:length(importProducts)} CUỘN</td>
                    <td class="thickness"></td>
                    <td class="overlay"></td>
                    <td class="stiffness"></td>
                    <td class="colour"></td>
                    <td class="core"></td>
                    <td style="text-align: center;"><fmt:formatNumber value="${totalPure}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/></td>
                    <td style="text-align: center;"><fmt:formatNumber value="${totalMet}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/></td>
                </tr>
            </table>
            <security:authorize ifAnyGranted="QUANLYKHO">
            <table class="tbHskt info noprint">
                <caption><fmt:message key="label.confirmation"/></caption>
                <tr>
                    <td style="width:20%;"><fmt:message key="label.note"/></td>
                    <td style="width:80%;"><form:textarea path="pojo.note" cssClass="nohtml nameValidate span11" rows="2"/></td>
                </tr>
                <tr>
                    <td class="ctrl-btn" colspan="2">
                        <a href="javascript:window.print();" class="btn btn-primary"><i class="icon-print"></i> <fmt:message key="button.print"/></a>
                        <security:authorize ifAnyGranted="QUANLYKHO">
                            <c:if test="${item.pojo.status == Constants.WAIT_CONFIRM}">
                                <a onclick="rejectBill()" class="btn btn-danger" style="cursor: pointer;">
                                    <fmt:message key="button.reject"/>
                                </a>
                                <a onclick="saveBill()" class="btn btn-success" style="cursor: pointer;">
                                    <fmt:message key="button.confirm"/>
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
            <security:authorize ifNotGranted="QUANLYKHO">
                <div class="controls">
                    <div style="display: inline">
                        <a href="javascript:window.print();" class="btn btn-primary"><i class="icon-print"></i> <fmt:message key="button.print"/></a>
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
        <c:if test="${thickness eq 'false'}">$('.thickness').hide();</c:if>
        <c:if test="${overlay eq 'false'}">$('.overlay').hide();</c:if>
        <c:if test="${stiffness eq 'false'}">$('.stiffness').hide();</c:if>
        <c:if test="${colour eq 'false'}">$('.colour').hide();</c:if>
        <c:if test="${core eq 'false'}">$('.core').hide();</c:if>
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
        $('.inputNumber').each(function(){
            if($(this).val() != '' && $(this).val() != 0 ) {
                $(this).val(numeral().unformat($(this).val()));
            }
        });
    }
    function setTotalMoney(){
        var tong = 0;
        for(var q = 0; q<noRootMaterial; q++)
        {
            var money = $("#money_" + q).val() != ""  ? $("#money_"+q).val() : "0";
            if(money == undefined){ money = "0"}
            money = numeral().unformat(money);
            if(money!="")
            {
                tong += parseFloat(money);
            }
        }
        var string = numeral(parseFloat(tong)).format('0,0');
        $("#totalMoney").val(string);
    }
</script>