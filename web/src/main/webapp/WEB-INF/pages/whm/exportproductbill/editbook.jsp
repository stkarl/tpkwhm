<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" errorPage="/error.jsp" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@page import="com.banvien.tpk.core.Constants" %>

<head>
    <title><fmt:message key="edit.export.book.bill"/></title>
    <meta name="heading" content="<fmt:message key="edit.export.book.bill"/>"/>
</head>

<c:url var="url" value="/whm/exportproductbill/editbook.html"/>
<c:url var="editUrl" value="/whm/exportproductbill/edit.html"/>
<c:url var="backUrl" value="/whm/exportrootmaterialbill/list.html?isBlackProduct=${item.isBlackProduct}"/>
<form:form commandName="item" action="${url}" method="post" id="itemForm" class="form-horizontal" novalidate="novalidate">
    <div id="container-fluid data_content_box">
        <div class="row-fluid data_content">
            <div class="content-header"><fmt:message key="edit.export.book.bill"/></div>
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
            <c:if test="${not empty bookedProducts}">
                <c:set var="totalMet" value="0"/>
                <c:set var="totalKg" value="0"/>
                <display:table name="bookedProducts" cellspacing="0" cellpadding="0" requestURI="${editUrl}"
                               partialList="true" sort="external" size="${fn:length(bookedProducts)}"
                               uid="tableList" excludedParams="crudaction"
                               pagesize="${fn:length(bookedProducts)}" export="false" class="tableSadlier table-hover" style="margin: 0 0 0 0;">
                    <display:caption><fmt:message key='booked.product.list'/></display:caption>
                    <display:column headerClass="table_header_center" sortable="false" title="STT" class="text-center" style="width: 2%;">
                        ${tableList_rowNum}
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
                        <input class="checkPrd" type="checkbox" name="itemInfos[${tableList_rowNum - 1}].itemID" value="${tableList.importProduct.importProductID}" ${tempExportedMap[tableList.importProduct.importProductID] ? "checked=\"checked\"" : ""}/>
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
                            Tổng: ${fn:length(bookedProducts)} cuộn
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
            <c:if test="${not empty item.pojo.status}">
                <table class="tbHskt info">
                    <caption><fmt:message key="label.confirmation"/></caption>
                    <tr>
                        <td style="width:20%;"><fmt:message key="label.note"/></td>
                        <td style="width:80%;"><form:textarea path="pojo.note" cssClass="nohtml nameValidate span11" rows="2"/></td>
                    </tr>
                </table>
            </c:if>
            <div class="controls">
                <c:set var="allowEdit" value="${item.pojo.editable}"/>
                <c:if test="${allowEdit}">
                    <security:authorize ifAnyGranted="XUAT_TP,QUANLYKHO">
                        <fmt:formatDate var="exportDate" value="${item.pojo.exportDate}" pattern="dd/MM/yyyy"/>
                        <span style="font-weight: bold">Ngày xuất:&nbsp;</span>
                        <div class="input-append date" style="margin-right: 1px;">
                            <input name="exportDate" id="deliveryDate" class="text-center width2" type="text" value="${exportDate}"/>
                            <span class="add-on" id="deliveryDateIcon"><i class="icon-calendar"></i></span>
                        </div>
                        &nbsp;
                        <a onclick="saveExportBill()" class="btn btn-green btn-success" style="cursor: pointer;">
                            <i class="icon-save"></i> <fmt:message key="button.save"/>
                        </a>
                    </security:authorize>
                </c:if>
                <div style="display: inline">
                    <form:hidden path="crudaction" id="crudaction" value="insert-update"/>
                    <form:hidden path="pojo.exporttype.code" id="exportcode"/>
                    <form:hidden path="pojo.exportProductBillID"/>
                    <form:hidden path="isBlackProduct"/>
                    <a href="${backUrl}" class="cancel-link">
                        <fmt:message key="button.cancel"/>
                    </a>
                </div>
            </div>
            <%@include file="../common/tablelog.jsp"%>
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

function saveExportBill(){
    $("#crudaction").val("insert-update");    
    $("#itemForm").submit();
}

</script>