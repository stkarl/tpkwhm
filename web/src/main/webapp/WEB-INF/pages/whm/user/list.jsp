<%@ include file="/common/taglibs.jsp"%>
<%@page import="com.banvien.tpk.core.Constants" %>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>

<head>
    <title><fmt:message key="whm.user"/></title>
    <meta name="heading" content="<fmt:message key="whm.user"/>"/>
</head>

<c:url var="editUrl" value="/whm/user/edit.html"/>
<c:url var="setCustomerUrl" value="/whm/user/usercustomer.html"/>
<c:url var="setModuleUrl" value="/whm/user/usermodule.html"/>
<c:url var="setMaterialCateUrl" value="/whm/user/usermaterialcate.html"/>

<c:url var="url" value="/whm/user/list.html"/>
<c:url var="urlImport" value="/whm/user/import.html"/>

<body>
<form:form commandName="items" action="${url}" method="post" id="listForm">
    <div id="container-fluid data_content_box">
        <div class="row-fluid data_content">
            <div class="content-header">
                <fmt:message key="whm.user.list"/>
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
                            <td style="width: 15%"><fmt:message key="label.fullname"/></td>
                            <td style="width: 35%">
                                <form:input path="pojo.fullname" size="35"/>
                            </td>
                            <td style="width: 15%"><fmt:message key="label.username"/></td>
                            <td style="width: 35%">
                                <form:input path="pojo.userName" size="35"/>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 15%"><fmt:message key="whm.warehouse"/></td>
                            <td style="width: 35%">
                                <form:select path="pojo.warehouse.warehouseID">
                                    <form:option value="" ><fmt:message key="label.all" /></form:option>
                                    <c:forEach items="${warehouses}" var="warehouse">
                                        <form:option value="${warehouse.warehouseID}" label="${warehouse.name}" />
                                    </c:forEach>
                                </form:select>
                            </td>
                            <td style="width: 15%"><fmt:message key="label.role"/></td>
                            <td style="width: 35%">
                                <form:select path="pojo.role">
                                    <form:option value="" ><fmt:message key="label.all"/></form:option>
                                    <form:option value="NHANVIENKHO">Nhân viên kho</form:option>
                                    <form:option value="NHANVIENTT">Nhân viên trung tâm</form:option>
                                    <form:option value="TRUONGCA">Trưởng ca sản xuất</form:option>
                                    <form:option value="QUANLYKT">Quản lý kỹ thuật</form:option>
                                    <form:option value="NHANVIENKD">Nhân viên kinh doanh</form:option>
                                    <form:option value="QUANLYNO">Quản lý công nợ</form:option>
                                    <form:option value="QUANLYKHO">Quản lý kho</form:option>
                                    <form:option value="QUANLYTT">Quản lý trung tâm</form:option>
                                    <form:option value="QUANLYKD">Quản lý kinh doanh</form:option>
                                    <form:option value="LANHDAO">Lãnh đạo </form:option>
                                    <form:option value="ADMIN">Admin</form:option>
                                </form:select>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 15%"><fmt:message key="label.status"/></td>
                            <td style="width: 35%">
                                <form:select path="pojo.status">
                                    <form:option value="" ><fmt:message key="label.all"/></form:option>
                                    <form:option value="1" ><fmt:message key="label.active"/></form:option>
                                    <form:option value="0" ><fmt:message key="label.inactive"/></form:option>
                                </form:select>
                            </td>
                            <td colspan="2"></td>
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
                <a onclick="document.location.href='${editUrl}';" class="btn btn-primary">
                    <i class="icon-plus"></i>
                    <fmt:message key="button.add"/>
                </a>
            </div>
            <div class="clear"></div>
            <display:table name="items.listResult" cellspacing="0" cellpadding="0" requestURI="${url}"
                           partialList="true" sort="external" size="${items.totalItems}"  uid="tableList" pagesize="${items.maxPageItems}" class="tableSadlier table-hover" export="false">
                <display:caption><fmt:message key='whm.user.list'/></display:caption>
                <display:column headerClass="table_header" property="userName" escapeXml="true" sortable="true" sortName="userName" titleKey="label.username" style="width: 10%"/>
                <display:column headerClass="table_header"  escapeXml="false" sortable="true" sortName="fullname" titleKey="label.fullname" style="width: 15%" >
                    <security:authorize ifAnyGranted="ADMIN">
                    <a href="${editUrl}?pojo.userID=${tableList.userID}">${tableList.fullname}</a>
                    </security:authorize>
                    <security:authorize ifNotGranted="ADMIN">
                        ${tableList.fullname}
                    </security:authorize>
                </display:column>

                <display:column headerClass="table_header" property="userCode" escapeXml="true" sortable="true" sortName="usercode" titleKey="label.usercode" style="width: 10%"/>

                <display:column headerClass="table_header" property="email" escapeXml="true" sortable="true" sortName="email" titleKey="label.email" style="width: 20%"/>

                <display:column headerClass="table_header" property="role" escapeXml="true" sortable="true" sortName="role" titleKey="label.role" style="width: 10%"/>

                <display:column headerClass="table_header" sortName="status" escapeXml="true" sortable="true" titleKey="label.status" style="width:10%">
                    <c:choose>
                        <c:when test="${tableList.status == 1}">
                            <fmt:message key="label.active"/>
                        </c:when>
                        <c:otherwise>
                            <fmt:message key="label.inactive"/>
                        </c:otherwise>

                    </c:choose>
                </display:column>

                <display:column sortable="false"  headerClass="table_header_center" titleKey="label.assgin.role" style="width: 10%;text-align:center;">
                    <security:authorize ifAnyGranted="ADMIN">
                    <a href="${setModuleUrl}?userID=${tableList.userID}" class="icon-key tip-top" title="<fmt:message key="label.set.module"/>"></a>
                    <c:if test="${tableList.role eq Constants.NVKHO_ROLE || tableList.role eq Constants.TRUONGCA_ROLE}">
                        <span class="separator"></span>
                        <a href="${setMaterialCateUrl}?userID=${tableList.userID}" class="icon-cogs tip-top" title="<fmt:message key="label.set.materialcate"/>"></a>
                    </c:if>
                    </security:authorize>
                    <security:authorize ifAnyGranted="ADMIN,QUANLYKD">
                    <c:if test="${tableList.role eq Constants.NVKD_ROLE || tableList.role eq Constants.QLKD_ROLE || tableList.role eq Constants.QLCN_ROLE}">
                        <span class="separator"></span>
                        <a href="${setCustomerUrl}?userID=${tableList.userID}" class="icon-male tip-top" title="<fmt:message key="label.set.customer"/>"></a>
                    </c:if>
                    </security:authorize>
                </display:column>
                <security:authorize ifAnyGranted="ADMIN">
                <display:column sortable="false"  headerClass="table_header_center" url="/whm/user/edit.html"
                                titleKey="label.options" style="width: 10%;text-align:center;">
                    <a href="${editUrl}?pojo.userID=${tableList.userID}" class="icon-edit tip-top" title="<fmt:message key="label.edit"/>"></a>
                    <span class="separator"></span>
                    <a name="deleteLink" onclick="warningDelete(this)" id="${tableList.userID}" href="#" class="icon-remove tip-top" title="<fmt:message key="label.delete"/>"></a>
                </display:column>
                </security:authorize>

                <display:setProperty name="paging.banner.item_name"><fmt:message key= "whm.user.name"/></display:setProperty>
                <display:setProperty name="paging.banner.items_name" ><fmt:message key= "whm.user.name"/></display:setProperty>
                <display:setProperty name="paging.banner.placement" value="bottom"/>
                <display:setProperty name="paging.banner.no_items_found" value=""/>
            </display:table>
            <div class="clear"></div>

        </div>
    </div>

</form:form>
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

    function exportData() {
        $('#crudaction').val('export');
        $('#listForm').submit();
        $('#crudaction').val('doReport');
    }
</script>
</body>
