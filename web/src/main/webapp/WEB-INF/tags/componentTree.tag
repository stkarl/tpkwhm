<%@ attribute type="java.util.List" name="components" required="true" %>
<%@ attribute type="java.lang.Integer" name="level" required="true" %>
<%@ attribute type="java.lang.Integer" name="confirmStatus" required="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.tanphuockhanh.vn/componentTree" prefix="treeTag"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<%@ taglib uri="http://www.tanphuockhanh.vn/tpk-taglibs" prefix="tpk" %>

<c:if test="${!empty components}">
    <c:set var="parentClass" value=""/>
    <c:if test="${level > 1}">
        <c:set var="parentClass" value="treegrid-parent-${level - 1}"/>
    </c:if>
    <c:forEach var="childComponent" items="${components}" varStatus="status">
        <tr class="component-level-${level} treegrid-${childComponent.machineComponentID} treegrid-parent-${childComponent.parent.machineComponentID}" id="component-${childComponent.machineComponentID}">
            <td><span id="cCode-${childComponent.machineComponentID}">${childComponent.code}</span></td>
            <td id="cName-${childComponent.machineComponentID}">${childComponent.name}</td>
            <td id="cDes-${childComponent.machineComponentID}">
                    ${childComponent.description}<br>
                <c:if test="${not empty childComponent.machineComponentPictures}">
                    <div id="machine-image">
                        <ul class="thumbs">
                            <c:forEach items="${childComponent.machineComponentPictures}" var="componentPicture">
                                <c:if test="${tpk:checkImage(componentPicture.path)}">
                                    <li id="machine-pic-${componentPicture.machineComponentPictureID}" style="text-align: center">
                                        <a class="fancybox-thumbs" data-fancybox-group="thumb" href="<c:url value="/${componentPicture.path}"/>" title="" >
                                            <img src="<c:url value="/${componentPicture.path}"/>" style="width: 50px;height: 50px;"/>
                                        </a>
                                        <c:if test="${empty confirmStatus || confirmStatus < 20}">
                                            <security:authorize ifAnyGranted="ADMIN">
                                                <a onclick="deleteMachinePicture(${componentPicture.machineComponentPictureID});" class="icon-remove"></a>
                                            </security:authorize>
                                            <security:authorize ifNotGranted="ADMIN">
                                                <c:if test="${childComponent.createdBy.userID eq tpk:getLoginID()}">
                                                    <a onclick="deleteComponentPicture(${componentPicture.machineComponentPictureID});" class="icon-remove"></a>
                                                </c:if>
                                            </security:authorize>
                                        </c:if>
                                    </li>
                                </c:if>
                                <c:if test="${!tpk:checkImage(componentPicture.path)}">
                                    <li id="machine-pic-${componentPicture.machineComponentPictureID}" style="text-align: center">
                                        <a class="icon-file" href="<c:url value="/${componentPicture.path}"/>" title="${componentPicture.path}">
                                                ${tpk:getFileName(componentPicture.path)}
                                        </a>
                                        <c:if test="${empty confirmStatus || confirmStatus < 20}">
                                            <security:authorize ifAnyGranted="ADMIN">
                                                <a onclick="deleteMachinePicture(${componentPicture.machineComponentPictureID});" class="icon-remove"></a>
                                            </security:authorize>
                                            <security:authorize ifNotGranted="ADMIN">
                                                <c:if test="${childComponent.createdBy.userID eq tpk:getLoginID()}">
                                                    <a onclick="deleteComponentPicture(${componentPicture.machineComponentPictureID});" class="icon-remove"></a>
                                                </c:if>
                                            </security:authorize>
                                        </c:if>
                                    </li>
                                </c:if>
                            </c:forEach>
                        </ul>
                    </div>
                </c:if>
            </td>
            <td><fmt:formatDate value="${childComponent.latestMaintenance.maintenanceDate}" pattern="dd/MM/yyyy"/><br>(<fmt:message key="next.maintenance.day"/> ${childComponent.latestMaintenance.noDay} <fmt:message key="label.no.day"/>)</td>
            <td>
                <c:choose>
                    <c:when test="${childComponent.status eq Constants.MACHINE_NORMAL}"><fmt:message key="label.normal"/></c:when>
                    <c:when test="${childComponent.status eq Constants.MACHINE_WARNING}"><fmt:message key="label.need.maintenance"/></c:when>
                    <c:when test="${childComponent.status eq Constants.MACHINE_STOP}"><fmt:message key="label.machine.stop"/></c:when>
                </c:choose>
            </td>
            <td style="text-align: center">
                <div class="dropdown" id="menu-update">
                    <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                        <span class="text"><fmt:message key="label.action.process"/></span>
                    </a>
                    <ul class="dropdown-menu" style="text-align: left">
                        <li><a class="menu" onclick="showComponentLog('${childComponent.machineComponentID}');"><span><fmt:message key="label.maintain.log"/></span></a></li>
                        <security:authorize ifAnyGranted="MAY_THIET_BI,ADMIN">
                            <li><a class="menu" onclick="showMaintainComponent('${childComponent.machineComponentID}');"><span><fmt:message key="label.maintain"/></span></a></li>
                            <%--Constants.MACHINE_SUBMIT = 20--%>
                            <c:if test="${empty confirmStatus || confirmStatus < 20}">
                                <c:if test="${childComponent.createdBy.userID eq tpk:getLoginID()}">
                                    <li><a class="menu" onclick="showEditComponentForm('${childComponent.machineComponentID}');"><span><fmt:message key="label.edit"/></span></a></li>
                                </c:if>
                                <security:authorize ifAnyGranted="ADMIN">
                                    <li><a class="menu" onclick="deleteComponent('${childComponent.machineComponentID}');"><span><fmt:message key="label.delete"/></span></a></li>
                                </security:authorize>
                                <security:authorize ifNotGranted="ADMIN">
                                    <c:if test="${childComponent.createdBy.userID eq tpk:getLoginID()}">
                                        <li><a class="menu" onclick="deleteComponent('${childComponent.machineComponentID}');"><span><fmt:message key="label.delete"/></span></a></li>
                                    </c:if>
                                </security:authorize>
                                <c:if test="${childComponent.createdBy.userID eq tpk:getLoginID()}">
                                    <li><a class="menu" onclick="showDuplicateComponent('${childComponent.machineComponentID}');"><span><fmt:message key="label.duplicate"/></span></a></li>
                                    <li><a class="menu" onclick="showAddSubComponentForm('${childComponent.machineComponentID}');"><span><fmt:message key="add.sub.component"/></span></a></li>
                                    <li><a class="menu" onclick="showUploadComponent('${childComponent.machineComponentID}');"><span><fmt:message key="upload.picture"/></span></a></li>
                                </c:if>
                            </c:if>
                        </security:authorize>
                    </ul>
                </div>
            </td>
        </tr>
        <treeTag:componentTree components="${childComponent.childComponents}" level="${level + 1}" confirmStatus="${confirmStatus}"/>
    </c:forEach>
</c:if>
