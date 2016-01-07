jQuery(function($) {

    var selectedDate = null;

    /* initialize the external events
     -----------------------------------------------------------------*/

    $('#external-events div.external-event').each(function() {

        // create an Event Object (http://arshaw.com/fullcalendar/docs/event_data/Event_Object/)
        // it doesn't need to have a start or end
        var eventObject = {
            title: $.trim($(this).text()) // use the element's text as the event title
        };

        // store the Event Object in the DOM element so we can get to it later
        $(this).data('eventObject', eventObject);

        // make the event draggable using jQuery UI
        $(this).draggable({
            zIndex: 999,
            revert: true,      // will cause the event to go back to its
            revertDuration: 0  //  original position after the drag
        });

    });




    /* initialize the calendar
     -----------------------------------------------------------------*/

    var date = new Date();
    if (selectedDate == null){
        selectedDate = new Date();
    }

    // No nedd  to use this below code bacause of ajax call to get events of last month wii be performed on event viewDisplay of fullCalendar.
//    $.ajax({
//        url: contextPath + "ajax/getEvents.html",
//        dataType: "json",
//        data: "year=" +selectedDate.getFullYear()+ "&month=" + (selectedDate.getMonth()),
//        async: false,
//        success: function(res){
//            var events = [];
//            $(res.results).each(function(ind,val){
//                var startTime = new Date(val.start);
//                var endTime = new Date(val.end);
//                var event = {
//                    title: val.title,
//                    start: new Date(startTime.getFullYear(), startTime.getMonth(), startTime.getDate(), startTime.getHours(), startTime.getMinutes(), startTime.getSeconds()),
//                    end: new Date(endTime.getFullYear(), endTime.getMonth(), endTime.getDate(), endTime.getHours(), endTime.getMinutes(), endTime.getSeconds()),
////                            backgroundColor: val.background,
////                            textColor: val.color,
//                    borderColor: "#000",
//                    allDay: val.allDay ,
//                    id: val.id
//                };
//                events.push(event);
//            });

            function onRenderCallDay(view, values){
                // check for offDaysInMonth (global)
                $('td.fc-widget-content').removeClass('calendar_cell_holiday');
                $(this).removeAttr("disabled");

                // reset value for array of holidays in month.
                inMonthGlobalOffDaysSetting = new Array();
                // Get all off days in month.
                if (null != values.offDaysInMonth){
                    $(values.offDaysInMonth).each(function(ind,val){
                        inMonthGlobalOffDaysSetting.push("" +val.date);
                    });
                }

                // Go to each element to set style for a day in Calendar with a specific style if it is an off day or holiday.
                $('td.fc-widget-content').each(function(){
                    // only get days in this month.
                    if (!$(this).hasClass('fc-other-month')){
                        if ($(this).has('div').has('.fc-day-number')){
                            for (i=0; i < inMonthGlobalOffDaysSetting.length; i++){
                                if ($(this).has('div').has('.fc-day-number').text().trim() == inMonthGlobalOffDaysSetting[i].toUpperCase().trim()){
                                    setCellOfDayInFullCalendar($(this), "disabled", "calendar_cell_holiday", true);
                                    break;
                                }
                            }
                        }
                    }
                });

                // load off days for each week setting
                inWeekOffDaysSetting = new Array();
                if (null != values.offDaysInWeekJSON){
                    $(values.offDaysInWeekJSON).each(function(ind,val){
                        if (val.SUN){
                            $('td.fc-sun').each(function(){
                                setCellOfDayInFullCalendar($(this), "disabled", "calendar_cell_holiday", true);
                                inWeekOffDaysSetting.push(SUN);
                            });
                        }else if (val.MON){
                            $('td.fc-mon').each(function(){
                                setCellOfDayInFullCalendar($(this), "disabled", "calendar_cell_holiday", true);
                                inWeekOffDaysSetting.push(MON);
                            });
                        }else if (val.TUE){
                            $('td.fc-tue').each(function(){
                                setCellOfDayInFullCalendar($(this), "disabled", "calendar_cell_holiday", true);
                                inWeekOffDaysSetting.push(TUE);
                            });
                        }else if (val.WED){
                            $('td.fc-wed').each(function(){
                                setCellOfDayInFullCalendar($(this), "disabled", "calendar_cell_holiday", true);
                                inWeekOffDaysSetting.push(WED);
                            });
                        }else if (val.THU){
                            $('td.fc-thu').each(function(){
                                setCellOfDayInFullCalendar($(this), "disabled", "calendar_cell_holiday", true);
                                inWeekOffDaysSetting.push(THU);
                            });
                        }else if (val.FRI){
                            $('td.fc-fri').each(function(){
                                setCellOfDayInFullCalendar($(this), "disabled", "calendar_cell_holiday", true);
                                inWeekOffDaysSetting.push(FRI);
                            });
                        }else if (val.SAT){
                            $('td.fc-sat').each(function(){
                                setCellOfDayInFullCalendar($(this), "disabled", "calendar_cell_holiday", true);
                                inWeekOffDaysSetting.push(SAT);
                            });
                        }
                    });
                }
            }

            var calendar = $('#calendar').fullCalendar({
                year: selectedDate.getFullYear(),
                month: selectedDate.getMonth() - 1,
//                date: 1,
                buttonText: {
                    prev: '<i class="icon-chevron-left"></i>',
                    next: '<i class="icon-chevron-right"></i>'
                },
                // Set Moday is the first column which will be displayed on the full calendar.
                firstDay: 1,
                dayNamesShort: labelArrayDayofWeek,
                eventColor: '#F7931E',
                buttonText: {
                    today:    labelToday,
                    month:    labelMonth,
                    week:     labelWeek,
                    day:      labelDay
                },
                titleFormat: '',
                header: {
                    left: 'prev,next today',
                    center: 'title',
                    right: 'month,agendaWeek,agendaDay'
                },
                dayRender: function (date, cell, view) {
                    var today = new Date();
                    if (date.getDate() === today.getDate()) {
                        cell.css("background-color", "red");
                    }
                },
//                events: events,
//                editable: true,
//                droppable: true, // this allows things to be dropped onto the calendar !!!
//                drop: function(date, allDay) { // this function is called when something is dropped
//
//                    // retrieve the dropped element's stored Event Object
//                    var originalEventObject = $(this).data('eventObject');
//                    var $extraEventClass = $(this).attr('data-class');
//
//
//                    // we need to copy it, so that multiple events don't have a reference to the same object
//                    var copiedEventObject = $.extend({}, originalEventObject);
//
//                    // assign it the date that was reported
//                    copiedEventObject.start = date;
//                    copiedEventObject.allDay = allDay;
//                    if($extraEventClass) copiedEventObject['className'] = [$extraEventClass];
//
//                    // render the event on the calendar
//                    // the last `true` argument determines if the event "sticks" (http://arshaw.com/fullcalendar/docs/event_rendering/renderEvent/)
//                    $('#calendar').fullCalendar('renderEvent', copiedEventObject, true);
//
//                    // is the "remove after drop" checkbox checked?
//                    if ($('#drop-remove').is(':checked')) {
//                        // if so, remove the element from the "Draggable Events" list
//                        $(this).remove();
//                    }
//
//                }
//                ,
                selectable: true,
                selectHelper: true,
                select: function(start, end, allDay) {
                    if (!allowAdjust){
                        return false;
                    }

                    if (isNotAnOffDay(start)){
                        if (isHandlingRealWorkingPlan){
                            return false;
                        }

                        var selectedDate = $('#calendar').fullCalendar('getDate');

                        // check the date that user clicked on cell of calendar is on same month or not.
                        if (start.getMonth() != selectedDate.getMonth()){
                            var textInfo1 = labelWrongMonthWorkingPlanCreate;
                            var form1 = $("<form class='form-inline'><label>" +textInfo1+ "</label></form>");
                            var div = bootbox.dialog(form1,
                                [
                                    {
                                        "label" : "<i class='icon-ok'></i> " +btnOKText,
                                        "class" : "btn-small btn-success",
                                        "callback" : function(){
                                            isHandlingRealWorkingPlan = false;
                                        }
                                    }
                                ]
                                ,
                                {
                                    // prompts need a few extra options
                                    "onEscape": function(){
                                        div.modal("hide");
                                        isHandlingRealWorkingPlan = false;
                                    }
                                }
                            );
                            // prevent event.
                            return false;
                        }

                        // call ajax check status of working plan.
                        $.ajax({
                            url : contextPath + "ajax/workingplan/realworkingplandetail/checkWorkingPlanFinalStatusByOwner.html",
                            type : "POST",
                            dataType : "json",
                            data : "year=" +selectedDate.getFullYear()+ "&month=" + selectedDate.getMonth(),
                            success : function(res){
                                if (res.status == "CONFIRM" || res.status == "APPROVED"){
                                    // if has confirmed or approved, you can not create working plan detail for this month any more.
                                    return false;
                                }else{
                                    bootbox.createEvent(labelNewMoreWorkingPlanDetail, function(title) {
                                        if (title !== null) {
                                            var isFieldDate = false;
                                            if ($("#subordinatesList option:selected").val() != "-1"){
                                                isFieldDate = true;
                                            }
                                            createDetailWorkingPlan(null, title, start, end, false, selectedDate.getFullYear(), selectedDate.getMonth(), start, end, isFieldDate, true);
                                            $('#planForm').remove();
                                        }
                                    });
                                }
                            }
                        });
                    }

                    $('#calendar').fullCalendar('unselect');

                }
                ,
                eventClick: function(calEvent, jsEvent, view) {
                    if (!allowAdjust){
                        return false;
                    }

                    if (isNotAnOffDay(calEvent.start)){
                        if (isHandlingRealWorkingPlan){
                            return false;
                        }
                        isHandlingRealWorkingPlan = true;
                        var workingPlanDetailID = calEvent.id;
                        var startTimeInMiliseconds = calEvent.start.getTime();
                        var endTimeInMiliseconds = "";
                        if (null != calEvent.end){
                            endTimeInMiliseconds = calEvent.end.getTime();
                        }
                        var workingPlanFinalDetailID = calEvent.id;
                        var selectedDate = $('#calendar').fullCalendar('getDate');

                        $.ajax({
                            url: contextPath + "ajax/whm/workingplan/realworkingplandetail/search.html",
                            type: "POST",
                            data: "pojo.workingPlanFinalDetailID=" +workingPlanFinalDetailID+ "&pojo.selectedMonth=" +selectedDate.getMonth()+
                                "&pojo.selectedYear=" +selectedDate.getFullYear()+ "&startTimeInMiliseconds=" +calEvent.start.getTime()+ "&endTimeInMiliseconds=" +calEvent.end.getTime()+ "&crudaction=search",
                            complete: function(html){
                                var form = $(html.responseText);

                                // disale all elements with cssClass="manual-style" on form when display first.
                                $(form).find('.manual-style').attr("disabled", "disabled");

                                var div = bootbox.dialog(form,
                                    [
                                        {
                                            "id" : "btnConfirmNoChange",
                                            "label" : "<i class='icon-save'></i> " + btnSaveWithoutChangeText,
                                            "class" : "btn-small btn-success btnConfirmWithoutChange",
                                            "callback": function() {
                                                $(form).find('.manual-style').removeAttr("disabled");
                                                var formDatas = $('form[id="detailFinalWorkingPlanForm"]').serialize();
                                                $.ajax({
                                                    type: "POST",
                                                    url: contextPath + "ajax/whm/workingplan/realworkingplandetail/confirm.html",
                                                    data: formDatas,
                                                    complete : function(res){
                                                        isHandlingRealWorkingPlan = false;
                                                        // reset all values before close modal.
                                                        resetAllIsChangedVariables();

                                                        updateRealWorkingPlanSummaryReport();

                                                        $('#detailFinalWorkingPlanForm').remove();
                                                    }
                                                });
                                            }
                                        }
                                        ,
                                        {
                                            "label" : "<i class='icon-hand-left'></i> " +btnBackText,
                                            "class" : "btn-small btn-info btnBack hide",
                                            "callback" : function(){
                                                $('.modal-footer').find('.btnConfirmWithoutChange').show();
                                                $('.modal-footer').find('.btnChange').html("<i class='icon-edit'></i> " +btnSaveChangeText);
                                                $('.modal-footer').find('.btnBack').addClass("hide");
                                                $(form).find('.manual-style').attr("disabled", "disabled");
                                                return false;
                                            }
                                        }
                                        ,
                                        {
                                            "label" : "<i class='icon-edit'></i> " +btnChangeText,
                                            "class" : "btn-small btn-success btnChange",
                                            "callback" : function(){
                                                if ($('.modal-footer').find('.btnConfirmWithoutChange').is(":visible")){
                                                    $('.modal-footer').find('.btnConfirmWithoutChange').fadeOut("slow");
                                                    $('.modal-footer').find('.btnBack').removeClass("hide");
                                                    $('.modal-footer').find('.btnChange').html("<i class='icon-edit'></i> " +btnSaveChangeText);
                                                    $(form).find('.manual-style').removeAttr("disabled");
                                                    return false;
                                                }

                                                var isFieldDate = false;
                                                if ($("#subordinatesList option:selected").val() != "-1"){
                                                    isFieldDate = true;
                                                }
                                                $('#isFieldDate').val(isFieldDate);
                                                $('#selectedMonth').val(selectedDate.getMonth());
                                                $('#selectedYear').val(selectedDate.getFullYear());

                                                $(form).find('.manual-style').removeAttr("disabled");
                                                var formDatas = $('form[id="detailFinalWorkingPlanForm"]').serialize();

                                                $.ajax({
                                                    url: contextPath + "ajax/whm/workingplan/realworkingplandetail/confirm.html",
                                                    type: "POST",
                                                    data: formDatas,
                                                    complete: function(){
                                                        updateRealWorkingPlanSummaryReport();

                                                        // update event title on calendar for specific event.
                                                        var selectedFullName =  $("#subordinatesList option:selected").text().trim();
                                                        var suffixTitleEvent = "";
//                                                        if ($("#subordinatesList option:selected").val() != "-1"){
//                                                            suffixTitleEvent = " - " + selectedFullName.substring(selectedFullName.lastIndexOf(" "), selectedFullName.length) + " [" +$('#userCode').text()+ "]";
//                                                        }
                                                        calEvent.title = form.find("#detailWorkingPlanName").val() + suffixTitleEvent;
                                                        $('#calendar').fullCalendar('updateEvent', calEvent);

                                                        isHandlingRealWorkingPlan = false;

                                                        // reset all values before close modal.
                                                        resetAllIsChangedVariables();

                                                        updateRealWorkingPlanSummaryReport();

                                                        $('#detailFinalWorkingPlanForm').remove();
                                                    }
                                                });
                                            }
                                        },
                                        {
                                            "label" : "<i class='icon-remove'></i> " +btnCloseText,
                                            "class" : "btn-small btn-warning",
                                            "callback" : function(){
                                                isHandlingRealWorkingPlan = false;

                                                // reset all values before close modal.
                                                resetAllIsChangedVariables();

                                                $('#detailFinalWorkingPlanForm').remove();
                                            }
                                        }
                                    ]
                                    ,
                                    {
                                        // prompts need a few extra options
                                        "onEscape": function(){
                                            isHandlingRealWorkingPlan = false;
                                            $('#detailFinalWorkingPlanForm').remove();
                                            div.modal("hide");
                                        }
                                    }
                                );

                                div.on("shown", function() {
                                    // Append option to select menu each time user choose a day on full calendar to create new working plan detail.
                                    $.each(subordinateJSONObj, function(key, item){
                                        $('#subordinatesList').append($('<option>', {
                                            code: item.userCode,
                                            text : item.fullname,
                                            value : item.userID,
                                            selected : item.userID == eval(loadedUserID) ? true : false
                                        }));
                                    });
                                });

                                form.on('submit', function(){
                                    calEvent.title = form.find("input[type=text]").val();
                                    calendar.fullCalendar('updateEvent', calEvent);
                                    div.modal("hide");
                                    return false;
                                });
                            }
                        });
                    }
                }
                ,

                //hien thi ??
                viewDisplay: function(view) {
                    var selectedDate = $('#calendar').fullCalendar('getDate');
                    var currentMonth = selectedDate.getMonth() + 1;

                    if (currentMonth < 10){
                        currentMonth = "0" + currentMonth;
                    }

                    // update variable selectedCalendarMonth to use when click on buttons of footer.
                    selectedCalendarMonth = currentMonth;
                    selectedCalendarYear = selectedDate.getFullYear();

                    // update label month on form.
                    $('#currentMonth').text(selectedDate.getFullYear() + "/" + currentMonth);

                    isHandlingRealWorkingPlan = false;
                    // handle when click prev or next to go other month on full calendar.
                    var selectedDate = $('#calendar').fullCalendar('getDate');

                    // update page title label
                    var pageTitleText = "";
                    if (eval(currentStep) == 1){
                        pageTitleText = labelStepPageTitle_1 + " " + selectedCalendarMonth + "/" + selectedCalendarYear;
                    }else if (eval(currentStep) == 2){
                        pageTitleText = labelStepPageTitle_2 + " " + selectedCalendarMonth + "/" + selectedCalendarYear;
                    }else if (eval(currentStep) == 3){
                        pageTitleText = labelStepPageTitle_3;
                    }
                    $('#pageTitle').text(pageTitleText);

                    $.ajax({
                        url: contextPath + "ajax/workingplan/realworkingplandetail/getEvents.html",
                        dataType: "json",
                        data: "year=" +selectedDate.getFullYear()+ "&month=" + selectedDate.getMonth(),
                        async: false,
                        success: function(res){
                            // remove all events on Full Calendar before load news.
                            $('#calendar').fullCalendar( 'removeEvents', function(event) {return true});

                            // check error message from server.
                            if (null != res ){
                                if(null != res.message){
                                    if (res.message != ""){
                                        // has error
//                                        var form = $("<form class='form-inline'><label>" +res.message+ "</form>");
//                                        var div = bootbox.dialog(form,
//                                            [
//                                                {
//                                                    "label" : "<i class='icon-ok'></i> " +btnSaveWithoutChangeText,
//                                                    "class" : "btn-small btn-primary"
//                                                }
//                                            ]
//                                            ,
//                                            {
//                                                // prompts need a few extra options
//                                                "onEscape": function(){
//                                                    div.modal("hide");
//                                                }
//                                            }
//                                        );
                                    }else{
                                        // no error. All fine!

                                        // Call ajax to get real working plan title.
                                        $.ajax({
                                            url : contextPath + "ajax/whm/workingplan/realworkingplandetail/getRealWorkingPlanTitle.html",
                                            data: "year=" +selectedDate.getFullYear()+ "&month=" +selectedDate.getMonth(),
                                            type : "POST",
                                            dataType : "json",
                                            success : function(res){
                                                if (null != res){
                                                    if(null != res.title && res.title.length > 0){
                                                        // update working plan title on calendar.
                                                        $('#realWorkingPlanTitle').text(res.title);
                                                    }
                                                }
                                            }

                                        });

                                        // Call ajax to check status of btnConfirmRealWorkingPlan on calendar.
                                        $.ajax({
                                            url : contextPath + "ajax/workingplan/checkRealWorkingPlanStatusByOwner.html",
                                            dataType : "json",
                                            type : "POST",
                                            data: "year=" +selectedDate.getFullYear()+ "&month=" + selectedDate.getMonth(),
                                            success : function(res){
                                                if (!res.noItem){
                                                    if (res.status == "CONFIRM" || res.status == "APPROVED"){
                                                        $('#btnConfirmRealWorkingPlan').attr("disabled", "disabled");
                                                    }else{
                                                        $('#btnConfirmRealWorkingPlan').removeAttr("disabled");
                                                    }
                                                }else{
                                                    $('#btnConfirmRealWorkingPlan').attr("disabled", "disabled");
                                                }
                                            }
                                        });

                                        // Load all registered working plan details to the calendar.
                                        var events = [];
                                        $(res.results).each(function(ind,val){
                                            var startTime = new Date(val.start);
                                            var endTime = new Date(val.end);
                                            var event = {
                                                title: val.title,
                                                start: new Date(startTime.getFullYear(), startTime.getMonth(), startTime.getDate(), startTime.getHours(), startTime.getMinutes(), startTime.getSeconds()),
                                                end: new Date(endTime.getFullYear(), endTime.getMonth(), endTime.getDate(), endTime.getHours(), endTime.getMinutes(), endTime.getSeconds()),
                                                borderColor: "#000",
                                                allDay: true ,
                                                id: val.id
                                            };

                                            // load event to Full Calendar right now.
                                            $('#calendar').fullCalendar( 'renderEvent', event );

                                        });
                                    }
                                }
                            }

                            // load holiday events to calendar.
                            if (null != res.eventsOffDaysInMonth){
                                $(res.eventsOffDaysInMonth).each(function(ind,val){
                                    var startTime = new Date(val.start);
                                    var endTime = new Date(val.end);
                                    var event = {
                                        title: val.title,
                                        start: new Date(startTime.getFullYear(), startTime.getMonth(), startTime.getDate(), startTime.getHours(), startTime.getMinutes(), startTime.getSeconds()),
                                        end: new Date(endTime.getFullYear(), endTime.getMonth(), endTime.getDate(), endTime.getHours(), endTime.getMinutes(), endTime.getSeconds()),
                                        borderColor: "#000",
                                        allDay: true ,
                                        id: val.id
                                    };

                                    // load event to Full Calendar right now.
                                    $('#calendar').fullCalendar( 'renderEvent', event );

                                });
                            }

                            // paints the days cells
                            onRenderCallDay(view, res);
                        }
                    });

                    updateRealWorkingPlanSummaryReport();
                }
            });
//        }
//    });
    function isNotAnOffDay(selectedDate){
        // check this date is a day off or holiday before edit working plan detail, if true, prevent it.
        if (null != inMonthGlobalOffDaysSetting){
            if (inMonthGlobalOffDaysSetting.length > 0){
                for (i=0; i < inMonthGlobalOffDaysSetting.length; i++){
                    if (selectedDate.getDate() == inMonthGlobalOffDaysSetting[i].toUpperCase().trim()){
                        // prevent event.
                        return false;
                    }
                }
            }
        }
        return true;
    }
})
