<%@ include file="/common/taglibs.jsp"%>
<security:authorize ifAnyGranted="BOARD">
    <c:redirect url="/whm/spBoard.html"/>
</security:authorize>

<security:authorize ifAnyGranted="ADMIN,NHANVIENKHO,TRUONGCA,NHANVIENTT,NHANVIENKD,QUANLYKHO,QUANLYTT,QUANLYKD,LANHDAO,QUANLYKT,QUANLYNO">
    <c:redirect url="/whm/home.html"/>
</security:authorize>

<security:authorize ifNotGranted="ADMIN,NHANVIENKHO,TRUONGCA,NHANVIENTT,NHANVIENKD,QUANLYKHO,QUANLYTT,QUANLYKD,LANHDAO,QUANLYKT,QUANLYNO,BOARD">
    <c:redirect url="/login.jsp"/>
</security:authorize>


