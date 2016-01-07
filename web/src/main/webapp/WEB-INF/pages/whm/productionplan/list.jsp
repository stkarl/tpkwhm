<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<head>
    <title><fmt:message key="whm.productionplan.list"/></title>
    <meta name="heading" content="<fmt:message key="whm.productionplan.list"/>"/>
</head>

<c:url var="url" value="/whm/productionplan/list.html"/>
<c:url var="editUrl" value="/whm/productionplan/edit.html"/>

<div id="content">
    <form:form commandName="items" action="${url}" method="post" id="listForm" name="listForm">
        <div id="container-fluid data_content_box">
            <div class="row-fluid data_content">
                <div class="content-header">
                    <fmt:message key="whm.productionplan.list"/>
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
                <div class="button-actions">
                    <a class="btn btn-primary " onclick="document.location.href='${editUrl}';"><i class="icon-plus"></i> <fmt:message key="button.add"/></a>
                </div>
                <div class="clear"></div>
                <display:table name="items.listResult" cellspacing="0" cellpadding="0" requestURI="${url}"
                               partialList="true" sort="external" size="${items.totalItems}" uid="tableList" pagesize="${items.maxPageItems}" class="tableSadlier table-hover" export="false">
                    <display:caption><fmt:message key='whm.productionplan.list'/></display:caption>
                    <display:column headerClass="table_header"  escapeXml="false" sortable="true" sortName="name" titleKey="label.name" style="width: 35%" >
                        ${tableList.name}
                    </display:column>
                    <display:column headerClass="table_header"  escapeXml="false" sortable="true" sortName="description" titleKey="label.description" style="width: 20%" >
                        <str:truncateNicely upper="35">${tableList.description}</str:truncateNicely>
                    </display:column>
                    <display:column headerClass="table_header"  escapeXml="false" sortable="true" sortName="warehouse.name" titleKey="whm.warehouse" style="width: 15%" >
                        ${tableList.warehouse.name}
                    </display:column>
                    <display:column headerClass="table_header"  escapeXml="false" sortable="false" sortName="name" titleKey="label.plan.type" style="width: 15%" >
                        <c:if test="${tableList.production == 1}">Sản Xuất Lạnh/Kẽm</c:if>
                        <c:if test="${tableList.production == 2}">Sản Xuất Màu</c:if>
                        <c:if test="${tableList.production == 0}"><fmt:message key="label.maintain"/></c:if>
                    </display:column>
                    <display:column headerClass="table_header"  escapeXml="false" sortable="true" sortName="status" titleKey="label.status" style="width: 10%" >
                        <c:if test="${tableList.status == 1}"><fmt:message key="label.producing"/></c:if>
                        <c:if test="${tableList.status == 0}"><fmt:message key="label.done"/></c:if>
                    </display:column>
                    <display:column sortable="false" headerClass="table_header_center" titleKey="label.options" style="width: 8%; text-align:center">
                        <a href="${editUrl}?pojo.productionPlanID=${tableList.productionPlanID}" class="icon-edit tip-top" title="<fmt:message key="label.edit"/>"></a>
                        <security:authorize ifAnyGranted="ADMIN">
                            <span class="separator"></span>
                            <a name="deleteLink" onclick="warningDelete(this)" id="${tableList.productionPlanID}" href="#" class="icon-remove tip-top" title="<fmt:message key="label.delete"/>"></a>
                        </security:authorize>
                    </display:column>
                    <display:setProperty name="paging.banner.item_name">ca sản xuất - bảo dưỡng - sữa chữa</display:setProperty>
                    <display:setProperty name="paging.banner.items_name">ca sản xuất - bảo dưỡng - sữa chữa</display:setProperty>
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


