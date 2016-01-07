<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>


<head>
    <title><fmt:message key="user.customer.title"/></title>
    <meta name="heading" content="<fmt:message key="user.customer.title"/>"/>
</head>

<c:url var="backUrl" value="/whm/user/list.html"/>
<c:url var="url" value="/whm/user/usercustomer.html"/>

<body>
<form:form commandName="items" action="${url}" method="post" id="listForm">
    <div id="container-fluid data_content_box">
        <div class="row-fluid data_content">
            <div class="content-header">
                <fmt:message key="user.customer.title"/> - ${user.fullname}
            </div>
            <div class="clear"></div>
            <c:if test="${not empty messageResponse}">
                <div class="alert alert-${alertType}">
                    <button aria-hidden="true" data-dismiss="alert" class="close" type="button">x</button>
                        ${messageResponse}
                </div>
            </c:if>
            <div class="clear"></div>
            <div class="button-actions">
                <a onclick="document.location.href='${backUrl}';" class="btn">
                    <i class="icon-backward"></i>
                    <fmt:message key="button.back"/>
                </a>
            </div>
            <div class="clear"></div>
            <c:if test="${! empty assignedCustomers}">
                <display:table name="assignedCustomers" cellspacing="0" cellpadding="0"
                               partialList="false" sort="external" size="${fn:length(assignedCustomers)}"  uid="tableList" pagesize="${fn:length(assignedCustomers)}" class="tableSadlier" export="false">
                    <display:caption>Danh sách khách hàng đã giao</display:caption>
                    <display:column headerClass="table_header"  escapeXml="false" sortable="false" title="" style="width: 5%">
                        <a onclick="removeCustomer('${tableList.userCustomerID}' , '${tableList.user.userID}')" href="#" class="icon-remove tip-top" title="<fmt:message key="label.delete"/>"></a>
                    </display:column>
                    <display:column headerClass="table_header"  escapeXml="false" sortable="false" titleKey="whm.customer.name">
                        ${tableList.customer.name}
                    </display:column>
                    <display:column headerClass="table_header"  escapeXml="false" sortable="false" titleKey="label.address">
                        ${tableList.customer.address}
                    </display:column>
                    <display:column headerClass="table_header"  escapeXml="false" sortable="false" titleKey="whm.province.name">
                        ${tableList.customer.province.name}
                    </display:column>
                    <display:column headerClass="table_header"  escapeXml="false" sortable="false" titleKey="whm.region.name">
                        ${tableList.customer.region.name}
                    </display:column>
                    <display:setProperty name="paging.banner.item_name">khách hàng</display:setProperty>
                    <display:setProperty name="paging.banner.items_name" >khách hàng</display:setProperty>
                    <display:setProperty name="paging.banner.placement" value="bottom"/>
                    <display:setProperty name="paging.banner.no_items_found" value=""/>
                </display:table>
                <div class="clear"></div>
            </c:if>



            <div class="report-filter">
                <div class="row-fluid report-filter">
                    <table class="tbReportFilter">
                        <caption><fmt:message key="label.search.title"/></caption>
                        <tr>
                            <td ><fmt:message key="label.name"/></td>
                            <td><form:input path="pojo.name" size="40"/></td>
                            <td ><fmt:message key="whm.region.name"/></td>
                            <td>
                                <form:select path="pojo.region.regionID">
                                    <form:option value="-1">Tất cả</form:option>
                                    <form:options items="${regions}" itemValue="regionID" itemLabel="name"/>
                                </form:select>
                            </td>
                        </tr>
                        <tr style="text-align: center;">
                            <td colspan="4">
                                <form:hidden path="crudaction" id="crudaction" value="doReport"/>
                                <a id="btnFilter" class="btn btn-primary " onclick="$('#listForm').submit();"><i class="icon-refresh"></i> <fmt:message key="label.search"/> </a>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>

            <div class="button-actions">
                <a onclick="update();" class="btn btn-success">
                    <i class="icon-save"></i>
                    <fmt:message key="button.update"/>
                </a>
            </div>
            <div class="clear"></div>
            <display:table name="items.listResult" cellspacing="0" cellpadding="0" requestURI="${url}"
                           partialList="false" sort="external" size="${items.totalItems}"  uid="tableList" pagesize="${items.maxPageItems}" class="tableSadlier" export="false">
                <display:caption>Danh sách khách hàng</display:caption>
                <display:column headerClass="table_header"  escapeXml="false" sortable="false" title="<input type=\"checkbox\" onclick=\"checkAll('check_customer', this);\"/>" style="width: 5%">
                    <input class="check_customer" type="checkbox" name="customerIDs" value="${tableList.customerID}"/>
                </display:column>
                <display:column headerClass="table_header"  escapeXml="false" sortable="false" titleKey="whm.customer.name">
                   ${tableList.name}
                </display:column>
                <display:column headerClass="table_header"  escapeXml="false" sortable="false" titleKey="label.address">
                    ${tableList.address}
                </display:column>
                <display:column headerClass="table_header"  escapeXml="false" sortable="false" titleKey="whm.province.name">
                    ${tableList.province.name}
                </display:column>
                <display:column headerClass="table_header"  escapeXml="false" sortable="false" titleKey="whm.region.name">
                    ${tableList.region.name}
                </display:column>
                <display:setProperty name="paging.banner.item_name">khách hàng</display:setProperty>
                <display:setProperty name="paging.banner.items_name" >khách hàng</display:setProperty>
                <display:setProperty name="paging.banner.placement" value="bottom"/>
                <display:setProperty name="paging.banner.no_items_found" value=""/>
            </display:table>
            <div class="clear"></div>
            <form:hidden path="userID"/>
        </div>
    </div>
</form:form>
<script type="text/javascript">
    function update(){
        $('#crudaction').val('update');
        submitForm('listForm');
    }
    <c:if test="${not empty items.crudaction}">
    highlightTableRows("tableList");
    </c:if>

    function checkAll(clsName, thisElement){
        var isChecked = $(thisElement).is(":checked");
        if(isChecked){
            $("." + clsName).each(function(index, value){
                $(this).attr("checked", true);
                $(this).parent("span").addClass("checked")
            });
        }else{
            $("." + clsName).each(function(index, value){
                $(this).attr("checked", false);
                $(this).parent("span").removeClass("checked")
            });
        }
    }

    function removeCustomer(userCustomerID, userID){
        var userCustomerID = userCustomerID;
        var userID = userID;
        var textInfo = '<fmt:message key="user.customer.xacnhanxoa.msg" />';
        var form = $("<form class='form-inline'><label>" +textInfo+ "</label></form>");
        var div = bootbox.dialog(form,
                [
                    {
                        "label" : "<i class='icon-ok'></i> " + '<fmt:message key="button.accept" />',
                        "class" : "btn-small btn-success",
                        "callback" : function(){
                            $.ajax({
                                url : '<c:url value="/ajax/removeUserCustomer.html"/>',
                                type: 'post',
                                cache: false,
                                data: {'userCustomerID': userCustomerID},
                                success: function(data){
                                    var error = data.error;
                                    if (error != null) {
                                        alert(error);
                                    }else{
                                        window.location.href = "<c:url value='/whm/user/usercustomer.html?userID='/>" + userID + '&isDeleted=true';
//                                        $(Ele).closest('tr').remove();
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

</script>
</body>
