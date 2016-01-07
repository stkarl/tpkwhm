<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@page import="com.banvien.tpk.core.Constants" %>

<head>
    <title><fmt:message key="owe.log.list.title"/></title>
    <meta name="heading" content="<fmt:message key="owe.log.list.title"/>"/>
</head>

<c:url var="url" value="/whm/customer/owelog.html"/>
<c:url var="editUrl" value="/whm/customer/editlog.html"/>
<div id="content">
    <form:form commandName="items" action="${url}" method="post" id="listForm" name="listForm">
        <div id="container-fluid data_content_box">
            <div class="row-fluid data_content">
                <div class="content-header">
                    <fmt:message key="owe.log.list.title"/>
                </div>
                <div class="clear"></div>
                <c:if test="${not empty messageResponse}">
                    <div class="alert alert-${alertType}">
                        <button aria-hidden="true" data-dismiss="alert" class="close" type="button">x</button>
                            ${messageResponse}
                    </div>
                </c:if>
                <div class="report-filter">
                    <div class="row-fluid report-filter">
                        <table class="tbReportFilter">
                            <caption><fmt:message key="label.search.title"/></caption>
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
                            <tr>
                                <td class="label-field"><fmt:message key="whm.customer.name"/></td>
                                <td>
                                    <form:select path="pojo.customer.customerID" cssStyle="width: 360px;">
                                        <form:option value="-1">Tất cả</form:option>
                                        <c:forEach items="${customers}" var="customer">
                                            <form:option value="${customer.customerID}">${customer.name} - ${customer.province.name}</form:option>
                                        </c:forEach>
                                    </form:select>
                                </td>
                                <td colspan="3"></td>
                            </tr>
                            <tr style="text-align: center;">
                                <td colspan="4">
                                    <form:hidden path="crudaction" id="crudaction" value="doReport"/>
                                    <a id="btnFilter" class="btn btn-primary " onclick="$('#listForm').submit();"><i class="icon-refresh"></i> <fmt:message key="label.search"/> </a>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>

                <div class="clear"></div>
                <display:table name="items.listResult" cellspacing="0" cellpadding="0" requestURI="${url}"
                               partialList="true" sort="external" size="${items.totalItems}"  uid="tableList" pagesize="${items.maxPageItems}" class="tableSadlier table-hover" export="false">
                    <display:caption><fmt:message key='owe.log.list.title'/></display:caption>
                    <display:column headerClass="table_header"  escapeXml="false" sortable="true" sortName="customer.name" titleKey="label.name" style="width: 10%" >
                        ${tableList.customer.name}
                    </display:column>
                    <display:column headerClass="table_header"  escapeXml="false" sortable="true" sortName="customer.province.name" titleKey="whm.province.name" style="width: 10%" >
                        ${tableList.customer.province.name}
                    </display:column>
                    <display:column headerClass="table_header_center"  escapeXml="false" sortable="false" titleKey="label.pay" style="width: 10%;text-align:center;" >
                        <c:if test="${tableList.type eq Constants.OWE_MINUS}">
                            <fmt:formatNumber value="${tableList.pay}" pattern="###,###"/>
                        </c:if>
                    </display:column>
                    <display:column headerClass="table_header_center"  escapeXml="false" sortable="false" titleKey="label.owe" style="width: 10%;text-align:center;" >
                        <c:if test="${tableList.type eq Constants.OWE_PLUS}">
                            <fmt:formatNumber value="${tableList.pay}" pattern="###,###"/>
                        </c:if>
                    </display:column>
                    <display:column headerClass="table_header_center"  escapeXml="false" sortable="false" titleKey="label.date" style="width: 10%;text-align:center;" >
                        <c:if test="${!empty tableList.payDate}">
                            <fmt:formatDate value="${tableList.payDate}" pattern="dd/MM/yyyy"/>
                        </c:if>
                        <c:if test="${!empty tableList.oweDate}">
                            <fmt:formatDate value="${tableList.oweDate}" pattern="dd/MM/yyyy"/>
                        </c:if>
                    </display:column>
                    <display:column headerClass="table_header_center"  escapeXml="false" sortable="false" titleKey="label.note" style="width: 30%;text-align:center;">
                        <c:if test="${fn:length(tableList.note) gt 35}">
                            <span title="${tableList.note}"><str:truncateNicely upper="35" appendToEnd="...">${tableList.note}</str:truncateNicely></span>
                        </c:if>
                        <c:if test="${fn:length(tableList.note) lt 35}">
                            ${tableList.note}
                        </c:if>
                    </display:column>

                    <display:column sortable="false" headerClass="table_header_center" titleKey="label.options" style="width: 10%; text-align:center">
                        <c:if test="${tableList.type eq Constants.OWE_MINUS && empty tableList.bookProductBill}">
                            <a onclick="printOwe('${tableList.oweLogID}');" class="icon-print tip-top" title="<fmt:message key="label.print.owe"/>"></a>
                        </c:if>
                        <security:authorize ifAnyGranted="ADMIN,LANHDAO,QUANLYKD,QUANLYNO">
                            <c:if test="${tableList.type eq Constants.OWE_MINUS && empty tableList.bookProductBill}">
                                <span class="separator"></span>
                            </c:if>
                            <a href="${editUrl}?pojo.oweLogID=${tableList.oweLogID}" class="icon-edit tip-top" title="<fmt:message key="label.edit"/>"></a>
                            <security:authorize ifNotGranted="QUANLYNO">
                                <span class="separator"></span>
                                <a name="deleteLink" onclick="warningDelete(this)" id="${tableList.oweLogID}" class="icon-remove tip-top" title="<fmt:message key="label.delete"/>"></a>
                            </security:authorize>
                        </security:authorize>
                    </display:column>
                    <display:setProperty name="paging.banner.item_name"> lần cập nhật </display:setProperty>
                    <display:setProperty name="paging.banner.items_name">lần cập nhật</display:setProperty>
                    <display:setProperty name="paging.banner.placement" value="bottom"/>
                    <display:setProperty name="paging.banner.no_items_found" value=""/>
                </display:table>
                <div class="clear"></div>
            </div>
        </div>


    </form:form>
</div>
<iframe name="printout" style="width:1px;height:1px;border:none;" id="printout"></iframe>
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

    function printOwe(oweLogID){
        <%--window.location.href = "<c:url value='/ajax/printPayment.html?oweLogID='/>" + oweLogID;--%>
        document.getElementById("printout").src = "<c:url value='/ajax/printPayment.html?oweLogID='/>" + oweLogID;
    }

</script>


