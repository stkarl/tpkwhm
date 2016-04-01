<%@ include file="/common/taglibs.jsp"%>
<html>
<head>
    <title>Raphael Play</title>
    <script src="${sadlier:getCloudFrontURL4CSSAndJS(pageContext.request, "/themes/sadlierconnect/scripts/bootstrap/jquery.min.js")}"></script>

    <script type="text/javascript" src="/sc-content/javascript/raphael-min_v2.1.5.2.js"></script>
    <script type="text/javascript" src="/sc-content/javascript/raphaeljs/raphael.free_transform.js"></script>
    <script type="text/javascript" src="/sc-content/javascript/mathpad_v1.52/mathpad.common_v1.1.js"></script>
    <script type="text/javascript" src="/sc-content/javascript/svg_game/attribute.rect.js"></script>
    <script type="text/javascript" src="/sc-content/javascript/svg_game/attrbute_triangle.js"></script>
    <script type="text/javascript" src="/sc-content/javascript/svg_game/attribute_common.js"></script>
    <script type="text/javascript" src="/sc-content/javascript/raphaeljs/raphael.free_transform.js"></script>
    <!--<script type="text/javascript" src="mathpad.bar.js"></script>-->
    <!--<script type="text/javascript" src="mathpad.block.js"></script>-->
    <%--<script type="text/javascript" src="mathpad.line.js"></script>--%>
    <!--<script type="text/javascript" src="mathpad.circle.js"></script>-->
    <!--<script type="text/javascript" src="mathpad.pencil.js"></script>-->
    <!--<script type="text/javascript" src="mathpad.text.js"></script>-->
    <script type="text/javascript" src="/sc-content/javascript/mathpad_v1.52/sadlier.mathpad_v1.3.js"></script>
    <script type="text/javascript" src="/sc-content/javascript/mathpad_v1.52/sadlier.mathpad_v1.3.js"></script>
    <script type="text/javascript" src="/sc-content/javascript/mathpad_v1.52/sadlier.mathpad.init.js"></script>

    <%--<script type="text/javascript" src="mathpad.text.js"></script>--%>
    <%--<script type="text/javascript" src="../raphaeljs/Raphael.InlineTextEditting.js"></script>--%>
    <%--<script type="text/javascript" src="../raphaeljs/raphael.export.js"></script>--%>
    <%--<script type="text/javascript" src="../raphaeljs/raphael.json.js"></script>--%>
    <link rel="stylesheet" href="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.8.10/themes/redmond/jquery-ui.css">



</head>
<body>

     <div id='sadlier_container'>
         <table>
             <tr>
                 <td><div class="attributeBlock" ></div>    </td>
             </tr>
             <tr>
                 <td><input type="button" value="delete"> </td>
             </tr>
         </table>

     </div>




</body>

<script type="text/javascript">

</script>


<%--<script type="text/javascript">--%>
    <%--var paper = Raphael('mathPatchViewer');--%>

    <%--var rect = paper--%>
            <%--.rect(200, 200, 100, 100)--%>
            <%--.attr('fill', '#f00');--%>

    <%--// Add freeTransform--%>
    <%--var ft = paper.freeTransform(rect);--%>

    <%--// Hide freeTransform handles--%>
    <%--ft.hideHandles();--%>

    <%--// Show hidden freeTransform handles--%>
    <%--ft.showHandles();--%>

    <%--// Apply transformations programmatically--%>
    <%--ft.attrs.rotate = 45;--%>

    <%--ft.apply();--%>

    <%--// Remove freeTransform completely--%>
    <%--ft.unplug();--%>

    <%--// Add freeTransform with options and callback--%>
    <%--ft = paper.freeTransform(rect, { scale: false}, function(ft, events) {--%>
        <%--console.log(ft.attrs);--%>
    <%--});--%>

    <%--// Change options on the fly--%>
    <%--ft.setOpts({ keepRatio: false });--%>

<%--</script>--%>
</html>