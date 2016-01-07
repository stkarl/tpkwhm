<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" errorPage="/error.jsp" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@page import="com.banvien.tpk.core.Constants" %>

<head>
    <title><fmt:message key="whm.re.importproduct.title"/></title>
    <meta name="heading" content="<fmt:message key="whm.re.importproduct.title"/>"/>
    <link rel="stylesheet" href="<c:url value='/themes/whm/css/jquery.jscrollpane.css' />" />
    <style>
        .pane_title{
            text-align:center;
        }
    </style>

</head>

<c:url var="url" value="/whm/importproductbill/reimport.html"/>
<c:url var="backUrl" value="/whm/importproductbill/reimportlist.html"/>
<form:form commandName="item" action="${url}" method="post" id="itemForm" class="form-horizontal" novalidate="novalidate">
<div id="container-fluid data_content_box">
<div class="row-fluid data_content">
<div class="content-header"><fmt:message key="whm.re.importproduct.declare"/></div>
<div class="clear"></div>
<div class="alert alert-error" style="display: none;">
    <a onclick="closeAlert();" href="#" style="float: right;font-size: larger;color: #C5B0C2;">&times;</a>
    Hãy nhập đủ thông tin bắt buộc trước khi lưu.
</div>
<div style="color: red; clear: both; font-style: italic; margin-bottom: 12px;">Lưu ý: Nhập Mã gốc để kiểm tra thông tin cũ trước.</div>
<div id="generalInfor">
    <table class="tbHskt info">
        <caption><fmt:message key="import.material.generalinfo"/></caption>
        <tr>
            <td><fmt:message key="label.number"/></td>
            <td colspan="2">
                <span>${item.pojo.code}</span>
                <form:hidden path="pojo.code"/>
            </td>
            <td class="wall"><fmt:message key="import.material.supplier"/></td>
            <td colspan="2">
                <form:select path="pojo.customer.customerID">
                    <form:option value=""><fmt:message key="label.select"/></form:option>
                    <c:forEach items="${customers}" var="customer">
                        <form:option value="${customer.customerID}">${customer.name}-${customer.address}</form:option>
                    </c:forEach>
                </form:select>
            </td>
        </tr>
        <tr>
            <td><fmt:message key="label.location"/></td>
            <td colspan="2">
                <form:select path="pojo.warehouseMap.warehouseMapID">
                    <form:option value=""><fmt:message key="label.select"/></form:option>
                    <c:forEach items="${warehouseMaps}" var="warehouseMap">
                        <form:option value="${warehouseMap.warehouseMapID}">${warehouseMap.name}</form:option>
                    </c:forEach>
                </form:select>
            </td>
            <td class="wall"><fmt:message key="import.date"/></td>
            <td colspan="2">
                <div class="input-append date" >
                    <fmt:formatDate var="importedDate" value="${item.pojo.importDate}" pattern="dd/MM/yyyy"/>
                    <input name="pojo.importDate" id="importDate" class="prevent_type text-center width2" value="${importedDate}" type="text" />
                    <span class="add-on" id="importDateIcon"><i class="icon-calendar"></i></span>
                </div>
            </td>
        </tr>
        <tr>
            <td><fmt:message key="label.description"/></td>
            <td colspan="5">
                <form:textarea path="pojo.description" cssClass="nohtml nameValidate span11" rows="2"/>
                <form:errors path="pojo.description" cssClass="error-inline-validate"/>
            </td>
        </tr>
    </table>
</div>
<div class="clear"></div>
<c:if test="${empty item.pojo.importproducts}">
    <c:set var="counterNL" value="0"></c:set>
        <div class="right-btn" id="bt_add_sp_${counterNL}">
            <a class="btn btn-info " onclick="addSP('${counterNL}');"><i class="icon-plus"></i> <fmt:message key="label.add.product"/> </a>
        </div>
        <div class="clear"></div>
            <%-- declare produced product--%>
        <c:set var="counterSP" value="0"></c:set>
        <div id="div_sp_${counterSP}">
            <div class="pane_title">
                    <span style="float: left;" >
                            <a id="btn-hide-sp-${counterSP}" title="<fmt:message key="label.hide"/>" class="tip-top" onclick="hideSP('${counterSP}');">
                                <i class="icon-collapse-alt"></i>
                            </a>
                        <a style="display: none;" id="btn-show-sp-${counterSP}" title="<fmt:message key="label.show"/>" class="tip-top" onclick="showSP('${counterSP}');">
                            <i class="icon-expand-alt"></i>
                        </a>
                    </span>
                <fmt:message key = "produced.product.info"/>
                        <span style="float: right;">
                            <a title="<fmt:message key="label.remove.product"/>" class="tip-top" onclick="removeSP('div_sp_${counterSP}');">
                                <i class="icon-trash"></i>
                            </a>
                        </span>
            </div>
            <div id="div_sp_detail_${counterSP}">
                <table class="tbInput" style="margin-bottom: 12px;">
                    <tr>
                        <td><fmt:message key="label.product.name"/></td>
                        <td>
                            <select class="width4 requiredField" sp="${counterSP}" name="reImportProducts[${counterSP}].productname.productNameID" id="sl_prd_name_${counterSP}">
                                <option value="">-<fmt:message key="label.select"/>-</option>
                                <c:forEach items="${productNames}" var="productName">
                                    <option value="${productName.productNameID}">${productName.name}</option>
                                </c:forEach>
                            </select>
                        </td>
                        <td><fmt:message key="label.original.code"/></td>
                        <td>
                            <input counter="${counterSP}" name="reImportProducts[${counterSP}].originalCode" onblur="validateCodeNew(this);" type="text" class="uppercase span11"/>
                        </td>
                        <td><fmt:message key="label.new.code"/></td>
                        <td>
                            <input name="reImportProducts[${counterSP}].productCode" type="text" class="uppercase span11 requiredField" sp="${counterSP}"/>
                        </td>
                    </tr>

                    <tr>
                        <td><fmt:message key="label.size"/></td>
                        <td>
                            <select class="width4" name="reImportProducts[${counterSP}].size.sizeID">
                                <option value="">-<fmt:message key="label.select"/>-</option>
                                <c:forEach items="${sizes}" var="size">
                                    <option value="${size.sizeID}">${size.name}</option>
                                </c:forEach>
                            </select>
                        </td>
                        <td><fmt:message key="label.thickness"/></td>
                        <td>
                            <select class="width4" name="reImportProducts[${counterSP}].thickness.thicknessID">
                                <option value="">-<fmt:message key="label.select"/>-</option>
                                <c:forEach items="${thicknesses}" var="thickness">
                                    <option value="${thickness.thicknessID}">${thickness.name}</option>
                                </c:forEach>
                            </select>
                        </td>
                        <td><fmt:message key="label.quantity.kg"/></td>
                        <td>
                            <input name="reImportProducts[${counterSP}].quantity2Pure" id="quantityPure-${counterSP}" type="text" class="inputNumber span11" sp="${counterSP}"/>
                        </td>
                    </tr>

                    <tr>
                        <td><fmt:message key="whm.stiffness.name"/></td>
                        <td>
                            <select class="width4" name="reImportProducts[${counterSP}].stiffness.stiffnessID">
                                <option value="">-<fmt:message key="label.select"/>-</option>
                                <c:forEach items="${stiffnesses}" var="stiffness">
                                    <option value="${stiffness.stiffnessID}">${stiffness.name}</option>
                                </c:forEach>
                            </select>
                        </td>
                        <td><fmt:message key="label.colour"/></td>
                        <td>
                            <select class="width4" name="reImportProducts[${counterSP}].colour.colourID">
                                <option value="">-<fmt:message key="label.select"/>-</option>
                                <c:forEach items="${colours}" var="colour">
                                    <option value="${colour.colourID}">${colour.name}</option>
                                </c:forEach>
                            </select>
                        </td>
                        <td><fmt:message key="label.core"/></td>
                        <td>
                            <input name="reImportProducts[${counterSP}].core" type="text" class="inputNumber span11"/>
                        </td>
                    </tr>
                    <tr>
                        <td><fmt:message key="whm.overlaytype.name"/></td>
                        <td>
                            <select class="width4" name="reImportProducts[${counterSP}].overlaytype.overlayTypeID">
                                <option value="">-<fmt:message key="label.select"/>-</option>
                                <c:forEach items="${overlayTypes}" var="overlayType">
                                    <option value="${overlayType.overlayTypeID}">${overlayType.name}</option>
                                </c:forEach>
                            </select>
                        </td>
                        <td><fmt:message key="label.used.market"/></td>
                        <td>
                            <select class="width4" name="reImportProducts[${counterSP}].market.marketID">
                                <option value="">-<fmt:message key="label.select"/>-</option>
                                <c:forEach items="${markets}" var="market">
                                    <option value="${market.marketID}">${market.name}</option>
                                </c:forEach>
                            </select>
                        </td>
                        <td><fmt:message key="label.quantity.meter"/></td>
                        <td><input id="quantity_${counterSP}" name="reImportProducts[${counterSP}].quantity1" type="text" class="inputNumber span11"/></td>
                    </tr>
                    <tr>
                        <td><fmt:message key="label.quality.assessment"/></td>
                        <td colspan="5">
                            <textarea name="reImportProducts[${counterSP}].note" style="width: 97%;" rows="2"></textarea>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
</c:if>
<c:if test="${not empty item.pojo.importproducts}">
<c:set var="counterNL" value="0"></c:set>
<c:set var="counterSP" value="0"></c:set>
        <div id="bt_add_sp_${counterNL}" class="right-btn">
            <a class="btn btn-info " onclick="addSP('${counterNL}');"><i class="icon-plus"></i> <fmt:message key="label.add.product"/> </a>
        </div>
        <div class="clear"></div>
        <c:forEach items="${item.pojo.importproducts}" var="product" varStatus="counter">
            <%-- declare produced product--%>
            <div id="div_sp_${counterSP}">
                <div class="pane_title">
                            <span style="float: left;" >
                            <a id="btn-hide-sp-${counterSP}" title="<fmt:message key="label.hide"/>" class="tip-top" onclick="hideSP('${counterSP}');">
                                <i class="icon-collapse-alt"></i>
                            </a>
                            <a style="display: none;" id="btn-show-sp-${counterSP}" title="<fmt:message key="label.show"/>" class="tip-top" onclick="showSP('${counterSP}');">
                                <i class="icon-expand-alt"></i>
                            </a>
                            </span>
                    <fmt:message key = "produced.product.info"/>
                            <span style="float: right;">
                                <a title="<fmt:message key="label.remove.product"/>" class="tip-top" onclick="removeSP('div_sp_${counterSP}');">
                                    <i class="icon-trash"></i>
                                </a>
                            </span>
                </div>
                <div id="div_sp_detail_${counterSP}">
                    <table class="tbInput" style="margin-bottom: 12px;">
                        <tr>
                            <td><fmt:message key="label.product.name"/></td>
                            <td>
                                <select class="width4 requiredField" sp="${counterSP}" name="reImportProducts[${counterSP}].productname.productNameID" id="sl_prd_name_${counterSP}">
                                    <option value="">-<fmt:message key="label.select"/>-</option>
                                    <c:forEach items="${productNames}" var="productName">
                                        <option value="${productName.productNameID}" <c:if test="${productName.productNameID == product.productname.productNameID}">selected</c:if>>${productName.name}</option>
                                    </c:forEach>
                                </select>
                            </td>
                            <td><fmt:message key="label.original.code"/></td>
                            <td>
                                <input counter="${counterSP}" name="reImportProducts[${counterSP}].originalCode" onblur="validateCodeNew(this);" value="${product.originalProduct.productCode}" type="text" class="uppercase span11"/>
                            </td>
                            <td><fmt:message key="label.new.code"/></td>
                            <td>
                                <input name="reImportProducts[${counterSP}].productCode" value="${product.productCode}" type="text" class="uppercase span11 requiredField" sp="${counterSP}"/>
                            </td>
                        </tr>

                        <tr>
                            <td><fmt:message key="label.size"/></td>
                            <td>
                                <select class="width4" name="reImportProducts[${counterSP}].size.sizeID">
                                    <option value="">-<fmt:message key="label.select"/>-</option>
                                    <c:forEach items="${sizes}" var="size">
                                        <option value="${size.sizeID}" <c:if test="${size.sizeID == product.size.sizeID}">selected</c:if>>${size.name}</option>
                                    </c:forEach>
                                </select>
                            </td>
                            <td><fmt:message key="label.thickness"/></td>
                            <td>
                                <select class="width4" name="reImportProducts[${counterSP}].thickness.thicknessID">
                                    <option value="">-<fmt:message key="label.select"/>-</option>
                                    <c:forEach items="${thicknesses}" var="thickness">
                                        <option value="${thickness.thicknessID}" <c:if test="${thickness.thicknessID == product.thickness.thicknessID}">selected</c:if>>${thickness.name}</option>
                                    </c:forEach>
                                </select>
                            </td>
                            <td><fmt:message key="label.quantity.kg"/></td>
                            <td>
                                <input sp="${counterSP}" name="reImportProducts[${counterSP}].quantity2Pure" id="quantityPure-${counterSP}" type="text" class="inputNumber span11" value="<fmt:formatNumber value="${product.quantity2Pure}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/>"/>
                            </td>
                        </tr>

                        <tr>
                            <td><fmt:message key="whm.stiffness.name"/></td>
                            <td>
                                <select class="width4" name="reImportProducts[${counterSP}].stiffness.stiffnessID">
                                    <option value="">-<fmt:message key="label.select"/>-</option>
                                    <c:forEach items="${stiffnesses}" var="stiffness">
                                        <option value="${stiffness.stiffnessID}" <c:if test="${stiffness.stiffnessID == product.stiffness.stiffnessID}">selected</c:if>>${stiffness.name}</option>
                                    </c:forEach>
                                </select>
                            </td>
                            <td><fmt:message key="label.colour"/></td>
                            <td>
                                <select class="width4" name="reImportProducts[${counterSP}].colour.colourID">
                                    <option value="">-<fmt:message key="label.select"/>-</option>
                                    <c:forEach items="${colours}" var="colour">
                                        <option value="${colour.colourID}" <c:if test="${colour.colourID == product.colour.colourID}">selected</c:if>>${colour.name}</option>
                                    </c:forEach>
                                </select>
                            </td>
                            <td><fmt:message key="label.core"/></td>
                            <td>
                                <input name="reImportProducts[${counterSP}].core" type="text" class="inputNumber span11" value="${product.core}"/>
                            </td>
                        </tr>
                        <tr>
                            <td><fmt:message key="whm.overlaytype.name"/></td>
                            <td>
                                <select class="width4" name="reImportProducts[${counterSP}].overlaytype.overlayTypeID">
                                    <option value="">-<fmt:message key="label.select"/>-</option>
                                    <c:forEach items="${overlayTypes}" var="overlayType">
                                        <option value="${overlayType.overlayTypeID}" <c:if test="${overlayType.overlayTypeID == product.overlaytype.overlayTypeID}">selected</c:if>>${overlayType.name}</option>
                                    </c:forEach>
                                </select>
                            </td>
                           <td><fmt:message key="label.used.market"/></td>
                            <td>
                                <select class="width4" name="reImportProducts[${counterSP}].market.marketID">
                                    <option value="">-<fmt:message key="label.select"/>-</option>
                                    <c:forEach items="${markets}" var="market">
                                        <option value="${market.marketID}" <c:if test="${market.marketID == product.market.marketID}">selected</c:if>>${market.name}</option>
                                    </c:forEach>
                                </select>
                            </td>
                            <td><fmt:message key="label.quantity.meter"/></td>
                            <td><input id="quantity_${counterSP}" name="reImportProducts[${counterSP}].quantity1" type="text" class="inputNumber span11" value="<fmt:formatNumber value="${product.quantity1}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/>"/></td>

                        </tr>
                        <tr>
                            <td><fmt:message key="label.quality.assessment"/></td>
                            <td colspan="5">
                                <textarea name="reImportProducts[${counterSP}].note" style="width: 97%;" rows="2">${product.note}</textarea>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <div class="clear"></div>
            <c:set var="counterSP" value="${1 + counterSP}"></c:set>
        </c:forEach>
<div class="clear"></div>
</c:if>
<div class="clear"></div>
<c:if test="${not empty item.pojo.status}">
    <table class="tbHskt info">
        <caption><fmt:message key="label.confirmation"/></caption>
        <tr>
            <td style="width:20%;"><fmt:message key="label.note"/></td>
            <td style="width:80%;"><form:textarea path="pojo.note" cssClass="nohtml nameValidate span11" rows="2"/></td>
        </tr>
    </table>
</c:if>
<div class="clear"></div>
<div class="controls">
    <c:set var="allowEdit" value="${item.pojo.editable}"/>
    <c:if test="${empty item.pojo.importProductBillID}">
        <c:set var="allowEdit" value="true"/>
    </c:if>
    <c:if test="${allowEdit}">
        <a onclick="save()" class="btn btn-success btn-green" style="cursor: pointer;">
            <fmt:message key="button.save"/>
        </a>
    </c:if>
    <div style="display: inline">
        <form:hidden path="crudaction" id="crudaction" value="insert-update"/>
        <form:hidden path="pojo.importProductBillID"/>
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
var countNL = ${counterNL};
var countSP = ${counterSP};
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


function save(){
    $("#crudaction").val("insert-update");
    var hasInputNumber = false;
    $('.inputNumber').each(function(){
        if($(this).val() != '' && $(this).val() != 0 ) {
            hasInputNumber = true;
            $(this).val(numeral().unformat($(this).val()));
        }
    });
    var checkField = checkSPRequiredField();
    if(checkField){
        $("#itemForm").submit();
    }else if(!checkField){
        bootbox.alert("<fmt:message key="label.title.confirm"/>", "<fmt:message key="message.require.field.error"/>",function(){
        });
    }
}

function addSP(noNL){
    var noNL = noNL;
    countSP++;
    var sp ='<div class="clear"></div>'+
            '<div id="div_sp_'+countSP+'">'+
            '<div class="pane_title">'+
            '<span style="float: left;" >'+
            '<a id="btn-hide-sp-'+countSP+'" title="<fmt:message key="label.hide"/>" class="tip-top" onclick="hideSP(\''+countSP+'\');">'+
            '<i class="icon-collapse-alt"></i>'+
            '</a>'+
            '<a style="display: none;" id="btn-show-sp-'+countSP+'" title="<fmt:message key="label.show"/>" class="tip-top" onclick="showSP(\''+countSP+'\');">'+
            '<i class="icon-expand-alt"></i>'+
            '</a>'+
            '</span>'+
            '<fmt:message key = "produced.product.info"/>'+
            '<span style="float: right;">'+
            '<a title="<fmt:message key="label.remove.product"/>" class="tip-top" onclick="removeSP(div_sp_'+countSP+');">'+
            '<i class="icon-trash"></i>'+
            '</a>'+
            '</span>'+
            '</div>'+
            '<div id="div_sp_detail_'+countSP+'">'+
            '<table class="tbInput" style="margin-bottom: 12px;">'+
            '<tr>'+
            '<td><fmt:message key="label.product.name"/></td>'+
            '<td>'+
            '<select class="width4 requiredField" sp="'+countSP+'" name="reImportProducts['+countSP+'].productname.productNameID" id="sl_prd_name_'+countSP+'">'+
            '<option value="">-<fmt:message key="label.select"/>-</option>'+
            '<c:forEach items="${productNames}" var="productName">'+
            '<option value="${productName.productNameID}">${productName.name}</option>'+
            '</c:forEach>'+
            '</select>'+
            '</td>'+
            '<td><fmt:message key="label.original.code"/></td>'+
            '<td>'+
            '<input counter="'+countSP+'" name="reImportProducts['+countSP+'].originalCode" onblur="validateCodeNew(this);" type="text" class="uppercase span11"/>'+
            '</td>'+
            '<td><fmt:message key="label.new.code"/></td>'+
            '<td>'+
            '<input name="reImportProducts['+countSP+'].productCode" type="text" class="uppercase span11 requiredField"  sp="'+countSP+'"/>'+
            '</td>'+
            '</tr>'+
            '<tr>'+
            '<td><fmt:message key="label.size"/></td>'+
            '<td>'+
            '<select class="width4" name="reImportProducts['+countSP+'].size.sizeID" id="sl_size_'+countSP+'">'+
            '<option value="">-<fmt:message key="label.select"/>-</option>'+
            '<c:forEach items="${sizes}" var="size">'+
            '<option value="${size.sizeID}">${size.name}</option>'+
            '</c:forEach>'+
            '</select>'+
            '</td>'+
            '<td><fmt:message key="label.thickness"/></td>'+
            '<td>'+
            '<select class="width4" name="reImportProducts['+countSP+'].thickness.thicknessID" id="sl_thickness_'+countSP+'">'+
            '<option value="">-<fmt:message key="label.select"/>-</option>'+
            '<c:forEach items="${thicknesses}" var="thickness">'+
            '<option value="${thickness.thicknessID}">${thickness.name}</option>'+
            '</c:forEach>'+
            '</select>'+
            '</td>'+
            '<td><fmt:message key="label.quantity.kg"/></td>'+
            '<td>'+
            '<input name="reImportProducts['+countSP+'].quantity2Pure" sp="'+countSP+'" id="quantityPure-'+countSP+'" type="text" class="inputNumber span11 weight-'+noNL+'"/>'+
            '</td>'+
            '</tr>'+
            '<tr>'+
            '<td><fmt:message key="whm.stiffness.name"/></td>'+
            '<td>'+
            '<select class="width4" name="reImportProducts['+countSP+'].stiffness.stiffnessID" id="sl_stiffness_'+countSP+'">'+
            '<option value="">-<fmt:message key="label.select"/>-</option>'+
            '<c:forEach items="${stiffnesses}" var="stiffness">'+
            '<option value="${stiffness.stiffnessID}">${stiffness.name}</option>'+
            '</c:forEach>'+
            '</select>'+
            '</td>'+
            '<td><fmt:message key="label.colour"/></td>'+
            '<td>'+
            '<select class="width4" name="reImportProducts['+countSP+'].colour.colourID" id="sl_colour_'+countSP+'">'+
            '<option value="">-<fmt:message key="label.select"/>-</option>'+
            '<c:forEach items="${colours}" var="colour">'+
            '<option value="${colour.colourID}">${colour.name}</option>'+
            '</c:forEach>'+
            '</select>'+
            '</td>'+
            '<td><fmt:message key="label.core"/></td>'+
            '<td>'+
            '<input name="reImportProducts['+countSP+'].core" type="text" class="inputNumber span11"/>'+
            '</td>'+
            '</tr>'+
            '<tr>'+
            '<td><fmt:message key="whm.overlaytype.name"/></td>'+
            '<td>'+
            '<select class="width4" name="reImportProducts['+countSP+'].overlaytype.overlayTypeID" id="sl_overlay_'+countSP+'">'+
            '<option value="">-<fmt:message key="label.select"/>-</option>'+
            '<c:forEach items="${overlayTypes}" var="overlayType">'+
            '<option value="${overlayType.overlayTypeID}">${overlayType.name}</option>'+
            '</c:forEach>'+
            '</select>'+
            '</td>'+
            '<td><fmt:message key="label.used.market"/></td>'+
            '<td>'+
            '<select class="width4" name="reImportProducts['+countSP+'].market.marketID" id="sl_market_'+countSP+'">'+
            '<option value="">-<fmt:message key="label.select"/>-</option>'+
            '<c:forEach items="${markets}" var="market">'+
            '<option value="${market.marketID}">${market.name}</option>'+
            '</c:forEach>'+
            '</select>'+
            '</td>'+
            '<td><fmt:message key="label.quantity.meter"/></td>'+
            '<td><input name="reImportProducts['+countSP+'].quantity1" type="text" class="inputNumber span11" onkeyup="calKgM(\''+countSP+'\');" id="quantity_'+countSP+'"/></td>'+
            '</tr>'+
            '<tr>'+
            '<td><fmt:message key="label.quality.assessment"/></td>'+
            '<td colspan="5">'+
            '<textarea name="reImportProducts['+countSP+'].note" style="width: 97%;" rows="2"></textarea>'+
            '</td>'+
            '</tr>'+
            '</div>'+
            '</div>';
    $("#bt_add_sp_" + noNL).after(sp);
    $("#sl_overlay_" + countSP).select2();
    $("#sl_prd_name_" + countSP).select2();
    $("#sl_size_" + countSP).select2();
    $("#sl_thickness_" + countSP).select2();
    $("#sl_stiffness_" + countSP).select2();
    $("#sl_market_" + countSP).select2();
    $("#sl_colour_" + countSP).select2();
}

function removeSP(spId){
    if(typeof spId == 'string'){
        $("#" + spId).remove();
    }else{
        spId.remove();
    }
}
function hideSP(spId){
    $("#div_sp_detail_" + spId).hide();
    $('#btn-hide-sp-' +spId).hide();
    $('#btn-show-sp-' +spId).show();
}
function showSP(spId){
    $("#div_sp_detail_" + spId).show();
    $('#btn-hide-sp-' +spId).show();
    $('#btn-show-sp-' +spId).hide();
}

function checkSPRequiredField(){
    var checker = true;
    $("input[class*='requiredField']").each(function(){
        if($(this).attr('sp') != undefined){
            var counterSP = $(this).attr('sp');
            var slVal = $("#sl_prd_name_" + counterSP + " option:selected").val();
            if(slVal == null || slVal == '' || slVal < 0){
                checker = false;
                $("#sl_prd_name_" + counterSP).focus();
                return checker;
            }

            if($(this).val() == ''){
                checker = false;
                $(this).focus();
                return checker;
            }
        }
    });
    return checker;
}

function validateCode(ele){
    var code = $.trim($(ele).val()).toUpperCase();
    var counter = $(ele).attr("counter");
    if(code != ''){
        var url = '<c:url value="/ajax/getOriginalProduct.html"/>?code=' + code;
        $.getJSON(url, function(data) {
            if (data.originalID != null){
            }else{
                bootbox.alert("<fmt:message key="label.title.confirm"/>", "<fmt:message key="message.product.code.incorrect"/>",function(){
                });
            }
        });
    }
}

function validateCodeNew(ele){
    var code = $.trim($(ele).val()).toUpperCase();
    var counter = $(ele).attr("counter");
    if(code != ''){
        var url = '<c:url value="/ajax/getOriginalProductNew.html"/>?code=' + code + '&counter=' + counter;
        $.ajax({
            url : url,
            dataType: "html",
            type : "GET",
            complete : function(res){
                if (res.responseText != ''){

                    $('#div_sp_detail_' + counter).html(res.responseText);
                }else{
                    bootbox.alert("<fmt:message key="label.title.confirm"/>", "<fmt:message key="message.product.code.incorrect"/>",function(){});
                }
            }
        });
    }
}
</script>