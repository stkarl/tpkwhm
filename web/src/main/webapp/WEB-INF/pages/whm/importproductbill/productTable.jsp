<%@ include file="/common/taglibs.jsp"%>
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
            <input counter="${counterSP}" name="reImportProducts[${counterSP}].originalCode" onblur="validateCode(this);" value="${product.productCode}" type="text" class="uppercase span11"/>
        </td>
        <td><fmt:message key="label.new.code"/></td>
        <td>
            <input name="reImportProducts[${counterSP}].productCode" value="${product.productCode}-TN" type="text" class="uppercase span11 requiredField" sp="${counterSP}" readonly="readonly"/>
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
            <input sp="${counterSP}" name="reImportProducts[${counterSP}].quantity2Pure" id="quantityPure-${counterSP}" type="text" class="inputNumber span11" value=""/>
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
        <td><input id="quantity_${counterSP}" name="reImportProducts[${counterSP}].quantity1" type="text" class="inputNumber span11" value=""/></td>

    </tr>
    <tr>
        <td><fmt:message key="label.quality.assessment"/></td>
        <td colspan="5">
            <textarea name="reImportProducts[${counterSP}].note" style="width: 97%;" rows="2">${product.note}</textarea>
        </td>
    </tr>
</table>