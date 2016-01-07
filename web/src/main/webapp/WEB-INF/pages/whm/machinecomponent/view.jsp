<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@page import="com.banvien.tpk.core.Constants" %>
<html>
<head>
    <title><fmt:message key="whm.machinecomponent.title"/></title>
    <meta name="heading" content="<fmt:message key="whm.machinecomponent.title"/>"/>
</head>
<c:url var="url" value="/whm/machinecomponent/view.html"/>
<c:url var="backUrl" value="/whm/machinecomponent/list.html"/>
<body>
<div id="machineContent">
    <div id="container-fluid data_content_box">
        <div class="row-fluid data_content">
            <div class="content-header">
                <fmt:message key="whm.machinecomponent.info"/>
            </div>
            <div class="clear"></div>

            <div class="row-fluid">
                <table class="tbReportFilter">
                    <caption><fmt:message key="whm.machinecomponent.info"/></caption>
                    <tr>
                        <td class="label-field"><fmt:message key="label.code"/> - <fmt:message key="label.name"/></td>
                        <td>
                            ${item.pojo.code} - ${item.pojo.name}
                            <a onclick="showComponentLog('${item.pojo.machineComponentID}');" class="icon-list tip-top" title="<fmt:message key="label.maintain.log"/>"></a>
                        </td>
                    </tr>
                    <tr>
                        <td class="label-field"><fmt:message key="label.description"/></td>
                        <td>${item.pojo.description}</td>
                    </tr>
                    <%--<tr>--%>
                        <%--<td class="label-field"><fmt:message key="label.bought.date"/></td>--%>
                        <%--<td><fmt:formatDate value="${item.pojo.boughtDate}" pattern="dd/MM/yyyy"/></td>--%>
                    <%--</tr>--%>
                    <tr>
                        <td class="label-field"><fmt:message key="whm.last.maintenance.date"/></td>
                        <td><fmt:formatDate value="${item.pojo.latestMaintenance.maintenanceDate}" pattern="dd/MM/yyyy"/> (<fmt:message key="next.maintenance.day"/> ${item.pojo.latestMaintenance.noDay} <fmt:message key="label.no.day"/>)</td>
                    </tr>
                    <tr>
                        <td class="label-field"><fmt:message key="label.status"/></td>
                        <td>
                            <c:choose>
                                <c:when test="${item.pojo.status eq Constants.MACHINE_NORMAL}"><fmt:message key="label.normal"/></c:when>
                                <c:when test="${item.pojo.status eq Constants.MACHINE_WARNING}"><fmt:message key="label.need.maintenance"/></c:when>
                                <c:when test="${item.pojo.status eq Constants.MACHINE_STOP}"><fmt:message key="label.machine.stop"/></c:when>
                            </c:choose>
                            <%--<a onclick="showComponentLog();" class="icon-wrench tip-top" title="<fmt:message key="label.maintain"/>"></a>--%>
                        </td>
                    </tr>
                </table>
                <div class="clear"></div>
            </div>

            <div class="controls">
                <div style="display: inline">
                    <a href="${backUrl}" class="cancel-link">
                        <fmt:message key="button.cancel"/>
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    $(document).ready(function(){});
    function showComponentLog(comID) {
        $.ajax({
            type: "POST",
            url:  '<c:url value="/ajax/componentLog.html"/>',
            dataType: 'html',
            data:{'machineComponentID': comID},
            complete : function(res){
                if (res.responseText != ''){
                    var form = $(res.responseText);
                    var modal = bootbox.dialog(form, [
                        {
                            "label" :  "<i class='icon-remove-sign'></i> <fmt:message key="button.cancel"/>",
                            "class" : "btn-small btn-primary",
                            "callback" : function(){
                                form.remove();

                            }
                        }],
                            {
                                "onEscape": function(){
                                    form.remove();
                                }
                            });
                    modal.modal("show");
                    $('#tbLogs').jScrollPane({contentWidth : 550});
                }
            }
        });
    }
</script>
</body>

</html>


