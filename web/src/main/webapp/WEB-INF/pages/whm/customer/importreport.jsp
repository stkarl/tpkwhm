<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<head>
    <title>Nạp dữ liệu khách hàng</title>
    <meta name="heading" content="Nạp dữ liệu khách hàng"/>
</head>


<c:url var="backUrl" value="/whm/customer/import.html"/>

<div id="container-fluid data_content_box">
    <div class="row-fluid data_content">
        <div class="content-header">
            Nạp dữ liệu khách hàng
        </div>
        <c:if test="${not empty errorMessage}">
            <div class="clear"></div>
            <div class="alert alert-error}">
                <button aria-hidden="true" data-dismiss="alert" class="close" type="button">x</button>
                    ${errorMessage}
            </div>
        </c:if>
        <div class="clear"></div>

        <div class="form">
            <table width="100%" cellpadding="5" cellspacing="5" border="0">
                <tr>
                    <td style="width: 20%;">Tổng dữ liệu:</td>
                    <td>
                        ${totalItems}
                    </td>

                </tr>
                <tr>
                    <td style="width: 20%;">Tổng thành công:</td>
                    <td>
                        ${totalSuccess}
                    </td>
                </tr>
                <tr>
                    <td style="width: 20%;">Thất bại:</td>
                    <td style="color: red">
                        ${failCode}
                    </td>
                </tr>

                <tr>
                    <td colspan="2">
                        <div style="display: inline">
                            <a href="${backUrl}" class="cancel-link">
                                <fmt:message key="button.cancel"/>
                            </a>
                        </div>
                    </td>
                </tr>
            </table>
        </div>

    </div>
</div>