<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" errorPage="/error.jsp" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@page import="com.banvien.tpk.core.Constants" %>

<head>
    <title><fmt:message key="whm.importproduct.material.title"/></title>
    <meta name="heading" content="<fmt:message key="whm.importproduct.material.title"/>"/>
    <link rel="stylesheet" href="<c:url value='/themes/whm/css/jquery.jscrollpane.css' />" />


</head>

<c:url var="url" value="/whm/importrootmaterialbill/edit.html"/>
<c:url var="backUrl" value="/whm/importrootmaterialbill/list.html"/>
<form:form commandName="item" action="${url}" method="post" id="itemForm" class="form-horizontal" novalidate="novalidate">
    <div id="container-fluid data_content_box">
        <div class="row-fluid data_content">
            <div class="content-header"><fmt:message key="whm.importproduct.material.declare"/></div>
            <div class="clear"></div>
            <c:if test="${not empty messageResponse}">
                <div class="alert alert-${alertType}">
                    <button aria-hidden="true" data-dismiss="alert" class="close" type="button">x</button>
                        ${messageResponse}
                </div>
            </c:if>
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
                    <td class="wall">
                        <fmt:message key="label.used.market"/>
                    </td>
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

                <tr class="noprint">
                    <td><fmt:message key="label.temp.bill"/></td>
                    <td colspan="5">
                        <form:checkbox path="pojo.tempBill" id="tempBill"/>
                        <form:errors path="pojo.tempBill" cssClass="error-inline-validate"/>
                    </td>
                </tr>
            </table>
            <div class="row-fluid">
                <c:set var="counter" value="0"></c:set>
                <table class="tbInput">
                    <caption><fmt:message key="import.info.product.material.base"/>
                        <span style="float: right;">
                            <a title="<fmt:message key="label.add"/>" class="tip-top" onclick="addRowMtr('${counter}');">
                                <i class="icon-plus-sign" ></i>
                            </a>
                        </span>
                    </caption>
                    <tr id="tbHead">
                        <th ><fmt:message key="label.code"/></th>
                        <th ><fmt:message key="label.size"/></th>
                        <th ><fmt:message key="label.quantity.pure"/></th>
                        <th ><fmt:message key="label.quantity.overall"/></th>
                        <th ><fmt:message key="label.quantity.actual"/></th>
                        <th ><fmt:message key="label.made.in"/></th>
                    </tr>
                    <c:if test="${empty importProducts}">
                        <tr id="prd_${counter}">
                            <td class="inputItemInfo2">
                                <a title="<fmt:message key="label.remove"/>" class="tip-top" id="addPrd_'+countPrd+'" onclick="deleteRowPrd(this);">
                                    <i class="icon-minus" ></i>
                                </a>
                                <input name="itemInfos[${counter}].code" type="text" class="width3 uppercase"/>
                            </td>
                            <td class="inputItemInfo1">
                                <select name="itemInfos[${counter}].size.sizeID" class="width2">
                                    <option value="">-<fmt:message key="label.select"/>-</option>
                                    <c:forEach items="${sizes}" var="size">
                                        <option value="${size.sizeID}">${size.name}</option>
                                    </c:forEach>
                                </select>
                            </td>
                            <td class="inputItemInfo1">
                                <input name="itemInfos[${counter}].quantityPure" type="text" class="inputNumber width2"/>
                            </td>
                            <td class="inputItemInfo1">
                                <input name="itemInfos[${counter}].quantityOverall" type="text" class="inputNumber width2"/>
                            </td>
                            <td class="inputItemInfo1">
                                <input name="itemInfos[${counter}].quantityActual" type="text" class="inputNumber width2"/>
                            </td>
                            <td class="inputItemInfo1">
                                <select name="itemInfos[${counter}].origin.originID" class="width2">
                                    <option value="">-<fmt:message key="label.select"/>-</option>
                                    <c:forEach items="${origins}" var="origin">
                                        <option value="${origin.originID}">${origin.name}</option>
                                    </c:forEach>
                                </select>
                            </td>
                        </tr>
                    </c:if>
                    <c:if test="${not empty importProducts}">
                        <c:set var="counter" value="${fn:length(importProducts)}"></c:set>
                        <c:forEach items="${importProducts}" var="importProduct" varStatus="status">
                            <tr id="prd_${status.index}">
                                <td class="inputItemInfo2">
                                    <a title="<fmt:message key="label.remove"/>" class="tip-top" onclick="deleteRowPrd(this);">
                                        <i class="icon-minus" ></i>
                                    </a>
                                    <input name="itemInfos[${status.index}].code" value="${importProduct.productCode}" type="text" class="width3 uppercase"/>
                                </td>
                                <td class="inputItemInfo1">
                                    <select name="itemInfos[${status.index}].size.sizeID" class="width2">
                                        <option value="">-<fmt:message key="label.select"/>-</option>
                                        <c:forEach items="${sizes}" var="size">
                                            <option value="${size.sizeID}" <c:if test="${size.sizeID == importProduct.size.sizeID}">selected</c:if>>${size.name}</option>
                                        </c:forEach>
                                    </select>
                                </td>
                                <td class="inputItemInfo1">
                                    <input name="itemInfos[${status.index}].quantityPure" value="<fmt:formatNumber value="${importProduct.quantity2Pure}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/>" type="text" class="inputNumber width2"/>
                                </td>
                                <td class="inputItemInfo1">
                                    <input name="itemInfos[${status.index}].quantityOverall" value="<fmt:formatNumber value="${importProduct.quantity2}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/>" type="text" class="inputNumber width2"/>
                                </td>
                                <td class="inputItemInfo1">
                                    <input name="itemInfos[${status.index}].quantityActual" value="<fmt:formatNumber value="${importProduct.quantity2Actual}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/>" type="text" class="inputNumber width2"/>
                                </td>
                                <td class="inputItemInfo1">
                                    <select name="itemInfos[${status.index}].origin.originID" class="width2">
                                        <option value="">-<fmt:message key="label.select"/>-</option>
                                        <c:forEach items="${origins}" var="origin">
                                            <option value="${origin.originID}" <c:if test="${origin.originID == importProduct.origin.originID}">selected</c:if>>${origin.name}</option>
                                        </c:forEach>
                                    </select>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:if>
                </table>
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
            </div>
            <%@include file="../common/tablelog.jsp"%>
        </div>
    </div>
</form:form>
<script type="text/javascript">
    var countPrd = ${counter};
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

    function addRowMtr(counter){
        var counter = counter;
        countPrd++;
        var id;
        var name = ""
        var row = '<tr id="prd_'+countPrd+'">'+
                '<td class="inputItemInfo2">'+
                '<a title="<fmt:message key="label.remove"/>" class="tip-top" id="addPrd_'+countPrd+'" onclick="deleteRowPrd(this);">'+
                '<i class="icon-minus" ></i>'+
                '</a>'+
                ' <input name="itemInfos['+countPrd+'].code" type="text" class="width3 uppercase"/>'+
                '</td>'+
                '<td class="inputItemInfo1">'+
                '<select name="itemInfos['+countPrd+'].size.sizeID" id="sl_sz_'+countPrd+'" class="width2">'+
                '<option value="">-<fmt:message key="label.select"/>-</option>'+
                '<c:forEach items="${sizes}" var="size"><option value="${size.sizeID}">${size.name}</option></c:forEach>'+
                '</select></td>'+
                '<td class="inputItemInfo1">'+
                '<input name="itemInfos['+countPrd+'].quantityPure" type="text" id="quanPure_'+countPrd+'" class="inputNumber width2"/>'+
                '</td>'+
                '<td class="inputItemInfo1">'+
                '<input name="itemInfos['+countPrd+'].quantityOverall" type="text" id="quanOverall_'+countPrd+'" class="inputNumber width2"/>'+
                '</td>'+
                '<td class="inputItemInfo1">'+
                '<input name="itemInfos['+countPrd+'].quantityActual" type="text" id="quanActual_'+countPrd+'" class="inputNumber width2"/>'+
                '</td>'+
                '<td class="inputItemInfo1">'+
                '<select name="itemInfos['+countPrd+'].origin.originID" id="sl_org_'+countPrd+'" class="width2">'+
                '<option value="">-<fmt:message key="label.select"/>-</option>'+
                '<c:forEach items="${origins}" var="origin"><option value="${origin.originID}">${origin.name}</option></c:forEach>'+
                '</select></td>' +
                '</div>'+
                '</td>';
        $("#tbHead").after(row);
        $("#sl_prd_" + countPrd).select2();
        $("#sl_org_" + countPrd).select2();
        $("#sl_sz_" + countPrd).select2();
        $("#sl_tn_" + countPrd).select2();
        $("#sl_cl_" + countPrd).select2();
        $('.inputNumber').each(function(){
            formatNumberVND($(this));
            $(this).keydown(function(e) {
                handleKeyDown(e);
            }).keyup(function(e) {
                        handleKeyUp(e);
                        if (!ignoreEvent(e)) formatNumberVND($(this));
                    });
        });
    }
    function deleteRowPrd(Ele){
        var td = $(Ele).parent();
        var trid = $(td).parent().attr("id");
        $("#" + trid).remove();
    }
    function save(){
        if($('#tempBill').is(':checked')){
            bootbox.confirm("","<fmt:message key="msg.temp.bill"/>", function(result) {
                if(result){
                    submitBill();
                }
            });
        }else{
            submitBill();
        }
    }

    function submitBill(){
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