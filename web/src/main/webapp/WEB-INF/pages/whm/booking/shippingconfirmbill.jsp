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
            <td>Tel: (84.64) 3922.762    ****    Fax: (84.64) 3922.765</td>
        </tr>
        <tr style="font-weight: bold;">
            <td>Số tài khoản: 0421.00.383.0445 tại Ngân hàng Vietcombank - CN Phú Thọ - TP.HCM</td>
        </tr>
    </table>
</div>
<hr>
<div class="clear"></div>
<div class="customer-info">
    <table>
        <tr>
            <td colspan="2">TP.HCM, ngày</td>
        </tr>
        <tr>
            <td colspan="2">
                BẢNG XÁC NHẬN ĐƠN HÀNG <c:if test="${owe != 0}"> - CÔNG NỢ</c:if>
            </td>
        </tr>
        <tr>
            <td colspan="2">Số:......./${year}/.......(${customer})</td>
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
            <td colspan="2">Bên A đồng ý bán và Bên B đồng ý mua:</td>
        </tr>
        <tr>
            <td colspan="2">1. Bảng kê chi tiết hàng như sau:</td>
        </tr>
    </table>
</div>
<div class="clear"></div>
<div class="product-info">
    <table class="tableSadlier">
        <tr>
            <td>Stt</td>
            <td colspan="2">Tên hàng - Quy cách</td>
            <td>MS - SP</td>
            <td>Mã số</td>
            <td>Tr.Lượng</td>
            <td>S.Lượng</td>
            <td>Đ.Giá</td>
            <td>Thành tiền</td>
            <td>Kg/m</td>
        </tr>
        <c:set var="totalKg" value="0"/>
        <c:set var="totalM" value="0"/>
        <c:set var="totalMoney" value="0"/>
        <c:forEach items="${bookProducts}" var="bookProduct" varStatus="status">
            <c:set var="product" value="${bookProduct.importProduct}"/>
            <c:set var="kgm" value="${product.quantity2Pure / product.quantity1}"/>
            <c:set var="isCold" value="${product.productname.code eq Constants.PRODUCT_LANH ? true : false}"/>

            <tr>
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
                                <%--<c:set var="kgQuantity" value="${productQuality.quantity1 * kgm - saleQuantity}"/>--%>
                                <fmt:formatNumber var="kgQuantity" value="${productQuality.quantity1 * kgm - saleQuantity}" groupingUsed="false" maxFractionDigits="0"/>
                                <fmt:formatNumber var="kgQuantityOthersRounded" value="${kgQuantity}" pattern="######"/>
                                <c:set var="price" value="${productQuality.price}"/>
                                <c:set var="salePrice" value="${productQuality.salePrice}"/>
                            </c:if>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
                <td><fmt:formatNumber value="${kgQuantity}" pattern="###,###"/></td>
                <td>
                    <fmt:formatNumber value="${quantity}" pattern="###,###"/>
                </td>
                <td><fmt:formatNumber value="${price}" pattern="###,###"/></td>
                <td><fmt:formatNumber value="${isCold ? price * kgQuantity : price * quantity}" pattern="###,###"/></td>
                <c:set var="totalMoney" value="${isCold ? totalMoney + price * kgQuantity : totalMoney + price * quantity}"/>
                <td><fmt:formatNumber value="${kgm}" pattern="###,###.##"/></td>
            </tr>
            <%--<c:if test="${!empty saleQuantity && saleQuantity != 0}">--%>
                <%--<tr>--%>
                    <%--<td></td>--%>
                    <%--<td></td>--%>
                    <%--<td></td>--%>
                    <%--<td></td>--%>
                    <%--<td></td>--%>
                    <%--<td></td>--%>
                    <%--<td><fmt:formatNumber value="${saleQuantity}" pattern="###,###" maxFractionDigits="2" minFractionDigits="0"/></td>--%>
                    <%--<td><fmt:formatNumber value="${salePrice}" pattern="###,###" maxFractionDigits="2" minFractionDigits="0"/></td>--%>
                    <%--<td><fmt:formatNumber value="${salePrice * saleQuantity}" pattern="###,###"/></td>--%>
                    <%--<c:set var="totalMoney" value="${totalMoney + salePrice * saleQuantity}"/>--%>
                    <%--<td></td>--%>
                <%--</tr>--%>
            <%--</c:if>--%>
            <c:if test="${fn:length(product.productqualitys) > 1}">
                <c:forEach items="${product.productqualitys}" var="productQuality" varStatus="status">
                    <c:if test="${productQuality.quality.code ne Constants.QUALITY_A && productQuality.quantity1 > 0}">
                        <tr>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td style="font-style: italic;font-weight: bold">
                            <%--@TODO remove only show Kg for Cold--%>
                                <c:if test="${status.index != fn:length(product.productqualitys) - 1}">
                                    <%--<c:if test="${isCold}">--%>
                                    <fmt:formatNumber value="${productQuality.quantity1 * kgm - productQuality.saleQuantity}" pattern="###,###"/>
                                    <%--</c:if>--%>
                                    <fmt:formatNumber var="kgQuantityOthersRounded" value="${kgQuantityOthersRounded + productQuality.quantity1 * kgm - productQuality.saleQuantity}" pattern="######"/>
                                </c:if>
                                <c:if test="${status.index == fn:length(product.productqualitys) - 1}">
                                    <%--<c:if test="${isCold}">--%>
                                    <fmt:formatNumber value="${product.quantity2Pure - kgQuantityOthersRounded - productQuality.saleQuantity}" pattern="###,###"/>
                                    <%--</c:if>--%>
                                </c:if>
                            </td>
                            <td style="font-style: italic;font-weight: bold">
                                <fmt:formatNumber value="${productQuality.quantity1 - productQuality.saleQuantity}" pattern="###,###"/>m${productQuality.quality.name}
                            </td>
                            <td><fmt:formatNumber value="${productQuality.price}" pattern="###,###"/></td>
                            <td>
                                <c:set var="tempMoney" value="0"/>
                                <c:if test="${isCold}">
                                    <fmt:formatNumber var="kgQuantity" value="${productQuality.quantity1 * kgm - productQuality.saleQuantity}" groupingUsed="false" maxFractionDigits="0"/>
                                    <c:set var="tempMoney" value="${productQuality.price * kgQuantity}"/>
                                </c:if>
                                <c:if test="${!isCold}">
                                    <c:set var="tempMoney" value="${productQuality.price * (productQuality.quantity1 - productQuality.saleQuantity)}"/>
                                </c:if>
                                <fmt:formatNumber value="${tempMoney}" pattern="###,###"/>
                            </td>
                            <c:set var="totalMoney" value="${totalMoney + tempMoney}"/>
                            <td></td>
                        </tr>
                        <%--<c:if test="${!empty productQuality.saleQuantity}">--%>
                            <%--<tr class="sale-info">--%>
                                <%--<td></td>--%>
                                <%--<td></td>--%>
                                <%--<td></td>--%>
                                <%--<td></td>--%>
                                <%--<td></td>--%>
                                <%--<td></td>--%>
                                <%--<td>--%>
                                    <%--<fmt:formatNumber value="${productQuality.saleQuantity}" pattern="###,###" maxFractionDigits="2" minFractionDigits="0"/>--%>
                                <%--</td>--%>
                                <%--<td>--%>
                                    <%--<fmt:formatNumber value="${productQuality.salePrice}" pattern="###,###" maxFractionDigits="2" minFractionDigits="0"/>--%>
                                <%--</td>--%>
                                <%--<td><fmt:formatNumber value="${productQuality.saleQuantity * productQuality.salePrice}" pattern="###,###"/></td>--%>
                                <%--<c:set var="totalMoney" value="${totalMoney + productQuality.salePrice * productQuality.saleQuantity}"/>--%>
                                <%--<td></td>--%>
                            <%--</tr>--%>
                        <%--</c:if>--%>
                    </c:if>
                </c:forEach>
            </c:if>
            <c:set var="totalKg" value="${totalKg + product.quantity2Pure}"/>
            <c:set var="totalM" value="${totalM + product.quantity1}"/>
        </c:forEach>
        <tr>
            <td colspan="2">Tổng cộng</td>
            <td></td>
            <td></td>
            <td></td>
            <td><fmt:formatNumber value="${totalKg}" pattern="###,###"/></td>
            <td><fmt:formatNumber value="${totalM}" pattern="###,###"/></td>
            <td></td>
            <td><fmt:formatNumber value="${totalMoney}" pattern="###,###"/></td>
            <td></td>
        </tr>
    </table>
</div>
<div class="clear"></div>

<div class="note-info">
    <table>
        <tr>
            <td colspan="5">
                <u>Ghi chú:</u> Bảng xác nhận này có giá trị đến hết ngày:....../....../ ${year}. Giá bán đã bao gồm thuế VAT 10%.
            </td>
        </tr>
        <tr>
            <td colspan="5" style="font-weight: bold">2. Tình hình công nợ:</td>
        </tr>
        <tr>
            <td style="width: 25%;">- Tính đến ngày:</td>
            <td style="width: 20%;font-weight: bold">${utilDate}</td>
            <c:if test="${owe != 0}">
                <td style="width: 25%;">Tiền khách hàng còn nợ:</td>
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
            <td>- Giá trị đơn hàng nêu trên:</td>
            <td colspan="2"></td>
            <td style="text-align: right;padding-right:20px;"><fmt:formatNumber value="${totalMoney}" pattern="###,###"/></td>
            <td>đồng.</td>
        </tr>
        <c:if test="${transportFee > 0}">
            <tr>
                <td colspan="2">- Trừ CP vận chuyển tại: ${noinhan}</td>
                <td style="font-weight: bold">Ngày: <fmt:formatDate value="${deliveryDate}" pattern="dd/MM/yyyy"/></td>
                <td style="text-align: right;padding-right:20px;">(<fmt:formatNumber value="${transportFee}" pattern="###,###"/>)</td>
                <td>đồng.</td>
            </tr>
        </c:if>
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
            <td colspan="3">- Tổng cộng:</td>
            <td style="font-weight: bold"><div style="width: 120px; border-bottom: solid 1px black;text-align: right;padding-right:20px;"><fmt:formatNumber value="${sumAll}" pattern="###,###"/></div></td>
            <td>đồng.</td>
        </tr>
        <tr style="font-style: italic">
            <td colspan="5"><b>Bằng chữ:</b> ${tpk:numberInWord(sumAll)}</td>
        </tr>
        <tr>
            <td colspan="5" style="font-weight: bold">3. Thời gian - địa điểm giao,nhận hàng:</td>
        </tr>
        <tr>
            <td colspan="2">- Ngày nhận hàng:......./......./ ${year}</td>
            <td>- Địa điểm nhận hàng:</td>
            <td colspan="2">..........................................</td>
        </tr>
        <tr>
            <td colspan="2">- Người nhận hàng:.............................</td>
            <td>- Số xe:</td>
            <td colspan="2">..........................................</td>
        </tr>
        <tr>
            <td colspan="5" style="font-weight: bold">4. Điều kiện thanh toán: Tiền mặt hoặc chuyển khoản</td>
        </tr>
        <tr>
            <td colspan="5">Ngày:.................................. Thanh toán số tiền:............................ đồng.</td>
        </tr>
        <tr>
            <td colspan="5">Ngày:.................................. Thanh toán dứt điểm.</td>
        </tr>
        <tr>
            <td colspan="5">5. Mọi thông tin chi tiết vui lòng liên hệ Phòng kinh doanh:</td>
        </tr>
        <tr>
            <td colspan="5">- SĐT: 08.3864.1836 / 3866.3514 *** Fax: 08.3864.5265 - Hotline: 0909.300.303 / 0909.909.055</td>
        </tr>
        <tr>
            <td colspan="5">* Chữ ký trên bản fax đều có giá trị như bản gốc; Khách hàng có thể thay đổi độ dày, nhưng KHÔNG hủy đơn hàng khi đã ký xác nhận.</td>
        </tr>
        <tr>
            <td colspan="5">** Sau 03 ngày kể từ ngày gởi bảng xác nhận đơn hàng - công nợ này,
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
    <table class="tableSadlier">
        <tr>
            <td>CTY TÔN TÂN PHƯỚC KHANH</td>
            <td>TP.KINH DOANH</td>
            <td>NV BÁN HÀNG</td>
            <td>XÁC NHẬN KHÁCH HÀNG</td>
        </tr>
        <tr>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
        </tr>
        <tr>
            <td>Nguyễn Thị Tuyết</td>
            <td></td>
            <td>${user.fullname}<br>HP: ${user.phone}</td>
            <td></td>
        </tr>
    </table>
</div>

<div class="ad-info">
    Quý khách mua sản phẩm TPK là đồng hành cùng Chúng tôi trong chương trình <b>"Khát vọng sống"</b> <br>
    <b>Website:</b> <i>www.khatvongsong.uniad.com.vn</i>
</div>
</div>
<div class="clear"></div>
</body>
</html>