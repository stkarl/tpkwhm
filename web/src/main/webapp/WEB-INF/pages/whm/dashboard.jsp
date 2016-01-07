<%@ include file="/common/taglibs.jsp" %>
<head>
    <title><fmt:message key="title.dashboard"/></title>
    <meta name="heading" content="<fmt:message key='title.dashboard'/>"/>
    <link rel="stylesheet" type="text/css" media="all" href="<c:url value='/themes/whm/css/jquery.jscrollpane.css'/>" />
    <style>
        .classWidth{
            width: 100% !important;
        }
    </style>
</head>
<body>
<div id="top-nav">
    <ul>
        <li class="top-nav-left"></li>
        <li class="top-nav-main">
            <marquee>
            <div style="text-align: center; color:#ffffff ;font-weight: bold;text-transform: uppercase;line-height: 45px;"><fmt:message key="title.dashboard"/></div>
            </marquee>
        </li>
        <li class="top-nav-right"></li>
    </ul>
    <div class="clear"></div>
</div>
<div class="container-fluid" style="width:100%; float :left;">
<div class="container-fluid" style="width:40%; float :left;">
    <div class="row-fluid" style="margin-top: 30px; ">
        <div class="span6 classWidth">
            <div class="icon_box myCorner">
                <div class="icon_edcd"></div>
                <div class="box_text">
                    <a href="<c:url value='/whm/assessmentcapacity/list.html'/>"><fmt:message key="whm.tools.edcd.title"/></a>
                    <fmt:message key="whm.tools.edcd"/>
                </div>
            </div>
        </div>
    </div>
    <div class="row-fluid" style="margin-top: 10px;  ">
        <div class="span6 classWidth">
            <div class="icon_box myCorner">
                <div class="icon_etargetsetting"></div>
                <div class="box_text">
                    <a href="#"><fmt:message key="whm.tools.etargetsetting.title"/></a>
                    <fmt:message key="whm.tools.etargetsetting"/>
                </div>
            </div>
        </div>
    </div>
    <div class="row-fluid" style="margin-top: 10px; ">
        <div class="span6 classWidth">
            <div class="icon_box myCorner">
                <div class="icon_ebar"></div>
                <div class="box_text">
                    <a href="<c:url value='/whm/edttool.html'/>"><fmt:message key="whm.tools.ebar.title"/></a>
                    <fmt:message key="whm.tools.ebar"/>
                </div>
            </div>
        </div>
    </div>
    <div class="row-fluid" style="margin-top: 10px; ">
        <div class="span6 classWidth">
            <div class="icon_box myCorner">
                <div class="icon_workingplan"></div>
                <div class="box_text">
                    <a href="<c:url value='/whm/workingplan/reportworkingplanregisterstatus/list.html'/>"><fmt:message key="whm.tools.workingplan.title"/></a>
                    <fmt:message key="whm.tools.workingplan"/>
                </div>
            </div>
        </div>
    </div>
    <div class="row-fluid" style="margin-top: 10px; ">
        <div class="span6 classWidth">
            <div class="icon_box myCorner">
                <div class="icon_scorecard"></div>
                <div class="box_text">
                    <security:authorize ifAnyGranted="SE">
                        <a href="<c:url value='/whm/scorecard/list.html'/>"><fmt:message key="whm.tools.scorecard.title"/></a>
                    </security:authorize>
                    <security:authorize ifAnyGranted="ASM,RSM,AUDITOR">
                        <a href="<c:url value='/whm/scorecard/yearSubmitReport.html'/>"><fmt:message key="whm.tools.scorecard.title"/></a>
                    </security:authorize>
                    <fmt:message key="whm.tools.scorecard"/>
                </div>
            </div>
        </div>
    </div>
    <div class="row-fluid" style="margin-top: 10px; ">
        <div class="span6 classWidth">
            <div class="icon_box myCorner">
                <div class="icon_elearning"></div>
                <div class="box_text">
                    <a href="<c:url value='/whm/elearning/declare.html'/>"><fmt:message key="whm.tools.elearning.title"/></a>
                    <fmt:message key="whm.tools.elearning"/>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="container-fluid" style="width:50%; float :left;">
    <div class="row-fluid" style="margin-top: 30px; ">
        <div class="span6 classWidth" style="height: 140px;">
            <div class="icon_box myCorner">
                <div class="icon_edcd"></div>

                <div class="box_text" style="height: 120px;">
                    <a href="<c:url value='/whm/assessmentcapacity/list.html'/>"><fmt:message key="whm.tools.edcd.title"/></a>
                    <c:if test="${not empty messageASS}">
                        <span style="color: #55FAE6">${messageASS}</span>
                    </c:if>
                    <c:if test="${empty messageASS}">
                        <span style="color: #55FAE6">No Message</span>
                    </c:if>
                </div>

            </div>
        </div>
    </div>
    <div class="row-fluid" style="margin-top: 10px; ">
        <div class="span6 classWidth" style="height: 140px;">
            <div class="icon_box myCorner">
                <div class="icon_workingplan"></div>
                <div class="box_text" style="height: 120px;">
                    <a href="<c:url value="/whm/workingplan/reportworkingplanregisterstatus/list.html" />"><fmt:message key="whm.tools.workingplan.title"/></a>
                    <c:if test="${not empty messageWKP}">
                        <span style="color: #CA312A">${messageWKP}</span>
                    </c:if>
                    <c:if test="${empty messageWKP}">
                        <span style="color: #CA312A">No Message</span>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
    <div class="row-fluid" style="margin-top: 10px;">
        <div class="span6 classWidth">
            <div class="icon_box myCorner" style="height: 260px;">
                <div class="clear"></div>
                <div style="margin-top: 10px; margin-left: 80px; " class="row-fluid">
                    <div id="placeholder_cate" style="width:300px;height:260px; float: left;"></div>
                    <div id="legend_cate" style="position:relative; float:left;"></div>
                </div>
            </div>
        </div>
    </div>

</div>

</div>


<!--[if lte IE 8]><script src="<c:url value="/themes/whm/scripts/bootstrap/excanvas.min.js"/>"></script><![endif]-->
<script src="<c:url value="/themes/whm/scripts/bootstrap/jquery.flot.js"/>"></script>
<script src="<c:url value="/themes/whm/scripts/bootstrap/jquery.flot.barnumbers.js"/>"></script>
<script src="/themes/whm/scripts/bootstrap/bootstrap-datepicker_v1.0.js"></script>


<script type="text/javascript" language="javascript">

    function decimalToHex(d) {
        var hex = Number(d).toString(16);
        hex = "000000".substr(0, 6 - hex.length) + hex;
        return '#' + hex;
    }

    var colorHexArray = [];
    <c:forEach begin="1" end="10000" step="1" var="m" varStatus="status6">
    colorHexArray['${status6.count}'] =  decimalToHex(${status6.count} * 10000);
    </c:forEach>

    var dataChart_cate = [
        <c:forEach items="${vectors}" var="vector" varStatus="status1">
        {
            "label": "${vector.label}",
            "data": [[${vector.vX}, ${vector.vY}]],
            "color": '#EFFF3A'
        },
        </c:forEach>
    ];

    var ticks_cate = [
        <c:forEach begin="1" end="5" var="i">
        ["${i}", "${i}"],
        </c:forEach>
    ];
    var options_cate = {
        series: {
            points: {
                show: true
            }
        },
        yaxis: {
            min: 0,
            max: ${yMAX + 30}
        },
        xaxis: {
            min: 0,
            max: ${xMAX + 2}
        },
        legend:{
            show: true,
            container: $('#legend_cate'),
            noColumns: 1
        }
    };

    function showTooltip(x,y,contents, colour, label){
        $('<div id="value" title="'+ label +'">' +  contents + '</div>').css( {
            position: 'absolute',
            display: 'block',
            top: y,
            left: x,
            'border-style': 'solid',
            'border-width': '2px',
            'border-color': colour,
            'border-radius': '5px',
            'background-color': '#ffffff',
            color: '#262626',
            padding: '2px'
        }).appendTo("body").fadeIn(200);
    }


    $(document).ready(function() {
        <c:if test="${not empty vectors}">
        var graph = $.plot($('#placeholder_cate'), dataChart_cate, options_cate);

        var points = graph.getData();
        var graphx = $('#placeholder_cate').offset().left;
        graphx = graphx + 30; // replace with offset of canvas on graph
        var graphy = $('#placeholder_cate').offset().top;
        graphy = graphy + 10; // how low you want the label to hang underneath the point
        for(var k = 0; k < points.length; k++){
            for(var m = 0; m < points[k].data.length; m++){
                if(points[k].data[m][0] != null && points[k].data[m][1] != null){
                    showTooltip(graphx + points[k].xaxis.p2c(points[k].data[m][0]) - 15, graphy + points[k].yaxis.p2c(points[k].data[m][1]) - 45,Math.round(points[k].data[m][1])+' /'+ Math.round( points[k].data[m][0]* 100)/100, dataChart_cate[k].color, dataChart_cate[k].label);
                }
            }
        }
        </c:if>
    });
</script>


</body>
