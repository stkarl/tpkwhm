<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@page import="com.banvien.tpk.core.Constants" %>

<head>
    <title><fmt:message key="whm.machine.list"/></title>
    <meta name="heading" content="<fmt:message key="whm.machine.list"/>"/>
</head>

<c:url var="url" value="/whm/machine/list.html"/>
<c:url var="editUrl" value="/whm/machine/edit.html"/>
<c:url var="viewDetailUrl" value="/whm/machine/viewdetail.html"/>
<div id="content">
    <form:form commandName="items" action="${url}" method="post" id="listForm" name="listForm">
        <div id="container-fluid data_content_box">
            <div class="row-fluid data_content">
                <div class="content-header">
                    <fmt:message key="whm.machine.list"/>
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
                                <td class="label-field"><fmt:message key="label.name"/> máy</td>
                                <td><form:input path="pojo.name" size="40"/></td>
                                <td class="label-field"><fmt:message key="label.code"/> máy</td>
                                <td><form:input path="pojo.code" size="40"/></td>
                            </tr>

                            <tr>
                                <td class="label-field">Tên linh kiện</td>
                                <td><form:input path="componentName" size="40"/></td>
                                <td class="label-field">Mã linh kiện</td>
                                <td><form:input path="componentCode" size="40"/></td>
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
                <security:authorize ifAnyGranted="MAY_THIET_BI">
                    <div class="button-actions">
                        <a class="btn btn-primary " onclick="document.location.href='${editUrl}';"><i class="icon-plus"></i> <fmt:message key="button.add"/></a>
                    </div>
                </security:authorize>
                <div class="clear"></div>
                <display:table name="items.listResult" cellspacing="0" cellpadding="0" requestURI="${url}"
                               partialList="true" sort="external" size="${items.totalItems}"  uid="tableList" pagesize="${items.maxPageItems}" class="tableSadlier table-hover" export="false">
                    <display:caption><fmt:message key='whm.machine.list'/></display:caption>
                    <display:column headerClass="table_header"  escapeXml="false" sortable="true" sortName="name" titleKey="label.name" style="width: 15%" >
                        ${tableList.name}
                    </display:column>
                    <display:column headerClass="table_header"  escapeXml="false" sortable="true" sortName="code" titleKey="label.code" style="width: 10%" >
                        ${tableList.code}
                    </display:column>
                    <display:column headerClass="table_header"  escapeXml="false" sortable="true" sortName="description" titleKey="label.description" style="width: 35%" >
                        ${tableList.description}
                    </display:column>
                    <display:column headerClass="table_header"  escapeXml="false" sortable="true" sortName="warehouse.name" titleKey="whm.warehouse.name" style="width: 15%" >
                        ${tableList.warehouse.name}
                    </display:column>
                    <display:column headerClass="table_header"  escapeXml="false" sortable="true" sortName="status" titleKey="label.status" style="width: 10%" >
                        <c:choose>
                            <c:when test="${tableList.status == Constants.MACHINE_NORMAL}">
                                <fmt:message key="label.normal"/>
                            </c:when>
                            <c:when test="${tableList.status == Constants.MACHINE_STOP}">
                                <fmt:message key="label.machine.stop"/>
                            </c:when>
                            <c:otherwise>
                                <fmt:message key="label.need.maintenance"/>
                            </c:otherwise>
                        </c:choose>
                    </display:column>
                    <display:column headerClass="table_header"  escapeXml="false" sortable="true" sortName="confirmStatus" titleKey="label.confirm.status" style="width: 10%" >
                        <c:choose>
                            <c:when test="${tableList.confirmStatus == Constants.MACHINE_SUBMIT}">
                               Chờ duyệt
                            </c:when>
                            <c:when test="${tableList.confirmStatus == Constants.MACHINE_REJECTED}">
                               Bị từ chối
                            </c:when>
                            <c:when test="${tableList.confirmStatus == Constants.MACHINE_APPROVED_1}">
                                Kỹ thuật duyệt
                            </c:when>
                            <c:when test="${tableList.confirmStatus == Constants.MACHINE_APPROVED_2}">
                                Lãnh đạo duyệt
                            </c:when>
                            <c:otherwise>
                                Đang soạn thảo
                            </c:otherwise>
                        </c:choose>
                    </display:column>
                    <display:column sortable="false" headerClass="table_header_center" titleKey="label.options" style="width: 10%; text-align:center">
                        <a href="${viewDetailUrl}?pojo.machineID=${tableList.machineID}" class="icon-eye-open tip-top" title="<fmt:message key="label.view.detail"/>"></a>
                        <c:if test="${empty tableList.confirmStatus || tableList.confirmStatus < Constants.MACHINE_SUBMIT}">
                            <c:if test="${tableList.createdBy.userID eq items.loginID}">
                                <security:authorize ifAnyGranted="MAY_THIET_BI">
                                    <span class="separator"></span>
                                    <a href="${editUrl}?pojo.machineID=${tableList.machineID}" class="icon-edit tip-top" title="<fmt:message key="label.edit"/>"></a>
                                </security:authorize>
                            </c:if>
                            <security:authorize ifAnyGranted="ADMIN">
                                <span class="separator"></span>
                                <a name="deleteLink" onclick="warningDelete(this)" id="${tableList.machineID}" href="#" class="icon-remove tip-top" title="<fmt:message key="label.delete"/>"></a>
                            </security:authorize>
                            <security:authorize ifNotGranted="ADMIN">
                                <c:if test="${tableList.createdBy.userID eq items.loginID}">
                                    <span class="separator"></span>
                                    <a name="deleteLink" onclick="warningDelete(this)" id="${tableList.machineID}" href="#" class="icon-remove tip-top" title="<fmt:message key="label.delete"/>"></a>
                                </c:if>
                            </security:authorize>
                        </c:if>

                    </display:column>
                    <display:setProperty name="paging.banner.item_name"><fmt:message key= "whm.machine.name"/></display:setProperty>
                    <display:setProperty name="paging.banner.items_name"><fmt:message key= "whm.machine.name"/></display:setProperty>
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


