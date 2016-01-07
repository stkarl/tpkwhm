<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@page import="com.banvien.tpk.core.Constants" %>
<html>
<head>
    <title><fmt:message key="in.stock.product.title"/></title>
    <meta name="heading" content="<fmt:message key='in.stock.product.title'/>"/>
    <link rel="stylesheet" href="<c:url value='/themes/whm/css/jquery.jscrollpane.css' />" />

</head>
<c:url var="urlForm" value="/whm/report/instock/product.html"></c:url>
<body>
<div class="row-fluid data_content">
    <div class="content-header"><fmt:message key="in.stock.product.title"/></div>
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
                    <td class="label-field" ><fmt:message key="label.number"/></td>
                    <td><form:input path="code" size="25" maxlength="45" /></td>
                    <td class="label-field" ><fmt:message key="whm.warehouse"/></td>
                    <td>
                        <form:select path="warehouseID">
                            <form:option value="-1">Tất cả</form:option>
                            <form:options items="${warehouses}" itemValue="warehouseID" itemLabel="name"/>
                        </form:select>
                    </td>
                </tr>
                <tr>
                    <td class="label-field"><fmt:message key="label.from.import.date"/></td>
                    <td>
                        <div class="input-append date" >
                            <fmt:formatDate var="ngayKeKhaiFrom" value="${items.fromImportedDate}" pattern="dd/MM/yyyy"/>
                            <input name="fromImportedDate" id="effectiveFromDate" class="prevent_type text-center width2" value="${ngayKeKhaiFrom}" type="text" />
                            <span class="add-on" id="effectiveFromDateIcon"><i class="icon-calendar"></i></span>
                        </div>
                    </td>
                    <td class="label-field"><fmt:message key="label.to.import.date"/></td>
                    <td>
                        <div class="input-append date" >
                            <fmt:formatDate var="ngayKeKhaiTo" value="${items.toImportedDate}" pattern="dd/MM/yyyy"/>
                            <input name="toImportedDate" id="effectiveToDate" class="prevent_type text-center width2" value="${ngayKeKhaiTo}" type="text" />
                            <span class="add-on" id="effectiveToDateIcon"><i class="icon-calendar"></i></span>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="label-field"><fmt:message key="whm.productname.name"/></td>
                    <td>
                        <form:select path="productNameID">
                            <form:option value="-1">Tất cả</form:option>
                            <form:options items="${productNames}" itemValue="productNameID" itemLabel="name"/>
                        </form:select>
                    </td>
                    <td class="label-field"><fmt:message key="whm.size.name"/></td>
                    <td>
                        <form:select path="sizeID">
                            <form:option value="-1">Tất cả</form:option>
                            <form:options items="${sizes}" itemValue="sizeID" itemLabel="name"/>
                        </form:select>
                    </td>
                </tr>
                <tr>
                    <td class="label-field"><fmt:message key="whm.thickness.name"/></td>
                    <td>
                        <form:select path="thicknessID">
                            <form:option value="-1">Tất cả</form:option>
                            <form:options items="${thicknesses}" itemValue="thicknessID" itemLabel="name"/>
                        </form:select>
                    </td>
                    <td class="label-field"><fmt:message key="whm.stiffness.name"/></td>
                    <td>
                        <form:select path="stiffnessID">
                            <form:option value="-1">Tất cả</form:option>
                            <form:options items="${stiffnesses}" itemValue="stiffnessID" itemLabel="name"/>
                        </form:select>
                    </td>
                </tr>
                <tr>
                    <td class="label-field"><fmt:message key="whm.colour.name"/></td>
                    <td>
                        <form:select path="colourID">
                            <form:option value="-1">Tất cả</form:option>
                            <form:options items="${colours}" itemValue="colourID" itemLabel="name"/>
                        </form:select>
                    </td>
                    <td class="label-field"><fmt:message key="whm.overlaytype.name"/></td>
                    <td>
                        <form:select path="overlayTypeID">
                            <form:option value="-1">Tất cả</form:option>
                            <form:options items="${overlayTypes}" itemValue="overlayTypeID" itemLabel="name"/>
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
                <tr>
                    <td class="label-field"><fmt:message key="label.location"/></td>
                    <td>
                        <form:select path="warehouseMapID">
                            <form:option value="-1">Tất cả</form:option>
                            <form:options items="${warehouseMaps}" itemValue="warehouseMapID" itemLabel="name"/>
                        </form:select>
                    </td>
                    <td class="label-field" ><fmt:message key="label.status"/></td>
                    <td>
                        <form:select path="status">
                            <form:option value="">Sẵn trong kho | Đã đặt bán</form:option>
                            <form:option value="${Constants.ROOT_MATERIAL_STATUS_WAIT_CONFIRM}">Đã lập phiếu xuất kho</form:option>
                            <form:option value="${Constants.ROOT_MATERIAL_STATUS_AVAILABLE}">Sẵn trong kho</form:option>
                            <form:option value="${Constants.ROOT_MATERIAL_STATUS_USED}">Đã sử dụng</form:option>
                            <form:option value="${Constants.ROOT_MATERIAL_STATUS_EXPORTING}">Đang chuyển kho</form:option>
                            <form:option value="${Constants.ROOT_MATERIAL_STATUS_WAIT_TO_USE}">Chờ thu cuộn thành phẩm</form:option>
                            <form:option value="${Constants.ROOT_MATERIAL_STATUS_BOOKED}">Đã được đặt bán</form:option>
                        </form:select>
                    </td>
                </tr>
                <tr>
                    <td class="label-field"><fmt:message key="label.from.kg.m"/></td>
                    <td>
                        <form:input path="fromKgM" size="25" maxlength="45" id="fromKgM" onchange="checkNumber(this.value, this.id);"/>
                    </td>
                    <td class="label-field"><fmt:message key="label.to.kg.m"/></td>
                    <td>
                        <form:input path="toKgM" size="25" maxlength="45" id="toKgM" onchange="checkNumber(this.value, this.id);"/>
                    </td>
                </tr>
                <tr style="text-align: center;">
                    <td colspan="4">
                        <a id="btnFilter" class="btn btn-primary " onclick="submitForm('itemForm');"><i class="icon-refresh"></i> <fmt:message key="label.search"/> </a>
                        <c:if test="${fn:length(items.listResult) > 0}">
                            <a id="btnExport" class="btn btn-info " onclick="submitExport('itemForm');"><i class="icon-arrow-down"></i> <fmt:message key="label.export.excel"/> </a>
                        </c:if>
                    </td>
                </tr>
            </table>
            <div class="clear"></div>
            <div id="infoMsg"></div>

            <div id="tbContent" style="width:100%;max-height: 500px;">
                <table class="tableSadlier table-hover" border="1" style="border-right: 1px;margin: 12px 0 20px 0;width: 1300px;">
                    <caption><fmt:message key="in.stock.product.list"/></caption>
                    <tr>
                        <th class="table_header text-center"><input type="checkbox" onclick="checkAllByClass('checkPrd', this);"/></th>
                        <th class="table_header text-center"><fmt:message key="label.stt"/></th>
                        <th class="table_header text-center"><fmt:message key="label.name"/></th>
                        <th class="table_header text-center"><fmt:message key="label.code"/></th>
                        <th class="table_header text-center"><fmt:message key="label.size"/></th>
                        <th class="table_header text-center"><fmt:message key="label.specific"/></th>
                        <th class="table_header text-center"><fmt:message key="whm.overlaytype.name"/></th>
                        <th class="table_header text-center"><fmt:message key="label.kg"/></th>
                        <c:forEach items="${qualities}" var="quality">
                            <th class="table_header text-center">${quality.name}</th>
                        </c:forEach>
                        <th class="table_header text-center"><fmt:message key="label.total.m"/></th>
                        <th class="table_header text-center">Kg/m</th>
                        <th class="table_header text-center"><fmt:message key="main.material.note"/></th>
                        <th class="table_header text-center"><fmt:message key="whm.warehouse.name"/></th>
                        <th class="table_header text-center"><fmt:message key="label.produced.date"/></th>
                        <th class="table_header text-center"><fmt:message key="label.status"/></th>
                    </tr>
                    <c:forEach items="${items.listResult}" var="tableList" varStatus="status">
                        <tr class="${status.index % 2 == 0 ? "even text-center" : "odd text-center"}">
                            <td>
                                <input class="checkPrd" type="checkbox" name="bookedProductIDs" value="${tableList.importProductID}" id="selected-${tableList.importProductID}"/>
                                <input type="hidden" value="${tableList.warehouse.warehouseID}" id="warehouse-${tableList.importProductID}"/>
                            </td>
                            <td>${status.index + 1}</td>
                            <td>${tableList.productname.name}</td>
                            <td>${tableList.productCode}</td>
                            <td>${tableList.size.name}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${not empty tableList.colour}">
                                        ${tableList.colour.name}
                                    </c:when>
                                    <c:when test="${not empty tableList.thickness}">
                                        ${tableList.thickness.name}
                                    </c:when>
                                </c:choose>
                            </td>
                            <td>${tableList.overlaytype.name}</td>
                            <td><fmt:formatNumber value="${tableList.quantity2Pure}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/></td>
                            <c:forEach items="${qualities}" var="quality">
                                <td>
                                    <c:forEach items="${tableList.productqualitys}" var="productQuality">
                                        <c:if test="${productQuality.quality.qualityID == quality.qualityID}">
                                            <fmt:formatNumber value="${productQuality.quantity1}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/>
                                        </c:if>
                                    </c:forEach>
                                </td>
                            </c:forEach>
                            <td><fmt:formatNumber value="${tableList.quantity1}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/></td>
                            <td><fmt:formatNumber value="${tableList.quantity2Pure / tableList.quantity1}" pattern="###,###.##" maxFractionDigits="2" minFractionDigits="0"/></td>
                            <td style="text-align: left">
                                    ${tableList.note}
                            </td>
                            <td>${tableList.warehouse.name}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${not empty tableList.importDate}">
                                        <fmt:formatDate value="${tableList.importDate}" pattern="dd/MM/yyyy"/>
                                    </c:when>
                                    <c:when test="${not empty tableList.produceDate}">
                                        <fmt:formatDate value="${tableList.produceDate}" pattern="dd/MM/yyyy"/>
                                    </c:when>
                                    <c:otherwise>-</c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${tableList.status eq Constants.ROOT_MATERIAL_STATUS_WAIT_CONFIRM}">
                                        Đã lập phiếu xuất kho
                                    </c:when>
                                    <c:when test="${tableList.status eq Constants.ROOT_MATERIAL_STATUS_AVAILABLE}">
                                        Sẵn trong kho
                                    </c:when>
                                    <c:when test="${tableList.status eq Constants.ROOT_MATERIAL_STATUS_USED}">
                                        Đã sử dụng
                                    </c:when>
                                    <c:when test="${tableList.status eq Constants.ROOT_MATERIAL_STATUS_EXPORTING}">
                                        Đang chuyển kho
                                    </c:when>
                                    <c:when test="${tableList.status eq Constants.ROOT_MATERIAL_STATUS_WAIT_TO_USE}">
                                        Chờ thu cuộn thành phẩm
                                    </c:when>
                                    <c:when test="${tableList.status eq Constants.ROOT_MATERIAL_STATUS_BOOKED}">
                                        Đã được đặt bán
                                    </c:when>
                                    <c:otherwise>-</c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
            </div>

            <div style="clear:both"></div>
            <table class="tableSadlier">
                <tr style="font-weight: bold">
                    <td style="text-align: left;width: 70%">
                        Tổng: ${items.totalItems} cuộn
                    </td>
                    <td style="text-align: right;width: 30%">
                        Mét: <fmt:formatNumber value="${items.totalMet}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/>
                        <span class="separator"></span>
                        Tấn: <fmt:formatNumber value="${items.totalKg / 1000}" pattern="###,###" maxFractionDigits="0" minFractionDigits="3"/>
                    </td>
                </tr>
            </table>
            <display:table name="items.listResult" cellspacing="0" cellpadding="0" requestURI="${formlUrl}"
                           partialList="true" sort="external" size="${items.totalItems }"
                           uid="tableList" excludedParams="crudaction" style="display: none;"
                           pagesize="${items.maxPageItems}" export="false" class="tableSadlier table-hover">
                <display:setProperty name="paging.banner.item_name" value="cuộn tôn"/>
                <display:setProperty name="paging.banner.items_name" value="cuộn tôn"/>
                <display:setProperty name="paging.banner.placement" value="bottom"/>
                <display:setProperty name="paging.banner.no_items_found" value=""/>
            </display:table>

            <form:hidden path="crudaction" id="crudaction"/>
        </form:form>
    </div>
</div>
<script src="<c:url value="/themes/whm/scripts/bootstrap/jscrollpane.js"/>"></script>

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

        $('#tbContent').jScrollPane();


        $("#btnFilter").click(function(){
            $("#crudaction").val("search");
            $("#itemForm").submit();
        });
    });
</script>
</body>
</html>