/**
 * User: tdtran
 */
/*
 User : tdtran

 Note :
 Pan Balance
 @TODO
 Here are a few problems and features need to be implemented and solved

 1. Reading from JSON asset file !
 2. Communicate with HTML element: Iframe (?) ,,,,,
 3. Align items on the pan. Limit to 6 columns of 4.
 4. Group Items for dragging ..... @!!!!
 5. Toolbox
 6. Bin
 7. Display Panel
 8. Generate random game.....
 9. .....
 10 .........
 */


function BalanceUtil() {
    this.getNumberOfUnit = function (value) {
        var noItems = 0;
        var remainingWeight = value - this.breakItemWeight(value);
        while(remainingWeight > 0) {
            remainingWeight = remainingWeight - this.retrieveItemWeight(remainingWeight);
            noItems ++;
        }
        return noItems;
    }

    this.breakItemWeight = function (weight) {
        if (weight > 10) {
            return 10;
        }

        if (weight <=10 && weight > 5) {
            return 5;
        }

        if (weight <=5 && weight >= 1) {
            return 1;
        }
    }

    this.retrieveItemWeight = function (weight) {
        if (weight >= 10) {
            return 10;
        }

        if (weight <10 && weight >= 5) {
            return 5;
        }

        if (weight <5 && weight >= 1) {
            return 1;
        }
    }

    this._CONST_maxItemsInOneColumn = 4;
    this._CONST_maxItemsOnOnePan = 6 * this._CONST_maxItemsInOneColumn;

}

function PanBalance(_CONST_canvas_width,_CONST_canvas_height) {

    var balanceUtil = new BalanceUtil();

    // -------------------- Game Constants -------------------------------------------
    var _CONST_lightColor = "cyan";  // This is the color of the indicator light
    var _CONST_hook = 0.05;          // This the hook Constant of the balance.

    var _CONST_maxSpeed = 0.2;
    var _CONST_minSpeed = 0.1;
    var _CONST_maxBalanceAngle = 18;    // This is the max angle of the bar. Not the Indicator
    var _CONST_balanceDegreeFactor = 1; // This is the Unit/Angle of the bar. ==> 1 unit the bar will rotate _CONST_balanceDegreeFactor degree
    var _CONST_balanceOffsetCenter = 30;

    var _CONST_bouncingSteps = 30;
    var _CONST_bouncingSpeed = 0.05;          // This the hook Constant of the balance.

    var _CONST_maxShownItemsInContainer = 10;

    // Trong's Note
    // From above we can calculate the sweeping angle of the indicator light
    // 1 Unit / Degree = balanceDegreeFactor * maxBalanceAngle / 180.  (180 is the max sweeping angle on the indicator board).
    // so
    // Sweeping angle for 1 Unit = 2 * 18/ 180 = 20 degree.


    // ------Position Constants
    // Those are Constants for displaying
    var _CONST_balancePlateThickness = 10;
    var _CONST_balanceBaseY = 250;   // The Y cordinate of the Balance Base
    var _CONST_balanceIndicatorBoardYOffset = 27;   // Is the offsetY of the indicator to the base
    var _CONST_lightIndicatorRadius = 10;
    var _CONST_plateWidth = 0;
    var _CONST_itemWidth = 29;
    var _CONST_itemHeight = 28;
    var _CONST_pointer_adjust = 25;
    var _CONST_left_container_adjust = 25;
    var _CONST_blockLabelFont = '900 14px arial';

    var _CONST_img_balanceBar = 'balanceBar.png';
    var _CONST_img_balanceCenter = 'balanceCenter.png';
    var _CONST_img_balancePlate = 'balancePlate.png';
    var _CONST_img_down_arrow = 'down_arrow.png';
    var _CONST_img_indicator = 'indicator.png';
    var _CONST_img_indicatorBoard = 'indicatorBoard.png';
    var _CONST_img_indicatorGlass = 'indicatorGlass.png';
    var _CONST_img_plus_x = 'plus-x.png';
    var _CONST_img_pointer = 'pointer.png';
    var _CONST_img_side_tab = 'side_tab.png';
    var _CONST_img_up_arrow = 'up_arrow.png';
    var _CONST_img_prefix = '.png';

    var _CONST_UnitColorMap = ['brown', 'red', 'orange', 'yellow', 'green', 'blue', 'pink', 'purple', ''];

    // -------------------  Common Utils ----------------------------------------------

    function getBalanceBar() {
        return Q("BalanceBar").items[0];
    }

    function getWeightContainer() {
        return Q("LeftContainer").items[0];
    }

    function getMessagePanel() {
        return Q("Container").items[0];
    }

    function getMessageText() {
        return Q("UI.Text").items[0];
    }

    function updateMessage(value) {
        var txt = getMessageText();
        txt.p.label = value;
    }

    function disableTouch() {
        var blocks = Q("Block").items;
        for (var i = 0; i < blocks.length; i++) {
            blocks[i].off("drag");
            blocks[i].off("touchEnd");
        }
    }

    function disableDrag() {
        var blocks = Q("Block").items;
        for (var i = 0; i < blocks.length; i++) {
            blocks[i].off("drag");
        }
    }

    function enableTouch() {
        var blocks = Q("Block").items;
        for (var i = 0; i < blocks.length; i++) {
            blocks[i].on("drag");
            blocks[i].on("touchEnd");
        }
    }

    function getColorFromWeight(weight) {
        return _CONST_UnitColorMap[weight % 8];
    }

    /*

     Simulate the Hook's LAW.
     Just an approximation
     It should be quadratic. dv = dx/dt , dv=dF/dt ==> dv = df/dt2 ==> v = k*x^2

     But here we 'd like to avoid natural bouncing on object
     here is the speed

     * *                           * *   <------- max speed
     *                          *
     *                        *      <-------- linear speed
     *                     *
     *  * *       * * *          <-------- min speed
     *  *                <-------- zero speed ---> get at limit of the Pan Balance

     */
    function hookSpeed(angle1, offset) {

        if (Math.abs(Math.abs(angle1) - _CONST_maxBalanceAngle) < 0.5 && (Math.abs(offset) > Math.abs(angle1) && sgn(offset)*sgn(angle1) > 0)) {
            // ie. If Angle has reached the MAX_VALUE and balance tries to move further then set speed to ZERO.
            // Move further means : offset and angle have the same Sign
            return 0;
        }
        var absDifference = Math.abs(angle1 - offset);
        if (_CONST_hook * absDifference > _CONST_maxSpeed) {
            return _CONST_maxSpeed * sgn(offset - angle1);
        } else if (_CONST_hook * absDifference < _CONST_minSpeed) {
            return _CONST_minSpeed * sgn(offset - angle1);
        } else {
            return _CONST_hook * (offset - angle1);
        }
    }

    /*
     just to find out the sign of a number
     */
    function sgn(x) {
        return (x > 0) - (x < 0);
    }

    /*
     --- Set up : 1. Balance Base
     2. Indicators
     3. Bar
     4. 2 Plates
     */



    function setupBalance(stage) {
        var balanceCenter = Q.width / 2 + _CONST_balanceOffsetCenter;
        var balanceBase = new Q.Sprite({asset: _CONST_img_balanceCenter,
            type: Q.SPRITE_NONE,
            y: _CONST_balanceBaseY,
            x: balanceCenter});

//        // insert the bar before the board to set it as a background
        insertBalanceBar(stage, balanceBase);
        stage.insert(balanceBase);



        var balancePointer = stage.insert(new Q.Sprite({asset: _CONST_img_pointer,
            type: Q.SPRITE_NONE,
            y: balanceBase.p.y - _CONST_pointer_adjust,
            x: balanceBase.p.x,
            z: 1}));

//        balanceIndicator.add("indicatorLight");
        balancePointer.add("pointer");

    }


    // because the bar position depends on the board so it needs board as param
    function insertBalanceBar(stage, balanceIndicatorBoard) {
        var balanceCenter = Q.width / 2 + _CONST_balanceOffsetCenter;
        var balanceBar = new Q.BalanceBar({
            y: balanceIndicatorBoard.p.y - 30,
            x: balanceCenter,
            z:0});

        var leftBalancePlate = new Q.BalancePlate({
            name: 'leftPlate'});
        _CONST_plateWidth = leftBalancePlate.p.w;

        stage.insert(leftBalancePlate);

        var rightBalancePlate = new Q.BalancePlate({
            name: 'rightPlate'});

        stage.insert(rightBalancePlate);


        stage.insert(balanceBar);



        balanceBar.setLeftPlate(leftBalancePlate);
        balanceBar.setRightPlate(rightBalancePlate);

    }
    var Q = window.Q = Quintus().include("Sprites, Scenes, Touch, UI, 2D, SadlierLayout")
        .setup("sadlier", {
            // height of created canvas
            width: _CONST_canvas_width,  // width of created canvas
            height: _CONST_canvas_height, // height of created canvas
            maximize: false // set to true to maximize to screen, "touch" to maximize on touch devices
        }).touch();


    Q.component("indicatorLight", {
        added: function () {
            this.entity.on("step", this, "step");

        },
        step: function (dt) {
            var balanceBar = getBalanceBar();
            var p = this.entity.p;
            if (this.entity instanceof Q.Indicator) {
                p.angle = 180 * balanceBar.p.angle / _CONST_maxBalanceAngle;
            } else {
                if (Math.abs(balanceBar.p.angle) < 0.5) {
                    p.hidden = false;
                } else {
                    p.hidden = true;
                }
            }
        }
    });

    Q.component("pointer", {
        added: function () {
            this.entity.on("step", this, "step");

        },
        step: function (dt) {
            var balanceBar = getBalanceBar();
            var p = this.entity.p;
            p.angle = 180 * balanceBar.p.angle / _CONST_maxBalanceAngle;
        }
    });


    Q.component("fallingObject", {
        defaults: {},

        added: function () {
            var p = this.entity.p;
            Q._defaults(p, this.defaults);
            this.entity.on("step", this, "step");
            this.entity.on('hit', this, "stop");
        },

        step: function (dt) {

            var stage = this.entity.stage;
            var bar = getBalanceBar();
            var leftPan = bar.getLeftPlate();
            var rightPan = bar.getRightPlate();

            if (leftPan.getLeftEnd() < this.entity.p.x  && this.entity.p.x < leftPan.getRightEnd()) {
                // going to left plate
                if (this.entity.plateHit != 'leftPlate') {
                    this.alignment(leftPan);
                } else {
                    this.adjustment(leftPan);
                }


            } else if (rightPan.getLeftEnd() < this.entity.p.x && this.entity.p.x < rightPan.getRightEnd()) {
                if (this.entity.plateHit != 'rightPlate') {
                    this.alignment(rightPan);
                } else {
                    this.adjustment(rightPan);
                }

            }
            // going to bin
            else {
                this.entity.removeWeightAndDestroy();
            }
        },

        stop: function (sprite) {

            if (sprite.obj.className == 'BalancePlate' || sprite.obj.className == 'Block') {
                var stage = this.entity.stage;
                var balanceBar = getBalanceBar();
                if ((sprite.obj.name == 'leftPlate' || sprite.obj.plateHit == 'leftPlate') && (this.entity.hit == null || this.entity.hit)) {
                    if (this.entity.plateHit == 'leftPlate') {

                    } else if (this.entity.plateHit == 'rightPlate') {
                        balanceBar.setLeftWeight(this.entity.myWeight);
                        balanceBar.setRightWeight(-this.entity.myWeight);
                        balanceBar.getRightPlate().removeItem(this.entity);
                    } else {
                        balanceBar.setLeftWeight(this.entity.myWeight);
                    }

                    if (this.entity.plateHit != 'leftPlate') {
                        balanceBar.getLeftPlate().addItem(this.entity);
                        this.entity.plateHit = 'leftPlate';
                        this.entity.addToolToObject(Q.state.get('tool'));
                        updateMessage(balanceBar.getMessage());
                    }

                } else if ((sprite.obj.name == 'rightPlate' || sprite.obj.plateHit == 'rightPlate') && (this.entity.hit == null || this.entity.hit)) {
                    if (this.entity.plateHit == 'leftPlate') {
                        balanceBar.setLeftWeight(-this.entity.myWeight);
                        balanceBar.setRightWeight(this.entity.myWeight);
                        balanceBar.getLeftPlate().removeItem(this.entity);

                    } else if (this.entity.plateHit == 'rightPlate') {

                    } else {

                        balanceBar.setRightWeight(this.entity.myWeight);
                    }

                    if (this.entity.plateHit != 'rightPlate') {
                        balanceBar.getRightPlate().addItem(this.entity);
                        this.entity.plateHit = 'rightPlate';
                        this.entity.addToolToObject(Q.state.get('tool'));
                        updateMessage(balanceBar.getMessage());
                    }
                }
            }
        },

        adjustment: function (pan) {
            var col = this.entity.column;
            this.entity.p.x = pan.getColX(col);
            var row = this.entity.addedToRow;
            var base = (pan.p.y - _CONST_balancePlateThickness);
            this.entity.p.y = base - (row)*_CONST_itemHeight;

        },
        alignment: function (pan) {
            var t = this.entity.column;
            var col = this.entity.p.x;
            var closestColumn = 1;
            var closestDistance = Math.abs(col - pan.getFirstCol());
            for (var i = 1; i <= 6; i++) {
                if (pan.isColFull(i)) {
                    continue;
                } else {
                    if (Math.abs(col - pan.getColX(i)) < Math.abs(closestDistance)) {
                        closestDistance = Math.abs(col - pan.getColX(i));
                        closestColumn = i;
                    }
                }
            }

            if (pan.isColFull(closestColumn) && this.entity.plateHit != pan.name) {
                moveToNextColumn(pan, this.entity, closestColumn);

            } else {
                this.entity.column = closestColumn;
                this.entity.p.x = pan.getColX(closestColumn);
            }


            function moveToNextColumn(pan, el, column) {
                var nextLeft = column - 1;
                var nextRight = column + 1;
                var rightColx;
                var leftColx;
                while (nextLeft > 1 && pan.isColFull(nextLeft)) {
                    nextLeft = nextLeft - 1;
                }
                leftColx = nextLeft > 0 ? pan.getColX(nextLeft) : -1;

                while (nextRight < 7 && pan.isColFull(nextRight)) {
                    nextRight = nextRight + 1;
                }
                rightColx = nextRight < 7 ? pan.getColX(nextRight) : -1;

                var leftDis = leftColx > 0 ? Math.abs(el.p.x - leftColx) : -1;
                var rightDis = rightColx > 0 ? Math.abs(el.p.x - rightColx) : -1;

                if (leftDis < 0) {
                    el.column = nextRight;

                } else if (rightDis < 0) {
                    el.column = nextLeft;
                } else if (leftDis < rightDis) {
                    el.column = nextLeft;
                } else {
                    el.column = nextRight;
                }
                el.p.x = pan.getColX(el.column);
                //  }
            }
        }
    });

    Q.component("plate", {
        weight: 0,
        defaults: {},
        added: function () {
            var p = this.entity.p;
            Q._defaults(p, this.defaults);
            this.entity.on("step", this, "step");

        },
        step: function () {

            var bar = getBalanceBar();
            if (this.entity.name == 'leftPlate') {
                this.entity.p.x = bar.getLeftEndX();
                this.entity.p.y = bar.getLeftEndY() - 25;

            } else if (this.entity.name = 'rightPlate') {
                this.entity.p.x = bar.getRightEndX();
                this.entity.p.y = bar.getRightEndY() - 25;
            }

            var p = this.entity.p;
        }
    });


    Q.component("bar", {
        defaults: { speed: 0, direction: 'down'},
        added: function () {
            var p = this.entity.p;
            Q._defaults(p, this.defaults);
            this.entity.on("step", this, "step");
        },
        step: function () {
            var p = this.entity.p;
            var offBalanceDeg = this.entity.getOffBalanceDeg();
            if (this.entity.bouncingForward || this.entity.bouncingBackward) {
                doBouncing(this);
            } else {
                // Or condition is for setup equation, when blocks are added to quickly, hitting can happen before the previous move has finished
                if ((this.entity.getOffBalanceDeg() != this.entity.getCurrentOffDeg() || (Math.abs(this.entity.getOffBalanceDeg() - this.entity.p.angle) > 0.1))) {

                    if (Math.abs(offBalanceDeg - this.entity.p.angle) <= 0.1) {

                        this.entity.setCurrentOffDeg(offBalanceDeg);
                        startBouncing(this, offBalanceDeg < this.entity.p.angle);
                    } else {
                        this.entity.p.angle = this.entity.p.angle + hookSpeed(this.entity.p.angle, offBalanceDeg);

                        if (Math.abs(this.entity.p.angle) >= _CONST_maxBalanceAngle && Math.abs(offBalanceDeg) > _CONST_maxBalanceAngle) {

                            this.entity.setCurrentOffDeg(offBalanceDeg);
                        }
                    }
                }
            }

            function startBouncing(el, antiClockwise) {
                el.entity.bouncingForward = true;
                el.entity.bouncingBackward = true;
                el.entity.bouncingSteps = 0;
                el.entity.bouncingDirection = antiClockwise ? 'anti-clockwise' : 'clockwise';
            }

            function doBouncing(el) {
                if (el.entity.bouncingDirection == 'anti-clockwise') {
                    el.entity.p.angle = el.entity.p.angle - _CONST_bouncingSpeed;
                } else if (el.entity.bouncingDirection == 'clockwise') {
                    el.entity.p.angle = el.entity.p.angle + _CONST_bouncingSpeed;
                }

                if (el.entity.bouncingSteps < _CONST_bouncingSteps) {
                    el.entity.bouncingSteps = el.entity.bouncingSteps + 1;
                } else {
                    el.entity.bouncingSteps = 0;
                    if (el.entity.bouncingForward) {
                        el.entity.bouncingForward = false;
                        if (el.entity.bouncingDirection == 'anti-clockwise') {
                            el.entity.bouncingDirection = 'clockwise';
                        } else if (el.entity.bouncingDirection == 'clockwise') {
                            el.entity.bouncingDirection = 'anti-clockwise';
                        }

                    } else if (el.entity.bouncingBackward) {
                        el.entity.bouncingBackward = false;
                    }
                }
            }
        }
    });

//    var selectGroup = [];
    var leftSelectGroup = [];
    var rightSelectGroup = [];


    Q.component("toBeSelectedObject", {
        added: function () {
            this.entity.on("touchEnd", this, "touch");
            this.entity.on("_unselect", this, "_unselect");
            this.entity.on("unselect", this, "unselect");
        },
        touch: function (touch) {
            // we only handle tap, so if touch.dx != null then it is a drag !!!!
            if (touch.dx == null && touch.dy == null) {
                if (this.entity.selected != true) {
                    this.select();
                } else {
                    this.unselect();
                }
            }
        },
        select: function () {
            this.entity.p.fontColor =  "black";
            this.entity.selected = true;

            if ('leftPlate' == this.entity.plateHit) {
                leftSelectGroup = addToGroup(leftSelectGroup, this);
            } else if ('rightPlate' == this.entity.plateHit) {
                rightSelectGroup = addToGroup(rightSelectGroup, this);
            }

            function addToGroup(selectGroup, el) {
                var notExist = true;
                for (var i = 0; i < selectGroup.length; i++) {
                    if (selectGroup[i] == el.entity) {
                        notExist = false;
                        break;
                    }
                }
                if (notExist) {

                    selectGroup.push(el.entity);
                }

                return selectGroup;
            }

        },
        unselect: function () {
            this.entity.p.fontColor =  "white";
            this.entity.selected = false;
            var index = -1;
            for (var i = 0; i < leftSelectGroup.length; i++) {
                if (leftSelectGroup[i] == this.entity) {
                    index = i;
                }
            }

            if (index == -1) {
                for (var i = 0; i < rightSelectGroup.length; i++) {
                    if (rightSelectGroup[i] == this.entity) {
                        index = i;
                    }
                }
            } else {
                leftSelectGroup.splice(index, 1);
            }

            if (index != -1) {

                rightSelectGroup.splice(index, 1);
            }
        },
        _unselect: function() {
            this.entity.p.fontColor =  "white";
            this.entity.selected = false;
        }
    });

    Q.component("toBeCopiedObject", {
        added: function () {
            this.entity.on("touchEnd", this, "touch");
        },
        touch: function (touch) {
            var weight = this.entity.myWeight;
            var panName = this.entity.plateHit;
            var column = this.entity.addedToColumn;
            var columnPointer = column;
            var row = this.addedToRow;
            var stage = this.entity.stage;
            var bar = getBalanceBar();
            var pan;
            if ('leftPlate' == panName) {
                pan = bar.getLeftPlate();
            } else if ('rightPlate' == panName) {
                pan = bar.getRightPlate();
            }
            if (pan.validateNumberExceed(1)) {

                while (pan.isColFull(columnPointer)) {
                    columnPointer = columnPointer % 6 + 1;
                }

                var base = (pan.p.y - _CONST_balancePlateThickness)- _CONST_itemHeight;
                var length = pan.getLengthOfColumn(columnPointer);
                var varY ;
                if (length == 0) {
                    varY = base;
                } else {
                    varY =  base - (length)*_CONST_itemHeight;
                }

                copyItemAt(stage, pan, weight , pan.getColX(columnPointer), varY, columnPointer, null);
            } else {
                alert("ERROR");
            }



            function copyItemAt(stage, pan, weight, x, y, column, row) {
                var b = new Q.Block({weight: weight, x: x, y: y});
                b.add("2d , fallingObject");
                stage.insert(b);
                b.column = column;
                //pan.addItemToColumn(b, column, row);
                b.add('toBeCopiedObject');
            }

        }
    });


    Q.component("toBeHammeredObject", {

        added: function () {
            this.entity.on("touchEnd", this, "touch");
        },
        touch: function (touch) {
            var panName = this.entity.plateHit;
            var row = this.addedToRow;
            var stage = this.entity.stage;
            var bar = getBalanceBar();
            var pan;
            if ('leftPlate' == panName) {
                pan = bar.getLeftPlate();
            } else if ('rightPlate' == panName) {
                pan = bar.getRightPlate();
            }

            if (pan.validateNumberExceed(balanceUtil.getNumberOfUnit(this.entity.myWeight))) {
                breakIntoUnits(stage, pan, this.entity);
                disableDrag();
                updateMessage(getBalanceBar().getMessage());
            } else {
                alert("Number Of Breaking Unit exceeds " + balanceUtil._CONST_maxItemsOnOnePan)
            }



            // disableDrag();
            function insertItemAt(stage, pan, weight, x, y, column, row) {
                var b = new Q.Block({weight: weight, x: x, y: y});
                // b.p.dragging = false;
                // b.add("2d , fallingObject");
                stage.insert(b);
                b.brokenItem = true;
                b.plateHit = pan.name;
                b.column = column;
                pan.addItemToColumn(b, column, row);
                b.add('toBeHammeredObject');
                b.add('2d, fallingObject');
            }

            function breakIntoUnits(stage, pan, entity) {
                var remainingWeight = replaceItem(stage, pan, entity);
                entity.destroy();
                pan.removeItem(entity);
                var weight = entity.myWeight;
                var column = entity.addedToColumn;
                var columnPointer = column;
                columnPointer = (columnPointer + 1)%6;
                columnPointer = columnPointer == 0 ? 6 : columnPointer;
                var base = (pan.p.y - _CONST_balancePlateThickness)- _CONST_itemHeight;
                while(remainingWeight > 0) {
                    var itemWeight = balanceUtil.retrieveItemWeight(remainingWeight);
                    if (!pan.isColFull(columnPointer)) {
                        remainingWeight = remainingWeight - itemWeight;
                        var lastItemInCol = pan.getLastItemOfCol(columnPointer);
                        var length = pan.getLengthOfColumn(columnPointer);
                        var varY ;
                        if (lastItemInCol == null) {
                            varY = base;
                        } else {
                            varY =  base - (length)*_CONST_itemHeight;
                        }
                        insertItemAt(stage, pan, itemWeight , pan.getColX(columnPointer), varY, columnPointer, null);
                    }
                    columnPointer = (columnPointer + 1)%6;
                    columnPointer = columnPointer == 0 ? 6 : columnPointer;
                }

            }

            function replaceItem(stage, pan, entity) {
                var weight = balanceUtil.breakItemWeight(entity.myWeight);
                var varY =  entity.p.y;
                insertItemAt(stage, pan, weight , pan.getColX(entity.addedToColumn), varY,  entity.addedToColumn, entity.addedToRow);
                return entity.myWeight - weight;
            }


        }
    });


    Q.Sprite.extend('Indicator', {
        init: function (p) {
            this._super(p, {
            });
            this.lightAngle = 0;
        },

        draw: function (ctx) {
            ctx.beginPath();
            var antiClockwise = this.p.lightAngle <= 0;
            ctx.arc(0, 0, _CONST_lightIndicatorRadius, -Math.PI / 2, -Math.PI / 2 + this.p.lightAngle * Math.PI / 180, antiClockwise);
            ctx.strokeStyle = _CONST_lightColor;
            ctx.lineWidth = 8;
            ctx.stroke();
        }
    });

    Q.UI.Button.extend('SideTab', {
        init: function (p) {
            this._super(p, {
            });
            this.on("touch", this, "touch");
            this.on('touchEnd',this,"push");
        },
        touch: function(touch) {

            if (true != this.isHide) {
                this.parentContainer.hideAll();
                this.p.x = this.parentContainer.p.x ;
                this.isHide = true;
            } else {
                this.parentContainer.showAll();
                this.p.x = this.parentContainer.p.x + this.parentContainer.p.width + this.p.w;
                this.isHide = false;
            }

        },
        push: function(touch) {

        }
    });

    Q.UI.Button.extend('Scroll', {
        init: function (props) {
            this._super(props);
            this.on("touch", this, "touch");
            this.on('touchEnd',this,"push");

        },
        touch: function(touch) {

            if (true == this.down) {
                moveDown(this.parentContainer);
            }

            if (true == this.up) {
                moveUp(this.parentContainer);
            }
            showAndHide(this.parentContainer);

            function moveUp(container) {
                var pointer = container.pointer;
                var items = container.items;
                if (pointer == items.length - _CONST_maxShownItemsInContainer) {
                    return;
                } else {
                    container.pointer = container.pointer + 1;
                    for (var i = items.length -1; i > 0; i--) {
                        items[i].p.y = items[i-1].p.y;

                    }
                }
            }
            function moveDown(container) {
                var pointer = container.pointer;
                var items = container.items;
                if (pointer == 0) {
                    return;
                } else {
                    container.pointer = container.pointer - 1;
                    for (var i = 0; i < items.length -1; i++) {
                        items[i].p.y = items[i+1].p.y;

                    }
                }
            }


            function showAndHide(container) {
                var items = container.items;
                var pointer = container.pointer;

                for (var i = 0; i < items.length; i++) {
                    if (i < pointer || i > pointer + _CONST_maxShownItemsInContainer - 1) {
                        items[i].hide();
                    } else {
                        items[i].show();
                    }
                }
            }

        },
        push: function(touch) {

        }
    });

    Q.Sprite.extend('LeftContainer', {
        init: function (p) {
            this._super(p, {
            });
            this.currentY = this.p.y + 10;
            this.items = [];
            this.pointer = 0;
        },

        draw: function (ctx) {
            ctx.beginPath();
            ctx.rect(this.p.x, this.p.y,this.p.width, this.p.height);
            ctx.lineWidth = 1;
            ctx.stroke();
        },
        insert: function (entity) {
            entity.p.x = this.p.x + this.p.width - (entity.p.w/2);
            entity.p.y = this.currentY + entity.p.h;
            this.stage.insert(entity);
            entity.origin = true;
            if (this.items.length == _CONST_maxShownItemsInContainer) {
                entity.hide();
            }
            this.items.push(entity);
            this.currentY =  this.currentY + entity.p.h + 5;

        },
        replace: function(e1, e2) {
            for (var i = 0; i < this.items.length; i ++) {
                if (this.items[i] == e1) {
                    this.items[i] = e2;
                    e2.origin = true;
                    break;
                }
            }
        },
        insertSideTab: function() {
            var tab = new Q.SideTab({asset: _CONST_img_side_tab, x: this.p.x + this.p.width, y: this.p.y});
            tab.p.x =  this.p.x + this.p.width + tab.p.w/2 + 10;
            tab.p.y = this.p.y + tab.p.h/2 + 10;
            this.stage.insert(tab);
            tab.parentContainer = this;
        },
        insertTopScroll: function() {
            var scroller = new Q.Scroll({asset: _CONST_img_up_arrow, x: this.p.x + this.p.width/2 + 10, y: this.p.y});
            scroller.p.y = this.p.y + scroller.p.h - 5;
            this.stage.insert(scroller);
            this.topScroller = scroller;
            scroller.parentContainer = this;
            scroller.down = true;
        },
        insertBottomScroll: function() {
            var scroller = new Q.Scroll({asset: _CONST_img_down_arrow, x: this.p.x + this.p.width/2 + 10, y: this.p.y});
            scroller.p.y = this.p.y + this.p.height ;
            this.stage.insert(scroller);
            this.bottomScroller = this;
            scroller.parentContainer = this;
            scroller.up = true;
        },
        hideAll: function() {
            this.hide();
            this.topScroller.hide();
            this.bottomScroller.hide();
            var items = this.items;
            var pointer = this.pointer;
            for (var i = 0; i < items.length; i++) {

                items[i].hide();

            }
        },
        showAll: function() {
            this.show();
            this.topScroller.show();
            this.bottomScroller.show();
            var items = this.items;
            var pointer = this.pointer;
            for (var i = 0; i < items.length; i++) {
                if (i < pointer || i > pointer + _CONST_maxShownItemsInContainer - 1) {
                    items[i].hide();
                } else {
                    items[i].show();
                }
            }
        }
    });

    Q.UI.Button.extend('Block', {
        init: function (props) {
//            var color = getColorFromWeight(props.weight);
            var color = 'white';
            var xVar = props.x != null ? props.x : 0;
            var yVar = props.y != null ? props.y : 0;
            var weightIndex;
            weightIndex = Math.abs(props.weight < 10 ? props.weight % 10 : props.weight/10);



            this._super({ w: _CONST_itemWidth, h: _CONST_itemHeight, fill: color, z:0, stroke: 'white', label: props.isVariable ? '' : '' + props.weight, border: null,
                x: xVar, y: yVar,
//                type: Q.SPRITE_UI,
                asset: true == props.isVariable ? _CONST_img_plus_x : ('weights_' + weightIndex + _CONST_img_prefix), font: _CONST_blockLabelFont, fontColor : 'white'});  // to add label  label: props.weight != null ? props.weight : 0,

            this.myWeight = props.weight != null ? props.weight : 0;
            if (true == props.isVariable) {
                this.isVariable = true;
            }
            this.origin = false;
            this.on("drag");
            this.on("touchEnd");
            this.on("touch");
            Q.state.on("change.tool", this, "toolSet");

        },

        touch: function(touch) {
            if (this.origin == true && ('select' != Q.state.p.tool)) {
                return;
            }
            if (this.origin == true && 'select' == Q.state.p.tool) {
                this.origin = false;
                this.p.z = 1;
                var newBlock = new Q.Block({x: this.p.x, y:this.p.y, weight: this.myWeight, isVariable : this.isVariable });
                this.stage.insert(newBlock);
                getWeightContainer().replace(this, newBlock);
            }
        },

        drag: function (touch) {
            var selectGroup = null;


            if (this.selected == true) {

                if (this.plateHit == 'leftPlate') {
                    selectGroup = leftSelectGroup;
                } else {
                    selectGroup = rightSelectGroup;
                }

                if (selectGroup == null || selectGroup.length == 0) {
                    dragObject(this, touch);
                } else {

                    dragAGroup(selectGroup, this, touch);
                }
            } else {
                this.del("2d , fallingObject");
                this.p.dragging = true;
                this.p.x = touch.origX + touch.dx;
                this.p.y = touch.origY + touch.dy;
            }

            function dragObject(obj, touch) {
                obj.del("2d , fallingObject");
                obj.p.dragging = true;
                obj.p.x = touch.origX + touch.dx;
                obj.p.y = touch.origY + touch.dy;
            }

            function dragAGroup(selectGroup, obj, touch) {
                for (var i = 0; i < selectGroup.length; i++) {
                    selectGroup[i].del("2d , fallingObject");
                    selectGroup[i].p.dragging = true;
                    if (selectGroup[i] == obj) {
                        dragObject(obj, touch);
                    } else {
                        selectGroup[i].p.x = obj.p.x - (obj.addedToColumn - selectGroup[i].addedToColumn) * _CONST_itemWidth;
                        selectGroup[i].p.y = obj.p.y + (obj.addedToRow - selectGroup[i].addedToRow) * _CONST_itemHeight;
                    }

                }
            }
        },

        touchEnd: function (touch) {
            var selectGroup = null;
            if (touch.dx == null && touch.dy == null) {
                return;
            }

            if (this.selected == true) {
                if (this.plateHit == 'leftPlate') {
                    selectGroup = leftSelectGroup;
                    leftSelectGroup = [];
                    leftSelectGroup.length = 0;
                } else {
                    selectGroup = rightSelectGroup;
                    rightSelectGroup= [];
                    rightSelectGroup.length = 0;
                }

                if (!this.has('fallingObject') && (selectGroup == null || selectGroup.length == 0)) {
                    validate(this, touch, null);
                    this.p.dragging = false;
                    this.add("2d , fallingObject");
                    this.trigger('unselect');
                } else {
                    validate(this, touch, selectGroup);
                    for (var i = 0; i < selectGroup.length; i++) {
                        selectGroup[i].p.dragging = false;
                        selectGroup[i].add("2d , fallingObject");
                        selectGroup[i].trigger('_unselect');
                    }

                }
            } else {
                validate(this, touch, null);
                this.p.dragging = false;
                this.add("2d , fallingObject");
            }

            function validate(el, touch, selectGroup) {
                var bar = getBalanceBar();
                var leftPan = bar.getLeftPlate();
                var rightPan = bar.getRightPlate();
                if (leftPan.getLeftEnd() < el.p.x && (el.p.x) < leftPan.getRightEnd()) {
                    if (!leftPan.validateExceed(selectGroup)) {
                        alert("ERROR 1 ");

                        if (selectGroup == null) {
                            if(el.plateHit == null) {
                                el.stage.remove(el);
                            } else {
                                el.p.x = touch.origX;
                                el.p.y = touch.origY;
                            }
                        } else {
                            for (var i = 0; i < selectGroup.length; i++) {
                                selectGroup[i].p.x = touch.origX;
                                selectGroup[i].p.y = touch.origY;
                            }
                        }
//

                        return;
                    }

                } else if (rightPan.getLeftEnd() < el.p.x  && el.p.x < rightPan.getRightEnd()) {
                    if (!rightPan.validateExceed(selectGroup)) {
                        alert("ERROR 2");
                        if (selectGroup == null) {
                            if(el.plateHit == null) {
                                el.stage.remove(el);
                            } else {
                                el.p.x = touch.origX;
                                el.p.y = touch.origY;
                            }
                        } else {
                            for (var i = 0; i < selectGroup.length; i++) {
                                selectGroup[i].p.x = touch.origX;
                                selectGroup[i].p.y = touch.origY;
                            }
                        }

                        return;
                    }
                }

            }

        },

        toolSet: function (tool) {

            if ('group' == tool) {
                return;
            }

            if (this.plateHit != null && this.plateHit != '')  {
                if ('select' == tool) {
                    this.del('toBeHammeredObject');
                    this.del('toBeCopiedObject');
                    this.add('toBeSelectedObject');
                    var items = Q("Block").items;
                    if ( true == this.brokenItem) {
                        this.add("2d , fallingObject");
                        this.brokenItem = null;
                    }
                    enableTouch();
                } else if ('hammer' == tool) {
                    this.del('toBeSelectedObject');
                    this.del('toBeCopiedObject');
                    this.add('toBeHammeredObject');
                    disableDrag();
                } else if ('copy' == tool){
                    this.del('toBeHammeredObject');
                    this.del('toBeSelectedObject');
                    this.add('toBeCopiedObject');
                    disableDrag();
                } else if ('delete' == tool) {
                    for (var i = 0; i < leftSelectGroup.length; i++) {
                        leftSelectGroup[i].removeWeightAndDestroy();
                    }

                    for (var i = 0; i < rightSelectGroup.length; i++) {
                        rightSelectGroup[i].removeWeightAndDestroy();
                    }
                    rightSelectGroup = [];
                    leftSelectGroup = [];
                    updateMessage(getBalanceBar().getMessage());

                    this.del('toBeHammeredObject');
                    this.del('toBeSelectedObject');
                    this.del('toBeCopiedObject');
                }
            } else {
                if ('select' != tool && true == this.origin) {
                    this.off('touch');
                    this.off('drag');
                    this.off('touchEnd');
                } else {
                    this.on('touch');
                    this.on('drag');
                    this.on('touchEnd');
                }
            }

        },

        removeWeightAndDestroy: function () {
            if (this.plateHit == 'leftPlate') {
                getBalanceBar().setLeftWeight(-this.myWeight);
                getBalanceBar().getLeftPlate().removeItem(this)

            } else if (this.plateHit == 'rightPlate') {
                getBalanceBar().setRightWeight(-this.myWeight);
                getBalanceBar().getRightPlate().removeItem(this);

            }
            this.destroy();
        },
        addToolToObject: function(tool) {
            if ('select' == tool && !this.has('toBeSelectedObject')) {
                this.del('toBeHammeredObject');
                this.add('toBeSelectedObject');
            } else {

            }
        },
        changeWeight: function(newWeight) {
            this.myWeight= newWeight;
            this.p.label = newWeight;
            var weightIndex = this.myWeight < 10 ? this.myWeight % 10 : this.myWeight/10;
            // this.p.asset = 'weights_' + weightIndex + _CONST_img_prefix;
        }
    });


    Q.Sprite.extend('BalanceBar', {
        init: function (props) {
            this._super({
                color: 'red',
                asset: _CONST_img_balanceBar,
                type: Q.SPRITE_NONE,
                x: props.x,
                y: props.y
            });
            this.add("bar");
        },
        setLeftWeight: function (weight) {
            if (this.leftWeight == null) {
                this.leftWeight = 0;
            }
            this.leftWeight = this.leftWeight + weight;

        },
        setRightWeight: function (weight) {
            if (this.rightWeight == null) {
                this.rightWeight = 0;
            }
            this.rightWeight = this.rightWeight + weight;

        },
        getOffBalance: function () {
            var left = this.leftWeight == null ? 0 : this.leftWeight;
            var right = this.rightWeight == null ? 0 : this.rightWeight;
            return left - right;
        },
        getOffBalanceDeg: function () {
            return -this.getOffBalance() * _CONST_balanceDegreeFactor;
        },
        setCurrentOffDeg: function (deg) {
            this.currentOffDeg = deg;
        },
        getCurrentOffDeg: function () {
            return this.currentOffDeg == null ? 0 : this.currentOffDeg;
        },
        getLeftEndX: function () {
            var angle = this.p.angle;
            return (this.p.x - (this.p.w / 2 - 15) * Math.cos(angle * Math.PI / 180));

        },
        getLeftEndY: function () {
            var angle = this.p.angle;
            return (this.p.y - (this.p.w / 2 - 15) * Math.sin(angle * Math.PI / 180));
        },
        getRightEndX: function () {
            var angle = this.p.angle;
            return (this.p.x + (this.p.w / 2 - 15) * Math.cos(angle * Math.PI / 180));
        },
        getRightEndY: function () {
            var angle = this.p.angle;
            return (this.p.y + (this.p.w / 2 - 15) * Math.sin(angle * Math.PI / 180));
        },
        setLeftPlate: function (leftPlate) {
            this.leftPlate = leftPlate;
        },
        setRightPlate: function (rightPlate) {
            this.rightPlate = rightPlate;
        },
        getLeftPlate: function () {
            return this.leftPlate;
        },
        getRightPlate: function () {
            return this.rightPlate;
        },
        getMessage: function() {
            var left = this.leftWeight == null ? 0 : this.leftWeight;
            var right = this.rightWeight == null ? 0 : this.rightWeight;
            var operator;
            if (left < right) {
                operator = '<';
            } else if (left > right) {
                operator = '>';
            } else {
                operator = '=';
            }

            return this.getLeftPlate().getItemsStr() + ' ' + operator + ' ' + this.getRightPlate().getItemsStr();
        }
    });


    Q.Sprite.extend('BalancePlate', {
        init: function (props) {
            this._super({
                gravity: 0,
                asset: _CONST_img_balancePlate,
                x: props.x,
                y: props.y,
                z:1,
                name: props.name
            });
            this.name = props.name;
            this.add("plate");
            this.hitItems = [
                []
            ];
            Q.state.on("change.tool", this, "toolChanged");
        },

        toolChanged: function(tool) {
            if ('group' == tool) {
                //  var plateName = this.name;
                group(leftSelectGroup, this);
                group(rightSelectGroup, this);

            }


            function grouping(group, el) {
                var firstItem = group[0];
                var weight = firstItem.myWeight;
                for(var i =1; i < group.length; i++) {
                    weight = weight + group[i].myWeight;
                    el.removeItem(group[i]);
                    el.stage.remove(group[i]);
                    group[i].destroy();
                }
                firstItem.changeWeight(weight);
            }

            function group(selectGroup, el) {
                var group = [];
                for (var i = 0; i < selectGroup.length; i++) {
                    if (el.name == selectGroup[i].plateHit) {
                        group.push(selectGroup[i]);
                    }
                }
                if (group.length > 1) {
                    grouping(group, el);
                }
            }
        },
        getLeftEnd: function () {
            return this.p.x - (_CONST_itemWidth/2 + _CONST_itemWidth + _CONST_itemWidth + _CONST_itemWidth/2); // 20 + 40 + 40 + 20     // new: 30
        },

        getFirstCol: function () {
            return this.p.x - 100; // 20 + 40 + 40 + 20
        },

        getSecondCol: function () {
            return this.p.x - 60; // 20 + 40 + 40 + 20
        },

        getThirdCol: function () {
            return this.p.x - 20; // 20 + 40 + 40 + 20
        },

        getFourthCol: function () {
            return this.p.x + 20; // 20 + 40 + 40 + 20
        },

        getFifthCol: function () {
            return this.p.x + 60; // 20 + 40 + 40 + 20
        },

        getSixthCol: function () {
            return this.p.x + 100; // 20 + 40 + 40 + 20
        },

        getRightEnd: function () {
            return this.p.x + (_CONST_itemWidth/2 + _CONST_itemWidth + _CONST_itemWidth + _CONST_itemWidth/2); // 20 + 40 + 40 + 20
        },
        getColX: function (columnIndex) {
            return this.p.x - (_CONST_itemWidth + _CONST_itemWidth + _CONST_itemWidth/2) + (columnIndex - 1) * _CONST_itemWidth;

        },
        addItemToColumn: function (el, col, row) {
            var items = this.hitItems;
            if (items[col - 1] == null) {
                items[col - 1] = [];
            }
            items[col - 1].push(el);
            el.addedToColumn = col;
            if (row != null) {
                el.addedToRow = row;
            } else {
                el.addedToRow = items[col - 1].length;
            }

        },
        isColFull: function (col) {

            col = col - 1;
            var items = this.hitItems;
            if (items == null) {
                items = [];
            }

            if (items[col] == null) {
                items[col] = [];
            }

            return items[col] != null && items[col].length >= balanceUtil._CONST_maxItemsInOneColumn;
        },
        addItem: function (el) {
            var items = this.hitItems;
            if (items == null) {
                return true;
            }
            if (items[el.column - 1] == null) {
                items[el.column - 1] = [];
            }
            if (items[el.column - 1].length < balanceUtil._CONST_maxItemsInOneColumn) {
                items[el.column - 1].push(el);
                el.addedToColumn = el.column;
                el.addedToRow = items[el.column - 1].length;
            } else {

                // error
                for (var i = 0; i< items.length; i++) {
                    if (items[i].length < balanceUtil._CONST_maxItemsInOneColumn) {
                        var base = (this.p.y - _CONST_balancePlateThickness)- ((items[i].length + 1)* _CONST_itemHeight);
                        var newEl = new Q.Block({weight: el.myWeight,x:this.getColX(i+1) -5 , y:base });
                        newEl.column =  i+1;

                        newEl.add("2d, fallingObject");
                        newEl.p.x = this.getColX(i+1);

                        this.stage.insert(newEl);


                        el.removeWeightAndDestroy();
                        return;
                    }
                }
            }

        },
        removeItem: function (el) {
            var column = el.addedToColumn;
            var row = el.addedToRow;
            var hitItems = this.hitItems[column - 1];
            hitItems.splice(row -1, 1);

            function log(hitItems) {
                for (var i = 0; i < hitItems.length; i++) {
                    if (hitItems[i] != null && hitItems[i].length > 0) {
                        for(var j = 0; j < hitItems[i].length; j ++) {
                            console.log('item at' + hitItems[i][j].addedToColumn + ' ' + hitItems[i][j].addedToRow);
                        }
                    }
                }
            }
        },
        getLastItemOfCol: function(column) {
            var items = this.hitItems;
            if (items == null || items[column -1] == null) {
                return null;
            }
            var lastIndex = items[column -1].length;
            if (lastIndex > 0) {
                return items[column -1][lastIndex - 1];
            } else {
                return null;
            }

        },
        getLengthOfColumn: function (column) {
            var items = this.hitItems;
            if (items == null || items[column -1] == null) {
                return null;
            }
            var lastIndex = items[column -1].length;
            if (lastIndex > 0) {
                return lastIndex;
            } else {
                return 0;
            }
        },
        getItemsStr : function() {
            var str = '';

            if (this.hitItems != null && this.hitItems.length > 0) {
                for (var i = 0; i < this.hitItems.length; i++) {
                    for (var j = 0; j < this.hitItems[i].length; j ++) {
                        if ((this.hitItems[i][j].isVariable != null && this.hitItems[i][j].isVariable)) {
                            str = str + 'x' +' + ';
                        } else {
                            str = str + this.hitItems[i][j].myWeight + ' + ';
                        }
                    }
                }
            }
            return str == '' ? 0 : str.slice(0, -3);
        },
        validateExceed: function(group) {
            var totalItem = 0;
            for(var i = 0; i < this.hitItems.length; i++) {
                totalItem = totalItem + this.hitItems[i].length;
            }
            totalItem = totalItem + ((group == null) ? 1 : group.length);
            if (totalItem >  balanceUtil._CONST_maxItemsOnOnePan) {
                return false;
            } else {
                return true;
            }
        },
        validateNumberExceed : function(noToBeAdded) {
            var totalItem = 0;
            for(var i = 0; i < this.hitItems.length; i++) {
                totalItem = totalItem + this.hitItems[i].length;
            }
            if (totalItem + noToBeAdded > balanceUtil._CONST_maxItemsOnOnePan) {
                return false;
            } else {
                return true;
            }
        }
    });

    Q.scene("Grade4", function (stage) {
        // set up balance
        setupBalance(stage);
        var leftContainer = new Q.LeftContainer({asset: _CONST_img_indicator,
            type: Q.SPRITE_NONE,
            width: Q.width / 15,
            height:Q.height - _CONST_left_container_adjust,
            y: 10,
            x: 10,
            z: 0});
        stage.insert(leftContainer);
        leftContainer.insertSideTab();
        leftContainer.insertTopScroll();
        leftContainer.insertBottomScroll();
        leftContainer.insert(new Q.Block({isVariable: true, weight: 0}));
        leftContainer.insert(new Q.Block({weight: 0}));
        for (var i = 1; i <=9; i++) {
            leftContainer.insert(new Q.Block({weight: i}));
        }

        for (var i = 1; i <=9; i++) {
            leftContainer.insert(new Q.Block({weight: i*10}));
        }


        var panel = stage.insert(new Q.UI.Container({
            fill: "white",
            border: 1,
            stroke: '#2EB6E9',
            y: 50,
            x: 3*Q.width/4,
            w: Q.width/3,
            h: 40
        }));

        stage.insert(new Q.UI.Text({
            label: "",
            color: "black",
            x: 0,
            y: -20
        }), panel);

        // Setup Bin
//        Q.debug = true;



    }, { sort: true });


    Q.scene("Grade5", function (stage) {
        setupBalance(stage);
        var leftContainer = new Q.LeftContainer({asset: _CONST_img_indicator,
            type: Q.SPRITE_NONE,
            width: Q.width / 15,
            height: Q.height - _CONST_left_container_adjust,
            y: 10,
            x: 10,
            z: 0});
        stage.insert(leftContainer);
        leftContainer.insertSideTab();
        leftContainer.insertTopScroll();
        leftContainer.insertBottomScroll();
        leftContainer.insert(new Q.Block({isVariable: true, weight: 0}));
        leftContainer.insert(new Q.Block({weight: 1}));
        leftContainer.insert(new Q.Block({weight: -1}));
//        for (var i = 1; i <=9; i++) {
//            leftContainer.insert(new Q.Block({weight: i}));
//        }
//
//        for (var i = 1; i <=9; i++) {
//            leftContainer.insert(new Q.Block({weight: i*10}));
//        }


        var panel = stage.insert(new Q.UI.Container({
            fill: "white",
            border: 1,
            y: 50,
            x: 3*Q.width/4,
            w: 600,
            h: 50
        }));

        stage.insert(new Q.UI.Text({
            label: "",
            color: "black",
            x: 0,
            y: -10
        }), panel);

        // Setup Bin
//        Q.debug = true;


    }, { sort: true });


    this.grade4 =  function grade4() {
        Q.load("balanceCenter.png, balanceBar.png, balancePlate.png, indicatorBoard.png, indicator.png, indicatorGlass.png, pointer.png, side_tab.png,down_arrow.png, up_arrow.png," +
            "weights_0.png, weights_1.png, weights_2.png, weights_3.png, weights_4.png, weights_5.png, weights_6.png, weights_7.png, weights_8.png, weights_9.png, plus-x.png", function () {

            // start grade 4
            Q.stageScene("Grade4");
            Q.state.set("tool", 'select');

        });
    }

    this.grade5 =  function grade5() {
        Q.load("balanceCenter.png, balanceBar.png, balancePlate.png, indicatorBoard.png, indicator.png, indicatorGlass.png, pointer.png, side_tab.png,down_arrow.png, up_arrow.png," +
            "weights_0.png, weights_1.png, weights_2.png, weights_3.png, weights_4.png, weights_5.png, weights_6.png, weights_7.png, weights_8.png, weights_9.png, plus-x.png", function () {

            // start grade 4
            Q.stageScene("Grade5");
            Q.state.set("tool", 'select');

        });
    }

    this.grade4retina =  function grade4retina() {
        _CONST_balancePlateThickness = 21;
        _CONST_balanceBaseY = 470;   // The Y cordinate of the Balance Base
        _CONST_balanceIndicatorBoardYOffset = 55;   // Is the offsetY of the indicator to the base
        _CONST_lightIndicatorRadius = 20;
        _CONST_plateWidth = 0;
        _CONST_itemWidth = 60;
        _CONST_itemHeight = 55;
        _CONST_pointer_adjust = 50;
        _CONST_left_container_adjust = 50;

        _CONST_blockLabelFont = '900 25px arial';


        _CONST_img_balanceBar = 'balanceBar@2x.png';
        _CONST_img_balanceCenter = 'balanceCenter@2x.png';
        _CONST_img_balancePlate = 'balancePlate@2x.png';
        _CONST_img_down_arrow = 'down_arrow@2x.png';
        _CONST_img_indicator = 'indicator@2x.png';
        _CONST_img_indicatorBoard = 'indicatorBoard@2x.png';
        _CONST_img_indicatorGlass = 'indicatorGlass@2x.png';
        _CONST_img_pointer = 'pointer@2x.png';
        _CONST_img_side_tab = 'side_tab@2x.png';
        _CONST_img_up_arrow = 'up_arrow@2x.png';
        _CONST_img_plus_x = 'plus-x@2x.png';
        _CONST_img_prefix = '@2x.png';

        Q.load("balanceCenter@2x.png, balanceBar@2x.png, balancePlate@2x.png, indicatorBoard@2x.png, indicator@2x.png, indicatorGlass@2x.png, pointer@2x.png, side_tab@2x.png,down_arrow@2x.png, up_arrow@2x.png," +
                "weights_0@2x.png, weights_1@2x.png, weights_2@2x.png, weights_3@2x.png, weights_4@2x.png, weights_5@2x.png, weights_6@2x.png, weights_7@2x.png, weights_8@2x.png, weights_9@2x.png, plus-x@2x.png", function () {

                // start grade 4
            Q.stageScene("Grade4");
            Q.state.set("tool", 'select');

        });
    }

    this.grade5retina =  function grade5retina() {
        _CONST_balancePlateThickness = 21;
        _CONST_balanceBaseY = 470;   // The Y cordinate of the Balance Base
        _CONST_balanceIndicatorBoardYOffset = 55;   // Is the offsetY of the indicator to the base
        _CONST_lightIndicatorRadius = 20;
        _CONST_plateWidth = 0;
        _CONST_itemWidth = 60;
        _CONST_itemHeight = 55;
        _CONST_pointer_adjust = 50;
        _CONST_left_container_adjust = 50;

        _CONST_blockLabelFont = '900 25px arial';



        _CONST_img_balanceBar = 'balanceBar@2x.png';
        _CONST_img_balanceCenter = 'balanceCenter@2x.png';
        _CONST_img_balancePlate = 'balancePlate@2x.png';
        _CONST_img_down_arrow = 'down_arrow@2x.png';
        _CONST_img_indicator = 'indicator@2x.png';
        _CONST_img_indicatorBoard = 'indicatorBoard@2x.png';
        _CONST_img_indicatorGlass = 'indicatorGlass@2x.png';
        _CONST_img_pointer = 'pointer@2x.png';
        _CONST_img_side_tab = 'side_tab@2x.png';
        _CONST_img_up_arrow = 'up_arrow@2x.png';
        _CONST_img_plus_x = 'plus-x@2x.png';
        _CONST_img_prefix = '@2x.png';

        Q.load("balanceCenter@2x.png, balanceBar@2x.png, balancePlate@2x.png, indicatorBoard@2x.png, indicator@2x.png, indicatorGlass@2x.png, pointer@2x.png, side_tab@2x.png,down_arrow@2x.png, up_arrow@2x.png," +
            "weights_0@2x.png, weights_1@2x.png, weights_2@2x.png, weights_3@2x.png, weights_4@2x.png, weights_5@2x.png, weights_6@2x.png, weights_7@2x.png, weights_8@2x.png, weights_9@2x.png, plus-x@2x.png", function () {

            // start grade 4
            Q.stageScene("Grade5");
            Q.state.set("tool", 'select');

        });
    }




};


