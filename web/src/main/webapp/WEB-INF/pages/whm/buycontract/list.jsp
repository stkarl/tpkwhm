<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<head>
    <title><fmt:message key="whm.buycontract.list"/></title>
    <meta name="heading" content="<fmt:message key="whm.buycontract.list"/>"/>
</head>

<c:url var="url" value="/whm/buycontract/list.html"/>
<c:url var="editUrl" value="/whm/buycontract/edit.html"/>
<div id="content">
    <form:form commandName="items" action="${url}" method="post" id="listForm" name="listForm">
        <div id="container-fluid data_content_box">
            <div class="row-fluid data_content">
                <div class="content-header">
                    <fmt:message key="whm.buycontract.list"/>
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
                                <td class="label-field"><fmt:message key="label.code"/></td>
                                <td><form:input path="pojo.code" size="40"/></td>
                                <td class="label-field"><fmt:message key="whm.customer.name"/></td>
                                <td>
                                    <form:select path="pojo.customer.customerID" cssStyle="width: 360px;">
                                        <form:option value="-1">Tất cả</form:option>
                                        <c:forEach items="${customers}" var="customer">
                                            <form:option value="${customer.customerID}">${customer.name} - ${customer.province.name}</form:option>
                                        </c:forEach>
                                    </form:select>
                                </td>
                            </tr>
                            <tr>
                                <td class="label-field"><fmt:message key="from.date"/></td>
                                <td>
                                    <div class="input-append date" >
                                        <fmt:formatDate var="fromDate" value="${items.fromDate}" pattern="dd/MM/yyyy"/>
                                        <input name="fromDate" id="effectiveFromDate" class="prevent_type text-center width2" value="${fromDate}" type="text" />
                                        <span class="add-on" id="effectiveFromDateIcon"><i class="icon-calendar"></i></span>
                                    </div>
                                </td>
                                <td class="label-field"><fmt:message key="to.date"/></td>
                                <td>
                                    <div class="input-append date" >
                                        <fmt:formatDate var="toDate" value="${items.toDate}" pattern="dd/MM/yyyy"/>
                                        <input name="toDate" id="effectiveToDate" class="prevent_type text-center width2" value="${toDate}" type="text" />
                                        <span class="add-on" id="effectiveToDateIcon"><i class="icon-calendar"></i></span>
                                    </div>
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
                <display:table name="items.listResult" cellspacing="0" cellpadding="0" requestURI="${url}"
                               partialList="true" sort="external" size="${items.totalItems}"  uid="tableList" pagesize="${items.maxPageItems}" class="tableSadlier table-hover" export="false">
                    <display:caption><fmt:message key='whm.buycontract.list'/></display:caption>
                    <display:column headerClass="table_header_center" sortable="false" title="STT" class="text-center" style="width: 2%;">
                        ${tableList_rowNum}
                    </display:column>
                    <display:column headerClass="table_header"  escapeXml="false" sortable="true" sortName="name" titleKey="contract.code" style="width: 10%" >
                        ${tableList.code}
                    </display:column>
                    <display:column headerClass="table_header"  escapeXml="false" sortable="false" sortName="name" titleKey="whm.customer.name" style="width: 20%" >
                        ${tableList.customer.name}
                    </display:column>
                    <display:column headerClass="table_header"  escapeXml="false" sortable="true" sortName="name" titleKey="contract.date" style="width: 20%" >
                        <fmt:formatDate value="${tableList.date}" pattern="dd/MM/yyyy"/>
                    </display:column>
                    <%--<display:column headerClass="table_header"  escapeXml="false" sortable="true" sortName="name" titleKey="label.no.roll" style="width: 10%" >--%>
                        <%--${tableList.noRoll}--%>
                    <%--</display:column>--%>
                    <display:column headerClass="table_header"  escapeXml="false" sortable="true" sortName="name" titleKey="label.weight.tan" style="width: 20%" >
                        <fmt:formatNumber value="${tableList.weight}" pattern="###,###.###"/>
                    </display:column>
                    <display:column sortable="false" headerClass="table_header_center" titleKey="label.options" style="width: 15%; text-align:center">
                        <a href="${editUrl}?pojo.buyContractID=${tableList.buyContractID}" class="icon-edit tip-top" title="<fmt:message key="label.edit"/>"></a>
                        <security:authorize ifAnyGranted="ADMIN">
                            <span class="separator"></span>
                            <a name="deleteLink" onclick="warningDelete(this)" id="${tableList.buyContractID}" href="#" class="icon-remove tip-top" title="<fmt:message key="label.delete"/>"></a>
                        </security:authorize>

                    </display:column>
                    <display:setProperty name="paging.banner.item_name"><fmt:message key= "whm.buycontract.name"/></display:setProperty>
                    <display:setProperty name="paging.banner.items_name"><fmt:message key= "whm.buycontract.name"/></display:setProperty>
                    <display:setProperty name="paging.banner.placement" value="bottom"/>
                    <display:setProperty name="paging.banner.no_items_found" value=""/>
                </display:table>
                <div class="clear"></div>
            </div>
        </div>


    </form:form>
</div>

<script type="text/javascript">
    $(document).ready(function(){
        var effectiveToDateVar = $("#effectiveToDate").datepicker({
            format: 'dd/mm/yyyy',
            onRender: function(date){
            }}).on('changeDate', function(ev) {
                    effectiveToDateVar.hide();
                }).data('datepicker');
        var effectiveFromDateVar = $("#effectiveFromDate").datepicker({
            format: 'dd/mm/yyyy',
            onRender: function(date){
            }}).on('changeDate', function(ev) {
                    effectiveFromDateVar.hide();
                }).data('datepicker');
        $('#effectiveToDateIcon').click(function() {
            $('#effectiveToDate').focus();
            return true;
        });
        $('#effectiveFromDateIcon').click(function() {
            $('#effectiveFromDate').focus();
            return true;
        });        
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


