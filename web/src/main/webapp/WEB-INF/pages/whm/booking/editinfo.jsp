<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<head>
    <title><fmt:message key="book.info.title"/></title>
    <meta name="heading" content="<fmt:message key="book.info.title"/>"/>
    <style>
        .form-horizontal .control-label{
            width: 250px;
        }
        .form-horizontal .controls {
            margin-left: 260px;
        }
        .datePicker{
            width: 90px;
        }
        caption{
            text-align: left;
        }
    </style>
</head>

<c:url var="url" value="/whm/booking/editinfo.html"/>
<c:url var="backUrl" value="/whm/booking/list.html"/>
<form:form commandName="item" action="${url}" method="post" id="itemForm" class="form-horizontal" novalidate="novalidate">
    <div id="container-fluid data_content_box">
        <div class="row-fluid data_content">
            <div class="content-header"><fmt:message key="book.info.title"/></div>
            <div class="clear"></div>
            <div class="row-fluid">
                <div class="pane_info">
                    <div class="pane_title"><fmt:message key="book.info.title"/></div>
                    <div class="pane_content">
                        <div class="control-group">
                            <label class="control-label"><fmt:message key="label.customer"/></label>
                            <div class="controls">
                                <form:select path="pojo.customer.customerID" cssClass="required" id="sl_customer" cssStyle="width: 360px;" onchange="verifyLiability();">
                                    <form:option value="-1"><fmt:message key="label.select"/></form:option>
                                    <c:forEach items="${customers}" var="customer">
                                        <form:option value="${customer.customerID}">${customer.name}-${customer.province.name}</form:option>
                                    </c:forEach>
                                </form:select>
                            </div>
                            <label class="control-label">Ngày lập phiếu</label>
                            <div class="controls">
                                <fmt:formatDate var="billDate" value="${item.pojo.billDate}" pattern="dd/MM/yyyy"/>
                                <input name="pojo.billDate" id="billDate" class="prevent_type text-center width2 required" value="${billDate}" type="text"/>
                            </div>
                            <label class="control-label">Ngày giao</label>
                            <div class="controls">
                                <fmt:formatDate var="ngayKeKhaiTo" value="${item.pojo.deliveryDate}" pattern="dd/MM/yyyy"/>
                                <input name="pojo.deliveryDate" id="effectiveToDate" class="prevent_type text-center width2 required" value="${ngayKeKhaiTo}" type="text"/>
                            </div>
                            <label class="control-label" style="display: none" id="owe-info"><fmt:message key="whm.owe.util.bill.date"/></label>
                            <div class="controls text-inline" id="owe" style="display: none; font-weight: bold"></div>
                        </div>
                    </div>
                </div>

                <table class="tableSadlier table-hover">
                    <caption><fmt:message key="money.reduce.if.any"/></caption>
                    <tr>
                        <th class="table_header_center" style="width: 50%;">Lý do khấu trừ</th>
                        <th class="table_header_center" style="width: 20%;">Ngày</th>
                        <th class="table_header_center" style="width: 30%;">Số tiền</th>
                    </tr>
                    <c:forEach items="${saleReasons}" var="reason" varStatus="status">
                        <tr>
                            <td>${reason.reason}</td>
                            <td><input class="datePicker prevent_type" type="text" value="<fmt:formatDate value="${mapReasonDate[reason.saleReasonID]}" pattern="dd/MM/yyyy"/>" name="mapReasonDate[${reason.saleReasonID}]"/></td>
                            <td><input class="inputNumber" type="text" value="<fmt:formatNumber value="${mapReasonMoney[reason.saleReasonID]}" pattern="###,###"/>" name="mapReasonMoney[${reason.saleReasonID}]"/></td>
                        </tr>
                    </c:forEach>
                </table>

                <table class="tableSadlier table-hover">
                    <caption><fmt:message key="money.paid.if.any"/></caption>
                    <tr>
                        <th class="table_header_center" style="width: 50%;">Phương thức thanh toán</th>
                        <th class="table_header_center" style="width: 20%;">Ngày thanh toán</th>
                        <th class="table_header_center" style="width: 30%;">Số tiền</th>
                    </tr>
                    <c:if test="${empty item.pojo.prePaids}">
                        <c:forEach begin="0" end="2" step="1" var="counter" varStatus="status">
                            <tr class="pre-paid-box">
                                <td><input type="text" name="prePaids[${status.index}].note" class="span11"/></td>
                                <td><input class="datePicker prevent_type" type="text" name="prePaids[${status.index}].payDate"/></td>
                                <td><input class="inputNumber" type="text" name="prePaids[${status.index}].pay"/></td>
                            </tr>
                        </c:forEach>
                    </c:if>
                    <c:if test="${!empty item.pojo.prePaids}">
                        <c:forEach items="${item.pojo.prePaids}" var="prePaid" varStatus="status">
                            <tr class="pre-paid-box-old">
                                <td><input type="text" value="${prePaid.note}" name="prePaids[${status.index}].note" class="span11"/></td>
                                <td><input class="datePicker prevent_type" type="text" value="<fmt:formatDate value="${prePaid.payDate}" pattern="dd/MM/yyyy"/>" name="prePaids[${status.index}].payDate"/></td>
                                <td><input class="inputNumber" type="text" value="<fmt:formatNumber value="${prePaid.pay}" pattern="###,###"/>" name="prePaids[${status.index}].pay"/></td>
                            </tr>
                        </c:forEach>
                        <c:set var="noPaid" value="${fn:length(item.pojo.prePaids)}"/>
                        <c:if test="${noPaid < 3}">
                            <c:forEach begin="0" end="${3 - 1 - noPaid}" step="1" var="counter" varStatus="status">
                                <tr class="pre-paid-box">
                                    <td><input type="text" name="prePaids[${noPaid + status.index}].note" class="span11"/></td>
                                    <td><input class="datePicker prevent_type" type="text" name="prePaids[${noPaid + status.index}].payDate"/></td>
                                    <td><input class="inputNumber" type="text" name="prePaids[${noPaid + status.index}].pay"/></td>
                                </tr>
                            </c:forEach>
                        </c:if>
                    </c:if>
                </table>

                <div class="controls">
                    <c:if test="${empty item.pojo.bookProductBillID || item.pojo.status == Constants.BOOK_WAIT_CONFIRM || item.pojo.status == Constants.BOOK_REJECTED}">
                        <a onclick="saveOnly();" class="btn btn-success btn-green" style="cursor: pointer;">
                            <fmt:message key="button.save"/>
                        </a>
                        <a onclick="saveThenBook();" class="btn btn-success btn-green" style="cursor: pointer;width: auto">
                            <fmt:message key="button.save.book"/>
                        </a>
                    </c:if>
                    <div style="display: inline">

                        <a href="${backUrl}" class="cancel-link">
                            <fmt:message key="button.cancel"/>
                        </a>
                    </div>
                </div>

            </div>
        </div>
    </div>
    <form:hidden path="crudaction" id="crudaction"/>
    <form:hidden path="pojo.bookProductBillID"/>
</form:form>
<script>
    $(document).ready(function(){
        var billDateVar = $("#billDate").datepicker({
            format: 'dd/mm/yyyy',
            onRender: function(date){
            }}).on('changeDate', function(ev) {
                    billDateVar.hide();
                    verifyLiability();
                }).data('datepicker');
        $('#billDateIcon').click(function() {
            $('#billDate').focus();
            return true;
        });

        var effectiveToDateVar = $("#effectiveToDate").datepicker({
            format: 'dd/mm/yyyy',
            onRender: function(date){
            }}).on('changeDate', function(ev) {
                    effectiveToDateVar.hide();
                }).data('datepicker');
        $('#effectiveToDateIcon').click(function() {
            $('#effectiveToDate').focus();
            return true;
        });

        $(".datePicker").each(function(){
            var $this = $(this).datepicker({
                format: 'dd/mm/yyyy',
                autoclose: true
            }).on('changeDate', function(ev) {
                        $this.hide();
                    }).data('datepicker');
        });
    });
    function saveOnly(){
        $('.inputNumber').each(function(){
            if($(this).val() != '' && $(this).val() != 0 ) {
                $(this).val(numeral().unformat($(this).val()));
            }
        });
        $('#crudaction').val("insert-update");
        $('#itemForm').submit();
    }
    function saveThenBook(){
        $('.inputNumber').each(function(){
            if($(this).val() != '' && $(this).val() != 0 ) {
                $(this).val(numeral().unformat($(this).val()));
            }
        });
        $('#crudaction').val("save-then-book");
        $('#itemForm').submit();
    }

    function verifyLiability(){
        var customerID = $('#sl_customer option:selected').val();
        var date = $('#billDate').val();
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
                        showLiability(customerID, date);
                    }
                }
            });
        }
    }

    function showLiability(customerID, date){
        var owe;
        var url = '<c:url value="/ajax/customer/showLiability.html"/>?customerID=' + customerID  + '&date=' + date + '&bookProductBillID=' + '${item.pojo.bookProductBillID}';
        $.getJSON(url, function(data) {
            if (data.owe != null){
                owe = data.owe;
                $('#owe-info').show();
                $('#owe').html(numeral(owe).format('###,###'));
                $('#owe').show();
            }
        });
    }
    function hideOwe(){
        $('#owe-info').hide();
        $('#owe').html("");
        $('#owe').hide();
    }
</script>
