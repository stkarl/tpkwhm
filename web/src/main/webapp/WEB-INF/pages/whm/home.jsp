<%@ include file="/common/taglibs.jsp" %>
<head>
    <title><fmt:message key="title.home"/></title>
    <meta name="heading" content="<fmt:message key='title.home'/>"/>
    <link rel="stylesheet" href="<c:url value='/themes/whm/css/jquery.jscrollpane.css' />" />

</head>
<body>
<div class="row-fluid data_content">
    <c:if test="${fn:length(warningProducts) > 0 || fn:length(warningMaterials) > 0  || fn:length(warningMachines) > 0  || fn:length(warningComponents) > 0 }">
        <div class="content-header" style="text-align: center;width: 100%;"><fmt:message key="warning.dashboard"/></div>
        <div class="clear"></div>
    </c:if>
    <c:if test="${fn:length(warningProducts) > 0}">
        <div id="tbProduct" style="max-height:400px;margin:0 0 1.5em 0;">
            <display:table name="warningProducts" cellspacing="0" cellpadding="0" requestURI="${url}"
                           partialList="true" sort="external" size="${fn:length(warningProducts)}"
                           uid="tableList" excludedParams="crudaction"
                           pagesize="${fn:length(warningProducts)}" export="false" class="tableSadlier table-hover">
                <display:caption><fmt:message key='list.warning.product'/></display:caption>
                <display:column headerClass="table_header_center" property="productname.name" sortable="false" sortName="productname.name" titleKey="whm.productname.name" class="text-center" style="width: 7%;"/>
                <display:column headerClass="table_header_center" property="productCode" titleKey="label.number" class="text-center" style="width: 7%;"/>

                <display:column headerClass="table_header_center" property="size.name" sortable="false" sortName="size.name" titleKey="whm.size.name" class="text-center" style="width: 7%;"/>
                <display:column headerClass="table_header_center" property="thickness.name" sortable="false" sortName="thickness.name" titleKey="whm.thickness.name" class="text-center" style="width: 7%;"/>
                <display:column headerClass="table_header_center" property="colour.name" sortable="false" sortName="colour.name" titleKey="whm.colour.name" class="text-center" style="width: 7%;"/>
                <display:column headerClass="table_header_center" property="overlaytype.name" sortable="false" sortName="overlaytype.name" titleKey="whm.overlaytype.name" class="text-center" style="width: 7%;"/>
                <display:column headerClass="table_header large" sortName="quantity1" sortable="false" titleKey="label.quantity.meter" style="width: 10%;text-align:right;">
                    <fmt:formatNumber value="${tableList.quantity1}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/>
                </display:column>
                <display:column headerClass="table_header large" sortName="quantity2Pure" sortable="false" titleKey="label.quantity.kg" style="width: 10%;text-align:right;">
                    <fmt:formatNumber value="${tableList.quantity2Pure}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/>
                </display:column>

                <display:column headerClass="table_header large" property="warehouse.name" titleKey="whm.warehouse.name" sortName="warehouse.name" sortable="false" style="width: 10%;"/>
                <display:column headerClass="table_header_center" sortable="false" titleKey="import.warehouse.date" class="text-center" style="width: 7%;">
                <span style="color: red;font-weight: bold;"><c:choose>
                    <c:when test="${not empty tableList.importDate}">
                        <fmt:formatDate value="${tableList.importDate}" pattern="dd/MM/yyyy"/>
                    </c:when>
                    <c:when test="${not empty tableList.produceDate}">
                        <fmt:formatDate value="${tableList.produceDate}" pattern="dd/MM/yyyy"/>
                    </c:when>
                    <c:otherwise>-</c:otherwise>
                </c:choose></span>
                </display:column>
                <display:setProperty name="paging.banner.all_items_found" value=""/>
                <display:setProperty name="paging.banner.one_item_found" value=""/>
                <display:setProperty name="paging.banner.no_item_found" value=""/>
            </display:table>
        </div>
    </c:if>

    <c:if test="${fn:length(warningMaterials) > 0}">
        <div id="tbMaterial" style="max-height:400px;margin:0 0 1.5em 0;">
            <display:table name="warningMaterials" cellspacing="0" cellpadding="0" requestURI="${url}"
                           partialList="true" sort="external" size="${fn:length(warningMaterials)}"
                           uid="tableList" excludedParams="crudaction"
                           pagesize="${fn:length(warningMaterials)}" export="false" class="tableSadlier table-hover">
                <display:caption><fmt:message key='list.warning.material'/></display:caption>
                <display:column headerClass="table_header_center" property="material.name" sortable="false" sortName="material.name" titleKey="whm.material.name" class="text-center" style="width: 10%;"/>
                <display:column headerClass="table_header_center" property="code" titleKey="label.number" class="text-center" style="width: 7%;"/>
                <display:column headerClass="table_header_center" property="origin.name" sortable="false" sortName="origin.name" titleKey="whm.origin.name" class="text-center" style="width: 10%;"/>

                <display:column headerClass="table_header large" sortName="remainQuantity" sortable="false" titleKey="label.quantity" style="width: 10%;text-align:right;">
                    <span style="color: red;font-weight: bold;"><fmt:formatNumber value="${tableList.remainQuantity}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/> (${tableList.material.unit.name})</span>
                </display:column>
                <display:column headerClass="table_header large" property="warehouse.name" titleKey="whm.warehouse.name" sortName="warehouse.name" sortable="false" style="width: 10%;"/>
                <display:column headerClass="table_header_center" sortable="false" titleKey="import.warehouse.date" class="text-center" style="width: 7%;">
                    <fmt:formatDate value="${tableList.importDate}" pattern="dd/MM/yyyy"/>
                </display:column>

                <display:column headerClass="table_header_center" sortable="false" titleKey="label.expiredDate" class="text-center" style="width: 7%;">
                    <span style="color: red;font-weight: bold;"><fmt:formatDate value="${tableList.expiredDate}" pattern="dd/MM/yyyy"/></span>
                </display:column>

                <display:setProperty name="paging.banner.all_items_found" value=""/>
                <display:setProperty name="paging.banner.one_item_found" value=""/>
                <display:setProperty name="paging.banner.no_item_found" value=""/>
            </display:table>
        </div>
    </c:if>

    <c:if test="${fn:length(warningMachines) > 0}">
        <display:table name="warningMachines" cellspacing="0" cellpadding="0" requestURI="${url}"
                       partialList="true" sort="external" size="${fn:length(warningMachines)}"
                       uid="tableList" excludedParams="crudaction"
                       pagesize="${fn:length(warningMachines)}" export="false" class="tableSadlier table-hover">
            <display:caption><fmt:message key='list.warning.machine'/></display:caption>
            <display:column headerClass="table_header_center" property="name" sortable="false" sortName="material.name" titleKey="label.name" class="text-center" style="width: 15%;"/>
            <display:column headerClass="table_header_center" property="code" titleKey="label.code" class="text-center" style="width: 5%;"/>
            <display:column headerClass="table_header_center" sortable="false" sortName="origin.name" titleKey="label.description" class="text-center" style="width: 35%;">
                <str:truncateNicely upper="65">${tableList.description}</str:truncateNicely>
            </display:column>
            <%--<display:column headerClass="table_header_center" property="warehouse.name" sortable="false" titleKey="whm.warehouse.name" class="text-center" style="width: 7%;"/>--%>

            <display:column headerClass="table_header_center" sortable="false" titleKey="need.maintain.date" class="text-center" style="width: 15%;">
                <span style="color: red;font-weight: bold;"><fmt:formatDate value="${tableList.needMaintainDate}" pattern="dd/MM/yyyy"/></span>
            </display:column>
            <display:column headerClass="table_header_center" sortable="false" titleKey="label.status" class="text-center" style="width: 15%;">
                <c:if test="${tableList.status eq Constants.MACHINE_NORMAL}">
                    <fmt:message key="label.normal"/>
                </c:if>
                <c:if test="${tableList.status eq Constants.MACHINE_WARNING}">
                    <span style="color: red;font-weight: bold;"><fmt:message key="label.need.maintenance"/></span>
                </c:if>
            </display:column>
            <display:setProperty name="paging.banner.all_items_found" value=""/>
            <display:setProperty name="paging.banner.one_item_found" value=""/>
            <display:setProperty name="paging.banner.no_item_found" value=""/>
        </display:table>
    </c:if>

    <c:if test="${fn:length(warningComponents) > 0}">
        <display:table name="warningComponents" cellspacing="0" cellpadding="0" requestURI="${url}"
                       partialList="true" sort="external" size="${fn:length(warningComponents)}"
                       uid="tableList" excludedParams="crudaction"
                       pagesize="${fn:length(warningComponents)}" export="false" class="tableSadlier table-hover">
            <display:caption><fmt:message key='list.warning.component'/></display:caption>
            <display:column headerClass="table_header_center" property="name" sortable="false" titleKey="label.name" class="text-center" style="width: 15%;"/>
            <display:column headerClass="table_header_center" property="code" titleKey="label.code" class="text-center" style="width: 5%;"/>
            <display:column headerClass="table_header_center" sortable="false" sortName="origin.name" titleKey="label.description" class="text-center" style="width: 35%;">
                <str:truncateNicely upper="65">${tableList.description}</str:truncateNicely>
            </display:column>
            <%--<display:column headerClass="table_header_center" property="warehouse.name" sortable="false" titleKey="whm.warehouse.name" class="text-center" style="width: 7%;"/>--%>

            <display:column headerClass="table_header_center" sortable="false" titleKey="need.maintain.date" class="text-center" style="width: 15%;">
                <span style="color: red;font-weight: bold;"><fmt:formatDate value="${tableList.needMaintainDate}" pattern="dd/MM/yyyy"/></span>
            </display:column>
            <display:column headerClass="table_header_center" sortable="false" titleKey="label.status" class="text-center" style="width: 15%;">
                <c:if test="${tableList.status eq Constants.MACHINE_NORMAL}">
                    <fmt:message key="label.normal"/>
                </c:if>
                <c:if test="${tableList.status eq Constants.MACHINE_WARNING}">
                    <span style="color: red;font-weight: bold;"><fmt:message key="label.need.maintenance"/></span>
                </c:if>
            </display:column>
            <display:setProperty name="paging.banner.all_items_found" value=""/>
            <display:setProperty name="paging.banner.one_item_found" value=""/>
            <display:setProperty name="paging.banner.no_item_found" value=""/>
        </display:table>
    </c:if>



</div>




<script type="text/javascript" src="<c:url value='/scripts/jquery/jquery.mousewheel.js'/>"></script>
<script src="<c:url value="/themes/whm/scripts/bootstrap/jscrollpane.js"/>"></script>
<script>
    $(document).ready(function(){
        $('#tbProduct').jScrollPane();
        $('#tbMaterial').jScrollPane();
    });
</script>

</body>
