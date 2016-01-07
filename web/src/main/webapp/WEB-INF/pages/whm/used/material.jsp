<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@page import="com.banvien.tpk.core.Constants" %>
<html>
<head>
    <title><fmt:message key="report.used.material.title"/></title>
    <meta name="heading" content="<fmt:message key='report.used.material.title'/>"/>
</head>
<c:url var="urlForm" value="/whm/report/used/material.html"></c:url>
<body>
<div class="row-fluid data_content">
    <div class="content-header"><fmt:message key="report.used.material.title"/></div>
    <div class="clear"></div>
    <c:if test="${not empty messageResponse}">
        <div class="alert alert-${alertType}">
            <button aria-hidden="true" data-dismiss="alert" class="close" type="button">x</button>
                ${messageResponse}
        </div>
    </c:if>
    <div class="report-filter">
        <form:form commandName="items" action="${urlForm}" id="itemForm" method="post" autocomplete="off" name="itemForm">
            <table class="tbReportFilter" >
                <caption><fmt:message key="label.search.title"/></caption>
                <tr>
                    <td class="label-field" ><fmt:message key="label.export.type"/></td>
                    <td>
                        <form:select path="exportTypeID">
                            <form:options items="${exportTypes}" itemValue="exportTypeID" itemLabel="name"/>
                        </form:select>
                    </td>
                    <td class="label-field" ><fmt:message key="whm.productionplan.type"/></td>
                    <td>
                        <form:select path="productionType">
                            <form:option value="1">Sản Xuất Lạnh/Kẽm</form:option>
                            <form:option value="2">Sản Xuất Màu</form:option>
                        </form:select>
                    </td>
                </tr>
                <tr>
                    <td class="label-field"><fmt:message key="label.from.export.date"/></td>
                    <td>
                        <div class="input-append date" >
                            <fmt:formatDate var="ngayKeKhaiFrom" value="${items.fromExportedDate}" pattern="dd/MM/yyyy"/>
                            <input name="fromExportedDate" id="effectiveFromDate" class="prevent_type text-center width2" value="${ngayKeKhaiFrom}" type="text" />
                            <span class="add-on" id="effectiveFromDateIcon"><i class="icon-calendar"></i></span>
                        </div>
                    </td>
                    <td class="label-field"><fmt:message key="label.to.date"/></td>
                    <td>
                        <div class="input-append date" >
                            <fmt:formatDate var="ngayKeKhaiTo" value="${items.toExportedDate}" pattern="dd/MM/yyyy"/>
                            <input name="toExportedDate" id="effectiveToDate" class="prevent_type text-center width2" value="${ngayKeKhaiTo}" type="text" />
                            <span class="add-on" id="effectiveToDateIcon"><i class="icon-calendar"></i></span>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="label-field"><fmt:message key="whm.material.name"/></td>
                    <td>
                        <form:select path="materialID">
                            <form:option value="-1">Tất cả</form:option>
                            <form:options items="${materials}" itemValue="materialID" itemLabel="name"/>
                        </form:select>
                    </td>
                    <td class="label-field" ><fmt:message key="whm.warehouse"/></td>
                    <td>
                        <form:select path="warehouseID">
                            <form:option value="-1">Tất cả</form:option>
                            <form:options items="${warehouses}" itemValue="warehouseID" itemLabel="name"/>
                        </form:select>
                    </td>
                </tr>
                <tr>
                    <td class="label-field"><fmt:message key="whm.origin.name"/></td>
                    <td>
                        <form:select path="originID">
                            <form:option value="-1">Tất cả</form:option>
                            <form:options items="${origins}" itemValue="originID" itemLabel="name"/>
                        </form:select>
                    </td>
                    <td class="label-field"><fmt:message key="whm.market.name"/></td>
                    <td>
                        <form:select path="marketID">
                            <form:option value="-1">Tất cả</form:option>
                            <form:options items="${markets}" itemValue="marketID" itemLabel="name"/>
                        </form:select>
                    </td>
                </tr>
                <tr style="text-align: center;">
                    <td colspan="4">
                        <a id="btnFilter" class="btn btn-primary " onclick="submitReport('itemForm');"><i class="icon-refresh"></i> <fmt:message key="label.report"/></a>
                        <c:if test="${not empty result}">
                            <a id="btnExport" class="btn btn-info " onclick="submitExport('itemForm');"><i class="icon-arrow-down"></i> <fmt:message key="label.export.excel"/></a>
                        </c:if>
                    </td>
                </tr>
            </table>
            <div class="clear"></div>
            <c:if test="${not empty items.crudaction}">
                <div id="tongHopKHPB">
                    <div style="margin-top: 35px;">
                        <div class="pane_title">VẬT TƯ SỬ DỤNG
                            <%--<div class="float-right">Số ngày Sx: </div>--%>
                        </div>
                    </div>
                    <div class="row-fluid" >
                        <table class="tableSadlier table-hover" style="border-right: 1px;width: 100%;vertical-align: middle;">
                            <tr class="boldRow">
                                <th rowspan="2" class="table_header text-center" style="width: 45px;">STT</th>
                                <th rowspan="2" class="table_header">Nguyên Phụ Liệu (NPL)</th>
                                <th rowspan="2" class="table_header text-center" style="width: 65px;">ĐVT</th>
                                <th rowspan="2" class="table_header text-center" style="width: 110px;">Số Lượng</th>
                                <th colspan="2" class="table_header text-center">Bình quân sử dụng</th>
                                <%--<th rowspan="2" class="table_header text-center">Ghi Chú</th>--%>
                            </tr>
                            <tr class="boldRow">
                                <th class="table_header text-center" style="width: 110px;">ĐVT/m2</th>
                                <th class="table_header text-center" style="width: 110px;">ĐVT/Tấn Tôn</th>
                            </tr>
                            <c:set var="counter" value="0"/>
                            <c:if test="${fn:length(result.shareUsedMaterials) gt 0 || not empty result.usedProducts || not empty result.usedMeasurementMaterials}">
                                <c:set var="usedProducts" value="${result.usedProducts}"/>
                                <c:set var="shareUsedMaterials" value="${result.shareUsedMaterials}"/>
                                <c:set var="usedMeasurementMaterials" value="${result.usedMeasurementMaterials}"/>

                                <c:if test="${fn:length(usedProducts) gt 0}">
                                    <c:set var="totalMainProductKg" value="0"/>
                                    <c:set var="totalMainProductMet2" value="0"/>
                                    <c:forEach items="${usedProducts}" var="usedProduct">
                                        <c:set var="counter" value="${counter + 1}"/>
                                        <c:set var="totalKg" value="${usedProduct.totalKgUsed}"/>
                                        <c:set var="totalMet2" value="${usedProduct.totalMUsed * usedProduct.width / 1000}"/>
                                        <c:set var="totalMainProductKg" value="${totalMainProductKg + totalKg}"/>
                                        <c:set var="totalMainProductMet2" value="${totalMainProductMet2 + totalMet2}"/>
                                        <tr class="usedProduct ${counter % 2 eq 0 ? 'even' : 'odd'}">
                                            <td class="text-center">${counter}</td>
                                            <td>${usedProduct.productName.name}</td>
                                            <td class="text-center">Kg</td>
                                            <td class="text-right">
                                                <fmt:formatNumber value="${totalKg}" pattern="#,###"/>
                                            </td>
                                            <td></td>
                                            <td></td>
                                            <%--<td></td>--%>
                                        </tr>
                                        <c:if test="${fn:length(usedProduct.usedMaterialDTOs) gt 0}">
                                            <c:forEach items="${usedProduct.usedMaterialDTOs}" var="usedMaterial">
                                                <c:set var="counter" value="${counter + 1}"/>
                                                <tr class="${counter % 2 eq 0 ? 'even' : 'odd'}">
                                                    <td class="text-center">${counter}</td>
                                                    <td>${usedMaterial.material.name}</td>
                                                    <td class="text-center">${usedMaterial.unit.name}</td>
                                                    <td class="text-right">
                                                        <fmt:formatNumber value="${usedMaterial.totalUsed}" pattern="#,###,###.##"/>
                                                    </td>
                                                    <td class="text-right">
                                                        <fmt:formatNumber value="${totalMet2 > 0 ? usedMaterial.totalUsed/totalMet2 : ''}" pattern="#,###.####"/>
                                                    </td>
                                                    <td class="text-right">
                                                        <fmt:formatNumber value="${totalKg > 0 ? usedMaterial.totalUsed*1000/totalKg : ''}" pattern="#,###.##"/>
                                                    </td>
                                                    <%--<td></td>--%>
                                                </tr>
                                            </c:forEach>
                                        </c:if>
                                    </c:forEach>
                                </c:if>

                                <c:if test="${not empty usedMeasurementMaterials}">
                                    <c:forEach items="${usedMeasurementMaterials}" var="usedMaterial">
                                        <c:set var="counter" value="${counter + 1}"/>
                                        <tr class="${counter % 2 eq 0 ? 'even' : 'odd'}">
                                            <td class="text-center">${counter}</td>
                                            <td>${usedMaterial.material.name}</td>
                                            <td class="text-center">${usedMaterial.unit.name}</td>
                                            <td class="text-right">
                                                <fmt:formatNumber value="${usedMaterial.totalUsed}" pattern="#,###.##"/>
                                            </td>
                                            <td class="text-right">
                                                <fmt:formatNumber value="${totalMainProductMet2 > 0 ? usedMaterial.totalUsed/totalMainProductMet2 : ''}" pattern="#,###.####"/>
                                            </td>
                                            <td class="text-right">
                                                <fmt:formatNumber value="${totalMainProductKg > 0 ? usedMaterial.totalUsed*1000/totalMainProductKg : ''}" pattern="#,###.##"/>
                                            </td>
                                            <%--<td></td>--%>
                                        </tr>
                                    </c:forEach>
                                </c:if>

                                <c:if test="${not empty shareUsedMaterials}">
                                    <c:forEach items="${shareUsedMaterials}" var="usedMaterial">
                                        <c:set var="counter" value="${counter + 1}"/>
                                        <tr class="${counter % 2 eq 0 ? 'even' : 'odd'}">
                                            <td class="text-center">${counter}</td>
                                            <td>${usedMaterial.material.name}</td>
                                            <td class="text-center">${usedMaterial.unit.name}</td>
                                            <td class="text-right">
                                                <fmt:formatNumber value="${usedMaterial.totalUsed}" pattern="#,###.##"/>
                                            </td>
                                            <td class="text-right">
                                                <fmt:formatNumber value="${totalMainProductMet2 > 0 ? usedMaterial.totalUsed/totalMainProductMet2 : ''}" pattern="#,###.####"/>
                                            </td>
                                            <td class="text-right">
                                                <fmt:formatNumber value="${totalMainProductKg > 0 ? usedMaterial.totalUsed*1000/totalMainProductKg : ''}" pattern="#,###.##"/>
                                            </td>
                                            <%--<td></td>--%>
                                        </tr>
                                    </c:forEach>
                                </c:if>

                            </c:if>

                            <c:if test="${fn:length(result.shareUsedMaterials) lt 1 && empty result.usedProducts && empty result.usedMeasurementMaterials}">
                                <tr>
                                    <td colspan="10" style="font-size:15px;color:red;text-align:center;">
                                        Không tìm thấy dữ liệu phù hợp với các trường tìm kiếm.
                                    </td>
                                </tr>
                            </c:if>

                        </table>
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
</script>
</body>
</html>