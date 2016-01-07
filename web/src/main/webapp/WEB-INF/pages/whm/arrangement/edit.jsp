<%@ taglib prefix="input" uri="http://www.springframework.org/tags/form" %>
<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<head>
    <title><fmt:message key="whm.arrangement.title"/></title>
    <meta name="heading" content="<fmt:message key="whm.arrangement.title"/>"/>
    <style>
        .black-info,.expense-info {
            float: left;
            width: 65%;
        }
    </style>
</head>

<c:url var="url" value="/whm/arrangement/edit.html"/>
<c:url var="backUrl" value="/whm/arrangement/list.html"/>
<form:form commandName="item" action="${url}" method="post" id="itemForm" class="form-horizontal" novalidate="novalidate">
    <div id="container-fluid data_content_box">
        <div class="row-fluid data_content">
            <div class="content-header"><fmt:message key="whm.importproduct.material.declare"/></div>
            <div class="clear"></div>
            <div class="guideline">
                <span>(<span class="required">*</span>): là bắt buộc.</span>
                <div style="clear:both"></div>
            </div>
            <div class="alert alert-error" style="display: none;">
                <a onclick="closeAlert();" href="#" style="float: right;font-size: larger;color: #C5B0C2;">&times;</a>
                Hãy nhập đủ thông tin bắt buộc trước khi lưu.
            </div>

            <div class="date-info">
                <table class="tbHskt info">
                    <caption><fmt:message key="fee.arrangement.date"/></caption>
                    <tr>
                        <td><fmt:message key="from.date"/><span id="rq_fromDate" class="required">*</span></td>
                        <td colspan="2">
                            <div class="input-append date" >
                                <fmt:formatDate var="fromDate" value="${item.pojo.fromDate}" pattern="dd/MM/yyyy"/>
                                <input name="pojo.fromDate" id="fromDate" class="prevent_type text-center width2" value="${fromDate}" type="text" />
                                <span class="add-on" id="fromDateIcon"><i class="icon-calendar"></i></span>
                            </div>
                        </td>
                        <td><fmt:message key="to.date"/><span id="rq_toDate" class="required">*</span></td>
                        <td colspan="2">
                            <div class="input-append date" >
                                <fmt:formatDate var="toDate" value="${item.pojo.toDate}" pattern="dd/MM/yyyy"/>
                                <input name="pojo.toDate" id="toDate" class="prevent_type text-center width2" value="${toDate}" type="text" />
                                <span class="add-on" id="toDateIcon"><i class="icon-calendar"></i></span>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="6" style="text-align: center">
                            <a class="btn btn-info " onclick="getBlackInfo();"><i class="icon-arrow-down"></i> <fmt:message key="arrangement.get.black.info"/> </a>
                        </td>
                    </tr>
                </table>
            </div>

            <div class="black-info">
                <table class="tbHskt info">
                    <caption><fmt:message key="arrangement.black.info"/></caption>
                    <tr>
                        <td style="width: 60%;text-align: right"><fmt:message key="arrangement.total.black"/></td>
                        <td>
                            <input type="hidden" name="pojo.totalBlack" value="${item.pojo.totalBlack}" id="input-black"/>
                            <span id="blackInfo" style="font-weight: bold"><fmt:formatNumber value="${item.pojo.totalBlack}" pattern="###,###.###"/> </span>
                            <span style="font-weight: bold">Tấn</span>
                        </td>
                    </tr>
                </table>
            </div>

            <div class="expense-info">
                <table class="tbHskt info">
                    <caption><fmt:message key="arrangement.expense.info"/></caption>
                    <c:forEach items="${fixExpenses}" var="fixExpense" varStatus="status">
                        <tr class="${status.index % 2 == 0 ? "even" : "odd"}">
                            <td style="width: 60%;text-align: right">${fixExpense.name}</td>
                            <td>
                                <input type="hidden" name="arrangementDetails[${status.index}].fixExpense.fixExpenseID" value="${fixExpense.fixExpenseID}"/>
                                <input onkeyup="calAverageFee();" type="text" class="inputFractionNumber" value="<fmt:formatNumber value="${mapExpenseValue[fixExpense.fixExpenseID]}" pattern="###,###.##"/>" name="arrangementDetails[${status.index}].value"/>
                            </td>
                        </tr>
                    </c:forEach>
                    <tr class="${status.index % 2 == 0 ? "even" : "odd"}">
                        <td style="width: 60%;text-align: right;font-weight: bold;">Phân bổ trung bình</td>
                        <td>
                            <span id="averageFee" style="font-weight: bold;"><fmt:formatNumber value="${item.pojo.average}" pattern="###,###.###"/></span>
                            <input type="hidden" name="pojo.average" value="${item.pojo.average}" id="input-average"/>
                            <span style="font-weight: bold">VNĐ/Tấn</span>
                        </td>
                    </tr>
                </table>
            </div>

            <div class="controls" style="text-align: right;margin-right: 75px;">
                <a onclick="saveArrangement();" class="btn btn-success btn-green" style="cursor: pointer;">
                    <fmt:message key="button.save"/>
                </a>
                <div style="display: inline">
                    <form:hidden path="crudaction" id="crudaction" value="insert-update"/>
                    <form:hidden path="pojo.arrangementID"/>
                    <a href="${backUrl}" class="cancel-link">
                        <fmt:message key="button.cancel"/>
                    </a>
                </div>
            </div>

        </div>
    </div>
</form:form>
<script>
    $(document).ready(function(){
        var toDateVar = $("#toDate").datepicker({
            format: 'dd/mm/yyyy',
            onRender: function(date){
            }}).on('changeDate', function(ev) {
                    toDateVar.hide();
                }).data('datepicker');
        $('#toDateIcon').click(function() {
            $('#toDate').focus();
            return true;
        });

        var fromDateVar = $("#fromDate").datepicker({
            format: 'dd/mm/yyyy',
            onRender: function(date){
            }}).on('changeDate', function(ev) {
                    fromDateVar.hide();
                }).data('datepicker');
        $('#fromDateIcon').click(function() {
            $('#fromDate').focus();
            return true;
        });
    });

    function getBlackInfo(){
        if($('#fromDate').val() != '' && $('#toDate').val() != ''){
            $.ajax({
                url : '/ajax/arrangement/getblackinfo.html',
                dataType: "json",
                data : "fromDate=" + $('#fromDate').val() + "&toDate=" + $('#toDate').val(),
                type : "GET",
                success : function(res){
                    if (null != res.totalBlack){
                        $('#blackInfo').text(numeral(res.totalBlack).format('###,###.###'));
                        $('#input-black').val(res.totalBlack);
                    }else{
                        $('#blackInfo').text('0');
                        $('#input-black').val(0);
                    }
                    calAverageFee();
                }
            });
        }else{
            bootbox.alert("<fmt:message key="label.title.confirm"/>", "<fmt:message key="label.arragement.get.black.message.detail"/>",function(){
                $('body').modalmanager('loading');
                $('#fromDate').focus;
            });
        }
    }

    function calAverageFee(){
        if($('#blackInfo').text() != '' && $('#blackInfo').text() != '0'){
            var black = numeral().unformat($('#blackInfo').text());
            var totalFee = 0;
            $('.inputFractionNumber').each(function(){
                var fee = $(this).val() != '' ? numeral().unformat($(this).val()) : 0;
                totalFee += fee;
            });
            var averageFee = totalFee / black;
            $('#averageFee').text(numeral(averageFee).format('###,###.####'));
            $('#input-average').val(averageFee);

        }
    }
    function saveArrangement(){
        $('.inputFractionNumber').each(function(){
            if($(this).val() != ''){
                $(this).val(numeral().unformat($(this).val()));
            }
        });
        $('#itemForm').submit();
    }
</script>
