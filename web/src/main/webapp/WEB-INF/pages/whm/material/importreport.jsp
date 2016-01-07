<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<head>
    <title>Nhập kho tôn đầu kỳ</title>
    <meta name="heading" content="Nhập kho tôn đầu kỳ"/>
</head>


<c:url var="backUrl" value="/whm/product/import.html"/>

<div id="container-fluid data_content_box">
    <div class="row-fluid data_content">
        <div class="content-header">
            Nhập kho tôn đầu kỳ
        </div>
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
                    <td style="width: 20%;">Mã thất bại:</td>
                    <td>
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