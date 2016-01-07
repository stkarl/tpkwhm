/* This function is used to change the style class of an element */
function swapClass(obj, newStyle) {
    obj.className = newStyle;
}

function isUndefined(value) {
    var undef;
    return value == undef;
}

function checkAll(theForm) { // check all the checkboxes in the list
    for (var i=0;i<theForm.elements.length;i++) {
        var e = theForm.elements[i];
        var eName = e.name;
        if (eName != 'allbox' &&
            (e.type.indexOf("checkbox") == 0)) {
            e.checked = theForm.allbox.checked;
        }
    }
}
//check all the checkboxes in the list
function checkAll(formId, listName, thisStatus){
    var list = document.getElementById(formId).elements[listName];
    if(list != null){
        var listSize = list.length;
        if(listSize == undefined) {
            if (!list.disabled) {
                if (thisStatus.checked) {
                    list.checked = true;
                    list.parentNode.className = 'checked';
                }else{
                    list.checked = false;
                    list.parentNode.className = '';
                }
            }
        } else {
            if(listSize > 1) { //Have one or more element
                for(i = 0; i < listSize; i++) {
                    if (!list[i].disabled) {
                        if (thisStatus.checked) {
                            list[i].checked = true;
                            list[i].parentNode.className = 'checked';
                        }else{
                            list[i].checked = false;
                            list[i].parentNode.className = '';
                        }
                    }
                }
            }
        }
    }

}
//check the all checkbox if there is only one checkbox which be checked
function checkAllIfOne(formId, listName, thisStatus, checkboxAll){
    var allCheck = document.getElementById(formId).elements[checkboxAll];
    if(!thisStatus.checked){	//uncheck one  checkbox
        allCheck.checked = false;
        allCheck.parentNode.className = "";
    }else{	//check one  checkbox
        //var checkList = document.getElementsByName(listName);
        var checkList = document.getElementById(formId).elements[listName];
        var listSize = checkList.length;
        if(listSize == undefined) {
            if(checkList.checked) {
                allCheck.checked = true;
                allCheck.parentNode.className = "checked";
            }

        } else {
            if(listSize > 0){ //Have one or more elements
                for(i = 0;i < listSize; i++)
                    if(!checkList[i].checked)
                        return false;
                allCheck.checked = true;
                allCheck.parentNode.className = "checked";
            }
        }

    }
}
function checkSelected4ConfirmDelete(formId, checkList) {
    var checkList = document.getElementById(formId).elements[checkList];
    var listSize = undefined;
    if(checkList != null)
        listSize = checkList.length;
    var fb = false;
    if(listSize == undefined && checkList != null) {
        if(checkList.checked) {
            return true;
        }
    }
    else {
        for(i=0; i < listSize; i++) {
            if(checkList[i].checked) {
                return true;
            }
        }
    }
    return false;
}

function checkSelected(formId, checkList) {
    var checkList = document.getElementById(formId).elements[checkList];
    var listSize = undefined;
    if(checkList != null)
        listSize = checkList.length;
    var fb = false;
    if(listSize == undefined && checkList != null) {
        if(checkList.checked) {
            return true;
        }
    }
    else {
        for(i=0; i < listSize; i++) {
            if(checkList[i].checked) {
                return true;
            }
        }
    }
    return false;
}

/* Function to clear a form of all it's values */
function clearForm(frmObj) {
    for (var i = 0; i < frmObj.length; i++) {
        var element = frmObj.elements[i];
        if(element.type.indexOf("text") == 0 ||
            element.type.indexOf("password") == 0) {
            element.value="";
        } else if (element.type.indexOf("radio") == 0) {
            element.checked=false;
        } else if (element.type.indexOf("checkbox") == 0) {
            element.checked = false;
        } else if (element.type.indexOf("select") == 0) {
            for(var j = 0; j < element.length ; j++) {
                element.options[j].selected=false;
            }
            element.options[0].selected=true;
        }
    }
}

/* Function to get a form's values in a string */
function getFormAsString(frmObj) {
    var query = "";
    for (var i = 0; i < frmObj.length; i++) {
        var element = frmObj.elements[i];
        if (element.type.indexOf("checkbox") == 0 ||
            element.type.indexOf("radio") == 0) {
            if (element.checked) {
                query += element.name + '=' + escape(element.value) + "&";
            }
        } else if (element.type.indexOf("select") == 0) {
            for (var j = 0; j < element.length ; j++) {
                if (element.options[j].selected) {
                    query += element.name + '=' + escape(element.value) + "&";
                }
            }
        } else {
            query += element.name + '='
                + escape(element.value) + "&";
        }
    }
    return query;
}

/* Function to hide form elements that show through
 the search form when it is visible */
function toggleForm(frmObj, iState) // 1 visible, 0 hidden
{
    for(var i = 0; i < frmObj.length; i++) {
        if (frmObj.elements[i].type.indexOf("select") == 0 || frmObj.elements[i].type.indexOf("checkbox") == 0) {
            frmObj.elements[i].style.visibility = iState ? "visible" : "hidden";
        }
    }
}

/* Helper function for re-ordering options in a select */
function opt(txt,val,sel) {
    this.txt=txt;
    this.val=val;
    this.sel=sel;
}

/* Function for re-ordering <option>'s in a <select> */
function move(list,to) {
    var total=list.options.length;
    index = list.selectedIndex;
    if (index == -1) return false;
    if (to == +1 && index == total-1) return false;
    if (to == -1 && index == 0) return false;
    to = index+to;
    var opts = new Array();
    for (i=0; i<total; i++) {
        opts[i]=new opt(list.options[i].text,list.options[i].value,list.options[i].selected);
    }
    tempOpt = opts[to];
    opts[to] = opts[index];
    opts[index] = tempOpt
    list.options.length=0; // clear

    for (i=0;i<opts.length;i++) {
        list.options[i] = new Option(opts[i].txt,opts[i].val);
        list.options[i].selected = opts[i].sel;
    }

    list.focus();
}

/*  This function is to select all options in a multi-valued <select> */
function selectAll(elementId) {
    var element = document.getElementById(elementId);
    len = element.length;
    if (len != 0) {
        for (i = 0; i < len; i++) {
            element.options[i].selected = true;
        }
    }
}

/* This function is used to select a checkbox by passing
 * in the checkbox id
 */
function toggleChoice(elementId) {
    var element = document.getElementById(elementId);
    if (element.checked) {
        element.checked = false;
    } else {
        element.checked = true;
    }
}

/* This function is used to select a radio button by passing
 * in the radio button id and index you want to select
 */
function toggleRadio(elementId, index) {
    var element = document.getElementsByName(elementId)[index];
    element.checked = true;
}

/* This function is used to open a pop-up window */
function openWindow(url, winTitle, winParams) {
    winName = window.open(url, winTitle, winParams);
    winName.focus();
}


/* This function is to open search results in a pop-up window */
function openSearch(url, winTitle) {
    var screenWidth = parseInt(screen.availWidth);
    var screenHeight = parseInt(screen.availHeight);

    var winParams = "width=" + screenWidth + ",height=" + screenHeight;
    winParams += ",left=0,top=0,toolbar,scrollbars,resizable,status=yes";

    openWindow(url, winTitle, winParams);
}

/* This function is used to set cookies */
function setCookie(name,value,expires,path,domain,secure) {
    document.cookie = name + "=" + escape (value) +
        ((expires) ? "; expires=" + expires.toGMTString() : "") +
        ((path) ? "; path=" + path : "") +
        ((domain) ? "; domain=" + domain : "") + ((secure) ? "; secure" : "");
}

/* This function is used to get cookies */
function getCookie(name) {
    var prefix = name + "="
    var start = document.cookie.indexOf(prefix)

    if (start==-1) {
        return null;
    }

    var end = document.cookie.indexOf(";", start+prefix.length)
    if (end==-1) {
        end=document.cookie.length;
    }

    var value=document.cookie.substring(start+prefix.length, end)
    return unescape(value);
}

/* This function is used to delete cookies */
function deleteCookie(name,path,domain) {
    if (getCookie(name)) {
        document.cookie = name + "=" +
            ((path) ? "; path=" + path : "") +
            ((domain) ? "; domain=" + domain : "") +
            "; expires=Thu, 01-Jan-70 00:00:01 GMT";
    }
}

// This function is for stripping leading and trailing spaces
String.prototype.trim = function () {
    return this.replace(/^\s*(\S*(\s+\S+)*)\s*$/, "$1");
};

// This function is used by the login screen to validate user/pass
// are entered.
function validateRequired(form) {
    var bValid = true;
    var focusField = null;
    var i = 0;
    var fields = new Array();
    oRequired = new required();

    for (x in oRequired) {
        if ((form[oRequired[x][0]].type == 'text' || form[oRequired[x][0]].type == 'textarea' || form[oRequired[x][0]].type == 'select-one' || form[oRequired[x][0]].type == 'radio' || form[oRequired[x][0]].type == 'password') && form[oRequired[x][0]].value == '') {
            if (i == 0)
                focusField = form[oRequired[x][0]];

            fields[i++] = oRequired[x][1];

            bValid = false;
        }
    }

    if (fields.length > 0) {
        focusField.focus();
        alert(fields.join('\n'));
    }

    return bValid;
}
//this function is used to check email
function isValidEmail(input) {
    regx = /^([a-zA-Z0-9_.-])+@(([a-zA-Z0-9-])+.)+([a-zA-Z0-9]{2,4})+$/;
    return regx.test(input);
}
//this function is used to check number
function isValidNumber(input) {
    regx = /^-?(0|[1-9]\d*|(?=\.))(\.\d+)?$/;
    return regx.test(input);
}
// This function is a generic function to create form elements
function createFormElement(element, type, name, id, value, parent) {
    var e = document.createElement(element);
    e.setAttribute("name", name);
    e.setAttribute("type", type);
    e.setAttribute("id", id);
    e.setAttribute("value", value);
    parent.appendChild(e);
}

function confirmDelete(obj) {
    var msg = "Are you sure you want to delete this " + obj + "?";
    ans = confirm(msg);
    if (ans) {
        return true;
    } else {
        return false;
    }
}

function highlightTableRows(tableId) {
    var previousClass = null;
    var table = document.getElementById(tableId);
    var startRow = 0;
    // workaround for Tapestry not using thead
    if (!table.getElementsByTagName("thead")[0]) {
        startRow = 1;
    }
    var tbody = table.getElementsByTagName("tbody")[0];
    var rows = tbody.getElementsByTagName("tr");
    // add event handlers so rows light up and are clickable
    for (i=startRow; i < rows.length; i++) {
        rows[i].onmouseover = function() { previousClass=this.className;this.className+=' over' };
        rows[i].onmouseout = function() { this.className=previousClass };
        /*rows[i].onclick = function() {
         var cell = this.getElementsByTagName("td")[0];
         var link = cell.getElementsByTagName("a")[0];
         if (link.onclick) {
         call = link.getAttribute("onclick");
         if (call.indexOf("return ") == 0) {
         call = call.substring(7);
         }
         // this will not work for links with onclick handlers that return false
         eval(call);
         } else {
         location.href = link.getAttribute("href");
         }
         this.style.cursor="wait";
         return false;
         }*/
    }
}

function highlightFormElements() {
    // add input box highlighting
    addFocusHandlers(document.getElementsByTagName("input"));
    addFocusHandlers(document.getElementsByTagName("textarea"));
}

/*Cookie function*/

function setCookie(name,value,days) {
    if (days) {
        var date = new Date();
        date.setTime(date.getTime()+(days*24*60*60*1000));
        var expires = "; expires="+date.toGMTString();
    }
    else var expires = "";
    document.cookie = name+"="+value+expires+"; path=/";
}

function getCookie(name) {
    var nameEQ = name + "=";
    var ca = document.cookie.split(';');
    for(var i=0;i < ca.length;i++) {
        var c = ca[i];
        while (c.charAt(0)==' ') c = c.substring(1,c.length);
        if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);
    }
    return null;
}

function deleteCookie(name) {
    setCookie(name,"", -1);
}

function addFocusHandlers(elements) {
    for (i=0; i < elements.length; i++) {
        if (elements[i].type != "button" && elements[i].type != "submit" &&
            elements[i].type != "reset" && elements[i].type != "checkbox" && elements[i].type != "radio") {
            if (!elements[i].getAttribute('readonly') && !elements[i].getAttribute('disabled')) {
                elements[i].onfocus=function() {this.style.backgroundColor='#ffd';this.select()};
                elements[i].onmouseover=function() {this.style.backgroundColor='#ffd'};
                elements[i].onblur=function() {this.style.backgroundColor='';}
                elements[i].onmouseout=function() {this.style.backgroundColor='';}
            }
        }
    }
}

function radio(clicked){
    var form = clicked.form;
    var checkboxes = form.elements[clicked.name];
    if (!clicked.checked || !checkboxes.length) {
        clicked.parentNode.parentNode.className="";
        return false;
    }

    for (i=0; i<checkboxes.length; i++) {
        if (checkboxes[i] != clicked) {
            checkboxes[i].checked=false;
            checkboxes[i].parentNode.parentNode.className="";
        }
    }

    // highlight the row
    clicked.parentNode.parentNode.className="over";
}

window.onload = function() {
    //highlightFormElements();
}

// Show the document's title on the status bar
window.defaultStatus=document.title;

function trimAndSubmitForm(formName) {
    $(formName).find('input:text').each(function(){
        var orgValue = $(this).val();
        $(this).val($.trim(orgValue));
    });
    $(formName).validate({
        errorPlacement: function(error, element) {},
        invalidHandler: function(event, validator) {
            bootbox.alert("Warning", validator.errorList[0].message);
        }
    });
    $(formName).submit();
}

function validateDateFormat(inputId, field) {
    if (!isDate($("#" + inputId).val(), inputId)) {
        bootbox.alert("Error", field + ": Invalid date format");
        return false;
    }
    return true;
}
function validateFromToDate(fromDateId, toDateId) {
    if ($("#" + fromDateId).val() != '' && !validateDateFormat(fromDateId, "From Date")) {
        $("#" + fromDateId).focus();
        return false;
    }
    if ($("#" + toDateId).val() != '' && !validateDateFormat(toDateId, "To Date")) {
        $("#" + toDateId).focus();
        return false;
    }
    if ($("#" + fromDateId).val() != '' && $("#" + toDateId).val() != '' && ! compareDate($("#" + fromDateId).val(), $("#" + toDateId).val())){
        $("#" + fromDateId).focus();
        return false;
    }
    return true;
}


$(document).ready(function() {
    try{
        $("#expanAll").click(function(){
            $(".resource-detail").slideDown(300);
            $(".btn-show-hide i").removeClass("icon-plus");
            $(".btn-show-hide i").each(function(){
                if(!$(this).hasClass("icon-minus")){
                    $(this).addClass("icon-minus");
                }
            });

        });
        $("#collapseAll").click(function(){
            $(".resource-detail").slideUp(300);
            $(".btn-show-hide i").removeClass("icon-minus");
            $(".btn-show-hide i").each(function(){
                if(!$(this).hasClass("icon-plus")){
                    $(this).addClass("icon-plus");
                }
            });
        });

        try{
            $('.myCorner').corner();
        }catch(err) { }

        $(".pagelinks .gotoPage").keydown(function(event) {
            // Allow: backspace, delete, tab, escape, and enter
            if ( event.keyCode == 46 || event.keyCode == 8 || event.keyCode == 9 || event.keyCode == 27 || event.keyCode == 13 ||
                // Allow: Ctrl+A
                (event.keyCode == 65 && event.ctrlKey === true) ||
                // Allow: home, end, left, right
                (event.keyCode >= 35 && event.keyCode <= 39)) {
                // let it happen, don't do anything
                return;
            }
            else {
                // Ensure that it is a number and stop the keypress
                if (event.shiftKey || (event.keyCode < 48 || event.keyCode > 57) && (event.keyCode < 96 || event.keyCode > 105 )) {
                    event.preventDefault();
                }
            }
        });

        $(".pagelinks .gotoPage").keypress(function(e){
            if(e.which == 13) {
                var totalPage = new BigInteger($(this).attr("id").replace(/,/g , ""));
                var gotoPage = new BigInteger($(this).val().replace(/,/g , ""));

                if(totalPage < gotoPage || gotoPage < 1){
                    return false;
                }
                var elementId = null;
                if($('#nextPage').length > 0){
                    elementId = 'nextPage';
                }else{
                    elementId = 'previousPage';
                }
                if(elementId != null){
                    var sysLink = $("#"+elementId).attr("href");
                    newLink = sysLink.replace(/-p=[0-9]{1,10}/g, '-p=' + $(this).val());
                    location.href = newLink;
                    return false;
                }
            }
        });

        $('.prevent_type').keydown(function(event){
            if (event.keyCode >= 0){
                event.preventDefault();
            }
        });
    }catch(err) { }

    //form validator
    try{
        jQuery.validator.addClassRules('required', {
            required: true
        });

        jQuery.validator.addClassRules('required-email', {
            required: true,
            email: true
        });

        jQuery.validator.addClassRules('no-special-character', {
            notSpecialCharacter: true
        });

        jQuery.validator.addMethod("number", function(value, element) {
            var nameRegex = /^[0-9.]+$/;
            return nameRegex.test(value);
        }, "Chỉ nhập số.");

        jQuery.validator.addMethod("notSpecialCharacter", function(value, element) {
            var nameRegex = /^[0-9a-zA-Z_-]+$/;
            return nameRegex.test(value);
        }, "Value contains illegal characters.");

        $("form").each(function(){
            if($(this).attr("novalidate") != null && $(this).attr("novalidate") != undefined){

                $(this).validate({
                    errorClass: "error-inline-validate",
                    errorElement: "span",
                    ignore: "",
                    highlight:function(element, errorClass, validClass) {
                        if($(element).hasClass('required') || $(element).hasClass('required-email') || $(element).hasClass('customRequired')) {
                            $(element).closest('.control-group').removeClass('success').addClass('error');
                        }
                    },
                    unhighlight: function(element, errorClass, validClass) {
                        if($(element).hasClass('required') || $(element).hasClass('required-email') || $(element).hasClass('customRequired')) {
                            $(element).closest('.control-group').removeClass('error').addClass('success');
                        }
                    },
                    success: function(element) {
                        var itemId = element.attr('for');
                        if($("[id='" + itemId + "']").hasClass('required') || $("[id='" + itemId + "']").hasClass('required-email')
                                || $("[id='" + itemId + "']").hasClass('customRequired')) {
                            element.text('OK!').addClass('valid').closest('.control-group').removeClass('error').addClass('success');
                        }else {
                            element.remove();
                        }
                    }
                });
            }

        });
    } catch(error){}

    // password field
    $("#btnShowHide").click(function(){
        if($(this).html() == "Show"){
            $(this).html("Hide");
            var mval = $("#pwd").val();
            $("#pwd").remove();
            $("<input type='text' class='required' name='pojo.password' id='pwd'>").val(mval).attr("style", "width:160px").insertBefore("#btnShowHide");

        }else{
            $(this).html("Show");
            var mval = $("#pwd").val();
            $("#pwd").remove();
            $("<input type='password' class='required' name='pojo.password' id='pwd'>").val(mval).attr("style", "width:160px").insertBefore("#btnShowHide");
        }
    });

    $('.not_allow_input').keydown(function(event){
        event.preventDefault();
    });
});
function searchSchool(selectId, schoolId, schoolName, url){
    try{
        $(selectId).select2({
            minimumInputLength: 3,
            allowClear: true,
            ajax: {
                url: url,
                dataType: 'json',
                quietMillis: 100,
                type : "POST",
                data: function (term, page) { // page is the one-based page number tracked by Select2
                    return {
                        schoolName: term, //search term
                        page_limit: 10, // page size
                        page: page, // page number
                        _: new Date().getTime()
                    };
                },
                results: function (data, page) {
                    $('select').select2();
                    if (data != null){
                        var more = (page * 10) < data.total;
                        return {results: data.schools, more: more};
                    }
                }
            },
            dropdownCssClass: "bigdrop" // apply css that makes the dropdown taller
        });
        if ($(schoolId).val() != '' && $(schoolName).val() != ''){
            $(selectId).select2('data', { id: $(schoolId).val(), text: $(schoolName).val() });
        }
        $(selectId).change(function() {
            if ($(selectId).select2('data') != null){
                $(schoolId).val($(selectId).select2('data').id);
                $(schoolName).val( $(selectId).select2('data').text);
            }else{
                $(schoolId).val("");
                $(schoolName).val("");
            }
        });
    }catch(error){}
}

$(document).on('touchstart', function (e) {
    if($(".datepicker").is(":visible")){
        var clsName = e.target.className;
        if(clsName != null && clsName != undefined){
            clsName = clsName.trim().toLowerCase();
            var targetObj = $("."+clsName).closest("div");
            if(targetObj != null && targetObj != undefined){
                if(targetObj.attr("class").trim().toLowerCase().indexOf('datepicker') < 0){
                    $(".datepicker").hide();
                }
            }
        }
    }
});

function toggleTRs(className, iconID, prefixIconURL) {


    if($('#' + iconID).attr('src') == prefixIconURL + 'open_ico.png') {//collapse
        $('#' + iconID).attr('src', prefixIconURL + 'close_ico.png');
        $('.' + className).each(function(){
            if(!$(this).hasClass('hidden')) {
                $(this).addClass('hidden');
            }
        });
    }else{
        $('#' + iconID).attr('src' , prefixIconURL + 'open_ico.png');
        $('.' + className).each(function(){
            if($(this).hasClass('hidden')) {
                $(this).removeClass('hidden');
            }
        });
    }
}
function collapseAllLevels(className, iconID){
    if($('#' + iconID).attr('src') != undefined){
        $('#' + iconID).attr('src', $('#' + iconID).attr('src').replace('open_ico.png', 'close_ico.png'));

    }
    $('.' + className).each(function(){
        var icon = $(this).find('td:first').find('a').find('img');
        if(icon.attr('id') != undefined){
            $('#' + icon.attr('id')).attr('src', $('#' + icon.attr('id')).attr('src').replace('open_ico.png', 'close_ico.png'));
        }
        if(!$(this).hasClass('hidden')) {
            $(this).addClass('hidden');
        }
    });
}
function toggleTRs3Levels(className, iconID, regexOfChildClassName, regexOf2ndChildClassName) {
    var rege = /open_ico.png/;
    if(rege.test($('#' + iconID).attr('src'))) {//collapse
        $('#' + iconID).attr('src', $('#' + iconID).attr('src').replace('open_ico.png', 'close_ico.png'));
        $('.' + className).each(function(){
            if(!$(this).hasClass('hidden')) {
                $(this).addClass('hidden');
            }
        });
    }else{//open
        var firstLevelOpen = false;
        var secondLevelOpen = false;
        var hasSecondLevel = false;
        $('#' + iconID).attr('src', $('#' + iconID).attr('src').replace('close_ico.png', 'open_ico.png'));
        $('.' + className).each(function(){
            var clazzes = $(this).attr('class');
            var matched1 = clazzes.match(regexOfChildClassName);
            var matched2 = clazzes.match(regexOf2ndChildClassName);
            var level = 1;
            if(matched1 == null && matched2 == null) {
                hasSecondLevel = false;
            }else if(matched1 != null && matched2 == null) {
                level = 2;
                hasSecondLevel = true;
            }else if(matched1 != null && matched2 != null) {
                level = 3;
            }
            if(level == 1){
                var icon = $(this).find('td:first').find('a').find('img');
                if(icon.attr('id') != undefined){
                    if(rege.test($('#' + icon.attr('id')).attr('src'))){
                        firstLevelOpen = true;
                    }else{
                        firstLevelOpen = false;
                    }
                }else{
                    firstLevelOpen = false;
                }
                if($(this).hasClass('hidden')) {
                    $(this).removeClass('hidden');
                }
            }else if(level == 2){
                var icon = $(this).find('td:first').find('a').find('img');
                if(icon.attr('id') != undefined){
                    if(rege.test($('#' + icon.attr('id')).attr('src'))){
                        secondLevelOpen = true;
                    }else{
                        secondLevelOpen = false;
                    }
                }else{
                    secondLevelOpen = false;
                }
                if(firstLevelOpen && $(this).hasClass('hidden')){
                    $(this).removeClass('hidden');
                }
            }else if(level == 3){
                if(((firstLevelOpen && hasSecondLevel && secondLevelOpen) || (firstLevelOpen && !hasSecondLevel)) && $(this).hasClass('hidden')){
                    $(this).removeClass('hidden');
                }
            }
        });
    }
}
function toggleTRs2Levels(className, iconID, regexOfChildClassName) {
    var rege = /open_ico.png/;
    if(rege.test($('#' + iconID).attr('src'))) {//collapse
        $('#' + iconID).attr('src', $('#' + iconID).attr('src').replace('open_ico.png', 'close_ico.png'));
        $('.' + className).each(function(){
            if(!$(this).hasClass('hidden')) {
                $(this).addClass('hidden');
            }
        });
    }else{//open
        var firstLevelOpen = false;
        $('#' + iconID).attr('src', $('#' + iconID).attr('src').replace('close_ico.png', 'open_ico.png'));
        $('.' + className).each(function(){
            var clazzes = $(this).attr('class');
            var matched = clazzes.match(regexOfChildClassName);
            var isFisrtLevel = false;
            if(matched == null) isFisrtLevel = true;

            if(isFisrtLevel){
                var icon = $(this).find('td:first').find('a').find('img');
                if(icon.attr('id') != undefined){
                    if(rege.test($('#' + icon.attr('id')).attr('src'))){
                        firstLevelOpen = true;
                    }else{
                        firstLevelOpen = false;
                    }
                }else{
                    firstLevelOpen = false;
                }
                if($(this).hasClass('hidden')) {
                    $(this).removeClass('hidden');
                }
            }else{//2nd level
                if(firstLevelOpen && $(this).hasClass('hidden')){
                    $(this).removeClass('hidden');
                }
            }
        });
    }
}

function refreshCaptcha() {
    document.getElementById('captchaCodeImg').src = "jcaptcha?dc=" + new Date().getTime();
}

function toggleSidebar() {
    if ($("#sidebar").hasClass('show')) {
        $("#sidebar").removeClass('show');
        $(".sidebar_body").hide();
    }else{
        $("#sidebar").addClass('show');
        $(".sidebar_body").show();
    }
}

function toggleSidebarTeacherList() {
    if ($("#sidebar").hasClass('show')) {
        $("#sidebar").removeClass('show');
        $(".sidebar_body").hide();
    }else{
        $("#sidebar").addClass('show');
        $("#sidebar").addClass('sidebarTeacher');
        $(".sidebar_body").show();
    }
}

function showHide(targetId){
    var isShowing = $(".resource-detail-"+targetId).is(":visible");
    if(isShowing){
        $(".resource-detail-"+targetId).slideUp(300);
    }else{
        $(".resource-detail-"+targetId).slideDown(300);
    }

    if($("#btn-show-hide-"+targetId+" i").hasClass("icon-plus")){
        $("#btn-show-hide-"+targetId+" i").removeClass("icon-plus");
        $("#btn-show-hide-"+targetId+" i").addClass("icon-minus");
    }else{
        $("#btn-show-hide-"+targetId+" i").removeClass("icon-minus");
        $("#btn-show-hide-"+targetId+" i").addClass("icon-plus");
    }
}
function parseDate(input) {
    var parts = input.split('/');
    // new Date(year, month [, date [, hours[, minutes[, seconds[, ms]]]]])
    return new Date(parts[2], parts[0]-1, parts[1]); // months are 0-based
}
function compareDate(fromDate, toDate){
    if (parseDate(fromDate) > parseDate(toDate)){
        alert("From Date is greater than To Date", "Error");
        return false;
    };
    return true;
}

function getBrowser()
{
    var BrowserDetect = {
        init: function () {
            this.browser = this.searchString(this.dataBrowser) || "An unknown browser";
            this.version = this.searchVersion(navigator.userAgent)
                || this.searchVersion(navigator.appVersion)
                || "an unknown version";
            this.OS = this.searchString(this.dataOS) || "an unknown OS";
        },
        searchString: function (data) {
            for (var i=0;i<data.length;i++)	{
                var dataString = data[i].string;
                var dataProp = data[i].prop;
                this.versionSearchString = data[i].versionSearch || data[i].identity;
                if (dataString) {
                    if (dataString.indexOf(data[i].subString) != -1)
                        return data[i].identity;
                }
                else if (dataProp)
                    return data[i].identity;
            }
        },
        searchVersion: function (dataString) {
            var index = dataString.indexOf(this.versionSearchString);
            if (index == -1) return;
            return parseFloat(dataString.substring(index+this.versionSearchString.length+1));
        },
        dataBrowser: [
            {
                string: navigator.userAgent,
                subString: "Chrome",
                identity: "Chrome"
            },
            { 	string: navigator.userAgent,
                subString: "OmniWeb",
                versionSearch: "OmniWeb/",
                identity: "OmniWeb"
            },
            {
                string: navigator.vendor,
                subString: "Apple",
                identity: "Safari",
                versionSearch: "Version"
            },
            {
                prop: window.opera,
                identity: "Opera",
                versionSearch: "Version"
            },
            {
                string: navigator.vendor,
                subString: "iCab",
                identity: "iCab"
            },
            {
                string: navigator.vendor,
                subString: "KDE",
                identity: "Konqueror"
            },
            {
                string: navigator.userAgent,
                subString: "Firefox",
                identity: "Firefox"
            },
            {
                string: navigator.vendor,
                subString: "Camino",
                identity: "Camino"
            },
            {		// for newer Netscapes (6+)
                string: navigator.userAgent,
                subString: "Netscape",
                identity: "Netscape"
            },
            {
                string: navigator.userAgent,
                subString: "MSIE",
                identity: "Explorer",
                versionSearch: "MSIE"
            },
            {
                string: navigator.userAgent,
                subString: "Gecko",
                identity: "Mozilla",
                versionSearch: "rv"
            },
            { 		// for older Netscapes (4-)
                string: navigator.userAgent,
                subString: "Mozilla",
                identity: "Netscape",
                versionSearch: "Mozilla"
            }
        ],
        dataOS : [
            {
                string: navigator.platform,
                subString: "Win",
                identity: "Windows"
            },
            {
                string: navigator.platform,
                subString: "Mac",
                identity: "Mac"
            },
            {
                string: navigator.userAgent,
                subString: "iPhone",
                identity: "iPhone/iPod"
            },
            {
                string: navigator.platform,
                subString: "Linux",
                identity: "Linux"
            }
        ]

    };
    BrowserDetect.init();
    return BrowserDetect;
}

function containHtml(value) {
    return (value.match(/<(|\/)(\w+)((?:\s+\w+(?:\s*=\s*(?:(?:"[^"]*")|(?:'[^']*')|[^>\s]+))?)*)\s*(\/?)>/)) == null;
}

function doPrint(totalItems, resourceUrl){
    $('#crudaction').val('print');
    if (totalItems == 0){
        bootbox.alert("Warning", "Zero record found.");
    } else {
        if ( $.browser.msie ) {
           newwindow= window.open(resourceUrl, '_blank');
        } else {
            $('iframe').attr('src', resourceUrl);
            $('iframe').load(function(){
                var iframeEl = document.getElementById('viewer');
                iframeEl.contentWindow.window.focus();
                iframeEl.contentWindow.window.print();
            });
        }
    }
    $('#crudaction').val('search');
}
function doExport(formElement, totalItems){
    $('#crudaction').val('export');
    if (totalItems == 0){
        bootbox.alert("Warning", "Zero record found.");
    } else {
        $("#" + formElement).submit();
    }
    $('#crudaction').val('search');
}

function checkEnableLinkSubmit(fileUpload, linkSubmit){
    if (fileUpload.val() != ""){
        linkSubmit.css('display', 'block');
        linkSubmit.removeAttr("disabled");
        linkSubmit.css('cursor', 'pointer');
    }else{
        linkSubmit.css('display', 'none');
        linkSubmit.attr("disabled", "disabled");
        linkSubmit.css('cursor', 'default');
    }
}

function checkSubmit(linkSubmit, formSubmit){
    if (linkSubmit.attr("disabled") === undefined){
        formSubmit.submit();
    }
}
function addPlaceHolder(input) {   // fix placeholder not working for IE
    if ($.browser.msie) {
        input.val(input.attr('placeholder'));

        input.focus(function () {
            if ($(this).val() == $(this).attr('placeholder')) {
                $(this).val('');
                $(this).removeClass('placeholder');
            }
        }).blur(function () {
                if ($(this).val() == '' || $(this).val() == $(this).attr('placeholder')) {
                    $(this).addClass('placeholder');
                    $(this).val($(this).attr('placeholder'));
                }
            });

    }
}
function selectFirstItemSelect2(select2ItemId){
    if ($.browser.msie) {
        $(select2ItemId).select2().select2('val','-1');
    }else{
        $(select2ItemId).select2().select2('val', $('.select2 option:eq(1)').val());
    }
}
function insertGroupOptionsToSelect(select2Id, data, optgroupName, allSelectOption){
    var k = -1;
    var j = 0;
    var group = new Array();
    var targetId = select2Id.substr(1, select2Id.length);
    var targetObj = document.getElementById(targetId).options;
    targetObj.length = 1;
    var prevClassGroupId = -1;
        for (i = 0; i < data.array.length; i++) {
            var item = data.array[i];
            if (item.classGroupId == null && prevClassGroupId != -2) {
                k = j;
                j++;
                group[k] = document.createElement('optgroup');
                group[k].setAttribute("label", optgroupName);
                prevClassGroupId = -2;
            } else if (item.classGroupId != prevClassGroupId && item.classGroupId != null) {
                k = j;
                j++;
                group[k] = document.createElement('optgroup');
                group[k].setAttribute("label", 'Group ' + item.classGroupName);
                prevClassGroupId = item.classGroupId;
            }
            var option = document.createElement('option');
            group[k].appendChild(new Option(item.firstLastName, item.userId));
        }
    $.each(group, function(index, value){
        document.getElementById(targetId).appendChild(value);
    });

    $(select2Id).select2();
}

$(document).ready(function(){

});
function trimText(input){
    if (input.val() == input.attr('placeholder')){
        input.val("");
    }
    input.val($.trim(input.val()));
}

function hightlightInput(element, errorFlag, focusFlag){
    var addOn = null;
    if ($(element).prop('type') == 'select-one'){
        element = $('#s2id_' + $(element).attr('id')).find('.select2-choice:first-child');
    }else{
        if ($(element).hasClass('requiredInput')){
            if($(element).closest('div.input-append').find('span').hasClass('add-on')){
                addOn = $(element).closest('div').find('span.add-on');
            }
        }
        element = $(element);
    }
    if (errorFlag || $.type(errorFlag) === "undefined"){
        if(element.hasClass("success-input")){
            element.removeClass("success-input");
            if (null != addOn){
                addOn.removeClass('success-input');
            }
        }
        if (!element.hasClass("error-input")){
            element.addClass("error-input");
            if(null != addOn){
                addOn.addClass('error-input');
            }
        }

        if ($.type(focusFlag) !== "undefined" && focusFlag){
            /* prevent focus on the date picker element */
            if (!element.hasClass('prevent_type')){
                element.focus();
            }
        }
    }else{
        if(element.hasClass("error-input")){
            element.removeClass("error-input");
            if (null != addOn){
                addOn.removeClass('error-input');
            }
        }
        if (!element.hasClass("success-input")){
            element.addClass("success-input");
            if (null != addOn){
                addOn.addClass('success-input');
            }
        }
    }
}

function checkInput(element){
    if ($(element).val() !== ""){
        hightlightInput(element, false);
    }else{
        hightlightInput(element, true, true);
    }
}

function checkValidFormSubmit(formID){
    var hasError = false;
    $('#' + formID).find("input[class*='requiredInput'], select[class*='requiredInput']").each(function(){
        if($(this).val() == "-1" || $(this).val() == ""){
            hightlightInput(this, true);
            hasError = true;
        }
    });
    if (hasError){
        return false;
    }
    return true;
}

function compare2DatesFromString(strDate1, strDate2){
    var arrStrDate1 = strDate1.split('/');
    var arrStrDate2 = strDate2.split('/');
    var date1 = new Date(arrStrDate1[2], arrStrDate1[1]-1, arrStrDate1[0]);
    var date2 = new Date(arrStrDate2[2], arrStrDate2[1]-1, arrStrDate2[0]);
    if (date1.getTime() == date2.getTime())
        return 0;
    else if (date1.getTime() > date2.getTime())
        return 1;
    else
        return -1;
}

function forceNumericInputsOnly(elementInput){
    $(elementInput).keydown(function(event){
        // Ensure that it is a number and stop the keypress
        if (event.keyCode >= 65 && event.keyCode <= 90) {
            event.preventDefault();
        }
    });
}

function notAllowInputButFormatCurrency(){
    $('.not_allow_input').each(function(){
        $(this).formatCurrency({ roundToDecimalPlace: 0, eventOnDecimalsEntered: true });
        $(this).keydown(function(event){
            event.preventDefault();
        });
    })
}

function autoBindCurrencyFormat(){
    $('.currencyFormat').blur(function() {
        $(this).formatCurrency({ roundToDecimalPlace: 0, eventOnDecimalsEntered: true });
    });
}

function changeTableRowBackground(trObject, color){
    $(trObject).find('td').each(function(){
        $(this).css('background', color);
    });
}

function checkKeyCodeForOnlyNumberInput(keycode){
    if((keyCode >= 65 && keyCode <= 90) || (keyCode >= 106 && keyCode <= 111)){
        return false;
    }
}

$(document).ready(function(){
    $('.currencyFormat').blur(function() {
        var numericReg = /\d+/g;
        if (!numericReg.test($(this).val()))
            $(this).val('');
        $(this).formatCurrency({ roundToDecimalPlace: 0, eventOnDecimalsEntered: true });
    });

    $('.currencyFormat').keydown(function(event){
        // Ensure that it is a number and stop the keypress
        if (event.keyCode >= 65 && event.keyCode <= 90) {
            event.preventDefault();
        }
    });

    $('.onlyNumberInput').keydown(function(event){
        // Ensure that it is a number and stop the keypress
        if(!checkKeyCodeForOnlyNumberInput(event.keyCode)){
            event.preventDefault();
        }
    });
});

$(window).load(function(){
    (function ($, window, delay) {
        // http://jsfiddle.net/AndreasPizsa/NzvKC/
        var theTimer = 0;
        var theElement = null;
        var theLastPosition = {x:0,y:0};
        $('[data-toggle]')
            .closest('li')
            .on('mouseenter', function (inEvent) {
                if (theElement) theElement.removeClass('open');
                window.clearTimeout(theTimer);
                theElement = $(this);

                theTimer = window.setTimeout(function () {
                    theElement.addClass('open');
                }, delay);
            })
            .on('mousemove', function (inEvent) {
                if(Math.abs(theLastPosition.x - inEvent.ScreenX) > 4 ||
                    Math.abs(theLastPosition.y - inEvent.ScreenY) > 4)
                {
                    theLastPosition.x = inEvent.ScreenX;
                    theLastPosition.y = inEvent.ScreenY;
                    return;
                }

                if (theElement.hasClass('open')) return;
                window.clearTimeout(theTimer);
                theTimer = window.setTimeout(function () {
                    theElement.addClass('open');
                }, delay);
            })
            .on('mouseleave', function (inEvent) {
                window.clearTimeout(theTimer);
                theElement = $(this);
                theTimer = window.setTimeout(function () {
                    theElement.removeClass('open');
                }, delay);
            });
    })(jQuery, window, 200); // 200 is the delay in milliseconds
});

function checkMST(value){
    var arrIndexValue = value.split("");
    if(arrIndexValue.length > 10){
        var number = 10-(eval(arrIndexValue[0])*31+eval(arrIndexValue[1])*29+eval(arrIndexValue[2])*23+eval(arrIndexValue[3])*19+
                            eval(arrIndexValue[4])*17+eval(arrIndexValue[5])*13+eval(arrIndexValue[6])*7+eval(arrIndexValue[7])*5+
                            eval(arrIndexValue[8])*3);
        if((number - 11 * Math.floor(number/11) == eval(arrIndexValue[9]))){
            return true;
        }
    }
    return false;
}

function formatNumberFromString(value, pScale){
    if(pScale == null){
        var scale = value.split('.')[1].length;
        return eval(value.toFixed(scale));
    }else{
        return eval(value.toFixed(pScale));
    }
}

function autoSearchByName(selectId, objId, objName, url){
    var valueterm ;
    try{
        $(selectId).select2({
            minimumInputLength: 3,
            allowClear: true,
            ajax: {
                url: url,
                dataType: 'json',
                quietMillis: 100,
                type : "POST",
                data: function (term, page) { // page is the one-based page number tracked by Select2
                    valueterm = term;
                    return {
                        schoolName: term, //search term
                        page_limit: 10, // page size
                        page: page, // page number
                        _: new Date().getTime()
                    };
                },
                results: function (data, page) {
                    $('select').select2();
                    if (data != null){
                        if(data.schools.length >0)
                        {
                            var more = (page * 10) < data.total;
                            return {results: data.schools, more: more};
                        }
                        else
                        {
                            var schools = [];
                            schools.push({
                                text: valueterm,
                                id: -1
                            });
                            return {results: schools, more: 1}
                        }
                    }
                }
            },
            dropdownCssClass: "bigdrop" // apply css that makes the dropdown taller
        });
        if ($(objId).val() != '' && $(objName).val() != ''){
            $(selectId).select2('data', { id: $(objId).val(), text: $(objName).val() });
        }

        $(selectId).change(function() {
            if ($(selectId).select2('data') != null){
                $(objId).val($(selectId).select2('data').id);
                $(objName).val( $(selectId).select2('data').text);
            }else{
                $(objId).val("");
                $(objName).val("");
            }
        });
    }catch(error){}
}