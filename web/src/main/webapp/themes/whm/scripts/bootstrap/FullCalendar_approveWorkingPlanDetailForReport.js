jQuery(function($) {

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

    function checkSelectedDateIsOffDay(selectedDate){
        if (null != inMonthGlobalOffDaysSetting){
            for (i=0; i < inMonthGlobalOffDaysSetting.length; i++){
                if (selectedDate.getDate() == inMonthGlobalOffDaysSetting[i].toUpperCase().trim()){
                    return true;
                }
            }
        }

        if (null != inWeekOffDaysSetting){
            if (inWeekOffDaysSetting.length > 0){
                for (i=0; i < inWeekOffDaysSetting.length; i++){
                    if (selectedDate.getDay() == inWeekOffDaysSetting[i]){
                        return true;
                    }
                }
            }
        }

        return false;
    }

    function updateTableReportSummary(selectedYear, selectedMonth){
        // Call ajax to calculate status summary of selected date.
        $.ajax({
            url : contextPath + "ajax/whm/workingplan/calculateWorkingPlanStatus.html",
            dataType: "json",
            data: "year=" +selectedYear+ "&month=" +selectedMonth+ "&userID=" +subordinateID,
            success: function(res){
                if (null != res){
                    if (null != res.numOfWorkingDaysInMonth){
                        $('#numOfWorkingDaysInMonth').text(res.numOfWorkingDaysInMonth);
                    }
                    if (null != res.numOfStandardizedFieldDays){
                        $('#numOfStandardizedFieldDays').text(res.numOfStandardizedFieldDays);
                    }
                    if (null != res.numOfPlannedFieldDays){
                        $('#numOfFieldDaysOfPlan').text(res.numOfPlannedFieldDays);
                    }
                    if (null != res.resultStatus){
                        $('#resultStatus').text(res.resultStatus);
                    }
                    if (null != res.standardizedStatus){
                        if(res.standardizedStatus){
                            $('#summaryStatusTable').css("background-color", "lightgreen");
                            standardizedStatus = true;
                        }else{
                            $('#summaryStatusTable').css("background-color", "#06A8F1");
                            standardizedStatus = false;
                        }
                    }
                }
            }
        });
    }

    var calendar = $('#calendar').fullCalendar({
        year: selectedYearToView,
        month: selectedMonthToView,
        buttonText: {
            prev: '<i class="icon-chevron-left"></i>',
            next: '<i class="icon-chevron-right"></i>'
        },
        // Set Moday is the first column which will be displayed on the full calendar.
        firstDay: 1,
        dayNamesShort: labelArrayDayofWeek,
        buttonText: {
            today:    labelToday,
            month:    labelMonth,
            week:     labelWeek,
            day:      labelDay
        },
        titleFormat: '',
        eventColor: '#F7931E',
        header: {
            left: 'today',
            center: 'title',
            right: 'month,agendaWeek,agendaDay'
        },
//        editable: true,
        droppable: true, // this allows things to be dropped onto the calendar !!!
        selectable: true,
        selectHelper: true,
        select: function(start, end, allDay) {
            return false;
            if (isHandlingPlanListWaitingApprove){
                return false;
            }
            isHandlingPlanListWaitingApprove = true;

            if (checkSelectedDateIsOffDay(start)){
                var textInfo = alertMsgCreateWorkingPlanOnOffDay;
                var form = $("<form class='form-inline'><label>" +textInfo+ "</label></form>");

                var div = bootbox.dialog(form,
                    [
                        {
                            "label" : "<i class='icon-ok'></i> " +btnOKText,
                            "class" : "btn-small btn-success",
                            "callback" : function(){
                                isHandlingPlanListWaitingApprove = false;
                            }
                        }
                    ]
                    ,
                    {
                        // prompts need a few extra options
                        "onEscape": function(){
                            isHandlingPlanListWaitingApprove = false;
                            div.modal("hide");
                        }
                    }
                );

                // prevent event.
                return false;
            }else{
                bootbox.createEvent(labelNewWorkingPlanDetail, subordinateID, function(title) {
                    if (title !== null) {
                        var date = $('#calendar').fullCalendar('getDate');
                        var isFieldDate = false;
                        if ($("#subordinatesList option:selected").val() != "-1"){
                            isFieldDate = true;
                        }

                        createDetailWorkingPlan(subordinateID, title, start, end, allDay, date.getFullYear(), date.getMonth(), start, end, isFieldDate);
                        $('#planForm').remove();
                    }
                });

                calendar.fullCalendar('unselect');
            }
        }
        ,
        eventClick: function(calEvent, jsEvent, view) {
            return false;
            if (isHandlingPlanListWaitingApprove){
                return false;
            }
            isHandlingPlanListWaitingApprove = true;

            if (checkSelectedDateIsOffDay(calEvent.start)){
                // prevent event.
                isHandlingPlanListWaitingApprove = false;
                return false;
            }else{
                var workingPlanDetailID = calEvent.id;
                var startTimeInMiliseconds = calEvent.start.getTime();
                var endTimeInMiliseconds = "";
                if (null != calEvent.end){
                    endTimeInMiliseconds = calEvent.end.getTime();
                }

                var selectedDate = $('#calendar').fullCalendar('getDate');

                var workingPlanDetailID = calEvent.id;
                $.ajax({
                    url: contextPath + "ajax/whm/workingPlanDetail/search.html",
                    data: "pojo.workingPlanDetailID=" +workingPlanDetailID+ "&crudaction=search",
                    type: "POST",
                    complete: function(html){
                        var form = $(html.responseText);

                        var div = bootbox.dialog(form,
                            [
                                {
                                    "label" : "<i class='icon-save'></i> " +btnOKText,
                                    "class" : "btn-small btn-success",
                                    "callback": function() {
                                        var isFieldDate = false;
                                        if ($("#subordinatesList option:selected").val() != "-1"){
                                            isFieldDate = true;
                                        }
                                        $('#isFieldDate').val(isFieldDate);
                                        var formDatas = $('form[id="detailWorkingPlanForm"]').serialize();
                                        $.ajax({
                                            type: "POST",
                                            url: contextPath + "ajax/whm/workingPlanDetail/edit.html",
                                            data: formDatas,
                                            async: false,
                                            success: function(res){
                                                if (null != res){
                                                    if (null != res.success){
                                                        if (res.success){
                                                            // update event title on calendar for specific event.
                                                            var suffixTitleEvent= "";
                                                            var selectedFullName =  $("#subordinatesList option:selected").text().trim();
                                                            if ($("#subordinatesList option:selected").val() != "-1"){
                                                                suffixTitleEvent = " - " + selectedFullName.substring(selectedFullName.lastIndexOf(" "), selectedFullName.length) + " [" +$('#userCode').text()+ "]";
                                                            }
                                                            calEvent.title = form.find("#detailWorkingPlanName").val() + suffixTitleEvent;
                                                            calendar.fullCalendar('updateEvent', calEvent);

                                                            $('#info').html("<div class='alert alert-success' style='margin-top: 10px;'>"
                                                                + "<button type='button' class='close' data-dismiss='alert'>&times;</button>"
                                                                + "<span>" + labelEditSuccess + "</span>"
                                                                +"</div>");
                                                        }else{
                                                            $('#info').html("<div class='alert alert-error' style='margin-top: 10px;'>"
                                                                + "<button type='button' class='close' data-dismiss='alert'>&times;</button>"
                                                                + "<span>" + labelEditFailed + "</span>"
                                                                +"</div>");
                                                        }

                                                        // call function to update table summary
                                                        updateTableReportSummary(selectedDate.getFullYear(), selectedDate.getMonth());

                                                        // need to remove form which loaded by call ajax each time click on event on calendar to clear encoded data of form before.
                                                        $('#detailWorkingPlanForm').remove();
                                                        div.modal("hide");
                                                        isHandlingPlanListWaitingApprove = false;
                                                        return false;
                                                    }
                                                }
                                            }
                                        });
                                    }
                                }
                                ,
                                {
                                    "label" : "<i class='icon-trash'></i> " +btnDeleteText,
                                    "class" : "btn-small btn-danger",
                                    "callback": function() {
                                        var workingPlanDetailID = $('#workingPlanDetailID').val();
                                        $.ajax({
                                            url: contextPath + "ajax/whm/workingPlanDetail/edit.html",
                                            type: "POST",
                                            data: "pojo.workingPlanDetailID=" +workingPlanDetailID+ "&crudaction=delete",
                                            async: false,
                                            success: function(res){
                                                if (null != res){
                                                    if(res.success){
                                                        $('#detailWorkingPlanForm').remove();
                                                        isHandlingPlanListWaitingApprove = false;
                                                        calendar.fullCalendar('removeEvents' , function(ev){
                                                            return (ev._id == calEvent._id);
                                                        })

                                                        // call function to update table summary
                                                        updateTableReportSummary(selectedDate.getFullYear(), selectedDate.getMonth());
                                                    }
                                                }
                                            }
                                        });
                                    }
                                }
                                ,
                                {
                                    "label" : "<i class='icon-remove'></i> " +btnCancelText,
                                    "class" : "btn-small btn-warning",
                                    "callback" : function(){
                                        $('#detailWorkingPlanForm').remove();
                                        isHandlingPlanListWaitingApprove = false;
                                    }
                                }
                            ]
                            ,
                            {
                                // prompts need a few extra options
                                "onEscape": function(){
                                    $('#detailWorkingPlanForm').remove();
                                    isHandlingWorkingPlan = false;
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
        viewDisplay: function(view) {
            var selectedDate = $('#calendar').fullCalendar('getDate');
            var currentMonth = selectedDate.getMonth() + 1;
            if (currentMonth < 10){
                currentMonth = "0" + currentMonth;
            }

            // update label month on form.
            $('#currentMonth').text(selectedDate.getFullYear() + "/" + currentMonth);

            isHandlingPlanListWaitingApprove = false;
            // handle when click prev or next to go other month on full calendar.
//            var selectedDate = $('#calendar').fullCalendar('getDate');

            // update page title label
//            $('#pageTitle').text(labelPageTittle + " " + (eval(selectedMonthToView) + 1));
            $('#pageTitle').text(labelPageTittle);

            // call function to update table summary
            updateTableReportSummary(selectedDate.getFullYear(), selectedDate.getMonth());

            $.ajax({
                url: contextPath +"ajax/workingplandetail/searchEventsByOwnerIDInDateForReport.html",
                dataType: "json",
                type: "POST",
                data: "ownerID=" +$('#ownerID').val()+ "&year=" +selectedYearToView+ "&month=" + selectedMonthToView,
                success: function(res){
                    // remove all events on Full Calendar before load news.
                    $('#calendar').fullCalendar( 'removeEvents', function(event) {return true});

                    var eventResults = res.results;

                    // Call ajax check status of working plan to disable btnReject and btnApprove or not if them performed before.
                    $.ajax({
                        url : contextPath + "ajax/workingplan/checkWorkingPlanStatusByOwner.html",
                        type : "POST",
                        dataType : "json",
                        data: "ownerID=" +$('#ownerID').val()+ "&year=" +selectedYearToView+ "&month=" +selectedMonthToView,
                        success : function(res){
                            //alert(res.status);
                            //if (res.status != "CONFIRM"){
//                                $('.manual-style').attr("disabled", "disabled");
                            //}else{
                                // load working plan details to Full Calendar right now.
                                $('.manual-style').removeAttr("disabled");
                                var events = [];
                                $(eventResults).each(function(ind,val){
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

                                    $('#calendar').fullCalendar( 'renderEvent', event );

                                });
                            //}
                        }
                    });

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
                                allDay: val.allDay ,
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
        }

    });


})