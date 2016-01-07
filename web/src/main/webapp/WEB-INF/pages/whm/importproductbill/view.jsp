<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" errorPage="/error.jsp" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@page import="com.banvien.tpk.core.Constants" %>

<head>
    <title><fmt:message key="whm.view.importproduct.title"/></title>
    <meta name="heading" content="<fmt:message key="whm.view.importproduct.title"/>"/>
    <style>
        .pane_title{
            text-align:center;
        }
    </style>
</head>

<c:url var="url" value="/whm/importproductbill/view.html"/>
<c:url var="backUrl" value="/whm/importproductbill/list.html"/>
<form:form commandName="item" action="${url}" method="post" id="itemForm" class="form-horizontal" novalidate="novalidate">
<div id="container-fluid data_content_box">
<div class="row-fluid data_content">
<div class="content-header"><fmt:message key="whm.importproduct.view"/></div>
<div class="clear"></div>
<div id="generalInfor">
    <table class="tbHskt info">
        <caption><fmt:message key="import.material.generalinfo"/></caption>
        <tr>
            <td><fmt:message key="label.number"/></td>
            <td colspan="2">${item.pojo.code}
            </td>
            <c:if test="${not empty item.pojo.productionPlan}">
                <td class="wall"><fmt:message key="whm.productionplan.name"/></td>
                <td colspan="2">${item.pojo.productionPlan.name}</td>
            </c:if>
            <c:if test="${empty item.pojo.productionPlan}">
                <td class="wall"><fmt:message key="import.material.supplier"/></td>
                <td colspan="2">${item.pojo.customer.name} - ${item.pojo.customer.address}</td>
            </c:if>
        </tr>
        <tr>
            <td><fmt:message key="label.location"/></td>
            <td colspan="2">${item.pojo.warehouseMap.name}</td>
            <td class="wall"></td>
            <td colspan="2"></td>
        </tr>
        <tr>
            <td><fmt:message key="label.description"/></td>
            <td colspan="5">${item.pojo.description}</td>
        </tr>
    </table>
</div>
<div class="clear"></div>
<c:if test="${not empty mainUsedMaterials}">
    <c:set var="counterNL" value="${fn:length(mainUsedMaterials)}"></c:set>
    <c:set var="counterSP" value="0"></c:set>
    <c:forEach items="${mainUsedMaterials}" var="mainUsedMaterial" varStatus="status">
        <div id="div_nl_${status.index}" class="pane_info">
            <div class="pane_title">
                <fmt:message key = "import.info.product"/>
            </div>
            <div class="pane_content">
                    <%--select main material--%>
                <table class="tbInput" id="table_nl_${status.index}">
                    <caption><fmt:message key="material.type.info"/></caption>
                    <tr>
                        <th class="inputItemInfo2"><fmt:message key="label.code"/></th>
                        <th ><fmt:message key="label.name"/></th>
                        <th ><fmt:message key="label.size"/></th>
                        <th ><fmt:message key="label.specific"/></th>
                        <th ><fmt:message key="label.quantity.kg"/></th>
                        <th class="inputItemInfo2"><fmt:message key="label.quantity.meter"/></th>
                        <th class="inputItemInfo2"><fmt:message key="label.cut.off"/></th>
                    </tr>
                    <tr>
                        <td>${mainUsedMaterial.mainMaterialCode}</td>
                        <td>${mainUsedMaterial.mainMaterialName}</td>
                        <td>${mainUsedMaterial.mainMaterialSize}</td>
                        <td>${mainUsedMaterial.mainMaterialSpecific}</td>
                        <td><fmt:formatNumber value="${mainUsedMaterial.totalKg}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/></td>
                        <td><fmt:formatNumber value="${mainUsedMaterial.totalM}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/></td>
                        <td><fmt:formatNumber value="${mainUsedMaterial.cutOff}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/></td>
                    </tr>
                </table>

                <div class="clear"></div>
                <c:forEach items="${mainUsedMaterial.importproducts}" var="product" varStatus="counter">
                    <c:set var="counterSP" value="${fn:length(mainUsedMaterial.importproducts) + counterSP}"></c:set>
                    <%-- declare produced product--%>
                    <div id="div_sp_${counter.index}">
                        <div class="pane_title">
                            <fmt:message key = "produced.product.info"/>
                        </div>
                        <table class="tbInput" style="margin-bottom: -1px;">
                            <tr>
                                <td><fmt:message key="label.product.name"/></td>
                                <td>${product.productname.name}</td>
                                <td><fmt:message key="label.used.market"/></td>
                                <td>${product.market.name}</td>
                                <td><fmt:message key="label.code"/></td>
                                <%--<td>${tpk:productCodeWhenPrint(product.productCode)}</td>--%>
                                <td>${product.productCode}</td>
                            </tr>
                            <tr>
                                <td><fmt:message key="label.size"/></td>
                                <td>${product.size.name}</td>
                                <td><fmt:message key="label.thickness"/></td>
                                <td>${product.thickness.name}</td>
                                <td><fmt:message key="label.quantity.kg"/></td>
                                <td><fmt:formatNumber value="${product.quantity2Pure}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/></td>
                            </tr>

                            <tr>
                                <td><fmt:message key="whm.stiffness.name"/></td>
                                <td>${product.stiffness.name}</td>
                                <td><fmt:message key="label.colour"/></td>
                                <td>${product.colour.name}</td>
                                <td><fmt:message key="label.core"/></td>
                                <td>${product.core}</td>
                            </tr>
                            <tr>
                                <td><fmt:message key="whm.overlaytype.name"/></td>
                                <td>${product.overlaytype.name}</td>
                                <td><fmt:message key="label.produce.team"/></td>
                                <td colspan="3">${product.producedTeam}</td>
                            </tr>
                            <%--<tr>--%>
                                <%--<td><fmt:message key="label.note"/></td>--%>
                                <%--<td colspan="4">${product.note}</td>--%>
                                <%--<td></td>--%>
                            <%--</tr>--%>
                        </table>
                        <table class="tbInput">
                            <tr>
                                <c:forEach items="${qualities}" var="quality">
                                    <td><fmt:message key="label.rate"/> ${quality.name}</td>
                                    <td><fmt:formatNumber value="${product.qualityQuantityMap[quality.qualityID]}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/></td>
                                </c:forEach>
                            </tr>
                            <tr>
                                <td><fmt:message key="label.quality.assessment"/></td>
                                <td colspan="${fn:length(qualities) * 2 - 1}">${product.note}</td>
                            </tr>
                        </table>
                    </div>
                    <div class="clear"></div>
                </c:forEach>
            </div>
        </div>
        <div class="clear"></div>

    </c:forEach>
</c:if>
<div class="clear"></div>
<div class="controls">
    <div style="display: inline">
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
</script>