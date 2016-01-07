<%--
  Created by IntelliJ IDEA.
  User: Chu Quoc Khanh
  Date: 25/03/14
  Time: 22:11
  To change this template use File | Settings | File Templates.
--%>
<table class="tbInput log-info">
    <caption><fmt:message key="label.log"/></caption>
    <tr>
        <th style="width: 20%"><fmt:message key="label.date.process"/></th>
        <th style="width: 25%"><fmt:message key="label.user.process"/></th>
        <th style="width: 15%"><fmt:message key="label.action.process"/></th>
        <th style="width: 40%"><fmt:message key="label.note"/></th>
    </tr>
    <c:forEach items="${item.pojo.logs}" var="log">
        <tr>
            <td style="text-align: center"><fmt:formatDate value="${log.createdDate}" pattern="dd/MM/yyyy-HH:mm"/></td>
            <td style="text-align: center">${log.createdBy.fullname}</td>
            <td style="text-align: center">
                <c:if test="${log.status == 1}"><fmt:message key="label.approve"/></c:if>
                <c:if test="${log.status == 0}"><fmt:message key="label.reject"/></c:if>
            </td>
            <td style="text-align: center">${log.note}</td>
        </tr>
    </c:forEach>
    </tr>
</table>