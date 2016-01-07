<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" errorPage="/error.jsp" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" media="all" href="<c:url value='/themes/whm/css/print_ship_bill.css'/>" />
</head>
<body onload='window.focus(); self.print();'>
<div class="company-title">
    <table style="text-align: center;">
        <tr>
            <td rowspan="6" style="width: 50px;"><img src="/images/printlogoiso.png" style="width:50px;height: 58px;"/></td>
            <td style="width: 240px;font-weight: bold;font-size: 12px;">CTY CP THƯƠNG MẠI - SẢN XUẤT</td>
            <td rowspan="2" class="bill-title" style="font-weight: bold;font-size: 26px;">
                PHIẾU GIAO HÀNG
            </td>
            <td rowspan="2" style="width: 120px;"></td>
        </tr>
        <tr>
            <td style="font-weight: bold;font-size: 14px;">TÔN TÂN PHƯỚC KHANH</td>
        </tr>
        <tr>
            <td style="font-weight: bold;font-size: 10px;">KCN Phú Mỹ 1, H.Tân Thành, Tỉnh BRVT</td>
            <td rowspan="2" style="font-weight: bold;font-size: 14px;">Số: ......./......./.......</td>
            <td rowspan="4" style="font-weight: bold;font-size: 12px;"><div style="border: 3px solid #000000">VUI LÒNG ĐỂ TÔN <br>NƠI KHÔ RÁO <br>TRÁNH ẨM ƯỚT</div></td>
        </tr>
        <tr>
            <td style="font-weight: bold;font-size: 10px;">ĐT: 0643.922762 - Fax: 0643.922765</td>
        </tr>
        <tr>
            <td rowspan="2"></td>
            <td rowspan="2" style="font-size: 14px;font-style: italic">Ngày&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;tháng&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;năm&nbsp;&nbsp;${year}</td>
        </tr>
    </table>
</div>
<div class="clear"></div>

<div class="customer-info">
    <table class="tableSadlier">
        <tr style="font-weight: bold;text-align: center;">
            <td colspan="2">ĐẠI DIỆN BÊN GIAO HÀNG:</td>
            <td colspan="3">CÔNG TY CP TM & SX TÔN TÂN PHƯỚC KHANH</td>
        </tr>
        <tr>
            <td>Họ & tên:</td>
            <td></td>
            <td>Chức vụ: </td>
            <td></td>
            <td></td>
        </tr>
        <tr>
            <td>Họ & tên:</td>
            <td></td>
            <td>Chức vụ: </td>
            <td></td>
            <td></td>
        </tr>
        <tr style="font-weight: bold;text-align: center;">
            <td colspan="2">ĐẠI DIỆN BÊN NHẬN HÀNG:</td>
            <td colspan="3" style="text-transform: uppercase;">${customer}</td>
        </tr>
        <tr>
            <td>Họ & tên tài xế:</td>
            <td></td>
            <td>Số xe: </td>
            <td></td>
            <td></td>
        </tr>
        <tr>
            <td>Xuất tại kho:</td>
            <td style="text-align: center;text-transform: uppercase;font-weight: bold;">${warehouse}</td>
            <td>Địa chỉ:</td>
            <td></td>
            <td></td>
        </tr>
    </table>
</div>
<div class="clear"></div>
<div class="product-info">
    <table class="tableSadlier">
        <tr>
            <td>STT</td>
            <td>TÊN HÀNG</td>
            <td>QUY CÁCH</td>
            <td>MÃ SỐ</td>
            <td>TL(Kg)</td>
            <td>SỐ MÉT</td>
            <td>MSSP</td>
            <td>GHI CHÚ</td>
        </tr>
        <c:set var="totalKg" value="0"/>
        <c:set var="totalM" value="0"/>
        <c:forEach items="${bookProducts}" var="bookProduct" varStatus="status">
            <c:set var="product" value="${bookProduct.importProduct}"/>
            <tr>
                <td>${status.index + 1}</td>
                <td>${tpk:productShipName(product.productname.name,product.colour.name)}</td>
                <td>${product.size.name}</td>
                <%--<td>${tpk:productCodeWhenPrint(product.productCode)}</td>--%>
                <td>${product.productCode}</td>
                <td><fmt:formatNumber value="${product.quantity2Pure}" pattern="###,###"/></td>
                <td><fmt:formatNumber value="${product.quantity1}" pattern="###,###"/></td>
                <td>
                    <c:choose>
                        <c:when test="${!empty product.colour}">${product.colour.code}</c:when>
                        <c:when test="${empty product.colour}">${product.thickness.name}</c:when>
                        <c:otherwise>-</c:otherwise>
                    </c:choose>
                </td>
                <td>${tpk:productShipNote(product.productqualitys)}</td>
            </tr>
            <c:set var="totalKg" value="${totalKg + product.quantity2Pure}"/>
            <c:set var="totalM" value="${totalM + product.quantity1}"/>
        </c:forEach>
        <tr>
            <td></td>
            <td></td>
            <td colspan="2">${fn:length(bookProducts)} cuộn</td>
            <td><fmt:formatNumber value="${totalKg}" pattern="###,###"/></td>
            <td><fmt:formatNumber value="${totalM}" pattern="###,###"/></td>
            <td></td>
            <td></td>
        </tr>
    </table>
</div>
<div class="clear"></div>
<div class="sign-info">
    <table class="tableSadlier">
        <tr>
            <td rowspan="2">DUYỆT XUẤT KHO</td>
            <td rowspan="2">PHÒNG KD ĐỀ XUẤT</td>
            <td colspan="3" style="font-size: 14px;">Hai bên đã kiểm tra đối chiếu số liệu và ký xác nhận</td>
        </tr>
        <tr>
            <td>BĐH NHÀ MÁY</td>
            <td>ĐẠI DIỆN GIAO HÀNG</td>
            <td>ĐẠI DIỆN NHẬN HÀNG</td>
        </tr>
        <tr>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
        </tr>
    </table>
</div>
<div class="clear"></div>
<div class="note-info">
    <table>
        <tr>
            <td>
                <u>Ghi chú:</u> Hàng hóa được giao lên phương tiện trong tình trạng nguyên vẹn,không bị móp méo, khô ráo, được hai bên chứng kiến
            </td>
        </tr>
        <tr>
            <td>* Điều kiện giao nhận hàng:</td>
        </tr>
        <tr>
            <td>- Giao hàng tại kho Công Ty Tôn Tân Phước Khanh hoặc các chi nhánh trực thuộc Cty Phước Khanh.</td>
        </tr>
        <tr>
            <td>- Người nhận hàng là đại diện hợp pháp của đơn vị mua hàng</td>
        </tr>
        <tr>
            <td><u>* ĐẶC BIỆT CHÚ Ý</u></td>
        </tr>
        <tr>
            <td>Đây là thời điểm vào mùa mưa, quý khách hàng và người đại diện nhận hàng cần chú ý bảo quản Tôn và sàn xe khô ráo.</td>
        </tr>
    </table>
</div>
</body>
</html>