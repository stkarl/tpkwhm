<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<head>
    <title><fmt:message key="whm.buycontract.title"/></title>
    <meta name="heading" content="<fmt:message key="whm.buycontract.title"/>"/>
</head>

<c:url var="url" value="/whm/buycontract/edit.html"/>
<c:url var="backUrl" value="/whm/buycontract/list.html"/>
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
                    <c:when test="${not empty item.pojo.buyContractID}">
                        <fmt:message key="whm.buycontract.edit"/>
                    </c:when>
                    <c:otherwise>
                        <fmt:message key="whm.buycontract.new"/>
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="clear"></div>
            <div class="row-fluid">
                <div class="pane_info">
                    <div class="pane_title"><fmt:message key="whm.buycontract.info"/></div>
                    <div class="pane_content">
                        <div class="control-group">
                            <label class="control-label"><fmt:message key="whm.customer.name"/></label>
                            <div class="controls">
                                <form:select path="pojo.customer.customerID" cssClass="required" cssStyle="width: 360px;">
                                    <form:option value="-1">Chọn</form:option>
                                    <c:forEach items="${customers}" var="customer">
                                        <form:option value="${customer.customerID}">${customer.name} - ${customer.province.name}</form:option>
                                    </c:forEach>
                                </form:select>
                            </div>
                            
                            <label class="control-label"><fmt:message key="contract.code"/></label>
                            <div class="controls">
                                <form:input path="pojo.code" size="25" maxlength="45"/>
                                <form:errors path="pojo.code" cssClass="error-inline-validate"/>
                            </div>

                            <label class="control-label"><fmt:message key="contract.date"/></label>
                            <div class="controls">
                                <fmt:formatDate var="contractDate" value="${item.pojo.date}" pattern="dd/MM/yyyy"/>
                                <input name="pojo.date" id="contractDate" class="prevent_type text-center width2" value="${contractDate}" type="text"/>
                            </div>

                            <%--<label class="control-label"><fmt:message key="label.no.roll"/></label>--%>
                            <%--<div class="controls">--%>
                                <%--<form:input path="pojo.noRoll" size="25" maxlength="45"/>--%>
                                <%--<form:errors path="pojo.noRoll" cssClass="error-inline-validate"/>--%>
                            <%--</div>--%>

                            <label class="control-label"><fmt:message key="label.weight.tan"/></label>
                            <div class="controls">
                                <form:input path="pojo.weight" size="25" maxlength="45" cssClass="inputFractionNumber"/>
                                <form:errors path="pojo.weight" cssClass="error-inline-validate"/>
                            </div>

                            <div class="controls">
                                <a onclick="save();" class="btn btn-success btn-green" style="cursor: pointer;">
                                    <fmt:message key="button.save"/>
                                </a>
                                <div style="display: inline">
                                    <form:hidden path="crudaction" id="crudaction" value="insert-update"/>
                                    <form:hidden path="pojo.buyContractID"/>
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
        var contractDateVar = $("#contractDate").datepicker({
            format: 'dd/mm/yyyy',
            onRender: function(date){
            }}).on('changeDate', function(ev) {
                    contractDateVar.hide();
                    verifyLiability();
                }).data('datepicker');
        $('#contractDateIcon').click(function() {
            $('#contractDate').focus();
            return true;
        });
    });

    function save(){
        $("#crudaction").val("insert-update");
        $('.inputFractionNumber').each(function(){
            if($(this).val() != '' && $(this).val() != 0 ) {
                $(this).val(numeral().unformat($(this).val()));
            }
        });
        $("#itemForm").submit();
    }
</script>
