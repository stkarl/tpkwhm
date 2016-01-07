<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@page import="com.banvien.tpk.core.Constants" %>
<html>
<head>
    <title><fmt:message key="report.sold.product.title"/></title>
    <meta name="heading" content="<fmt:message key='report.sold.product.title'/>"/>
    <link rel="stylesheet" href="<c:url value='/themes/whm/css/jquery.jscrollpane.css' />" />
</head>
<c:url var="urlForm" value="/whm/report/sold.html"></c:url>
<body>
<div class="row-fluid data_content">
    <div class="content-header"><fmt:message key="report.sold.product.title"/></div>
    <div class="clear"></div>
    <div class="report-filter">
        <form:form commandName="items" action="${urlForm}" id="itemForm" method="post" autocomplete="off" name="itemForm">
            <table class="tbReportFilter" >
                <caption><fmt:message key="label.search.title"/></caption>
                <tr>
                    <td class="label-field"><fmt:message key="label.from.sold.date"/></td>
                    <td>
                        <div class="input-append date" >
                            <fmt:formatDate var="ngayKeKhaiFrom" value="${items.fromDate}" pattern="dd/MM/yyyy"/>
                            <input name="fromDate" id="effectiveFromDate" class="prevent_type text-center width2" value="${ngayKeKhaiFrom}" type="text" />
                            <span class="add-on" id="effectiveFromDateIcon"><i class="icon-calendar"></i></span>
                        </div>
                    </td>
                    <td class="label-field"><fmt:message key="label.to.date"/></td>
                    <td>
                        <div class="input-append date" >
                            <fmt:formatDate var="ngayKeKhaiTo" value="${items.toDate}" pattern="dd/MM/yyyy"/>
                            <input name="toDate" id="effectiveToDate" class="prevent_type text-center width2" value="${ngayKeKhaiTo}" type="text" />
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
                    <td class="label-field"><fmt:message key="label.user"/></td>
                    <td>
                        <form:select path="userID">
                            <form:option value="-1">Tất cả</form:option>
                            <form:options items="${users}" itemValue="userID" itemLabel="fullname"/>
                        </form:select>
                    </td>
                    <td class="label-field"><fmt:message key="label.customer"/></td>
                    <td>
                        <form:select path="customerID" cssStyle="width: 360px;">
                            <form:option value="-1">Tất cả</form:option>
                            <c:forEach items="${customers}" var="customer">
                                <form:option value="${customer.customerID}">${customer.name} - ${customer.province.name}</form:option>
                            </c:forEach>
                        </form:select>
                    </td>
                </tr>
                <tr style="text-align: center;">
                    <td colspan="4">
                        <a id="btnFilter" class="btn btn-primary " onclick="submitForm();"><i class="icon-refresh"></i> <fmt:message key="label.search"/> </a>
                    </td>
                </tr>
            </table>
            <div class="clear"></div>

            <div id="tbContent" style="width:100%; max-height: 600px;">
                <table class="tableSadlier table-hover" border="1" style="border-right: 1px;margin: 12px 0 0px 0;width: 1500px;">
                    <caption><fmt:message key='sold.product.list'/></caption>
                    <tr>
                        <th class="table_header text-center"><fmt:message key="label.stt"/></th>
                        <th class="table_header text-center"><fmt:message key="sold.date"/></th>
                        <th class="table_header text-center"><fmt:message key="label.user"/></th>
                        <th class="table_header text-center"><fmt:message key="label.customer"/></th>
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
                    </tr>
                    <c:set var="totalKg" value="0"/>
                    <c:set var="totalMet" value="0"/>
                    <c:forEach items="${results}" var="tableList" varStatus="status">
                        <tr class="${status.index % 2 == 0 ? "even" : "odd"} text-center">
                            <td>${status.index + 1}</td>
                            <td><fmt:formatDate value="${tableList.soldDate}" pattern="dd/MM/yyyy"/></td>
                            <td>
                            ${mapCustomerUser[tableList.soldFor.customerID].fullname}
                            </td>
                            <td>${tableList.soldFor.name}</td>
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
                        </tr>
                        <c:set var="totalKg" value="${totalKg + tableList.quantity2Pure}"/>
                        <c:set var="totalMet" value="${totalMet + tableList.quantity1}"/>
                    </c:forEach>
                </table>
                <display:table name="results" cellspacing="0" cellpadding="0" requestURI="${formlUrl}"
                               partialList="true" sort="external" size="${fn:length(results)}"
                               uid="tableList" excludedParams="crudaction" style="display: none;"
                               pagesize="${fn:length(results)}" export="false" class="tableSadlier table-hover">
                    <display:setProperty name="paging.banner.item_name" value=""/>
                    <display:setProperty name="paging.banner.items_name" value=""/>
                    <display:setProperty name="paging.banner.placement" value=""/>
                    <display:setProperty name="paging.banner.no_items_found" value=""/>
                </display:table>
            </div>
            <div style="clear:both"></div>
            <table class="tableSadlier" style="margin-top: -30px">
                <tr style="font-weight: bold">
                    <td style="text-align: left;width: 70%">
                        Tổng: ${fn:length(results)} cuộn
                    </td>
                    <td style="text-align: right;width: 30%">
                        Kg: <fmt:formatNumber value="${totalKg}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/>
                        <span class="separator"></span>
                        Mét: <fmt:formatNumber value="${totalMet}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/>
                    </td>
                </tr>
            </table>
            <form:hidden path="crudaction" id="crudaction"/>
        </form:form>
    </div>
</div>
<script src="<c:url value="/themes/whm/scripts/bootstrap/jscrollpane.js"/>"></script>
<script type="text/javascript">
    $(document).ready(function(){
        $('#tbContent').jScrollPane();
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


        $("#btnFilter").click(function(){
            $("#crudaction").val("search");
            $("#itemForm").submit();
        });
    });
</script>
</body>
</html>