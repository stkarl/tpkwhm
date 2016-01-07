<%@ include file="/common/taglibs.jsp" %>


<head>
    <title>List User Import</title>
    <meta name="heading" content="List User Import"/>
</head>

<body>
<div id="breadcrumb">
    <a href='<c:url value="/dcdt/assessmentkpicategory/list.html"/>' title="Go to Home" class="tip-bottom firstLink"><i class="icon-home"></i> Home</a>
    <a href="/dcdt/user/import.html" class="tip-bottom" title="Import User">Import User</a>
    <a href="/dcdt/user/importlist.html" class="tip-bottom" title="Import User List">Import User List</a>
    <a href="#" class="current tip-bottom" title="Report">Report</a>
</div>
<c:set var="cancelUrl" value="/dcdt/user/import.html"></c:set>
<div id="container-fluid data_content_box">
    <div class="row-fluid data_content">
        <div class="content-header">
            Summary Import Result
        </div>
        <div class="button-actions">
            <a onclick="document.location.href='${cancelUrl}';" class="btn">
                Back
            </a>
        </div>
        <div class="widget-box">
            <div class="widget-title"><span class="icon"><i class="icon-file"></i></span><h5>Summary of User Import</h5></div>
            <div class="widget-content nopadding">
                <div style="padding:10px">
                    <strong>
                        Total: ${totalItems}
                        <br/><br/>
                        Success: ${totalSuccess}
                    </strong>
                </div>
            </div>
        </div>
        <div class="clear"></div>
    </div>
</div>

<script type="text/javascript">

</script>
</body>