<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>

<head>
    <title><fmt:message key="whm.system.setting"/></title>
    <meta name="heading" content="<fmt:message key="whm.system.setting"/>"/>
</head>
<c:url var="url" value="/whm/system/setting.html"/>
<body>
<form:form commandName="items" action="${url}" method="post" id="itemsForm" name="itemsForm">
<div id="container-fluid data_content_box">
    <div class="row-fluid data_content">
        <div class="content-header">
            <fmt:message key="whm.system.setting"/>
        </div>
        <c:if test="${!empty messageResponse}">
            <div class="clear"></div>
            <div class="alert alert-success">
                <a class="close" data-dismiss="alert" href="#">x</a>
                    ${messageResponse}
            </div>
            <div style="clear:both;"></div>
        </c:if>
        <display:table name="items.settings" cellspacing="0" cellpadding="0" requestURI="${url}"
                       partialList="false" sort="external" size="${items.totalItems}"  uid="tableList" pagesize="${items.totalItems}" class="tableSadlier table-hover" export="false">
            <display:caption><fmt:message key='whm.system.setting.list'/></display:caption>
            <display:column headerClass="table_header"  escapeXml="false" sortable="false" titleKey="Name" style="width: 70%">
                <fmt:message key="${tableList.fieldName}"/>
                <input type="hidden" name="settings[${tableList_rowNum - 1}].fieldName" value="${tableList.fieldName}"/>
                <input type="hidden" name="settings[${tableList_rowNum - 1}].settingID" value="${tableList.settingID}"/>
            </display:column>

            <display:column headerClass="table_header"  escapeXml="false" sortable="true" sortName="name" titleKey="Value" style="width: 30%">
                <input type="text" name="settings[${tableList_rowNum - 1}].fieldValue" value="${tableList.fieldValue}"/>
            </display:column>
            <display:setProperty name="paging.banner.item_name" value=""/>
            <display:setProperty name="paging.banner.items_name" value=""/>
            <display:setProperty name="paging.banner.placement" value="bottom"/>
            <display:setProperty name="paging.banner.no_items_found" value=""/>
            <display:setProperty name="paging.banner.one_item_found" value=""/>
            <display:setProperty name="paging.banner.some_items_found" value=""/>
            <display:setProperty name="paging.banner.all_items_found" value=""/>
        </display:table>
        <div class="clear"></div>
        <div class="controls" style="margin-top: 10px;">
            <input type="hidden" name="crudaction" id="crudaction" value="insert-update"/>
            <a onclick="$('#itemsForm').submit();" class="btn btn-success btn-green" style="cursor: pointer;">
                <fmt:message key="button.update" />
            </a>
            <a class="cancel-link" id="cancelLink" href="<c:url value='/dcdt/scorecard/declare.html'/>">
                <fmt:message key="button.cancel"/>
            </a>
        </div>
    </div>
</div>
</form:form>
</body>

