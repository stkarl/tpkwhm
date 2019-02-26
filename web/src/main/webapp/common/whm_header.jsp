<%@ page import="com.banvien.tpk.security.SecurityUtils" %>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@page trimDirectiveWhitespaces="true"%>
<%@ include file="/common/taglibs.jsp"%>
<c:set var="prefixURL" value="/whm"/>
<c:url var="dashboardUrl" value="${prefixURL}/home.html"/>

<div id="header">
<div id="logoheader" onclick="document.location.href='${dashboardUrl}';" style="cursor: pointer;"></div>
<div id="user-profile" class="navbar">
    <ul class="nav btn-group">
        <li class="btn dropdown" id="menu-user-profile"><a data-toggle="dropdown" data-target="#menu-user-profile" class="dropdown-toggle"><i class="user-profile-icon"></i> <b class="caret"></b><span class="text"> <%=SecurityUtils.getPrincipal().getFullname()%> (<%=SecurityUtils.getPrincipal().getRole()%>)</span></a>
            <ul class="dropdown-menu">
                <li><a class="i-profile" href="<c:url value="${prefixURL}/myProfile.html"/>"><fmt:message key="dcdt.menu.myprofile"/></a></li>
                <li><a class="i-logout" title="" href="<c:url value="/logout.jsp"/>"><fmt:message key="dcdt.menu.logout"/></a></li>
            </ul>
        </li>
    </ul>
</div>
<div id="user-nav" class="navbar">
<ul class="nav btn-group pull-right">
    <security:authorize ifAnyGranted="BOARD">
        <li class="dropdown" id="menu-board">
            <a href="<c:url value="${prefixURL}/spBoard.html"/>">
                <i class="sc-icon-top-board"></i> <span class="text"><fmt:message key="whm.menu.board"/></span>
            </a>
        </li>
    </security:authorize>
    <security:authorize ifNotGranted="BOARD">
        <li class="dropdown" id="menu-data"><a href="#" data-toggle="dropdown" data-target="#menu-data" class="dropdown-toggle"><i class="sc-icon-top-settings"></i> <span class="text"><fmt:message key="whm.menu.data.management"/></span></a>
            <ul class="dropdown-menu" style="margin-left:-15px;">
                <security:authorize ifAnyGranted="XUAT_TD,XUAT_TP,ADMIN,LANHDAO,QUANLYKHO,TRUONGCA">
                    <li><a class="menu" href="<c:url value="/whm/productionplan/list.html"/>"><span><fmt:message key="whm.menu.production.plan.list"/></span></a></li>
                </security:authorize>
                <security:authorize ifAnyGranted="ADMIN,QUANLYKD">
                    <li><a class="menu" href="<c:url value="/whm/user/list.html"/>"><span><fmt:message key="whm.menu.user.management"/></span></a></li>
                    <security:authorize ifAnyGranted="ADMIN">
                        <li><a class="menu" href="<c:url value="/whm/warehouse/list.html"/>"><span><fmt:message key="whm.menu.warehouse.management"/></span></a></li>
                    </security:authorize>
                </security:authorize>
                    <%--<li class="divider"></li>--%>
                <security:authorize ifAnyGranted="NHAP_TD,NHAP_VT,NHAP_TP,ADMIN,LANHDAO,QUANLYKHO,TRUONGCA,NHANVIENKD,QUANLYKD,QUANLYTT,QUANLYNO">

                    <li class="dropdown-submenu pull-left"><a href="#" ><fmt:message key="whm.menu.data.basic"/></a>
                        <ul class="dropdown-menu" style="margin-left: 210px;">
                            <security:authorize ifNotGranted="NHANVIENKD,QUANLYNO,QUANLYKD">
                                <li><a class="menu" href="<c:url value="/whm/market/list.html"/>"><span><fmt:message key="whm.menu.market.management"/></span></a></li>
                                <li><a class="menu" href="<c:url value="/whm/origin/list.html"/>"><span><fmt:message key="whm.menu.origin.management"/></span></a></li>
                                <li><a class="menu" href="<c:url value="/whm/unit/list.html"/>"><span><fmt:message key="whm.menu.unit.management"/></span></a></li>
                                <li><a class="menu" href="<c:url value="/whm/warehousemap/list.html"/>"><span><fmt:message key="whm.menu.warehousemap.management"/></span></a></li>
                                <li><a class="menu" href="<c:url value="/whm/shift/list.html"/>"><span><fmt:message key="whm.menu.shift.management"/></span></a></li>
                                <li><a class="menu" href="<c:url value="/whm/team/list.html"/>"><span><fmt:message key="whm.menu.team.management"/></span></a></li>
                            </security:authorize>
                                <%--<security:authorize ifAnyGranted="QUANLYTT,LANHDAO,ADMIN">--%>
                                <%--<li><a class="menu" href="<c:url value="/whm/fixexpense/list.html"/>"><span><fmt:message key="whm.fixexpense.title"/></span></a></li>--%>
                                <%--</security:authorize>--%>
                            <security:authorize ifAnyGranted="NHANVIENKD,QUANLYKD,LANHDAO,ADMIN,QUANLYNO">
                                <li><a class="menu" href="<c:url value="/whm/salereason/list.html"/>"><span><fmt:message key="whm.salereason.title"/></span></a></li>
                            </security:authorize>
                        </ul>
                    </li>
                    <security:authorize ifNotGranted="NHANVIENKD,QUANLYNO,QUANLYKD">
                        <li class="dropdown-submenu pull-left"><a href="#" ><fmt:message key="whm.menu.data.material"/></a>
                            <ul class="dropdown-menu" style="margin-left: 210px;">
                                <li><a class="menu" href="<c:url value="/whm/materialcategory/list.html"/>"><span><fmt:message key="whm.menu.materialcategory.management"/></span></a></li>
                                <li><a class="menu" href="<c:url value="/whm/material/list.html"/>"><span><fmt:message key="whm.menu.material.management"/></span></a></li>
                            </ul>
                        </li>
                        <li class="dropdown-submenu pull-left"><a href="#" ><fmt:message key="whm.menu.data.product"/></a>
                            <ul class="dropdown-menu" style="margin-left: 210px;">
                                <li><a class="menu" href="<c:url value="/whm/productname/list.html"/>"><span><fmt:message key="whm.menu.productname.management"/></span></a></li>
                                <li><a class="menu" href="<c:url value="/whm/thickness/list.html"/>"><span><fmt:message key="whm.menu.thickness.management"/></span></a></li>
                                <li><a class="menu" href="<c:url value="/whm/stiffness/list.html"/>"><span><fmt:message key="whm.menu.stiffness.management"/></span></a></li>
                                <li><a class="menu" href="<c:url value="/whm/size/list.html"/>"><span><fmt:message key="whm.menu.size.management"/></span></a></li>
                                <li><a class="menu" href="<c:url value="/whm/overlaytype/list.html"/>"><span><fmt:message key="whm.menu.overlaytype.management"/></span></a></li>
                                <li><a class="menu" href="<c:url value="/whm/colour/list.html"/>"><span><fmt:message key="whm.menu.colour.management"/></span></a></li>
                                <li><a class="menu" href="<c:url value="/whm/quality/list.html"/>"><span><fmt:message key="whm.menu.quality.management"/></span></a></li>
                            </ul>
                        </li>
                    </security:authorize>
                    <li class="dropdown-submenu pull-left"><a href="#" ><fmt:message key="whm.menu.data.customer"/></a>
                        <ul class="dropdown-menu" style="margin-left: 210px;">
                            <li><a class="menu" href="<c:url value="/whm/region/list.html"/>"><span><fmt:message key="whm.menu.region.management"/></span></a></li>
                            <li><a class="menu" href="<c:url value="/whm/province/list.html"/>"><span><fmt:message key="whm.menu.province.management"/></span></a></li>
                            <li><a class="menu" href="<c:url value="/whm/customer/list.html"/>"><span><fmt:message key="whm.menu.customer.management"/></span></a></li>
                        </ul>
                    </li>
                </security:authorize>
                <security:authorize ifAnyGranted="ADMIN,LANHDAO,QUANLYKHO,MAY_THIET_BI,QUANLYKT">
                    <li><a class="menu" href="<c:url value="/whm/machine/list.html"/>"><span><fmt:message key="whm.menu.machine.management"/></span></a></li>
                    <li><a class="menu" href="<c:url value="/whm/machinecomponent/list.html"/>"><span><fmt:message key="whm.menu.machinecomponent.management"/></span></a></li>
                    <li><a class="menu" href="<c:url value="/whm/maintenance/list.html"/>"><span><fmt:message key="whm.menu.maintenane.management"/></span></a></li>
                    <%--<li class="dropdown-submenu pull-left"><a href="#" ><fmt:message key="whm.menu.data.machine"/></a>--%>
                    <%--<ul class="dropdown-menu" style="margin-left: 210px;">--%>
                    <%----%>
                    <%--</ul>--%>
                    <%--</li>--%>
                </security:authorize>
            </ul>
        </li>
    </security:authorize>

    <security:authorize ifNotGranted="NHANVIENKD,QUANLYNO,QUANLYKD,BOARD">
        <li class="dropdown" id="menu-import"><a href="#" data-toggle="dropdown" data-target="#menu-import" class="dropdown-toggle"><i class="sc-icon-top-import"></i> <span class="text"><fmt:message key="whm.menu.import"/></span></a>
            <ul class="dropdown-menu" style="margin-left:-15px;">
                <security:authorize ifAnyGranted="ADMIN,NHAP_VT,NHANVIENTT,QUANLYTT,QUANLYKHO,LANHDAO">
                    <li><a class="menu" href="<c:url value="/whm/importmaterialbill/list.html"/>"><span><fmt:message key="whm.menu.import.material.list"/></span></a></li>
                </security:authorize>
                <security:authorize ifAnyGranted="NHAP_VT">
                    <li><a class="menu" href="<c:url value="/whm/importmaterialbill/edit.html"/>"><span><fmt:message key="whm.menu.import.material.edit"/></span></a></li>
                    <li><a class="menu" href="<c:url value="/whm/material/quickimport.html"/>"><span><fmt:message key="quick.import.material.title"/></span></a></li>
                </security:authorize>

                <security:authorize ifAnyGranted="ADMIN,NHAP_TP,QUANLYKHO,TRUONGCA,QUANLYTT,LANHDAO">
                    <li><a class="menu" href="<c:url value="/whm/importproductbill/reimportlist.html"/>"><span><fmt:message key="import.reimport.product.title"/></span></a></li>
                </security:authorize>
                <security:authorize ifAnyGranted="NHAP_TP">
                    <li><a class="menu" href="<c:url value="/whm/importproductbill/reimport.html"/>"><span><fmt:message key="whm.menu.reimport.product.edit"/></span></a></li>
                </security:authorize>
                <security:authorize ifAnyGranted="ADMIN,NHAP_TD,NHANVIENTT,QUANLYTT,QUANLYKHO,LANHDAO">
                    <li><a class="menu" href="<c:url value="/whm/importrootmaterialbill/list.html"/>"><span><fmt:message key="whm.menu.import.rootmaterial.list"/></span></a></li>
                </security:authorize>
                <security:authorize ifAnyGranted="NHAP_TD">
                    <li><a class="menu" href="<c:url value="/whm/importrootmaterialbill/edit.html"/>"><span><fmt:message key="whm.menu.import.rootmaterial.edit"/></span></a></li>
                    <li><a class="menu" href="<c:url value="/whm/product/quickimport.html"/>"><span><fmt:message key="quick.import.product.title"/></span></a></li>
                </security:authorize>

                <security:authorize ifAnyGranted="ADMIN,NHAP_TP,QUANLYKHO,TRUONGCA,QUANLYTT,LANHDAO">
                    <li><a class="menu" href="<c:url value="/whm/importproductbill/list.html"/>"><span><fmt:message key="whm.menu.import.product.list"/></span></a></li>
                </security:authorize>
                <security:authorize ifAnyGranted="NHAP_TP">
                    <li><a class="menu" href="<c:url value="/whm/importproductbill/byplan.html"/>"><span><fmt:message key="whm.menu.import.product.by.plan.edit"/></span></a></li>
                </security:authorize>
                <security:authorize ifAnyGranted="ADMIN,NHAP_TP,QUANLYKHO,TRUONGCA,QUANLYTT,LANHDAO">
                    <li><a class="menu" href="<c:url value="/whm/productionplan/importproductbyplan.html"/>"><span>Tổng hợp nhập thành phẩm theo ca</span></a></li>
                </security:authorize>

                <security:authorize ifAnyGranted="ADMIN,GHI_SO,QUANLYKHO,LANHDAO">
                    <li><a class="menu" href="<c:url value="/whm/materialmeasurement/list.html"/>"><span><fmt:message key="whm.menu.materialmeasurement.list"/></span></a></li>
                    <li><a class="menu" href="<c:url value="/whm/materialmeasurement/editlist.html"/>"><span><fmt:message key="whm.menu.materialmeasurement.editlist"/></span></a></li>
                </security:authorize>

                <security:authorize ifAnyGranted="NHANVIENKHO,QUANLYKHO">
                    <li class="dropdown-submenu pull-left"><a href="#" ><fmt:message key="change.location"/></a>
                        <ul class="dropdown-menu" style="margin-left: 380px;">
                            <li><a class="menu" href="<c:url value="/whm/instock/location/product.html"/>"><span><fmt:message key="change.product.location.title"/></span></a></li>
                            <li><a class="menu" href="<c:url value="/whm/instock/location/material.html"/>"><span><fmt:message key="change.material.location.title"/></span></a></li>
                            <li><a class="menu" href="<c:url value="/whm/location/history.html"/>"><span><fmt:message key="location.history.title"/></span></a></li>
                        </ul>
                    </li>
                </security:authorize>

                <security:authorize ifAnyGranted="ADMIN">
                    <li><a class="menu" href="<c:url value="/whm/product/list.html"/>"><span><fmt:message key="edit.product.info.title"/></span></a></li>
                    <li><a class="menu" href="<c:url value="/whm/product/import.html"/>"><span>Nhập kho tôn đầu kỳ</span></a></li>
                    <li><a class="menu" href="<c:url value="/whm/product/importinit.html"/>"><span>Nhập khai báo tôn đầu kỳ</span></a></li>
                    <li><a class="menu" href="<c:url value="/whm/material/import.html"/>"><span>Nhập kho vật tư đầu kỳ</span></a></li>
                </security:authorize>
            </ul>
        </li>

        <li class="dropdown" id="menu-export"><a href="#" data-toggle="dropdown" data-target="#menu-export" class="dropdown-toggle"><i class="sc-icon-top-export"></i> <span class="text"><fmt:message key="whm.menu.export"/></span></a>
            <ul class="dropdown-menu" style="margin-left:-15px;">
                <security:authorize ifAnyGranted="ADMIN,XUAT_VT_SX,XUAT_VT_BD,NHAP_VT,QUANLYKHO,TRUONGCA,LANHDAO,QUANLYTT">
                    <li><a class="menu" href="<c:url value="/whm/exportmaterialbill/list.html"/>"><span><fmt:message key="whm.menu.export.material.list"/></span></a></li>
                </security:authorize>
                <security:authorize ifAnyGranted="XUAT_VT_SX,XUAT_VT_BD">
                    <li><a class="menu" href="<c:url value="/whm/exportmaterialbill/edit.html"/>"><span><fmt:message key="whm.menu.export.material.edit"/></span></a></li>
                </security:authorize>

                <security:authorize ifAnyGranted="ADMIN,XUAT_TD,NHAP_TD,QUANLYKHO,TRUONGCA,LANHDAO,QUANLYTT">
                    <li><a class="menu" href="<c:url value="/whm/exportrootmaterialbill/list.html?isBlackProduct=true"/>"><span><fmt:message key="whm.menu.export.rootmaterial.list"/></span></a></li>
                </security:authorize>
                <security:authorize ifAnyGranted="XUAT_TD">
                    <li><a class="menu" href="<c:url value="/whm/exportrootmaterialbill/edit.html?isBlackProduct=true"/>"><span><fmt:message key="whm.menu.export.rootmaterial.edit"/></span></a></li>
                </security:authorize>

                <security:authorize ifAnyGranted="ADMIN,XUAT_TP,NHAP_TP,QUANLYKHO,TRUONGCA,LANHDAO,QUANLYTT">
                    <li><a class="menu" href="<c:url value="/whm/exportrootmaterialbill/list.html"/>"><span><fmt:message key="whm.menu.export.product.list"/></span></a></li>
                </security:authorize>
                <security:authorize ifAnyGranted="XUAT_TP">
                    <li><a class="menu" href="<c:url value="/whm/exportrootmaterialbill/edit.html"/>"><span><fmt:message key="whm.menu.export.product.edit"/></span></a></li>
                </security:authorize>
                <security:authorize ifAnyGranted="ADMIN,XUAT_VT_SX,XUAT_VT_BD,QUANLYKHO,TRUONGCA,LANHDAO,QUANLYTT">
                    <li><a class="menu" href="<c:url value="/whm/productionplan/materialbyplan.html"/>"><span>Danh sách xuất vật tư theo ca</span></a></li>
                </security:authorize>
                <security:authorize ifAnyGranted="ADMIN,XUAT_TD,XUAT_TP,QUANLYKHO,TRUONGCA,LANHDAO,QUANLYTT">
                    <li><a class="menu" href="<c:url value="/whm/productionplan/productbyplan.html"/>"><span>Danh sách xuất tôn theo ca</span></a></li>
                </security:authorize>
            </ul>
        </li>
    </security:authorize>
    <security:authorize ifAnyGranted="XUAT_TP,QUANLYKHO,NHANVIENKD,QUANLYKD,LANHDAO,ADMIN,QUANLYNO">
        <li class="dropdown" id="menu-moneys"><a href="#" data-toggle="dropdown" data-target="#menu-moneys" class="dropdown-toggle"><i class="sc-icon-top-money"></i> <span class="text"><fmt:message key="whm.menu.money"/></span></a>
            <ul class="dropdown-menu" style="margin-left:-15px;">
                <security:authorize ifAnyGranted="XUAT_TP,QUANLYKHO,NHANVIENKD,QUANLYKD,LANHDAO,ADMIN,QUANLYNO">
                    <li><a class="menu" href="<c:url value="/whm/booking/list.html"/>"><span><fmt:message key="booking.bill.list.title"/></span></a></li>
                </security:authorize>
                <security:authorize ifAnyGranted="NHANVIENKD,QUANLYKD,LANHDAO,QUANLYNO">
                    <li><a class="menu" href="<c:url value="/whm/booking/editinfo.html"/>"><span><fmt:message key="book.info.declare"/></span></a></li>
                </security:authorize>
            </ul>
        </li>
    </security:authorize>
	<security:authorize ifAnyGranted="BAOCAO_SX,BAOCAO_KD,QUANLYKHO,TRUONGCA,QUANLYKD,QUANLYTT,LANHDAO,ADMIN">
        <li class="dropdown" id="menu-reports"><a href="#" data-toggle="dropdown" data-target="#menu-reports" class="dropdown-toggle"><i class="sc-icon-top-report"></i> <span class="text"><fmt:message key="whm.menu.report"/></span></a>
            <ul class="dropdown-menu" style="margin-left:-15px;">
                <security:authorize ifAnyGranted="ADMIN,LANHDAO,QUANLYKD,QUANLYTT,QUANLYKHO,TRUONGCA,BAOCAO_SX">
                    <li><a class="menu" href="<c:url value="/whm/report/instock/material.html"/>"><span><fmt:message key="whm.menu.instock.material.list"/></span></a></li>
                    <li><a class="menu" href="<c:url value="/whm/report/material/export.html"/>"><span><fmt:message key="export.material.report.title"/></span></a></li>
                    <li><a class="menu" href="<c:url value="/whm/report/instock/product.html"/>"><span><fmt:message key="whm.menu.instock.product.list"/></span></a></li>
                    <li><a class="menu" href="<c:url value="/whm/report/productgeneral.html"/>"><span><fmt:message key="whm.menu.report.product.general"/></span></a></li>
                    <li><a class="menu" href="<c:url value="/whm/report/produce/product.html"/>"><span><fmt:message key="whm.menu.report.produce.product"/></span></a></li>
                    <li><a class="menu" href="<c:url value="/whm/report/used/material.html"/>"><span><fmt:message key="whm.menu.report.used.material"/></span></a></li>
                    <li><a class="menu" href="<c:url value="/whm/report/byoverlay.html"/>"><span><fmt:message key="whm.menu.report.by.overlay"/></span></a></li>
                    <li><a class="menu" href="<c:url value="/whm/report/summaryproduction.html"/>"><span><fmt:message key="whm.menu.report.summary.production"/></span></a></li>
                </security:authorize>
            </ul>
        </li>
    </security:authorize>

</ul>

</div>
<div class="clear"></div>
</div>





