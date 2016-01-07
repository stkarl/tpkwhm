<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@page import="com.banvien.tpk.core.Constants" %>

<head>
    <title><fmt:message key="whm.machinecomponent.list"/></title>
    <meta name="heading" content="<fmt:message key="whm.machinecomponent.list"/>"/>
</head>

<c:url var="url" value="/whm/machinecomponent/list.html"/>
<c:url var="editUrl" value="/whm/machinecomponent/edit.html"/>
<c:url var="viewDetailUrl" value="/whm/machinecomponent/view.html"/>
<div id="content">
    <form:form commandName="items" action="${url}" method="post" id="listForm" name="listForm">
        <div id="container-fluid data_content_box">
            <div class="row-fluid data_content">
                <div class="content-header">
                    <fmt:message key="whm.machinecomponent.list"/>
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
                                <td class="label-field"><fmt:message key="label.name"/></td>
                                <td><form:input path="pojo.name" size="40"/></td>
                                <td class="label-field"><fmt:message key="whm.machine.name"/></td>
                                <td>
                                    <form:select path="pojo.machine.machineID">
                                        <form:option value="-1">Tất cả</form:option>
                                        <form:options items="${machines}" itemValue="machineID" itemLabel="name"/>
                                    </form:select>
                                </td>
                            </tr>
                            <tr>
                                <td class="label-field"><fmt:message key="label.code"/></td>
                                <td><form:input path="pojo.code" size="40"/></td>
                                <td class="label-field"></td>
                                <td>

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
                    <%--<div class="clear"></div>--%>
                    <%--<div class="button-actions">--%>

                    <%--<a class="btn btn-primary " onclick="document.location.href='${editUrl}';"><i class="icon-plus"></i> <fmt:message key="button.add"/></a>--%>
                    <%--</div>--%>
                <div class="clear"></div>
                <display:table name="items.listResult" cellspacing="0" cellpadding="0" requestURI="${url}"
                               partialList="true" sort="external" size="${items.totalItems}"  uid="tableList" pagesize="${items.maxPageItems}" class="tableSadlier table-hover" export="false">
                    <display:caption><fmt:message key='whm.machinecomponent.list'/></display:caption>
                    <display:column headerClass="table_header"  escapeXml="false" sortable="true" sortName="name" titleKey="label.name" style="width: 15%" >
                        ${tableList.name}
                    </display:column>
                    <display:column headerClass="table_header"  escapeXml="false" sortable="true" sortName="code" titleKey="label.code" style="width: 10%" >
                        ${tableList.code}
                    </display:column>
                    <display:column headerClass="table_header"  escapeXml="false" sortable="true" sortName="description" titleKey="label.description" style="width: 30%" >
                        ${tableList.description}
                    </display:column>
                    <display:column headerClass="table_header"  escapeXml="false" sortable="false" sortName="machine.name" titleKey="whm.machine.or.component.name" style="width: 20%" >
                        <c:if test="${!empty tableList.machine.name}">
                            ${tableList.machine.name}
                        </c:if>
                        <c:if test="${!empty tableList.parent.name}">
                            ${tableList.parent.name}
                        </c:if>
                    </display:column>
                    <display:column headerClass="table_header"  escapeXml="false" sortable="false" sortName="status" titleKey="label.status" style="width: 8%" >
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
                    <display:column headerClass="table_header"  escapeXml="false" sortable="false" sortName="confirmStatus" titleKey="label.confirm.status" style="width: 10%" >
                        <c:choose>
                            <c:when test="${tableList.machine.confirmStatus == Constants.MACHINE_SUBMIT}">
                                Chờ duyệt
                            </c:when>
                            <c:when test="${tableList.machine.confirmStatus == Constants.MACHINE_REJECTED}">
                                Bị từ chối
                            </c:when>
                            <c:when test="${tableList.machine.confirmStatus == Constants.MACHINE_APPROVED_1}">
                                Kỹ thuật duyệt
                            </c:when>
                            <c:when test="${tableList.machine.confirmStatus == Constants.MACHINE_APPROVED_2}">
                                Lãnh đạo duyệt
                            </c:when>
                            <c:otherwise>
                                Đang soạn thảo
                            </c:otherwise>
                        </c:choose>
                    </display:column>
                    <display:column sortable="false" headerClass="table_header_center" titleKey="label.options" style="width: 10%; text-align:center">
                        <a href="${viewDetailUrl}?pojo.machineComponentID=${tableList.machineComponentID}" class="icon-eye-open tip-top" title="<fmt:message key="label.view.detail"/>"></a>
                        <c:if test="${empty tableList.machine.confirmStatus || tableList.machine.confirmStatus < Constants.MACHINE_SUBMIT}">
                            <security:authorize ifAnyGranted="MAY_THIET_BI">
                                <span class="separator"></span>
                                <a href="${editUrl}?pojo.machineComponentID=${tableList.machineComponentID}" class="icon-edit tip-top" title="<fmt:message key="label.edit"/>"></a>
                            </security:authorize>
                            <security:authorize ifAnyGranted="ADMIN">
                                <span class="separator"></span>
                                <a name="deleteLink" onclick="warningDelete(this)" id="${tableList.machineComponentID}" href="#" class="icon-remove tip-top" title="<fmt:message key="label.delete"/>"></a>
                            </security:authorize>
                        </c:if>

                    </display:column>
                    <display:setProperty name="paging.banner.item_name">loại <fmt:message key= "whm.machinecomponent.name"/></display:setProperty>
                    <display:setProperty name="paging.banner.items_name">loại <fmt:message key= "whm.machinecomponent.name"/></display:setProperty>
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


