<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@page import="com.banvien.tpk.core.Constants" %>
<html>
<head>
    <title><fmt:message key="booking.product"/></title>
    <meta name="heading" content="<fmt:message key='booking.product'/>"/>
    <link rel="stylesheet" href="<c:url value='/themes/whm/css/jquery.jscrollpane.css' />" />
    <style>
        table.tbHskt .table_header{
            text-align: left;
            padding: 4px 2px 4px 5px;
        }
    </style>

</head>
<c:url var="backUrl" value="/whm/booking/list.html"/>
<c:url var="urlForm" value="/whm/instock/booking.html"></c:url>
<body>
<div class="row-fluid data_content">
<div class="content-header"><fmt:message key="booking.product"/></div>
<div class="clear"></div>
<c:if test="${not empty messageResponse}">
    <div class="alert alert-${alertType}">
        <button aria-hidden="true" data-dismiss="alert" class="close" type="button">x</button>
            ${messageResponse}
    </div>
</c:if>
<div class="report-filter">
<form:form commandName="items" action="${urlForm}" id="itemForm" method="post" autocomplete="off" name="itemForm">
<div id="generalInfor">
    <table class="tbHskt info">
        <caption><fmt:message key="import.material.generalinfo"/></caption>
        <tr>
            <td><fmt:message key="label.description"/></td>
            <td colspan="5">
                    ${bookBill.description}
            </td>
        </tr>
        <tr>
            <td><fmt:message key="label.customer"/></td>
            <td colspan="2">
                    ${bookBill.customer.name} - ${bookBill.customer.province.name}
            </td>
            <td class="wall"><fmt:message key="delivery.date"/></td>
            <td colspan="2">
                <fmt:formatDate value="${bookBill.deliveryDate}" pattern="dd/MM/yyyy"/>
            </td>
        </tr>
        <tr>
            <td><fmt:message key="whm.owe.util.bill.date"/></td>
            <td colspan="2">
                <fmt:formatNumber value="${owe}" pattern="###,###"/>
            </td>
            <td class="wall"><fmt:message key="bill.date"/></td>
            <td colspan="2">
                <fmt:formatDate value="${bookBill.billDate}" pattern="dd/MM/yyyy"/>
            </td>
        </tr>

    </table>
</div>
<div class="clear"></div>
<c:if test="${!empty bookBill.bookBillSaleReasons}">
    <div id="reduce-money">
        <table class="tbHskt info">
            <caption><fmt:message key="money.reduce"/></caption>
            <tr>
                <th class="table_header" style="width: 50%;">Lý do khấu trừ</th>
                <th class="table_header" style="width: 20%;">Ngày</th>
                <th class="table_header" style="width: 30%;">Số tiền</th>
            </tr>
            <c:forEach items="${bookBill.bookBillSaleReasons}" var="reason">
                <tr>
                    <td>${reason.saleReason.reason}</td>
                    <td><fmt:formatDate value="${reason.date}" pattern="dd/MM/yyyy"/></td>
                    <td><fmt:formatNumber value="${reason.money}" pattern="###,###"/></td>
                </tr>
            </c:forEach>
        </table>
    </div>
    <div class="clear"></div>
</c:if>
<c:if test="${!empty bookBill.prePaids}">
    <div id="reduce-money">
        <table class="tbHskt info">
            <caption><fmt:message key="money.prepaid"/></caption>
            <tr>
                <th class="table_header" style="width: 50%;">Phương thức thanh toán</th>
                <th class="table_header" style="width: 20%;">Ngày thanh toán</th>
                <th class="table_header" style="width: 30%;">Số tiền</th>
            </tr>
            <c:forEach items="${bookBill.prePaids}" var="prePaid">
                <tr>
                    <td>${prePaid.note}</td>
                    <td><fmt:formatDate value="${prePaid.payDate}" pattern="dd/MM/yyyy"/></td>
                    <td><fmt:formatNumber value="${prePaid.pay}" pattern="###,###"/></td>
                </tr>
            </c:forEach>
        </table>
    </div>
    <div class="clear"></div>
</c:if>
<c:set var="selectedWarehouse" value="-1"/>
<c:if test="${not empty bookBill.bookProducts}">
    <div id="tbBookedContent" style="width:100%">
        <table class="tableSadlier table-hover" border="1" style="border-right: 1px;margin: 12px 0 20px 0;width: 1300px;">
            <caption><fmt:message key="booked.product.list"/></caption>
            <tr>
                <th class="table_header text-center"></th>
                <th class="table_header text-center"><fmt:message key="label.stt"/></th>
                <th class="table_header text-center"><fmt:message key="label.name"/></th>
                <th class="table_header text-center"><fmt:message key="label.code"/></th>
                <th class="table_header text-center"><fmt:message key="label.size"/></th>
                <th class="table_header text-center"><fmt:message key="label.specific"/></th>
                <th class="table_header text-center"><fmt:message key="whm.overlaytype.name"/></th>
                <th class="table_header text-center"><fmt:message key="label.kg"/></th>
                <c:forEach items="${qualities}" var="quality">
                    <th class="table_header text-center">${quality.name}</th>
                </c:forEach>
                <th class="table_header text-center"><fmt:message key="label.total.m"/></th>
                <th class="table_header text-center">Kg/m</th>
                <th class="table_header text-center"><fmt:message key="main.material.note"/></th>
                <th class="table_header text-center"><fmt:message key="whm.warehouse.name"/></th>
                <th class="table_header text-center"><fmt:message key="label.produced.date"/></th>
            </tr>
            <c:forEach items="${bookBill.bookProducts}" var="tableList" varStatus="status">
                <tr class="${status.index % 2 == 0 ? "even text-center" : "odd text-center"}">
                    <td>
                        <a onclick="removeProduct(this,'${tableList.bookProductID}','${bookBill.bookProductBillID}')" href="#" class="icon-remove tip-top" title="<fmt:message key="label.delete"/>"></a>
                    </td>
                    <td>${status.index + 1}</td>
                    <td>${tableList.importProduct.productname.name}</td>
                    <td>${tableList.importProduct.productCode}</td>
                    <td>${tableList.importProduct.size.name}</td>
                    <td>
                        <c:choose>
                            <c:when test="${not empty tableList.importProduct.colour}">
                                ${tableList.importProduct.colour.name}
                            </c:when>
                            <c:when test="${not empty tableList.importProduct.thickness}">
                                ${tableList.importProduct.thickness.name}
                            </c:when>
                        </c:choose>
                    </td>
                    <td>${tableList.importProduct.overlaytype.name}</td>
                    <td><fmt:formatNumber value="${tableList.importProduct.quantity2Pure}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/></td>
                    <c:forEach items="${qualities}" var="quality">
                        <td>
                            <c:forEach items="${tableList.importProduct.productqualitys}" var="productQuality">
                                <c:if test="${productQuality.quality.qualityID == quality.qualityID}">
                                    <fmt:formatNumber value="${productQuality.quantity1}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/>
                                </c:if>
                            </c:forEach>
                        </td>
                    </c:forEach>
                    <td><fmt:formatNumber value="${tableList.importProduct.quantity1}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/></td>
                    <td><fmt:formatNumber value="${tableList.importProduct.quantity2Pure / tableList.importProduct.quantity1}" pattern="###,###.##" maxFractionDigits="2" minFractionDigits="0"/></td>
                    <td>
                        <c:if test="${fn:length(tableList.importProduct.note) gt 35}">
                            <span title="${tableList.importProduct.note}"><str:truncateNicely upper="35" appendToEnd="...">${tableList.importProduct.note}</str:truncateNicely></span>
                        </c:if>
                        <c:if test="${fn:length(tableList.importProduct.note) lt 35}">
                            ${tableList.importProduct.note}
                        </c:if>
                    </td>
                    <td>${tableList.importProduct.warehouse.name}</td>
                    <c:set var="selectedWarehouse" value="${tableList.importProduct.warehouse.warehouseID}"/>
                    <td>
                        <c:choose>
                            <c:when test="${not empty tableList.importProduct.importDate}">
                                <fmt:formatDate value="${tableList.importProduct.importDate}" pattern="dd/MM/yyyy"/>
                            </c:when>
                            <c:when test="${not empty tableList.importProduct.produceDate}">
                                <fmt:formatDate value="${tableList.importProduct.produceDate}" pattern="dd/MM/yyyy"/>
                            </c:when>
                            <c:otherwise>-</c:otherwise>
                        </c:choose>
                    </td>

                </tr>
            </c:forEach>
        </table>
    </div>
    <div class="clear"></div>
    <div class="process-control">
        <a onclick="goSetPrice('${bookBill.bookProductBillID}')" class="btn btn-info" style="cursor: pointer;">
            <fmt:message key="go.set.price"/> <i class="icon-arrow-right"></i>
        </a>
    </div>
</c:if>
<div class="process-control-left">
    <a onclick="goEditInfo('${bookBill.bookProductBillID}')" class="btn btn-info" style="cursor: pointer;">
        <i class="icon-arrow-left"></i> Thay đổi thông tin chung
    </a>
    <a href="${backUrl}" class="cancel-link">
        <fmt:message key="button.cancel"/>
    </a>
</div>

<div class="clear"></div>

<table class="tbReportFilter" >
    <caption><fmt:message key="label.search.title"/></caption>
    <tr>
        <td class="label-field" ><fmt:message key="label.number"/></td>
        <td><form:input path="code" size="25" maxlength="45" /></td>
        <td class="label-field" ><fmt:message key="whm.warehouse"/></td>
        <td>
            <form:select path="warehouseID">
                <form:option value="-1">Tất cả</form:option>
                <form:options items="${warehouses}" itemValue="warehouseID" itemLabel="name"/>
            </form:select>
        </td>
    </tr>
    <tr>
        <td class="label-field"><fmt:message key="label.produce.from.date"/></td>
        <td>
            <div class="input-append date" >
                <fmt:formatDate var="ngayKeKhaiFrom" value="${items.fromImportedDate}" pattern="dd/MM/yyyy"/>
                <input name="fromImportedDate" id="effectiveFromDate" class="prevent_type text-center width2" value="${ngayKeKhaiFrom}" type="text" />
                <span class="add-on" id="effectiveFromDateIcon"><i class="icon-calendar"></i></span>
            </div>
        </td>
        <td class="label-field"><fmt:message key="label.to.import.date"/></td>
        <td>
            <div class="input-append date" >
                <fmt:formatDate var="ngayKeKhaiTo" value="${items.toImportedDate}" pattern="dd/MM/yyyy"/>
                <input name="toImportedDate" id="effectiveToDate" class="prevent_type text-center width2" value="${ngayKeKhaiTo}" type="text" />
                <span class="add-on" id="effectiveToDateIcon"><i class="icon-calendar"></i></span>
            </div>
        </td>
    </tr>
    <tr>
        <td class="label-field"><fmt:message key="whm.productname.name"/></td>
        <td>
            <form:select path="productNameID">
                <form:option value="-1">Tất cả</form:option>
                <form:options items="${productNames}" itemValue="productNameID" itemLabel="name"/>
            </form:select>
        </td>
        <td class="label-field"><fmt:message key="whm.size.name"/></td>
        <td>
            <form:select path="sizeID">
                <form:option value="-1">Tất cả</form:option>
                <form:options items="${sizes}" itemValue="sizeID" itemLabel="name"/>
            </form:select>
        </td>
    </tr>
    <tr>
        <td class="label-field"><fmt:message key="whm.thickness.name"/></td>
        <td>
            <form:select path="thicknessID">
                <form:option value="-1">Tất cả</form:option>
                <form:options items="${thicknesses}" itemValue="thicknessID" itemLabel="name"/>
            </form:select>
        </td>
        <td class="label-field"><fmt:message key="whm.stiffness.name"/></td>
        <td>
            <form:select path="stiffnessID">
                <form:option value="-1">Tất cả</form:option>
                <form:options items="${stiffnesses}" itemValue="stiffnessID" itemLabel="name"/>
            </form:select>
        </td>
    </tr>
    <tr>
        <td class="label-field"><fmt:message key="whm.colour.name"/></td>
        <td>
            <form:select path="colourID">
                <form:option value="-1">Tất cả</form:option>
                <form:options items="${colours}" itemValue="colourID" itemLabel="name"/>
            </form:select>
        </td>
        <td class="label-field"><fmt:message key="whm.overlaytype.name"/></td>
        <td>
            <form:select path="overlayTypeID">
                <form:option value="-1">Tất cả</form:option>
                <form:options items="${overlayTypes}" itemValue="overlayTypeID" itemLabel="name"/>
            </form:select>
        </td>
    </tr>
    <tr>
        <td class="label-field"><fmt:message key="whm.origin.name"/></td>
        <td>
            <form:select path="originID">
                <form:option value="-1">Tất cả</form:option>
                <form:options items="${origins}" itemValue="originID" itemLabel="name"/>
            </form:select>
        </td>
        <td class="label-field"><fmt:message key="whm.market.name"/></td>
        <td>
            <form:select path="marketID">
                <form:option value="-1">Tất cả</form:option>
                <form:options items="${markets}" itemValue="marketID" itemLabel="name"/>
            </form:select>
        </td>
    </tr>
    <tr>
        <td class="label-field"><fmt:message key="label.from.kg.m"/></td>
        <td>
            <form:input path="fromKgM" size="25" maxlength="45" id="fromKgM" onchange="checkNumber(this.value, this.id);"/>
        </td>
        <td class="label-field"><fmt:message key="label.to.kg.m"/></td>
        <td>
            <form:input path="toKgM" size="25" maxlength="45" id="toKgM" onchange="checkNumber(this.value, this.id);"/>
        </td>
    </tr>
    <tr style="text-align: center;">
        <td colspan="4">
            <a id="btnFilter" class="btn btn-primary " onclick="searchItem();"><i class="icon-refresh"></i> <fmt:message key="label.search"/> </a>
        </td>
    </tr>
</table>
<div class="clear"></div>
<c:if test="${bookBill.status == Constants.BOOK_WAIT_CONFIRM || bookBill.status == Constants.BOOK_REJECTED}">
    <div class="process-control">
        <a id="btnBook" class="btn btn-info " onclick="bookProduct();"><i class="icon-check"></i> <fmt:message key="booking.product"/> </a>
    </div>
</c:if>

<div id="tbContent" style="width:100%;max-height: 500px;">
    <table class="tableSadlier table-hover" border="1" style="border-right: 1px;margin: 12px 0 20px 0;width: 1300px;">
        <caption><fmt:message key="in.stock.product.list"/></caption>
        <tr>
            <th class="table_header text-center"><input type="checkbox" onclick="checkAllByClass('checkPrd', this);"/></th>
            <th class="table_header text-center"><fmt:message key="label.stt"/></th>
            <th class="table_header text-center"><fmt:message key="label.name"/></th>
            <th class="table_header text-center"><fmt:message key="label.code"/></th>
            <th class="table_header text-center"><fmt:message key="label.size"/></th>
            <th class="table_header text-center"><fmt:message key="label.specific"/></th>
            <th class="table_header text-center"><fmt:message key="whm.overlaytype.name"/></th>
            <th class="table_header text-center"><fmt:message key="label.kg"/></th>
            <c:forEach items="${qualities}" var="quality">
                <th class="table_header text-center">${quality.name}</th>
            </c:forEach>
            <th class="table_header text-center"><fmt:message key="label.total.m"/></th>
            <th class="table_header text-center">Kg/m</th>
            <th class="table_header text-center"><fmt:message key="main.material.note"/></th>
            <th class="table_header text-center"><fmt:message key="whm.warehouse.name"/></th>
            <th class="table_header text-center"><fmt:message key="label.produced.date"/></th>
        </tr>
        <c:forEach items="${items.listResult}" var="tableList" varStatus="status">
            <tr class="${status.index % 2 == 0 ? "even text-center" : "odd text-center"}">
                <td>
                    <input class="checkPrd" type="checkbox" name="bookedProductIDs" value="${tableList.importProductID}" id="selected-${tableList.importProductID}"/>
                    <input type="hidden" value="${tableList.warehouse.warehouseID}" id="warehouse-${tableList.importProductID}"/>
                </td>
                <td>${status.index + 1}</td>
                <td>${tableList.productname.name}</td>
                <td>${tableList.productCode}</td>
                <td>${tableList.size.name}</td>
                <td>
                    <c:choose>
                        <c:when test="${not empty tableList.colour}">
                            ${tableList.colour.name}
                        </c:when>
                        <c:when test="${not empty tableList.thickness}">
                            ${tableList.thickness.name}
                        </c:when>
                    </c:choose>
                </td>
                <td>${tableList.overlaytype.name}</td>
                <td><fmt:formatNumber value="${tableList.quantity2Pure}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/></td>
                <c:forEach items="${qualities}" var="quality">
                    <td>
                        <c:forEach items="${tableList.productqualitys}" var="productQuality">
                            <c:if test="${productQuality.quality.qualityID == quality.qualityID}">
                                <fmt:formatNumber value="${productQuality.quantity1}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/>
                            </c:if>
                        </c:forEach>
                    </td>
                </c:forEach>
                <td><fmt:formatNumber value="${tableList.quantity1}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/></td>
                <td><fmt:formatNumber value="${tableList.quantity2Pure / tableList.quantity1}" pattern="###,###.##" maxFractionDigits="2" minFractionDigits="0"/></td>
                <td style="text-align: left">
                    ${tableList.note}
                </td>
                <td>${tableList.warehouse.name}</td>
                <td>
                    <c:choose>
                        <c:when test="${not empty tableList.importDate}">
                            <fmt:formatDate value="${tableList.importDate}" pattern="dd/MM/yyyy"/>
                        </c:when>
                        <c:when test="${not empty tableList.produceDate}">
                            <fmt:formatDate value="${tableList.produceDate}" pattern="dd/MM/yyyy"/>
                        </c:when>
                        <c:otherwise>-</c:otherwise>
                    </c:choose>
                </td>

            </tr>
        </c:forEach>
    </table>
    <display:table name="items.listResult" cellspacing="0" cellpadding="0" requestURI="${formlUrl}"
                   partialList="true" sort="external" size="${items.totalItems }"
                   uid="tableList" excludedParams="crudaction" style="display: none;"
                   pagesize="${items.maxPageItems}" export="false" class="tableSadlier table-hover">
        <display:setProperty name="paging.banner.item_name" value="cuộn tôn"/>
        <display:setProperty name="paging.banner.items_name" value="cuộn tôn"/>
        <display:setProperty name="paging.banner.placement" value="bottom"/>
        <display:setProperty name="paging.banner.no_items_found" value=""/>
    </display:table>
</div>
    <div id="tableFooter"></div>
<form:hidden path="crudaction" id="crudaction"/>
<form:hidden path="bookProductBillID"/>
</form:form>
</div>
</div>
<script src="<c:url value="/themes/whm/scripts/bootstrap/jscrollpane.js"/>"></script>
<script type="text/javascript">
    var warehouseId = ${selectedWarehouse};
    $(document).ready(function(){
        var deliveryDateVar = $("#deliveryDate").datepicker({
            format: 'dd/mm/yyyy',
            onRender: function(date){
            }}).on('changeDate', function(ev) {
                    deliveryDateVar.hide();
                }).data('datepicker');
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
        $('#deliveryDateIcon').click(function() {
            $('#deliveryDate').focus();
            return true;
        });
        $('#effectiveFromDateIcon').click(function() {
            $('#effectiveFromDate').focus();
            return true;
        });
        $('#effectiveToDateIcon').click(function() {
            $('#effectiveToDate').focus();
            return true;
        });

        $('.pagebanner').appendTo($('#tableFooter'));
        $('.pagelinks').appendTo($('#tableFooter'));

        $("#btnFilter").click(function(){
            $("#crudaction").val("search");
            $("#itemForm").submit();
        });



        $('#tbBookedContent').jScrollPane();
        $('#tbContent').jScrollPane();


    });
    function searchItem(){
        $("#crudaction").val("search");
        submitForm('itemForm');

    }
    function bookProduct(){
        var prdId,
                hasPrd = false,
                sameWarehouse = true;
        $(".checkPrd:checkbox:checked").each(function(){
            hasPrd = true;
            prdId = $(this).val();
            if(warehouseId == undefined || warehouseId == "-1"){
                warehouseId = $('#warehouse-' + prdId).val();
            }else if(warehouseId != undefined && warehouseId != "-1" && warehouseId != $('#warehouse-' + prdId).val()){
                sameWarehouse = false;
            }
        });
        if(hasPrd && sameWarehouse){
            $("#crudaction").val("booking");
            submitForm('itemForm');
        }else if(!hasPrd){
            bootbox.alert("<fmt:message key="label.title.confirm"/>", "<fmt:message key="message.chooseAtLeastOne"/>");
        }else if(!sameWarehouse){
            bootbox.alert("<fmt:message key="label.title.confirm"/>", "<fmt:message key="message.not.same.warehouse"/>");
        }
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

    function removeProduct(Ele,bookProductID,billId){
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
                                        window.location.href = "<c:url value='/whm/instock/booking.html?bookProductBillID='/>" + billId;
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
    function goSetPrice(billId){
        window.location.href = "<c:url value='/whm/booking/addPrice.html?pojo.bookProductBillID='/>" + billId;
    }
    function goEditInfo(billId){
        window.location.href = "<c:url value='/whm/booking/editinfo.html?pojo.bookProductBillID='/>" + billId;
    }
</script>
</body>
</html>