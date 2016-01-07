<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@page import="com.banvien.tpk.core.Constants" %>

<head>
    <title><fmt:message key="edit.owe.log.title"/></title>
    <meta name="heading" content="<fmt:message key="edit.owe.log.title"/>"/>
</head>

<c:url var="url" value="/whm/customer/editlog.html"/>
<c:url var="backUrl" value="/whm/customer/owelog.html"/>
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
                <fmt:message key="edit.owe.log.title"/>

            </div>
            <div class="clear"></div>
                <c:set value="false" var="showLiability"/>
                <security:authorize ifAnyGranted="NHANVIENKD,QUANLYKD,LANHDAO,QUANLYNO">
                    <c:set value="true" var="showLiability"/>
                </security:authorize>
                <c:set value="owe" var="logType"/>
                <c:if test="${item.pojo.type eq Constants.OWE_MINUS}">
                    <c:set value="pay" var="logType"/>
                </c:if>
                <div class="pane_info">
                    <div class="pane_title"><fmt:message key="update.liability.info"/></div>
                    <div class="pane_content">
                        <div class="control-group">
                            <label class="control-label"><fmt:message key="label.customer"/></label>
                            <div class="controls text-inline">
                                    ${item.pojo.customer.name} - ${item.pojo.customer.province.name}
                            </div>

                            <label class="control-label"><fmt:message key="label.${logType}"/></label>
                            <div class="controls">
                                <fmt:formatNumber var="money" value="${item.pojo.pay}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/>
                                <input name="pojo.pay" value="${money}" class="inputNumber" type="text"/>
                            </div>

                            <label class="control-label"><fmt:message key="label.in.date"/></label>
                            <div class="controls">
                                <div class="input-append date">
                                    <c:if test="${item.pojo.type eq Constants.OWE_MINUS}">
                                        <fmt:formatDate var="moneyDate" value="${item.pojo.payDate}" pattern="dd/MM/yyyy"/>
                                        <input name="pojo.payDate" id="lastPayDate" class="prevent_type text-center width5" value="${moneyDate}" type="text" />
                                        <span class="add-on" id="lastPayDateIcon"><i class="icon-calendar"></i></span>
                                    </c:if>
                                    <c:if test="${item.pojo.type eq Constants.OWE_PLUS}">
                                        <fmt:formatDate var="moneyDate" value="${item.pojo.oweDate}" pattern="dd/MM/yyyy"/>
                                        <input name="pojo.oweDate" id="lastPayDate" class="prevent_type text-center width5" value="${moneyDate}" type="text" />
                                        <span class="add-on" id="lastPayDateIcon"><i class="icon-calendar"></i></span>
                                    </c:if>
                                </div>
                            </div>

                            <label class="control-label"><fmt:message key="no.day.delay"/></label>
                            <div class="controls">
                                <form:input path="pojo.dayAllow" cssClass="nohtml nameValidate width0" size="3" maxlength="45"/> <fmt:message key="label.no.day"/>
                            </div>

                            <label class="control-label"><fmt:message key="label.note"/></label>
                            <div class="controls">
                                <form:textarea path="pojo.note"/>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="controls">
                    <security:authorize ifAnyGranted="QUANLYKD,LANHDAO,ADMIN,QUANLYNO">
                    <a onclick="save();" class="btn btn-success btn-green" style="cursor: pointer;">
                        <fmt:message key="button.save"/>
                    </a>
                    </security:authorize>
                    <div style="display: inline">
                        <form:hidden path="crudaction" id="crudaction" value="insert-update"/>
                        <form:hidden path="pojo.oweLogID"/>
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
