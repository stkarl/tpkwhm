<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@page import="com.banvien.tpk.core.Constants" %>

<head>
    <title><fmt:message key="whm.customer.title"/></title>
    <meta name="heading" content="<fmt:message key="whm.customer.title"/>"/>
</head>

<c:url var="url" value="/whm/customer/edit.html"/>
<c:url var="backUrl" value="/whm/customer/list.html"/>
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
                    <c:when test="${not empty item.pojo.customerID}">
                        <fmt:message key="whm.customer.edit"/>
                    </c:when>
                    <c:otherwise>
                        <fmt:message key="whm.customer.new"/>
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="clear"></div>
            <div class="row-fluid">
                <div class="pane_info">
                    <div class="pane_title"><fmt:message key="whm.customer.info"/></div>
                    <div class="pane_content">
                        <div class="control-group">
                            <label class="control-label"><fmt:message key="label.customer"/></label>
                            <div class="controls">
                                <form:input path="pojo.name" cssClass="required nohtml nameValidate" size="25" maxlength="45"/>
                                <form:errors path="pojo.name" cssClass="error-inline-validate"/>
                            </div>
                            <label class="control-label"><fmt:message key="label.birthday"/></label>
                            <div class="controls">
                                <div class="input-append date" >
                                    <fmt:formatDate var="birthday" value="${item.pojo.birthday}" pattern="dd/MM/yyyy"/>
                                    <input name="pojo.birthday" id="birthdayDate" class="prevent_type text-center width5" value="${birthday}" type="text" />
                                    <span class="add-on" id="birthdayDateIcon"><i class="icon-calendar"></i></span>
                                </div>
                            </div>
                            <label class="control-label"><fmt:message key="customer.company"/></label>
                            <div class="controls">
                                <form:input path="pojo.company" cssClass="nohtml large" size="25" maxlength="85"/>
                            </div>
                            <label class="control-label"><fmt:message key="label.address"/></label>
                            <div class="controls">
                                <form:input path="pojo.address" cssClass="nohtml large" size="25" maxlength="85"/>
                            </div>
                            <label class="control-label"><fmt:message key="whm.province.name"/></label>
                            <div class="controls">
                                <form:select path="pojo.province.provinceID" id="slprovince">
                                    <form:option value="">-<fmt:message key="label.select"/>-</form:option>
                                    <form:options items="${provinces}" itemValue="provinceID" itemLabel="name"/>
                                </form:select>
                            </div>
                            <label class="control-label"><fmt:message key="label.phone"/></label>
                            <div class="controls">
                                <form:input path="pojo.phone" cssClass="nohtml large" size="25" maxlength="85"/>
                            </div>
                            <label class="control-label">Fax</label>
                            <div class="controls">
                                <form:input path="pojo.fax" cssClass="nohtml" size="25" maxlength="45"/>
                            </div>
                            <label class="control-label"><fmt:message key="customer.contact"/></label>
                            <div class="controls">
                                <form:input path="pojo.contact"  size="25" maxlength="45"/>
                            </div>
                            <label class="control-label"><fmt:message key="customer.contact.phone"/></label>
                            <div class="controls">
                                <form:input path="pojo.contactPhone"  size="25" maxlength="45"/>
                            </div>
                        </div>
                    </div>
                </div>
                <c:set value="false" var="showLiability"/>
                <security:authorize ifAnyGranted="NHANVIENKD,QUANLYKD,LANHDAO,QUANLYTT,QUANLYNO">
                    <c:set value="true" var="showLiability"/>
                </security:authorize>

                <security:authorize ifAnyGranted="QUANLYKD,LANHDAO,QUANLYTT">
                    <c:set value="true" var="showStatus"/>
                </security:authorize>
                <div class="pane_info" style="display: ${showLiability ? "block" : "none"}">
                    <div class="pane_title"><fmt:message key="whm.customer.liability.info"/></div>
                    <div class="pane_content">
                        <div class="control-group">
                            <label class="control-label"><fmt:message key="whm.limit.money.owe"/></label>
                            <div class="controls">
                                <fmt:formatNumber var="oweLimit" value="${item.pojo.oweLimit}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/>
                                <input name="pojo.oweLimit" value="${oweLimit}" class="inputNumber" type="text"/>
                            </div>
                            <div style="display: ${showStatus ? "block" : "none"}">
                                <label class="control-label">
                                    <fmt:message key="label.status"/>
                                </label>
                                <div class="controls" style="margin-top: 5px;">
                                    <label class="label-inline"><form:radiobutton path="pojo.status" value="${Constants.CUSTOMER_NORMAL}" cssClass="radioCls"/>&nbsp;<fmt:message key="label.normal"/></label>
                                    <label class="label-inline"><form:radiobutton path="pojo.status" value="${Constants.CUSTOMER_WARNING}" cssClass="radioCls"/>&nbsp;<fmt:message key="label.bad"/></label>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="controls">
                    <a onclick="save();" class="btn btn-success btn-green" style="cursor: pointer;">
                        <fmt:message key="button.save"/>
                    </a>
                    <div style="display: inline">
                        <form:hidden path="crudaction" id="crudaction" value="insert-update"/>
                        <form:hidden path="pojo.customerID"/>
                        <a href="${backUrl}" class="cancel-link">
                            <fmt:message key="button.cancel"/>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</form:form>


<script type="text/javascript">
    $(document).ready(function(){

        var lastPayDateVar = $("#lastPayDate").datepicker({
            format: 'dd/mm/yyyy',
            onRender: function(date){
            }}).on('changeDate', function(ev) {
                    lastPayDateVar.hide();
                }).data('datepicker');

        $('#lastPayDateIcon').click(function() {
            $('#lastPayDate').focus();
            return true;
        });

        var birthdayDateVar = $("#birthdayDate").datepicker({
            format: 'dd/mm/yyyy',
            onRender: function(date){
            }}).on('changeDate', function(ev) {
                    birthdayDateVar.hide();
                }).data('datepicker');

        $('#birthdayDateIcon').click(function() {
            $('#birthdayDate').focus();
            return true;
        });
    });

    function save(){
        $("#crudaction").val("insert-update");
        var hasInputNumber = false;
        $('.inputNumber').each(function(){
            if($(this).val() != '' && $(this).val() != 0 ) {
                hasInputNumber = true;
                $(this).val(numeral().unformat($(this).val()));
            }
        });
        $("#itemForm").submit();
    }

    function changeProvince(value) {
        var options = document.getElementById('slprovince').options;
        options.length = 1;
        var url = '<c:url value="/ajax/getProvinceByRegion.html"/>?regionID=' + value;
        $.getJSON(url, function(data) {
            var error = data.error;
            if (error != null) {
                alert(error);
            }else if (data.array != null){
                for (i = 0; i < data.array.length; i++) {
                    var item = data.array[i];
                    options[i + 1] = new Option(item.name, item.provinceID);
                }
            }

        });
    }
</script>
