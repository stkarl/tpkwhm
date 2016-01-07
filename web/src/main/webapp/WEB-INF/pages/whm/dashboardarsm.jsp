<%@ include file="/common/taglibs.jsp" %>
<head>
    <title><fmt:message key="title.dashboard"/></title>
    <meta name="heading" content="<fmt:message key='title.dashboard'/>"/>
    <link rel="stylesheet" type="text/css" media="all" href="<c:url value='/themes/dcdt/css/jquery.jscrollpane.css'/>" />
</head>
<body>
<div id="top-nav">
    <ul>
        <li class="top-nav-left"></li>
        <li class="top-nav-main">
            <marquee>
            <div style="text-align: center;color:red;text-transform: uppercase;line-height: 45px;"><fmt:message key="title.dashboard"/></div>
            </marquee>
        </li>
        <li class="top-nav-right"></li>
    </ul>
    <div class="clear"></div>
</div>
<div class="container-fluid" style="width:95%">
    <div class="row-fluid" style="margin-top: 40px;">
        <div class="span6">
            <div class="icon_box myCorner">
                <div class="icon_edcd"></div>
                <div class="box_text2">
                    <a href="<c:url value='/dcdt/assessmentcapacity/list.html'/>"><fmt:message key="dcdt.tools.edcd.title"/></a>
                    <fmt:message key="dcdt.tools.edcd"/>
                </div>
            </div>
        </div>
        <div class="span6">
            <div class="icon_box myCorner">
                <div class="icon_workingplan"></div>
                <div class="box_text2">
                    <a href="<c:url value='/dcdt/workingplan/reportworkingplanregisterstatus/list.html'/>"><fmt:message key="dcdt.tools.workingplan.title"/></a>
                    <fmt:message key="dcdt.tools.workingplan"/>
                </div>
            </div>
        </div>
    </div>
    <div class="row-fluid" style="margin-top: 40px;">
        <div class="span6">
            <div class="icon_box myCorner">
                <div class="icon_etargetsetting"></div>
                <div class="box_text2">
                    <a href="#"><fmt:message key="dcdt.tools.etargetsetting.title"/></a>
                    <fmt:message key="dcdt.tools.etargetsetting"/>
                </div>
            </div>
        </div>
        <div class="span6">
            <div class="icon_box myCorner">
                <div class="icon_scorecard"></div>
                <div class="box_text2">
                    <security:authorize ifAnyGranted="SE">
                    <a href="<c:url value='/dcdt/scorecard/list.html'/>"><fmt:message key="dcdt.tools.scorecard.title"/></a>
                    </security:authorize>
                    <security:authorize ifAnyGranted="ASM,RSM,AUDITOR">
                        <a href="<c:url value='/dcdt/scorecard/yearSubmitReport.html'/>"><fmt:message key="dcdt.tools.scorecard.title"/></a>
                    </security:authorize>
                    <fmt:message key="dcdt.tools.scorecard"/>
                </div>
            </div>
        </div>
    </div>
    <div class="row-fluid" style="margin-top: 40px;">
        <div class="span6">
            <div class="icon_box myCorner">
                <div class="icon_ebar"></div>
                <div class="box_text2">
                    <a href="<c:url value='/dcdt/edttool.html'/>"><fmt:message key="dcdt.tools.ebar.title"/></a>
                    <fmt:message key="dcdt.tools.ebar"/>
                </div>
            </div>
        </div>
        <div class="span6">
            <div class="icon_box myCorner">
                <div class="icon_elearning"></div>
                <div class="box_text2">
                    <a href="<c:url value='/dcdt/elearning/declare.html'/>"><fmt:message key="dcdt.tools.elearning.title"/></a>
                    <fmt:message key="dcdt.tools.elearning"/>
                </div>
            </div>
        </div>
    </div>

</div>


</body>