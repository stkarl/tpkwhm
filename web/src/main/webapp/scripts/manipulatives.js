// Drag and drop manipulatives
function dragging (){
    //document.getElementById('tooloverlay').style.cursor = "url('assets/dragdrop.cur'),move";
}

$(document).ready(function(){
    //Counter
    start_offset_left = 0;
    start_offset_top = 0;
    counter = 0;
    selectedColor = 'black';
    selectedIndex = 0;
    xorigin = -1;
    yorigin = -1;
    //Make element draggable
    $(".drag").draggable({
        helper:'clone',
        zIndex : 700,
        appendTo: "#tooloverlay"
    });
    
    //Make element droppable
    $("#tooloverlay").droppable({
      drop: function(ev, ui) {
        var element=$(ui.draggable).clone();
        if (!element.hasClass("unDroppable")) {
          counter++;  
          selectedIndex = counter;
          var top = ui.position.top;
          var left = ui.position.left;
          if (element.hasClass("typing_text")) {
            element = $("<div id='clonediv"+counter+"' class='drag' onmousedown='javascript:dragging();' style='float:left' ><span style='color:"+selectedColor+"'>(click the icon to edit text)</span><a href='javascript:void(0);' ontouchstart='changeText(\""+selectedIndex+"\");' onclick='changeText(\""+selectedIndex+"\")'><img src='/content/images/icons/edit.png' border='0' /></a></div>");
            
            var toolbar_text_left = left + start_offset_left;
            var toolbar_text_top = top + start_offset_top;
            $("#toolbar-text").css({'position':'absolute', 'top': toolbar_text_top, 'left': toolbar_text_left });
            $("#toolbar-text").show();
            $("#toolbar_text_input").focus();
          }
          
          element.css('position', 'absolute');
          element.css('top', top);
          element.css('left', left);
          element.addClass("unDroppable");
          element.draggable({
                          zIndex : 700
                  });
          
          $(this).append(element);
        }
      }
    });
});
    
function changeText(index){
	selectedIndex = index;
  var element = $("#clonediv"+index);
	var str = element.find("span").html().replace(/<br\/>|<br>/g, "\n");
	$("#toolbar_text_input").val(str);
	var toolbar_text_left = parseInt(element.css('left').replace("px", "")) + start_offset_left;
	var toolbar_text_top = parseInt(element.css('top').replace("px", "")) + start_offset_top;
	$("#toolbar-text").css({'position':'absolute', 'top':element.css('top'), 'left':toolbar_text_left });
  $("#toolbar-text").show();
  $("#font_size").val(element.find("span").css("font-size"));
  $("#toolbar_text_input").focus();
}

function insert_text() {
  var clonetext = $("#toolbar_text_input").val().replace(/\n/g, "<br/>");
  var fontSize = $("#font_size").val();
  $("#clonediv"+selectedIndex).html("<span style='color:"+selectedColor+";font-size:"+fontSize+"'>"+clonetext+"</span><a href='javascript:void(0);' ontouchstart='changeText(\""+selectedIndex+"\");' onclick='changeText(\""+selectedIndex+"\")'><img src='/content/images/icons/edit.png' border='0' /></a>");
  clear_text();
}

function clear_text() {
  $("#toolbar_text_input").val('');
  $("#toolbar-text").hide('medium');
}

function toggleManip(){
	$("#wrapper").slideToggle(200);
	mode = 1;
	//document.getElementById('container').style.cursor = "move"; //url('assets/grab.cur'),
}

function clearManipulatives(){
	// for ( i = 0 ; i < counter+1 ; i++ ) {
		// $("#clonediv"+i).remove();
	// }
    var strHtml = '<svg id="svgPan" width="${param.tooloverlay_width}" height="100%" style="-ms-touch-action: none;position:absolute;z-index:1000">';
    strHtml += '<rect width="100%" height="100%" fill="none"></rect>';
    strHtml += '</svg>';
    if (/Touch/.test( navigator.userAgent )) {
        $('#tooloverlay').html(strHtml);
    } else {
        $('#tooloverlay').html('');
    }

  counter = 0;
  selectedIndex = 0;
}

function closeToolbar(){
	clearManipulatives();
	turn_off_paint();
	$('#toolbar-options').hide('medium');
	if (/iPad|iPhone/.test( navigator.userAgent )) {
		$('#toolbar').css({'position':'absolute', 'top': '200px', 'left': '800px'});
	} else {
		$('#toolbar').css({'position':'absolute', 'top': '200px', 'left': '1000px'});
	}
  $('#toolbar').toggle('medium');
}

function toggleOptions(){
	$('#toolbar-options').toggle("medium");
//	$('#toolbar-options').animate({
//		marginLeft: parseInt($('#toolbar-options').css('marginLeft'),10) == 0 ? $('#toolbar-options').outerWidth() : 0
//	});
//	if ($('#toolbar-options').is(":visible")) {
//		$('#toolbar-options').hide("slide", { direction: "right" }, 1000);
//	} else {
//		$('#toolbar-options').show("slide", { direction: "right" }, 1000);
//	}
}

function select_color(color) {
  $("img[src*=toolbar_paint_]").each(function() {
    $(this).css({"opacity":1});
  });
  selectedColor = color;
  $("img[src*=toolbar_paint_"+color+"]").each(function() {
	  $(this).css({"opacity":0.3});
  });
}

function paint_onoff() {
  if ($("#paint_onoff_title").html() == "ON") {
    turn_off_paint();
  } else {
    painting();
  }
}

function turn_off_paint() {
	if (/Mozilla\/4.0/.test( navigator.userAgent )) {
		  $("#viewer").contents().enableSelection();
	  }
  $("#paint_onoff_title").html("OFF");
  $("#tooloverlay").unbind("mousemove mousedown mouseup");
  $("#tooloverlay").unbind("touchstart touchmove touchend");
}

function painting() {
  if (/Mozilla\/4.0/.test( navigator.userAgent )) {
    $("#viewer").contents().disableSelection();
  }
  $("#paint_onoff_title").html("ON");
  $("#tooloverlay").bind("mousedown touchstart", function(e) {
	  
    $("#tooloverlay").bind("mousemove touchmove", function(event) {
      
	  if (/iPad|iPhone/.test( navigator.userAgent )) {
        event.which = 1;
        var target = event.originalEvent.targetTouches[0];
        event.pageX = target.clientX;
        event.pageY = target.clientY;
      }
      var x = event.pageX - $(this).position().left;
      var y = event.pageY - $(this).position().top;
      if (xorigin < 0)
    	  xorigin = x;
      if (yorigin < 0)
    	  yorigin = y;
      event.preventDefault();
      $("#tooloverlay").drawLine(xorigin, yorigin, x, y, {stroke: 2, color: selectedColor});
      xorigin = x;
      yorigin = y;
      return false;
    });
    e.preventDefault();
  });
  
  $("#tooloverlay").bind("mouseup touchend", function() {
	  xorigin = -1;
      yorigin = -1;
    $("#tooloverlay").unbind("mousemove touchmove");
  });
  
}

function clear_highlight() {
    if ($("#tooloverlay").is(':hidden')){
        return;
    }
	turn_off_highlight();
	clearManipulatives();
	$("#tooloverlay").hide();
    if (/MSIE 8.0/.test( navigator.userAgent )) {
        $("#tooloverlay_double").hide();
    }
}

function turn_off_highlight() {
	if (/Mozilla\/4.0/.test( navigator.userAgent )) {
		//$("#viewer").contents().enableSelection();
	}
    $("#tooloverlay").unbind("mousemove mousedown mouseup");
    $("#tooloverlay").unbind("touchstart touchmove touchend");
}

function fixPageXY(e) {
    if (e.pageX == null && e.clientX != null ) {
        var html = document.documentElement
        var body = document.body
        e.pageX = e.clientX + (html.scrollLeft || body && body.scrollLeft || 0)
        e.pageX -= html.clientLeft || 0
        e.pageY = e.clientY + (html.scrollTop || body && body.scrollTop || 0)
        e.pageY -= html.clientTop || 0
    }
}


function highlight(hlightColor) {
	if (/Mozilla\/4.0/.test( navigator.userAgent )) {
	    //$("#viewer").contents().disableSelection();
	}
    $("#tooloverlay").show();
    if (/MSIE 8.0/.test( navigator.userAgent )) {
        $("#tooloverlay_double").show();
        $("#tooloverlay_double").height($("#viewer").height());
    }

    $("#tooloverlay").bind("mousedown touchstart", function(e) {

        $("#tooloverlay").bind("mousemove touchmove", function(event) {

	        if (/iPad|iPhone/.test( navigator.userAgent )) {
                event.which = 1;
                var target = event.originalEvent.targetTouches[0];
                event.pageX = target.clientX;
                event.pageY = target.clientY + window.pageYOffset;
            }

            var x = event.pageX - $(this).offset().left;
            var y = event.pageY - $(this).offset().top;
            if (/MSIE 8.0/.test( navigator.userAgent )) {
                fixPageXY(e);
                x = event.pageX - $(this).offset().left;
                y = event.pageY - $(this).offset().top;
            }
            if (xorigin < 0)
    	        xorigin = x;
            if (yorigin < 0)
    	        yorigin = y;
            event.preventDefault();
            $("#tooloverlay").drawLine(xorigin, yorigin, x, y, {stroke: 2, color: hlightColor});
            xorigin = x;
            yorigin = y;
            return false;
        });
        e.preventDefault();
    });

    $("#tooloverlay").bind("mouseup touchend", function() {
	    xorigin = -1;
        yorigin = -1;
        $("#tooloverlay").unbind("mousemove touchmove");
    });
}
