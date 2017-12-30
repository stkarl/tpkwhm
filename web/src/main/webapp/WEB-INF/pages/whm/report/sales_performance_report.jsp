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
            /*width: 24%;*/
        }
        .tb_center {
            float: left;
            width: 75%;
        }
        #tbContent{
            width: 75%;
        }

        .tb_left .tableSadlier,
        .tb_center .tableSadlier{
            margin-top: 12px;
        }

        .tableSadlier .table_header {
            min-width: 64px;
        }
        .stt{
            width: 24px;
            min-width: 0;
        }

        .tableSadlier th.table_header:first-child {
            padding-left: 2px;
        }
        .tableSadlier td:first-child {
            padding-left: 4px;
        }

        #tbContent  .tableSadlier tr td{
            text-align: right;
        }

        .tooltip-inner {
            width: 200px;
        }

        #tbContent {
            margin-bottom: 240px;
        }

    </style>
</head>
<c:url var="urlForm" value="/whm/report/salesPerformance.html"></c:url>
<body>
<div class="row-fluid data_content">
    <div class="content-header"><fmt:message key="summary.sales.performance.title"/></div>
    <div class="clear"></div>
    <c:if test="${not empty messageResponse}">
        <div class="alert alert-${alertType}">
            <button aria-hidden="true" data-dismiss="alert" class="close" type="button">x</button>
                ${messageResponse}
        </div>
    </c:if>
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
            <c:if test="${!empty results && fn:length(results) > 0}">
                <jsp:include page="sales_performance_report_tb.jsp"/>
            </c:if>
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

        computeTotal('Weight');
        computeTotal('Customer');
    });

    function computeTotal(type){
        $('.totalDaily' + type).each(function(){
            var total = 0;
            var date = $(this).attr('date');
            $('.daily' + type + date).each(function(){
                total += eval($(this).attr(type).replace(',', ''));
            });
            $(this).text(numeral(total).format('###,###'));
        });

        var total = 0;
        $('.monthly' + type).each(function(){
            total += eval($(this).attr(type).replace(',', ''));
        });
        $('.totalMonthly' + type).text(numeral(total).format('###,###'));
    }
</script>
</body>
</html>