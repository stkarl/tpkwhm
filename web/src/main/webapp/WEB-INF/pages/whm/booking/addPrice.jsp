<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" errorPage="/error.jsp" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@page import="com.banvien.tpk.core.Constants" %>

<head>
    <title><fmt:message key="booking.bill.add.price.title"/></title>
    <meta name="heading" content="<fmt:message key="booking.bill.add.price.title"/>"/>
    <link rel="stylesheet" href="<c:url value='/themes/whm/css/jquery.jscrollpane.css' />" />
    <style>
        table.tbHskt .table_header{
            text-align: left;
            padding: 4px 2px 4px 5px;
        }
    </style>
</head>

<c:url var="url" value="/whm/booking/addPrice.html"/>
<c:url var="backUrl" value="/whm/booking/list.html"/>

<form:form commandName="item" action="${url}" method="post" id="itemForm" class="form-horizontal" novalidate="novalidate">
    <div id="container-fluid data_content_box">
        <div class="row-fluid data_content">
            <div class="content-header"><fmt:message key="booking.bill.add.price.title"/></div>
            <div class="clear"></div>
            <div id="generalInfor">
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
                </table>
            </div>
            <div class="clear"></div>
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
            <c:if test="${not empty item.pojo.bookProducts}">
                <div class="product-info">
                    <table class="tableSadlier table-hover">
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
                            <%--<th class="table_header_center"></th>--%>
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
                                <td>${product.productCode}</td>
                                <c:set var="price" value="0"/>
                                <c:set var="quantity" value="0"/>
                                <c:set var="saleQuantity" value="0"/>
                                <c:set var="kgQuantity" value="0"/>
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
                                                <input type="hidden" name="suggestedItems[${counter - 1}].qualityID" value="${productQuality.quality.qualityID}"/>
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
                                    <input style="width:80px;" code="${product.productname.code}" id="price-${product.importProductID}_A" name="suggestedItems[${counter - 1}].price" value="<fmt:formatNumber value="${price}" pattern="###,###" maxFractionDigits="2" minFractionDigits="0"/>" type="text" class="inputFractionNumber width2" onblur="calMoney(this);"/>
                                    <input type="hidden" name="suggestedItems[${counter - 1}].itemID" value="${product.importProductID}"/>
                                </td>
                                <td id="money-${product.importProductID}_A" class="money"></td>
                                <td><fmt:formatNumber value="${kgm}" pattern="###,###.##"/></td>
                                <%--<td>--%>
                                    <%--<a onclick="addSale(this);" index="${counter - 1}" product="${product.importProductID}" quality="A" class="${!empty saleQuantity && saleQuantity != 0 ? 'icon-minus' : 'icon-plus'} tip-top" title="<fmt:message key="${!empty saleQuantity && saleQuantity != 0 ? 'remove.sale' : 'add.sale'}"/>"></a>--%>
                                <%--</td>--%>
                            </tr>
                            <%--@TODO reivse sale if re-use later--%>
                            <%--<tr id="sale-row-${counter - 1}" class="sale-info ${!empty saleQuantity && saleQuantity != 0 ? '' : 'hide'}">--%>
                                <%--<td colspan="6"><fmt:message key="sale.info"/></td>--%>
                                <%--<td style="text-align: center;"><input value="<fmt:formatNumber value="${saleQuantity}" pattern="###,###" maxFractionDigits="2" minFractionDigits="0"/>" style="width:80px;" id="quantitySale-${product.importProductID}_A" class="inputNumber" type="text" name="suggestedItems[${counter - 1}].saleQuantity" onblur="balanceQuantity(this);"/></td>--%>
                                <%--<td style="text-align: center;"><input value="<fmt:formatNumber value="${salePrice}" pattern="###,###" maxFractionDigits="2" minFractionDigits="0"/>" style="width:80px;" id="priceSale-${product.importProductID}_A" class="inputFractionNumber" type="text" name="suggestedItems[${counter - 1}].salePrice" onblur="calSaleMoney(this);"/></td>--%>
                                <%--<td id="moneySale-${product.importProductID}_A" class="money"></td>--%>
                                <%--<td></td>--%>
                                <%--&lt;%&ndash;<td></td>&ndash;%&gt;--%>
                            <%--</tr>--%>
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
                                            <td>
                                            <%--@TODO remove only show Kg for Cold--%>
                                                <c:if test="${status.index != fn:length(product.productqualitys) - 1}">
                                                    <%--<c:if test="${isCold}">--%>
                                                <span id="kg-product-${product.importProductID}_${productQuality.quality.name}" quantity="${productQuality.quantity1 * kgm}" quality="${productQuality.quality.name}">
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
                                                <span id="product-${product.importProductID}_${productQuality.quality.name}" quantity="${productQuality.quantity1}" quality="${productQuality.quality.name}">
                                                    <fmt:formatNumber value="${productQuality.quantity1 - productQuality.saleQuantity}" pattern="###,###"/>m${productQuality.quality.name}
                                                </span>
                                            </td>
                                            <td>
                                                <input style="width:80px;" code="${product.productname.code}" id="price-${product.importProductID}_${productQuality.quality.name}" name="suggestedItems[${counter - 1}].price" value="<fmt:formatNumber value="${productQuality.price}" pattern="###,###" maxFractionDigits="2" minFractionDigits="0"/>" type="text" class="inputFractionNumber width2" onblur="calMoney(this);"/>
                                                <input type="hidden" name="suggestedItems[${counter - 1}].itemID" value="${product.importProductID}"/>
                                                <input type="hidden" name="suggestedItems[${counter - 1}].qualityID" value="${productQuality.quality.qualityID}"/>
                                            </td>
                                            <td id="money-${product.importProductID}_${productQuality.quality.name}" class="money"></td>
                                            <td></td>
                                            <%--<td>--%>
                                                <%--<a onclick="addSale(this);" index="${counter - 1}" product="${product.importProductID}" quality="${productQuality.quality.name}" class="${!empty productQuality.saleQuantity && productQuality.saleQuantity != 0 ? 'icon-minus' : 'icon-plus'} tip-top" title="<fmt:message key="${!empty productQuality.saleQuantity && productQuality.saleQuantity != 0 ? 'remove.sale' : 'add.sale'}"/>"></a>--%>
                                            <%--</td>--%>
                                        </tr>
                                        <%--<tr id="sale-row-${counter - 1}" class="sale-info ${!empty productQuality.saleQuantity && productQuality.saleQuantity != 0 ? '' : 'hide'}">--%>
                                            <%--<td colspan="6"><fmt:message key="sale.info"/></td>--%>
                                            <%--<td style="text-align: center;"><input value="<fmt:formatNumber value="${productQuality.saleQuantity}" pattern="###,###"/>" style="width:80px;" id="quantitySale-${product.importProductID}_${productQuality.quality.name}" class="inputNumber" type="text" name="suggestedItems[${counter - 1}].saleQuantity" onblur="balanceQuantity(this);"/></td>--%>
                                            <%--<td style="text-align: center;"><input value="<fmt:formatNumber value="${productQuality.salePrice}" pattern="###,###" maxFractionDigits="2" minFractionDigits="0"/>" style="width:80px;" id="priceSale-${product.importProductID}_${productQuality.quality.name}" class="inputFractionNumber" type="text" name="suggestedItems[${counter - 1}].salePrice" onblur="calSaleMoney(this);"/></td>--%>
                                            <%--<td id="moneySale-${product.importProductID}_${productQuality.quality.name}" class="money"></td>--%>
                                            <%--<td></td>--%>
                                            <%--&lt;%&ndash;<td></td>&ndash;%&gt;--%>
                                        <%--</tr>--%>
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
                            <%--<td></td>--%>
                        </tr>
                    </table>
                </div>
            </c:if>
            <div style="clear:both"></div>

            <div id="reduce-transport">
                <table class="tbHskt info">
                    <caption><fmt:message key="transport.reduce.if.any"/></caption>
                    <tr>
                        <th class="table_header" style="width: 50%;">Địa điểm nhận</th>
                        <th class="table_header" style="width: 20%;">Định mức (VNĐ/kg)</th>
                        <th class="table_header" style="width: 30%;">Thành tiền</th>
                    </tr>
                    <tr>
                        <td><form:input path="pojo.destination" type="text" cssStyle="width: 480px;text-transform: none"/></td>
                        <td><form:input path="pojo.reduceCost" type="text" class="inputNumber" onblur="calTransport(this.value);"/></td>
                        <td><span id="transport"><fmt:formatNumber value="${item.pojo.reduce}" pattern="###,###"/> </span><form:hidden path="pojo.reduce" id="reduce"/></td>
                    </tr>
                </table>
            </div>
            <div class="clear"></div>

            <div class="controls">
                <c:if test="${item.pojo.status == Constants.BOOK_WAIT_CONFIRM || item.pojo.status == Constants.BOOK_REJECTED}">
                        <a onclick="savePrice()" class="btn btn-success" style="cursor: pointer;">
                            <i class="icon-save"></i> <fmt:message key="button.save"/>
                        </a>
                </c:if>

                <form:hidden path="crudaction" id="crudaction" value="insert-update"/>
                    <form:hidden path="pojo.bookProductBillID"/>
                    <a href="${backUrl}" class="cancel-link">
                        <fmt:message key="button.cancel"/>
                    </a>
            </div>
            <input type="hidden" name="totalMoney" id="totalMoney"/>
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

    function calTransport(val){
        var kg = ${totalKg};
        var money = val != '' ? numeral().unformat(val) : 0;
        $('#transport').text(numeral(kg * money).format('###,###'));
        $('#reduce').val(kg * money);
    }

    function initCalMoney(){
        var total = 0;
        $("input[id^='price-']").each(function(){
            var price = $(this).val() != '' ? numeral().unformat($(this).val()) : 0;
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

        $("input[id^='priceSale-']").each(function(){
            var price = $(this).val() != '' ? numeral().unformat($(this).val()) : 0;
            var id = $(this).attr('id').split('-')[1];
            var quantity = $.trim($('#quantitySale-' + id).val());
            quantity = quantity != '' ? numeral().unformat(quantity) : 0;
            total += price * quantity;
            $('#moneySale-' + id).html(numeral(parseFloat(price * quantity)).format('###,###'));
        });

        $('#total').html(numeral(total).format('###,###'));
        $('#totalMoney').val(total);
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
    $("#crudaction").val("insert-update");    
    $("#itemForm").submit();
}


    function printShippingBill(billId){
        <%--window.location.href = "<c:url value='/ajax/printShippingBill.html?bookProductBillId='/>" + billId;--%>
        document.getElementById("printout").src = "<c:url value='/ajax/printShippingBill.html?bookProductBillId='/>" + billId;
    }
    function printShippingConfirmBill(billId){
        <%--window.location.href = "<c:url value='/ajax/printShippingConfirmBill.html?bookProductBillId='/>" + billId;--%>
        document.getElementById("printout").src = "<c:url value='/ajax/printShippingConfirmBill.html?bookProductBillId='/>" + billId;
    }

    function savePrice(){
        $("#crudaction").val("insert-update");
        unformatNumber();
        $("#itemForm").submit();
    }

    function unformatNumber(){
        $('.inputFractionNumber').each(function(){
            if($(this).val() != '' && $(this).val() != 0 ) {
                $(this).val(numeral().unformat($(this).val()));
            }
        });
        $('.inputNumber').each(function(){
            if($(this).val() != '' && $(this).val() != 0 ) {
                $(this).val(numeral().unformat($(this).val()));
            }
        });
    }

    function calMoney(ele){
        var price = $(ele).val() != '' ? numeral().unformat($(ele).val()) : 0;
        var productCode = $(ele).attr('code');
        var id = $(ele).attr('id').split('-')[1];
        var quantity;
        if(productCode != '${Constants.PRODUCT_LANH}'){
            var quantity = $.trim($('#product-' + id).text());
            if(quantity != '' && quantity.split('m').length > 0){
                quantity = quantity.split('m')[0];
            }
        }else{
            var quantity = $.trim($('#kg-product-' + id).text());
            if(quantity != '' && quantity.split('kg').length > 0){
                quantity = quantity.split('kg')[0];
            }
        }
        quantity = quantity != '' ? numeral().unformat(quantity) : 0;
        $('#money-' + id).html(numeral(parseFloat(price * quantity)).format('###,###'));
        calTotalMoney();
    }

    function calSaleMoney(ele){
        var price = $(ele).val() != '' ? numeral().unformat($(ele).val()) : 0;
        var id = $(ele).attr('id').split('-')[1];
        var quantity = $.trim($('#quantitySale-' + id).val());
        quantity = quantity != '' ? numeral().unformat(quantity) : 0;
        $('#moneySale-' + id).html(numeral(parseFloat(price * quantity)).format('###,###'));
        calTotalMoney();
    }

    function calTotalMoney(){
        var total = 0;
        var temp = 0;
        $('.money').each(function(){
            temp = $.trim($(this).html()) != '' ? numeral().unformat($(this).html()) : 0;
            total += temp;
        });
        $('#total').html(numeral(total).format('###,###'));
        $('#totalMoney').val(total);
    }

    function addSale(ele){
        var index = $(ele).attr('index');
        var product = $(ele).attr('product');
        var quality = $(ele).attr('quality');
        if($(ele).hasClass('icon-plus')){
            $('#sale-row-' + index).show();
            $(ele).removeClass('icon-plus');
            $(ele).addClass('icon-minus');
            $(ele).attr('data-original-title','<fmt:message key="remove.sale"/>');

        }else{
            $('#sale-row-' + index).hide();
            $(ele).removeClass('icon-minus');
            $(ele).addClass('icon-plus');
            $(ele).attr('data-original-title','<fmt:message key="add.sale"/>');

            $('#priceSale-' + product + '_' + quality).val('');
            $('#quantitySale-' + product + '_' + quality).val('');
            balanceQuantity($('#quantitySale-' + product + '_' + quality));
        }

    }

    function balanceQuantity(ele){
        var id = $(ele).attr('id').split('-')[1];
        var origin = $('#product-' + id);
        var quality = origin.attr('quality') != undefined ? 'm' + origin.attr('quality') : '';
        var saleQuantity = $(ele).val() != '' ? numeral().unformat($(ele).val()) : 0;
        var totalQuantity = numeral().unformat(origin.attr('quantity'));
        if(saleQuantity <= totalQuantity){
            var remainQuantity = totalQuantity - saleQuantity;
            origin.text(numeral(remainQuantity).format('###,###') + quality);
            calMoney($('#price-' + id));
            calSaleMoney($('#priceSale-' + id));
        }else{
            $(ele).val('');
            origin.text(numeral(totalQuantity).format('###,###') + quality);
            calMoney($('#price-' + id));
        }

    }
</script>