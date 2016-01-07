<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<head>
    <title><fmt:message key="whm.customer.list"/></title>
    <meta name="heading" content="<fmt:message key="whm.customer.list"/>"/>
    <link rel="stylesheet" href="<c:url value='/themes/whm/css/jquery.jscrollpane.css' />" />
    <style>
        .warning{
            background: #FFAD9A;
        }
    </style>
</head>

<c:url var="url" value="/whm/customer/list.html"/>
<c:url var="editUrl" value="/whm/customer/edit.html"/>
<div id="content">
    <form:form commandName="items" action="${url}" method="post" id="listForm" name="listForm">
        <div id="container-fluid data_content_box">
            <div class="row-fluid data_content">
                <div class="content-header">
                    <fmt:message key="whm.customer.list"/>
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
                                <td class="label-field"><fmt:message key="label.customer"/></td>
                                <td>
                                    <form:select path="pojo.customerID" cssStyle="width: 360px;">
                                        <form:option value="-1">Tất cả</form:option>
                                        <c:forEach items="${customers}" var="customer">
                                            <form:option value="${customer.customerID}">${customer.name} - ${customer.province.name}</form:option>
                                        </c:forEach>
                                    </form:select>
                                </td>
                                <td colspan="2"></td>
                            </tr>
                            <tr>
                                <td class="label-field"><fmt:message key="whm.province.name"/></td>
                                <td>
                                    <form:select path="pojo.province.provinceID">
                                        <form:option value="-1">Tất cả</form:option>
                                        <form:options items="${provinces}" itemValue="provinceID" itemLabel="name"/>
                                    </form:select>
                                </td>
                                <td class="label-field"><fmt:message key="whm.region.name"/></td>
                                <td>
                                    <form:select path="pojo.region.regionID">
                                        <form:option value="-1">Tất cả</form:option>
                                        <form:options items="${regions}" itemValue="regionID" itemLabel="name"/>
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
                <div id="tbContent" style="width:100%">
                <display:table name="items.listResult" cellspacing="0" cellpadding="0" requestURI="${url}" style="width:100%;margin-top:12px;"
                               partialList="true" sort="external" size="${items.totalItems}"  uid="tableList" pagesize="${items.maxPageItems}" class="tableSadlier table-hover" export="false">
                    <display:caption><fmt:message key='whm.customer.list'/></display:caption>

                    <display:column class="${tableList.status eq 1 ? '' : 'warning'}" headerClass="table_header"  escapeXml="false" sortable="true" sortName="name" titleKey="label.customer" style="width: 15%">
                        ${tableList.name} - ${tableList.province.name}
                    </display:column>
                    <display:column class="${tableList.status eq 1 ? '' : 'warning'}" headerClass="table_header" property="company"  escapeXml="false" sortable="true" titleKey="customer.company" style="width: 15%" />
                    <display:column class="${tableList.status eq 1 ? '' : 'warning'}" headerClass="table_header" property="phone"  escapeXml="false" sortable="true"  titleKey="label.phone" style="width: 10%" />
                    <display:column class="${tableList.status eq 1 ? '' : 'warning'}" headerClass="table_header" property="fax"  escapeXml="false" sortable="true" title="Fax" style="width: 7%" />
                    <display:column class="${tableList.status eq 1 ? '' : 'warning'}" headerClass="table_header" property="address"  escapeXml="false" sortable="false" titleKey="label.address" style="width: 15%" />
                    <%--<display:column class="${tableList.status eq 1 ? '' : 'warning'}" headerClass="table_header" property="contact"  escapeXml="false" sortable="true" titleKey="customer.contact" style="width: 7%" />--%>
                    <display:column class="${tableList.status eq 1 ? '' : 'warning'}" headerClass="table_header" property="contactPhone"  escapeXml="false" sortable="true" titleKey="customer.contact.phone" style="width: 7%" />
                    <display:column class="${tableList.status eq 1 ? '' : 'warning'}"  sortable="false" headerClass="table_header_center" titleKey="label.options" style="width: 5%; text-align:center">
                        <a href="${editUrl}?pojo.customerID=${tableList.customerID}" class="icon-edit tip-top" title="<fmt:message key="label.edit"/>"></a>
                        <security:authorize ifAnyGranted="ADMIN">
                            <span class="separator"></span>
                            <a name="deleteLink" onclick="warningDelete(this)" id="${tableList.customerID}" class="icon-remove tip-top" title="<fmt:message key="label.delete"/>"></a>
                        </security:authorize>
                    </display:column>
                    <display:setProperty name="paging.banner.item_name"><fmt:message key= "whm.customer.name"/></display:setProperty>
                    <display:setProperty name="paging.banner.items_name"><fmt:message key= "whm.customer.name"/></display:setProperty>
                    <display:setProperty name="paging.banner.placement" value="bottom"/>
                    <display:setProperty name="paging.banner.no_items_found" value=""/>
                </display:table>
                </div>
                <div class="clear"></div>
            </div>
        </div>


    </form:form>
</div>
<script src="<c:url value="/themes/whm/scripts/bootstrap/jscrollpane.js"/>"></script>

<script type="text/javascript">
    $(document).ready(function(){
        $('#tbContent').jScrollPane();
    });
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


