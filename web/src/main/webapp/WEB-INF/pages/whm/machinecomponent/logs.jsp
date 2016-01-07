<%--
  Created by IntelliJ IDEA.
  User: khanhcq
  Date: 11/25/14
  Time: 11:00 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ include file="/common/taglibs.jsp"%>
<div id="tbLogs" style="max-height: 500px;">
    <table class="tbReportFilter">
        <caption><fmt:message key="maintenance.logs"/>: ${machineComponent.code} - ${machineComponent.name}</caption>
        <tr>
            <td colspan="2" style="font-weight: normal;">
                <ul>
                    <c:forEach items="${logs}" var="history">
                        <li class="log">
                            <strong><fmt:formatDate value="${history.maintenanceDate}" pattern="dd/MM/yyyy"/>:</strong><span>${history.note}</span>
                        </li>
                    </c:forEach>
                </ul>
            </td>
        </tr>
    </table>
</div>