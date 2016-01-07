<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<head>
    <title><fmt:message key="whm.productionplan.title"/></title>
    <meta name="heading" content="<fmt:message key="whm.productionplan.title"/>"/>
</head>

<c:url var="url" value="/whm/productionplan/edit.html"/>
<c:url var="backUrl" value="/whm/productionplan/list.html"/>
<form:form commandName="item" action="${url}" method="post" id="itemForm" class="form-horizontal" novalidate="novalidate">
    <div id="container-fluid data_content_box">
        <div class="row-fluid data_content">

            <c:if test="${!empty errorMessage}">
                <div class="alert alert-error">
                    <a class="close" data-dismiss="alert" href="#">x</a>
                        ${errorMessage}
                </div>
                <div style="clear:both;"></div>
            </c:if>
            <c:if test="${!empty successMessage}">
                <div class="alert alert-success">
                    <a class="close" data-dismiss="alert" href="#">x</a>
                        ${successMessage}
                </div>
                <div style="clear:both;"></div>
            </c:if>

            <div class="content-header">
                <c:choose>
                    <c:when test="${not empty item.pojo.productionPlanID}">
                        <fmt:message key="whm.productionplan.edit"/>
                    </c:when>
                    <c:otherwise>
                        <fmt:message key="whm.productionplan.new"/>
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="clear"></div>
            <div class="row-fluid">
                <div class="pane_info">
                    <div class="pane_title"><fmt:message key="whm.productionplan.info"/></div>
                    <div class="pane_content">
                        <div class="control-group">
                            <label class="control-label"><fmt:message key="label.name"/></label>
                            <div class="controls">
                                <form:input id="planName" path="pojo.name" cssClass="nohtml span7" size="25" maxlength="65" readonly="true"/>
                                <form:errors path="pojo.name" cssClass="error-inline-validate"/>
                            </div>
                            <label class="control-label"><fmt:message key="label.description"/></label>
                            <div class="controls">
                                <form:textarea path="pojo.description" rows="5" cols="25"/>
                            </div>
                            <label class="control-label"><fmt:message key="label.date.process"/></label>
                            <div class="controls">
                                <fmt:formatDate var="ngayKeKhaiTo" value="${item.pojo.date}" pattern="dd/MM/yyyy"/>
                                <input name="pojo.date" id="effectiveToDate" class="prevent_type text-center width2 required" value="${ngayKeKhaiTo}" type="text"/>
                            </div>
                            <label class="control-label"><fmt:message key="whm.shift.name"/></label>
                            <div class="controls">
                                <form:select path="pojo.shift.shiftID" cssClass="required" onchange="changeName();" id="shift">
                                    <form:option value="-1"><fmt:message key="label.select"/></form:option>
                                    <form:options items="${shifts}" itemValue="shiftID" itemLabel="name"/>
                                </form:select>
                            </div>
                            <label class="control-label"><fmt:message key="whm.team.name"/></label>
                            <div class="controls">
                                <form:select path="pojo.team.teamID" cssClass="required" onchange="changeName();" id="team">
                                    <form:option value="-1"><fmt:message key="label.select"/></form:option>
                                    <form:options items="${teams}" itemValue="teamID" itemLabel="name"/>
                                </form:select>
                            </div>
                            <label class="control-label"><fmt:message key="whm.warehouse.name"/></label>
                            <div class="controls">
                                <form:select path="pojo.warehouse.warehouseID" cssClass="required">
                                    <form:options items="${warehouses}" itemValue="warehouseID" itemLabel="name"/>
                                </form:select>
                            </div>
                            <label class="control-label"><fmt:message key="label.plan.type"/></label>
                            <div class="controls">
                                <form:select path="pojo.production" id="type" onchange="changeName();">
                                    <form:option value="1">Sản Xuất Lạnh/Kẽm</form:option>
                                    <form:option value="2">Sản Xuất Màu</form:option>
                                    <form:option value="0"><fmt:message key="label.maintain"/></form:option>
                                </form:select>
                            </div>
                            <label class="control-label"><fmt:message key="label.status"/></label>
                            <div class="controls">
                                <label class="label-inline"><form:radiobutton path="pojo.status" value="1" cssClass="radioCls"/>&nbsp;<fmt:message key="label.producing"/></label>
                                <label class="label-inline"><form:radiobutton path="pojo.status" value="0" cssClass="radioCls"/>&nbsp;<fmt:message key="label.done"/></label>
                            </div>
                            <div class="controls">
                                <a onclick="$('#itemForm').submit();" class="btn btn-success btn-green" style="cursor: pointer;">
                                    <fmt:message key="button.save"/>
                                </a>
                                <div style="display: inline">
                                    <form:hidden path="crudaction" id="crudaction" value="insert-update"/>
                                    <form:hidden path="pojo.productionPlanID"/>
                                    <a href="${backUrl}" class="cancel-link">
                                        <fmt:message key="button.cancel"/>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</form:form>
<script>
    $(document).ready(function(){
        var effectiveToDateVar = $("#effectiveToDate").datepicker({
            format: 'dd/mm/yyyy',
            onRender: function(date){
            }}).on('changeDate', function(ev) {
                    effectiveToDateVar.hide();
                    changeName();
                }).data('datepicker');
        $('#effectiveToDateIcon').click(function() {
            $('#effectiveToDate').focus();
            return true;
        });
    });
    function changeName(){
        var type = $('#type option:selected').text();
        var date = $('#effectiveToDate').val();
        var shift = $('#shift option:selected').text();
        var team = $('#team option:selected').text();
        var planName = date + ' - ' + shift + ' - ' + team + ' - ' + type;
        $('#planName').val(planName);
    }
</script>
