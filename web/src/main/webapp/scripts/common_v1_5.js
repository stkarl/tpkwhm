function checkRequired(){
    var checker = true;
    $("span[class*='required']").each(function(){
        if($(this).attr('id') != undefined){
            var field = $(this).attr('id').split('_')[1];
            if($("#s2id_sl_" + field).is(":visible")){
                var slVal = $("#sl_" + field + " option:selected").val();
                if(slVal == null || slVal == '' || slVal < 0){
                    checker = false;
                    $("#sl_" + field).focus();
                    return false;
                }
            }
        }
    });
    return checker;
}

function closeAlert(){
    $(".alert-error").hide();
}
function warningDelete(ele){
    var id = $(ele).attr("id");
    bootbox.confirm('Xác nhận xóa dữ liệu', 'Bạn có chắc chắn muốn xóa phần tử này không', function(r) {
        if(r){
            if(id != null && id != undefined){
                $("<input type='hidden' name='checkList' value='"+id+"'>").appendTo($("#listForm"));
                $("#crudaction").val("delete");
                $("#listForm").submit();
            }
        }
    });
}
function submitForm(formId){
    $('body').modalmanager('loading');
    $('#'+formId).submit();
}
function saveData(url){
    $('body').modalmanager('loading');
    var u = url;
    document.location.href=u;
}
function submitReport(formId){
    $('body').modalmanager('loading');
    $('#crudaction').val('report');
    $('#'+formId).submit();
}

function submitExport(formId){
    $('#crudaction').val('export');
    $('#'+formId).submit();
    $('#crudaction').val('report');
}

function checkNumber(value, id){
    if(value != '' && $.isNumeric(value) == false){
        bootbox.alert("Thông báo", "Dùng dấu '.' để phân cách số thập phân",function(){
        });
        $('#' + id.toString()).val("");
    }
}


function getScaleOfNumber(value){
    try{
        if(value.trim() != ''){
            if(eval(value) < 0){return 0;}
            value = eval(value).toString();
            var reg = new RegExp("^\\d+(,\\d{3})*(\.?\\d+)?$");
            if(reg.test(value)){
                if(value.split('.').length > 1){
                    if(value.split('.')[1].toString().trim() != '0'){
                        return value.split('.')[1].length > 2 ? 2 : value.split('.')[1].length;
                    }
                }
            }
        }
    }catch (error){
    }
    return 0;
}