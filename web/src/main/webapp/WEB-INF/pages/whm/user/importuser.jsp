<%@ include file="/common/taglibs.jsp" %>


<head>
    <link rel="stylesheet" href="<c:url value='/themes/${appConfig["csstheme"]}/bootstrap/whm.css' />" />
    <link rel="stylesheet" href="<c:url value='/themes/css/jquery.jscrollpane.css' />" />
    <meta name="menu" content="AdminMenu"/>
</head>

<body>
<c:url var="cancelUrl" value="/dcdt/user/list.html"/>
<div id="breadcrumb">
    <a href='<c:url value="/dcdt/assessmentkpicategory/list.html"/>' title="Go to Home" class="tip-bottom firstLink"><i class="icon-home"></i> Home</a>
    <a href="#" class="current tip-bottom" title="Import User">Import User</a>
</div>
<div id="container-fluid data_content_box">
    <div class="row-fluid data_content">
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-error">
                <a class="close" data-dismiss="alert" href="#">x</a>
                    ${errorMessage}
            </div>
            <div style="clear:both;"></div>
        </c:if>
        <div class="content-header">
            Import User
        </div>
        <div class="button-actions">
            <a onclick="document.location.href='${cancelUrl}';" class="btn">
                Back
            </a>
        </div>
        <div class="widget-box">
            <div class="widget-title"><span class="icon"><i class="icon-file"></i></span><h5>Step 1 of 2: Select User Import File</h5></div>
            <div class="widget-content nopadding">
                <div style="margin: 10px;">
                    <p>
                        Below are links to instructions on how to create the necessary file as well as a template to get you started.
                    </p>
                    <div style="padding: 5px 0px 12px 60px;">
                        <a href="<c:url value="/files/userdcdt/importdcdtuser.xls" />">Download User Import Template</a>
                    </div>
                    <p>
                        If you have prepared a user .Xls to import, please select the file by selecting "Choose File" below.
                    </p>

                </div>
                <c:url var="formUrl" value="/dcdt/user/import.html"/>
                <form id="importUserForm" action="${formUrl}" method="POST" command="item" enctype="multipart/form-data" class="form-horizontal">
                    <div style="padding-left: 68px;height:40px;">
                        <input type="file" name="dataFile" id="dataFile"  size="40"/>
                        <form:hidden path="item.crudaction" value="import" />
                        <div class="button-actions" style="padding-right: 16px;">
                            <a href="#null" onclick="submitForm('importUserForm');" name="preventDblSubmitUpload"  class="btn" id="submit" style="cursor: default;">
                                Continue
                            </a>
                        </div>
                    </div>

                    <div style="padding-bottom:5px">
                        <div class="clear"></div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    $(document).ready(function(){
        $('input[type=checkbox],input[type=radio],input[type=file]').uniform();
        $("select[name='previewBy']").select2({
            width: 'resolve'
        });
        <c:if test="${action eq 'upload'}">
        $('#previewStudentRosterData').jScrollPane();
        </c:if>
    });

    $(window).load(function(){
        $('.jspPane').width(1350);
        $('.jspPane').css('padding-top', '10px');
    });
</script>
</body>