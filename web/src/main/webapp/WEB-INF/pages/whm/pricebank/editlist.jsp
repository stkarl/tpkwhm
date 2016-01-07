<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<head>
    <title><fmt:message key="price.bank.title"/></title>
    <meta name="heading" content="<fmt:message key="price.bank.title"/>"/>
</head>
<style>
    table tbody tr td{
        vertical-align: middle;
    }
    .sanXuat {
        background-color: darkseagreen;text-align: center;font-weight: bold;
    }
</style>

<c:url var="url" value="/whm/materialmeasurement/editlist.html"/>
<c:url var="backUrl" value="/whm/home.html"/>
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
                <fmt:message key="price.bank.title"/>
            </div>
            <div class="clear"></div>
            <div class="row-fluid">
                <div class="pane_info">
                    <div class="pane_title">Thông tin chung</div>
                    <div class="pane_content">
                        <div class="control-group">
                            <label class="control-label">
                                <fmt:message key="label.effected.date"/>
                            </label>
                            <div class="controls">
                                <fmt:formatDate var="effectedDate" value="${item.effectedDate}" pattern="dd/MM/yyyy"/>
                                <div class="input-append date" style="margin-right: 1px;">
                                    <input name="effectedDate" id="effectedDate" class="prevent_type text-center width2" type="text" value="${effectedDate}"/>
                                    <span class="add-on" id="effectedDateIcon"><i class="icon-calendar"></i></span>
                                </div>
                            </div>
                            <div class="controls">
                                <a onclick="submitPrice();" class="btn btn-success btn-green" style="cursor: pointer;">
                                    <fmt:message key="button.update"/>
                                </a>
                                <div style="display: inline">
                                    <form:hidden path="crudaction" id="crudaction" value="insert-update"/>
                                    <a href="${backUrl}" class="cancel-link">
                                        <fmt:message key="button.cancel"/>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <c:set var="qualityLength" value="${fn:length(qualities)}"/>
            <table class="tableSadlier table-hover">
                <caption><fmt:message key="set.price.bank"/></caption>
                <tr>
                    <th rowspan="2">Quy cách</th>
                    <c:if test="${item.thickness}">
                        <c:forEach items="${thicknesses}" var="thickness">
                            <th colspan="${qualityLength}">${thickness.name}</th>
                        </c:forEach>
                    </c:if>
                    <c:if test="${item.colour}">
                        <c:forEach items="${colours}" var="colour">
                            <th colspan="${qualityLength}">${colour.name}</th>
                        </c:forEach>
                    </c:if>
                </tr>
                <tr>
                    <c:if test="${item.thickness}">
                        <c:forEach items="${thicknesses}" var="thickness">
                            <c:forEach items="${qualities}" var="quality">
                                <th>${quality.description}</th>
                            </c:forEach>
                        </c:forEach>
                    </c:if>
                    <c:if test="${item.colour}">
                        <c:forEach items="${colours}" var="colour">
                            <c:forEach items="${qualities}" var="quality">
                                <th>${quality.description}</th>
                            </c:forEach>
                        </c:forEach>
                    </c:if>
                </tr>
                <c:set var="counter" value="0"/>
                <c:forEach items="${sizes}" var="size">
                    <tr>
                        <td>
                            ${size.name}
                        </td>
                        <c:if test="${item.thickness}">
                            <c:forEach items="${thicknesses}" var="thickness">
                                <c:forEach items="${qualities}" var="quality">
                                    <td>
                                        <input type="text" name="priceUpdates[${counter}].price" style="width: 55px;" class="inputNumber row-${size.sizeID}-${quality.qualityID}" size="${size.sizeID}" quality="${quality.qualityID}" onblur="updateOthers(this);">
                                        <input type="hidden" value="${size.sizeID}" name="priceUpdates[${counter}].size.sizeID">
                                        <input type="hidden" value="${productName.productNameID}" name="priceUpdates[${counter}].productName.productNameID">
                                        <input type="hidden" value="${thickness.thicknessID}" name="priceUpdates[${counter}].thickness.thicknessID">
                                        <input type="hidden" value="${quality.qualityID}" name="priceUpdates[${counter}].quality.qualityID">
                                    </td>
                                    <c:set var="counter" value="${counter + 1}"/>
                                </c:forEach>
                            </c:forEach>
                        </c:if>
                        <c:if test="${item.colour}">
                            <c:forEach items="${colours}" var="colour">
                                <c:forEach items="${qualities}" var="quality">
                                    <td>
                                        <input type="text" name="priceUpdates[${counter}].price" style="width: 55px;" class="inputNumber row-${size.sizeID}-${quality.qualityID}" size="${size.sizeID}" quality="${quality.qualityID}" onblur="updateOthers(this);">
                                        <input type="hidden" value="${size.sizeID}" name="priceUpdates[${counter}].size.sizeID">
                                        <input type="hidden" value="${productName.productNameID}" name="priceUpdates[${counter}].productName.productNameID">
                                        <input type="hidden" value="${colour.colourID}" name="priceUpdates[${counter}].colour.colourID">
                                        <input type="hidden" value="${quality.qualityID}" name="priceUpdates[${counter}].quality.qualityID">
                                    </td>
                                    <c:set var="counter" value="${counter + 1}"/>
                                </c:forEach>
                            </c:forEach>
                        </c:if>
                    </tr>
                </c:forEach>
            </table>
        </div>
    </div>
</form:form>
<script>
    $(document).ready(function(){
        var effectedDateVar = $("#effectedDate").datepicker({
            format: 'dd/mm/yyyy',
            onRender: function(date){
            }}).on('changeDate', function(ev) {
                    effectedDateVar.hide();
                }).data('datepicker');
        $('#effectedDateIcon').click(function() {
            $('#effectedDate').focus();
            return true;
        });

    });
    function submitPrice(){
        var hasInputNumber = false;
        $("#crudaction").val("insert-update");
        $('.inputNumber').each(function(){
            if($(this).val() != '' && $(this).val() != 0 ) {
                hasInputNumber = true;
                $(this).val(numeral().unformat($(this).val()));
            }
        });
        if(hasInputNumber){
            $("#itemForm").submit();
        }else{
            bootbox.alert("<fmt:message key="label.title.confirm"/>", "Vui lòng nhập giá",function(){});
        }
    }

    function updateOthers(ele){
        var price = $(ele).val();
        var sizeId = $(ele).attr('size');
        var qualityId = $(ele).attr('quality');
        $('.row-' + sizeId + '-' + qualityId).each(function(){
            if($(this).val() == ''){
                $(this).val(price);
            }
        });
    }

</script>
