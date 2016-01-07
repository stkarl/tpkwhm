<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" errorPage="/error.jsp" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@page import="com.banvien.tpk.core.Constants" %>

<head>
    <title><fmt:message key="edit.product.info.title"/></title>
    <meta name="heading" content="<fmt:message key="edit.product.info.title"/>"/>
    <link rel="stylesheet" href="<c:url value='/themes/whm/css/jquery.jscrollpane.css' />" />
    <style>
        .pane_title{
            text-align:center;
        }
    </style>

</head>

<c:url var="url" value="/whm/product/edit.html"/>
<c:url var="backUrl" value="/whm/product/list.html"/>
<form:form commandName="item" action="${url}" method="post" id="itemForm" class="form-horizontal" novalidate="novalidate">
    <div id="container-fluid data_content_box">
        <div class="row-fluid data_content">
            <div class="content-header"><fmt:message key="edit.product.info.title"/></div>
            <div class="clear"></div>
            <div class="alert alert-error" style="display: none;">
                <a onclick="closeAlert();" href="#" style="float: right;font-size: larger;color: #C5B0C2;">&times;</a>
                Hãy nhập đủ thông tin bắt buộc trước khi lưu.
            </div>
            <div class="pane_title">
                <fmt:message key = "product.info.title"/>
            </div>
            <c:if test="${!item.isBlackProduct}">
                <table class="tbInput" style="margin-bottom: -1px;">
                    <tr>
                        <td><fmt:message key="label.product.name"/></td>
                        <td>
                            <select class="width4 requiredField" name="productInfo.productName.productNameID" id="sl_prd_name">
                                <option value="">-<fmt:message key="label.select"/>-</option>
                                <c:forEach items="${productNames}" var="productName">
                                    <option value="${productName.productNameID}" <c:if test="${productName.productNameID == product.productname.productNameID}">selected</c:if>>${productName.name}</option>
                                </c:forEach>
                            </select>
                        </td>
                        <td><fmt:message key="label.used.market"/></td>
                        <td>
                            <select class="width4" name="productInfo.market.marketID">
                                <option value="">-<fmt:message key="label.select"/>-</option>
                                <c:forEach items="${markets}" var="market">
                                    <option value="${market.marketID}" <c:if test="${market.marketID == product.market.marketID}">selected</c:if>>${market.name}</option>
                                </c:forEach>
                            </select>
                        </td>
                        <td><fmt:message key="label.code"/></td>
                        <td>
                            <input name="productInfo.code" value="${product.productCode}" type="text" class="uppercase span11 requiredField productCode"/>
                        </td>
                    </tr>

                    <tr>
                        <td><fmt:message key="label.size"/></td>
                        <td>
                            <select class="width4" name="productInfo.size.sizeID">
                                <option value="">-<fmt:message key="label.select"/>-</option>
                                <c:forEach items="${sizes}" var="size">
                                    <option value="${size.sizeID}" <c:if test="${size.sizeID == product.size.sizeID}">selected</c:if>>${size.name}</option>
                                </c:forEach>
                            </select>
                        </td>
                        <td><fmt:message key="label.thickness"/></td>
                        <td>
                            <select class="width4" name="productInfo.thickness.thicknessID">
                                <option value="">-<fmt:message key="label.select"/>-</option>
                                <c:forEach items="${thicknesses}" var="thickness">
                                    <option value="${thickness.thicknessID}" <c:if test="${thickness.thicknessID == product.thickness.thicknessID}">selected</c:if>>${thickness.name}</option>
                                </c:forEach>
                            </select>
                        </td>
                        <td><fmt:message key="label.quantity.kg"/></td>
                        <td>
                            <input onkeyup="calKgM();" name="productInfo.quantityPure" id="quantityPure" type="text" class="inputNumber span11 weight" value="<fmt:formatNumber value="${product.quantity2Pure}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/>"/>
                        </td>
                    </tr>

                    <tr>
                        <td><fmt:message key="whm.stiffness.name"/></td>
                        <td>
                            <select class="width4" name="productInfo.stiffness.stiffnessID">
                                <option value="">-<fmt:message key="label.select"/>-</option>
                                <c:forEach items="${stiffnesses}" var="stiffness">
                                    <option value="${stiffness.stiffnessID}" <c:if test="${stiffness.stiffnessID == product.stiffness.stiffnessID}">selected</c:if>>${stiffness.name}</option>
                                </c:forEach>
                            </select>
                        </td>
                        <td><fmt:message key="label.colour"/></td>
                        <td>
                            <select class="width4" name="productInfo.colour.colourID">
                                <option value="">-<fmt:message key="label.select"/>-</option>
                                <c:forEach items="${colours}" var="colour">
                                    <option value="${colour.colourID}" <c:if test="${colour.colourID == product.colour.colourID}">selected</c:if>>${colour.name}</option>
                                </c:forEach>
                            </select>
                        </td>
                        <td><fmt:message key="label.core"/></td>
                        <td>
                            <input name="productInfo.core" type="text" class="inputNumber span11" value="${product.core}"/>
                        </td>
                    </tr>
                    <tr>
                        <td><fmt:message key="whm.overlaytype.name"/></td>
                        <td>
                            <select class="width4" name="productInfo.overlayType.overlayTypeID">
                                <option value="">-<fmt:message key="label.select"/>-</option>
                                <c:forEach items="${overlayTypes}" var="overlayType">
                                    <option value="${overlayType.overlayTypeID}" <c:if test="${overlayType.overlayTypeID == product.overlaytype.overlayTypeID}">selected</c:if>>${overlayType.name}</option>
                                </c:forEach>
                            </select>
                        </td>
                        <td colspan="4" style="font-weight: bold;color: red;text-align:center;">
                            Kg/m: <span id="kgm"></span>
                        </td>
                    </tr>
                </table>
                <table class="tbInput">
                    <tr>
                        <c:forEach items="${qualities}" var="quality">
                            <td><fmt:message key="label.rate"/> ${quality.name}</td>
                            <td><input onkeyup="calKgM();" id="quantity_${quality.qualityID}" name="productInfo.qualityQuantityMap[${quality.qualityID}]" type="text" class="inputNumber span11 quality" value="<fmt:formatNumber value="${product.qualityQuantityMap[quality.qualityID]}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/>"/></td>
                        </c:forEach>
                    </tr>
                    <tr>
                        <td><fmt:message key="label.quality.assessment"/></td>
                        <td colspan="${fn:length(qualities) * 2 - 1}">
                            <textarea name="productInfo.note" style="width: 97%;" rows="2">${product.note}</textarea>
                        </td>
                    </tr>
                </table>
            </c:if>
            <c:if test="${item.isBlackProduct}">
                <table class="tbInput">
                    <tr id="tbHead">
                        <th><fmt:message key="label.code"/></th>
                        <th><fmt:message key="label.size"/></th>
                        <th><fmt:message key="label.quantity.pure"/></th>
                        <th><fmt:message key="label.quantity.overall"/></th>
                        <th><fmt:message key="label.quantity.actual"/></th>
                        <th><fmt:message key="label.made.in"/></th>
                    </tr>
                    <tr id="prd">
                        <td class="inputItemInfo2">
                            <input name="productInfo.code" name="productInfo.code" value="${product.productCode}" type="text" class="width3 uppercase"/>
                        </td>
                        <td class="inputItemInfo1">
                            <select name="productInfo.size.sizeID" class="width2">
                                <option value="">-<fmt:message key="label.select"/>-</option>
                                <c:forEach items="${sizes}" var="size">
                                    <option value="${size.sizeID}" <c:if test="${size.sizeID == product.size.sizeID}">selected</c:if>>${size.name}</option>
                                </c:forEach>
                            </select>
                        </td>
                        <td class="inputItemInfo1">
                            <input name="productInfo.quantityPure" value="<fmt:formatNumber value="${product.quantity2Pure}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/>" type="text" class="inputNumber width2"/>
                        </td>
                        <td class="inputItemInfo1">
                            <input name="productInfo.quantityOverall" value="<fmt:formatNumber value="${product.quantity2}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/>" type="text" class="inputNumber width2"/>
                        </td>
                        <td class="inputItemInfo1">
                            <input name="productInfo.quantityActual" value="<fmt:formatNumber value="${product.quantity2Actual}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/>" type="text" class="inputNumber width2"/>
                        </td>
                        <td class="inputItemInfo1">
                            <select name="productInfo.origin.originID" class="width2">
                                <option value="">-<fmt:message key="label.select"/>-</option>
                                <c:forEach items="${origins}" var="origin">
                                    <option value="${origin.originID}" <c:if test="${origin.originID == product.origin.originID}">selected</c:if>>${origin.name}</option>
                                </c:forEach>
                            </select>
                        </td>
                    </tr>
                </table>
            </c:if>
            <div class="clear"></div>
            <div class="controls">
                <a onclick="save()" class="btn btn-success btn-green" style="cursor: pointer;">
                    <fmt:message key="button.save"/>
                </a>
                <div style="display: inline">
                    <form:hidden path="crudaction" id="crudaction" value="insert-update"/>
                    <input type="hidden" value="${product.importProductID}" name="productInfo.itemID"/>
                    <form:hidden path="pojo.importProductBillID"/>
                    <form:hidden path="isBlackProduct"/>
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

        calKgM();
    });

    function calKgM(){
        var kg = $('#quantityPure').val();
        var m = 0;
        $('input[id*="quantity_"]').each(function(){
            if($(this).val() != ''){
                m += numeral().unformat($(this).val());
            }
        });
        if(m != 0 && kg != ''){
            kg = numeral().unformat(kg);
            var kgm = numeral(kg/m).format('###,###.##');
            $('#kgm').text(kgm);
        }
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
        var checkField = checkSPRequiredField();
        if(checkField){
            $("#itemForm").submit();
        }else if(!checkField){
            bootbox.alert("<fmt:message key="label.title.confirm"/>", "<fmt:message key="message.require.field.error"/>",function(){
            });
        }
    }

    function checkSPRequiredField(){
        var checker = true;
        $("input[class*='requiredField']").each(function(){
            var slVal = $("#sl_prd_name option:selected").val();
            if(slVal == null || slVal == '' || slVal < 0){
                checker = false;
                $("#sl_prd_name").focus();
                return checker;
            }

            if($(this).val() == ''){
                checker = false;
                $(this).focus();
                return checker;
            }

        });
        return checker;
    }

</script>