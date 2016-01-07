<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/common/taglibs.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
    <%@ include file="/common/meta.jsp" %>
    <title><fmt:message key="webapp.name"/>&trade;&nbsp;-&nbsp;<decorator:title/></title>

    <link rel="stylesheet" type="text/css" media="all"
          href="<c:url value='/styles/${appConfig["csstheme"]}/theme.css'/>"/>
    <link rel="stylesheet" type="text/css" media="print"
          href="<c:url value='/styles/${appConfig["csstheme"]}/print_v1.2.css'/>"/>
    <link rel="stylesheet" type="text/css"
          href="<c:url value='/styles/${appConfig["csstheme"]}/style.css'/>"/>
    <link rel="stylesheet" type="text/css"
          href="<c:url value='/styles/${appConfig["csstheme"]}/jquery-lightness/jquery-ui-1.8.10.css'/>"/>
    <link rel="stylesheet" type="text/css" media="all"
          						href="<c:url value='/styles/${appConfig["csstheme"]}/jquery.alerts.css'/>"/>
    <script type="text/javascript" src="<c:url value="/scripts/jquery/jquery-1.8.2.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/scripts/jquery/jquery-ui.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value='/scripts/jquery/jquery.alerts.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/scripts/global.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/scripts/common_v1_5.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/scripts/whm_v1.2.js'/>"></script>
    <script type="text/javascript" src="<c:url value="/themes/whm/scripts/bootstrap/bootstrap-datepicker_v1.0.js"/>"></script>
    <script src="<c:url value="/themes/whm/scripts/bootstrap/jquery.formatCurrency-1.4.1.js"/>"></script>
    <decorator:head/>
</head>
<body<decorator:getProperty property="body.id" writeEntireProperty="true"/><decorator:getProperty property="body.class"
                                                                                                  writeEntireProperty="true"/>>
<c:set var="currPage" scope="request"><decorator:getProperty property="body.id"/></c:set>
<div id="page">

    <div id="header">
        <jsp:include page="/common/header.jsp"/>
    </div>

    <div id="maincontent">
        <%--<div id="leftpane">--%>
            <%--<jsp:include page="/common/report_menu.jsp"/>--%>
        <%--</div>--%>
        <div id="mainpane">
            <decorator:body/>
        </div>
        <div class="clear"></div>
    </div>
    <div id="footer" class="clearfix">
        <jsp:include page="/common/footer.jsp"/>
    </div>

</div>
</body>
</html>
