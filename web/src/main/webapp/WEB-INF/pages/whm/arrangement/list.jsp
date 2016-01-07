<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<head>
    <title><fmt:message key="whm.arrangement.list"/></title>
    <meta name="heading" content="<fmt:message key="whm.arrangement.list"/>"/>
</head>

<c:url var="url" value="/whm/arrangement/list.html"/>
<c:url var="editUrl" value="/whm/arrangement/edit.html"/>
<c:url var="viewUrl" value="/whm/arrangement/view.html"/>
<div id="content">
    <form:form commandName="items" action="${url}" method="post" id="listForm" name="listForm">
        <div id="container-fluid data_content_box">
            <div class="row-fluid data_content">
                <div class="content-header">
                    <fmt:message key="whm.arrangement.list"/>
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
                <div class="button-actions">
                    <a class="btn btn-primary " onclick="document.location.href='${editUrl}';"><i class="icon-plus"></i> <fmt:message key="whm.arrangement.declare"/> </a>
                </div>
                <div class="clear"></div>
                <display:table name="items.listResult" cellspacing="0" cellpadding="0" requestURI="${url}"
                               partialList="true" sort="external" size="${items.totalItems}"  uid="tableList" pagesize="${items.maxPageItems}" class="tableSadlier table-hover" export="false">
                    <display:caption><fmt:message key='whm.arrangement.list'/></display:caption>
                    <display:column headerClass="table_header"  escapeXml="false" sortable="false" title="STT" style="width: 5%" >
                        ${tableList_rowNum}
                    </display:column>
                    <display:column headerClass="table_header"  escapeXml="false" sortable="true" sortName="fromDate" titleKey="from.date" style="width: 10%" >
                        <fmt:formatDate value="${tableList.fromDate}" pattern="${datePattern}"/>
                    </display:column>
                    <display:column headerClass="table_header"  escapeXml="false" sortable="true" sortName="toDate" titleKey="to.date" style="width: 10%" >
                        <fmt:formatDate value="${tableList.toDate}" pattern="${datePattern}"/>
                    </display:column>
                    <display:column headerClass="table_header"  escapeXml="false" sortable="true" sortName="totalBack" titleKey="arrangement.total.black.used" style="width: 15%" >
                        <fmt:formatNumber value="${tableList.totalBlack}" pattern="###,###.###"/>
                    </display:column>
                    <display:column headerClass="table_header"  escapeXml="false" sortable="false" title="Tổng phân bổ (VNĐ)" style="width: 25%" >
                        <c:set var="totalFee" value="0"/>
                        <c:forEach items="${tableList.arrangementDetails}" var="detail">
                            <c:set var="totalFee" value="${totalFee + detail.value}"/>
                        </c:forEach>
                        <fmt:formatNumber value="${totalFee}" pattern="###,###.###"/>
                    </display:column>
                    <display:column headerClass="table_header"  escapeXml="false" sortable="true" sortName="average" title="Phân bổ trung bình (VNĐ/Tấn)" style="width: 25%" >
                        <fmt:formatNumber value="${tableList.average}" pattern="###,###.###"/>
                    </display:column>

                    <display:column sortable="false" headerClass="table_header_center" titleKey="label.options" style="width: 15%; text-align:center">
                        <a href="${viewUrl}?pojo.arrangementID=${tableList.arrangementID}" class="icon-eye-open tip-top" title="<fmt:message key="label.view"/>"></a>
                        <span class="separator"></span>
                        <a href="${editUrl}?pojo.arrangementID=${tableList.arrangementID}" class="icon-edit tip-top" title="<fmt:message key="label.edit"/>"></a>
                        <security:authorize ifAnyGranted="LANHDAO,ADMIN">
                        <span class="separator"></span>
                        <a name="deleteLink" onclick="warningDelete(this)" id="${tableList.arrangementID}" href="#" class="icon-remove tip-top" title="<fmt:message key="label.delete"/>"></a>
                        </security:authorize>
                    </display:column>
                    <display:setProperty name="paging.banner.item_name"><fmt:message key= "whm.arrangement.name"/></display:setProperty>
                    <display:setProperty name="paging.banner.items_name"><fmt:message key= "whm.arrangement.name"/></display:setProperty>
                    <display:setProperty name="paging.banner.placement" value="bottom"/>
                    <display:setProperty name="paging.banner.no_items_found" value=""/>
                </display:table>

                <div class="clear"></div>
            </div>
        </div>
    </form:form>
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


