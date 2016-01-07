<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" errorPage="/error.jsp" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@page import="com.banvien.tpk.core.Constants" %>

<head>
    <title><fmt:message key="whm.re.importproduct.title"/></title>
    <meta name="heading" content="<fmt:message key="whm.re.importproduct.title"/>"/>
    <link rel="stylesheet" href="<c:url value='/themes/whm/css/jquery.jscrollpane.css' />" />
</head>

<c:url var="url" value="/whm/importproductbill/reimport.html"/>
<c:url var="backUrl" value="/whm/importproductbill/reimportlist.html"/>
<form:form commandName="item" action="${url}" method="post" id="itemForm" class="form-horizontal" novalidate="novalidate">
    <div id="container-fluid data_content_box">
        <div class="row-fluid data_content">
            <div class="content-header"><fmt:message key="whm.re.importproduct.declare"/></div>
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
                    <td><fmt:message key="label.returner"/> <span id="rq_supplier" class="required">*</span></td>
                    <td colspan="2">
                        <form:select path="pojo.customer.customerID" cssClass="required" cssStyle="width: 360px;">
                            <form:option value=""><fmt:message key="label.select"/></form:option>
                            <c:forEach items="${customers}" var="customer">
                                <form:option value="${customer.customerID}">${customer.name} - {customer.province.name}</form:option>
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
                    <td class="wall"><fmt:message key="return.date"/></td>
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
                    <caption><fmt:message key="import.info.product.base"/></caption>
                    <tr id="tbHead">
                        <th><fmt:message key="label.code"/></th>
                        <th><fmt:message key="label.quantity.kg"/></th>
                        <th><fmt:message key="label.quantity.meter"/></th>
                        <th><fmt:message key="label.note"/></th>
                    </tr>
                    <c:if test="${empty importProducts}">
                        <c:forEach var="counter" begin="1" end="10" step="1" varStatus="status">
                            <tr id="prd_${count}">
                                <td class="inputItemInfo1">
                                    <input name="reImportProducts[${status.index}].code" onblur="validateCode(this);" type="text" class="width3 uppercase originalCode" id="code-${status.index}"/>
                                    <input name="reImportProducts[${status.index}].originalProductId" type="hidden" id="id-${status.index}"/>
                                </td>
                                <td class="inputItemInfo1">
                                    <input name="reImportProducts[${status.index}].kg" id="kg-${status.index}" type="text" class="inputNumber width2"/>
                                </td>
                                <td class="inputItemInfo1">
                                    <input name="reImportProducts[${status.index}].m" type="text" class="inputNumber width2"/>
                                </td>
                                <td>
                                    <textarea rows="2" name="reImportProducts[${status.index}].note" class="span11"></textarea>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:if>
                    <c:if test="${not empty importProducts}">
                        <c:set var="noRow" value="${fn:length(importProducts) < 10 ? 10 - fn:length(importProducts) : 5}"></c:set>
                        <c:set var="count" value="0"/>
                        <c:forEach items="${importProducts}" var="importProduct" varStatus="status">
                            <tr id="prd_${count}">
                                <td class="inputItemInfo1">
                                    <input name="reImportProducts[${count}].code" onblur="validateCode(this);" value="${importProduct.productCode}" type="text" class="width3 uppercase originalCode" id="code-${count}"/>
                                    <input name="reImportProducts[${status.index}].originalProductId" type="hidden" id="id-${count}"/>
                                </td>
                                <td class="inputItemInfo1">
                                    <input name="reImportProducts[${count}].kg" id="kg-${count}" value="<fmt:formatNumber value="${importProduct.quantity2Pure}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/>" type="text" class="inputNumber width2"/>
                                </td>
                                <td class="inputItemInfo1">
                                    <input name="reImportProducts[${count}].m" value="<fmt:formatNumber value="${importProduct.quantity1}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/>" type="text" class="inputNumber width2"/>
                                </td>
                                <td>
                                    <input name="reImportProducts[${count}].quantityActual" value="<fmt:formatNumber value="${importProduct.quantity2Actual}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/>" type="text" class="inputNumber width2"/>
                                </td>
                            </tr>
                            <c:set var="count" value="${count + 1}"/>
                        </c:forEach>
                        <c:forEach var="counter" begin="1" end="${noRow}" step="1" varStatus="status">
                            <tr id="prd_${count}">
                                <td class="inputItemInfo1">
                                    <input name="reImportProducts[${count}].code" onblur="validateCode(this);" type="text" class="width3 uppercase originalCode" id="code-${count}"/>
                                    <input name="reImportProducts[${status.index}].originalProductId" type="hidden" id="id-${count}"/>
                                </td>
                                <td class="inputItemInfo1">
                                    <input name="reImportProducts[${count}].kg" id="kg-${count}" type="text" class="inputNumber width2"/>
                                </td>
                                <td class="inputItemInfo1">
                                    <input name="reImportProducts[${count}].m" type="text" class="inputNumber width2"/>
                                </td>
                                <td>
                                    <textarea rows="2" name="reImportProducts[${count}].note" class="span11"></textarea>
                                </td>
                            </tr>
                            <c:set var="count" value="${count + 1}"/>
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
        var errorCode = "";
        var isValid = true;
        var isErrorKg = false;
        var errorKg = "";
        var hasInputNumber = false;
        $('.inputNumber').each(function(){
            if($(this).val() != '' && $(this).val() != 0 ) {
                hasInputNumber = true;
                $(this).val(numeral().unformat($(this).val()));
            }
        });
        $('.originalCode').each(function(){
            if($(this).val() != '') {
                var count = $(this).attr('id').split('-')[1];
                var id = $("#id-" + count).val();
                if(id == ''){
                    isValid = false;
                    errorCode += " "  + $.trim($(this).val()).toUpperCase();
                }
                var kg = $("#kg-" + count).val();
                if(kg == ''){
                    isErrorKg = true;
                    errorKg += " "  + $.trim($(this).val()).toUpperCase();
                }
            }
        });

        if(!isValid){
            bootbox.alert("<fmt:message key="label.title.confirm"/>", "<fmt:message key="message.product.code.incorrect"/>" + " " + errorCode,function(){});
        }else if(isErrorKg){
            bootbox.alert("<fmt:message key="label.title.confirm"/>", "<fmt:message key="message.product.kg.incorrect"/>" + " " + errorKg,function(){});
        }else{
            $("#itemForm").submit();
        }
    }

    function validateCode(ele){
        var code = $.trim($(ele).val()).toUpperCase();
        var count = $(ele).attr('id').split('-')[1];
        if(code != ''){
            var url = '<c:url value="/ajax/getOriginalProduct.html"/>?code=' + code;
            $.getJSON(url, function(data) {
                if (data.originalID != null){
                    $("#id-" + count).val(data.originalID);
                }else{
                    bootbox.alert("<fmt:message key="label.title.confirm"/>", "<fmt:message key="message.product.code.incorrect"/>" + " " + code,function(){
                    });
                }
            });
        }
    }
</script>