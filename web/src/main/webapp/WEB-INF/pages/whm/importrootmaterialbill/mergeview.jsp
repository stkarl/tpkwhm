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

<c:url var="url" value="/whm/importrootmaterialbill/mergeView.html"/>
<c:url var="backUrl" value="/whm/importrootmaterialbill/list.html"/>
<form:form commandName="item" action="${url}" method="post" id="itemForm" class="form-horizontal" novalidate="novalidate">
    <div id="container-fluid data_content_box">
        <div class="row-fluid data_content">
            <c:if test="${!empty messageResponse}">
                <div class="alert alert-${alertType}">
                    <a class="close" data-dismiss="alert" href="#">x</a>
                        ${messageResponse}
                </div>
                <div style="clear:both;"></div>
            </c:if>
            <div class="content-header noprint"><fmt:message key="whm.importproduct.material.merge"/></div>
            <div class="clear"></div>
            <table class="tbHskt info">
                <caption><fmt:message key="import.material.generalinfo"/></caption>
                <tr>
                    <td><fmt:message key="label.number"/></td>
                    <td colspan="2">${code}</td>
                    <td class="wall"><fmt:message key="label.used.market"/></td>
                    <td colspan="2">
                        <form:select path="marketID">
                            <form:option value=""><fmt:message key="label.select"/></form:option>
                            <c:forEach items="${markets}" var="market">
                                <form:option value="${market.marketID}">${market.name}</form:option>
                            </c:forEach>
                        </form:select>
                    </td>
                </tr>
                <tr>
                    <td><fmt:message key="import.material.supplier"/></td>
                    <td colspan="2">${customer.name} - ${customer.province.name}</td>
                    <td class="wall"><fmt:message key="import.material.receive.warehouse"/></td>
                    <td colspan="2">${warehouse.name}</td>
                </tr>
                <tr>
                    <td><fmt:message key="label.location"/></td>
                    <td colspan="2">${warehouseMap.name}</td>
                    <td class="wall"><fmt:message key="import.date"/></td>
                    <td colspan="2">
                        <div class="input-append date" >
                            <fmt:formatDate var="importedDate" value="${importDate}" pattern="dd/MM/yyyy"/>
                            <input name="importDate" id="importDate" class="prevent_type text-center width2" value="${importedDate}" type="text" />
                            <span class="add-on" id="importDateIcon"><i class="icon-calendar"></i></span>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td><fmt:message key="label.description"/></td>
                    <td colspan="5">
                        <form:textarea path="description" cssClass="nohtml nameValidate span11" rows="2"/>
                        <form:errors path="description" cssClass="error-inline-validate"/>
                    </td>
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
                </tr>
                <c:set var="total" value="0"/>
                <c:set var="totalPure" value="0"/>
                <c:set var="totalActual" value="0"/>
                <c:set var="noRoll" value="0"/>
                <c:forEach items="${importproductbills}" var="bill" varStatus="status">
                    <c:forEach items="${bill.importproducts}" var="importProduct" varStatus="status">
                        <tr id="prd_${status.index}">
                            <td style="width: 3%">${status.index + 1}</td>
                            <td class="inputItemInfo0">${importProduct.productname.name}</td>
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
                        </tr>
                        <c:set var="total" value="${total + importProduct.quantity2}"/>
                        <c:set var="totalPure" value="${totalPure + importProduct.quantity2Pure}"/>
                        <c:set var="totalActual" value="${totalActual + importProduct.quantity2Actual}"/>
                        <c:set var="noRoll" value="${noRoll + 1}"/>
                    </c:forEach>
                </c:forEach>
                <tr style="font-weight: bold;">
                    <td colspan="3" style="text-align: right"><fmt:message key="label.total"/></td>
                    <td style="text-align: center;">${noRoll} CUỘN</td>
                    <td style="text-align: center;"><fmt:formatNumber value="${totalPure}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/></td>
                    <td style="text-align: center;"><fmt:formatNumber value="${total}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/></td>
                    <td style="text-align: center;"><fmt:formatNumber value="${totalActual}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/></td>
                    <td style="text-align: center;">
                        <c:if test="${total > 0 && totalActual > 0}">
                            <fmt:formatNumber value="${totalActual - total}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/>
                        </c:if>
                    </td>
                    <td></td>
                </tr>
            </table>

            <security:authorize ifAnyGranted="NHANVIENKHO,QUANLYKHO">
                <div class="controls">
                    <div style="display: inline">
                        <a class="btn btn-info " onclick="mergeBill();"><i class="icon-plus"></i> <fmt:message key="label.merge"/></a>
                        <form:hidden path="billIDs"/>
                        <form:hidden path="crudaction" id="crudaction"/>
                        <a href="${backUrl}" class="cancel-link">
                            <fmt:message key="button.cancel"/>
                        </a>
                    </div>
                </div>
            </security:authorize>
        </div>
    </div>
</form:form>
<script type="text/javascript">
    $(document).ready(function(){
        var importDateVar = $("#importDate").datepicker({
            format: 'dd/mm/yyyy',
            onRender: function(date){
            }}).on('changeDate', function(ev) {
                    importDateVar.hide();
                }).data('datepicker');
        $('#importDateIcon').click(function() {
            $('#importDate').focus();
            return true;
        });
    });
    function mergeBill(){
        $("#crudaction").val("insert-update");
        $("#itemForm").submit();
    }
</script>