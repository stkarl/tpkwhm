<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" errorPage="/error.jsp" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@page import="com.banvien.tpk.core.Constants" %>
<head>
    <title><fmt:message key="export.material.by.plan.title"/></title>
    <meta name="heading" content="<fmt:message key="export.material.by.plan.title"/>"/>
    <style media="print">
        table.tbInput,
        table.tbHskt.info,
        .sign-panel{
            font-size: 18px!important;
        }
    </style>
</head>

<c:url var="backUrl" value="/whm/productionplan/materialbyplan.html"/>
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
                                <c:when test="${not empty plan}">
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
            <div class="content-header noprint"><fmt:message key="export.material.by.plan.title"/></div>
            <div class="clear"></div>
            <table class="tbHskt info">
                <caption><fmt:message key="import.material.generalinfo"/></caption>
                <tr>
                    <td style="width: 25%"><fmt:message key="whm.productionplan.name"/></td>
                    <td colspan="5">${plan.name}</td>
                </tr>
                <tr>
                    <td style="width: 25%"><fmt:message key="label.export.type"/></td>
                    <td colspan="5">
                        <c:if test="${plan.production == 1}">Sản Xuất Lạnh/Kẽm</c:if>
                        <c:if test="${plan.production == 2}">Sản Xuất Màu</c:if>
                        <c:if test="${plan.production == 0}"><fmt:message key="label.maintain"/></c:if>
                    </td>
                </tr>
                <tr>
                    <td><fmt:message key="warehouse.export"/></td>
                    <td colspan="5">${plan.warehouse.name}</td>
                </tr>
            </table>
            <table class="tbInput">
                <caption><fmt:message key="import.info.material"/></caption>
                <tr id="tbHead">
                    <th >Mã vật tư</th>
                    <th >Tên vật tư</th>
                    <th ><fmt:message key="label.quantity"/></th>
                    <th ><fmt:message key="label.made.in"/></th>
                    <th ><fmt:message key="label.expiredDate"/></th>
                </tr>
                <c:forEach items="${exportmaterials}" var="exportmaterial" varStatus="status">
                    <tr id="mtr_${status.index}" style="text-align: center">
                        <td style="width:15%;">${exportmaterial.importmaterial.code}</td>
                        <td style="width:18%">${exportmaterial.importmaterial.material.name}</td>
                        <td style="width:15%;"><fmt:formatNumber value="${exportmaterial.quantity}" pattern="###,###.#" maxFractionDigits="1" minFractionDigits="0"/> (${exportmaterial.importmaterial.material.unit.name})</td>
                        <td style="width:15%;">${exportmaterial.importmaterial.origin.name}</td>
                        <td style="width:15%;"><fmt:formatDate value="${exportmaterial.importmaterial.expiredDate}" pattern="dd/MM/yyyy"/></td>
                    </tr>
                </c:forEach>
            </table>
            <div class="controls">
                <div style="display: inline">
                    <a href="javascript:window.print();" class="btn btn-primary"><i class="icon-print"></i> <fmt:message key="button.print"/></a>
                    <a href="${backUrl}" class="cancel-link">
                        <fmt:message key="button.cancel"/>
                    </a>
                </div>
            </div>

            <div class="noscreen sign-panel">
                <table style="width: 100%">
                    <tr>
                        <td colspan="4" style="text-align: right;padding-bottom: 1em;">Ngày......tháng......năm.....</td>
                    </tr>
                    <tr style="text-align: center;font-weight: bold">
                        <td>Người lập phiếu</td>
                        <td>
                            <c:choose>
                                <c:when test="${not empty plan}">
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
</form:form>
<script type="text/javascript">
</script>