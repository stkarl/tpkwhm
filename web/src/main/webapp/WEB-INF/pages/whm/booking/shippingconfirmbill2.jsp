<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" errorPage="/error.jsp" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" media="all" href="<c:url value='/themes/whm/css/print_ship_confirm_bill_v1.3.css'/>" />
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
        <tr style="font-weight: bold;">
            <td>${bankAccountShort}</td>
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
                BẢNG XÁC NHẬN ĐƠN HÀNG
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
            <td colspan="2" class="font-10"><i>Bên A đồng ý bán và Bên B đồng ý mua:</i></td>
        </tr>
        <tr>
            <td colspan="2"><u>1. Bảng kê chi tiết hàng như sau:</u></td>
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
            <c:set var="saleByKg" value="${product.productname.code eq Constants.PRODUCT_LANH || !oldFormula  ? true : false}"/>

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
                        <c:set var="priceTypeA" value="0"/>
                        <c:set var="priceTypeAB" value="false"/>
                        <c:forEach items="${product.productqualitys}" var="productQuality">
                            <c:if test="${productQuality.quality.code eq Constants.QUALITY_A}">
                                <c:set var="saleQuantity" value="${productQuality.saleQuantity}"/>
                                <c:set var="quantity" value="${productQuality.quantity1 - saleQuantity}"/>
                                <fmt:formatNumber var="kgQuantity" value="${productQuality.quantity1 * kgm - saleQuantity}" groupingUsed="false" maxFractionDigits="0"/>
                                <fmt:formatNumber var="kgQuantityOthersRounded" value="${kgQuantity}" pattern="######"/>
                                <c:set var="price" value="${productQuality.price}"/>
                                <c:set var="salePrice" value="${productQuality.salePrice}"/>
                                <c:set var="priceTypeA" value="${productQuality.price}"/>
                            </c:if>
                        </c:forEach>
                        <c:forEach items="${product.productqualitys}" var="productQuality">
                            <c:if test="${productQuality.quality.code eq Constants.QUALITY_B && productQuality.price eq priceTypeA}">
                                <c:set var="saleQuantity" value="${productQuality.saleQuantity}"/>
                                <c:set var="quantity" value="${quantity + productQuality.quantity1 - saleQuantity}"/>
                                <fmt:formatNumber var="kgQuantity" value="${kgQuantity + productQuality.quantity1 * kgm - saleQuantity}" groupingUsed="false" maxFractionDigits="0"/>
                                <fmt:formatNumber var="kgQuantityOthersRounded" value="${kgQuantity}" pattern="######"/>
                                <c:set var="price" value="${productQuality.price}"/>
                                <c:set var="salePrice" value="${productQuality.salePrice}"/>
                                <c:set var="priceTypeAB" value="true"/>
                            </c:if>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
                <td><fmt:formatNumber value="${kgQuantity}" pattern="###,###"/></td>
                <td>
                    <fmt:formatNumber value="${quantity}" pattern="###,###"/>
                </td>
                <td><fmt:formatNumber value="${price}" pattern="###,###"/></td>
                <td><fmt:formatNumber value="${saleByKg ? price * kgQuantity : price * quantity}" pattern="###,###"/></td>
                <c:set var="totalMoney" value="${saleByKg ? totalMoney + price * kgQuantity : totalMoney + price * quantity}"/>
                <td><fmt:formatNumber value="${kgm}" pattern="###,###.##"/></td>
            </tr>
            <c:if test="${fn:length(product.productqualitys) > 0}">
                <c:forEach items="${product.productqualitys}" var="productQuality" varStatus="status">
                    <c:if test="${productQuality.quality.code ne Constants.QUALITY_A && productQuality.quantity1 > 0}">
                        <c:choose>
                            <c:when test="${productQuality.quality.code eq Constants.QUALITY_B && priceTypeAB eq 'true'}"></c:when>
                            <c:otherwise>
                                <tr>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td style="font-style: italic;font-weight: bold">
                                        <c:if test="${status.index != fn:length(product.productqualitys) - 1}">
                                            <fmt:formatNumber value="${productQuality.quantity1 * kgm - productQuality.saleQuantity}" pattern="###,###"/>
                                            <fmt:formatNumber var="kgQuantityOthersRounded" value="${kgQuantityOthersRounded + productQuality.quantity1 * kgm - productQuality.saleQuantity}" pattern="######"/>
                                        </c:if>
                                        <c:if test="${status.index == fn:length(product.productqualitys) - 1}">
                                            <fmt:formatNumber value="${product.quantity2Pure - kgQuantityOthersRounded - productQuality.saleQuantity}" pattern="###,###"/>
                                        </c:if>
                                    </td>
                                    <td style="font-style: italic;font-weight: bold">
                                        <fmt:formatNumber value="${productQuality.quantity1 - productQuality.saleQuantity}" pattern="###,###"/>m${productQuality.quality.name}
                                    </td>
                                    <td><fmt:formatNumber value="${productQuality.price}" pattern="###,###"/></td>
                                    <td>
                                        <c:set var="tempMoney" value="0"/>
                                        <c:if test="${saleByKg}">
                                            <fmt:formatNumber var="kgQuantity" value="${productQuality.quantity1 * kgm - productQuality.saleQuantity}" groupingUsed="false" maxFractionDigits="0"/>
                                            <c:set var="tempMoney" value="${productQuality.price * kgQuantity}"/>
                                        </c:if>
                                        <c:if test="${!saleByKg}">
                                            <c:set var="tempMoney" value="${productQuality.price * (productQuality.quantity1 - productQuality.saleQuantity)}"/>
                                        </c:if>
                                        <fmt:formatNumber value="${tempMoney}" pattern="###,###"/>
                                    </td>
                                    <c:set var="totalMoney" value="${totalMoney + tempMoney}"/>
                                    <td></td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
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
        <c:if test="${transportFee > 0}">
            <tr>
                <td style="font-style: normal"><b>- Hỗ trợ CPVC nhận tại ${noinhan}: ${reduceCost}đ/kg</b></td>
                <td colspan="2"></td>
                <td style="text-align: right;">(<fmt:formatNumber value="${transportFee}" pattern="###,###"/>)</td>
                <td style="text-align: center;width: 40px">đồng</td>
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
        <c:set var="sumAll" value="${totalMoney - transportFee - totalSale - totalPaid}"/>
        <tr>
            <td colspan="3"><b>&nbsp;&nbsp;&nbsp;Tổng Cộng:</b></td>
            <td style="font-weight: bold"><div style="border-bottom: solid 1px black;text-align: right;"><fmt:formatNumber value="${sumAll}" pattern="###,###"/></div></td>
            <td style="text-align: center;width: 40px">đồng</td>
        </tr>

        <tr>
            <td colspan="5" class="font-10">
                <b><i><u>Ghi chú:</u> Bảng xác nhận này có giá trị đến hết ngày:....../....../ ${year}.</i></b>
            </td>
        </tr>
        <tr>
            <td colspan="5" style="font-weight: bold">2. <u>Thời gian - địa điểm giao, nhận hàng:</u></td>
        </tr>
        <tr>
            <td colspan="2">- Ngày nhận hàng:......./......./ ${year}.</td>
            <td>- Địa điểm nhận hàng:</td>
            <td colspan="2">..........................................</td>
        </tr>
        <tr>
            <td colspan="2">- Người nhận hàng:.............................</td>
            <td>- Số xe:</td>
            <td colspan="2">..........................................</td>
        </tr>
        <tr>
            <td colspan="5" style="font-weight: bold">3. <u>Điều kiện thanh toán:</u> Tiền mặt hoặc chuyển khoản</td>
        </tr>
        <tr>
            <td colspan="5">Ngày:......./......./ ${year} Thanh toán số tiền:............................... đồng.</td>
        </tr>
        <tr>
            <td colspan="5" style="font-weight: bold">4. <u>Mọi thông tin chi tiết vui lòng liên hệ Phòng kinh doanh:</u></td>
        </tr>
        <tr>
            <td colspan="5" style="font-weight: normal;">- SĐT: <b>028.3864.1836 / 3866.3514</b> *** Fax: <b>028.3864.5265</b> - <i>Hotline:</i> 0909.300.303 / 0909.909.055</td>
        </tr>
        <tr>
            <td colspan="5" style="font-weight: normal; font-style: italic;" class="font-10">* Chữ ký trên bản fax đều có giá trị như bản gốc; Khách hàng có thể thay đổi độ dày, nhưng KHÔNG hủy đơn hàng khi đã ký xác nhận.</td>
        </tr>
        <tr>
            <td colspan="5" style="font-weight: normal; font-style: italic;" class="font-10">** Sau 03 ngày kể từ ngày gởi bảng xác nhận đơn hàng - công nợ này,
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
            <td class="font-10">${user.fullname}<br>HP: ${user.phone}</td>
            <td></td>
        </tr>
    </table>
</div>

<div class="ad-info font-10">
    Quý khách mua sản phẩm <b>TPK</b> là đồng hành cùng Chúng tôi trong <br>
    chương trình <b>"Khát vọng sống".</b> <br>
    <b>Website:</b> <i>www.khatvongsong.uniad.com.vn</i>
</div>
</div>
<div class="clear"></div>
</body>
</html>