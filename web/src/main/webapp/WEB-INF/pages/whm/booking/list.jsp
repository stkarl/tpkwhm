<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@page import="com.banvien.tpk.core.Constants" %>
<html>
<head>
    <title><fmt:message key="booking.bill.list.title"/></title>
    <meta name="heading" content="<fmt:message key='booking.bill.list.title'/>"/>
</head>
<c:url var="urlForm" value="/whm/booking/list.html"></c:url>
<c:url var="viewUrl" value="/whm/booking/view.html"></c:url>
<c:url var="editUrl" value="/whm/instock/booking.html"></c:url>
<body>
<div class="row-fluid data_content">
    <div class="content-header"><fmt:message key="booking.bill.list.title"/></div>
    <div class="clear"></div>
    <c:if test="${not empty messageResponse}">
        <div class="alert alert-${alertType}">
            <button aria-hidden="true" data-dismiss="alert" class="close" type="button">x</button>
                ${messageResponse}
        </div>
    </c:if>
    <div class="report-filter">
        <form:form commandName="items" action="${urlForm}" id="listForm" method="post" autocomplete="off" name="listForm">
            <table class="tbReportFilter" >
                <caption><fmt:message key="label.search.title"/></caption>
                <tr>
                    <td class="label-field"><fmt:message key="label.fromdate"/></td>
                    <td>
                        <div class="input-append date" >
                            <fmt:formatDate var="ngayKeKhaiFrom" value="${items.fromDate}" pattern="dd/MM/yyyy"/>
                            <input name="fromDate" id="effectiveFromDate" class="prevent_type text-center width2" value="${ngayKeKhaiFrom}" type="text" />
                            <span class="add-on" id="effectiveFromDateIcon"><i class="icon-calendar"></i></span>
                        </div>
                    </td>
                    <td class="label-field"><fmt:message key="label.todate"/></td>
                    <td>
                        <div class="input-append date" >
                            <fmt:formatDate var="ngayKeKhaiTo" value="${items.toDate}" pattern="dd/MM/yyyy"/>
                            <input name="toDate" id="effectiveToDate" class="prevent_type text-center width2" value="${ngayKeKhaiTo}" type="text" />
                            <span class="add-on" id="effectiveToDateIcon"><i class="icon-calendar"></i></span>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="label-field"><fmt:message key="label.customer"/></td>
                    <td>
                        <form:select path="customerID" cssStyle="width: 360px;">
                            <form:option value="-1">Tất cả</form:option>
                            <c:forEach items="${customers}" var="customer">
                                <form:option value="${customer.customerID}">${customer.name} - ${customer.province.name}</form:option>
                            </c:forEach>
                        </form:select>
                    </td>
                    <td class="label-field"><fmt:message key="label.user"/></td>
                    <td>
                        <form:select path="userID">
                            <form:option value="-1">Tất cả</form:option>
                            <form:options items="${users}" itemValue="userID" itemLabel="fullname"/>
                        </form:select>
                    </td>
                </tr>
                <tr>
                    <td class="label-field"><fmt:message key="label.status"/></td>
                    <td>
                        <form:select path="status">
                            <form:option value="-1">Tất cả</form:option>
                            <form:option value="${Constants.BOOK_WAIT_CONFIRM}">Chờ duyệt</form:option>
                            <form:option value="${Constants.BOOK_REJECTED}">Bị từ chối</form:option>
                            <form:option value="${Constants.BOOK_ALLOW_EXPORT}">Chờ xuất hàng</form:option>
                            <form:option value="${Constants.BOOK_EXPORTING}">Đang xuất hàng</form:option>
                            <form:option value="${Constants.BOOK_EXPORTED}">Đã hoàn thành</form:option>
                        </form:select>
                    </td>
                    <td class="label-field"></td>
                    <td></td>
                </tr>
                <tr style="text-align: center;">
                    <td colspan="4">
                        <a id="btnFilter" class="btn btn-primary " onclick="searchBill();"><i class="icon-refresh"></i> <fmt:message key="label.search"/> </a>
                    </td>
                </tr>
            </table>
            <div class="clear"></div>
            <div id="infoMsg"></div>
            <display:table name="items.listResult" cellspacing="0" cellpadding="0" requestURI="${formlUrl}"
                           partialList="true" sort="external" size="${items.totalItems }"
                           uid="tableList" excludedParams="crudaction"
                           pagesize="${items.maxPageItems}" export="false" class="tableSadlier table-hover">
                <display:caption><fmt:message key='booking.bill.list.title'/></display:caption>
                <display:column headerClass="table_header_center" sortable="false" title="STT" class="text-center" style="width: 2%;">
                    ${tableList_rowNum}
                </display:column>
                <display:column headerClass="table_header_center" property="description" titleKey="label.description" class="text-center" style="width: 40%;"/>
                <display:column headerClass="table_header large" property="customer.name" titleKey="label.customer" style="width: 10%;"/>
                <display:column headerClass="table_header large" titleKey="delivery.date" style="width: 10%;">
                    <fmt:formatDate value="${tableList.deliveryDate}" pattern="dd/MM/yyyy"/>
                </display:column>

                <display:column headerClass="table_header large" property="createdBy.fullname" titleKey="label.created.by" style="width: 10%;"/>
                <display:column headerClass="table_header_center" sortName="status" sortable="true" titleKey="label.status" style="width: 10%;text-align:center;">
                    <span class="bookStatusSpan">
                    <c:choose>
                        <c:when test="${tableList.status == Constants.BOOK_WAIT_CONFIRM}">Chờ duyệt</c:when>
                        <c:when test="${tableList.status == Constants.BOOK_REJECTED}">Bị từ chối</c:when>
                        <c:when test="${tableList.status == Constants.BOOK_ALLOW_EXPORT}">Chờ xuất hàng</c:when>
                        <c:when test="${tableList.status == Constants.BOOK_EXPORTING}">Đang xuất hàng</c:when>
                        <c:when test="${tableList.status == Constants.BOOK_EXPORTED}">Đã hoàn thành</c:when>
                        <c:otherwise>-</c:otherwise>
                    </c:choose>
                    </span>
                </display:column>
                <display:column headerClass="table_header_center" sortable="false" titleKey="label.options" style="width: 10%;text-align:center;">
                    <security:authorize ifAnyGranted="NHANVIENKD,QUANLYKD,QUANLYTT,LANHDAO,ADMIN,QUANLYNO">
                    <a href="${viewUrl}?pojo.bookProductBillID=${tableList.bookProductBillID}" class="icon-eye-open tip-top" title="<fmt:message key="label.view"/>"></a>
                    </security:authorize>
                    <security:authorize ifAnyGranted="XUAT_TD,XUAT_TP,QUANLYKHO" ifNotGranted="NHANVIENKD,QUANLYKD,QUANLYTT,LANHDAO,ADMIN,QUANLYNO">
                        <c:if test="${tableList.status >= Constants.BOOK_ALLOW_EXPORT}">
                            <a href="${viewUrl}?pojo.bookProductBillID=${tableList.bookProductBillID}" class="icon-eye-open tip-top" title="<fmt:message key="label.view"/>"></a>
                        </c:if>
                    </security:authorize>
                    <security:authorize ifNotGranted="ADMIN,QUANLYKD,LANHDAO">
                        <c:if test="${tableList.status < Constants.BOOK_ALLOW_EXPORT && items.loginID == tableList.createdBy.userID}">
                            <span class="separator"></span>
                            <a href="${editUrl}?bookProductBillID=${tableList.bookProductBillID}" class="icon-edit tip-top" title="<fmt:message key="label.edit.selected.product"/>"></a>
                            <span class="separator"></span>
                            <a name="deleteLink" onclick="warningDelete(this)" id="${tableList.bookProductBillID}" href="#" class="icon-remove tip-top" title="<fmt:message key="label.delete"/>"></a>
                        </c:if>
                    </security:authorize>
                    <security:authorize ifAnyGranted="ADMIN,QUANLYKD,LANHDAO">
                        <c:if test="${tableList.status < Constants.BOOK_EXPORTED && tableList.status != Constants.BOOK_REJECTED}">
                            <span class="separator"></span>
                            <a title="<fmt:message key='label.reject'/>" href="#" class="tip-top" onclick="confirmBooking($(this),${tableList.bookProductBillID},${Constants.BOOK_REJECTED});">
                                <i class="icon-thumbs-down-alt bigger-230"></i>
                            </a>
                        </c:if>
                        <c:if test="${tableList.status < Constants.BOOK_EXPORTING}">
                            <span class="separator"></span>
                            <a href="${editUrl}?bookProductBillID=${tableList.bookProductBillID}" class="icon-edit tip-top" title="<fmt:message key="label.edit.selected.product"/>"></a>
                            <span class="separator"></span>
                            <a name="deleteLink" onclick="warningDelete(this)" id="${tableList.bookProductBillID}" href="#" class="icon-remove tip-top" title="<fmt:message key="label.delete"/>"></a>
                        </c:if>
                    </security:authorize>
                </display:column>
                <display:setProperty name="paging.banner.item_name" value="Phiếu đặt bán hàng"/>
                <display:setProperty name="paging.banner.items_name" value="Phiếu đặt bán hàng"/>
                <display:setProperty name="paging.banner.placement" value="bottom"/>
                <display:setProperty name="paging.banner.no_items_found" value=""/>
            </display:table>
            <form:hidden path="crudaction" id="crudaction"/>
        </form:form>
    </div>
</div>

<script type="text/javascript">
    $(document).ready(function(){
        var effectiveToDateVar = $("#effectiveToDate").datepicker({
            format: 'dd/mm/yyyy',
            onRender: function(date){
            }}).on('changeDate', function(ev) {
                    effectiveToDateVar.hide();
                }).data('datepicker');
        var effectiveFromDateVar = $("#effectiveFromDate").datepicker({
            format: 'dd/mm/yyyy',
            onRender: function(date){
            }}).on('changeDate', function(ev) {
                    effectiveFromDateVar.hide();
                }).data('datepicker');
        $('#effectiveToDateIcon').click(function() {
            $('#effectiveToDate').focus();
            return true;
        });
        $('#effectiveFromDateIcon').click(function() {
            $('#effectiveFromDate').focus();
            return true;
        });


        $("#btnFilter").click(function(){
            $("#crudaction").val("search");
            $("#listForm").submit();
        });
    });

    function searchBill(){
        $("#crudaction").val("search");
        submitForm('listForm');
    }

    function confirmBooking(inputEle,bookId,status){
        if (inputEle.attr("disabled")){
            return;
        }

        var textInfo = "";
        if (status == ${Constants.BOOK_REJECTED}){
            textInfo = '<fmt:message key="msg.book.reject" />';
        }
        var form = $("<form class='form-inline'><label>" +textInfo+ "</label></form>");
        var div = bootbox.dialog(form,
                [
                    {
                        "label" : "<i class='icon-ok'></i> " + '<fmt:message key="label.approve" />',
                        "class" : "btn-small btn-success",
                        "callback" : function(){
                            $.ajax({
                                url : '/ajax/booking/confirmation.html',
                                dataType: "json",
                                data : "pojo.bookProductBillID=" +bookId+ "&pojo.status=" +status,
                                type : "POST",
                                success : function(res){
                                    var text = "";
                                    if (null != res.text){
                                        if (res.text == "Reject"){
                                            text = '<fmt:message key="msg.rejected.success" />';
                                        }else if(res.text == "Approve"){
                                            text = '<fmt:message key="msg.approved.success" />';
                                        }
                                    }
                                    $('#infoMsg').html("<div class='alert alert-success' style='margin-top: 10px;'>"
                                            + "<button type='button' class='close' data-dismiss='alert'>&times;</button>"
                                            + "<span>" +text+"</div>");
                                    inputEle.closest('tr').find('.manual-style').attr("disabled", "disabled");
                                    inputEle.closest('tr').css('background-color', '#dff0d8');
                                    inputEle.closest('tr').css('cursor', 'not-allowed');
                                    inputEle.closest('tr').find('.manual-style').css('cursor', 'not-allowed');
                                    if (status == ${Constants.BOOK_REJECTED}){
                                        inputEle.closest('tr').find('.bookStatusSpan').text('Bị từ chối');
                                    }else if (status == ${Constants.BOOK_ALLOW_EXPORT}){
                                        inputEle.closest('tr').find('.bookStatusSpan').text('Chờ xuất hàng');
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
                    "onEscape": function(){
                        div.modal("hide");
                    }
                }
        );

    }
</script>
</body>
</html>