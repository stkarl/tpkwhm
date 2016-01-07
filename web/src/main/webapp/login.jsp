<%@page trimDirectiveWhitespaces="true"%>
<%@ include file="/common/taglibs.jsp"%>
<head>
    <title><fmt:message key="login.title"/></title>
</head>
<div id="content">
    <div class="box_container">
        <%--<h1 class="info" style="color: #ff0000;font-weight: bold;text-align: center;margin-top: 12px;font-size: 24px;"><fmt:message key="dev.server.info"/></h1>--%>
        <div class="loginBox">
            <div style="background: none repeat scroll 0 0 #388757; border: 1px solid #388757;margin: 100px auto; width: 500px;color:white;">
                <form name="loginForm" action="<c:url value="/j_security_check"/>" method="post">
                    <table width="400px" cellpadding="5" cellspacing="5" border="0" style="font-size: 13px; margin: 30px 0px 30px 50px">
                        <tr>
                            <td colspan="2"><fmt:message key="page.login.info"/></td>

                        </tr>
                        <tr>
                            <td><fmt:message key="page.login.username"/></td>
                            <td><input type="text" name="j_username" id="username"/></td>
                        </tr>
                        <tr>
                            <td><fmt:message key="page.login.password"/></td>
                            <td><input type="password" name="j_password" id="password"/></td>
                        </tr>
                        <tr>
                            <td></td>
                            <td>
                                <fmt:message var="login" key="login"/>
                                <input type="submit" name="buttonLogin" value="${login}" style=" border: 1px solid #B3B3B3; padding: 2px; width: 75px;" id="submit"/>
                            </td>
                        </tr>
                        <c:if test="${not empty param.error}">
                            <tr>
                                <td colspan="2" style="color:red;">
                                    <c:choose>
                                        <c:when test="${param.error == 1}">
                                            <fmt:message key="login.error.passwordmissedmatch"/>
                                        </c:when>
                                        <c:when test="${param.error == 2}">
                                            <fmt:message key="login.error.sessionexpired"/>
                                        </c:when>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:if>
                    </table>
                </form>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    $(document).ready(function(){
        $('#submit').click(function(){
            if($('#username').val() == '' || $('#password').val() == '') {
                alert('<fmt:message key="login.error.empty.username.or.password"/>');
                return false;
            }
            return true;
        });
    });
</script>