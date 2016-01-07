<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<head>
    <title><fmt:message key="whm.export.material.by.plan.title"/></title>
    <meta name="heading" content="<fmt:message key="whm.export.material.by.plan.title"/>"/>
</head>

<c:url var="url" value="/whm/productionplan/materialbyplan.html"/>
<c:url var="exportProductUrl" value="/whm/viewbyplan/exportmaterial.html"/>

<div id="content">
    <form:form commandName="items" action="${url}" method="post" id="listForm" name="listForm">
        <div id="container-fluid data_content_box">
            <div class="row-fluid data_content">
                <div class="content-header">
                    <fmt:message key="whm.export.material.by.plan.title"/>
                </div>
                <div class="clear"></div>
                <div class="report-filter">
                    <div class="row-fluid report-filter">
                        <table class="tbReportFilter">
                            <caption><fmt:message key="label.search.title"/></caption>
                            <tr>
                                <td class="label-field"><fmt:message key="label.name"/></td>
                                <td><form:input path="pojo.name" size="40"/></td>
                                <td class="label-field"><fmt:message key="whm.warehouse.name"/></td>
                                <td>
                                    <form:select path="pojo.warehouse.warehouseID">
                                        <form:option value="-1">Tất cả</form:option>
                                        <form:options items="${warehouses}" itemValue="warehouseID" itemLabel="name"/>
                                    </form:select>
                                </td>
                            </tr>
                            <tr>
                                <td class="label-field"><fmt:message key="label.from.export.date"/></td>
                                <td>
                                    <div class="input-append date" >
                                        <fmt:formatDate var="ngayKeKhaiFrom" value="${items.fromDate}" pattern="dd/MM/yyyy"/>
                                        <input name="fromDate" id="effectiveFromDate" class="prevent_type text-center width2" value="${ngayKeKhaiFrom}" type="text" />
                                        <span class="add-on" id="effectiveFromDateIcon"><i class="icon-calendar"></i></span>
                                    </div>
                                </td>
                                <td class="label-field"><fmt:message key="label.to.import.date"/></td>
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
                <display:table name="items.listResult" cellspacing="0" cellpadding="0" requestURI="${url}"
                               partialList="true" sort="external" size="${items.totalItems}"  uid="tableList" pagesize="${items.maxPageItems}" class="tableSadlier table-hover" export="false">
                    <display:caption><fmt:message key='whm.productionplan.produce.list'/></display:caption>
                    <display:column headerClass="table_header"  escapeXml="false" sortable="true" sortName="name" titleKey="label.name" style="width: 25%" >
                        ${tableList.name}
                    </display:column>
                    <display:column headerClass="table_header"  escapeXml="false" sortable="true" sortName="name" titleKey="label.description" style="width: 40%" >
                        <str:truncateNicely upper="50">${tableList.description}</str:truncateNicely>
                    </display:column>
                    <display:column headerClass="table_header"  escapeXml="false" sortable="false" sortName="name" titleKey="whm.warehouse" style="width: 20%" >
                        ${tableList.warehouse.name}
                    </display:column>
                    <display:column sortable="false" headerClass="table_header_center" titleKey="label.options" style="width: 15%; text-align:center">
                        <a href="${exportProductUrl}?productionPlanID=${tableList.productionPlanID}" class="icon-eye-open tip-top" title="<fmt:message key="view.by.plan"/>"></a>
                    </display:column>
                    <display:setProperty name="paging.banner.item_name">ca</display:setProperty>
                    <display:setProperty name="paging.banner.items_name">ca</display:setProperty>
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
    <c:if test="${not empty items.crudaction}">
    highlightTableRows("tableList");
    </c:if>
    $(function() {
        $("#deleteConfirmLink").click(function() {
            $('#crudaction').val('delete');
            document.forms['listForm'].submit();
        });
        $('a[name="deleteLink"]').click(function(eventObj) {
            //document.location.href = eventObj.target.href;
            return true;

        });

    });
    function confirmDeleteItem(){
        var fb = checkSelected4ConfirmDelete('listForm', 'checkList');
        if(fb) {
            $("#deleteConfirmLink").trigger('click');
        }else {
            $("#hidenWarningLink").trigger('click');
        }
    }

</script>


