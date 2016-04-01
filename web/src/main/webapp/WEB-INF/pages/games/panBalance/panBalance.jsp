<%@ include file="/common/taglibs.jsp"%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Pan Balance</title>
    <meta name="viewport" content="width=device-width, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0"/>
    <%--<script src="${sadlier:getCloudFrontURL4CSSAndJS(pageContext.request, "/themes/sadlierconnect/scripts/bootstrap/jquery.min.js")}"></script>--%>
    <script src="/scripts/jquery/jquery-1.8.2.min.js"></script>
    <link rel="stylesheet" href="/game/pan_balance/pan_balance.css">

    <script src='/game/lib/quintus.js'></script>
    <script src='/game/lib/quintus_sprites.js'></script>
    <script src='/game/lib/quintus_scenes.js'></script>
    <script src='/game/lib/quintus_2d.js'></script>
    <script src='/game/lib/quintus_touch.js'></script>
    <script src='/game/lib/quintus_ui.js'></script>
    <script src='/game/lib/quintus_sadlier_layout.js'></script>
    <script src='/game/pan_balance/panBalance.js'></script>

    <style>
        canvas { background-color:white; }
    </style>


</head>
<body>

<div class="game-container">
    <div class="game-header"></div>
    <div class="game-body">
        <div id="game_content" style="width: 700px; margin: 0px auto; position: relative;border: 1px; border-color: #000066">

        </div>
    </div>
    <div class="game-footer"></div>
    <div class="game-tools">
        <div name='toolPanel'> <input type="button" value="Select" onclick="javascript:setGameTool('select')"/>
            &nbsp; <input type="button" value="Hammer" onclick="javascript:setGameTool('hammer')"/>
            &nbsp; <input type="button" value="Copy" onclick="javascript:setGameTool('copy')"/></div>

        &nbsp; <input type="button" value="Groupp" onclick="javascript:setGameTool('group')"/></div>
    <c:if test="${param.grade eq '4'}">
    &nbsp; <input type="button" value="Create Mode" onclick="javascript:showModelContainer(this)"/></div>
</c:if>
<c:if test="${param.grade eq '5'}">
    &nbsp; <input type="button" value="Create Equation" onclick="javascript:showEquationContainer(this)"/></div>
</c:if>
&nbsp; <input type="button" value="Delete" onclick="javascript:setGameTool('delete')"/></div>
&nbsp; <input type="button" value="Print" onclick="javascript:print()"/></div>
    </div>

</div>

<div class="popupContent">

</div>
</body>

<script>

    var balanceUtil = new BalanceUtil();
    function setGameTool(tool) {
        Q.state.set("tool", tool);
    }

    function showEquationContainer(element) {
        var modelContainer = $('<div class="modelContainer"></div>');
        modelContainer.append('<input name="leftPan" type="text"/>');
        modelContainer.append('<input name="rightPan" type="text"/>');
        modelContainer.append('<input type="button" value="OK" onclick="javascript:createEquation(this)"/>');
        $(element).parent().append(modelContainer);
    }


    function showModelContainer(element) {
        var modelContainer = $('<div class="modelContainer"></div>');
        modelContainer.append('<input name="leftPan" type="text"/>');
        modelContainer.append('<input name="rightPan" type="text"/>');
        modelContainer.append('<input type="button" value="OK" onclick="javascript:createModel(this)"/>');
        $(element).parent().append(modelContainer);
    }

    function print() {
        var dataUrl = document.getElementById('sadlier').toDataURL(); //attempt to save base64 string to server using this var
        var windowContent = '<!DOCTYPE html>';
        windowContent += '<html>'
        windowContent += '<head></title></head>';
        windowContent += '<body>'
        windowContent += '<img src="' + dataUrl + '">';
        windowContent += '</body>';
        windowContent += '</html>';
        var printWin = window.open('','','width=340,height=260');
        printWin.document.open();
        printWin.document.write(windowContent);
        printWin.document.close();
        printWin.focus();
        printWin.print();
        printWin.close();
    }


    function splitToItem(value) {
        var result = [];
        var ones = value % 10;
        if (ones != 0) {
            result.push(ones);
        }

        var tens = value - ones;
        if (tens != 0) {
            result.push(tens);
        }

        return result;
    }

    function validateEquation(leftNo, rightNo) {
        if (leftNo > balanceUtil._CONST_maxItemsOnOnePan || rightNo > balanceUtil._CONST_maxItemsOnOnePan) {
            alert("Exceed max num of items for 1 one : " + balanceUtil._CONST_maxItemsOnOnePan);
            return false;
        }
        return true;
    }

    function createEquation() {
        Q.stageScene("Grade5");
        var leftValue = $('[name=leftPan]').val();
        var rightValue = $('[name=rightPan]').val();

        var leftResult = splitToTerms(leftValue);
        var rightResult = splitToItem(rightValue);

        var bar = Q("BalanceBar").items[0];
        var p = bar.getLeftPlate().p;
        var block;
        var xFactor = getXFactor(leftResult);
        if ((rightValue - getXTerm(leftResult)) % xFactor == 0) {


            var xWeight = (rightValue - getXTerm(leftResult))/xFactor;

            if (validateEquation(leftResult.length, rightResult.length)) {
                for (var i =0; i < leftResult.length; i++) {
                    block =  new Q.Block({weight: leftResult[i] != 'x' ? leftResult[i] : xWeight, isVariable : 'x' == leftResult[i], y:300 - (Math.floor(i/6)*60), x: 120 + 60*( (i %6) +1)});
                    block.add('fallingObject');
                    block.add('2d');
                    Q.stage().insert(block);
                }

                for (var i =0; i < rightResult.length; i++) {
                    block =  new Q.Block({weight: rightResult[i], y:300 - (Math.floor(i/6)*60) , x:730 + 60*(i+1)});
                    Q.stage().insert(block);
                    block.add('fallingObject');
                    block.add('2d');
                }
            }

        } else {
            alert ('ERROR');
        }

    }

    function getFactor(value) {
        var value = $.trim(value);
        if (value == 'x') {
            return 1;
        }
        var factor = value.replace(/\*x/g, '');
        factor = factor.replace(/x\*/g, '');
        factor = factor.replace(/x/g, '');
        return factor;
    }

    function splitToTerms(value) {
        var results = [];
        var terms = value.split('+');
        for (var i =0; i< terms.length; i++) {
            var term = $.trim(terms[i]);
            if (term.indexOf('x') != -1) {
                var xFactor = getFactor(term);
                for (var j = 0; j < xFactor; j++) {
                    results.push('x');
                }
            } else {
                results = results.concat(splitToItem(term));
            }
        }
        return results;
    }

    function getXFactor(values) {
        var result = 0;
        for(var i =0; i<values.length; i++) {
            if (values[i] == 'x') {
                result = result + 1;
            }
        }
        return result;
    }
    function getXTerm(values) {
        var result = 0;
        for(var i =0; i<values.length; i++) {
            if (values[i] != 'x') {
                result = result + values[i];
            }
        }
        return result;
    }


    function createModel(leftResult, rightResult) {
        Q.stageScene("Grade4");
        var leftValue = $('[name=leftPan]').val();
        var rightValue = $('[name=rightPan]').val();

        var leftResult = splitToItem(leftValue);
        var rightResult = splitToItem(rightValue);

        var bar = Q("BalanceBar").items[0];
        var p = bar.getLeftPlate().p;
        var leftEnd = bar.getLeftPlate().getLeftEnd();
        var rightEnd = bar.getRightPlate().getLeftEnd();
        var block;

        for (var i =0; i < leftResult.length; i++) {
            block =  new Q.Block({weight: parseInt(leftResult[i]), y:300, x:180 + 30*(i+1)});
            block.add('fallingObject');
            block.add('2d');
            Q.stage().insert(block);
        }

        for (var i =0; i < rightResult.length; i++) {
            block =  new Q.Block({weight: rightResult[i], y:100, x:1000 + 30*(i+1)});
            Q.stage().insert(block);
            block.add('fallingObject');
            block.add('2d');
        }

    }

//    var bigMode = true;
    var bigMode = false;
    var _CONST_canvas_width = 800;
    var _CONST_canvas_height = 390;
    if(bigMode){
        var _CONST_canvas_width = 1200;
        var _CONST_canvas_height = 700;
    }

    var panBalance = new PanBalance(_CONST_canvas_width,_CONST_canvas_height);

    <c:if test="${param.grade eq '4'}">
    if(bigMode){
        panBalance.grade4retina();
    }else{
        panBalance.grade4();
    }
    </c:if>

    <c:if test="${param.grade eq '5'}">
    if(bigMode){
        panBalance.grade5retina();
    }else{
        panBalance.grade5();
    }
    </c:if>
</script>
</html>
