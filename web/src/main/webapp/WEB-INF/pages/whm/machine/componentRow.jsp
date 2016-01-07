<%@ include file="/common/taglibs.jsp"%>
<c:set var="rowClass" value=""/>
<c:if test="${!empty counter}">
    <c:set var="rowClass" value="${counter % 2 == 0 ? 'even' : 'odd'}"/>
</c:if>
<tr class="${rowClass}" id="component-${component.machineComponentID}">
    <td><span id="cCode-${component.machineComponentID}">${component.code}</span></td>
    <td id="cName-${component.machineComponentID}">${component.name}</td>
    <td id="cDes-${component.machineComponentID}">${component.description}</td>
    <td><fmt:formatDate value="${component.lastMaintenanceDate}" pattern="dd/MM/yyyy"/> (<fmt:message key="next.maintenance.day"/> ${component.nextMaintenance} <fmt:message key="label.no.day"/>)</td>
    <td>
        <fmt:message key="label.normal"/>
    </td>
    <td style="text-align: center">
        <div class="dropdown" id="menu-update">
            <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                <span class="text"><fmt:message key="label.action.process"/></span>
            </a>
            <ul class="dropdown-menu" style="text-align: left">
                <li><a class="menu" onclick="showComponentLog('${component.machineComponentID}');"><span><fmt:message key="label.maintain.log"/></span></a></li>
                <security:authorize ifAnyGranted="MAY_THIET_BI">
                    <li><a class="menu" onclick="showEditComponentForm('${component.machineComponentID}');"><span><fmt:message key="label.edit"/></span></a></li>
                    <li><a class="menu" onclick="deleteComponent('${component.machineComponentID}');"><span><fmt:message key="label.delete"/></span></a></li>
                    <li><a class="menu" onclick="showDuplicateComponent('${component.machineComponentID}');"><span><fmt:message key="label.duplicate"/></span></a></li>
                    <li><a class="menu" onclick="showMaintainComponent('${component.machineComponentID}');"><span><fmt:message key="label.maintain"/></span></a></li>
                    <li><a class="menu" onclick="showAddSubComponentForm('${component.machineComponentID}');"><span><fmt:message key="add.sub.component"/></span></a></li>
                </security:authorize>
            </ul>
        </div>
    </td>
</tr>