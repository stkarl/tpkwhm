<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@page import="com.banvien.tpk.core.Constants" %>
<form:form commandName="item" action="${url}" method="post" id="itemForm" class="form-horizontal" novalidate="novalidate">
    <div id="container-fluid data_content_box">
        <div class="row-fluid data_content">
            <div class="content-header">
                <fmt:message key="whm.machine.view.detail"/>
            </div>
            <div class="button-actions">
                <security:authorize ifAnyGranted="MAY_THIET_BI">
                    <c:if test="${(empty item.pojo.confirmStatus || item.pojo.confirmStatus < Constants.MACHINE_SUBMIT) && item.pojo.createdBy.userID eq tpk:getLoginID()}">
                        <a class="btn btn-info" onclick="submitForConfirm(${item.pojo.machineID});"><i class="icon-plus"></i> <fmt:message key="submit.machine"/></a>
                        <a class="btn btn-primary" onclick="showAddComponentForm();"><i class="icon-plus"></i> <fmt:message key="button.add.component"/></a>
                    </c:if>
                </security:authorize>
                <c:if test="${item.pojo.confirmStatus == Constants.MACHINE_SUBMIT}">
                    <security:authorize ifAnyGranted="QUANLYKT">
                        <a onclick="rejectMachine(${item.pojo.machineID});" class="btn btn-danger" style="cursor: pointer;">
                            <fmt:message key="button.reject"/>
                        </a>
                        <a onclick="approveMachine(${item.pojo.machineID});" class="btn btn-success" style="cursor: pointer;">
                            <fmt:message key="button.accept"/>
                        </a>
                    </security:authorize>
                </c:if>
                <security:authorize ifAnyGranted="LANHDAO">
                    <c:if test="${item.pojo.confirmStatus == Constants.MACHINE_APPROVED_1 || item.pojo.confirmStatus == Constants.MACHINE_APPROVED_2}">
                        <a onclick="rejectMachine(${item.pojo.machineID});" class="btn btn-danger" style="cursor: pointer;">
                            <fmt:message key="button.reject"/>
                        </a>
                    </c:if>
                    <c:if test="${item.pojo.confirmStatus == Constants.MACHINE_APPROVED_1}">
                        <a onclick="approveMachine(${item.pojo.machineID});" class="btn btn-success" style="cursor: pointer;">
                            <fmt:message key="button.accept"/>
                        </a>
                    </c:if>

                </security:authorize>
                <a href="${backUrl}" class="cancel-link">
                    <fmt:message key="button.cancel"/>
                </a>
            </div>
            <div class="clear"></div>
            <div class="row-fluid">
                <table class="tbReportFilter">
                    <caption><fmt:message key="whm.machine.info"/></caption>
                    <tr>
                        <td class="label-field"><fmt:message key="label.code"/> - <fmt:message key="label.name"/></td>
                        <td>
                                ${item.pojo.code} - ${item.pojo.name}
                            <a onclick="showMachineLog();" class="icon-list tip-top" title="<fmt:message key="label.maintain.log"/>"></a>
                        </td>
                    </tr>
                    <tr>
                        <td class="label-field"><fmt:message key="label.description"/></td>
                        <td>${item.pojo.description}</td>
                    </tr>
                    <tr>
                        <td class="label-field"><fmt:message key="label.bought.date"/></td>
                        <td><fmt:formatDate value="${item.pojo.boughtDate}" pattern="dd/MM/yyyy"/></td>
                    </tr>
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
                            <security:authorize ifAnyGranted="MAY_THIET_BI">
                                <a onclick="showMaintainMachine();" class="icon-wrench tip-top" title="<fmt:message key="label.maintain"/>"></a>
                            </security:authorize>
                        </td>
                    </tr>
                    <tr>
                        <td class="label-field">
                            <fmt:message key="label.picture"/>
                            <a onclick="showUploadMachine(${item.pojo.machineID});" class="icon-upload tip-top" title="<fmt:message key="upload.picture"/>"></a></td>
                        <td>
                            <c:if test="${not empty item.pojo.machinePictures}">
                                <div id="machine-image">
                                    <ul class="thumbs">
                                        <c:forEach items="${item.pojo.machinePictures}" var="machinePicture">
                                            <c:if test="${tpk:checkImage(machinePicture.path)}">
                                                <li id="machine-pic-${machinePicture.machinePictureID}" style="text-align: center">
                                                    <a class="fancybox-thumbs" data-fancybox-group="thumb" href="<c:url value="/${machinePicture.path}"/>" title="${machinePicture.path}" >
                                                        <img src="<c:url value="/${machinePicture.path}"/>" style="width: 50px;height: 50px;"/>
                                                    </a>
                                                    <security:authorize ifAnyGranted="MAY_THIET_BI">
                                                        <c:if test="${empty item.pojo.confirmStatus || item.pojo.confirmStatus < Constants.MACHINE_SUBMIT}">
                                                            <a onclick="deleteMachinePicture(${machinePicture.machinePictureID});" class="icon-remove"></a>
                                                        </c:if>
                                                    </security:authorize>
                                                </li>
                                            </c:if>
                                            <c:if test="${!tpk:checkImage(machinePicture.path)}">
                                                <li id="machine-pic-${machinePicture.machinePictureID}" style="text-align: center">
                                                    <a class="icon-file" href="<c:url value="/${machinePicture.path}"/>" title="${machinePicture.path}">
                                                            ${tpk:getFileName(machinePicture.path)}
                                                    </a>
                                                    <security:authorize ifAnyGranted="MAY_THIET_BI">
                                                        <c:if test="${(empty item.pojo.confirmStatus || item.pojo.confirmStatus < Constants.MACHINE_SUBMIT) && item.pojo.createdBy.userID eq tpk:getLoginID()}">
                                                            <a onclick="deleteMachinePicture(${machinePicture.machinePictureID});" class="icon-remove"></a>
                                                        </c:if>
                                                    </security:authorize>
                                                </li>
                                            </c:if>

                                        </c:forEach>
                                    </ul>
                                </div>
                            </c:if>
                        </td>
                    </tr>
                </table>
                <div class="clear"></div>
                <table class="tree tableSadlier table-hover table-component" style="table-layout: fixed;">
                    <caption><fmt:message key="whm.machinecomponent.info"/></caption>
                    <tr>
                        <td class="table_header" style="width: 170px"><fmt:message key="label.code"/></td>
                        <td class="table_header" style="width: 170px;"><fmt:message key="label.name"/></td>
                        <td class="table_header"><fmt:message key="label.description"/></td>
                        <td class="table_header" style="width: 85px;"><fmt:message key="whm.last.maintenance.date"/></td>
                        <td class="table_header" style="width: 85px;"><fmt:message key="label.status"/></td>
                        <td class="table_header center" style="width: 60px;"></td>
                    </tr>
                    <treeTag:componentTree components="${item.pojo.machinecomponents}" level="1" confirmStatus="${item.pojo.confirmStatus}"/>
                </table>
            </div>
        </div>
    </div>
</form:form>
