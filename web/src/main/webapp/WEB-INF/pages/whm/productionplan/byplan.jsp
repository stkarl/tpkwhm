<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<head>
    <title><fmt:message key="whm.import.product.by.plan.list"/></title>
    <meta name="heading" content="<fmt:message key="whm.import.product.by.plan.list"/>"/>
</head>

<c:url var="url" value="/whm/importproductbill/byplan.html"/>
<c:url var="importProductUrl" value="/whm/importproductbill/edit.html"/>

<div id="content">
    <form:form commandName="items" action="${url}" method="post" id="listForm" name="listForm">
        <div id="container-fluid data_content_box">
            <div class="row-fluid data_content">
                <div class="content-header">
                    <fmt:message key="whm.import.product.by.plan.list"/>
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
                                <td ><fmt:message key="label.name"/></td>
                                <td><form:input path="pojo.name" size="40"/></td>
                                <td ><fmt:message key="whm.warehouse.name"/></td>
                                <td>
                                    <form:select path="pojo.warehouse.warehouseID">
                                        <form:option value="-1">Tất cả</form:option>
                                        <form:options items="${warehouses}" itemValue="warehouseID" itemLabel="name"/>
                                    </form:select>
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
                               partialList="true" sort="external" size="${items.totalItems}" defaultorder="descending"  uid="tableList" pagesize="${items.maxPageItems}" class="tableSadlier table-hover" export="false">
                    <display:caption><fmt:message key='whm.productionplan.produce.list'/></display:caption>
                    <display:column headerClass="table_header"  escapeXml="false" sortable="false" sortName="name" titleKey="label.name" style="width: 25%" >
                        ${tableList.name}
                    </display:column>
                    <display:column headerClass="table_header"  escapeXml="false" sortable="false" sortName="description" titleKey="label.description" style="width: 40%" >
                        <str:truncateNicely upper="50">${tableList.description}</str:truncateNicely>
                    </display:column>
                    <display:column headerClass="table_header"  escapeXml="false" sortable="false" sortName="warehouse.name" titleKey="whm.warehouse" style="width: 20%" >
                        ${tableList.warehouse.name}
                    </display:column>
                    <display:column sortable="false" headerClass="table_header_center" titleKey="label.options" style="width: 15%; text-align:center">
                        <a href="${importProductUrl}?pojo.productionPlan.productionPlanID=${tableList.productionPlanID}" class="icon-arrow-right tip-top" title="<fmt:message key="label.declare.import.product"/>"></a>
                    </display:column>
                    <display:setProperty name="paging.banner.item_name"><fmt:message key= "whm.productionplan.name"/></display:setProperty>
                    <display:setProperty name="paging.banner.items_name"><fmt:message key= "whm.productionplan.name"/></display:setProperty>
                    <display:setProperty name="paging.banner.placement" value="bottom"/>
                    <display:setProperty name="paging.banner.no_items_found" value=""/>
                </display:table>
                <div class="clear"></div>
            </div>
        </div>


    </form:form>
</div>

<script type="text/javascript">
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


