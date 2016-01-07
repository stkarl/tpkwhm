/**
 * Created with IntelliJ IDEA.
 * User: Chu Quoc Khanh
 * Date: 20/09/2013
 * Time: 08:44
 * To change this template use File | Settings | File Templates.
 */

var kpiAtt = 'attrition';
var kpiNoSM = '# NVBH'
var catSOV = 'Sales Out Volume';
var d = new Date();
var year = d.getFullYear();
var month = d.getMonth() + 1;
function setRollingWhileChangeYearTarget(kpiId, kpiName, thresholeRate){

    var v = $('#'+kpiId+'_thisYear_target > input').val();
    var value = (v != null && v != '') ? parseFloat(numeral().unformat(v)) : 0;

//        in case kpi is #NVBH then calculate for kpi % attrition rate
    if(kpiName == kpiNoSM){
        var result = 0;
        var threshole = parseFloat(thresholeRate);
        result = parseFloat( value * threshole / 100).toFixed(2);
        $('#'+ kpiAtt+'_thisYear_target > input').val(numeral(result).format('0,0'));
        $('#'+ kpiAtt+'_thisYear_targetRolling > input').val(numeral(result).format('0,0'));
        //             set value for review
        $('#review_'+ kpiAtt+'_thisYear_target').html(numeral(result).format('0,0'));
        $('#review_'+ kpiAtt+'_thisYear_targetRolling').html(numeral(result).format('0,0'));
    }
//        set target rolling  = target by default
    $('#'+ kpiId+'_thisYear_targetRolling > input').val(numeral(value).format('0,0'));
//             set value for review
    $('#review_'+ kpiId+'_thisYear_target').html(numeral(value).format('0,0'));
    $('#review_'+ kpiId+'_thisYear_targetRolling').html(numeral(value).format('0,0'));

}


function setReviewWhileChangeInput(kpiId,col,fieldType){

    var v = $('#'+kpiId+'_'+ col +'_'+ fieldType +' > input').val();
    var value = (v != null && v != '') ? parseFloat(numeral().unformat(v)) : 0;

//             set value for review
    $('#review_'+ kpiId+'_'+ col +'_'+ fieldType).html(numeral(value).format('0,0'));
}

function evaluateValue4CaseSum(y,kpiId, m, fieldType){

//    <%--set target rolling = target by default--%>
    if(fieldType == 'target'){
        var value = $('#'+ kpiId + '_' + m +'_' + fieldType + ' > input').val();
        $('#'+ kpiId+'_' + m + '_targetRolling' + ' > input').val(numeral(value).format('0,0'));
        $('#review_'+ kpiId+'_' + m + '_targetRolling').html(numeral(value).format('0,0'));
        $('#review_'+ kpiId+'_' + m + '_target').html(numeral(value).format('0,0'));
    }

//        <%--evaluate sum 4 This Year--%>
    if(fieldType == 'result' || fieldType == 'resultinvestment' || fieldType == 'resultreturn'){
        var thisYear = 0;
        for ( var i = 1 ; i <= 12 ; i++){
            var va = $('#' + kpiId + '_' + i + '_' + fieldType + ' > input').val();
            thisYear += (va != null && va != '') ? parseFloat(numeral().unformat(va)) : 0
        }
        $('#'+ kpiId+'_thisYear_' + fieldType + '> input').val(numeral(thisYear).format('0,0'));
        $('#review_'+ kpiId+'_thisYear_' + fieldType ).html(numeral(thisYear).format('0,0'));
    }

//        <%--evaluate FY to Month--%>
    var fyToMonth = 0;
    var mo = m;

    if(year - y == 1 && month == 1){
        mo = 12;
    }
    for ( var i = 1 ; i <= mo ; i++){
        var val = $('#' + kpiId + '_' + i + '_' + fieldType + ' > input').val();
        fyToMonth += (val != null && val != '') ? parseFloat(numeral().unformat(val)) : 0;
    }
    $('#'+ kpiId+'_sumToMonth_' + fieldType).html(numeral(fyToMonth).format('0,0'));
    $('#review_'+ kpiId+'_sumToMonth_' + fieldType).html(numeral(fyToMonth).format('0,0'));
    if(fieldType == 'target'){
        $('#'+ kpiId+'_sumToMonth_targetRolling').html(numeral(fyToMonth).format('0,0'));
        $('#review_'+ kpiId+'_sumToMonth_targetRolling').html(numeral(fyToMonth).format('0,0'));
    }

//        <%--evaluate Best Estimate--%>
    if(fieldType == 'result'){
        var bestEstimate = 0;
        for ( var j = 1 ; j <= mo ; j++){
            var v = $('#' + kpiId + '_' + j + '_' + fieldType + ' > input').val();
            bestEstimate += (v != null && v != '') ? parseFloat(numeral().unformat(v)) : 0;
        }

        for ( var j = mo + 1; j <= 12 ; j++){
            var v = $('#' + kpiId + '_' + j + '_' + 'targetRolling' + ' > input').val();
            bestEstimate += (v != null && v != '') ? parseFloat(numeral().unformat(v)) : 0;
        }
    }else{
        var bestEstimate = 0;
        for ( var j = 1 ; j <= 12 ; j++){
            var v = $('#' + kpiId + '_' + j + '_' + fieldType + ' > input').val();
            bestEstimate += (v != null && v != '') ? parseFloat(numeral().unformat(v)) : 0;
        }
    }
    $('#'+ kpiId+'_bestEstimate_' + fieldType).html(numeral(bestEstimate).format('0,0'));
    $('#review_'+ kpiId+'_bestEstimate_' + fieldType).html(numeral(bestEstimate).format('0,0'));
    if(fieldType == 'target'){
        $('#'+ kpiId+'_bestEstimate_targetRolling').html(numeral(bestEstimate).format('0,0'));
        $('#review_'+ kpiId+'_bestEstimate_targetRolling').html(numeral(bestEstimate).format('0,0'));
    }
    if(fieldType == 'targetRolling'){
        var bestEstimateResult = 0;
        for ( var j = 1 ; j < mo ; j++){
            var v = $('#' + kpiId + '_' + j + '_' + 'result' + ' > input').val();
            bestEstimateResult += (v != null && v != '') ? parseFloat(numeral().unformat(v)) : 0;
        }

        for ( var j = mo; j <= 12 ; j++){
            var v = $('#' + kpiId + '_' + j + '_' + fieldType + ' > input').val();
            bestEstimateResult += (v != null && v != '') ? parseFloat(numeral().unformat(v)) : 0;
        }
        $('#'+ kpiId+'_bestEstimate_' + 'result').html(numeral(bestEstimateResult).format('0,0'));
        $('#review_'+ kpiId+'_bestEstimate_' + 'result').html(numeral(bestEstimateResult).format('0,0'));
    }
}

function evaluateValue4CaseGetLatest(y,kpiId, m, fieldType){

//        <%--set target rolling = target by default--%>
    if(fieldType == 'target'){
        var value = $('#'+ kpiId + '_' + m +'_' + fieldType+ ' > input').val();
        $('#'+ kpiId+'_' + m + '_targetRolling' + ' > input').val(numeral(value).format('0,0'));
        $('#review_'+ kpiId+'_' + m + '_targetRolling').html(numeral(value).format('0,0'));
        $('#review_'+ kpiId+'_' + m + '_target').html(numeral(value).format('0,0'));
    }

//        <%--set value 4 remain months--%>
    if(fieldType == 'target'){
        var curVal =  $('#'+ kpiId + '_' + m + '_' + fieldType+ ' > input').val();
        var currentValue = (curVal != null && curVal != '')? parseFloat(numeral().unformat(curVal)) : 0;
        for(var i = m + 1; i<=12;i++){
            $('#' + kpiId + '_' + i + '_' + fieldType + ' > input').val(numeral(currentValue).format('0,0'));
            $('#' + kpiId + '_' + i + '_' + 'targetRolling' + ' > input').val(numeral(currentValue).format('0,0'));

            $('#review_' + kpiId + '_' + i + '_' + fieldType ).html(numeral(currentValue).format('0,0'));
            $('#review_' + kpiId + '_' + i + '_' + 'targetRolling' ).html(numeral(currentValue).format('0,0'));
        }
    }

//        <%--evaluate set latest value 2 This Year--%>
    var mo = m;
    if(year - y == 1 && month == 1){
        mo = 12;
    }
    if(fieldType == 'result'){
        var thisYear = 0;
        var va = $('#' + kpiId + '_' + mo + '_' + fieldType + ' > input').val();
        thisYear = (va != null && va != '') ? parseFloat(numeral().unformat(va)) : 0;

        $('#'+ kpiId+'_thisYear_' + fieldType + ' > input').val(numeral(thisYear).format('0,0'));
        $('#review_'+ kpiId+'_thisYear_' + fieldType ).html(numeral(thisYear).format('0,0'));
    }

//        <%--evaluate FY to Month--%>
    var fyToMonth = 0;
    var val = 0;
    val = $('#' + kpiId + '_' + mo + '_' + fieldType + ' > input').val();
    if(fieldType == 'result'){
        val = $('#' + kpiId + '_' + mo + '_' + fieldType + ' > input').val();
    }
    fyToMonth = (val != null && val != '') ? parseFloat(numeral().unformat(val)) : 0;
    $('#'+ kpiId+'_sumToMonth_' + fieldType).html(numeral(fyToMonth).format('0,0'));
    $('#review_'+ kpiId+'_sumToMonth_' + fieldType).html(numeral(fyToMonth).format('0,0'));
    if(fieldType == 'target'){
        $('#'+ kpiId+'_sumToMonth_targetRolling').html(numeral(fyToMonth).format('0,0'));
        $('#review_'+ kpiId+'_sumToMonth_targetRolling').html(numeral(fyToMonth).format('0,0'));
    }

//        <%--evaluate Best Estimate--%>
    var bestEstimate = 0;
    if(fieldType == 'result'){
        var v = $('#' + kpiId + '_' + 12 + '_' + 'targetRolling' + ' > input').val();
        bestEstimate = (v != null && v != '') ? parseFloat(numeral().unformat(v)) : 0;
    }else{
        var v = $('#' + kpiId + '_' + 12 + '_' + fieldType + ' > input').val();
        bestEstimate = (v != null && v != '') ? parseFloat(numeral().unformat(v)) : 0;
    }
    $('#'+ kpiId+'_bestEstimate_' + fieldType).html(numeral(bestEstimate).format('0,0'));
    $('#review_'+ kpiId+'_bestEstimate_' + fieldType).html(numeral(bestEstimate).format('0,0'));
    if(fieldType == 'target'){
        $('#'+ kpiId+'_bestEstimate_targetRolling').html(numeral(bestEstimate).format('0,0'));
        $('#review_'+ kpiId+'_bestEstimate_targetRolling').html(numeral(bestEstimate).format('0,0'));
    }
    if(fieldType == 'targetRolling'){
        var bestEstimateResult = 0;
        var v = $('#' + kpiId + '_' + 12 + '_' + fieldType + ' > input').val();
        bestEstimateResult = (v != null && v != '') ? parseFloat(numeral().unformat(v)) : 0;
        $('#'+ kpiId+'_bestEstimate_' + 'result').html(numeral(bestEstimateResult).format('0,0'));
        $('#review_'+ kpiId+'_bestEstimate_' + 'result').html(numeral(bestEstimateResult).format('0,0'));
    }
}

function evaluateValue4CaseAverage(y, kpiId, m, fieldType){

//        <%--set target rolling = target by default--%>
    if(fieldType == 'target'){
        var value = $('#'+ kpiId + '_' + m +'_' + fieldType + ' > input').val();
        $('#'+ kpiId+'_' + m + '_targetRolling' + ' > input').val(numeral(value).format('0,0'));
        $('#review_'+ kpiId+'_' + m + '_targetRolling').html(numeral(value).format('0,0'));
        $('#review_'+ kpiId+'_' + m + '_target').html(numeral(value).format('0,0'));
    }

//        <%--evaluate sum 4 This Year--%>
    if(fieldType == 'result'){
        var thisYearSum = 0;
        for ( var i = 1 ; i <= m ; i++){
            var va = $('#' + kpiId + '_' + i + '_' + fieldType + ' > input').val();
            thisYearSum += (va != null && va != '') ? parseFloat(numeral().unformat(va)) : 0
        }
        var counter = parseFloat(m);
        var average = parseFloat(thisYearSum / counter).toFixed(2);
        $('#'+ kpiId+'_thisYear_' + fieldType + ' > input').val(numeral(average).format('0,0'));
        $('#review_'+ kpiId+'_thisYear_' + fieldType).html(numeral(average).format('0,0'));
    }

//        <%--evaluate FY to Month--%>
    var fyToMonth = 0;
    var mo = m;
    var average = 0;
    if(year - y == 1 && month == 1){
        mo = 12;
    }
        for ( var i = 1 ; i <= mo ; i++){
            var val = $('#' + kpiId + '_' + i + '_' + fieldType + ' > input').val();
            fyToMonth += (val != null && val != '') ? parseFloat(numeral().unformat(val)) : 0;
        }
        var counter = parseFloat(mo);
        var average = parseFloat(fyToMonth / counter).toFixed(2);


    $('#'+ kpiId+'_sumToMonth_' + fieldType).html(numeral(average).format('0,0'));
    $('#review_'+ kpiId+'_sumToMonth_' + fieldType).html(numeral(average).format('0,0'));
    if(fieldType == 'target'){
        $('#'+ kpiId+'_sumToMonth_targetRolling').html(numeral(average).format('0,0'));
        $('#review_'+ kpiId+'_sumToMonth_targetRolling').html(numeral(average).format('0,0'));
    }

//        <%--evaluate Best Estimate--%>
    if(fieldType != 'result'){
        var bestEstimate = 0;
        var average = 0;
        for ( var j = 1 ; j <= 12 ; j++){
            var v = $('#' + kpiId + '_' + j + '_' + fieldType + ' > input').val();
            bestEstimate += (v != null && v != '') ? parseFloat(numeral().unformat(v)) : 0;
        }
        average = parseFloat(bestEstimate / 12).toFixed(2);
    }else{
        var bestEstimate = 0;
        for ( var j = 1 ; j <= mo ; j++){
            var v = $('#' + kpiId + '_' + j + '_' + fieldType + ' > input').val();
            bestEstimate += (v != null && v != '') ? parseFloat(numeral().unformat(v)) : 0;
        }

        for ( var j = mo + 1 ; j <= 12 ; j++){
            var v = $('#' + kpiId + '_' + j + '_' + 'targetRolling' + ' > input').val();
            bestEstimate += (v != null && v != '') ? parseFloat(numeral().unformat(v)) : 0;
        }
        average = parseFloat(bestEstimate / 12).toFixed(2);

    }
    $('#'+ kpiId+'_bestEstimate_' + fieldType).html(numeral(average).format('0,0'));
    $('#review_'+ kpiId+'_bestEstimate_' + fieldType).html(numeral(average).format('0,0'));
    if(fieldType == 'target'){
        $('#'+ kpiId+'_bestEstimate_targetRolling').html(numeral(average).format('0,0'));
        $('#review_'+ kpiId+'_bestEstimate_targetRolling').html(numeral(average).format('0,0'));
    }
    if(fieldType == 'targetRolling'){
        var bestEstimateResult = 0;
        var averageResult = 0;
        for ( var j = 1 ; j < mo ; j++){
            var v = $('#' + kpiId + '_' + j + '_' + 'result' + ' > input').val();
            bestEstimateResult += (v != null && v != '') ? parseFloat(numeral().unformat(v)) : 0;
        }

        for ( var j = mo ; j <= 12 ; j++){
            var v = $('#' + kpiId + '_' + j + '_' + fieldType + ' > input').val();
            bestEstimateResult += (v != null && v != '') ? parseFloat(numeral().unformat(v)) : 0;
        }
        averageResult = parseFloat(bestEstimateResult / 12).toFixed(2);
        $('#'+ kpiId+'_bestEstimate_' + 'result').html(numeral(averageResult).format('0,0'));
        $('#review_'+ kpiId+'_bestEstimate_' + 'result').html(numeral(averageResult).format('0,0'));
    }
}


function evaluateResult4KPIAtt(y,kpiId, m, fieldType){

//        <%--evaluate sum 4 This Year--%>
    var thisYear = 0;
    for ( var i = 1 ; i <= 12 ; i++){
        var va = $('#' + kpiId + '_' + i + '_' + fieldType + ' > input').val();
        thisYear += (va != null && va != '') ? parseFloat(numeral().unformat(va)) : 0
    }
    $('#'+ kpiId+'_thisYear_' + fieldType + ' > input').val(numeral(thisYear).format('0,0'));
    $('#review_'+ kpiId+'_thisYear_' + fieldType ).html(numeral(thisYear).format('0,0'));

//        <%--evaluate FY to Month--%>
    var fyToMonth = 0;
    var mo = m;
    if(year - y == 1 && month == 1){
        mo = 12;
    }
    for ( var i = 1 ; i <= mo ; i++){
        var val = $('#' + kpiId + '_' + i + '_' + fieldType + ' > input').val();
        fyToMonth += (val != null && val != '') ? parseFloat(numeral().unformat(val)) : 0;
    }
    $('#'+ kpiId+'_sumToMonth_' + fieldType).html(numeral(fyToMonth).format('0,0'));
    $('#review_'+ kpiId+'_sumToMonth_' + fieldType).html(numeral(fyToMonth).format('0,0'));


//        <%--evaluate Best Estimate--%>
    var bestEstimate = 0;
    var v = $('#' + kpiId + '_' + 12 + '_' + 'targetRolling' + ' > input').val();
    bestEstimate = (v != null && v != '') ? parseFloat(numeral().unformat(v)) : 0;

    $('#'+ kpiId+'_bestEstimate_' + fieldType).html(numeral(bestEstimate).format('0,0'));
    $('#review_'+ kpiId+'_bestEstimate_' + fieldType).html(numeral(bestEstimate).format('0,0'));

}

function evaluateDelivery(kpiId,m, fieldType){
    var r;
    var t;
    var tr;
    var delivery;
    var deliveryRolling;

    if( $('#' + kpiId + '_' + m + '_result').find('INPUT').length ){
        r = $('#' + kpiId + '_' + m + '_result' + ' > input').val();
        t = $('#' + kpiId + '_' + m + '_target' + ' > input').val();
        tr = $('#' + kpiId + '_' + m + '_targetRolling' + ' > input').val();
    }else{
        r = $('#' + kpiId + '_' + m + '_result').html().trim();
        t = $('#' + kpiId + '_' + m + '_target').html().trim();
        tr = $('#' + kpiId + '_' + m + '_targetRolling').html().trim();
    }

    var result = (r != null && r != '') ? parseFloat(numeral().unformat(r)) : 0;
    var target = (t != null && t != '') ? parseFloat(numeral().unformat(t)) : 0;
    var targetRolling = (tr != null && tr != '') ? parseFloat(numeral().unformat(tr)) : 0;


    delivery = (result > 0) ? (parseFloat(result * 100/target) ).toFixed(1) : 0;
    deliveryRolling = (result > 0) ? (parseFloat(result * 100/targetRolling) ).toFixed(1) : 0;

    if(fieldType == 'result'){
        $('#'+ kpiId+'_'+ m + '_delivery').html(delivery+ '%');
        $('#'+ kpiId+'_'+ m + '_deliveryRolling').html(deliveryRolling+ '%');

        $('#review_'+ kpiId+'_'+ m + '_delivery').html(delivery+ '%');
        $('#review_'+ kpiId+'_'+ m + '_deliveryRolling').html(deliveryRolling+ '%');
    }
    if(fieldType == 'targetRolling'){
        $('#'+ kpiId+'_'+ m + '_deliveryRolling').html(deliveryRolling+ '%');
        $('#review_'+ kpiId+'_'+ m + '_deliveryRolling').html(deliveryRolling+ '%');
    }
}
function evaluateAllDelivery(kpiId,m, fieldType){
    evaluateDelivery(kpiId,m,fieldType);
    evaluateDelivery(kpiId,'thisYear',fieldType);
    evaluateDelivery(kpiId,'sumToMonth',fieldType);
    evaluateDelivery(kpiId,'bestEstimate',fieldType);
    if(fieldType == 'targetRolling'){
        evaluateDelivery(kpiId,'bestEstimate','result');
    }
}

function evaluatePOverI(kpiId, m , fieldType){
    var pOverI;
    var p;
    var i;

    if( $('#' + kpiId + '_' + m + '_' + fieldType + 'return').find('INPUT').length && $('#' + kpiId + '_' + m + '_' + fieldType + 'investment').find('INPUT').length){
        p = $('#' + kpiId + '_' + m + '_' + fieldType + 'return' + ' > input').val();
        i = $('#' + kpiId + '_' + m + '_' + fieldType + 'investment' + ' > input').val();
    }else{
        p = $('#' + kpiId + '_' + m + '_' + fieldType + 'return').html();
        i = $('#' + kpiId + '_' + m + '_' + fieldType + 'investment').html();

    }


    var profit = (p != null && p != '') ? parseFloat(numeral().unformat(p)) : 0;
    var investment = (i != null && i != '') ? parseFloat(numeral().unformat(i)) : 0;


    pOverI = (investment > 0) ? (parseFloat(profit * 100/investment) ).toFixed(1) : 0;
    $('#' + kpiId + '_' + m + '_poveri' + fieldType).html(pOverI+ '%');
    $('#review_' + kpiId + '_' + m + '_poveri' + fieldType).html(pOverI + '%');

}

function evaluateAllPOverI(kpiId, m , fieldType){
    evaluatePOverI(kpiId, m , fieldType);
    if(fieldType == 'result'){
        evaluatePOverI(kpiId, 'thisYear' , fieldType);
    }
    evaluatePOverI(kpiId, 'sumToMonth' , fieldType);
    evaluatePOverI(kpiId, 'bestEstimate' , fieldType);
}

function evaluateAttritionDelivery(kpiId,m, fieldType){
    var r;
    var rNoSM;
    var delivery;
    if(fieldType == 'unfortunate'){
        if( $('#' + kpiId + '_' + m + '_unfortunateresult').find('INPUT').length ){
            r = $('#' + kpiId + '_' + m + '_unfortunateresult' + ' > input').val();
            rNoSM = $('#noSM_' + m + '_result' + ' > input').val();
        }else{
            r = $('#' + kpiId + '_' + m + '_unfortunateresult').html();
            rNoSM = $('#noSM_' + m + '_result').html();
        }
    }else{
        if( $('#' + kpiId + '_' + m + '_result').find('INPUT').length ){
            r = $('#' + kpiId + '_' + m + '_result' + ' > input').val();
            rNoSM = $('#noSM_' + m + '_result' + ' > input').val();
        }else{
            r = $('#' + kpiId + '_' + m + '_result').html();
            rNoSM = $('#noSM_' + m + '_result').html();
        }
    }


    var result = (r != null && r != '') ? parseFloat(numeral().unformat(r)) : 0;
    var resultNoSM = (rNoSM != null && rNoSM != '') ? parseFloat(numeral().unformat(rNoSM)) : 0;


    delivery = (resultNoSM > 0) ? (parseFloat(result * 100/resultNoSM) ).toFixed(1) : 0;

    $('#'+ kpiId+'_'+ m + '_' + fieldType).html(delivery+ '%');
    $('#review_'+ kpiId+'_'+ m + '_' + fieldType).html(delivery + '%');
}
function evaluateAllAttDelivery(kpiId,m, fieldType){
    evaluateAttritionDelivery(kpiId,m, fieldType);
    evaluateAttritionDelivery(kpiId,'thisYear', fieldType);
    evaluateAttritionDelivery(kpiId,'sumToMonth', fieldType);
    evaluateAttritionDelivery(kpiId,'bestEstimate', fieldType);
}


function evaluateSum2Month(y,inputEle,kpiId,catName, col, fieldType) {
    var sumValue = 0;
    var mo = month - 1;
    if(year - y == 1 && month == 1){
        mo = 12;
    }
    if(catName != catSOV){
        var val = $('#' + kpiId + '_' + mo + '_' + fieldType + ' > input').val();
        sumValue = (val != null && val != '') ? parseFloat(numeral().unformat(val)) : 0;
    }else{
        for (var i = 1; i <= mo; i++) {
            var val = $('#' + kpiId + '_' + i + '_' + fieldType + ' > input').val();
            sumValue += (val != null && val != '') ? parseFloat(numeral().unformat(val)) : 0;
        }
    }

    $('#' + kpiId + '_'+ col+ '_' + fieldType).html(numeral(sumValue).format('0,0'));
    $('#review_' + kpiId + '_'+ col+ '_' + fieldType).html(numeral(sumValue).format('0,0'));
}

function warning(kpiId,fieldType,compareType){
    var be = $('#'+ kpiId + '_bestEstimate_' + fieldType).html();
    var bestEstimate = (be != null && be != '')? parseFloat(numeral().unformat(be)) : 0;
    if(compareType == 'gt'){
        var ty = $('#'+ kpiId + '_thisYear_' + fieldType + ' > input').val();
        var thisYear = (ty != null && ty != '')? parseFloat(numeral().unformat(ty)) : 0;
        var checker = bestEstimate - thisYear;
        if(checker >= 0){
            $('#TR_' + kpiId + '_' + fieldType).css('background','white');
            $('#CAT_' + kpiId + '_' + fieldType).val(1);
        }else{
            $('#TR_' + kpiId + '_' + fieldType).css('background','red');
            $('#CAT_' + kpiId+ '_' + fieldType).val(0);
        }
    }else if( compareType == 'lt'){
        var ty = $('#'+ kpiId + '_thisYear_' + fieldType + ' > input').val();
        var thisYear = (ty != null && ty != '')? parseFloat(numeral().unformat(ty)) : 0;
        var checker = bestEstimate - thisYear;
        if(checker <= 0){
            $('#TR_' + kpiId + '_' + fieldType).css('background','white');
            $('#CAT_' + kpiId+ '_' + fieldType).val(1);

        }else{
            $('#TR_' + kpiId + '_' + fieldType).css('background','red');
            $('#CAT_' + kpiId+ '_' + fieldType).val(0);
        }
    }else{
        $('#TR_' + kpiId + '_' + fieldType).css('background','blue');
        $('#CAT_' + kpiId+ '_' + fieldType).val(0);
    }



}




