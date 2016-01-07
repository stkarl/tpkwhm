<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" errorPage="/error.jsp" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@page import="com.banvien.tpk.core.Constants" %>

<head>
    <title><fmt:message key="import.product.by.plan.title"/></title>
    <meta name="heading" content="<fmt:message key="import.product.by.plan.title"/>"/>
    <style>
        .pane_title{
            text-align:center;
        }
        .tableSadlier tr td{
            text-align: center;
            vertical-align: middle;
        }
    </style>
</head>

<c:url var="backUrl" value="/whm/productionplan/importproductbyplan.html"/>
<form:form commandName="item" action="${url}" method="post" id="itemForm" class="form-horizontal" novalidate="novalidate">
    <div id="container-fluid data_content_box">
        <div class="row-fluid data_content">
            <div class="importBackDiv">
                <div class="noscreen company-title" style="margin:50px;">
                    <table style="text-align: center;width: 100%">
                        <tr>
                            <td rowspan="5" style="width: 72px"><img src="/images/printlogo.png" style="width:72px;height: 72px;"/></td>
                            <td style="width: 30%;">CTY CỔ PHẦN THƯƠNG MẠI - SẢN XUẤT</td>
                            <td rowspan="4" class="bill-title">
                                <c:choose>
                                    <c:when test="${not empty plan}">
                                        <fmt:message key="label.inner.import.bill"/>
                                    </c:when>
                                    <c:otherwise>
                                        <fmt:message key="label.import.bill"/>
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
                <div class="content-header noprint"><fmt:message key="import.product.by.plan.title"/></div>
                <div class="clear"></div>
                <div id="generalInfor">
                    <table class="tbHskt info">
                        <caption><fmt:message key="import.material.generalinfo"/></caption>
                        <tr>
                            <td style="width: 15%"><fmt:message key="whm.productionplan.name"/></td>
                            <td colspan="5">${plan.name}</td>
                        </tr>
                        <tr>
                            <td><fmt:message key="whm.warehouse"/></td>
                            <td colspan="5">${plan.warehouse.name}</td>
                        </tr>
                    </table>
                </div>
                <div class="clear"></div>
                <c:if test="${not empty mainUsedMaterials}">
                    <table class="tableSadlier table-hover" border="1" style="margin: 12px 0 12px 0;width:100%;">
                        <caption><fmt:message key="production.produced"/></caption>
                        <tr>
                            <th rowspan="2" class="table_header text-center"><fmt:message key="label.stt"/></th>
                            <th colspan="6" class="table_header text-center"><fmt:message key="label.main.material"/></th>
                            <th colspan="5" class="table_header  text-center"><fmt:message key="label.production"/></th>
                            <th colspan="${fn:length(qualities) + 1}" class="table_header  text-center"><fmt:message key="produced.product.quality"/></th>
                        </tr>
                        <tr>
                            <th class="table_header text-center"><fmt:message key="label.name"/></th>
                            <th class="table_header text-center"><fmt:message key="label.size"/></th>
                            <th class="table_header text-center"><fmt:message key="label.code"/></th>
                            <th class="table_header text-center"><fmt:message key="label.kg"/></th>
                            <th class="table_header text-center"><fmt:message key="label.m"/></th>
                            <th class="table_header text-center"><fmt:message key="label.cut.off"/></th>
                            <th class="table_header text-center"><fmt:message key="label.name"/></th>
                            <th class="table_header text-center"><fmt:message key="label.size"/></th>
                            <th class="table_header text-center"><fmt:message key="label.code"/></th>
                            <th class="table_header text-center"><fmt:message key="label.kg"/></th>
                            <th class="table_header text-center"><fmt:message key="label.core"/></th>
                            <c:forEach items="${qualities}" var="quality">
                                <th class="table_header text-center">${quality.name}</th>
                            </c:forEach>
                            <th class="table_header text-center"><fmt:message key="label.total.m"/></th>
                        </tr>
                        <c:set value="1" var="stt"/>
                        <c:set value="0" var="materialKg"/>
                        <c:set value="0" var="materialM"/>
                        <c:set value="0" var="productKg"/>
                        <c:set value="0" var="productM"/>
                        <c:set value="0" var="materialCut"/>
                        <c:set value="0" var="productCore"/>
                        <c:forEach items="${mainUsedMaterials}" var="tableList">
                            <c:set value="${materialKg + tableList.totalKg}" var="materialKg"/>
                            <c:set value="${materialM + tableList.totalM}" var="materialM"/>
                            <c:set value="${materialCut + tableList.cutOff}" var="materialCut"/>
                            <c:set value="${fn:length(tableList.importproducts)}" var="counter"/>
                            <c:forEach items="${tableList.importproducts}" var="product" varStatus="status">
                                <tr>
                                    <td style="text-align: center">${stt}</td>
                                    <c:choose>
                                        <c:when test="${status.index == 0}">
                                            <td rowspan="${counter}">
                                                    ${tableList.mainMaterialName}
                                            </td>
                                            <td rowspan="${counter}">
                                                    ${tableList.mainMaterialSize}
                                            </td>
                                            <td rowspan="${counter}">
                                                    ${tableList.mainMaterialCode} <br> ${tableList.mainMaterialSpecific}
                                            </td>
                                            <td rowspan="${counter}">
                                                <fmt:formatNumber value="${tableList.totalKg}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/>
                                            </td>
                                            <td rowspan="${counter}">
                                                <fmt:formatNumber value="${tableList.totalM}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/>                                </td>
                                            </td>
                                            <td rowspan="${counter}">
                                                <fmt:formatNumber value="${tableList.cutOff}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/>                                </td>
                                            </td>
                                        </c:when>
                                        <c:when test="${counter <= 1 || status.index != 0}">
                                        </c:when>
                                    </c:choose>
                                    <td>
                                            ${product.productname.name}
                                    </td>
                                    <td>
                                            ${product.size.name}
                                    </td>
                                    <td>
                                            ${product.productCode}
                                    </td>
                                    <td>
                                        <fmt:formatNumber value="${product.quantity2Pure}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/>
                                    </td>
                                    <td>
                                            ${product.core}
                                    </td>
                                    <c:set var="totalQuality" value="0"/>
                                    <c:forEach items="${qualities}" var="quality">
                                        <td>
                        <span class="prd-quality-${quality.qualityID}">
                             <fmt:formatNumber value="${product.qualityQuantityMap[quality.qualityID]}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/>
                        </span>
                                            <c:set var="totalQuality" value="${totalQuality + product.qualityQuantityMap[quality.qualityID]}"/>
                                        </td>
                                    </c:forEach>
                                    <td>
                                        <fmt:formatNumber value="${totalQuality}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/>
                                    </td>
                                    <c:set value="${productKg + product.quantity2Pure}" var="productKg"/>
                                    <c:set value="${productM + totalQuality}" var="productM"/>
                                    <c:set value="${productCore + product.core}" var="productCore"/>
                                    <c:set var="stt" value="${stt + 1}"/>
                                </tr>
                            </c:forEach>
                        </c:forEach>
                        <tr style="font-weight: bold">
                            <td colspan="3">Tổng</td>
                            <td>${fn:length(mainUsedMaterials)} Cuộn</td>
                            <td><fmt:formatNumber value="${materialKg}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/></td>
                            <td><fmt:formatNumber value="${materialM}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/></td>
                            <td><fmt:formatNumber value="${materialCut}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/></td>
                            <td></td><td></td><td></td>
                            <td><fmt:formatNumber value="${productKg}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/></td>
                            <td><fmt:formatNumber value="${productCore}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/></td>
                            <c:forEach items="${qualities}" var="quality">
                                <td id="total-quality-${quality.qualityID}">
                                </td>
                            </c:forEach>
                            <td><fmt:formatNumber value="${productM}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/></td>
                        </tr>
                    </table>
                </c:if>
                <div class="clear"></div>

                <div class="noscreen sign-panel">
                    <table style="width: 100%; margin-top: 10px;">
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

            <c:if test="${not empty importBackProducts}">
                <div class="clear"></div>
                <div class="importBackDiv">
                    <%@include file="importBackProduct.jsp"%>
                </div>
            </c:if>

            <div class="clear"></div>
            <div class="controls">
                <div style="display: inline">
                    <a href="javascript:window.print();" class="btn btn-primary"><i class="icon-print"></i> <fmt:message key="button.print"/></a>
                    <form:hidden path="pojo.importProductBillID"/>
                    <a href="${backUrl}" class="cancel-link">
                        <fmt:message key="button.cancel"/>
                    </a>
                </div>
            </div>
        </div>
    </div>
</form:form>
<script type="text/javascript">
    $(document).ready(function(){
        <c:forEach items="${qualities}" var="quality">
        var total = 0;
        $(".prd-quality-" + ${quality.qualityID}).each(function(){
            if($(this).text() != undefined && $(this).text() != ''){
                var val = numeral().unformat($(this).text());
                total += val;
            }
        });
        $('#total-quality-' + ${quality.qualityID}).html(numeral(total).format('###,###'))
        </c:forEach>
    });
</script>