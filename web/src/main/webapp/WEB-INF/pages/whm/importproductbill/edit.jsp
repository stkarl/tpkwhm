<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" errorPage="/error.jsp" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@page import="com.banvien.tpk.core.Constants" %>

<head>
    <title><fmt:message key="whm.importproduct.title"/></title>
    <meta name="heading" content="<fmt:message key="whm.importproduct.title"/>"/>
    <link rel="stylesheet" href="<c:url value='/themes/whm/css/jquery.jscrollpane.css' />" />
    <style>
        .pane_title{
            text-align:center;
        }
    </style>

</head>

<c:url var="url" value="/whm/importproductbill/edit.html"/>
<c:url var="backUrl" value="/whm/importproductbill/list.html"/>
<c:if test="${not empty item.pojo.productionPlan}">
    <c:url var="backUrl" value="/whm/importproductbill/byplan.html"/>
</c:if>
<c:if test="${not empty item.pojo.importProductBillID}">
    <c:url var="backUrl" value="/whm/importproductbill/list.html"/>
</c:if>
<form:form commandName="item" action="${url}" method="post" id="itemForm" class="form-horizontal" novalidate="novalidate">
<div id="container-fluid data_content_box">
<div class="row-fluid data_content">
<div class="content-header"><fmt:message key="whm.importproduct.declare"/></div>
<div class="clear"></div>
<c:if test="${not empty messageResponse}">
    <div class="alert alert-${alertType}">
        <button aria-hidden="true" data-dismiss="alert" class="close" type="button">x</button>
            ${messageResponse}
    </div>
</c:if>
<%--<div class="guideline">--%>
    <%--<span>(<span class="required">*</span>): là bắt buộc.</span>--%>
    <%--<div style="clear:both"></div>--%>
<%--</div>--%>
<div class="alert alert-error" style="display: none;">
    <a onclick="closeAlert();" href="#" style="float: right;font-size: larger;color: #C5B0C2;">&times;</a>
    Hãy nhập đủ thông tin bắt buộc trước khi lưu.
</div>
<div id="generalInfor">
    <table class="tbHskt info">
        <caption><fmt:message key="import.material.generalinfo"/></caption>
        <tr>
            <td><fmt:message key="label.number"/>
                <%--<span id="rq_code" class="required">*</span>--%>
            </td>
            <td colspan="2">
                <span>${item.pojo.code}</span>
                <form:hidden path="pojo.code"/>
            </td>
            <c:if test="${not empty item.pojo.productionPlan}">
                <td class="wall"><fmt:message key="whm.productionplan.name"/></td>
                <td colspan="2">${item.pojo.productionPlan.name}</td>
                <form:hidden path="pojo.productionPlan.productionPlanID"/>
            </c:if>
            <c:if test="${empty item.pojo.productionPlan}">
                <td class="wall"><fmt:message key="import.material.supplier"/></td>
                <td colspan="2">
                    <form:select path="pojo.customer.customerID">
                        <form:option value=""><fmt:message key="label.select"/></form:option>
                        <c:forEach items="${customers}" var="customer">
                            <form:option value="${customer.customerID}">${customer.name}-${customer.address}</form:option>
                        </c:forEach>
                    </form:select>
                </td>
            </c:if>
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
</div>
<div class="clear"></div>
<div class="right-btn" id="bt_add_nl">
    <a class="btn btn-info " onclick="addNL();"><i class="icon-plus"></i> <fmt:message key="label.add.root.material"/> </a>
</div>
<div class="clear"></div>
<c:if test="${empty mainUsedMaterials}">
    <c:set var="counterNL" value="0"></c:set>
    <div id="div_nl_${counterNL}" class="pane_info">
        <div class="pane_title">
            <span style="float: left;" >
                            <a id="btn-hide-nl-${counterNL}" title="<fmt:message key="label.hide"/>" class="tip-top" onclick="hideNL('${counterNL}');">
                                <i class="icon-collapse-alt"></i>
                            </a>
                        <a style="display: none;" id="btn-show-nl-${counterNL}" title="<fmt:message key="label.show"/>" class="tip-top" onclick="showNL('${counterNL}');">
                            <i class="icon-expand-alt"></i>
                        </a>
                    </span>
            <fmt:message key = "import.info.product"/>
        <span style="float: right;">
                            <a title="<fmt:message key="label.remove.root.material"/>" class="tip-top" onclick="removeNL('div_nl_${counterNL}');">
                                <i class="icon-trash"></i>
                            </a>
                        </span>
        </div>
        <div class="pane_content" id="div_nl_detail_${counterNL}">
                <%--select main material--%>
            <table class="tbInput" id="table_nl_${counterNL}"  style="text-align: center;">
                <caption><fmt:message key="material.type.info"/></caption>
                <tr>
                    <th style="width: 135px;"><fmt:message key="label.code"/></th>
                    <th style="width: 80px;"><fmt:message key="label.name"/></th>
                    <th style="width: 90px;"><fmt:message key="label.size"/></th>
                    <th style="width: 90px;"><fmt:message key="label.specific"/></th>
                    <th style="width: 90px;"><fmt:message key="label.quantity.kg"/></th>
                    <th style="width: 90px;"><fmt:message key="label.quantity.meter"/></th>
                    <th style="width: 120px;"><fmt:message key="label.cut.off"/></th>
                    <th style="width: 120px;"><fmt:message key="label.import.back.kg"/></th>
                </tr>
                <tr>
                    <td>
                        <select name="mainMaterials[${counterNL}].itemID" class="span11" id="sl_main_material_${counterNL}" onchange="loadDetail(this.value,${counterNL});" oldSelected="">
                            <option value="-1">-<fmt:message key="label.select"/>-</option>
                            <c:forEach items="${products}" var="product">
                                <option value="${product.importProductID}">${product.productCode}</option>
                            </c:forEach>
                        </select>
                    </td>
                    <td id="name_${counterNL}"></td>
                    <td id="size_${counterNL}"></td>
                    <td id="specific_${counterNL}"></td>
                    <td id="kg_${counterNL}"></td>
                    <td class="inputItemInfo0">
                        <span  id="totalMaterial_${counterNL}"></span>
                        <input name="mainMaterials[${counterNL}].totalM" type="hidden" id="totalMaterial_hidden_${counterNL}"/>
                        <input name="mainMaterials[${counterNL}].usedMet" type="hidden" id="usedMetMaterial_hidden_${counterNL}" />
                    </td>
                    <td><input name="mainMaterials[${counterNL}].cutOff" class="inputNumber span11" type="text" id="cutMaterial_${counterNL}"/></td>
                    <td><input name="mainMaterials[${counterNL}].importBack" class="inputNumber span11" type="text" id="importBack_${counterNL}"/></td>
                </tr>
            </table>
            <div class="clear"></div>
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
                    <table class="tbInput" style="margin-bottom: -1px;">
                        <tr>
                            <td><fmt:message key="label.product.name"/></td>
                            <td>
                                <select class="width4 requiredField" sp="${counterSP}" name="mainMaterials[${counterNL}].itemInfos[${counterSP}].productName.productNameID" id="sl_prd_name_${counterSP}">
                                    <option value="">-<fmt:message key="label.select"/>-</option>
                                    <c:forEach items="${productNames}" var="productName">
                                        <option value="${productName.productNameID}" code="${productName.code}">${productName.name}</option>
                                    </c:forEach>
                                </select>
                            </td>
                            <td><fmt:message key="label.used.market"/></td>
                            <td>
                                <select class="width4" name="mainMaterials[${counterNL}].itemInfos[${counterSP}].market.marketID">
                                    <option value="">-<fmt:message key="label.select"/>-</option>
                                    <c:forEach items="${markets}" var="market">
                                        <option value="${market.marketID}">${market.name}</option>
                                    </c:forEach>
                                </select>
                            </td>
                            <td><fmt:message key="label.code"/></td>
                            <td>
                                <input name="mainMaterials[${counterNL}].itemInfos[${counterSP}].code" type="text" class="uppercase span11 requiredField productCode" sp="${counterSP}"/>
                            </td>
                        </tr>

                        <tr>
                            <td><fmt:message key="label.size"/></td>
                            <td>
                                <select class="width4" name="mainMaterials[${counterNL}].itemInfos[${counterSP}].size.sizeID">
                                    <option value="">-<fmt:message key="label.select"/>-</option>
                                    <c:forEach items="${sizes}" var="size">
                                        <option value="${size.sizeID}">${size.name}</option>
                                    </c:forEach>
                                </select>
                            </td>
                            <td><fmt:message key="label.thickness"/></td>
                            <td>
                                <select class="width4" name="mainMaterials[${counterNL}].itemInfos[${counterSP}].thickness.thicknessID">
                                    <option value="">-<fmt:message key="label.select"/>-</option>
                                    <c:forEach items="${thicknesses}" var="thickness">
                                        <option value="${thickness.thicknessID}">${thickness.name}</option>
                                    </c:forEach>
                                </select>
                            </td>
                            <td><fmt:message key="label.quantity.kg"/></td>
                            <td>
                                <input onkeyup="calKgM('${counterSP}');" name="mainMaterials[${counterNL}].itemInfos[${counterSP}].quantityPure" id="quantityPure-${counterSP}" type="text" class="inputNumber span11 weight-${counterNL}"/>
                            </td>
                        </tr>

                        <tr>
                            <td><fmt:message key="whm.stiffness.name"/></td>
                            <td>
                                <select class="width4" name="mainMaterials[${counterNL}].itemInfos[${counterSP}].stiffness.stiffnessID">
                                    <option value="">-<fmt:message key="label.select"/>-</option>
                                    <c:forEach items="${stiffnesses}" var="stiffness">
                                        <option value="${stiffness.stiffnessID}">${stiffness.name}</option>
                                    </c:forEach>
                                </select>
                            </td>
                            <td><fmt:message key="label.colour"/></td>
                            <td>
                                <select class="width4" name="mainMaterials[${counterNL}].itemInfos[${counterSP}].colour.colourID">
                                    <option value="">-<fmt:message key="label.select"/>-</option>
                                    <c:forEach items="${colours}" var="colour">
                                        <option value="${colour.colourID}">${colour.name}</option>
                                    </c:forEach>
                                </select>
                            </td>
                            <td><fmt:message key="label.core"/></td>
                            <td>
                                <input name="mainMaterials[${counterNL}].itemInfos[${counterSP}].core" type="text" class="inputNumber span11"/>
                            </td>
                        </tr>
                        <tr>
                            <td><fmt:message key="whm.overlaytype.name"/></td>
                            <td>
                                <select class="width4" name="mainMaterials[${counterNL}].itemInfos[${counterSP}].overlayType.overlayTypeID">
                                    <option value="">-<fmt:message key="label.select"/>-</option>
                                    <c:forEach items="${overlayTypes}" var="overlayType">
                                        <option value="${overlayType.overlayTypeID}">${overlayType.name}</option>
                                    </c:forEach>
                                </select>
                            </td>
                            <td colspan="4" style="font-weight: bold;color: red;text-align:center;">
                                Kg/m: <span id="kgm-${counterSP}"></span>
                            </td>
                        </tr>
                            <%--<tr>--%>
                            <%--<td><fmt:message key="label.quality.assessment"/></td>--%>
                            <%--<td colspan="4">--%>
                            <%--<input name="mainMaterials[${counterNL}].itemInfos[${counterSP}].note" type="text" style="width: 97%;"/>--%>
                            <%--</td>--%>
                            <%--<td></td>--%>
                            <%--</tr>--%>
                    </table>
                    <table class="tbInput">
                        <tr>
                            <c:forEach items="${qualities}" var="quality">
                                <td><fmt:message key="label.rate"/> ${quality.name}</td>
                                <td><input spq="${counterSP}" onkeyup="calKgM('${counterSP}');" id="quantity_${quality.qualityID}_${counterNL}_${counterSP}" name="mainMaterials[${counterNL}].itemInfos[${counterSP}].qualityQuantityMap[${quality.qualityID}]" type="text" class="inputNumber span11 quality-${counterNL}"/></td>
                            </c:forEach>
                        </tr>
                        <tr>
                            <td><fmt:message key="label.quality.assessment"/></td>
                            <td colspan="${fn:length(qualities) * 2 - 1}">
                                <textarea name="mainMaterials[${counterNL}].itemInfos[${counterSP}].note" style="width: 97%;" rows="2"></textarea>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </div>
</c:if>
<c:if test="${not empty mainUsedMaterials}">
<c:set var="counterNL" value="${fn:length(mainUsedMaterials)}"></c:set>
<c:set var="counterSP" value="0"></c:set>
<c:forEach items="${mainUsedMaterials}" var="mainUsedMaterial" varStatus="status">
<div id="div_nl_${status.index}" class="pane_info">
    <div class="pane_title">
                           <span style="float: left;" >
                            <a id="btn-hide-nl-${status.index}" title="<fmt:message key="label.hide"/>" class="tip-top" onclick="hideNL('${status.index}');">
                                <i class="icon-collapse-alt"></i>
                            </a>
                        <a style="display: none;" id="btn-show-nl-${status.index}" title="<fmt:message key="label.show"/>" class="tip-top" onclick="showNL('${status.index}');">
                            <i class="icon-expand-alt"></i>
                        </a>
                    </span>
        <fmt:message key = "import.info.product"/>
                    <span style="float: right;">
                            <a title="<fmt:message key="label.remove.root.material"/>" class="tip-top" onclick="removeNL('div_nl_${status.index}');">
                                <i class="icon-trash"></i>
                            </a>
                        </span>
    </div>
    <div class="pane_content" id="div_nl_detail_${status.index}">
            <%--select main material--%>
        <table class="tbInput" id="table_nl_${status.index}" style="text-align: center;">
            <caption><fmt:message key="material.type.info"/></caption>
            <tr>
                <th style="width: 135px;"><fmt:message key="label.code"/></th>
                <th style="width: 80px;"><fmt:message key="label.name"/></th>
                <th style="width: 90px;"><fmt:message key="label.size"/></th>
                <th style="width: 90px;"><fmt:message key="label.specific"/></th>
                <th style="width: 90px;"><fmt:message key="label.quantity.kg"/></th>
                <th style="width: 90px;"><fmt:message key="label.quantity.meter"/></th>
                <th style="width: 120px;"><fmt:message key="label.cut.off"/></th>
                <th style="width: 120px;"><fmt:message key="label.import.back.kg"/></th>
            </tr>
            <tr>
                <td>
                    <select name="mainMaterials[${status.index}].itemID" class="span11" id="sl_main_material_${status.index}" onchange="loadDetail(this.value,${status.index});" oldSelected="">
                        <option value="-1">-<fmt:message key="label.select"/>-</option>
                        <c:forEach items="${products}" var="product">
                            <option value="${product.importProductID}" <c:if test="${product.importProductID == mainUsedMaterial.itemID}">selected</c:if>>${product.productCode}</option>
                        </c:forEach>
                    </select>
                </td>
                <td id="name_${status.index}">${mainUsedMaterial.mainMaterialName}</td>
                <td id="size_${status.index}">${mainUsedMaterial.mainMaterialSize}</td>
                <td id="specific_${status.index}">${mainUsedMaterial.mainMaterialSpecific}</td>
                <td id="kg_${status.index}"><fmt:formatNumber value="${mainUsedMaterial.totalKg}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/></td>
                <td class="inputItemInfo0">
                            <span id="totalMaterial_${status.index}">
                                <fmt:formatNumber value="${mainUsedMaterial.totalM}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/>
                            </span>
                    <input id="totalMaterial_hidden_${status.index}" name="mainMaterials[${status.index}].totalM" type="hidden"/>
                    <input id="usedMetMaterial_hidden_${status.index}" name="mainMaterials[${status.index}].usedMet" type="hidden"/>

                </td>
                <td><input id="cutMaterial_${status.index}" name="mainMaterials[${status.index}].cutOff" class="inputNumber span11" type="text" value="<fmt:formatNumber value="${mainUsedMaterial.cutOff}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/>"/></td>
                <td><input id="importBack_${status.index}" name="mainMaterials[${status.index}].importBack" class="inputNumber span11" type="text" value="<fmt:formatNumber value="${mainUsedMaterial.importBack}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/>"/></td>
                <input type="hidden" value="${mainUsedMaterial.itemID}" id="selectedProduct_${status.index}"/>
            </tr>
        </table>
        <div class="clear"></div>
        <div id="bt_add_sp_${status.index}" class="right-btn">
            <a class="btn btn-info " onclick="addSP('${status.index}');"><i class="icon-plus"></i> <fmt:message key="label.add.product"/> </a>
        </div>
        <div class="clear"></div>
        <c:forEach items="${mainUsedMaterial.importproducts}" var="product" varStatus="counter">
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
                    <table class="tbInput" style="margin-bottom: -1px;">
                        <tr>
                            <td><fmt:message key="label.product.name"/></td>
                            <td>
                                <select class="width4 requiredField" sp="${counterSP}" name="mainMaterials[${status.index}].itemInfos[${counterSP}].productName.productNameID" id="sl_prd_name_${counterSP}">
                                    <option value="">-<fmt:message key="label.select"/>-</option>
                                    <c:forEach items="${productNames}" var="productName">
                                        <option value="${productName.productNameID}" code="${productName.code}" <c:if test="${productName.productNameID == product.productname.productNameID}">selected</c:if>>${productName.name}</option>
                                    </c:forEach>
                                </select>
                            </td>
                            <td><fmt:message key="label.used.market"/></td>
                            <td>
                                <select class="width4" name="mainMaterials[${status.index}].itemInfos[${counterSP}].market.marketID">
                                    <option value="">-<fmt:message key="label.select"/>-</option>
                                    <c:forEach items="${markets}" var="market">
                                        <option value="${market.marketID}" <c:if test="${market.marketID == product.market.marketID}">selected</c:if>>${market.name}</option>
                                    </c:forEach>
                                </select>
                            </td>
                            <td><fmt:message key="label.code"/></td>
                            <td>
                                <input name="mainMaterials[${status.index}].itemInfos[${counterSP}].code" value="${product.productCode}" type="text" class="uppercase span11 requiredField productCode" sp="${counterSP}"/>
                            </td>
                        </tr>

                        <tr>
                            <td><fmt:message key="label.size"/></td>
                            <td>
                                <select class="width4" name="mainMaterials[${status.index}].itemInfos[${counterSP}].size.sizeID">
                                    <option value="">-<fmt:message key="label.select"/>-</option>
                                    <c:forEach items="${sizes}" var="size">
                                        <option value="${size.sizeID}" <c:if test="${size.sizeID == product.size.sizeID}">selected</c:if>>${size.name}</option>
                                    </c:forEach>
                                </select>
                            </td>
                            <td><fmt:message key="label.thickness"/></td>
                            <td>
                                <select class="width4" name="mainMaterials[${status.index}].itemInfos[${counterSP}].thickness.thicknessID">
                                    <option value="">-<fmt:message key="label.select"/>-</option>
                                    <c:forEach items="${thicknesses}" var="thickness">
                                        <option value="${thickness.thicknessID}" <c:if test="${thickness.thicknessID == product.thickness.thicknessID}">selected</c:if>>${thickness.name}</option>
                                    </c:forEach>
                                </select>
                            </td>
                            <td><fmt:message key="label.quantity.kg"/></td>
                            <td>
                                <input onkeyup="calKgM('${counterSP}');" name="mainMaterials[${status.index}].itemInfos[${counterSP}].quantityPure" id="quantityPure-${counterSP}" type="text" class="inputNumber span11 weight-${status.index}" value="<fmt:formatNumber value="${product.quantity2Pure}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/>"/>
                            </td>
                        </tr>

                        <tr>
                            <td><fmt:message key="whm.stiffness.name"/></td>
                            <td>
                                <select class="width4" name="mainMaterials[${status.index}].itemInfos[${counterSP}].stiffness.stiffnessID">
                                    <option value="">-<fmt:message key="label.select"/>-</option>
                                    <c:forEach items="${stiffnesses}" var="stiffness">
                                        <option value="${stiffness.stiffnessID}" <c:if test="${stiffness.stiffnessID == product.stiffness.stiffnessID}">selected</c:if>>${stiffness.name}</option>
                                    </c:forEach>
                                </select>
                            </td>
                            <td><fmt:message key="label.colour"/></td>
                            <td>
                                <select class="width4" name="mainMaterials[${status.index}].itemInfos[${counterSP}].colour.colourID">
                                    <option value="">-<fmt:message key="label.select"/>-</option>
                                    <c:forEach items="${colours}" var="colour">
                                        <option value="${colour.colourID}" <c:if test="${colour.colourID == product.colour.colourID}">selected</c:if>>${colour.name}</option>
                                    </c:forEach>
                                </select>
                            </td>
                            <td><fmt:message key="label.core"/></td>
                            <td>
                                <input name="mainMaterials[${status.index}].itemInfos[${counterSP}].core" type="text" class="inputNumber span11" value="${product.core}"/>
                            </td>
                        </tr>
                        <tr>
                            <td><fmt:message key="whm.overlaytype.name"/></td>
                            <td>
                                <select class="width4" name="mainMaterials[${status.index}].itemInfos[${counterSP}].overlayType.overlayTypeID">
                                    <option value="">-<fmt:message key="label.select"/>-</option>
                                    <c:forEach items="${overlayTypes}" var="overlayType">
                                        <option value="${overlayType.overlayTypeID}" <c:if test="${overlayType.overlayTypeID == product.overlaytype.overlayTypeID}">selected</c:if>>${overlayType.name}</option>
                                    </c:forEach>
                                </select>
                            </td>
                            <td colspan="4" style="font-weight: bold;color: red;text-align:center;">
                                Kg/m: <span id="kgm-${counterSP}"></span>
                            </td>
                        </tr>
                            <%--<tr>--%>
                            <%--<td><fmt:message key="label.quality.assessment"/></td>--%>
                            <%--<td colspan="4">--%>
                            <%--<input name="mainMaterials[${status.index}].itemInfos[${counterSP}].note" type="text" style="width: 97%;" value="${product.note}"/>--%>
                            <%--</td>--%>
                            <%--<td></td>--%>
                            <%--</tr>--%>
                    </table>
                    <table class="tbInput">
                        <tr>
                            <c:forEach items="${qualities}" var="quality">
                                <td><fmt:message key="label.rate"/> ${quality.name}</td>
                                <td><input spq="${counterSP}" onkeyup="calKgM('${counterSP}');" id="quantity_${quality.qualityID}_${status.index}_${counterSP}" name="mainMaterials[${status.index}].itemInfos[${counterSP}].qualityQuantityMap[${quality.qualityID}]" type="text" class="inputNumber span11 quality-${status.index}" value="<fmt:formatNumber value="${product.qualityQuantityMap[quality.qualityID]}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/>"/></td>
                            </c:forEach>
                        </tr>
                        <tr>
                            <td><fmt:message key="label.quality.assessment"/></td>
                            <td colspan="${fn:length(qualities) * 2 - 1}">
                                <textarea name="mainMaterials[${status.index}].itemInfos[${counterSP}].note" style="width: 97%;" rows="2">${product.note}</textarea>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <div class="clear"></div>
            <c:set var="counterSP" value="${1 + counterSP}"></c:set>
        </c:forEach>
    </div>
</div>
<div class="clear"></div>

</c:forEach>
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
        <form:hidden path="pojo.importProductBillID" id="billID"/>
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
var qualityLength = ${fn:length(qualities) * 2 - 1};
var listMainMaterialSelected = [];

$(document).ready(function(){
    pushSelectedProduct();
    if(countSP > 0){
        for(var i = 0; i <= countSP; i++){
            calKgM(i);
        }
    }
});

function pushSelectedProduct(){
    for(var i = 0;i < countNL;i++){
        var selectedBPId = $('#selectedProduct_' + i).val();
        listMainMaterialSelected.push({importProductID : selectedBPId});
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

    if(checkSPRequiredField()){
        var checkProductNameCode = true;
        var productCode,nameCode;
        var errorNameCode = "";
        $('.productCode').each(function(){
            if($(this).attr('sp') != undefined){
                var counterSP = $(this).attr('sp');
                nameCode = $("#sl_prd_name_" + counterSP + " option:selected").attr('code');
                productCode = $(this).val().toUpperCase();
                if(!checkNameCode(nameCode,productCode)){
                    errorNameCode += $("#sl_prd_name_" + counterSP + " option:selected").text() + ":" + productCode + " ";
                    checkProductNameCode = false;
                }
            }
        });
        if(!checkProductNameCode){
            var msg = '<fmt:message key="message.name.code.error.pre"/>' + ': ' + errorNameCode + '. ' + '<fmt:message key="message.name.code.error.post"/>';
            bootbox.confirm('<fmt:message key="label.title.confirm"/>', msg, function(r) {
                if(r){
                    checkBeforeSubmit();
                }
            });
        }else{
            checkBeforeSubmit();
        }
    }else{
        bootbox.alert("<fmt:message key="label.title.confirm"/>", "<fmt:message key="message.require.field.error"/>",function(){
        });
    }
}

function checkBeforeSubmit(){
    var checkSumLength = true;
    var errorLength = "";
    var checkSumWeight = true;
    var errorWeight = "";
    for(var i = 0; i <= countNL; i++){
        var totalWeight = 0;
        var totalMaterialWeight = $.trim($("#kg_" + i).html());
        $(".weight-" + i).each(function(){
            if($(this).val() != undefined && $(this).val() != ""){
                totalWeight += numeral().unformat($(this).val());
            }
        });
        if($("#cutMaterial_" +i).val() != undefined && $("#cutMaterial_" +i).val() != ""){
            totalWeight += numeral().unformat($("#cutMaterial_" +i).val());
        }
        var importBack = 0;
        if($("#importBack_" +i).val() != undefined && $("#importBack_" +i).val() != ""){
            importBack = numeral().unformat($("#importBack_" +i).val());
            totalWeight += importBack;
        }
        if(totalMaterialWeight != undefined && totalMaterialWeight != ""){
            if(numeral().unformat(totalMaterialWeight) - 30 >= totalWeight || numeral().unformat(totalMaterialWeight) <= importBack){   // -30 sai so cho phep
                checkSumWeight = false;
                errorWeight += $("#sl_main_material_" + i + " option:selected").text()  + " ";
            }
        }

        var total = 0;
        var totalMaterial = $.trim($("#totalMaterial_" + i).text());
        $(".quality-" + i).each(function(){
            if($(this).val() != undefined && $(this).val() != ""){
                total += numeral().unformat($(this).val());
            }
        });
        if(totalMaterial != undefined && totalMaterial != ""){
            if(numeral().unformat(totalMaterial) + 999 < total){  // 999 sai so cho phep
                checkSumLength = false;
                errorLength += $("#sl_main_material_" + i + " option:selected").text() + " ";
            }
        }
        if(importBack > 0){
            $("#usedMetMaterial_hidden_" + i).val(total);
        }else{
            $("#totalMaterial_hidden_" + i).val(total);
        }
    }
    if(checkSumLength && checkSumWeight){
        if($('#billID').val() != ''){
            $("#itemForm").submit();
        }else{
            checkProductCodeAndSubmit();
        }
    }else if(!checkSumLength){
        bootbox.alert("<fmt:message key="label.title.confirm"/>", "<fmt:message key="message.total.length.error"/>: " + errorLength,function(){
        });
    }else if(!checkSumWeight){
        bootbox.alert("<fmt:message key="label.title.confirm"/>", "<fmt:message key="message.total.weight.error"/>: " + errorWeight,function(){
        });
    }
}

function checkNameCode(nameCode,productCode){
    var checker = true;
    var fCode = productCode.substr(0,1);
    var tCode = productCode.substr(2,1);
    if( fCode == 'A' && nameCode != '${Constants.PRODUCT_LANH}'){
        checker = false;
    }else if(fCode == 'Z' && nameCode != '${Constants.PRODUCT_KEM}'){
        checker = false;
    }else if(tCode == 'Z' && nameCode != '${Constants.PRODUCT_KEM_MAU}'){
        checker = false;
    }else if(tCode == 'A' && nameCode != '${Constants.PRODUCT_LANH_MAU}'){
        checker = false;
    }else if(tCode == 'C' && nameCode != '${Constants.PRODUCT_DEN_MAU}'){
        checker = false;
    }
    return checker;
}


function checkProductCodeAndSubmit(){
    var errorCode;
    var codes = [];
    $('.productCode').each(function(index,value){
        codes[index] = $(this).val();
    });
    $.ajax({
        url: "<c:url value="/ajax/importproductbill/checkCodes.html"/>",
        data: {codes: codes},
        type: "GET",
        cache: false,
        dataType: 'json',
        traditional: true,
        success: function(data){
            errorCode = data.codeInfo;
            if(errorCode != ""){
                bootbox.alert("<fmt:message key="label.title.confirm"/>", "<fmt:message key="message.product.code.error"/>: " + errorCode,function(){
                });
            }else{
                $("#itemForm").submit();
            }
        }
    });
}

function loadDetail(id,counter){
    var oldSelectedId = $("#sl_main_material_" + counter).attr("oldSelected");
    if(oldSelectedId != null && oldSelectedId != ''){
        listMainMaterialSelected = $.grep(listMainMaterialSelected,
                function(o,i) { return o.importProductID === oldSelectedId; },true);
    }
    if(id < 0){
        $("#sl_main_material_" + counter).select2("val","");
        $("#name_" + counter).html("");
        $("#size_" + counter).html("");
        $("#specific_" + counter).html("");
        $("#kg_" + counter).html("");
        $("#totalMaterial_" + counter).text("");
        $("#cutMaterial_" + counter).html("");
        $("#importBack_" + counter).html("");
    }
    else if(!isSelectedItem(id)){
        var url = '<c:url value="/ajax/getAvailableBlackProduct.html"/>?importProductID=' + id;
        $.getJSON(url, function(data) {
            if (data.name != null){
                var met = '';
                var cutOff = '';
                var importBack = '';
                var kg = '';


                if(data.met != null){
                    met = numeral(data.met).format('###,###');
                }
                if(data.cutOff != null){
                    cutOff = numeral(data.cutOff).format('###,###');
                }
                if(data.importBack != null){
                    importBack = numeral(data.importBack).format('###,###');
                }
                if(data.kg != null){
                    kg = numeral(data.kg).format('###,###');
                }
                $("#name_" + counter).html(data.name);
                $("#size_" + counter).html(data.size);
                $("#specific_" + counter).html(data.origin);
                $("#kg_" + counter).html(kg);
                $("#totalMaterial_" + counter).text(met);
                $("#cutMaterial_" + counter).html(cutOff);
                $("#importBack_" + counter).html(importBack);
                listMainMaterialSelected.push({importProductID : id});
                $("#sl_main_material_" + counter).attr("oldSelected",id);

            }
        });
    }else{
        bootbox.alert("<fmt:message key="label.title.confirm"/>", "<fmt:message key="message.selected.product"/>",function(){
            $("#sl_main_material_" + counter).select2("val","");
            $("#name_" + counter).html("");
            $("#size_" + counter).html("");
            $("#specific_" + counter).html("");
            $("#kg_" + counter).html("");
            $("#totalMaterial_" + counter).text("");
            $("#cutMaterial_" + counter).html("");
            $("#importBack_" + counter).html("");
        });
    }
}
function isSelectedItem(selectedItem){
    if(selectedItem != null && selectedItem > 0){
        for(var i = 0; i < listMainMaterialSelected.length;i++){
            if(selectedItem==listMainMaterialSelected[i].importProductID){
                return true;
            }
        }
    }
    return false;
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
            '<table class="tbInput" style="margin-bottom: -1px;">'+
            '<tr>'+
            '<td><fmt:message key="label.product.name"/></td>'+
            '<td>'+
            '<select class="width4 requiredField" sp="'+countSP+'" name="mainMaterials['+noNL+'].itemInfos['+countSP+'].productName.productNameID" id="sl_prd_name_'+countSP+'">'+
            '<option value="">-<fmt:message key="label.select"/>-</option>'+
            '<c:forEach items="${productNames}" var="productName">'+
            '<option value="${productName.productNameID}" code="${productName.code}">${productName.name}</option>'+
            '</c:forEach>'+
            '</select>'+
            '</td>'+
            '<td><fmt:message key="label.used.market"/></td>'+
            '<td>'+
            '<select class="width4" name="mainMaterials['+noNL+'].itemInfos['+countSP+'].market.marketID" id="sl_market_'+countSP+'">'+
            '<option value="">-<fmt:message key="label.select"/>-</option>'+
            '<c:forEach items="${markets}" var="market">'+
            '<option value="${market.marketID}">${market.name}</option>'+
            '</c:forEach>'+
            '</select>'+
            '</td>'+
            '<td><fmt:message key="label.code"/></td>'+
            '<td>'+
            '<input name="mainMaterials['+noNL+'].itemInfos['+countSP+'].code" type="text" class="uppercase span11 requiredField productCode"  sp="'+countSP+'"/>'+
            '</td>'+
            '</tr>'+
            '<tr>'+
            '<td><fmt:message key="label.size"/></td>'+
            '<td>'+
            '<select class="width4" name="mainMaterials['+noNL+'].itemInfos['+countSP+'].size.sizeID" id="sl_size_'+countSP+'">'+
            '<option value="">-<fmt:message key="label.select"/>-</option>'+
            '<c:forEach items="${sizes}" var="size">'+
            '<option value="${size.sizeID}">${size.name}</option>'+
            '</c:forEach>'+
            '</select>'+
            '</td>'+
            '<td><fmt:message key="label.thickness"/></td>'+
            '<td>'+
            '<select class="width4" name="mainMaterials['+noNL+'].itemInfos['+countSP+'].thickness.thicknessID" id="sl_thickness_'+countSP+'">'+
            '<option value="">-<fmt:message key="label.select"/>-</option>'+
            '<c:forEach items="${thicknesses}" var="thickness">'+
            '<option value="${thickness.thicknessID}">${thickness.name}</option>'+
            '</c:forEach>'+
            '</select>'+
            '</td>'+
            '<td><fmt:message key="label.quantity.kg"/></td>'+
            '<td>'+
            '<input name="mainMaterials['+noNL+'].itemInfos['+countSP+'].quantityPure" id="quantityPure-'+countSP+'" type="text" class="inputNumber span11 weight-'+noNL+'" onkeyup="calKgM(\''+countSP+'\');"/>'+
            '</td>'+
            '</tr>'+
            '<tr>'+
            '<td><fmt:message key="whm.stiffness.name"/></td>'+
            '<td>'+
            '<select class="width4" name="mainMaterials['+noNL+'].itemInfos['+countSP+'].stiffness.stiffnessID" id="sl_stiffness_'+countSP+'">'+
            '<option value="">-<fmt:message key="label.select"/>-</option>'+
            '<c:forEach items="${stiffnesses}" var="stiffness">'+
            '<option value="${stiffness.stiffnessID}">${stiffness.name}</option>'+
            '</c:forEach>'+
            '</select>'+
            '</td>'+
            '<td><fmt:message key="label.colour"/></td>'+
            '<td>'+
            '<select class="width4" name="mainMaterials['+noNL+'].itemInfos['+countSP+'].colour.colourID" id="sl_colour_'+countSP+'">'+
            '<option value="">-<fmt:message key="label.select"/>-</option>'+
            '<c:forEach items="${colours}" var="colour">'+
            '<option value="${colour.colourID}">${colour.name}</option>'+
            '</c:forEach>'+
            '</select>'+
            '</td>'+
            '<td><fmt:message key="label.core"/></td>'+
            '<td>'+
            '<input name="mainMaterials['+noNL+'].itemInfos['+countSP+'].core" type="text" class="inputNumber span11"/>'+
            '</td>'+
            '</tr>'+
            '<tr>'+
            '<td><fmt:message key="whm.overlaytype.name"/></td>'+
            '<td>'+
            '<select class="width4" name="mainMaterials['+noNL+'].itemInfos['+countSP+'].overlayType.overlayTypeID" id="sl_overlay_'+countSP+'">'+
            '<option value="">-<fmt:message key="label.select"/>-</option>'+
            '<c:forEach items="${overlayTypes}" var="overlayType">'+
            '<option value="${overlayType.overlayTypeID}">${overlayType.name}</option>'+
            '</c:forEach>'+
            '</select>'+
            '</td>'+
            '<td colspan="4" style="font-weight: bold;color: red;text-align:center;">' +
            'Kg/m: <span id="kgm-'+countSP+'"></span>'+
            '</td>'+
            '</tr>'+
            <%--'<tr>'+--%>
            <%--'<td><fmt:message key="label.quality.assessment"/></td>'+--%>
            <%--'<td colspan="4">'+--%>
            <%--'<input name="mainMaterials['+noNL+'].itemInfos['+countSP+'].note" type="text" style="width: 97%;"/>'+--%>
            <%--'</td>'+--%>
            <%--'<td></td>'+--%>
            <%--'</tr>'+--%>
            '</table>'+
            '<table class="tbInput">'+
            '<tr>'+
            '<c:forEach items="${qualities}" var="quality">'+
            '<td><fmt:message key="label.rate"/> ${quality.name}</td>'+
            '<td><input name="mainMaterials['+noNL+'].itemInfos['+countSP+'].qualityQuantityMap[${quality.qualityID}]" type="text" class="inputNumber span11 quality-'+noNL+'" onkeyup="calKgM(\''+countSP+'\');" id="quantity_${quality.qualityID}_'+noNL+'_'+countSP+'" spq="'+countSP+'"/></td>'+
            '</c:forEach>'+
            '</tr>'+
            '<tr>'+
            '<td><fmt:message key="label.quality.assessment"/></td>'+
            '<td colspan="'+qualityLength+'">'+
            '<textarea name="mainMaterials['+noNL+'].itemInfos['+countSP+'].note" style="width: 97%;" rows="2"></textarea>'+
            '</td>'+
            '</tr>'+
            '</table>'+
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
function addNL(){
    countSP++;
    countNL++;
    var nl ='<div class="clear"></div>'+
            '<div id="div_nl_'+countNL+'" class="pane_info">'+
            '<div class="pane_title">'+
            '<span style="float: left;" >'+
            '<a id="btn-hide-nl-'+countNL+'" title="<fmt:message key="label.hide"/>" class="tip-top" onclick="hideNL(\''+countNL+'\');">'+
            '<i class="icon-collapse-alt"></i>'+
            '</a>'+
            '<a style="display: none;" id="btn-show-nl-'+countNL+'" title="<fmt:message key="label.show"/>" class="tip-top" onclick="showNL(\''+countNL+'\');">'+
            '<i class="icon-expand-alt"></i>'+
            '</a>'+
            '</span>'+
            '<fmt:message key = "import.info.product"/>'+
            '<span style="float: right;">'+
            '<a title="<fmt:message key="label.remove.root.material"/>" class="tip-top" onclick="removeNL(div_nl_'+countNL+');">'+
            '<i class="icon-trash"></i>'+
            '</a>'+
            '</span>'+
            '</div>'+
            '<div class="pane_content" id="div_nl_detail_'+countNL+'">'+
            '<table class="tbInput" id="table_nl_'+countNL+'">'+
            '<caption><fmt:message key="material.type.info"/></caption>'+
            '<tr>'+
            '<th style="width: 135px;"><fmt:message key="label.code"/></th>'+
            '<th style="width: 80px;"><fmt:message key="label.name"/></th>'+
            '<th style="width: 90px;"><fmt:message key="label.size"/></th>'+
            '<th style="width: 90px;"><fmt:message key="label.specific"/></th>'+
            '<th style="width: 90px;"><fmt:message key="label.quantity.kg"/></th>'+
            '<th style="width: 90px;"><fmt:message key="label.quantity.meter"/></th>'+
            '<th style="width: 120px;"><fmt:message key="label.cut.off"/></th>'+
            '<th style="width: 120px;"><fmt:message key="label.import.back.kg"/></th>'+
            '</tr>'+
            '<tr>'+
            '<td>'+
            '<select oldSelected="" name="mainMaterials['+countNL+'].itemID" class="span11" id="sl_main_material_'+countNL+'" onchange="loadDetail(this.value,'+countNL+');">'+
            '<option value="-1">-<fmt:message key="label.select"/>-</option>'+
            '<c:forEach items="${products}" var="product">'+
            '<option value="${product.importProductID}">${product.productCode}</option>'+
            '</c:forEach>'+
            '</select>'+
            '</td>'+
            '<td id="name_'+countNL+'"></td>'+
            '<td id="size_'+countNL+'"></td>'+
            '<td id="specific_'+countNL+'"></td>'+
            '<td id="kg_'+countNL+'"></td>'+
            '<td class="inputItemInfo0">' +
            '<span id="totalMaterial_'+countNL+'">' +
            '</span> ' +
            '<input type="hidden" name="mainMaterials['+countNL+'].totalM" id="totalMaterial_hidden_'+countNL+'"/>' +
            '<input type="hidden" name="mainMaterials['+countNL+'].usedMet" id="usedMetMaterial_hidden_'+countNL+'"/>' +
            '</td>'+
            '<td><input class="inputNumber span11" type="text" name="mainMaterials['+countNL+'].cutOff" id="cutMaterial_'+countNL+'"/></td>'+
            '<td><input class="inputNumber span11" type="text" name="mainMaterials['+countNL+'].importBack" id="importBack_'+countNL+'"/></td>'+
            '</tr>'+
            '</table>'+
            '<div class="clear"></div>'+
            '<div class="right-btn" id="bt_add_sp_'+countNL+'">'+
            '<a class="btn btn-info" onclick="addSP('+countNL+');"><i class="icon-plus"></i> <fmt:message key="label.add.product"/> </a>'+
            '</div>'+
            '<div class="clear"></div>'+
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
            '<table class="tbInput" style="margin-bottom: -1px;">'+
            '<tr>'+
            '<td><fmt:message key="label.product.name"/></td>'+
            '<td>'+
            '<select class="width4 requiredField" sp="'+countSP+'" name="mainMaterials['+countNL+'].itemInfos['+countSP+'].productName.productNameID" id="sl_prd_name_'+countSP+'">'+
            '<option value="">-<fmt:message key="label.select"/>-</option>'+
            '<c:forEach items="${productNames}" var="productName">'+
            '<option value="${productName.productNameID}" code="${productName.code}">${productName.name}</option>'+
            '</c:forEach>'+
            '</select>'+
            '</td>'+
            '<td><fmt:message key="label.used.market"/></td>'+
            '<td>'+
            '<select class="width4" name="mainMaterials['+countNL+'].itemInfos['+countSP+'].market.marketID" id="sl_market_'+countSP+'">'+
            '<option value="">-<fmt:message key="label.select"/>-</option>'+
            '<c:forEach items="${markets}" var="market">'+
            '<option value="${market.marketID}">${market.name}</option>'+
            '</c:forEach>'+
            '</select>'+
            '</td>'+
            '<td><fmt:message key="label.code"/></td>'+
            '<td>'+
            '<input name="mainMaterials['+countNL+'].itemInfos['+countSP+'].code" type="text" class="uppercase span11 requiredField productCode" sp="'+countSP+'"/>'+
            '</td>'+
            '</tr>'+
            '<tr>'+
            '<td><fmt:message key="label.size"/></td>'+
            '<td>'+
            '<select class="width4" name="mainMaterials['+countNL+'].itemInfos['+countSP+'].size.sizeID" id="sl_size_'+countSP+'">'+
            '<option value="">-<fmt:message key="label.select"/>-</option>'+
            '<c:forEach items="${sizes}" var="size">'+
            '<option value="${size.sizeID}">${size.name}</option>'+
            '</c:forEach>'+
            '</select>'+
            '</td>'+
            '<td><fmt:message key="label.thickness"/></td>'+
            '<td>'+
            '<select class="width4" name="mainMaterials['+countNL+'].itemInfos['+countSP+'].thickness.thicknessID" id="sl_thickness_'+countSP+'">'+
            '<option value="">-<fmt:message key="label.select"/>-</option>'+
            '<c:forEach items="${thicknesses}" var="thickness">'+
            '<option value="${thickness.thicknessID}">${thickness.name}</option>'+
            '</c:forEach>'+
            '</select>'+
            '</td>'+
            '<td><fmt:message key="label.quantity.kg"/></td>'+
            '<td>'+
            '<input name="mainMaterials['+countNL+'].itemInfos['+countSP+'].quantityPure" id="quantityPure-'+countSP+'" type="text" class="inputNumber span11 weight-'+countNL+'" onkeyup="calKgM(\''+countSP+'\');"/>'+
            '</td>'+
            '</tr>'+
            '<tr>'+
            '<td><fmt:message key="whm.stiffness.name"/></td>'+
            '<td>'+
            '<select class="width4" name="mainMaterials['+countNL+'].itemInfos['+countSP+'].stiffness.stiffnessID" id="sl_stiffness_'+countSP+'">'+
            '<option value="">-<fmt:message key="label.select"/>-</option>'+
            '<c:forEach items="${stiffnesses}" var="stiffness">'+
            '<option value="${stiffness.stiffnessID}">${stiffness.name}</option>'+
            '</c:forEach>'+
            '</select>'+
            '</td>'+
            '<td><fmt:message key="label.colour"/></td>'+
            '<td>'+
            '<select class="width4" name="mainMaterials['+countNL+'].itemInfos['+countSP+'].colour.colourID" id="sl_colour_'+countSP+'">'+
            '<option value="">-<fmt:message key="label.select"/>-</option>'+
            '<c:forEach items="${colours}" var="colour">'+
            '<option value="${colour.colourID}">${colour.name}</option>'+
            '</c:forEach>'+
            '</select>'+
            '</td>'+
            '<td><fmt:message key="label.core"/></td>'+
            '<td>'+
            '<input name="mainMaterials['+countNL+'].itemInfos['+countSP+'].core" type="text" class="inputNumber span11"/>'+
            '</td>'+
            '</tr>'+
            '<tr>'+
            '<td><fmt:message key="whm.overlaytype.name"/></td>'+
            '<td>'+
            '<select class="width4" name="mainMaterials['+countNL+'].itemInfos['+countSP+'].overlayType.overlayTypeID" id="sl_overlay_'+countSP+'">'+
            '<option value="">-<fmt:message key="label.select"/>-</option>'+
            '<c:forEach items="${overlayTypes}" var="overlayType">'+
            '<option value="${overlayType.overlayTypeID}">${overlayType.name}</option>'+
            '</c:forEach>'+
            '</select>'+
            '</td>'+
            '<td colspan="4" style="font-weight: bold;color: red;text-align:center;">' +
            'Kg/m: <span id="kgm-'+countSP+'"></span>'+
            '</td>'+
            '</tr>'+
            <%--'<tr>'+--%>
            <%--'<td><fmt:message key="label.quality.assessment"/></td>'+--%>
            <%--'<td colspan="4">'+--%>
            <%--'<input name="mainMaterials['+countNL+'].itemInfos['+countSP+'].note" type="text" style="width: 97%;"/>'+--%>
            <%--'</td>'+--%>
            <%--'<td></td>'+--%>
            <%--'</tr>'+--%>
            '</table>'+
            '<table class="tbInput">'+
            '<tr>'+
            '<c:forEach items="${qualities}" var="quality">'+
            '<td><fmt:message key="label.rate"/> ${quality.name}</td>'+
            '<td><input name="mainMaterials['+countNL+'].itemInfos['+countSP+'].qualityQuantityMap[${quality.qualityID}]" type="text" class="inputNumber span11 quality-'+countNL+'" onkeyup="calKgM(\''+countSP+'\');" id="quantity_${quality.qualityID}_'+countNL+'_'+countSP+'" spq="'+countSP+'"/></td>'+
            '</c:forEach>'+
            '</tr>'+
            '<tr>'+
            '<td><fmt:message key="label.quality.assessment"/></td>'+
            '<td colspan="'+qualityLength+'">'+
            '<textarea name="mainMaterials['+countNL+'].itemInfos['+countSP+'].note" style="width: 97%;" rows="2"></textarea>'+
            '</td>'+
            '</tr>'+
            '</table>'+
            '</div>'+
            '</div>'+
            '</div>'+
            '</div>';
    $('#bt_add_nl').after(nl);
    $("#sl_main_material_" + countNL).select2();
    $("#sl_overlay_" + countSP).select2();
    $("#sl_prd_name_" + countSP).select2();
    $("#sl_size_" + countSP).select2();
    $("#sl_thickness_" + countSP).select2();
    $("#sl_stiffness_" + countSP).select2();
    $("#sl_market_" + countSP).select2();
    $("#sl_colour_" + countSP).select2();
}
function calKgM(countSP){
    var kg = $('#quantityPure-' + countSP).val();
    var m = 0;
    $('input[spq*='+countSP+']').each(function(){
        if($(this).val() != ''){
            m += numeral().unformat($(this).val());
        }
    });
    if(m != 0 && kg != ''){
        kg = numeral().unformat(kg);
        var kgm = numeral(kg/m).format('###,###.##');
        $('#kgm-' + countSP).text(kgm);
    }
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
function hideNL(spId){
    $("#div_nl_detail_" + spId).hide();
    $('#btn-hide-nl-' +spId).hide();
    $('#btn-show-nl-' +spId).show();
}
function showNL(spId){
    $("#div_nl_detail_" + spId).show();
    $('#btn-hide-nl-' +spId).show();
    $('#btn-show-nl-' +spId).hide();
}
function removeNL(nlId){
    if(typeof nlId == 'string'){
        var temp = nlId.split('_');
        var count = temp[temp.length - 1];
        var mainUsedProductID=$("#sl_main_material_" + count +" option:selected").val();
        listMainMaterialSelected = $.grep(listMainMaterialSelected,
                function(o,i) { return o.importProductID === mainUsedProductID; },true);
        $("#" + nlId).remove();
    }else{
        var temp = nlId.id.split('_');
        var count = temp[temp.length - 1];
        var mainUsedProductID=$("#sl_main_material_" + count +" option:selected").val();
        listMainMaterialSelected = $.grep(listMainMaterialSelected,
                function(o,i) { return o.importProductID === mainUsedProductID; },true);
        nlId.remove();
    }
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
            }else if($(this).val() == ''){
                checker = false;
                $(this).focus();
                return checker;
            }
        }
    });
    return checker;
}


</script>