<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@page import="com.banvien.tpk.core.Constants" %>
<html>
<head>
    <title><fmt:message key="summary.sales.performance.title"/></title>
    <meta name="heading" content="<fmt:message key='summary.sales.performance.title'/>"/>
    <link rel="stylesheet" href="<c:url value='/themes/whm/css/jquery.jscrollpane.css' />" />
    <style>
        .tb_left {
            float: left;
            width: 20%;
        }
        .tb_center {
            float: left;
            width: 80%;
        }

        .tb_left .tableSadlier,
        .tb_center .tableSadlier{
            margin-top: 12px;
        }

    </style>
</head>
<c:url var="urlForm" value="/whm/report/salesPerformance.html"></c:url>
<body>
<div class="row-fluid data_content">
    <div class="content-header"><fmt:message key="summary.sales.performance.title"/></div>
    <div class="clear"></div>
    <div class="report-filter">
        <form:form commandName="items" action="${urlForm}" id="itemForm" method="post" autocomplete="off" name="itemForm">
            <table class="tbReportFilter" style="margin-bottom: 12px;">
                <caption><fmt:message key="label.search.title"/></caption>
                <tr>
                    <td class="label-field"><fmt:message key="label.from.date"/></td>
                    <td>
                        <div class="input-append date" >
                            <fmt:formatDate var="ngayKeKhaiFrom" value="${items.fromDate}" pattern="dd/MM/yyyy"/>
                            <input name="fromDate" id="effectiveFromDate" class="prevent_type text-center width2" value="${ngayKeKhaiFrom}" type="text" />
                            <span class="add-on" id="effectiveFromDateIcon"><i class="icon-calendar"></i></span>
                        </div>
                    </td>
                    <td class="label-field"><fmt:message key="label.to.date"/></td>
                    <td>
                        <div class="input-append date" >
                            <fmt:formatDate var="ngayKeKhaiTo" value="${items.toDate}" pattern="dd/MM/yyyy"/>
                            <input name="toDate" id="effectiveToDate" class="prevent_type text-center width2" value="${ngayKeKhaiTo}" type="text" />
                            <span class="add-on" id="effectiveToDateIcon"><i class="icon-calendar"></i></span>
                        </div>
                    </td>
                </tr>

                <tr style="text-align: center;">
                    <td colspan="4">
                        <a id="btnFilter" class="btn btn-primary " onclick="submitReport('itemForm');"><i class="icon-refresh"></i> <fmt:message key="label.report"/> </a>
                        <%--<c:if test="${fn:length(results) > 0}">--%>
                            <%--<a id="btnExport" class="btn btn-info " onclick="submitExport('itemForm');"><i class="icon-arrow-down"></i> <fmt:message key="label.export.excel"/> </a>--%>
                        <%--</c:if>--%>
                    </td>
                </tr>
            </table>
            <div class="clear"></div>
            <%--<div id="tbContent" style="width:100%">--%>

            <%--</div>--%>

            <jsp:include page="sales_performance_report_tb.jsp"/>

            <form:hidden path="crudaction" id="crudaction"/>
        </form:form>
    </div>
</div>
<script src="<c:url value="/themes/whm/scripts/bootstrap/jscrollpane.js"/>"></script>
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


//        $("#btnFilter").click(function(){
//            $("#crudaction").val("search");
//            $("#itemForm").submit();
//        });
        $('#tbContent').jScrollPane();
    });
</script>
</body>
</html>