<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" errorPage="/error.jsp" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@page import="com.banvien.tpk.core.Constants" %>

<head>
    <title><fmt:message key="booking.bill.view.title"/></title>
    <meta name="heading" content="<fmt:message key="booking.bill.view.title"/>"/>
    <link rel="stylesheet" href="<c:url value='/themes/whm/css/jquery.jscrollpane.css' />" />
</head>

<c:url var="url" value="/whm/booking/view.html"/>
<c:url var="backUrl" value="/whm/booking/list.html"/>

<form:form commandName="item" action="${url}" method="post" id="itemForm" class="form-horizontal" novalidate="novalidate">
    <div id="container-fluid data_content_box">
        <div class="row-fluid data_content">
            <div class="content-header"><fmt:message key="booking.bill.view.title"/></div>
            <div class="clear"></div>
            <div id="generalInfor">
                <table class="tbHskt info">
                    <caption><fmt:message key="import.material.generalinfo"/></caption>
                    <tr>
                        <td class="wall"><fmt:message key="label.customer"/></td>
                        <td colspan="5">${item.pojo.customer.name} - ${item.pojo.customer.address}</td>
                    </tr>
                    <tr>
                        <td><fmt:message key="label.description"/></td>
                        <td colspan="5">${item.pojo.description}</td>
                    </tr>
                </table>
            </div>
            <div class="clear"></div>
            <c:if test="${not empty item.pojo.bookProducts}">
                <c:set var="totalMet" value="0"/>
                <c:set var="totalKg" value="0"/>
                <display:table name="item.pojo.bookProducts" cellspacing="0" cellpadding="0" requestURI="${formlUrl}"
                               partialList="true" sort="external" size="${fn:length(item.pojo.bookProducts)}"
                               uid="tableList" excludedParams="crudaction"
                               pagesize="${fn:length(item.pojo.bookProducts)}" export="false" class="tableSadlier table-hover" style="margin: 0 0 0 0;">
                    <display:caption><fmt:message key='booked.product.list'/></display:caption>
                    <display:column headerClass="table_header_center" sortable="false" title="STT" class="text-center" style="width: 2%;">
                        ${tableList_rowNum}
                    </display:column>
                    <display:column headerClass="table_header_center" sortable="false" titleKey="label.status" class="text-center" style="width: 10%;">
                        <c:choose>
                            <c:when test="${tableList.importProduct.status == Constants.ROOT_MATERIAL_STATUS_BOOKED}">Chờ xuất</c:when>
                            <c:when test="${tableList.importProduct.status == Constants.ROOT_MATERIAL_STATUS_USED}">Đã xuất</c:when>
                            <c:otherwise>-</c:otherwise>
                        </c:choose>
                    </display:column>
                    <display:column headerClass="table_header_center" property="importProduct.productname.name" sortable="false"  titleKey="whm.productname.name" class="text-center" style="width: 7%;"/>
                    <display:column headerClass="table_header_center" property="importProduct.productCode" titleKey="label.number" class="text-center" style="width: 7%;"/>

                    <display:column headerClass="table_header_center" property="importProduct.size.name" sortable="false"  titleKey="whm.size.name" class="text-center" style="width: 7%;"/>
                    <display:column headerClass="table_header_center" property="importProduct.thickness.name" sortable="false"  titleKey="whm.thickness.name" class="text-center" style="width: 7%;"/>
                    <display:column headerClass="table_header_center" property="importProduct.stiffness.name" sortable="false"  titleKey="whm.stiffness.name" class="text-center" style="width: 7%;"/>
                    <display:column headerClass="table_header_center" property="importProduct.colour.name" sortable="false"  titleKey="whm.colour.name" class="text-center" style="width: 7%;"/>
                    <display:column headerClass="table_header_center" property="importProduct.overlaytype.name" sortable="false"  titleKey="whm.overlaytype.name" class="text-center" style="width: 7%;"/>
                    <display:column headerClass="table_header_center" sortable="false" titleKey="import.warehouse.date" class="text-center" style="width: 7%;">
                        <c:choose>
                            <c:when test="${not empty tableList.importProduct.produceDate}">
                                <fmt:formatDate value="${tableList.importProduct.produceDate}" pattern="dd/MM/yyyy"/>
                            </c:when>
                            <c:when test="${not empty tableList.importProduct.importDate}">
                                <fmt:formatDate value="${tableList.importProduct.importDate}" pattern="dd/MM/yyyy"/>
                            </c:when>
                            <c:otherwise>-</c:otherwise>
                        </c:choose>
                    </display:column>
                    <display:column headerClass="table_header large" sortName="quantity1" sortable="false" titleKey="label.quantity.meter" style="width: 10%;text-align:right;">
                        <fmt:formatNumber value="${tableList.importProduct.quantity1}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/>
                        <c:set var="totalMet" value="${totalMet + tableList.importProduct.quantity1}"/>
                    </display:column>
                    <display:column headerClass="table_header large" sortName="quantity2Pure" sortable="false" titleKey="label.quantity.kg" style="width: 10%;text-align:right;">
                        <fmt:formatNumber value="${tableList.importProduct.quantity2Pure}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/>
                        <c:set var="totalKg" value="${totalKg + tableList.importProduct.quantity2Pure}"/>
                    </display:column>
                    <security:authorize ifNotGranted="QUANLYKD">
                    <display:column headerClass="table_header_center" sortable="false" titleKey="<input type=\"checkbox\" onclick=\"checkAllByClass('checkPrd', this);\"/>" style="width: 5%;text-align:center">
                        <c:if test="${tableList.importProduct.status == Constants.ROOT_MATERIAL_STATUS_BOOKED}">
                            <input class="checkPrd" type="checkbox" name="bookedProductIDs" value="${tableList.importProduct.importProductID}"/>
                        </c:if>
                    </display:column>
                    </security:authorize>
                    <display:setProperty name="paging.banner.item_name" value="cuộn tôn"/>
                    <display:setProperty name="paging.banner.items_name" value="cuộn tôn"/>
                    <display:setProperty name="paging.banner.placement" value=""/>
                    <display:setProperty name="paging.banner.no_items_found" value=""/>
                </display:table>
                <div style="clear:both"></div>
                <table class="tableSadlier">
                    <tr style="font-weight: bold">
                        <td style="text-align: left;width: 60%">
                            Tổng: ${fn:length(item.pojo.bookProducts)} cuộn
                        </td>
                        <td style="text-align: right;width: 40%;padding-right: 38px;">
                            Mét: <fmt:formatNumber value="${totalMet}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/>
                            <span class="separator"></span>
                            Tấn: <fmt:formatNumber value="${totalKg / 1000}" pattern="###,###" maxFractionDigits="0" minFractionDigits="3"/>
                        </td>
                    </tr>
                </table>
            </c:if>
            <div style="clear:both"></div>
            <div class="controls">
                <c:if test="${item.pojo.status == Constants.BOOK_ALLOW_EXPORT || item.pojo.status == Constants.BOOK_EXPORTING}">
                    <security:authorize ifAnyGranted="XUAT_TP,QUANLYKHO">
                        <span style="font-weight: bold">Ngày xuất:&nbsp;</span>
                        <div class="input-append date" style="margin-right: 1px;">
                            <input name="exportDate" id="deliveryDate" class="text-center width2" type="text" />
                            <span class="add-on" id="deliveryDateIcon"><i class="icon-calendar"></i></span>
                        </div>
                        &nbsp;
                        <a onclick="saveExportBill()" class="btn btn-green btn-success" style="cursor: pointer;width: 220px;">
                            <i class="icon-check"></i> <fmt:message key="button.create.export.bill"/>
                        </a>
                    </security:authorize>
                </c:if>
                <c:if test="${item.pojo.status == Constants.BOOK_WAIT_CONFIRM}">
                    <security:authorize ifAnyGranted="QUANLYKD">
                        <a onclick="rejectBill()" class="btn btn-danger" style="cursor: pointer;">
                            <fmt:message key="button.reject"/>
                        </a>
                        <a onclick="approveBill()" class="btn btn-success" style="cursor: pointer;">
                            <fmt:message key="button.accept"/>
                        </a>
                    </security:authorize>
                </c:if>
                <div style="display: inline">
                    <form:hidden path="crudaction" id="crudaction" value="insert-update"/>
                    <form:hidden path="pojo.bookProductBillID"/>
                    <a href="${backUrl}" class="cancel-link">
                        <fmt:message key="button.cancel"/>
                    </a>
                </div>
            </div>
        </div>
    </div>
</form:form>
<script type="text/javascript">
    $(document).ready(function(){
        var deliveryDateVar = $("#deliveryDate").datepicker({
            format: 'dd/mm/yyyy',
            onRender: function(date){
            }}).on('changeDate', function(ev) {
                    deliveryDateVar.hide();
                }).data('datepicker');
        $('#deliveryDateIcon').click(function() {
            $('#deliveryDate').focus();
            return true;
        });

    });
    function rejectBill(){
        $("#crudaction").val("reject");
        $("#itemForm").submit();
    }
    function approveBill(){
        $("#crudaction").val("approve");
        $("#itemForm").submit();
    }

function saveExportBill(){
    $("#crudaction").val("insert-update");    
    $("#itemForm").submit();
}
</script>