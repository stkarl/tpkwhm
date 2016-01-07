<%@ include file="/common/taglibs.jsp" %>


<head>
    <title>List User Import</title>
    <meta name="heading" content="List User Import"/>
</head>

<body>
<c:set var="importSaveUrl" value="/dcdt/user/importsave.html"></c:set>
<c:set var="cancelUrl" value="/dcdt/user/import.html"></c:set>
<div id="breadcrumb">
    <a href='<c:url value="/dcdt/assessmentkpicategory/list.html"/>' title="Go to Home" class="tip-bottom firstLink"><i class="icon-home"></i> Home</a>
    <a href="/dcdt/user/import.html" class="tip-bottom" title="Import User">Import User</a>
    <a href="#" class="current tip-bottom" title="Import User List">Import User List</a>
</div>
<div id="container-fluid data_content_box">
    <div class="row-fluid data_content">
        <div class="content-header">
            List User Import
        </div>
        <div class="button-actions">
            <a onclick="saveData('${importSaveUrl}');" class="btn">
                <i class="icon-plus"></i>
                Import
            </a>
            <a onclick="document.location.href='${cancelUrl}';" class="btn">
                <i class="icon-minus"></i>
                Cancel
            </a>
        </div>
        <display:table name="items.listResult" cellspacing="0" cellpadding="0" requestURI="${url}"
                       partialList="true" sort="external" size="${items.totalItems}" id="tableList" pagesize="${items.maxPageItems}" class="tableSadlier" export="false">
            <display:column headerClass="table_header tableHeaderNowrap" property="rsmName" escapeXml="true" sortable="false" titleKey="RSM Name" class="${tableList.valid  ? '' : 'error'}"  style="width: 70px;white-space:nowrap;" />
            <display:column headerClass="table_header tableHeaderNowrap" property="asmName" escapeXml="true" sortable="false" titleKey="ASM Name" class="${tableList.valid  ? '' : 'error'}" style="width: 70px;white-space:nowrap;" />
            <display:column headerClass="table_header tableHeaderNowrap" property="seName" escapeXml="true" sortable="false" titleKey="SE Name" class="${tableList.valid  ? '' : 'error'}" style="width: 70px;white-space:nowrap;" />
            <display:column headerClass="table_header tableHeaderNowrap" property="smName" escapeXml="true" sortable="false" titleKey="SM Name" class="${tableList.valid  ? '' : 'error'}" style="width: 70px;white-space:nowrap;" />
            <display:column headerClass="table_header tableHeaderNowrap" property="errorMessages" escapeXml="true" sortable="false" titleKey="Error Messages" class="${tableList.valid  ? '' : 'error'}" style="width: 70px;white-space:nowrap;" />

            <display:setProperty name="paging.banner.item_name" value="User "/>
            <display:setProperty name="paging.banner.items_name" value="Users"/>
            <display:setProperty name="paging.banner.placement" value="bottom"/>
            <display:setProperty name="paging.banner.no_items_found" value=""/>
        </display:table>
        <div class="clear"></div>
    </div>
</div>

<script type="text/javascript">

</script>
</body>