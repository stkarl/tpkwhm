<%@ include file="/common/taglibs.jsp" %>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<head>
    <title>Xem lại danh sách vật tư nhập kho đầu kỳ</title>
    <meta name="heading" content="List User Import"/>
    <link rel="stylesheet" href="<c:url value='/themes/whm/css/jquery.jscrollpane.css' />" />
</head>

<body>
<c:set var="importSaveUrl" value="/whm/material/importsave.html"></c:set>
<c:set var="cancelUrl" value="/whm/material/import.html"></c:set>

<div id="container-fluid data_content_box">
    <div class="row-fluid data_content">
        <div class="content-header">
            Danh sách vật tư nhập kho đầu kỳ
        </div>
        <div class="button-actions">
            <a onclick="saveData('${importSaveUrl}');" class="btn btn-success">
                <i class="icon-plus"></i>
                Nhập dữ liệu
            </a>
            <a onclick="document.location.href='${cancelUrl}';" class="btn btn-inverse">
                <i class="icon-minus"></i>
                Hủy bỏ
            </a>
        </div>
        <div id="tbContent" style="width:100%">
            <display:table name="items.listResult" cellspacing="0" cellpadding="0" requestURI="${url}"
                           partialList="true" sort="external" size="${items.totalItems}" id="tableList" pagesize="${items.maxPageItems}" class="tableSadlier" export="false" style=" margin-top:12px;">
                <display:caption>Danh sách vật tư nhập đầu kỳ</display:caption>
                <display:column headerClass="table_header tableHeaderNowrap" escapeXml="true" sortable="false" titleKey="STT" class="${tableList.valid  ? '' : 'error'}"  style="width: 70px;white-space:nowrap;">
                    ${tableList_rowNum}
                </display:column>
                <display:column headerClass="table_header tableHeaderNowrap" property="name" escapeXml="true" sortable="false" titleKey="Tên" class="${tableList.valid  ? '' : 'error'}"  style="width: 70px;white-space:nowrap;" />
                <display:column headerClass="table_header tableHeaderNowrap" property="code" escapeXml="true" sortable="false" titleKey="Mã" class="${tableList.valid  ? '' : 'error'}" style="width: 70px;white-space:nowrap;" />
                <display:column headerClass="table_header tableHeaderNowrap" property="origin" escapeXml="true" sortable="false" titleKey="whm.origin.name" class="${tableList.valid  ? '' : 'error'}" style="width: 70px;white-space:nowrap;" />
                <display:column headerClass="table_header tableHeaderNowrap" property="market" escapeXml="true" sortable="false" titleKey="whm.market.name" class="${tableList.valid  ? '' : 'error'}" style="width: 70px;white-space:nowrap;" />
                <display:column headerClass="table_header tableHeaderNowrap" escapeXml="true" sortable="false" titleKey="label.quantity" class="${tableList.valid  ? '' : 'error'}" style="width: 70px;white-space:nowrap;">
                    <fmt:formatNumber value="${tableList.total}"/>
                </display:column>
                <display:column headerClass="table_header tableHeaderNowrap" property="unit" escapeXml="true" sortable="false" titleKey="label.unit" class="${tableList.valid  ? '' : 'error'}" style="width: 70px;white-space:nowrap;"/>
                <display:column headerClass="table_header tableHeaderNowrap" property="date" escapeXml="true" sortable="false" titleKey="label.import.date" class="${tableList.valid  ? '' : 'error'}" style="width: 70px;white-space:nowrap;" />
                <display:column headerClass="table_header tableHeaderNowrap" property="expiredDate" escapeXml="true" sortable="false" titleKey="label.expiredDate" class="${tableList.valid  ? '' : 'error'}" style="width: 70px;white-space:nowrap;" />
                <display:column headerClass="table_header tableHeaderNowrap" escapeXml="true" sortable="false" titleKey="label.price.vnd" class="${tableList.valid  ? '' : 'error'}" style="width: 70px;white-space:nowrap;">
                    <fmt:formatNumber value="${tableList.money}"/>
                </display:column>
                <%--<display:column headerClass="table_header tableHeaderNowrap" property="errorMessages" escapeXml="true" sortable="false" titleKey="Error Messages" class="${tableList.valid  ? '' : 'error'}" style="width: 70px;white-space:nowrap;" />--%>
                <display:setProperty name="paging.banner.item_name" value="vật tư "/>
                <display:setProperty name="paging.banner.items_name" value="vật tư"/>
                <display:setProperty name="paging.banner.placement" value="bottom"/>
                <display:setProperty name="paging.banner.no_items_found" value=""/>
            </display:table>
        </div>
        <div class="clear"></div>
    </div>
</div>
<script src="<c:url value="/themes/whm/scripts/bootstrap/jscrollpane.js"/>"></script>

<script type="text/javascript">
    $(document).ready(function(){
        $('#tbContent').jScrollPane();
    });

</script>
</body>