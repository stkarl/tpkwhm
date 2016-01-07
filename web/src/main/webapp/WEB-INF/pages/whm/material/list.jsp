<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<head>
    <title><fmt:message key="whm.material.list"/></title>
    <meta name="heading" content="<fmt:message key="whm.material.list"/>"/>
</head>

<c:url var="url" value="/whm/material/list.html"/>
<c:url var="editUrl" value="/whm/material/edit.html"/>
<div id="content">
    <form:form commandName="items" action="${url}" method="post" id="listForm" name="listForm">
        <div id="container-fluid data_content_box">
            <div class="row-fluid data_content">
                <div class="content-header">
                    <fmt:message key="whm.material.list"/>
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
                                <td ><fmt:message key="whm.materialcategory.name"/></td>
                                <td>
                                    <form:select path="materialCategoryID">
                                        <form:option value="-1">Tất cả</form:option>
                                        <form:options items="${materialcategorys}" itemValue="materialCategoryID" itemLabel="name"/>
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
                               partialList="true" sort="external" size="${items.totalItems}"  uid="tableList" pagesize="${items.maxPageItems}" class="tableSadlier table-hover" export="false">
                    <display:caption><fmt:message key='whm.material.list'/></display:caption>
                    <display:column headerClass="table_header"  escapeXml="false" sortable="true" sortName="name" titleKey="label.name" style="width: 20%" >
                        ${tableList.name}
                    </display:column>
                    <display:column headerClass="table_header"  escapeXml="false" sortable="true" sortName="unit.name" titleKey="whm.unit.name" style="width: 10%" >
                        ${tableList.unit.name}
                    </display:column>
                    <display:column headerClass="table_header"  escapeXml="false" sortable="true" sortName="price" titleKey="label.price" style="width: 10%" >
                        <fmt:formatNumber value="${tableList.price}"/>
                    </display:column>
                    <display:column headerClass="table_header"  escapeXml="false" sortable="false" titleKey="whm.materialcategory.name" style="width: 45%" >
                        <%--<str:truncateNicely upper="50">--%>
                        <c:forEach items="${tableList.materialAndCategories}" var="materialAndCategory" varStatus="status">
                           ${materialAndCategory.materialCategory.name} <c:if test="${status.index + 1< fn:length(tableList.materialAndCategories)}">/ </c:if>
                        </c:forEach>
                        <%--</str:truncateNicely>--%>
                    </display:column>
                    <display:column sortable="false" headerClass="table_header_center" titleKey="label.options" style="width: 15%; text-align:center">
                        <a href="${editUrl}?pojo.materialID=${tableList.materialID}" class="icon-edit tip-top" title="<fmt:message key="label.edit"/>"></a>
                        <security:authorize ifAnyGranted="ADMIN">
                            <span class="separator"></span>
                            <a name="deleteLink" href="<c:url value='/whm/material/list.html'><c:param name="checkList" value="${tableList.materialID}"/><c:param name="crudaction" value="delete"/></c:url>" class="icon-remove tip-top" title="<fmt:message key="label.delete"/>"></a>
                        </security:authorize>
                    </display:column>
                    <display:setProperty name="paging.banner.item_name"><fmt:message key= "whm.material.name"/></display:setProperty>
                    <display:setProperty name="paging.banner.items_name"><fmt:message key= "whm.material.name"/></display:setProperty>
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


