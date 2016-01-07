function calTotalPlanAndDuPhong() {
    // calculate total duphong and total plan value
    var totalPlanValue = 0;
    var totalDuPhongValue = 0;
    $('.planValue,.duPhongValue').each(function(){
        if($.trim($(this).text()) == '') {
            return;
        }
        var id = $(this).attr('id');
        var idSplitted = id.split("_");
        var cateId = idSplitted[1];
        var expenseIdLevel_1 = null;
        var expenseIdLevel_2 = null;
        if(idSplitted.length > 3) {
            expenseIdLevel_1 =  idSplitted[2];
            if(idSplitted.length > 4) {
                expenseIdLevel_2 =  idSplitted[3];
            }
        }
        var thisValue = numeral().unformat($.trim($(this).text()));

        var sumCate = 0;
        if($(this).hasClass('planValue')) {
            totalPlanValue += thisValue;
            if($.trim($('#cate_dk_' + cateId).text()) != '') {
                sumCate = numeral().unformat($.trim($('#cate_dk_' + cateId).text()));
            }
            $('#cate_dk_' + cateId).text(numeral(sumCate + thisValue).format('0,0.0'));
        }else {
            totalDuPhongValue  += thisValue;
            if($.trim($('#cate_dp_' + cateId).text()) != '') {
                sumCate = numeral().unformat($.trim($('#cate_dp_' + cateId).text()));
            }
            $('#cate_dp_' + cateId).text(numeral(sumCate + thisValue).format('0,0.0'));
        }

        if(expenseIdLevel_1 != null && expenseIdLevel_1 != '') {
            var sumL1 = 0;
            if($(this).hasClass('planValue')) {
                if($.trim($('#expenseDK_' + cateId + "_" + expenseIdLevel_1).text()) != '') {
                    sumL1 = numeral().unformat($.trim($('#expenseDK_' + cateId + "_" + expenseIdLevel_1).text()));
                }
                $('#expenseDK_' + cateId + "_" + expenseIdLevel_1).text(numeral(sumL1 + thisValue).format('0,0.0'));
            }else {
                if($.trim($('#expenseDP_' + cateId + "_" + expenseIdLevel_1).text()) != '') {
                    sumL1 = numeral().unformat($.trim($('#expenseDP_' + cateId + "_" + expenseIdLevel_1).text()));
                }
                $('#expenseDP_' + cateId + "_" + expenseIdLevel_1).text(numeral(sumL1 + thisValue).format('0,0.0'));
            }

            if(expenseIdLevel_2 != null && expenseIdLevel_2 != '') {
                var sumL2 = 0;
                if($(this).hasClass('planValue')) {
                    if($.trim($('#expenseDK_' + cateId + "_" + expenseIdLevel_1 + "_" + expenseIdLevel_2).text()) != '') {
                        sumL2 = numeral().unformat($.trim($('#expenseDK_' + cateId + "_" + expenseIdLevel_1 + "_" + expenseIdLevel_2).text()));
                    }
                    $('#expenseDK_' + cateId + "_" + expenseIdLevel_1 + "_" + expenseIdLevel_2).text(numeral(sumL2 + thisValue).format('0,0.0'));
                }else {
                    if($.trim($('#expenseDP_' + cateId + "_" + expenseIdLevel_1 + "_" + expenseIdLevel_2).text()) != '') {
                        sumL2 = numeral().unformat($.trim($('#expenseDP_' + cateId + "_" + expenseIdLevel_1 + "_"  + expenseIdLevel_2).text()));
                    }
                    $('#expenseDP_' + cateId + "_" + expenseIdLevel_1 + "_"  + expenseIdLevel_2).text(numeral(sumL2 + thisValue).format('0,0.0'));
                }
            }
        }
    });
    $('#totalPlanValue').html(numeral(totalPlanValue).format('0,0.0'));
    $('#totalDuPhongValue').html(numeral(totalDuPhongValue).format('0,0.0'));
}
function calTotalRegisterValue(element) {
    if(element == undefined) {
        element = 'input';
    }
    var totalValue = 0;
    $('.registerValue').each(function(){
        var temp = '';
        if(element == 'input') {
           temp = $.trim($(this).val());
        }else {
            temp = $.trim($(this).text());
        }
        if(temp != '') {
            totalValue += numeral().unformat(temp);
        }
    });
    $('#totalRegisterValue').text(numeral(totalValue).format('0,0.0'));
}

function calTotalApprovedValue(element) {
    if(element == undefined) {
        element = 'input';
    }
    var totalValue = 0;
    $('.approvalValue').each(function(){
        var temp = '';
        if(element == 'input') {
            temp = $.trim($(this).val());
        }else {
            temp = $.trim($(this).text());
        }
        if(temp != '') {
            totalValue += numeral().unformat(temp);
        }
    });
    $('#approvalTotal').text(numeral(totalValue).format('0,0.0'));
}

function calParentTotalValues(element) {
    if(element == undefined) {
        element = 'input';
    }
    $(element + '[id^="expenseValue_"]').each(function(){
        var temp = '';
        if(element == 'input') {
            temp = $(this).val();
        }else {
            temp = $(this).text();
        }
        if($.trim(temp) == '') {
            return;
        }
        var id = $(this).attr('id');
        var idSplitted = id.split("_");
        var cateId = idSplitted[1];
        var expenseIdLevel_1 = null;
        var expenseIdLevel_2 = null;
        if(idSplitted.length > 3) {
            expenseIdLevel_1 =  idSplitted[2];
            if(idSplitted.length > 4) {
                expenseIdLevel_2 =  idSplitted[3];
            }
        }
        var thisValue = numeral().unformat($.trim(temp));

        var sumCate = 0;
        if($.trim($('#cate_value_' + cateId).text()) != '') {
            sumCate = numeral().unformat($.trim($('#cate_value_' + cateId).text()));
        }
        $('#cate_value_' + cateId).text(numeral(sumCate + thisValue).format('0,0.0'));

        if(expenseIdLevel_1 != null && expenseIdLevel_1 != '') {
            var sumL1 = 0;
            if($.trim($('#td_expenseValue_' + expenseIdLevel_1).text()) != '') {
                sumL1 = numeral().unformat($.trim($('#td_expenseValue_' + expenseIdLevel_1).text()));
            }
            $('#td_expenseValue_' + expenseIdLevel_1).text(numeral(sumL1 + thisValue).format('0,0.0'));
            var sumL2 = 0;
            if(expenseIdLevel_2 != null && expenseIdLevel_2 != '') {
                if($.trim($('#td_expenseValue_' + expenseIdLevel_2).text()) != '') {
                    sumL2 = numeral().unformat($.trim($('#td_expenseValue_' + expenseIdLevel_2).text()));
                }
                $('#td_expenseValue_' + expenseIdLevel_2).text(numeral(sumL2 + thisValue).format('0,0.0'));
            }
        }
    });
}
function calParentTotalApproval(element) {
    if(element == undefined) {
        element = 'input';
    }
    $(element + '[id^="expenseApproval_"]').each(function(){
        var temp = '';
        if(element == 'input') {
            temp = $(this).val();
        }else {
            temp = $(this).text();
        }
        if($.trim(temp) == '') {
            return;
        }
        var id = $(this).attr('id');
        var idSplitted = id.split("_");
        var cateId = idSplitted[1];
        var expenseIdLevel_1 = null;
        var expenseIdLevel_2 = null;
        if(idSplitted.length > 3) {
            expenseIdLevel_1 =  idSplitted[2];
            if(idSplitted.length > 4) {
                expenseIdLevel_2 =  idSplitted[3];
            }
        }
        var thisValue = numeral().unformat($.trim(temp));

        var sumCate = 0;
        if($.trim($('#cate_approval_' + cateId).text()) != '') {
            sumCate = numeral().unformat($.trim($('#cate_approval_' + cateId).text()));
        }
        $('#cate_approval_' + cateId).text(numeral(sumCate + thisValue).format('0,0.0'));

        if(expenseIdLevel_1 != null && expenseIdLevel_1 != '') {
            var sumL1 = 0;
            if($.trim($('#td_expenseApproval_' + expenseIdLevel_1).text()) != '') {
                sumL1 = numeral().unformat($.trim($('#td_expenseApproval_' + expenseIdLevel_1).text()));
            }
            $('#td_expenseApproval_' + expenseIdLevel_1).text(numeral(sumL1 + thisValue).format('0,0.0'));
            var sumL2 = 0;
            if(expenseIdLevel_2 != null && expenseIdLevel_2 != '') {
                if($.trim($('#td_expenseApproval_' + expenseIdLevel_2).text()) != '') {
                    sumL2 = numeral().unformat($.trim($('#td_expenseApproval_' + expenseIdLevel_2).text()));
                }
                $('#td_expenseApproval_' + expenseIdLevel_2).text(numeral(sumL2 + thisValue).format('0,0.0'));
            }
        }
    });
}
var valPrefix = 'Value';
function changeRegisterValue(input, cateId, expenseIdLevel_1, expenseIdLevel_2) {
    var value = $.trim($(input).val());
    if(value != '') {
//        $(input).val(numeral(value).format('0,0.0'));
    }else {
        return;
    }
    var valueFloat = numeral().unformat(value);
    var oldValue = 0;
    if(input.oldValue != null && input.oldValue != '') {
        oldValue = numeral().unformat($.trim(input.oldValue));
    }
    var sumCate = 0;
    var cateSuffix = (valPrefix == 'Value'? 'value' : 'approval');
    if($.trim($('#cate_' + cateSuffix + '_' + cateId).html()) != '') {
        sumCate = numeral().unformat($.trim($('#cate_'+ cateSuffix + '_' + cateId).html()));
    }
    $('#cate_' + cateSuffix + '_' + cateId).html(numeral((sumCate - oldValue) + valueFloat).format('0,0.0'));
    if(expenseIdLevel_1 != undefined && expenseIdLevel_1 != '') {
        var sumL1 = 0;
        if($.trim($('#td_expense' + valPrefix + '_' + expenseIdLevel_1).html()) != '') {
            sumL1 = numeral().unformat($.trim($('#td_expense' + valPrefix + '_' + expenseIdLevel_1).html()));
        }
        $('#td_expense' + valPrefix + '_' + expenseIdLevel_1).html(numeral((sumL1 - oldValue) + valueFloat).format('0,0.0'));

        if(expenseIdLevel_2 != undefined && expenseIdLevel_2 != '') {
            var sumL2 = 0;
            if($.trim($('#td_expense' + valPrefix + '_' + expenseIdLevel_2).html()) != '') {
                sumL2 = numeral().unformat($($.trim('#td_expense' + valPrefix + '_' + expenseIdLevel_2).html()));
            }
            $('#td_expense' + valPrefix + '_' + expenseIdLevel_2).html(numeral((sumL2 - oldValue) + valueFloat).format('0,0.0'));
        }
    }
    if(valPrefix == 'Value') {
        calTotalRegisterValue();
    }else {
        calTotalApprovedValue();
    }
}

function changeApprovalValue(input, cateId, expenseIdLevel_1, expenseIdLevel_2) {
    valPrefix = 'Approval';
   changeRegisterValue(input, cateId, expenseIdLevel_1, expenseIdLevel_2);
   valPrefix = 'Value';
}

function calParentTotal4YearApprovalValues() {
    var total = 0;
    $('span' + '[id^="year_approval_value_"]').each(function(){
        var temp = $.trim($(this).text());
        if(temp == '') {
            return;
        }
        var id = $(this).attr('id');
        var idSplitted = id.split("_");
        var cateId = idSplitted[3];
        var expenseIdLevel_1 = null;
        var expenseIdLevel_2 = null;
        if(idSplitted.length > 4) {
            expenseIdLevel_1 =  idSplitted[4];
            if(idSplitted.length > 6) {
                expenseIdLevel_2 =  idSplitted[5];
            }
        }
        var thisValue = parseFloat(temp);
        total += thisValue;

        var sumCate = 0;
        if($.trim($('#cate_year_approval_value_' + cateId).text()) != '') {
            sumCate = numeral().unformat($.trim($('#cate_year_approval_value_' + cateId).text()));
        }
        $('#cate_year_approval_value_' + cateId).text(numeral(sumCate + thisValue).format('0,0.0'));

        if(expenseIdLevel_1 != null && expenseIdLevel_1 != '') {
            var sumL1 = 0;
            if($.trim($('#td_year_approval_value_' + expenseIdLevel_1).text()) != '') {
                sumL1 = numeral().unformat($.trim($('#td_year_approval_value_' + expenseIdLevel_1).text()));
            }
            $('#td_year_approval_value_' + expenseIdLevel_1).text(numeral(sumL1 + thisValue).format('0,0.0'));
            var sumL2 = 0;
            if(expenseIdLevel_2 != null && expenseIdLevel_2 != '') {
                if($.trim($('#td_year_approval_value_' + expenseIdLevel_2).text()) != '') {
                    sumL2 = numeral().unformat($.trim($('#td_year_approval_value_' + expenseIdLevel_2).text()));
                }
                $('#td_year_approval_value_' + expenseIdLevel_2).text(numeral(sumL2 + thisValue).format('0,0.0'));
            }
        }
        $(this).text(numeral(thisValue).format('0,0.0'));
    });
    $('#totalYearApprovalValue').text(numeral(total).format('0,0.0'));
}
function calParentTotal4YearRemainValues() {
    var total = 0;
    $('span' + '[id^="year_remain_value_"]').each(function(){
        var temp = $.trim($(this).text());
        if(temp == '') {
            return;
        }
        var id = $(this).attr('id');
        var idSplitted = id.split("_");
        var cateId = idSplitted[3];
        var expenseIdLevel_1 = null;
        var expenseIdLevel_2 = null;
        if(idSplitted.length > 4) {
            expenseIdLevel_1 =  idSplitted[4];
            if(idSplitted.length > 6) {
                expenseIdLevel_2 =  idSplitted[5];
            }
        }
        var thisValue = parseFloat(temp);
        total += thisValue;

        var sumCate = 0;
        if($.trim($('#cate_year_remain_value_' + cateId).text()) != '') {
            sumCate = numeral().unformat($.trim($('#cate_year_remain_value_' + cateId).text()));
        }
        $('#cate_year_remain_value_' + cateId).text(numeral(sumCate + thisValue).format('0,0.0'));

        if(expenseIdLevel_1 != null && expenseIdLevel_1 != '') {
            var sumL1 = 0;
            if($.trim($('#td_year_remain_value_' + expenseIdLevel_1).text()) != '') {
                sumL1 = numeral().unformat($.trim($('#td_year_remain_value_' + expenseIdLevel_1).text()));
            }
            $('#td_year_remain_value_' + expenseIdLevel_1).text(numeral(sumL1 + thisValue).format('0,0.0'));
            var sumL2 = 0;
            if(expenseIdLevel_2 != null && expenseIdLevel_2 != '') {
                if($.trim($('#td_year_remain_value_' + expenseIdLevel_2).text()) != '') {
                    sumL2 = numeral().unformat($.trim($('#td_year_remain_value_' + expenseIdLevel_2).text()));
                }
                $('#td_year_remain_value_' + expenseIdLevel_2).text(numeral(sumL2 + thisValue).format('0,0.0'));
            }
        }
        $(this).text(numeral(thisValue).format('0,0.0'));
    });
    $('#totalYearRemainValue').text(numeral(total).format('0,0.0'));
}
