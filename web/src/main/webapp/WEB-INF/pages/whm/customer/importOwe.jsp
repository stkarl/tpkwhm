<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>

<head>
    <title>Nạp dữ liệu công nợ khách hàng</title>
    <meta name="heading" content="Nạp dữ liệu công nợ khách hàng"/>
</head>
<body>
<c:url var="url" value="/whm/customer/importOwe.html"/>
<c:url var="backUrl" value="/whm/home.html"/>
</br>
<form:form commandName="item" action="${url}" method="post" id="itemForm" class="form-horizontal" novalidate="novalidate" enctype="multipart/form-data">

    <div id="container-fluid data_content_box">
        <div class="row-fluid data_content">
            <c:if test="${!empty errorMessage}">
                <div class="alert alert-error">
                    <a class="close" data-dismiss="alert" href="#">x</a>
                        ${errorMessage}
                </div>
                <div style="clear:both;"></div>
            </c:if>
            <c:if test="${!empty successMessage}">
                <div class="alert alert-success">
                    <a class="close" data-dismiss="alert" href="#">x</a>
                        ${successMessage}
                </div>
                <div style="clear:both;"></div>
            </c:if>

            <div class="content-header">
                Nạp dữ liệu công nợ khách hàng
            </div>
            <div class="clear"></div>

            <div class="row-fluid">
                <div class="control-group">
                    <label class="control-label">
                        <fmt:message key="label.file"/>
                    </label>
                    <div class="controls">
                        <input type="file" name="dataFile"/>
                        <a href="<c:url value="/files/importtemplate/templateImportCustomerOwe.xls"/>"> <fmt:message key="label.file.example"/></a>
                    </div>
                    <div class="controls">
                        <form:hidden path="crudaction" id="crudaction" value="import"/>
                        <a onclick="submitForm('itemForm');" class="btn btn-success btn-green" style="cursor: pointer;">
                            <fmt:message key="button.import"/>
                        </a>
                        <div style="display: inline">
                            <a href="${backUrl}" class="cancel-link">
                                <fmt:message key="button.cancel"/>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</form:form>
</body>

