<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" errorPage="/error.jsp" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@page import="com.banvien.tpk.core.Constants" %>
<c:set value="material" var="productType"/>
<c:if test="${!item.isBlackProduct}">
    <c:set value="product" var="productType"/>
</c:if>
<head>
    <title><fmt:message key="whm.exportproduct.${productType}.title"/></title>
    <meta name="heading" content="<fmt:message key="whm.exportproduct.${productType}.title"/>"/>
    <link rel="stylesheet" href="<c:url value='/themes/whm/css/jquery.jscrollpane.css' />" />


</head>

<c:url var="url" value="/whm/exportrootmaterialbill/view.html"/>
<c:url var="backUrl" value="/whm/exportrootmaterialbill/list.html?isBlackProduct=${item.isBlackProduct}"/>
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
            <div class="content-header noprint"><fmt:message key="whm.exportproduct.${productType}.declare"/></div>
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
                <c:if test="${item.pojo.exporttype.code eq Constants.EXPORT_TYPE_CHUYEN_KHO ||
                              item.pojo.exporttype.code eq Constants.EXPORT_TYPE_BAN  }">
                    <tr>
                        <td><fmt:message key="driver.name"/></td>
                        <td colspan="2"></td>
                        <td class="wall"><fmt:message key="car.no"/></td>
                        <td colspan="2">${item.pojo.vehicle}</td>
                    </tr>
                </c:if>
                <tr>
                    <td><fmt:message key="label.description"/></td>
                    <td colspan="5">${item.pojo.description}</td>
                </tr>
            </table>
            <table class="tbInput">
                <caption><fmt:message key="import.info.${productType}.base"/></caption>
                <tr id="tbHead">
                    <th>STT</th>
                    <th ><fmt:message key="label.code"/></th>
                    <th ><fmt:message key="label.name"/></th>
                    <th ><fmt:message key="label.size"/></th>
                    <c:if test="${!item.isBlackProduct}">
                        <th ><fmt:message key="label.quantity.meter"/></th>
                    </c:if>
                    <th ><fmt:message key="label.quantity.kg"/></th>
                    <th >
                        <c:if test="${!item.isBlackProduct}">
                            <fmt:message key="label.specific"/>
                        </c:if>
                        <c:if test="${item.isBlackProduct}">
                            <fmt:message key="whm.origin.name"/>
                        </c:if>
                    </th>
                </tr>
                <c:set var="totalM" value="0"/>
                <c:set var="totalKg" value="0"/>
                <c:forEach items="${exportProducts}" var="exportProduct" varStatus="status">
                    <tr class="product-row" id="prd_${status.index}">
                        <td class="counter" style="width: 3%">${status.index + 1}</td>
                        <%--<td class="inputItemInfo2">${tpk:productCodeWhenPrint(exportProduct.importproduct.productCode)}</td>--%>
                        <td class="inputItemInfo2">
                            <security:authorize ifAnyGranted="ADMIN">
                                <c:if test="${exportProduct.importproduct.status eq Constants.ROOT_MATERIAL_STATUS_WAIT_TO_USE}">
                                    <a class="icon-remove tip-top" title="Trả về kho" onclick="bringBack($(this),'${exportProduct.importproduct.importProductID}','${exportProduct.exportProductID}');"></a>
                                </c:if>
                            </security:authorize>
                                ${exportProduct.importproduct.productCode}
                        </td>
                        <td class="inputItemInfo1" id="name_${status.index}">${exportProduct.importproduct.productname.name}</td>
                        <td class="inputItemInfo1" id="size_${status.index}">${exportProduct.importproduct.size.name}</td>
                        <c:if test="${!item.isBlackProduct}">
                            <td class="inputItemInfo1" id="met_${status.index}"><fmt:formatNumber value="${exportProduct.importproduct.quantity1}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/></td>
                        </c:if>
                        <td class="inputItemInfo1" id="kg_${status.index}"><fmt:formatNumber value="${exportProduct.importproduct.quantity2Pure}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/></td>
                        <c:if test="${!item.isBlackProduct}">
                            <c:choose>
                                <c:when test="${not empty exportProduct.importproduct.colour}">
                                    <td class="inputItemInfo1" id="origin_${status.index}">${exportProduct.importproduct.colour.name}</td>
                                </c:when>
                                <c:when test="${not empty exportProduct.importproduct.thickness}">
                                    <td class="inputItemInfo1" id="origin_${status.index}">${exportProduct.importproduct.thickness.name}</td>
                                </c:when>
                            </c:choose>
                        </c:if>
                        <c:if test="${item.isBlackProduct}">
                            <td class="inputItemInfo1" id="origin_${status.index}">${exportProduct.importproduct.origin.name}</td>
                        </c:if>
                    </tr>
                    <c:set var="totalM" value="${totalM + exportProduct.importproduct.quantity1}"/>
                    <c:set var="totalKg" value="${totalKg + exportProduct.importproduct.quantity2Pure}"/>
                </c:forEach>
                <tr style="font-weight: bold;">
                    <td colspan="3" style="text-align: right"><fmt:message key="label.total"/></td>
                    <td style="text-align: center;">${fn:length(exportProducts)} CUỘN</td>
                    <c:if test="${!item.isBlackProduct}">
                        <td style="text-align: center;"><fmt:formatNumber value="${totalM}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/></td>
                    </c:if>
                    <td style="text-align: center;"><fmt:formatNumber value="${totalKg}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/></td>
                    <td></td>
                </tr>
            </table>

            <table class="tbHskt info noprint">
                <caption><fmt:message key="label.confirmation"/></caption>
                <tr>
                    <td style="width:20%;"><fmt:message key="label.note"/></td>
                    <td style="width:80%;"><form:textarea path="pojo.note" cssClass="nohtml nameValidate span11" rows="2"/></td>
                </tr>
                <tr>
                    <td class="ctrl-btn" colspan="2">
                        <c:if test="${item.loginWarehouseID eq item.pojo.exportWarehouse.warehouseID}">
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
                        </c:if>
                        <c:if test="${item.loginWarehouseID eq item.pojo.receiveWarehouse.warehouseID}">
                            <security:authorize ifAnyGranted="QUANLYKHO,LANHDAO">
                                <c:if test="${item.pojo.status == Constants.CONFIRMED}">
                                    <a onclick="rejectTransfer()" class="btn btn-danger" style="cursor: pointer;">
                                        <fmt:message key="button.reject"/>
                                    </a>
                                    <a onclick="approveTransfer()" class="btn btn-success" style="cursor: pointer;">
                                        <fmt:message key="button.confirm"/>
                                    </a>
                                </c:if>
                            </security:authorize>
                        </c:if>

                        <div style="display: inline">
                            <form:hidden path="crudaction" id="crudaction" value="insert-update"/>
                            <form:hidden path="pojo.exportProductBillID"/>
                            <form:hidden path="isBlackProduct"/>
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
                        <td>${item.pojo.exportWarehouse.code eq Constants.WAREHOSUE_PHUMY ? "BĐH Nhà máy TPK" : "Trưởng PKD"}</td>
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

    function approveTransfer(){
        $("#crudaction").val("approve-transfer");
        $("#itemForm").submit();
    }
    function rejectTransfer(){
        $("#crudaction").val("reject-transfer");
        $("#itemForm").submit();
    }

    function bringBack(ele, pid, eid){
        bootbox.confirm('Xác nhận cập mang về kho', 'Bạn có chắc chắn muốn trả cuộn tôn về lại kho?', function(r) {
            if(r){
                $.ajax({
                    url : '/ajax/product/bringback.html',
                    dataType: "json",
                    data : "productid=" + pid + "&exportid=" +eid,
                    type : "GET",
                    success : function(res){
                        if ('success' == res.msg){
                            bootbox.alert("<fmt:message key="label.title.confirm"/>", "Trả về kho thành công",function(){
                                $(ele).closest('.product-row').remove();
                                var index = 1;
                                $('.product-row').each(function(){
                                    $(this).find('.counter').text(index++);
                                });
                            });
                        }else{
                            bootbox.alert("<fmt:message key="label.title.confirm"/>", "Trả về kho thất bại, vui lòng thử lại",function(){
                            });
                        }
                    }
                });
            }
        });
    }
</script>