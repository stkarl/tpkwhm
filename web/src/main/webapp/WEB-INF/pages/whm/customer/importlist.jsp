<%@ include file="/common/taglibs.jsp" %>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<head>
    <title>Xem lại danh sách dữ liệu khách hàng</title>
    <meta name="heading" content="List User Import"/>
    <link rel="stylesheet" href="<c:url value='/themes/whm/css/jquery.jscrollpane.css' />" />
</head>

<body>
<c:set var="importSaveUrl" value="/whm/customer/importsave.html"></c:set>
<c:set var="cancelUrl" value="/whm/customer/import.html"></c:set>

<div id="container-fluid data_content_box">
    <div class="row-fluid data_content">
        <div class="content-header">
            Danh sách dữ liệu khách hàng
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
                <display:caption>Danh sách khách hàng</display:caption>
                <display:column headerClass="table_header tableHeaderNowrap" escapeXml="true" sortable="false" titleKey="STT" class="${tableList.valid  ? '' : 'error'}"  style="width: 70px;white-space:nowrap;">
                    ${tableList_rowNum}
                </display:column>
                <display:column headerClass="table_header tableHeaderNowrap" property="userName" escapeXml="true" sortable="false" titleKey="Nhân viên" class="${tableList.valid  ? '' : 'error'}"  style="width: 70px;white-space:nowrap;" />
                <display:column headerClass="table_header tableHeaderNowrap" property="customerName" escapeXml="true" sortable="false" titleKey="Khách hàng" class="${tableList.valid  ? '' : 'error'}"  style="width: 70px;white-space:nowrap;" />
                <display:column headerClass="table_header tableHeaderNowrap" property="companyName" escapeXml="true" sortable="false" titleKey="Tên công ty" class="${tableList.valid  ? '' : 'error'}" style="width: 70px;white-space:nowrap;" />
                <display:column headerClass="table_header tableHeaderNowrap" property="companyTel" escapeXml="true" sortable="false" titleKey="ĐT Cty" class="${tableList.valid  ? '' : 'error'}" style="width: 70px;white-space:nowrap;" />
                <display:column headerClass="table_header tableHeaderNowrap" property="fax" escapeXml="true" sortable="false" titleKey="Fax" class="${tableList.valid  ? '' : 'error'}" style="width: 70px;white-space:nowrap;" />
                <display:column headerClass="table_header tableHeaderNowrap" property="address" escapeXml="true" sortable="false" titleKey="Địa chỉ" class="${tableList.valid  ? '' : 'error'}" style="width: 70px;white-space:nowrap;" />
                <display:column headerClass="table_header tableHeaderNowrap" property="province" escapeXml="true" sortable="false" titleKey="Tỉnh" class="${tableList.valid  ? '' : 'error'}" style="width: 70px;white-space:nowrap;" />
                <display:column headerClass="table_header tableHeaderNowrap" property="contact" escapeXml="true" sortable="false" titleKey="Người liên hệ" class="${tableList.valid  ? '' : 'error'}" style="width: 70px;white-space:nowrap;" />
                <display:column headerClass="table_header tableHeaderNowrap" property="contactPhone" escapeXml="true" sortable="false" titleKey="Điện thoại" class="${tableList.valid  ? '' : 'error'}" style="width: 70px;white-space:nowrap;" />
                <display:column headerClass="table_header tableHeaderNowrap" property="birthday" escapeXml="true" sortable="false" titleKey="Ngày sinh" class="${tableList.valid  ? '' : 'error'}" style="width: 70px;white-space:nowrap;">
                </display:column>
                <display:column headerClass="table_header tableHeaderNowrap" escapeXml="true" sortable="false" titleKey="Hạn mức nợ" class="${tableList.valid  ? '' : 'error'}" style="width: 70px;white-space:nowrap;" >
                    <fmt:formatNumber value="${tableList.oweLimit}"/>
                </display:column>
                <display:column headerClass="table_header tableHeaderNowrap" escapeXml="true" sortable="false" titleKey="SD nợ 2013" class="${tableList.valid  ? '' : 'error'}" style="width: 70px;white-space:nowrap;" >
                    <fmt:formatNumber value="${tableList.owePast}"/>
                </display:column>
                <display:column headerClass="table_header tableHeaderNowrap" escapeXml="true" sortable="false" titleKey="Mua 2014" class="${tableList.valid  ? '' : 'error'}" style="width: 70px;white-space:nowrap;">
                    <fmt:formatNumber value="${tableList.oweCurrent}"/>
                </display:column>
                <display:column headerClass="table_header tableHeaderNowrap" escapeXml="true" sortable="false" titleKey="Trả 2014" class="${tableList.valid  ? '' : 'error'}" style="width: 70px;white-space:nowrap;">
                    <fmt:formatNumber value="${tableList.payCurrent}"/>
                </display:column>
                <display:column headerClass="table_header tableHeaderNowrap" property="oweDate" escapeXml="true" sortable="false" titleKey="Ngày chốt" class="${tableList.valid  ? '' : 'error'}" style="width: 70px;white-space:nowrap;">
                </display:column>
                <display:setProperty name="paging.banner.item_name" value="khách hàng"/>
                <display:setProperty name="paging.banner.items_name" value="khách hàng"/>
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