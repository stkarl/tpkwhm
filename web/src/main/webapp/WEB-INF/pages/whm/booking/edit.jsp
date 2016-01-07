<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" errorPage="/error.jsp" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@page import="com.banvien.tpk.core.Constants" %>

<head>
    <title><fmt:message key="booking.bill.edit.title"/></title>
    <meta name="heading" content="<fmt:message key="booking.bill.edit.title"/>"/>
    <link rel="stylesheet" href="<c:url value='/themes/whm/css/jquery.jscrollpane.css' />" />
</head>

<c:url var="url" value="/whm/booking/edit.html"/>
<c:url var="backUrl" value="/whm/booking/list.html"/>

<form:form commandName="item" action="${url}" method="post" id="itemForm" class="form-horizontal" novalidate="novalidate">
    <div id="container-fluid data_content_box">
        <div class="row-fluid data_content">
            <div class="content-header"><fmt:message key="booking.bill.edit.title"/></div>
            <div class="clear"></div>
            <div id="generalInfor">
                <table class="tbHskt info">
                    <caption><fmt:message key="import.material.generalinfo"/></caption>
                    <tr>
                        <td class="wall"><fmt:message key="label.customer"/></td>
                        <td colspan="2">
                            <form:select path="pojo.customer.customerID" id="sl_customer" onchange="verifyLiability(this.value);">
                                <form:option value="-1">Chưa xác định</form:option>
                                <c:forEach items="${customers}" var="customer">
                                    <form:option value="${customer.customerID}">${customer.name}-${customer.address}</form:option>
                                </c:forEach>
                            </form:select>
                        </td>
                        <td colspan="3"></td>
                    </tr>
                    <tr>
                        <td><fmt:message key="label.description"/></td>
                        <td colspan="5">
                                ${item.pojo.description}
                        </td>
                    </tr>
                </table>
            </div>
            <div class="clear"></div>
            <c:if test="${not empty item.pojo.bookProducts}">
                <display:table name="item.pojo.bookProducts" cellspacing="0" cellpadding="0" requestURI="${formlUrl}"
                               partialList="true" sort="external" size="${fn:length(item.pojo.bookProducts)}"
                               uid="tableList" excludedParams="crudaction"
                               pagesize="${fn:length(item.pojo.bookProducts)}" export="false" class="tableSadlier table-hover">
                    <display:caption><fmt:message key='booked.product.list'/></display:caption>
                    <display:column headerClass="table_header_center" sortable="false" title="STT" class="text-center" style="width: 2%;">
                        ${tableList_rowNum}
                    </display:column>
                    <display:column headerClass="table_header_center" property="importProduct.productname.name" sortable="false"  titleKey="whm.productname.name" class="text-center" style="width: 7%;"/>
                    <display:column headerClass="table_header_center" property="importProduct.productCode" titleKey="label.number" class="text-center" style="width: 7%;"/>

                    <display:column headerClass="table_header_center" property="importProduct.size.name" sortable="false"  titleKey="whm.size.name" class="text-center" style="width: 7%;"/>
                    <display:column headerClass="table_header_center" property="importProduct.thickness.name" sortable="false"  titleKey="whm.thickness.name" class="text-center" style="width: 7%;"/>
                    <display:column headerClass="table_header_center" property="importProduct.stiffness.name" sortable="false"  titleKey="whm.stiffness.name" class="text-center" style="width: 7%;"/>
                    <display:column headerClass="table_header_center" property="importProduct.colour.name" sortable="false"  titleKey="whm.colour.name" class="text-center" style="width: 7%;"/>
                    <display:column headerClass="table_header_center" property="importProduct.overlaytype.name" sortable="false"  titleKey="whm.overlaytype.name" class="text-center" style="width: 7%;"/>
                    <%--<display:column headerClass="table_header_center" property="importProduct.market.name" sortable="false"  titleKey="whm.market.name" class="text-center" style="width: 7%;"/>--%>

                    <display:column headerClass="table_header large" sortName="quantity1" sortable="false" titleKey="label.quantity.meter" style="width: 10%;text-align:right;">
                        <fmt:formatNumber value="${tableList.importProduct.quantity1}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/>
                    </display:column>
                    <display:column headerClass="table_header large" sortName="quantity2Pure" sortable="false" titleKey="label.quantity.kg" style="width: 10%;text-align:right;">
                        <fmt:formatNumber value="${tableList.importProduct.quantity2Pure}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/>
                    </display:column>

                    <display:column headerClass="table_header_center" sortable="false" titleKey="import.warehouse.date" class="text-center" style="width: 7%;">
                        <c:choose>
                            <c:when test="${not empty tableList.importProduct.produceDate}">
                                <fmt:formatDate value="${tableList.importProduct.produceDate}" pattern="dd/MM/yyyy"/>
                            </c:when>
                            <c:when test="${not empty tableList.importProduct.importDate}">
                                <fmt:formatDate value="${tableList.importProduct.importDate}" pattern="dd/MM/yyyy"/>
                            </c:when>
                            <c:otherwise>-</c:otherwise>
                        </c:choose>
                    </display:column>
                    <display:column headerClass="table_header_center" sortable="false" titleKey="sell.price" class="text-center" style="width: 10%;">
                        <fmt:formatNumber value="${tableList.importProduct.suggestedPrice}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/>
                    </display:column>
                    <c:if test="${item.pojo.status != Constants.CONFIRMED}">
                        <display:column headerClass="table_header_center" sortable="false" titleKey="label.options" style="width: 5%;text-align:center;">
                            <a onclick="removeProduct(this,${tableList.bookProductID})" href="#" class="icon-remove tip-top" title="<fmt:message key="label.delete"/>"></a>
                        </display:column>
                    </c:if>
                    <display:setProperty name="paging.banner.item_name" value="cuộn tôn"/>
                    <display:setProperty name="paging.banner.items_name" value="cuộn tôn"/>
                    <display:setProperty name="paging.banner.placement" value=""/>
                    <display:setProperty name="paging.banner.no_items_found" value=""/>
                </display:table>
            </c:if>
            <div class="clear"></div>

            <div class="controls">
                <c:if test="${item.pojo.status != Constants.CONFIRMED}">
                    <a onclick="save()" class="btn btn-success btn-green" style="cursor: pointer;">
                        <fmt:message key="button.save"/>
                    </a>
                </c:if>
                <div style="display: inline">
                    <form:hidden path="crudaction" id="crudaction" value="insert-update"/>
                    <form:hidden path="pojo.bookProductBillID"/>
                    <a href="${backUrl}" class="cancel-link">
                        <fmt:message key="button.cancel"/>
                    </a>
                </div>
            </div>
        </div>
    </div>
</form:form>
<script type="text/javascript">

function save(){
    $("#crudaction").val("insert-update");    
    $("#itemForm").submit();
}
function removeProduct(Ele,bookProductID){
    var bookProductID = bookProductID;
    var textInfo = '<fmt:message key="booked.product.xacnhanxoa.msg" />';
    var form = $("<form class='form-inline'><label>" +textInfo+ "</label></form>");
    var div = bootbox.dialog(form,
            [
                {
                    "label" : "<i class='icon-ok'></i> " + '<fmt:message key="button.accept" />',
                    "class" : "btn-small btn-success",
                    "callback" : function(){
                        $.ajax({
                            url : '<c:url value="/ajax/removeBookedProduct.html"/>',
                            type: 'post',
                            cache: false,
                            data: {'bookProductID': bookProductID},
                            success: function(data){
                                var error = data.error;
                                if (error != null) {
                                    alert(error);
                                }else{
                                    $(Ele).closest('tr').remove();
                                }
                            }
                        });
                    }
                },
                {
                    "label" : "<i class='icon-remove'></i> " + '<fmt:message key="button.cancel" />',
                    "class" : "btn-small btn-warning"
                }
            ]
            ,
            {
                // prompts need a few extra options
                "onEscape": function(){
                    div.modal("hide");
                }
            }
    );
}
function verifyLiability(customerID){
    if(customerID > 0){
        var status;
        var url = '<c:url value="/ajax/customer/verifyLiability.html"/>?customerID=' + customerID;
        $.getJSON(url, function(data) {
            if (data.allow != null){
                status = data.allow;
                if(status == 0){
                    bootbox.alert("<fmt:message key="label.title.confirm"/>", "<fmt:message key="customer.warning.status.msg"/>",function(){
                        $("#sl_customer").select2("val","");
                    });
                }else{
                    showLiability(customerID);
                }
            }
        });
    }
}

function showLiability(customerID){
    $.ajax({
        url : "<c:url value="/ajax/customer/showLiability.html"/>",
        data:{customerID : customerID},
        type: "GET",
        dataType : "html",
        cache: false,
        success: function(){

        },
        complete : function(res){
            var form = $(res.responseText);
            var modal = bootbox.dialog(form, [
                {
                    "label" :  "<i class='icon-remove-sign'></i> <fmt:message key="button.cancel"/>",
                    "class" : "btn-small btn-primary",
                    "callback" : function(){
                        form.remove();
                    }
                }],
                    {
                        "onEscape": function(){
                            form.remove();
                        }
                    });
            modal.modal("show");

        }
    });
}
</script>