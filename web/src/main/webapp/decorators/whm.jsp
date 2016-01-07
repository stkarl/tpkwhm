<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/common/taglibs.jsp" %>
<%@ page language="java" errorPage="/error.jsp" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
    <%@ include file="/common/meta.jsp" %>
    <title><fmt:message key="webapp.name"/>&trade;&nbsp;-&nbsp;<decorator:title/></title>

    <link rel="stylesheet" href="<c:url value='/themes/whm/bootstrap/bootstrap.css' />" />
    <link rel="stylesheet" href="<c:url value='/themes/whm/bootstrap/bootstrap-responsive.min.css' />" />
    <link rel="stylesheet" href="<c:url value='/themes/whm/bootstrap/font-awesome.min.css' />" />
    <link rel="stylesheet" href="<c:url value='/themes/whm/bootstrap/dropdown.css' />" />

    <link rel="stylesheet" href="<c:url value='/themes/whm/bootstrap/fullcalendar.css' />" />
    <link rel="stylesheet" href="<c:url value='/themes/whm/bootstrap/whm.main_v1.0.css' />"/>
    <link rel="stylesheet" href="<c:url value='/themes/whm/bootstrap/bootstrap-modal.css'/>"/>
    <link rel="stylesheet" href="<c:url value='/themes/whm/bootstrap/displaytag.css'/>"/>
    <link rel="stylesheet" href="<c:url value='/themes/whm/bootstrap/whm.css' />" />
    <link rel="stylesheet" href="<c:url value='/themes/whm/bootstrap/select2.css' />" />
    <link rel="stylesheet" href="<c:url value='/themes/whm/bootstrap/bootstrap-responsive.css' />" />
    <link rel="stylesheet" media="print" href="<c:url value='/themes/whm/css/print_v1.2.css' />" />
    <link rel="stylesheet" href="<c:url value='/themes/whm/css/style.css' />" />
    <link rel='stylesheet' type='text/css' href='/themes/whm/bootstrap/datepicker.css' />


    <!--[if IE 7]>
    <link rel="stylesheet" href="<c:url value='/themes/whm/bootstrap/font-awesome-ie7.min.css'/>" />

    <![endif]-->
    <script language="javascript" type="text/javascript">
        var contextPath = '<c:url value="/"/>';
    </script>


    <decorator:head/>
</head>
<body<decorator:getProperty property="body.id" writeEntireProperty="true"/><decorator:getProperty property="body.class"
                                                                                                  writeEntireProperty="true"/>>
<c:set var="currPage" scope="request"><decorator:getProperty property="body.id"/></c:set>
<div class="page_wrapper">
    <div class="body_wrapper">
        <script src="<c:url value="/themes/whm/scripts/bootstrap/jquery.min.js"/>"></script>
        <script src="<c:url value="/themes/whm/scripts/bootstrap/jquery.cookie.js"/>"></script>
        <script src="<c:url value="/themes/whm/scripts/bootstrap/bootstrap.min.js"/>"></script>
        <script src="<c:url value="/themes/whm/scripts/bootstrap/jquery.uniform.js"/>"></script>
        <script src="<c:url value="/themes/whm/scripts/bootstrap/select2.js"/>"></script>
        <script src="<c:url value="/themes/whm/scripts/bootstrap/jquery.validate.js"/>"></script>

        <script type="text/javascript" src="<c:url value='/scripts/numeral.min.js'/>"></script>

        <script src="<c:url value="/scripts/jquery/jquery.corner.js"/>"></script>
        <script type="text/javascript" src="<c:url value='/scripts/global.js'/>"></script>
        <script type="text/javascript" src="<c:url value='/scripts/common_v1_5.js'/>"></script>
        <script type="text/javascript" src="<c:url value='/scripts/whm_v1.2.js'/>"></script>
        <script type="text/javascript" src="<c:url value='/scripts/whm.source.js'/>"></script>
        <script src="<c:url value="/themes/whm/scripts/bootstrap/bootstrap-datepicker_v1.0.js"/>"></script>
        <script type="text/javascript" src="<c:url value='/scripts/global.source.js'/>"></script>
        <script src="<c:url value="/themes/whm/scripts/bootstrap/jquery.formatCurrency-1.4.1.js"/>"></script>

        <jsp:include page="/common/whm_header.jsp"/>
        <div id="content">
            <%--<c:if test="${!(fn:contains(pageContext.request.requestURI, '/whm/home.html'))}">--%>
            <div id="top-nav">
                <ul>
                    <li class="top-nav-left"></li>
                    <li class="top-nav-main">
                        <%--<h1 class="info" style="color: #ff0000;font-weight: bold;text-align: center;font-size: 24px;"><fmt:message key="dev.server.info"/></h1>--%>
                    </li>
                    <li class="top-nav-right"></li>
                </ul>
                <div class="clear"></div>
            </div>
            <%--</c:if>--%>
            <decorator:body/>
            <div class="clear"></div>
        </div>
    </div>
    <div id="footer">
        <%@ include file="/common/whm_footer.jsp" %>
    </div>
</div>

</body>
</html>
