<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>


<head>
    <title><fmt:message key="user.materialcate.title"/></title>
    <meta name="heading" content="<fmt:message key="user.materialcate.title"/>"/>
</head>

<c:url var="backUrl" value="/whm/user/list.html"/>
<c:url var="url" value="/whm/user/usermaterialcate.html"/>

<body>
<form:form commandName="items" action="${url}" method="post" id="listForm">
    <div id="container-fluid data_content_box">
        <div class="row-fluid data_content">
            <div class="content-header">
                <fmt:message key="user.materialcate.title"/> - ${user.fullname}
            </div>
            <div class="clear"></div>
            <c:if test="${not empty messageResponse}">
                <div class="alert alert-${alertType}">
                    <button aria-hidden="true" data-dismiss="alert" class="close" type="button">x</button>
                        ${messageResponse}
                </div>
            </c:if>
            <div class="clear"></div>
            <div class="button-actions">
                <a onclick="document.location.href='${backUrl}';" class="btn">
                    <i class="icon-backward"></i>
                    <fmt:message key="button.back"/>
                </a>
                <a onclick="update();" class="btn btn-success">
                    <i class="icon-save"></i>
                    <fmt:message key="button.update"/>
                </a>
            </div>
            <div class="clear"></div>
            <display:table name="items.listResult" cellspacing="0" cellpadding="0" requestURI="${url}"
                           partialList="false" sort="external" size="${items.totalItems}"  uid="tableList" pagesize="${items.maxPageItems}" class="tableSadlier" export="false">
                <display:column headerClass="table_header"  escapeXml="false" sortable="false" title="<input type=\"checkbox\" onclick=\"checkAll('check_materialcate', this);\"/>" style="width: 5%">
                    <input class="check_materialcate" type="checkbox" name="materialCateIDs" value="${tableList.materialCategoryID}" ${assignedMaterialCates[tableList.materialCategoryID] eq true ? "checked=\"checked\"" : ""}/>
                </display:column>
                <display:column headerClass="table_header"  escapeXml="false" sortable="false" titleKey="whm.materialcategory.name">
                   ${tableList.name}
                </display:column>
                <display:column headerClass="table_header"  escapeXml="false" sortable="false" titleKey="label.description">
                    ${tableList.description}
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
            <form:hidden path="userID"/>
            <form:hidden path="crudaction" id="crudaction"/>
        </div>
    </div>
</form:form>
<script type="text/javascript">
    function update(){
        $('#crudaction').val('update');
        submitForm('listForm');
    }
    <c:if test="${not empty items.crudaction}">
    highlightTableRows("tableList");
    </c:if>

    function checkAll(clsName, thisElement){
        var isChecked = $(thisElement).is(":checked");
        if(isChecked){
            $("." + clsName).each(function(index, value){
                $(this).attr("checked", true);
                $(this).parent("span").addClass("checked")
            });
        }else{
            $("." + clsName).each(function(index, value){
                $(this).attr("checked", false);
                $(this).parent("span").removeClass("checked")
            });
        }
    }

</script>
</body>
