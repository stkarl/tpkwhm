<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" errorPage="/error.jsp" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@page import="com.banvien.tpk.core.Constants" %>
<head>
    <title><fmt:message key="whm.export.material.view.title"/></title>
    <meta name="heading" content="<fmt:message key="whm.export.material.view.title"/>"/>
</head>

<c:url var="url" value="/whm/exportmaterialbill/view.html"/>
<c:url var="backUrl" value="/whm/exportmaterialbill/list.html"/>
<form:form commandName="item" action="${url}" method="post" id="itemForm" class="form-horizontal" novalidate="novalidate">
    <div id="container-fluid data_content_box">
        <div class="row-fluid data_content">
            <div class="noscreen company-title" style="margin:50px;">
                <table style="text-align: center;width: 100%">
                    <tr>
                        <td rowspan="5" style="width: 72px"><img src="/images/printlogo.png" style="width:72px;height: 72px;"/></td>
                        <td style="width: 30%;">CTY CỔ PHẦN THƯƠNG MẠI - SẢN XUẤT</td>
                        <td rowspan="4" class="bill-title">
                            <c:choose>
                                <c:when test="${not empty item.pojo.productionPlan}">
                                    <fmt:message key="label.inner.export.bill"/>
                                </c:when>
                                <c:otherwise>
                                    <fmt:message key="label.export.bill"/>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                    <tr>
                        <td style="font-weight: bold">TÔN TÂN PHƯỚC KHANH</td>
                    </tr>
                    <tr>
                        <td>KCN Phú Mỹ 1, H.Tân Thành, Tỉnh BRVT</td>
                    </tr>
                    <tr>
                        <td>Điện thoại: 0643.922762   Fax: 0643.922765</td>
                    </tr>
                </table>
            </div>
            <div class="content-header noprint"><fmt:message key="whm.export.material.view.title"/></div>
            <div class="clear"></div>
            <table class="tbHskt info">
                <caption><fmt:message key="import.material.generalinfo"/></caption>
                <tr>
                    <td><fmt:message key="label.number"/></td>
                    <td colspan="2">${item.pojo.code}</td>
                    <td class="wall"><fmt:message key="label.export.type"/></td>
                    <td colspan="2">${item.pojo.exporttype.name}</td>
                </tr>
                <c:choose>
                    <c:when test="${not empty item.pojo.receiveWarehouse}">
                        <tr>
                            <td><fmt:message key="warehouse.export"/></td>
                            <td colspan="2">${item.pojo.exportWarehouse.name}</td>
                            <td class="wall"><fmt:message key="warehouse.receive"/></td>
                            <td colspan="2">${item.pojo.receiveWarehouse.name}</td>
                        </tr>
                    </c:when>
                    <c:when test="${not empty item.pojo.customer}">
                        <tr>
                            <td><fmt:message key="warehouse.export"/></td>
                            <td colspan="2">${item.pojo.exportWarehouse.name}</td>
                            <td class="wall"><fmt:message key="label.customer"/></td>
                            <td colspan="2">${item.pojo.customer.name} - ${customer.address}</td>
                        </tr>
                    </c:when>
                    <c:when test="${not empty item.pojo.productionPlan}">
                        <tr>
                            <td><fmt:message key="warehouse.export"/></td>
                            <td colspan="2">${item.pojo.exportWarehouse.name}</td>
                            <td class="wall"><fmt:message key="whm.productionplan.name"/></td>
                            <td colspan="2">${item.pojo.productionPlan.name}</td>
                        </tr>
                    </c:when>
                </c:choose>
                <c:if test="${empty item.pojo.productionPlan}">
                    <tr class="noprint">
                        <td><fmt:message key="export.date"/></td>
                        <td colspan="2"><fmt:formatDate value="${item.pojo.exportDate}" pattern="dd/MM/yyyy"/></td>
                        <td class="wall"></td>
                        <td colspan="2"></td>
                    </tr>
                </c:if>
                <tr>
                    <td><fmt:message key="label.description"/></td>
                    <td colspan="5">${item.pojo.description}</td>
                </tr>
            </table>
            <div class="row-fluid">
                <display:table name="exportMaterials" cellspacing="0" cellpadding="0" requestURI="${formlUrl}"
                               partialList="true" sort="external" size="${fn:length(exportMaterials)}"
                               uid="tableList" excludedParams="crudaction"
                               pagesize="${fn:length(exportMaterials)}" export="false" class="tableSadlier table-hover">
                    <display:caption><fmt:message key='export.material.list'/></display:caption>
                    <display:column headerClass="table_header_center" sortable="false" title="STT" class="text-center" style="width: 2%;">
                        ${tableList_rowNum}
                    </display:column>
                    <display:column headerClass="table_header_center" property="importmaterial.material.name" sortable="true" sortName="material.name" titleKey="whm.material.name" class="text-center" style="width: 7%;"/>
                    <display:column headerClass="table_header_center" property="importmaterial.code" titleKey="label.number" class="text-center" style="width: 7%;"/>
                    <display:column headerClass="table_header_center" property="importmaterial.origin.name" sortable="true" sortName="origin.name" titleKey="whm.origin.name" class="text-center" style="width: 7%;"/>
                    <display:column headerClass="table_header_center" property="importmaterial.market.name" sortable="true" sortName="market.name" titleKey="whm.market.name" class="text-center" style="width: 7%;"/>
                    <display:column headerClass="table_header_center" sortable="false" titleKey="import.warehouse.date" class="text-center" style="width: 7%;">
                        <fmt:formatDate value="${tableList.importmaterial.importDate}" pattern="dd/MM/yyyy"/>
                    </display:column>
                    <display:column headerClass="table_header_center" sortable="false" titleKey="label.expiredDate" class="text-center" style="width: 7%;">
                        <fmt:formatDate value="${tableList.importmaterial.expiredDate}" pattern="dd/MM/yyyy"/>
                    </display:column>
                    <display:column headerClass="table_header_center" property="importmaterial.material.unit.name" sortable="false" title="ĐVT" class="text-center" style="width: 7%;"/>
                    <display:column headerClass="table_header_center" sortable="false" titleKey="label.quantity.export" style="width: 10%;" class="text-center">
                        <fmt:formatNumber value="${tableList.quantity}" pattern="###,###.#" maxFractionDigits="1" minFractionDigits="0"/>
                    </display:column>

                    <display:setProperty name="paging.banner.item_name" value="loại vật tư"/>
                    <display:setProperty name="paging.banner.items_name" value="loại vật tư"/>
                    <display:setProperty name="paging.banner.placement" value=""/>
                    <display:setProperty name="paging.banner.no_items_found" value=""/>
                </display:table>

                <table class="tbHskt info noprint">
                    <caption><fmt:message key="label.confirmation"/></caption>
                    <tr>
                        <td style="width:20%;"><fmt:message key="label.note"/></td>
                        <td style="width:80%;"><form:textarea path="pojo.note" cssClass="nohtml nameValidate span11" rows="2"/></td>
                    </tr>
                    <tr>
                        <td class="ctrl-btn" colspan="2">
                            <a href="javascript:window.print();" class="btn btn-primary"><i class="icon-print"></i> <fmt:message key="button.print"/></a>
                            <security:authorize ifAnyGranted="QUANLYKHO,LANHDAO">
                            <c:if test="${item.pojo.status == Constants.WAIT_CONFIRM}">
                            <a onclick="rejectBill()" class="btn btn-danger" style="cursor: pointer;">
                                <fmt:message key="button.reject"/>
                            </a>
                            <a onclick="saveBill()" class="btn btn-success" style="cursor: pointer;">
                                <fmt:message key="button.confirm"/>
                            </a>
                            </c:if>
                            </security:authorize>
                            <div style="display: inline">
                                <form:hidden path="crudaction" id="crudaction" value="insert-update"/>
                                <form:hidden path="pojo.exportMaterialBillID"/>
                                <a href="${backUrl}" class="cancel-link">
                                    <fmt:message key="button.cancel"/>
                                </a>
                            </div>
                        </td>
                    </tr>
                </table>
                <%@include file="../common/tablelog.jsp"%>
                <div class="noscreen sign-panel">
                    <table style="width: 100%">
                        <tr>
                            <td colspan="4" style="text-align: right;padding-bottom: 1em;">Ngày......tháng......năm.....</td>
                        </tr>
                        <tr style="text-align: center;font-weight: bold">
                            <td>Người lập phiếu</td>
                            <td>
                                <c:choose>
                                    <c:when test="${not empty item.pojo.productionPlan}">
                                        Trưởng ca xác nhận
                                    </c:when>
                                    <c:otherwise>
                                        Người nhận hàng
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>Thủ kho TPK</td>
                            <td>BĐH Nhà máy TPK</td>
                        </tr>
                        <tr style="text-align: center">
                            <td>(Ký, ghi rõ họ & tên)</td>
                            <td>(Ký, ghi rõ họ & tên)</td>
                            <td>(Ký, ghi rõ họ & tên)</td>
                            <td>(Ký, ghi rõ họ & tên)</td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </div>
</form:form>
<script type="text/javascript">
    function saveBill(){
        $("#crudaction").val("insert-update");
        $("#itemForm").submit();
    }
    function rejectBill(){
        $("#crudaction").val("reject");
        $("#itemForm").submit();
    }
</script>