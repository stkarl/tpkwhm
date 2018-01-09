<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" errorPage="/error.jsp" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" media="all" href="<c:url value='/themes/whm/css/print_ship_confirm_bill_v1.1.css'/>" />
</head>
<body onload='window.focus(); self.print();'>
<%--<body>--%>
<div class="company-title">
    <table style="text-align: center;">
        <tr>
            <td rowspan="4" style="width: 50px;"><img src="/images/printlogoiso.png" style="width:50px;height: 58px; margin-right: 12px;"/></td>
            <td style="font-weight: bold;">CÔNG TY CỔ PHẦN THƯƠNG MẠI & SẢN XUẤT TÔN TÂN PHƯỚC KHANH</td>
        </tr>
        <tr>
            <td>Khu Công Nghiệp Phú Mỹ I - Huyện Tân Thành - Tỉnh Bà Rịa Vũng Tàu</td>
        </tr>
        <tr>
            <td>Tel: (84.254) 3922.762    ****    Fax: (84.254) 3922.765</td>
        </tr>
    </table>
</div>
<hr>
<div class="clear"></div>
<div class="customer-info">
    <table>
        <tr>
            <td colspan="2">TP.HCM, ngày &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;...../...../ ${year}</td>
        </tr>
        <tr>
            <td colspan="2">
                BẢNG XÁC NHẬN CÔNG NỢ
            </td>
        </tr>
        <tr>
            <td colspan="2">Số:......./KH/....../....../....../${year}(${customer})</td>
        </tr>
        <tr>
            <td><u><i>Kính gởi</i></u>: ${company}</td>
            <td>- Người liên hệ: ${contact}</td>
        </tr>
        <tr>
            <td>Địa chỉ: ${customerAddress}</td>
            <td>- SĐT: ${contactPhone}</td>
        </tr>
        <tr>
            <td colspan="2">Điện thoại: ${customerTelFax}</td>
        </tr>
        <tr>
            <td colspan="2" style="font-weight: normal;">Căn cứ vào Bảng Xác Nhận Đơn Hàng, Công Ty CP TM & SX Tôn Tân Phước Khanh gửi đến Quý Khách hàng đối chiếu xác nhận công nợ như sau:</td>
        </tr>
        <tr><td colspan="2">&nbsp;</td></tr>
    </table>
</div>
<div class="clear"></div>

<div class="note-info">
    <table>
        <tr>
            <td colspan="5" style="font-style: normal;">1. <u>Tình hình công nợ:</u></td>
        </tr>
        <tr>
            <td style="width: 25%;font-weight: bold">Công nợ (nợ cũ) đến ngày:</td>
            <td style="width: 20%;font-weight: bold">${utilDate}</td>
            <c:if test="${owe != 0}">
                <td style="width: 25%;"></td>
                <td style="width: 20%;text-align: right;padding-right:20px;"><fmt:formatNumber value="${owe}" pattern="###,###"/></td>
                <td style="width: 10%;">đồng.</td>
            </c:if>
            <c:if test="${owe == 0}">
                <td style="width: 25%;"></td>
                <td style="width: 20%;"></td>
                <td style="width: 10%;"></td>
            </c:if>

        </tr>
        <tr>
            <c:set var="totalMoney" value="0"/>
            <c:forEach items="${bookProducts}" var="bookProduct" varStatus="status">
                <c:set var="product" value="${bookProduct.importProduct}"/>
                <c:set var="kgm" value="${product.quantity2Pure / product.quantity1}"/>
                <c:set var="saleByKg" value="${product.productname.code eq Constants.PRODUCT_LANH || !oldFormula  ? true : false}"/>
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
                                <fmt:formatNumber var="kgQuantity" value="${productQuality.quantity1 * kgm - saleQuantity}" groupingUsed="false" maxFractionDigits="0"/>
                                <fmt:formatNumber var="kgQuantityOthersRounded" value="${kgQuantity}" pattern="######"/>
                                <c:set var="price" value="${productQuality.price}"/>
                                <c:set var="salePrice" value="${productQuality.salePrice}"/>
                            </c:if>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
                <c:set var="totalMoney" value="${saleByKg ? totalMoney + price * kgQuantity : totalMoney + price * quantity}"/>
                <c:if test="${fn:length(product.productqualitys) > 1}">
                    <c:forEach items="${product.productqualitys}" var="productQuality" varStatus="status">
                        <c:if test="${productQuality.quality.code ne Constants.QUALITY_A && productQuality.quantity1 > 0}">
                                    <c:set var="tempMoney" value="0"/>
                                    <c:if test="${saleByKg}">
                                        <fmt:formatNumber var="kgQuantity" value="${productQuality.quantity1 * kgm - productQuality.saleQuantity}" groupingUsed="false" maxFractionDigits="0"/>
                                        <c:set var="tempMoney" value="${productQuality.price * kgQuantity}"/>
                                    </c:if>
                                    <c:if test="${!saleByKg}">
                                        <c:set var="tempMoney" value="${productQuality.price * (productQuality.quantity1 - productQuality.saleQuantity)}"/>
                                    </c:if>
                                <c:set var="totalMoney" value="${totalMoney + tempMoney}"/>
                        </c:if>
                    </c:forEach>
                </c:if>
            </c:forEach>
            <td colspan="3">-Quý khách mua hàng đợt này(đính kèm bảng xác nhận đơn hàng)</td>
            <td style="text-align: right;padding-right:20px;"><fmt:formatNumber value="${totalMoney - transportFee}" pattern="###,###"/></td>
            <td>đồng.</td>
        </tr>
        <c:set var="totalSale" value="0"/>
        <c:if test="${!empty bookSales && fn:length(bookSales) > 0}">
            <c:forEach items="${bookSales}" var="sale">
                <tr>
                    <td colspan="2">- ${sale.saleReason.reason}</td>
                    <td style="font-weight: bold">
                        <c:if test="${!empty sale.date}">
                            Ngày: <fmt:formatDate value="${sale.date}" pattern="dd/MM/yyyy"/>
                        </c:if>
                    </td>
                    <td style="text-align: right;padding-right:20px;">(<fmt:formatNumber value="${sale.money}" pattern="###,###"/>)</td>
                    <td>đồng.</td>
                </tr>
                <c:set var="totalSale" value="${totalSale + sale.money}"/>
            </c:forEach>
        </c:if>
        <c:set var="totalPaid" value="0"/>
        <c:if test="${!empty prePaids && fn:length(prePaids) > 0}">
            <c:forEach items="${prePaids}" var="prePaid">
                <tr>
                    <td colspan="2">- ${prePaid.note}</td>
                    <td style="font-weight: bold">
                        <c:if test="${!empty prePaid.payDate}">
                            Ngày: <fmt:formatDate value="${prePaid.payDate}" pattern="dd/MM/yyyy"/>
                        </c:if>
                    </td>
                    <td style="text-align: right;padding-right:20px;">(<fmt:formatNumber value="${prePaid.pay}" pattern="###,###"/>)</td>
                    <td>đồng.</td>
                </tr>
                <c:set var="totalPaid" value="${totalPaid + prePaid.pay}"/>
            </c:forEach>
        </c:if>
        <c:set var="sumAll" value="${owe + totalMoney - transportFee - totalSale - totalPaid}"/>
        <tr>
            <td colspan="3" style="font-weight: bold;">Tính đến ngày......./......./ ${year}, Quý khách còn nợ số tiền</td>
            <td style="font-weight: bold"><div style="width: 120px; border-bottom: solid 1px black;text-align: right;padding-right:20px;"><fmt:formatNumber value="${sumAll}" pattern="###,###"/></div></td>
            <td>đồng.</td>
        </tr>
        <tr style="font-style: italic">
            <td colspan="5">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>Bằng chữ:</b> ${tpk:numberInWord(sumAll)}</td>
        </tr>
        <tr>
            <td colspan="5" style="font-weight: bold">&nbsp;</td>
        </tr>
        <tr>
            <td colspan="5" style="font-weight: bold">2. Thông tin chuyển khoản</td>
        </tr>
        <tr>
            <td colspan="5" style="font-weight: bold"><span>${bankAccount}</span></td>
        </tr>
        <tr>
            <td colspan="5" style="font-weight: bold">&nbsp;</td>
        </tr>

        <tr>
            <td colspan="5" style="font-weight: bold">3. <u>Mọi thông tin chi tiết vui lòng liên hệ Phòng kinh doanh:</u></td>
        </tr>
        <tr>
            <td colspan="5" style="font-weight: normal;">- SĐT: <b>028.3864.1836 / 3866.3514</b> *** Fax: <b>028.3864.5265</b> - <i>Hotline:</i> 0909.300.303 / 0909.909.055</td>
        </tr>
        <tr>
            <td colspan="5" style="font-weight: normal; font-style: italic;">** Sau 03 ngày kể từ ngày gởi bảng xác nhận đơn hàng - công nợ này,
                Cty chúng tôi chưa nhận được sự phản hồi từ Quý khách, thì số công nợ trên được xem là đúng.
            </td>
        </tr>
        <tr>
            <td colspan="5"></td>
        </tr>
    </table>
</div>
<div class="last-div">
<div class="sign-info">
    <table>
        <tr>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
        </tr>
        <tr>
            <td>Xác Nhận Của Khách Hàng</td>
            <td></td>
            <td>Người lập</td>
            <td>Cty Tôn Tân Phước Khanh</td>
        </tr>
        <tr>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
        </tr>
        <tr>
            <td></td>
            <td></td>
            <td></td>
            <td>Nguyễn Thị Tuyết</td>
        </tr>
    </table>
</div>
</div>
<div class="clear"></div>
</body>
</html>