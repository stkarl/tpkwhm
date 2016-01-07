/** Add logic here for new theme */
function toggleLeftPanel() {
    if ($("#leftPanel").css('display') == 'none') {
        $("#leftPanel").css('display', 'block');
    }else{
        $("#leftPanel").css('display', 'none');
    }
}

$(document).ready(function(){
    // === Tooltips === //
    $('.tip').tooltip();
    $('.tip-left').tooltip({ placement: 'left' });
    $('.tip-right').tooltip({ placement: 'right' });
    $('.tip-top').tooltip({ placement: 'top' });
    $('.tip-bottom').tooltip({ placement: 'bottom' });

    //==== Popover ===== //
    $('.popover-top').popover({
        html: true,
        trigger: 'hover',
        placement: 'top'
    });
    //==== Prevent Cross site scripting ===== //
    $('input[type="text"]:not([class]').addClass("nohtml");
    $('input[type="text"][class*="required"]').addClass("nohtml");
    $('input[type="text"][class*="minlength"]').addClass("nohtml");
    $('input[type="text"][class*="text"]').addClass("nohtml");

    //==== Select 2 ==========//
    $('input[type=checkbox],input[type=radio],input[type=file]').uniform();
    $('select').not('.notAutoInitSelect2').select2();
})
