<%@page trimDirectiveWhitespaces="true"%>
<%@ include file="/common/taglibs.jsp"%>

<script src="<c:url value="/themes/whm/scripts/bootstrap/jquery.peity.min.js"/>"></script>
<script src="<c:url value="/themes/whm/scripts/bootstrap/fullcalendar.js"/>"></script>
<script src="<c:url value="/themes/whm/scripts/bootstrap/jquery.validate.js"/>"></script>
<script type="text/javascript" src="<c:url value='/scripts/jquery/jquery.form.js'/>"></script>
<script type="text/javascript" src="<c:url value='/themes/whm/scripts/bootstrap/bootbox.min.js'/>"></script>
<script src="<c:url value="/themes/whm/scripts/bootstrap/bootstrap-modalmanager.js"/>"></script>
<script src="<c:url value="/themes/whm/scripts/bootstrap/bootstrap-modal.js"/>"></script>
<script type="text/javascript" src="<c:url value='/scripts/jquery/jshashtable-2.1.js'/>"></script>
<script type="text/javascript" src="<c:url value='/scripts/jquery/jquery.numberformatter-1.2.2.min.js'/>"></script>

<div class="row-fluid">
    <div class="footer" class="span12">
        <div class="footer_settings navbar">

            <div class="btn-group dropup" style="float:left;">
                <a class="classroom link" data-toggle="dropdown"></a>
                <ul class="dropdown-menu bullet pull-top">
                    <li><a href="<c:url value="/files/TPK_Manual.pdf"/>"><fmt:message key="label.manual.warehouse"/></a></li>
                    <li><a href="<c:url value="/files/May_ThietBi.pdf"/>"><fmt:message key="label.manual.machine"/></a></li>
                    <security:authorize ifAnyGranted="ADMIN,LANHDAO,QUANLYKD,NHANVIENKD,QUANLYNO">
                    <li><a href="<c:url value="/files/ManualSell.pdf"/>"><fmt:message key="label.manual.sell"/></a></li>
                    </security:authorize>
                </ul>
            </div>
        </div>
        <div class="clear"></div>
        <div class="copyright" style="color: #442b2b;">Copyright &copy; 2014 by Tan Phuoc Khanh. Developed by Khanh Chu.</div>
        <div class="copyright" style="float: right; text-align: left;color: #442b2b;">Helpdesk : <fmt:message key="label.helpdesk.people"/></div>
        <div class="footer_links">
        </div>
    </div>
</div>