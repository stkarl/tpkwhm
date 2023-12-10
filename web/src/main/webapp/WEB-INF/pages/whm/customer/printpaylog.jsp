<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" errorPage="/error.jsp" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" media="all" href="<c:url value='/themes/whm/css/print_pay_log.css'/>" />
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
            <td style="font-weight: bold;">Khu Công Nghiệp Phú Mỹ I - Huyện Tân Thành - Tỉnh Bà Rịa Vũng Tàu</td>
        </tr>
        <tr>
            <td style="font-style: italic"><strong>Phòng kinh doanh:</strong> 08.38641836 - 22415924    **    <strong>Fax:</strong> 38645265</td>
        </tr>
    </table>
</div>
<hr>
<div class="clear"></div>
<div class="customer-info">
    <table>
        <tr>
            <td>
                BẢNG ĐỐI CHIẾU CÔNG NỢ
            </td>
        </tr>
        <tr>
            <td><u><i>Kính gởi</i></u>: ${company}</td>
        </tr>
        <tr>
            <td>Địa chỉ: ${customerAddress}</td>
        </tr>
        <tr>
            <td>Điện thoại: ${customerTelFax}</td>
        </tr>
    </table>
</div>
<div class="clear"></div>
<div class="product-info">
    <table class="tableSadlier">
        <tr>
            <td colspan="2">Nợ tiền hàng Cty TPK tính đến ${payDate}:</td>
            <td><fmt:formatNumber value="${owe}" pattern="###,###"/></td>
        </tr>
        <tr>
            <td style="width: 15%;">${payDate}</td>
            <td>${note}</td>
            <td style="width: 15%;">(<fmt:formatNumber value="${pay}" pattern="###,###"/>)</td>
        </tr>
        <tr>
            <td colspan="2">Số tiền ${customer} còn nợ Cty TPK đến ${payDate}:</td>
            <td>
                <c:set var="remain" value="${owe - pay}"/>
                <fmt:formatNumber value="${remain}" pattern="###,###"/>
            </td>
        </tr>
        <tr>
            <td colspan="3">Bằng chữ: ${tpk:numberInWord(remain)}</td>
        </tr>
    </table>
</div>
<div class="clear"></div>
<div class="note-info">
    <table>
        <tr>
            <td colspan="2">*** Sau 03 ngày kể từ ngày gởi bảng đối chiếu công nợ này,
                Cty chúng tôi chưa nhận được sự phản hồi từ Quý khách, thì số công nợ trên được xem là đúng.
            </td>
        </tr>
        <tr>
            <td style="width: 70%;padding-left: 50px;">
                Xác nhận công nợ và thời gian thanh toán
            </td>
            <td style="width: 30%">Tp.HCM ngày ${payDate}</td>
        </tr>
        <tr>
            <td></td>
            <td></td>
        </tr>
        <tr>
            <td></td>
            <td>Nguyễn Thị Tuyết</td>
        </tr>
    </table>
</div>
</body>
</html>