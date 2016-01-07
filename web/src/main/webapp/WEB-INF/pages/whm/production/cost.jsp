<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@page import="com.banvien.tpk.core.Constants" %>
<html>
<head>
    <title><fmt:message key="report.produced.product.cost"/></title>
    <meta name="heading" content="<fmt:message key='report.produced.product.cost'/>"/>
</head>
<c:url var="urlForm" value="/whm/production/cost.html"></c:url>
<body>
<div class="row-fluid data_content">
<div class="content-header"><fmt:message key="report.produced.product.cost"/></div>
<div class="clear"></div>
<div class="report-filter">
<form:form commandName="items" action="${urlForm}" id="itemForm" method="post" autocomplete="off" name="itemForm">
<table class="tbReportFilter" >
    <caption><fmt:message key="label.search.title"/></caption>
    <tr>
        <td class="label-field" ><fmt:message key="main.material.name"/></td>
        <td>
            <form:select path="productNameID">
                <form:option value="-1">Tất cả</form:option>
                <form:options items="${productNames}" itemValue="productNameID" itemLabel="name"/>
            </form:select>
        </td>
        <td class="label-field" ><fmt:message key="report.productname.name"/></td>
        <td>
            <form:select path="producedProductID">
                <form:option value="-1">Tất cả</form:option>
                <form:options items="${productNames}" itemValue="productNameID" itemLabel="name"/>
            </form:select>
        </td>
    </tr>
    <tr>
        <td class="label-field" ><fmt:message key="main.material.name"/></td>
        <td>
            <form:select path="sizeID">
                <form:option value="-1">Tất cả</form:option>
                <form:options items="${sizes}" itemValue="sizeID" itemLabel="name"/>
            </form:select>
        </td>
        <td class="label-field" ></td>
        <td>
        </td>
    </tr>
    <tr>
        <td class="label-field"><fmt:message key="label.fromdate"/></td>
        <td>
            <div class="input-append date" >
                <fmt:formatDate var="ngayKeKhaiFrom" value="${items.fromDate}" pattern="dd/MM/yyyy"/>
                <input name="fromDate" id="effectiveFromDate" class="prevent_type text-center width2" value="${ngayKeKhaiFrom}" type="text" />
                <span class="add-on" id="effectiveFromDateIcon"><i class="icon-calendar"></i></span>
            </div>
        </td>
        <td class="label-field"><fmt:message key="label.todate"/></td>
        <td>
            <div class="input-append date" >
                <fmt:formatDate var="ngayKeKhaiTo" value="${items.toDate}" pattern="dd/MM/yyyy"/>
                <input name="toDate" id="effectiveToDate" class="prevent_type text-center width2" value="${ngayKeKhaiTo}" type="text" />
                <span class="add-on" id="effectiveToDateIcon"><i class="icon-calendar"></i></span>
            </div>
        </td>
    </tr>

    <tr style="text-align: center;">
        <td colspan="4">
            <a id="btnFilter" class="btn btn-primary " onclick="submitReport('itemForm');"><i class="icon-refresh"></i> <fmt:message key="label.report"/></a>
            <c:if test="${not empty result}">
                <%--<a id="btnExport" class="btn btn-info " onclick="submitExport('itemForm');"><i class="icon-arrow-down"></i> <fmt:message key="label.export.excel"/></a>--%>
            </c:if>
        </td>
    </tr>
</table>
<div class="clear"></div>
<c:if test="${!empty items.crudaction && (!empty result || !empty summaryResult)}">
<div class="clear"></div>
<div class="fixedFee">
    <table class="tableSadlier table-hover" style="margin-top: 35px;width: 60%;float: right; border: none">
        <tr>
            <td style="text-align: right">Chi phí cố định tính phân bổ trung bình</td>
            <td>
                <input style="width: 60px;" type="text" value="2000.2" id="averageArrangement" class="inputFractionNumber" onblur="calculateCost(this.value);"/> VNĐ/m2
            </td>

        </tr>
        <%--<tr>--%>
            <%--<td style="text-align: right">Tỷ trọng tôn</td>--%>
            <%--<td>--%>
                <%--<input style="width: 60px;" type="text" value="7.85" id="averageWeight"/> Kg/m2--%>
            <%--</td>--%>
        <%--</tr>--%>
    </table>
</div>
    <%--temporary hidden--%>
    <div style="margin: 20px 0 -10px 0;">
        <a class="btn btn-info summary" onclick="viewDetail(this);"><fmt:message key="view.detail"/></a>
    </div>

    <div class="clear"></div>
    <div id="productCostSummary">
        <div>
            <div class="row-fluid" >
                <c:set var="prevproductNameID" value="0"/>
                <c:set var="mapProductProduceds" value="${summaryResult.mapProductProduceds}"/>
                <c:set var="mapProductUsedMaterials" value="${summaryResult.mapProductUsedMaterials}"/>
                <c:set var="averageCost" value="0"/>
                <c:forEach items="${mapProductProduceds}" var="mapProductProduceds" varStatus="status">
                    <c:set var="productNameID" value="${mapProductProduceds.key}"/>
                    <c:set var="totalProductInSummary" value="${summaryResult.mapProductTotalProduced[productNameID]}"/>
                    <c:set var="products" value="${mapProductProduceds.value}"/>
                    <c:set var="averageCost" value="0"/>
                    <table class="tableSadlier table-hover">
                        <caption>Chi phí sản xuất</caption>
                        <tr class="boldRow">
                            <th colspan="2" class="table_header text-center">Tổng thành phẩm sản xuất</th>
                            <th colspan="4" class="table_header text-center">Tổng vật tư sử dụng</th>
                            <th rowspan="2" class="table_header text-center" style="width: 10%;">Bình quân sử dụng (ĐVT/kg)</th>
                            <th rowspan="2" class="table_header text-center" style="width: 10%;">Giá vật tư / kg thành phẩm</th>
                        </tr>
                        <tr class="boldRow">
                            <th class="table_header text-center" style="width: 20%;">Tên</th>
                            <th class="table_header text-center" style="width: 10%;">Trọng lượng (kg)</th>
                            <th class="table_header text-center" style="width: 20%;">Tên</th>
                            <th class="table_header text-center" style="width: 10%;">Số Lượng</th>
                            <th class="table_header text-center" style="width: 10%;">ĐVT</th>
                            <th class="table_header text-center" style="width: 10%;">Giá (VNĐ/ĐVT)</th>
                        </tr>
                        <c:forEach items="${mapProductUsedMaterials[productNameID]}" var="usedMaterial" varStatus="materialStatus">
                            <tr style="text-align: center" class="${materialStatus.index % 2 == 0 ? "odd" : "even"}">
                                <c:if test="${materialStatus.index == 0}">
                                    <td rowspan="${fn:length(mapProductUsedMaterials[productNameID])}">${totalProductInSummary.productname.name}</td>
                                    <td rowspan="${fn:length(mapProductUsedMaterials[productNameID])}"><fmt:formatNumber value="${totalProductInSummary.totalProduced}"/></td>
                                </c:if>
                                <td>
                                    <c:if test="${not empty usedMaterial.material}">
                                        ${usedMaterial.material.name}
                                    </c:if>
                                    <c:if test="${not empty usedMaterial.productName}">
                                        ${usedMaterial.productName.name}
                                    </c:if>
                                </td>
                                <td><fmt:formatNumber value="${usedMaterial.totalUsed}"/></td>
                                <td>${usedMaterial.unit.name}</td>
                                <td><fmt:formatNumber value="${usedMaterial.cost}" pattern="#,###"/></td>
                                <td><fmt:formatNumber value="${usedMaterial.totalUsed / totalProductInSummary.totalProduced}"/></td>
                                <td><fmt:formatNumber value="${usedMaterial.totalUsed / totalProductInSummary.totalProduced * usedMaterial.cost}" pattern="#,###"/></td>
                                <c:set var="averageCost" value="${averageCost + usedMaterial.totalUsed / totalProductInSummary.totalProduced * usedMaterial.cost}"/>
                            </tr>
                        </c:forEach>
                        <%--<tr style="text-align: center" class="${(fn:length(mapProductUsedMaterials[productNameID])) % 2 == 0 ? "odd" : "even"}">--%>
                            <%--<td colspan="5">--%>
                                <%--<fmt:message key="arrangement.fee"/>--%>
                            <%--</td>--%>
                            <%--<td><fmt:formatNumber value="${summaryResult.mapProductArrangementFee[productNameID]}" pattern="#,###"/></td>--%>
                            <%--<c:set var="averageCost" value="${averageCost + summaryResult.mapProductArrangementFee[productNameID]}"/>--%>
                        <%--</tr>--%>
                        <tr class="boldRow ${(fn:length(mapProductUsedMaterials[productNameID]) + 1) % 2 == 0 ? "even" : "odd"}">
                            <td colspan="7" style="text-align: right">Tổng</td>
                            <td style="text-align: center"><fmt:formatNumber value="${averageCost}" pattern="#,###"/></td>
                        </tr>
                    </table>



                    <table class="tableSadlier table-hover" style="text-align: center">
                        <tr class="boldRow">
                            <th colspan="6" class="table_header text-center">Thành phẩm</th>
                            <th rowspan="2" class="table_header text-center" style="width: 10%;">Tổng giá vật tư / kg thành phẩm</th>
                            <th rowspan="2" class="table_header text-center" style="width: 10%;">Phân bổ VNĐ/Kg</th>
                            <th rowspan="2" class="table_header text-center" style="width: 10%;">Tổng</th>
                        </tr>
                        <tr class="boldRow">
                            <th class="table_header text-center" style="width: 15%;">Mã số</th>
                            <th class="table_header text-center" style="width: 10%;">Tên</th>
                            <th class="table_header text-center" style="width: 10%;">Quy cách</th>
                            <th class="table_header text-center" style="width: 15%;">Đặc tính</th>
                            <th class="table_header text-center" style="width: 10%;">Mét</th>
                            <th class="table_header text-center" style="width: 10%;">Kg</th>
                        </tr>
                        <c:set var="totalM" value="0"/>
                        <c:set var="totalKg" value="0"/>
                        <c:set var="totalMoney" value="0"/>
                        <c:forEach items="${products}" var="product" varStatus="productStatus">
                            <tr class="${productStatus.index % 2 == 0 ? "odd" : "even"}">
                                <input type="hidden" value="${tpk:productWidth(product.size.name)}" id="width-${product.importProductID}"/>
                                <c:set var="thick" value="${tpk:productThick(product.size.name)}"/>
                                <input type="hidden" value="${thick}" id="thick-${product.importProductID}"/>
                                <td>${product.productCode}</td>
                                <td>${product.productname.name}</td>
                                <td>${product.size.name}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty product.colour}">${product.colour.name}</c:when>
                                        <c:when test="${not empty product.thickness}">${product.thickness.name}</c:when>
                                        <c:otherwise>-</c:otherwise>
                                    </c:choose>
                                </td>
                                <td style="text-align: center" id="length-${product.importProductID}"><fmt:formatNumber value="${product.quantity1}"/></td>
                                <td style="text-align: center" id="weight-${product.importProductID}"><fmt:formatNumber value="${product.quantity2Pure}"/></td>
                                <td style="text-align: center" id="averageCost-${product.importProductID}"><fmt:formatNumber value="${averageCost}" pattern="#,###"/></td>
                                <c:set var="arrangeVal" value="${product.quantity1 * tpk:productWidth(product.size.name) * 2000.2 / product.quantity2Pure}"/>
                                <c:set var="arrangeVal" value="${tpk:balanceArrangeFee(arrangeVal, thick)}"/>

                                <td style="text-align: center" id="arrange-${product.importProductID}"><fmt:formatNumber value="${arrangeVal}" pattern="#,###.###"/></td>
                                <td style="text-align: center" id="cost-${product.importProductID}" class="productCost-${status.index}"><fmt:formatNumber value="${product.quantity2Pure * (averageCost + arrangeVal)}" pattern="#,###"/></td>
                            </tr>
                            <c:set var="totalM" value="${totalM + product.quantity1}"/>
                            <c:set var="totalKg" value="${totalKg + product.quantity2Pure}"/>
                            <c:set var="totalMoney" value="${totalMoney + product.quantity2Pure * (averageCost + arrangeVal)}"/>
                        </c:forEach>
                        <tr style="font-weight: bold" class="${(fn:length(products) + 1) % 2 == 0 ? "even" : "odd"}">
                            <td colspan="3">Tổng:</td>
                            <td> ${fn:length(products)} cuộn</td>
                            <td style="text-align: center"><fmt:formatNumber value="${totalM}"/></td>
                            <td style="text-align: center"><fmt:formatNumber value="${totalKg}"/></td>
                            <td style="text-align: center">-</td>
                            <td style="text-align: center">-</td>
                            <td style="text-align: center" id="totalGroup-${status.index}"><fmt:formatNumber value="${totalMoney}" pattern="#,###"/></td>
                        </tr>
                    </table>
                </c:forEach>
            </div>
        </div>
    </div>

    <div id="produceCostDetail" style="display: none;">
        <div style="margin-top: 35px;">
            <div class="row-fluid" >
                <c:set var="prevPlanID" value="0"/>
                <c:set var="mapPlanProducts" value="${result.mapPlanProducts}"/>
                <c:set var="mapIDPlan" value="${result.mapIDPlan}"/>
                <c:set var="mapPlanUsedMaterial" value="${result.mapPlanUsedMaterial}"/>
                <c:set var="averageCost" value="0"/>
                <c:forEach items="${mapPlanProducts}" var="mapPlanProducts">
                    <c:set var="planID" value="${mapPlanProducts.key}"/>
                    <c:set var="productionPlan" value="${mapIDPlan[planID]}"/>
                    <c:set var="totalProduct" value="${result.mapPlanTotalProducedProduct[planID]}"/>
                    <c:set var="products" value="${mapPlanProducts.value}"/>
                    <c:set var="averageCost" value="0"/>
                    <table class="tableSadlier table-hover">
                        <caption>Chi phí sản xuất: ${productionPlan.name}</caption>
                        <tr class="boldRow">
                            <th colspan="2" class="table_header text-center">Tổng thành phẩm sản xuất</th>
                            <th colspan="4" class="table_header text-center">Tổng vật tư sử dụng</th>
                            <th rowspan="2" class="table_header text-center" style="width: 10%;">Bình quân sử dụng (ĐVT/kg)</th>
                            <th rowspan="2" class="table_header text-center" style="width: 10%;">Giá vật tư / kg thành phẩm</th>
                        </tr>
                        <tr class="boldRow">
                            <th class="table_header text-center" style="width: 20%;">Tên</th>
                            <th class="table_header text-center" style="width: 10%;">Trọng lượng (kg)</th>
                            <th class="table_header text-center" style="width: 20%;">Tên</th>
                            <th class="table_header text-center" style="width: 10%;">Số Lượng</th>
                            <th class="table_header text-center" style="width: 10%;">ĐVT</th>
                            <th class="table_header text-center" style="width: 10%;">Giá (VNĐ/ĐVT)</th>
                        </tr>
                        <c:forEach items="${mapPlanUsedMaterial[planID]}" var="usedMaterial" varStatus="materialStatus">
                            <tr style="text-align: center" class="${materialStatus.index % 2 == 0 ? "odd" : "even"}">
                                <c:if test="${materialStatus.index == 0}">
                                    <td rowspan="${fn:length(mapPlanUsedMaterial[planID])}">${totalProduct.productname.name}</td>
                                    <td rowspan="${fn:length(mapPlanUsedMaterial[planID])}"><fmt:formatNumber value="${totalProduct.totalProduced}"/></td>
                                </c:if>
                                <td>
                                    <c:if test="${not empty usedMaterial.material}">
                                        ${usedMaterial.material.name}
                                    </c:if>
                                    <c:if test="${not empty usedMaterial.productName}">
                                        ${usedMaterial.productName.name}
                                    </c:if>
                                </td>
                                <td><fmt:formatNumber value="${usedMaterial.totalUsed}"/></td>
                                <td>${usedMaterial.unit.name}</td>
                                <td><fmt:formatNumber value="${usedMaterial.cost}" pattern="#,###"/></td>
                                <td><fmt:formatNumber value="${usedMaterial.totalUsed / totalProduct.totalProduced}"/></td>
                                <td><fmt:formatNumber value="${usedMaterial.totalUsed / totalProduct.totalProduced * usedMaterial.cost}" pattern="#,###"/></td>
                                <c:set var="averageCost" value="${averageCost + usedMaterial.totalUsed / totalProduct.totalProduced * usedMaterial.cost}"/>
                            </tr>
                        </c:forEach>
                        <%--<tr style="text-align: center" class="${(fn:length(mapPlanUsedMaterial[planID])) % 2 == 0 ? "odd" : "even"}">--%>
                            <%--<td colspan="5">--%>
                                <%--<fmt:message key="arrangement.fee"/>--%>
                            <%--</td>--%>
                            <%--<td><fmt:formatNumber value="${result.mapPlanArrangementFee[planID]}" pattern="#,###"/></td>--%>
                            <%--<c:set var="averageCost" value="${averageCost + result.mapPlanArrangementFee[planID]}"/>--%>
                        <%--</tr>--%>
                        <tr class="boldRow ${(fn:length(mapPlanUsedMaterial[planID]) + 1) % 2 == 0 ? "even" : "odd"}">
                            <td colspan="7" style="text-align: right">Tổng</td>
                            <td style="text-align: center"><fmt:formatNumber value="${averageCost}" pattern="#,###"/></td>
                        </tr>
                    </table>
                    <%--<table class="tableSadlier table-hover" style="text-align: center">--%>
                        <%--<tr class="boldRow">--%>
                            <%--<th colspan="6" class="table_header text-center">Thành phẩm</th>--%>
                            <%--<th rowspan="2" class="table_header text-center" style="width: 10%;">Tổng giá vật tư / kg thành phẩm</th>--%>
                            <%--<th rowspan="2" class="table_header text-center" style="width: 10%;">Tổng</th>--%>
                        <%--</tr>--%>
                        <%--<tr class="boldRow">--%>
                            <%--<th class="table_header text-center" style="width: 15%;">Mã số</th>--%>
                            <%--<th class="table_header text-center" style="width: 10%;">Tên</th>--%>
                            <%--<th class="table_header text-center" style="width: 10%;">Quy cách</th>--%>
                            <%--<th class="table_header text-center" style="width: 15%;">Đặc tính</th>--%>
                            <%--<th class="table_header text-center" style="width: 10%;">Mét</th>--%>
                            <%--<th class="table_header text-center" style="width: 10%;">Kg</th>--%>
                        <%--</tr>--%>
                        <%--<c:set var="totalM" value="0"/>--%>
                        <%--<c:set var="totalKg" value="0"/>--%>
                        <%--<c:set var="totalMoney" value="0"/>--%>
                        <%--<c:forEach items="${products}" var="product" varStatus="productStatus">--%>
                            <%--<tr class="${productStatus.index % 2 == 0 ? "odd" : "even"}">--%>
                                <%--<td>${product.productCode}</td>--%>
                                <%--<td>${product.productname.name}</td>--%>
                                <%--<td>${product.size.name}</td>--%>
                                <%--<td>--%>
                                    <%--<c:choose>--%>
                                        <%--<c:when test="${not empty product.colour}">${product.colour.name}</c:when>--%>
                                        <%--<c:when test="${not empty product.thickness}">${product.thickness.name}</c:when>--%>
                                        <%--<c:otherwise>-</c:otherwise>--%>
                                    <%--</c:choose>--%>
                                <%--</td>--%>
                                <%--<td style="text-align: center"><fmt:formatNumber value="${product.quantity1}"/></td>--%>
                                <%--<td style="text-align: center"><fmt:formatNumber value="${product.quantity2Pure}"/></td>--%>
                                <%--<td style="text-align: center"><fmt:formatNumber value="${averageCost}" pattern="#,###"/></td>--%>
                                <%--<td style="text-align: center"><fmt:formatNumber value="${product.quantity2Pure * averageCost}" pattern="#,###"/></td>--%>
                            <%--</tr>--%>
                            <%--<c:set var="totalM" value="${totalM + product.quantity1}"/>--%>
                            <%--<c:set var="totalKg" value="${totalKg + product.quantity2Pure}"/>--%>
                            <%--<c:set var="totalMoney" value="${totalMoney + product.quantity2Pure * averageCost}"/>--%>
                        <%--</c:forEach>--%>
                        <%--<tr style="font-weight: bold" class="${(fn:length(products) + 1) % 2 == 0 ? "even" : "odd"}">--%>
                            <%--<td colspan="3">Tổng:</td>--%>
                            <%--<td> ${fn:length(products)} cuộn</td>--%>
                            <%--<td style="text-align: center"><fmt:formatNumber value="${totalM}"/></td>--%>
                            <%--<td style="text-align: center"><fmt:formatNumber value="${totalKg}"/></td>--%>
                            <%--<td style="text-align: center"><fmt:formatNumber value="${averageCost}" pattern="#,###"/></td>--%>
                            <%--<td style="text-align: center"><fmt:formatNumber value="${totalMoney}"/></td>--%>
                        <%--</tr>--%>
                    <%--</table>--%>
                </c:forEach>
            </div>
        </div>
    </div>
</c:if>


<form:hidden path="crudaction" id="crudaction"/>
</form:form>
</div>
</div>

<script type="text/javascript">
    $(document).ready(function(){
        var effectiveToDateVar = $("#effectiveToDate").datepicker({
            format: 'dd/mm/yyyy',
            onRender: function(date){
            }}).on('changeDate', function(ev) {
                    effectiveToDateVar.hide();
                }).data('datepicker');
        var effectiveFromDateVar = $("#effectiveFromDate").datepicker({
            format: 'dd/mm/yyyy',
            onRender: function(date){
            }}).on('changeDate', function(ev) {
                    effectiveFromDateVar.hide();
                }).data('datepicker');
        $('#effectiveToDateIcon').click(function() {
            $('#effectiveToDate').focus();
            return true;
        });
        $('#effectiveFromDateIcon').click(function() {
            $('#effectiveFromDate').focus();
            return true;
        });

    });

    function viewDetail(ele){
        if($(ele).hasClass('summary')){
            $('#productCostSummary').hide();
            $('#produceCostDetail').show();
            $(ele).html('<fmt:message key="view.summary"/>');
            $(ele).removeClass('summary');
        }else{
            $('#produceCostDetail').hide();
            $('#productCostSummary').show();
            $(ele).addClass('summary');
            $(ele).html('<fmt:message key="view.detail"/>');
        }
    }

    function calculateCost(fee){
        var baseFee = numeral().unformat(fee);
        var productId,length,weight,width,thick,averageCost,arrangeCost,group,total;
        $('[id*="arrange-"]').each(function(){
            productId = $(this).attr('id').split('-')[1];
            length = numeral().unformat($('#length-' + productId).html());
            width = numeral().unformat($('#width-' + productId).val());
            thick = numeral().unformat($('#thick-' + productId).val());
            weight = numeral().unformat($('#weight-' + productId).html());
            averageCost = numeral().unformat($('#averageCost-' + productId).html());
            arrangeCost = length * width * baseFee / weight;
            arrangeCost = balanceArrangeFee(arrangeCost, thick);

            $(this).html(numeral(arrangeCost).format('###,###.###'));
            $('#cost-' + productId).html(numeral(weight * (arrangeCost + averageCost)).format('###,###'));
        });

        $('[id*="totalGroup-"]').each(function(){
            total = 0;
            group = $(this).attr('id').split('-')[1];
            $('.productCost-' + group).each(function(){
                total += numeral().unformat($(this).html());
            });
            $(this).html(numeral(total).format('###,###'));
        });
    }

    function balanceArrangeFee(arrangeCost, thick){
        var result;
        if(thick <= 0.25){
            result = arrangeCost - arrangeCost*0.06;
        }else if(thick > 0.25 && thick <= 0.3){
            result = arrangeCost - arrangeCost*0.03;
        }else if(thick >= 0.31 && thick <= 0.4){
            result = arrangeCost + arrangeCost*0.03;
        }else if(thick >= 0.41 && thick <= 0.5){
            result = arrangeCost + arrangeCost*0.06;
        }else if(thick >= 0.51 && thick <= 0.6){
            result = arrangeCost + arrangeCost*0.09;
        }else{
            result = arrangeCost + arrangeCost*0.12;
        }
        return result;
    }
</script>
</body>
</html>