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
            <div style="text-align: center;color:white;text-transform: uppercase;line-height: 45px;"><fmt:message key="title.dashboard"/></div>
        </li>
        <li class="top-nav-right"></li>
    </ul>
    <div class="clear"></div>
</div>
<div id="sidebar" class="data-page">
    <div class="toggle_header">
        <div class="toggle_icon">
            <a onclick="toggleSidebar()">
                <span class="sc-icon-filter sc-icon"></span>
                <span class="text">Filter</span>
            </a>
        </div>
    </div>
    <div class="toggle_content">
        <div class="row-fluid">
            <form id="dashboardForm" action="dashboard.html" method="GET">

            </form>
        </div>
    </div>
    <div class="clear siderbar_footer"></div>
</div>
<div class="container-fluid">
    <div class="row-fluid" style="margin-top: 40px;">
        <div class="span6">
            <div class="sc-teacher-box myCorner sc-teacher-dashboard-box sc-teacher-box-student-alert" data-corner="5px" style="margin-top: 0px;">
                <div class="header">
                    <div class="sc-workingplan-alert-icon" id="classAlertNumber"></div>
                    <div class="sc-title"><fmt:message key="dcdt.dashboard.workingplan"/></div>
                    <div class="clear"></div>
                </div>
                <div id="header-table-classAlert" class="sc-teacher-dashboard-box-title">
                    <div style="width:70%;float:left; text-indent: 11px;"><fmt:message key="dcdt.dashboard.workingplan.content"/></div>
                    <div style="width:30%;float:left;text-align: center" ><fmt:message key="dcdt.dashboard.workingplan.duedate"/></div>
                </div>
                <div class="body" id="workingPlanAlerts">
                    <display:table id="classAlertTable" name="workingPlanAlerts" cellspacing="0" cellpadding="0" pagesize="${fn:length(workingPlanAlerts)}"
                                   partialList="true" sort="external" size="${fn:length(workingPlanAlerts)}" requestURI="${url}"
                                   uid="tableList" class="table sc-teacher-dashboard-table table-striped table-hover with-check" export="false">
                        <display:column headerClass="table_header" titleKey=""  sortable="false" class="asgn-title" style="width: 30%%; text-indent: 4px;">
                            <a>${tableList.content}</a>
                        </display:column>
                        <display:column headerClass="table_header" titleKey=""  sortable="false" class="asgn-title" style="width: 20%; padding : 8px 8px 8px 1px;text-align: center;">
                            ${tableList.duedate}
                        </display:column>
                        <display:setProperty name="paging.banner.all_items_found" value=""/>
                        <display:setProperty name="paging.banner.one_item_found" value=""/>
                        <display:setProperty name="paging.banner.no_item_found" value=""/>
                        <display:setProperty name="basic.msg.empty_list_row">
                            <tr class="empty">
                                <td colspan="2"><fmt:message key='alert.workingplan.msg.no' /></td>
                            </tr>
                            </tr>
                        </display:setProperty>
                    </display:table>
                </div>
            </div>
        </div>
        <div class="span6">
            <div class="sc-teacher-box myCorner sc-teacher-dashboard-box sc-teacher-box-student-alert" data-corner="5px" style="margin-top: 0px;">
                <div class="header">
                    <div class="sc-assessment-alert-icon" id="studentAlertNumber"></div>
                    <div class="sc-title"><fmt:message key="dcdt.dashboard.assessment"/></div>
                    <div class="clear"></div>
                </div>
                <div id="header-table-studentAlert" class="sc-teacher-dashboard-box-title">
                    <div style="width:70%;float:left; text-indent: 7px;"><fmt:message key="dcdt.dashboard.assessment.distributor"/></div>
                    <div style="width:30%;float:left;text-align: center"><fmt:message key="dcdt.dashboard.assessment.duedate"/></div>
                </div>
                <div class="body" id="assessmentAlerts">
                    <display:table id="studentAlertTable" name="assessmentAlerts" cellspacing="0" cellpadding="0" pagesize="${fn:length(assessmentAlerts)}"
                                   partialList="true" sort="external" size="${fn:length(assessmentAlerts)}" requestURI="${url}"
                                   uid="tableList" class="table sc-teacher-dashboard-table table-striped table-hover with-check" export="false" style="width:100%">
                        <display:column headerClass="table_header header_name" titleKey=""  sortable="false" class="asgn-title" style="width: 70%;">
                            <a>${tableList.firstName}&nbsp;${tableList.distributor}</a>
                        </display:column>
                        <display:column headerClass="table_header header_standard" titleKey=""  sortable="false" class="asgn-title" style="width: 30%; text-align:center;">
                            ${tableList.duedate}
                        </display:column>
                        <display:setProperty name="paging.banner.all_items_found" value=""/>
                        <display:setProperty name="paging.banner.one_item_found" value=""/>
                        <display:setProperty name="paging.banner.no_item_found" value=""/>
                        <display:setProperty name="basic.msg.empty_list_row">
                            <tr class="empty">
                                <td colspan="2"><fmt:message key='alert.assessmnet.msg.no' /></td>
                            </tr>
                            </tr>
                        </display:setProperty>
                    </display:table>
                </div>
            </div>
        </div>
    </div>

</div>
<script type="text/javascript" src="<c:url value='/scripts/jquery/jquery.mousewheel.js'/>"></script>
<script src="<c:url value="/themes/dcdt/scripts/bootstrap/jscrollpane.js"/>"></script>
<script language="javascript">
    function submitForm() {
        $('#dashboardForm').submit();
    }
    $(function(){
        $('#workingPlanAlerts').jScrollPane();
        $('#assessmentAlerts').jScrollPane();
    });

</script>

</body>