
(function($)
{
    $.fn.moneyFormat_VN = function(options)
    {
        options = $.extend({}, {
            thousands: ',',
            decimal: '.'
        }, options);

        $(this).blur(function() {
//            $(this).formatCurrency({ colorize: true, negativeFormat: '-%s%n', roundToDecimalPlace: getScaleOfNumber($(this).val()), decimalSymbol: options.decimal, digitGroupSymbol: options.thousands });
        })
            .keyup(function(e) {
                var e = window.event || e;
                var keyUnicode = e.charCode || e.keyCode;
                if (e !== undefined) {
                    switch (keyUnicode) {
                        case 16: break; // Shift
                        case 17: break; // Ctrl
                        case 18: break; // Alt
                        case 27: this.value = ''; break; // Esc: clear entry
                        case 35: break; // End
                        case 36: break; // Home
                        case 37: break; // cursor left
                        case 38: break; // cursor up
                        case 39: break; // cursor right
                        case 40: break; // cursor down
                        case 78: break; // N (Opera 9.63+ maps the "." from the number key section to the "N" key too!) (See: http://unixpapa.com/js/key.html search for ". Del")
                        case 110: break; // . number block (Opera 9.63+ maps the "." from the number block to the "N" key (78) !!!)
                        case 190: break; // .
                        default: $(this).formatCurrency({ colorize: true, negativeFormat: '-%s%n', roundToDecimalPlace: -1, eventOnDecimalsEntered: true, decimalSymbol: options.decimal, digitGroupSymbol: options.thousands });
                    }
                }
            })
            .bind('decimalsEntered', function(e, cents) {
            });
    };

})(jQuery);

/** Add logic here for new theme */
function toggleLeftPanel() {
    if ($("#leftPanel").css('display') == 'none') {
        $("#leftPanel").css('display', 'block');
    }else{
        $("#leftPanel").css('display', 'none');
    }
}
function formatNumberVND(e) {
    e.parseNumber({ format: "#,###,###.###", locale: "us" });
    e.formatNumber({ format: "#,###,###.###", locale: "us" });
}
var ctrlDown = false;
function handleKeyDown(e) {
    if (e.which == 17) ctrlDown = true;
}
function handleKeyUp(e) {
    if (e.which == 17) ctrlDown = false;
}
function ignoreEvent(e) {
    if (e.which >= 16 && e.which <= 18) return true;
    if (e.which >= 33 && e.which <= 40) return true;
    if (e.which == 190) return true;
    if (ctrlDown && (e.which == 65 || e.which == 67)) return true;
    return false;
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

    $(".inputNumber").each(function() {
        if($(this).val() != ""){
            formatNumberVND($(this));
        }
    });
    $(".inputNumber").keydown(function(e) {
        handleKeyDown(e);
    }).keyup(function(e) {
        handleKeyUp(e);
        if (!ignoreEvent(e)) formatNumberVND($(this));
    });

    $(".inputCode").keydown(function(e) {
        handleKeyDown(e);
    }).keyup(function(e) {
            handleKeyUp(e);
            if (!ignoreEvent(e)) $(this).parseNumber({ format: "#,##0", locale: "us" });
            if($(this).val() == 0) $(this).val("");
    });

    $(".inputFractionNumber").each(function(){
        $(this).moneyFormat_VN({thousands: ',', decimal: '.'});
    });
})
