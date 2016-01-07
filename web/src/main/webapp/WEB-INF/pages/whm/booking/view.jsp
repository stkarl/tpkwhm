<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" errorPage="/error.jsp" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@page import="com.banvien.tpk.core.Constants" %>

<head>
    <title><fmt:message key="booking.bill.view.title"/></title>
    <meta name="heading" content="<fmt:message key="booking.bill.view.title"/>"/>
    <link rel="stylesheet" href="<c:url value='/themes/whm/css/jquery.jscrollpane.css' />" />
    <style>
        table.tbHskt .table_header{
            text-align: left;
            padding: 4px 2px 4px 5px;
        }
    </style>
</head>

<c:url var="url" value="/whm/booking/view.html"/>
<c:url var="backUrl" value="/whm/booking/list.html"/>

<form:form commandName="item" action="${url}" method="post" id="itemForm" class="form-horizontal" novalidate="novalidate">
<div id="container-fluid data_content_box">
<div class="row-fluid data_content">
<div class="content-header"><fmt:message key="booking.bill.view.title"/></div>
<div class="clear"></div>
<div id="generalInfo">
    <table class="tbHskt info">
        <caption><fmt:message key="import.material.generalinfo"/></caption>
        <tr>
            <td><fmt:message key="label.description"/></td>
            <td colspan="5">
                    ${item.pojo.description}
            </td>
        </tr>
        <tr>
            <td><fmt:message key="label.customer"/></td>
            <td colspan="2">
                    ${item.pojo.customer.name} - ${item.pojo.customer.province.name}
            </td>
            <td class="wall"><fmt:message key="delivery.date"/></td>
            <td colspan="2">
                <fmt:formatDate value="${item.pojo.deliveryDate}" pattern="dd/MM/yyyy"/>
            </td>
        </tr>
        <security:authorize ifAnyGranted="QUANLYKD,NHANVIENKD,QUANLYTT,LANHDAO,QUANLYNO">
            <tr>
                <td><fmt:message key="whm.owe.util.bill.date"/></td>
                <td colspan="2">
                    <fmt:formatNumber value="${owe}" pattern="###,###"/>
                </td>
                <td class="wall"><fmt:message key="bill.date"/></td>
                <td colspan="2">
                    <fmt:formatDate value="${item.pojo.billDate}" pattern="dd/MM/yyyy"/>
                </td>
            </tr>
        </security:authorize>
    </table>

</div>
<div class="clear"></div>
<security:authorize ifAnyGranted="QUANLYKD,NHANVIENKD,QUANLYTT,LANHDAO,QUANLYNO">
    <c:if test="${!empty item.pojo.bookBillSaleReasons}">
        <div id="reduce-money">
            <table class="tbHskt info">
                <caption><fmt:message key="money.reduce"/></caption>
                <tr>
                    <th class="table_header" style="width: 50%;">Lý do khấu trừ</th>
                    <th class="table_header" style="width: 20%;">Ngày</th>
                    <th class="table_header" style="width: 30%;">Số tiền</th>
                </tr>
                <c:forEach items="${item.pojo.bookBillSaleReasons}" var="reason">
                    <tr>
                        <td>${reason.saleReason.reason}</td>
                        <td><fmt:formatDate value="${reason.date}" pattern="dd/MM/yyyy"/></td>
                        <td><fmt:formatNumber value="${reason.money}" pattern="###,###"/></td>
                    </tr>
                </c:forEach>
            </table>
        </div>
        <div class="clear"></div>
    </c:if>
    <c:if test="${!empty item.pojo.prePaids}">
        <div id="reduce-money">
            <table class="tbHskt info">
                <caption><fmt:message key="money.prepaid"/></caption>
                <tr>
                    <th class="table_header" style="width: 50%;">Phương thức thanh toán</th>
                    <th class="table_header" style="width: 20%;">Ngày thanh toán</th>
                    <th class="table_header" style="width: 30%;">Số tiền</th>
                </tr>
                <c:forEach items="${item.pojo.prePaids}" var="prePaid">
                    <tr>
                        <td>${prePaid.note}</td>
                        <td><fmt:formatDate value="${prePaid.payDate}" pattern="dd/MM/yyyy"/></td>
                        <td><fmt:formatNumber value="${prePaid.pay}" pattern="###,###"/></td>
                    </tr>
                </c:forEach>
            </table>
        </div>
        <div class="clear"></div>
    </c:if>
    <c:if test="${!empty item.pojo.reduceCost}">
        <div id="reduce-transport">
            <table class="tbHskt info">
                <caption><fmt:message key="transport.reduce.if.any"/></caption>
                <tr>
                    <th class="table_header" style="width: 50%;">Địa điểm nhận</th>
                    <th class="table_header" style="width: 20%;">Định mức (VNĐ/kg)</th>
                    <th class="table_header" style="width: 30%;">Thành tiền</th>
                </tr>
                <tr>
                    <td>${item.pojo.destination}</td>
                    <td><fmt:formatNumber value="${item.pojo.reduceCost}" pattern="###,###"/></td>
                    <td><fmt:formatNumber value="${item.pojo.reduce}" pattern="###,###"/></td>
                </tr>
            </table>
        </div>
        <div class="clear"></div>
    </c:if>

</security:authorize>

<c:if test="${not empty item.pojo.bookProducts}">
<security:authorize ifAnyGranted="QUANLYKHO,XUAT_TP,ADMIN">
    <c:set var="totalMet" value="0"/>
    <c:set var="totalKg" value="0"/>
    <display:table name="item.pojo.bookProducts" cellspacing="0" cellpadding="0" requestURI="${formlUrl}"
                   partialList="true" sort="external" size="${fn:length(item.pojo.bookProducts)}"
                   uid="tableList" excludedParams="crudaction"
                   pagesize="${fn:length(item.pojo.bookProducts)}" export="false" class="tableSadlier table-hover" style="margin: 0 0 0 0;">
        <display:caption><fmt:message key='booked.product.list'/></display:caption>
        <display:column headerClass="table_header_center" sortable="false" title="STT" class="text-center" style="width: 2%;">
            ${tableList_rowNum}
        </display:column>
        <display:column headerClass="table_header_center" sortable="false" titleKey="label.status" class="text-center" style="width: 10%;">
            <c:choose>
                <c:when test="${tableList.importProduct.status == Constants.ROOT_MATERIAL_STATUS_BOOKED}">Chờ xuất</c:when>
                <c:when test="${tableList.importProduct.status == Constants.ROOT_MATERIAL_STATUS_USED}">Đã xuất</c:when>
                <c:otherwise>-</c:otherwise>
            </c:choose>
        </display:column>
        <display:column headerClass="table_header_center" property="importProduct.productname.name" sortable="false"  titleKey="whm.productname.name" class="text-center" style="width: 7%;"/>
        <display:column headerClass="table_header_center" titleKey="label.number" class="text-center" style="width: 7%;">
            <%--${tpk:productCodeWhenPrint(tableList.importProduct.productCode)}--%>
            ${tableList.importProduct.productCode}
        </display:column>

        <display:column headerClass="table_header_center" property="importProduct.size.name" sortable="false"  titleKey="whm.size.name" class="text-center" style="width: 7%;"/>
        <display:column headerClass="table_header_center" property="importProduct.thickness.name" sortable="false"  titleKey="whm.thickness.name" class="text-center" style="width: 7%;"/>
        <display:column headerClass="table_header_center" property="importProduct.stiffness.name" sortable="false"  titleKey="whm.stiffness.name" class="text-center" style="width: 7%;"/>
        <display:column headerClass="table_header_center" property="importProduct.colour.name" sortable="false"  titleKey="whm.colour.name" class="text-center" style="width: 7%;"/>
        <display:column headerClass="table_header_center" property="importProduct.overlaytype.name" sortable="false"  titleKey="whm.overlaytype.name" class="text-center" style="width: 7%;"/>
        <display:column headerClass="table_header_center" sortable="false" titleKey="import.warehouse.date" class="text-center" style="width: 7%;">
            <c:choose>
                <c:when test="${not empty tableList.importProduct.produceDate}">
                    <fmt:formatDate value="${tableList.importProduct.produceDate}" pattern="dd/MM/yyyy"/>
                </c:when>
                <c:when test="${not empty tableList.importProduct.importDate}">
                    <fmt:formatDate value="${tableList.importProduct.importDate}" pattern="dd/MM/yyyy"/>
                </c:when>
                <c:otherwise>-</c:otherwise>
            </c:choose>
        </display:column>
        <display:column headerClass="table_header large" sortName="quantity1" sortable="false" titleKey="label.quantity.meter" style="width: 10%;text-align:right;">
            <fmt:formatNumber value="${tableList.importProduct.quantity1}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/>
            <c:set var="totalMet" value="${totalMet + tableList.importProduct.quantity1}"/>
        </display:column>
        <display:column headerClass="table_header large" sortName="quantity2Pure" sortable="false" titleKey="label.quantity.kg" style="width: 10%;text-align:right;">
            <fmt:formatNumber value="${tableList.importProduct.quantity2Pure}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/>
            <c:set var="totalKg" value="${totalKg + tableList.importProduct.quantity2Pure}"/>
        </display:column>
        <security:authorize ifNotGranted="QUANLYKD">
            <display:column headerClass="table_header_center" sortable="false" titleKey="<input type=\"checkbox\" onclick=\"checkAllByClass('checkPrd', this);\"/>" style="width: 5%;text-align:center">
                <c:if test="${tableList.importProduct.status == Constants.ROOT_MATERIAL_STATUS_BOOKED}">
                    <input class="checkPrd" type="checkbox" name="bookedProductIDs" value="${tableList.importProduct.importProductID}"/>
                </c:if>
            </display:column>
        </security:authorize>
        <display:setProperty name="paging.banner.item_name" value="cuộn tôn"/>
        <display:setProperty name="paging.banner.items_name" value="cuộn tôn"/>
        <display:setProperty name="paging.banner.placement" value=""/>
        <display:setProperty name="paging.banner.no_items_found" value=""/>
    </display:table>
    <div style="clear:both"></div>
    <table class="tableSadlier">
        <tr style="font-weight: bold">
            <td style="text-align: left;width: 60%">
                Tổng: ${fn:length(item.pojo.bookProducts)} cuộn
            </td>
            <td style="text-align: right;width: 40%;padding-right: 38px;">
                Mét: <fmt:formatNumber value="${totalMet}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/>
                <span class="separator"></span>
                Tấn: <fmt:formatNumber value="${totalKg / 1000}" pattern="###,###" maxFractionDigits="0" minFractionDigits="3"/>
            </td>
        </tr>
    </table>
</security:authorize>
<security:authorize ifAnyGranted="QUANLYKD,NHANVIENKD,QUANLYTT,LANHDAO,QUANLYNO">
    <div class="product-info">
        <table class="tableSadlier table-hover">
            <caption><fmt:message key='booked.product.list'/></caption>
            <tr>
                <th class="table_header_center">Stt</th>
                <th class="table_header_center" colspan="2">Tên hàng - Quy cách</th>
                <th class="table_header_center">MS - SP</th>
                <th class="table_header_center">Mã số</th>
                <th class="table_header_center">Trọng lượng</th>
                <th class="table_header_center">Số lượng</th>
                <th class="table_header_center">Đơn giá</th>
                <th class="table_header_center">Thành tiền</th>
                <th class="table_header_center">Kg/m</th>
            </tr>
            <c:set var="totalKg" value="0"/>
            <c:set var="totalM" value="0"/>
            <c:set var="counter" value="0"/>

            <c:forEach items="${item.pojo.bookProducts}" var="bookProduct" varStatus="status">
                <c:set var="product" value="${bookProduct.importProduct}"/>
                <c:set var="counter" value="${counter + 1}"/>
                <c:set var="kgm" value="${product.quantity2Pure / product.quantity1}"/>
                <c:set var="isCold" value="${product.productname.code eq Constants.PRODUCT_LANH ? true : false}"/>

                <tr class="text-center ${counter % 2 == 0 ? 'even' : 'odd'}">
                    <td>${status.index + 1}</td>
                    <td>${tpk:productShipName(product.productname.name,product.colour.name)}</td>
                    <td>${product.size.name}</td>
                    <td>
                        <c:choose>
                            <c:when test="${!empty product.colour}">${product.colour.code}</c:when>
                            <c:when test="${empty product.colour}">${product.thickness.name}</c:when>
                            <c:otherwise>-</c:otherwise>
                        </c:choose>
                    </td>
                    <%--<td>${tpk:productCodeWhenPrint(product.productCode)}</td>--%>
                    <td>${product.productCode}</td>
                    <c:set var="price" value="0"/>
                    <c:set var="quantity" value="0"/>
                    <c:set var="kgQuantity" value="0"/>
                    <c:set var="saleQuantity" value="0"/>
                    <c:set var="salePrice" value="0"/>
                    <c:choose>
                        <c:when test="${empty product.productqualitys}">
                            <c:set var="saleQuantity" value="${product.saleQuantity}"/>
                            <c:set var="quantity" value="${product.quantity1 - saleQuantity}"/>
                            <c:set var="kgQuantity" value="${product.quantity2Pure - saleQuantity}"/>
                            <c:set var="price" value="${product.suggestedPrice}"/>
                            <c:set var="salePrice" value="${product.salePrice}"/>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${product.productqualitys}" var="productQuality">
                                <c:if test="${productQuality.quality.code eq Constants.QUALITY_A}">
                                    <c:set var="saleQuantity" value="${productQuality.saleQuantity}"/>
                                    <c:set var="quantity" value="${productQuality.quantity1 - saleQuantity}"/>
                                    <c:set var="kgQuantity" value="${productQuality.quantity1 * kgm - saleQuantity}"/>
                                    <fmt:formatNumber var="kgQuantityOthersRounded" value="${kgQuantity}" pattern="######"/>
                                    <c:set var="price" value="${productQuality.price}"/>
                                    <c:set var="salePrice" value="${productQuality.salePrice}"/>
                                </c:if>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                    <td>
                          <span id="kg-product-${product.importProductID}_A" quantity="${kgQuantity + saleQuantity}">
                            <fmt:formatNumber value="${kgQuantity}" pattern="###,###"/>
                          </span>
                    </td>
                    <td>
                                    <span id="product-${product.importProductID}_A" quantity="${quantity + saleQuantity}">
                                        <fmt:formatNumber value="${quantity}" pattern="###,###"/>
                                    </span>
                    </td>
                    <td>
                            <span code="${product.productname.code}" id="price-${product.importProductID}_A">
                                <fmt:formatNumber value="${price}" pattern="###,###" maxFractionDigits="2" minFractionDigits="0"/>
                            </span>
                    </td>
                    <td id="money-${product.importProductID}_A" class="money"></td>
                    <td><fmt:formatNumber value="${kgm}" pattern="###,###.##"/></td>
                </tr>
                <%--<c:if test="${!empty saleQuantity && saleQuantity != 0}">--%>
                    <%--<tr class="sale-info">--%>
                        <%--<td colspan="6"><fmt:message key="sale.info"/></td>--%>
                        <%--<td style="text-align: center;">--%>
                                <%--<span id="quantitySale-${product.importProductID}_A">--%>
                                    <%--<fmt:formatNumber value="${saleQuantity}" pattern="###,###" maxFractionDigits="2" minFractionDigits="0"/>--%>
                                <%--</span>--%>
                        <%--</td>--%>
                        <%--<td style="text-align: center;">--%>
                                <%--<span id="priceSale-${product.importProductID}_A">--%>
                                    <%--<fmt:formatNumber value="${salePrice}" pattern="###,###" maxFractionDigits="2" minFractionDigits="0"/>--%>
                                <%--</span>--%>
                        <%--</td>--%>
                        <%--<td id="moneySale-${product.importProductID}_A" class="money"></td>--%>
                        <%--<td></td>--%>
                    <%--</tr>--%>
                <%--</c:if>--%>
                <c:if test="${fn:length(product.productqualitys) > 1}">
                    <c:forEach items="${product.productqualitys}" var="productQuality" varStatus="status">
                        <c:if test="${productQuality.quality.code ne Constants.QUALITY_A && productQuality.quantity1 > 0}">
                            <c:set var="counter" value="${counter + 1}"/>
                            <tr class="text-center ${counter % 2 == 0 ? 'even' : 'odd'}">
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td style="font-style: italic;font-weight: bold">
                                <%--@TODO remove only show Kg for Cold--%>
                                    <c:if test="${status.index != fn:length(product.productqualitys) - 1}">
                                        <%--<c:if test="${isCold}">--%>
                                        <span id="kg-product-${product.importProductID}_${productQuality.quality.name}">
                                            <fmt:formatNumber value="${productQuality.quantity1 * kgm - productQuality.saleQuantity}" pattern="###,###"/>
                                        </span>
                                        <%--</c:if>--%>
                                        <fmt:formatNumber var="kgQuantityOthersRounded" value="${kgQuantityOthersRounded + productQuality.quantity1 * kgm - productQuality.saleQuantity}" pattern="######"/>
                                    </c:if>
                                    <c:if test="${status.index == fn:length(product.productqualitys) - 1}">
                                        <%--<c:if test="${isCold}">--%>
                                                <span id="kg-product-${product.importProductID}_${productQuality.quality.name}" quantity="${product.quantity2Pure - kgQuantityOthersRounded}" quality="${productQuality.quality.name}">
                                                   <fmt:formatNumber value="${product.quantity2Pure - kgQuantityOthersRounded - productQuality.saleQuantity}" pattern="###,###"/>
                                                </span>
                                        <%--</c:if>--%>
                                    </c:if>
                                </td>
                                <td style="font-style: italic;font-weight: bold">
                                    <span id="product-${product.importProductID}_${productQuality.quality.name}"><fmt:formatNumber value="${productQuality.quantity1 - productQuality.saleQuantity}" pattern="###,###"/>m${productQuality.quality.name}</span>
                                </td>
                                <td>
                                    <span code="${product.productname.code}" id="price-${product.importProductID}_${productQuality.quality.name}"><fmt:formatNumber value="${productQuality.price}" pattern="###,###" maxFractionDigits="2" minFractionDigits="0"/></span>
                                </td>
                                <td id="money-${product.importProductID}_${productQuality.quality.name}" class="money"></td>
                                <td></td>
                            </tr>
                            <%--<c:if test="${!empty productQuality.saleQuantity}">--%>
                                <%--<tr class="sale-info">--%>
                                    <%--<td colspan="6"><fmt:message key="sale.info"/></td>--%>
                                    <%--<td style="text-align: center;">--%>
                                            <%--<span id="quantitySale-${product.importProductID}_${productQuality.quality.name}">--%>
                                                <%--<fmt:formatNumber value="${productQuality.saleQuantity}" pattern="###,###" maxFractionDigits="2" minFractionDigits="0"/>--%>
                                            <%--</span>--%>
                                    <%--</td>--%>
                                    <%--<td style="text-align: center;">--%>
                                            <%--<span id="priceSale-${product.importProductID}_${productQuality.quality.name}">--%>
                                                <%--<fmt:formatNumber value="${productQuality.salePrice}" pattern="###,###" maxFractionDigits="2" minFractionDigits="0"/>--%>
                                            <%--</span>--%>
                                    <%--</td>--%>
                                    <%--<td id="moneySale-${product.importProductID}_${productQuality.quality.name}" class="money"></td>--%>
                                    <%--<td></td>--%>
                                <%--</tr>--%>
                            <%--</c:if>--%>
                        </c:if>
                    </c:forEach>
                </c:if>
                <c:set var="totalKg" value="${totalKg + product.quantity2Pure}"/>
                <c:set var="totalM" value="${totalM + product.quantity1}"/>
            </c:forEach>
            <c:set var="counter" value="${counter + 1}"/>
            <tr class="text-center ${counter % 2 == 0 ? 'even' : 'odd'}" style="font-weight: bold">
                <td colspan="2">Tổng cộng</td>
                <td></td>
                <td></td>
                <td></td>
                <td><fmt:formatNumber value="${totalKg}" pattern="###,###"/></td>
                <td><fmt:formatNumber value="${totalM}" pattern="###,###"/></td>
                <td></td>
                <td id="total">
                </td>
                <td></td>
            </tr>
        </table>
    </div>
</security:authorize>

</c:if>
<div style="clear:both"></div>
<div class="controls">
    <c:if test="${item.pojo.status == Constants.BOOK_ALLOW_EXPORT || item.pojo.status == Constants.BOOK_EXPORTING}">
        <security:authorize ifAnyGranted="XUAT_TP,QUANLYKHO">
            <span style="font-weight: bold">Ngày xuất:&nbsp;</span>
            <div class="input-append date" style="margin-right: 1px;">
                <input name="exportDate" id="deliveryDate" class="text-center width2 prevent_type" type="text" />
                <span class="add-on" id="deliveryDateIcon"><i class="icon-calendar"></i></span>
            </div>
            &nbsp;
            <a onclick="saveExportBill()" class="btn btn-green btn-success" style="cursor: pointer;width: 220px;">
                <i class="icon-check"></i> <fmt:message key="button.create.export.bill"/>
            </a>
        </security:authorize>
    </c:if>
    <c:if test="${item.pojo.status == Constants.BOOK_WAIT_CONFIRM}">
        <security:authorize ifAnyGranted="QUANLYKD">
            <a onclick="rejectBill()" class="btn btn-danger" style="cursor: pointer;">
                <fmt:message key="button.reject"/>
            </a>
            <a onclick="approveBill()" class="btn btn-success" style="cursor: pointer;">
                <fmt:message key="button.accept"/>
            </a>
        </security:authorize>
    </c:if>
    <div style="display: inline">
        <security:authorize ifAnyGranted="QUANLYKD,NHANVIENKD,QUANLYTT,LANHDAO,QUANLYNO">
            <a class="btn btn-primary" onclick="printShippingBill(${item.pojo.bookProductBillID});"><i class="icon-print"></i> <fmt:message key="button.print.ship.bill"/></a>
            <a class="btn btn-primary" onclick="printShippingConfirmBill(${item.pojo.bookProductBillID});"><i class="icon-print"></i> <fmt:message key="button.print.ship.confirm.bill"/></a>
        </security:authorize>
        <form:hidden path="crudaction" id="crudaction" value="insert-update"/>
        <form:hidden path="pojo.bookProductBillID"/>
        <a href="${backUrl}" class="cancel-link">
        <fmt:message key="button.cancel"/>
    </a>
    </div>
</div>
</div>
</div>
</form:form>
<iframe name="printout" style="width:1px;height:1px;border:none;" id="printout"></iframe>
<script type="text/javascript">
    $(document).ready(function(){
        var deliveryDateVar = $("#deliveryDate").datepicker({
            format: 'dd/mm/yyyy',
            onRender: function(date){
            }}).on('changeDate', function(ev) {
                    deliveryDateVar.hide();
                }).data('datepicker');
        $('#deliveryDateIcon').click(function() {
            $('#deliveryDate').focus();
            return true;
        });
        initCalMoney();
    });

    function initCalMoney(){
        var total = 0;

        $("span[id^='price-']").each(function(){
            var price = $(this).text() != '' ? numeral().unformat($(this).text()) : 0;
            var productCode = $(this).attr('code');
            var id = $(this).attr('id').split('-')[1];
            var quantity;
            if(productCode != '${Constants.PRODUCT_LANH}'){
                quantity = $.trim($('#product-' + id).text());
                if(quantity != '' && quantity.split('m').length > 0){
                    quantity = quantity.split('m')[0];
                }
            }else{
                quantity = $.trim($('#kg-product-' + id).text());
                if(quantity != '' && quantity.split('kg').length > 0){
                    quantity = quantity.split('kg')[0];
                }
            }

            quantity = quantity != '' ? numeral().unformat(quantity) : 0;
            total += price * quantity;
            $('#money-' + id).html(numeral(parseFloat(price * quantity)).format('###,###'));
        });

        $("span[id^='priceSale-']").each(function(){
            var price = $(this).text() != '' ? numeral().unformat($(this).text()) : 0;
            var id = $(this).attr('id').split('-')[1];
            var quantity = $.trim($('#quantitySale-' + id).text());
            quantity = quantity != '' ? numeral().unformat(quantity) : 0;
            total += price * quantity;
            $('#moneySale-' + id).html(numeral(parseFloat(price * quantity)).format('###,###'));
        });

        $('#total').html(numeral(total).format('###,###'));
    }
    function rejectBill(){
        $("#crudaction").val("reject");
        $("#itemForm").submit();
    }
    function approveBill(){
        $("#crudaction").val("approve");
        $("#itemForm").submit();
    }

    function saveExportBill(){
        var hasPrd = false;
        $(".checkPrd:checkbox:checked").each(function(){
            hasPrd = true;
        });
        var hasDate = false;
        if($('#deliveryDate').val() != ''){
            hasDate = true;
        }
        if(hasPrd && hasDate){
            $("#crudaction").val("insert-update");
            $("#itemForm").submit();
        }else if(!hasPrd){
            bootbox.alert("<fmt:message key="label.title.confirm"/>", "<fmt:message key="message.chooseAtLeastOne"/>");
        } else if(!hasDate){
            bootbox.alert("<fmt:message key="label.title.confirm"/>", "<fmt:message key="message.chooseDeliveryDate"/>");
        }
    }

    function printShippingBill(billId){
        <%--window.location.href = "<c:url value='/ajax/printShippingBill.html?bookProductBillId='/>" + billId;--%>
        document.getElementById("printout").src = "<c:url value='/ajax/printShippingBill.html?bookProductBillId='/>" + billId;
    }
    function printShippingConfirmBill(billId){
        <%--window.location.href = "<c:url value='/ajax/printShippingConfirmBill.html?bookProductBillId='/>" + billId;--%>
        document.getElementById("printout").src = "<c:url value='/ajax/printShippingConfirmBill.html?bookProductBillId='/>" + billId;
    }
</script>