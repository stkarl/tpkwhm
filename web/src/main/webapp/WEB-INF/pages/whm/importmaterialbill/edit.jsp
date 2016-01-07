<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" errorPage="/error.jsp" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@page import="com.banvien.tpk.core.Constants" %>

<head>
    <title><fmt:message key="whm.importmaterial.title"/></title>
    <meta name="heading" content="<fmt:message key="whm.importmaterial.title"/>"/>
    <link rel="stylesheet" href="<c:url value='/themes/whm/css/jquery.jscrollpane.css' />" />


</head>

<c:url var="url" value="/whm/importmaterialbill/edit.html"/>
<c:url var="backUrl" value="/whm/importmaterialbill/list.html"/>
<form:form commandName="item" action="${url}" method="post" id="itemForm" class="form-horizontal" novalidate="novalidate">
    <div id="container-fluid data_content_box">
    <div class="row-fluid data_content">
        <div class="content-header"><fmt:message key="whm.importmaterial.declare"/></div>
            <div class="clear"></div>
            <div class="guideline">
                <span>(<span class="required">*</span>): là bắt buộc.</span>
                <div style="clear:both"></div>
            </div>
        <div class="alert alert-error" style="display: none;">
            <a onclick="closeAlert();" href="#" style="float: right;font-size: larger;color: #C5B0C2;">&times;</a>
            Hãy nhập đủ thông tin bắt buộc trước khi lưu.
        </div>
            <table class="tbHskt info">
                <caption><fmt:message key="import.material.generalinfo"/></caption>
                <tr>
                    <td><fmt:message key="label.number"/> <span id="rq_code" class="required">*</span></td>
                    <td colspan="2">
                        <span>${item.pojo.code}</span>
                        <form:hidden path="pojo.code"/>
                    </td>
                    <td class="wall"><fmt:message key="label.used.market"/></td>
                    <td colspan="2">
                        <form:select path="pojo.market.marketID">
                            <form:option value=""><fmt:message key="label.select"/></form:option>
                            <c:forEach items="${markets}" var="market">
                                <form:option value="${market.marketID}">${market.name}</form:option>
                            </c:forEach>
                        </form:select>
                    </td>
                </tr>
                <tr>
                    <td><fmt:message key="import.material.supplier"/> <span id="rq_supplier" class="required">*</span></td>
                    <td colspan="2">
                        <form:select path="pojo.customer.customerID" cssClass="required" cssStyle="width: 360px;">
                            <form:option value=""><fmt:message key="label.select"/></form:option>
                            <c:forEach items="${customers}" var="customer">
                                <form:option value="${customer.customerID}">${customer.name} - ${customer.province.name}</form:option>
                            </c:forEach>
                        </form:select>
                    </td>
                    <td class="wall"><fmt:message key="label.location"/></td>
                    <td colspan="2">
                        <form:select path="pojo.warehouseMap.warehouseMapID">
                            <form:option value=""><fmt:message key="label.select"/></form:option>
                            <c:forEach items="${warehouseMaps}" var="warehouseMap">
                                <form:option value="${warehouseMap.warehouseMapID}">${warehouseMap.name}</form:option>
                            </c:forEach>
                        </form:select>
                    </td>
                </tr>
                <tr>
                    <td class="wall"><fmt:message key="import.date"/></td>
                    <td colspan="2">
                        <div class="input-append date" >
                            <fmt:formatDate var="importedDate" value="${item.pojo.importDate}" pattern="dd/MM/yyyy"/>
                            <input name="pojo.importDate" id="importDate" class="prevent_type text-center width2" value="${importedDate}" type="text" />
                            <span class="add-on" id="importDateIcon"><i class="icon-calendar"></i></span>
                        </div>
                    </td>
                    <td></td>
                    <td colspan="2"></td>
                </tr>
                <tr>
                    <td><fmt:message key="label.description"/></td>
                    <td colspan="5">
                        <form:textarea path="pojo.description" cssClass="nohtml nameValidate span11" rows="2"/>
                        <form:errors path="pojo.description" cssClass="error-inline-validate"/>
                    </td>
                </tr>
            </table>
            <div class="row-fluid">
                <c:set var="counter" value="0"></c:set>
                <table class="tbInput">
                    <caption><fmt:message key="import.info.material"/>
                        <span style="float: right;">
                            <a title="<fmt:message key="label.add.material"/>" class="tip-top" onclick="addRowMtr('${counter}');">
                                <i class="icon-plus-sign" ></i>
                            </a>
                        </span>
                    </caption>
                    <tr id="tbHead">
                        <th ><fmt:message key="label.item.name"/></th>
                        <th ><fmt:message key="label.code"/></th>
                        <th ><fmt:message key="label.quantity"/></th>
                        <th ><fmt:message key="label.made.in"/></th>
                        <th ><fmt:message key="label.expiredDate"/></th>
                    </tr>
                    <c:if test="${empty importMaterials}">
                    <tr id="mtr_${counter}">
                        <td style="width:19%;white-space: nowrap;">
                            <a title="<fmt:message key="label.remove.material"/>" class="tip-top" onclick="deleteRowMtr(this);">
                                <i class="icon-minus" ></i>
                            </a>
                            <select name="itemInfos[${counter}].material.materialID" class="width3">
                                <option value="">-<fmt:message key="label.select"/>-</option>
                                <c:forEach items="${materials}" var="material">
                                    <option value="${material.materialID}">${material.name}</option>
                                </c:forEach>
                            </select>
                        </td>

                        <td style="width:18%;">
                            <input name="itemInfos[${counter}].code" type="text" class="width3 uppercase"/>
                        </td>
                        <td style="width:17%;">
                            <input name="itemInfos[${counter}].quantity" type="text" class="inputNumber width2"/>
                        </td>
                        <td style="width:18%;">
                            <select name="itemInfos[${counter}].origin.originID" class="width3">
                                <option value="">-<fmt:message key="label.select"/>-</option>
                                <c:forEach items="${origins}" var="origin">
                                    <option value="${origin.originID}">${origin.name}</option>
                                </c:forEach>
                            </select>
                        </td>
                        <td style="width:18%;">
                            <div class="input-append date" >
                            <%--<fmt:formatDate var="importedDate" value="${items.pojo.importedDate}" pattern="${datePattern}"/>--%>
                            <input type="text" name="itemInfos[${counter}].expiredDate" id="expiredDate" class="prevent_type text-center width1" type="text"/>
                            <span class="add-on" id="expiredDateIcon"><i class="icon-calendar"></i></span>
                            </div>
                        </td>
                    </tr>
                    </c:if>
                    <c:if test="${not empty importMaterials}">
                        <c:set var="counter" value="${fn:length(importMaterials)}"></c:set>
                        <c:forEach items="${importMaterials}" var="importMaterial" varStatus="status">
                            <tr id="mtr_${status.index}">
                                <td style="width:19%;white-space: nowrap;">
                                    <a title="<fmt:message key="label.remove.material"/>" class="tip-top" onclick="deleteRowMtr(this);">
                                        <i class="icon-minus" ></i>
                                    </a>
                                    <select name="itemInfos[${status.index}].material.materialID" class="width3">
                                        <option value="">-<fmt:message key="label.select"/>-</option>
                                        <c:forEach items="${materials}" var="material">
                                            <option value="${material.materialID}" <c:if test="${material.materialID == importMaterial.material.materialID}">selected</c:if>>${material.name}</option>
                                        </c:forEach>
                                    </select>
                                </td>

                                <td style="width:18%;">
                                    <input name="itemInfos[${status.index}].code" value="${importMaterial.code}" type="text" class="width3 uppercase"/>
                                </td>
                                <td style="width:17%;">
                                    <input name="itemInfos[${status.index}].quantity" value="<fmt:formatNumber value="${importMaterial.quantity}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/>" type="text" class="inputNumber width2"/>
                                </td>
                                <td style="width:18%;">
                                    <select name="itemInfos[${status.index}].origin.originID" class="width3">
                                        <option value="">-<fmt:message key="label.select"/>-</option>
                                        <c:forEach items="${origins}" var="origin">
                                            <option value="${origin.originID}" <c:if test="${origin.originID == importMaterial.origin.originID}">selected</c:if>>${origin.name}</option>
                                        </c:forEach>
                                    </select>
                                </td>
                                <td style="width:18%;">
                                    <div class="input-append date" >
                                            <%--<fmt:formatDate var="importedDate" value="${items.pojo.importedDate}" pattern="${datePattern}"/>--%>
                                        <input type="text" name="itemInfos[${status.index}].expiredDate" id="expiredDate" value="<fmt:formatDate value="${importMaterial.expiredDate}" pattern="dd/MM/yyyy"/>" class="prevent_type text-center width1" type="text"/>
                                        <span class="add-on" id="expiredDateIcon"><i class="icon-calendar"></i></span>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:if>
                </table>
                <c:choose>
                    <c:when test="${empty item.pojo.importMaterialBillID}">
                        <div class="controls">
                            <a onclick="save()" class="btn btn-success btn-green" style="cursor: pointer;">
                                <fmt:message key="button.save"/>
                            </a>
                            <div style="display: inline">
                                <form:hidden path="crudaction" id="crudaction" value="insert-update"/>
                                <form:hidden path="pojo.importMaterialBillID"/>
                                <a href="${backUrl}" class="cancel-link">
                                    <fmt:message key="button.cancel"/>
                                </a>
                            </div>
                        </div>
                    </c:when>
                    <c:when test="${not empty item.pojo.importMaterialBillID}">
                        <table class="tbHskt info">
                            <caption><fmt:message key="label.update"/></caption>
                            <tr>
                                <td style="width:20%;"><fmt:message key="label.note"/></td>
                                <td style="width:80%;"><form:textarea path="pojo.note" cssClass="nohtml nameValidate span11" rows="2"/></td>
                            </tr>
                            <tr>
                                <td class="ctrl-btn" colspan="2">
                                    <c:set var="allowEdit" value="${item.pojo.editable}"/>
                                    <c:if test="${allowEdit}">
                                        <a onclick="save()" class="btn btn-success btn-green" style="cursor: pointer;">
                                            <fmt:message key="button.save"/>
                                        </a>
                                    </c:if>
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
                    </c:when>
                </c:choose>
                <%@include file="../common/tablelog.jsp"%>
            </div>
        </div>
    </div>
</form:form>
<script type="text/javascript">
    var countMtr = ${counter};
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

        var expiredDateVar = $("#expiredDate").datepicker({
            format: 'dd/mm/yyyy',
            onRender: function(date){
            }}).on('changeDate', function(ev) {
                    expiredDateVar.hide();
                }).data('datepicker');
        $('#expiredDateIcon').click(function() {
            $('#expiredDate').focus();
            return true;
        });
    });
    
    

    function addRowMtr(counter){
        var counter = counter;
        countMtr++;
        var id;
        var name = ""
        var row = '<tr id="mtr_'+countMtr+'">'+
                '<td style="width:19%;">'+
                '<a title="<fmt:message key="label.remove.material"/>" class="tip-top" id="addMtr_'+countMtr+'" onclick="deleteRowMtr(this);">'+
                '<i class="icon-minus" ></i>'+
                '</a>'+
                ' <select name="itemInfos['+countMtr+'].material.materialID" id="sl_mtr_'+countMtr+'" class="width3">'+
                '<option value="">-<fmt:message key="label.select"/>-</option>'+
                '<c:forEach items="${materials}" var="material"><option value="${material.materialID}">${material.name}</option></c:forEach>'+
                '</select></td>' +
                '<td style="width:18%;">'+
                '<input name="itemInfos['+countMtr+'].code" type="text" class="width3 uppercase"/>'+
                '</td>'+
                '<td style="width:17%;">'+
                '<input name="itemInfos['+countMtr+'].quantity" type="text" id="quan_'+countMtr+'" class="inputNumber width2"/>'+
                '</td>'+
                '<td style="width:18%;">'+
                '<select name="itemInfos['+countMtr+'].origin.originID" id="sl_org_'+countMtr+'" class="width3">'+
                '<option value="">-<fmt:message key="label.select"/>-</option>'+
                '<c:forEach items="${origins}" var="origin"><option value="${origin.originID}">${origin.name}</option></c:forEach>'+
                '</select></td>' +
                '<td style="width:18%; white-space: nowrap">'+
                '<div class="input-append date" >'+
                '<input type="text" name="itemInfos['+countMtr+'].expiredDate" id="expiredDate'+countMtr+'" class="prevent_type text-center width1" type="text"/>'+
                '<span class="add-on" id="expiredDateIcon'+countMtr+'"><i class="icon-calendar"></i></span>'+
                '</div>'+
                '</td>';
        $("#tbHead").after(row);
        $("#sl_mtr_" + countMtr).select2();
        $("#sl_org_" + countMtr).select2();
        $("#sl_un_" + countMtr).select2();
        $("#quan_" + countMtr).keydown(function(e) {
            handleKeyDown(e);
        }).keyup(function(e) {
                    handleKeyUp(e);
                    if (!ignoreEvent(e)) formatNumberVND($(this));
                });
        var expiredDateVarNew = $("#expiredDate" + countMtr).datepicker({
            format: 'dd/mm/yyyy',
            onRender: function(date){
            }}).on('changeDate', function(ev) {
                    expiredDateVarNew.hide();
                }).data('datepicker');
        $('#expiredDateIcon' + countMtr).click(function() {
            $('#expiredDate' + countMtr).focus();
            return true;
        });
        $('#expiredDate' + countMtr).keydown(function(event){
            if (event.keyCode >= 0){
                event.preventDefault();
            }
        });
        formatNumberVND($("#quan_" + countMtr));
        $("#quan_" + countMtr).keydown(function(e) {
            handleKeyDown(e);
        }).keyup(function(e) {
                    handleKeyUp(e);
                    if (!ignoreEvent(e)) formatNumberVND($(this));
                });
    }
    function deleteRowMtr(Ele){
        var td = $(Ele).parent();
        var trid = $(td).parent().attr("id");
        $("#" + trid).remove();
    }
    function save(){
        $("#crudaction").val("insert-update");
        var hasInputNumber = false;
        $('.inputNumber').each(function(){
            if($(this).val() != '' && $(this).val() != 0 ) {
                hasInputNumber = true;
                $(this).val(numeral().unformat($(this).val()));
            }
        });
        $("#itemForm").submit();
    }
</script>