<%--
  Created by IntelliJ IDEA.
  User: KhanhChu
  Date: 12/23/2017
  Time: 9:16 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ include file="/common/taglibs.jsp" %>
<head>
    <style>
        body{
            line-height: normal;
        }
        .body_wrapper {
            width: 100%;
             margin: 0;
        }
        #content {
            min-height: 500px;
            width: 100%;
        }
        #top-nav {
            margin-left: 0;
            width: 100%;
        }
        #user-profile,
        .top-nav-left,
        .top-nav-right,
        #footer{
            display: none;
        }
        #header{
            padding: 0;
        }
        #header,
        #top-nav .top-nav-main {
            width: 100%;
        }
        .real-time .tableSadlier td {
            text-align: right;
        }
    </style>
</head>
<%--<div class="ajax-progress"></div>--%>
<div id="container" class="real-time">
</div>
<c:url var="salesPerformance" value="/ajax/salesPerformance.html"/>
<c:url var="board" value="/whm/spBoard.html"/>
<script type="text/javascript">
    $(document).ready(function(){
        loadBoard();
    });
    function loadBoard(){
        $(".ajax-progress").show();
        $.ajax({
            url: '${salesPerformance}',
            dataType: "html",
            type: "GET",
            complete: function (res) {
                if (res.responseText != '') {
                    $('#container').html(res.responseText);
                }
                $(".ajax-progress").hide();
                setTimeout(loadBoard,60000);
            },
            error: function(){
                window.location.reload();
            }
        });
    }
</script>



