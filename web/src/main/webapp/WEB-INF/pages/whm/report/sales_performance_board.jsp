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
        #header{
            display: none;
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
        .real-time .tableSadlier tr.customer-detail td {
            border-bottom: 1px dashed #c3c3c3;
        }

        .real-time .tableSadlier tr td.col-1,
        .real-time .tableSadlier tr th.col-1{
            width: 56px;
            padding: 0;
        }
        .real-time .tableSadlier tr td.col-2,
        .real-time .tableSadlier tr th.col-2 {

        }
        .real-time .tableSadlier tr td.col-3,
        .real-time .tableSadlier tr th.col-3,
        .real-time .tableSadlier tr td.col-5,
        .real-time .tableSadlier tr th.col-5 {
            width: 16%;
        }
        .real-time .tableSadlier tr td.col-4,
        .real-time .tableSadlier tr th.col-4,
        .real-time .tableSadlier tr td.col-6,
        .real-time .tableSadlier tr th.col-6 {
            width: 16%;
        }

        .hide{
            display: none;
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
        var sleepShowDetail = 15000;
        var sleepEachSalesman = 10000;
        var scrollSpeed = 1000;

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
                    var sleepHideDetail = $('.salesman-row').length * sleepEachSalesman;
                    var sleepLoadBoard = sleepHideDetail + sleepShowDetail;
                    setTimeout(function(){
                        $('.customer-detail').removeClass('hide');
                        $('.salesman-row').each(function(index,ele){
                            var $target = $(ele);
                            setTimeout(function(){
                                $('html, body').animate({
                                    scrollTop: $target.offset().top
                                }, scrollSpeed);
                            },sleepEachSalesman * index);
                        });
                        setTimeout(function(){
                            $('html, body').animate({
                                scrollTop: $('.top-nav-main').offset().top
                            }, scrollSpeed, 'swing', function(){
                                $('.customer-detail').addClass('hide');
                            });
                        },sleepHideDetail);
                    },sleepShowDetail);

                    setTimeout(loadBoard,sleepLoadBoard);
                },
                error: function(){
                window.location.reload();
                }
            });
        }

        loadBoard();
    });

</script>



