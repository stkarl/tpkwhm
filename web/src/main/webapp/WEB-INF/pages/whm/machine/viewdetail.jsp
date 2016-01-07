<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@page import="com.banvien.tpk.core.Constants" %>
<html>
<head>
    <title><fmt:message key="whm.machine.title"/></title>
    <meta name="heading" content="<fmt:message key="whm.machine.title"/>"/>
    <link rel="stylesheet" href="<c:url value='/themes/whm/css/jquery.jscrollpane.css' />" />
    <link rel="stylesheet" href="<c:url value='/themes/whm/css/jquery.treegrid.css' />" />
    <link rel="stylesheet" href="<c:url value='/themes/whm/css/component_tree.css' />" />

    <link rel="stylesheet" href="<c:url value="/styles/tpk/galleriffic/galleriffic.css"/>" type="text/css" />
    <link rel="stylesheet" href="<c:url value="/scripts/fancybox/source/jquery.fancybox.css"/>" type="text/css" />
    <link rel="stylesheet" href="<c:url value="/scripts/fancybox/source/helpers/jquery.fancybox-thumbs.css"/>" type="text/css" />

    <style type="text/css">
        .fancybox-custom .fancybox-skin {
            box-shadow: 0 0 50px #222;
        }
    </style>

</head>

<c:url var="url" value="/whm/machine/view.html"/>
<c:url var="backUrl" value="/whm/machine/list.html"/>
<body>
<div class="ajax-progress"></div>
<div id="machineContent">
    <%@ include file="machineContent.jsp"%>
</div>


<div id="uploadPictureBox" class="modal hide fade in" style="display: none;">
    <div class="modal-header">
        <a class="close" data-dismiss="modal">×</a>
        <h3 id="uploadPictureHeader"></h3>
    </div>
    <div class="modal-body">
        <form id="uploadForm" enctype="multipart/form-data">
            <c:forEach begin="0" end="5" step="1" varStatus="status">
                <label class="label"><fmt:message key="label.file"></fmt:message></label>
                <input type="file" class="input-xlarge file-path" name="path-${status.index}"><br>

                <%--<label class="label"><fmt:message key="label.description"></fmt:message></label>--%>
                <%--<textarea name="picDes[${status.index}]" class="file-des" style="width: 450px;height: 120px;"></textarea>--%>
            </c:forEach>
            <input type="hidden" id="upFor" name="upFor">
        </form>
    </div>
    <div class="modal-footer">
        <a id='uploadButton' class="btn btn-success" onclick="uploadMachinePicture();"><fmt:message key="upload.picture"></fmt:message> </a>
        <a data-dismiss="modal" class="btn" style="color: #000000;" href="#"><fmt:message key="button.cancel"></fmt:message></a>
    </div>
</div>

<div id="addComponentBox" class="modal hide fade in" style="display: none;">
    <div class="modal-header">
        <a class="close" data-dismiss="modal">×</a>
        <h3 id="modalHeader"></h3>
    </div>
    <div class="modal-body">
        <label class="label"><fmt:message key="label.name"></fmt:message></label><br>
        <input id="componentName" type="text" class="input-xlarge"><br>
        <label class="label"><fmt:message key="label.code"></fmt:message></label><br>
        <input id="componentCode" type="text" class="input-xlarge"><br>
        <label class="label"><fmt:message key="label.description"></fmt:message></label><br>
        <textarea id="componentDescription" style="width: 550px;height: 120px;"></textarea>
    </div>
    <div class="modal-footer">
        <a id='formButton' class="btn btn-success" onclick="addComponent();"><fmt:message key="button.save"></fmt:message> </a>
        <a data-dismiss="modal" class="btn" style="color: #000000;" href="#"><fmt:message key="button.cancel"></fmt:message></a>
    </div>
</div>

<div id="duplicateComponentBox" class="modal hide fade in" style="display: none;">
    <div class="modal-header">
        <a class="close" data-dismiss="modal">×</a>
        <h3>Nhân bản số lượng linh kiện</h3>
    </div>
    <div class="modal-body">
        <span id="eMsg" style="color: #ff0000"></span><br>
        <label class="label">Linh kiện</label><br>
        <span id="component-info"></span><br>
        <label class="label" style="margin-top: 6px;">Tổng số lượng</label><br>
        <input id="componentNo" type="text" class="input-xlarge inputNumber"><br>
    </div>
    <div class="modal-footer">
        <a id="dupButton" class="btn btn-success"><fmt:message key="button.save"></fmt:message> </a>
        <a data-dismiss="modal" class="btn" style="color: #000000;" href="#"><fmt:message key="button.cancel"></fmt:message></a>
    </div>
</div>

<div id="maintainComponentBox" class="modal hide fade in" style="display: none;">
    <div class="modal-header">
        <a class="close" data-dismiss="modal">×</a>
        <h3>Bảo dưỡng linh kiện</h3>
    </div>
    <div class="modal-body">
        <span id="eMaintainCompMsg" style="color: #ff0000"></span><br>
        <label class="label">Linh kiện</label><br>
        <span id="component-maintain-info"></span><br>

        <label class="label" style="margin-top: 6px;">Ngày bảo dưỡng</label><br>
        <input id="componentDate" type="text" class="datePicker prevent_type text-center" style="width: 90px;"><br>

        <label class="label" style="margin-top: 6px;">Hẹn bảo dưỡng tiếp sau(số ngày)</label><br>
        <input id="componentNoDay" type="text" class="inputNumber" style="width: 30px;"><br>

        <label class="label" style="margin-top: 6px;">Tình trạng</label><br>
        <div class="btn-group" data-toggle-name="is_private" data-toggle="buttons-radio">
            <button type="button" value="${Constants.MACHINE_NORMAL}" class="btn compStatus active" data-toggle="button"><fmt:message key="label.normal"/></button><button type="button" value="${Constants.MACHINE_WARNING}" class="btn compStatus" data-toggle="button"><fmt:message key="label.need.maintenance"/></button><button type="button" value="${Constants.MACHINE_STOP}" class="btn compStatus" data-toggle="button"><fmt:message key="label.machine.stop"/></button>
        </div>
        <br>
        <label class="label" style="margin-top: 6px;"><fmt:message key="label.description"></fmt:message></label><br>
        <textarea id="component-maintain-des" style="width: 550px;height: 120px;"></textarea>
    </div>
    <div class="modal-footer">
        <a id="mtCompButton" class="btn btn-success"><fmt:message key="button.save"></fmt:message> </a>
        <a data-dismiss="modal" class="btn" style="color: #000000;" href="#"><fmt:message key="button.cancel"></fmt:message></a>
    </div>
</div>

<div id="maintainMachineBox" class="modal hide fade in" style="display: none;">
    <div class="modal-header">
        <a class="close" data-dismiss="modal">×</a>
        <h3>Bảo dưỡng máy - thiết bị</h3>
    </div>
    <div class="modal-body">
        <span id="eMaintainMachineMsg" style="color: #ff0000"></span><br>
        <label class="label">Máy - thiết bị</label><br>
        <span id="machine-maintain-info">${item.pojo.code} - ${item.pojo.name}</span><br>

        <label class="label" style="margin-top: 6px;">Ngày bảo dưỡng</label><br>
        <input id="machineDate" type="text" class="datePicker prevent_type text-center" style="width: 90px;"><br>

        <label class="label" style="margin-top: 6px;">Hẹn bảo dưỡng tiếp sau(số ngày)</label><br>
        <input id="machineNoDay" type="text" class="inputNumber" style="width: 30px;"><br>

        <label class="label" style="margin-top: 6px;">Tình trạng</label><br>

        <div class="btn-group" data-toggle-name="is_private" data-toggle="buttons-radio">
            <button type="button" value="${Constants.MACHINE_NORMAL}" class="btn machineStatus active" data-toggle="button"><fmt:message key="label.normal"/></button><button type="button" value="${Constants.MACHINE_WARNING}" class="btn machineStatus" data-toggle="button"><fmt:message key="label.need.maintenance"/></button><button type="button" value="${Constants.MACHINE_STOP}" class="btn machineStatus" data-toggle="button"><fmt:message key="label.machine.stop"/></button>
        </div>
        <br>
        <label class="label" style="margin-top: 6px;"><fmt:message key="label.description"></fmt:message></label><br>
        <textarea id="machine-maintain-des" style="width: 550px;height: 120px;"></textarea>
    </div>
    <div class="modal-footer">
        <a id="mtMachineButton" class="btn btn-success"><fmt:message key="button.save"></fmt:message> </a>
        <a data-dismiss="modal" class="btn" style="color: #000000;" href="#"><fmt:message key="button.cancel"></fmt:message></a>
    </div>
</div>
<script type="text/javascript" src="<c:url value='/scripts/jquery/jquery.mousewheel.js'/>"></script>
<script src="<c:url value="/themes/whm/scripts/bootstrap/jscrollpane.js"/>"></script>
<%--<script type="text/javascript" src="<c:url value="/scripts/jquery/jquery-ui-1.10.4.min.js"/>"></script>--%>
<script src="<c:url value="/scripts/jquery.treegrid.js"/>"></script>
<script type="text/javascript" src="/scripts/jquery.treegrid.bootstrap2.js"></script>
<script type="text/javascript" src="<c:url value="/scripts/fancybox/lib/jquery.mousewheel-3.0.6.pack.js"/>"></script>
<script type="text/javascript" src="<c:url value="/scripts/fancybox/source/jquery.fancybox.js"/>"></script>
<script type="text/javascript" src="<c:url value="/scripts/fancybox/source/helpers/jquery.fancybox-thumbs.js"/>"></script>



<script>

    $(document).ready(function(){
        $(".datePicker").each(function(){
            var $this = $(this).datepicker({
                format: 'dd/mm/yyyy',
                autoclose: true
            }).on('changeDate', function(ev) {
                        $this.hide();
                    }).data('datepicker');
        });

        $('.tree').treegrid();

        $('.fancybox-thumbs').fancybox({
            prevEffect : 'none',
            nextEffect : 'none',

            closeBtn  : false,
            arrows    : false,
            nextClick : true,

            helpers : {
                thumbs : {
                    width  : 50,
                    height : 50
                }
            }
        });

        /*
         *  Media helper. Group items, disable animations, hide arrows, enable media and button helpers.
         */
        $('.fancybox-media')
                .attr('rel', 'media-gallery')
                .fancybox({
                    openEffect : 'none',
                    closeEffect : 'none',
                    prevEffect : 'none',
                    nextEffect : 'none',

                    arrows : false,
                    helpers : {
                        media : {},
                        buttons : {}
                    }
                });

    });

    function showAddComponentForm() {
        $('#formButton').attr('onclick', 'addComponent()');
        $('#modalHeader').html('<fmt:message key="label.add.component"/>');
        showConfirmBox();
    }

    function showEditComponentForm(comID) {
        $('#formButton').attr('onclick', 'editComponent('+comID+')');
        $('#modalHeader').html('<fmt:message key="label.edit.component"/>');
        showConfirmBox();
        $('#componentCode').val($.trim($('#cCode-' + comID).text()));
        $('#componentName').val($.trim($('#cName-' + comID).html()));
        $('#componentDescription').val($.trim($('#cDes-' + comID).html()));
    }

    function showAddSubComponentForm(compID) {
        $('#formButton').attr('onclick', 'addSubComponent('+compID+')');
        $('#modalHeader').html('<fmt:message key="label.add.sub.component"/>');
        showConfirmBox();
    }

    function deleteComponent(comId){
        bootbox.confirm('Xác nhận xóa dữ liệu', 'Bạn có chắc chắn muốn xóa phần tử này không', function(r) {
            if(r){
                if(comId != null && comId != undefined){
                    $.ajax({
                        type: "POST",
                        dataType: "json",
                        data:{'componentID':comId},
                        url: '<c:url value="/ajax/deleteComponent.html"/>',
                        success: function(result){
                            bootbox.alert('Thông báo', 'Xóa phần tử thành công!', function(){
                                    window.location.reload();
                            });
                        }
                    });
                }
            }
        });
    }

    function showDuplicateComponent(comID) {
        $('#dupButton').attr('onclick', 'duplicateComponent('+comID+')');
        var $modal = $('#duplicateComponentBox');
        $modal.modal();

        var comInfo =  $.trim($('#cCode-' + comID).text())  + ' - ' +  $.trim($('#cName-' + comID).html());
        $('#component-info').text(comInfo);
        $('#componentNo').val('');
        $('#eMsg').text('');

    }

    function showMaintainComponent(comID) {
        $('#mtCompButton').attr('onclick', 'maintainComponent('+comID+')');
        var $modal = $('#maintainComponentBox');
        $modal.modal();

        var comInfo =  $.trim($('#cCode-' + comID).text())  + ' - ' +  $.trim($('#cName-' + comID).html());
        $('#component-maintain-info').text(comInfo);
        $('#componentDate').val('');
        $('#componentNoDay').val('');

        $('#component-maintain-des').val('');
        $('#eMaintainCompMsg').text('');
    }

    function showMaintainMachine() {
        $('#mtMachineButton').attr('onclick', 'maintainMachine()');
        var $modal = $('#maintainMachineBox');
        $modal.modal();

        $('#machineDate').val('');
        $('#machineNoDay').val('');
        $('#machine-maintain-des').val('');
        $('#eMaintainMachineMsg').text('');
    }

    function maintainComponent(comId){
        var no = $('#componentDate').val();
        if(comId != null && comId != undefined && no != ''){
            $.ajax({
                type: "POST",
                dataType: "json",
                data:{'componentID': comId,
                    'componentDate': $('#componentDate').val(),
                    'componentNoDay': $('#componentNoDay').val(),
                    'maintainDes': $('#component-maintain-des').val(),
                    'status': $('.compStatus.active').val()
                },
                url: '<c:url value="/ajax/maintainComponent.html"/>',
                success: function(result){
                    if(result.msg == 'success'){
                        $('#maintainComponentBox').modal('toggle');
                        bootbox.alert('Thông báo', 'Bảo dưỡng thành công!', function() {
                                window.location.reload();
                        });
                    }else{
                        $('#eMaintainCompMsg').text('Có lỗi, vui lòng thử lại!');
                    }

                }
            });
        }else{
            $('#eMaintainCompMsg').text('Chưa chọn ngày bảo dưỡng');
            $('#componentDate').focus();
        }
    }

    function maintainMachine(){
        var no = $('#machineDate').val();
        if(no != ''){
            $.ajax({
                type: "POST",
                dataType: "json",
                data:{'machineID': '${item.pojo.machineID}',
                    'machineDate': $('#machineDate').val(),
                    'machineNoDay': $('#machineNoDay').val(),
                    'maintainDes': $('#machine-maintain-des').val(),
                    'status': $('.machineStatus.active').val()
                },
                url: '<c:url value="/ajax/maintainMachine.html"/>',
                success: function(result){
                    if(result.msg == 'success'){
                        $('#maintainMachineBox').modal('toggle');
                        bootbox.alert('Thông báo', 'Bảo dưỡng thành công!', function() {
                            window.location.reload();
                        });
                    }else{
                        $('#eMaintainMachineMsg').text('Có lỗi, vui lòng thử lại!');
                    }

                }
            });
        }else{
            $('#eMaintainMachineMsg').text('Chưa chọn ngày bảo dưỡng');
            $('#machineDate').focus();
        }
    }

    function duplicateComponent(comId){
        var no = $('#componentNo').val();
        if(comId != null && comId != undefined && no != ''){
            $.ajax({
                type: "POST",
                dataType: "json",
                data:{'componentID':comId, 'numberOfComponent' : no},
                url: '<c:url value="/ajax/duplicateComponent.html"/>',
                success: function(result){
                    if(result.msg == 'success'){
                        bootbox.alert('Thông báo', 'Nhân bản thành công!', function(){
                            window.location.reload();
                        });
                    }else{
                        $('#eMsg').text('Có lỗi, vui lòng thử lại!');
                    }

                }
            });
        }
    }



    function showConfirmBox() {
        $('#errorDiv').html('');
        $('#errorDiv').hide();
        $('#componentCode').val('');
        $('#componentName').val('');
        $('#componentDescription').val('');
        var $modal = $('#addComponentBox');
        $modal.modal();
    }


    function validateNotEmpty() {
        if ($('#componentCode').val().trim() == '' || $('#componentName').val().trim() == '') {
            $('#errorDiv').show();
            $('#errorDiv').html("Vui lòng điền dủ thông tin!");
            return false;
        }
        return true;
    }

    function addComponent() {
        if (!validateNotEmpty()) {
            return false;
        }
        $.ajax({
            type: "POST",
            url:  '<c:url value="/ajax/addComponent.html"/>',
            dataType: 'html',
            data:{'machineID': ${item.pojo.machineID},
                  'componentCode': $('#componentCode').val(),
                  'componentName': $('#componentName').val(),
                  'componentDescription': $('#componentDescription').val()
            },
            complete : function(res){
                if (res.responseText != ''){
                    bootbox.alert('Thông báo', 'Thêm linh kiện thành công!', function(){
                        window.location.reload();
                    });
                }else{
                    $('#errorDiv').show();
                    $('#errorDiv').html('Có lỗi xảy ra!');
                }
            }
        });
    }

    function addSubComponent(compID) {
        if (!validateNotEmpty()) {
            return false;
        }
        $.ajax({
            type: "POST",
            url:  '<c:url value="/ajax/addSubComponent.html"/>',
            dataType: 'html',
            data:{'parentID': compID,
                'componentCode': $('#componentCode').val(),
                'componentName': $('#componentName').val(),
                'componentDescription': $('#componentDescription').val()
            },
            complete : function(res){
                if (res.responseText != ''){
                    bootbox.alert('Thông báo', 'Thêm linh kiện con thành công!', function(){
                        window.location.reload();
                    });
                }else{
                    $('#errorDiv').show();
                    $('#errorDiv').html('Có lỗi xảy ra!');
                }
            }
        });
    }

    function editComponent(componentId) {
        if (!validateNotEmpty()) {
            return false;
        }

        $.ajax({
            type: "POST",
            url:  '<c:url value="/ajax/editComponent.html"></c:url>',
            dataType: 'html',
            data:{'componentID': componentId,
                'componentCode': $('#componentCode').val(),
                'componentName': $('#componentName').val(),
                'componentDescription': $('#componentDescription').val()
                },
            complete : function(res){
                if (res.responseText != ''){
                    bootbox.alert('Thông báo', 'Đổi thông tin linh kiện thành công!', function(){
                        window.location.reload();
                    });
                }else{
                    $('#errorDiv').show();
                    $('#errorDiv').html('Có lỗi xảy ra!');
                }
            }
        });
    }

    function showMachineLog() {
        $.ajax({
            type: "POST",
            url:  '<c:url value="/ajax/machineLog.html"/>',
            dataType: 'html',
            data:{'machineID': '${item.pojo.machineID}'},
            complete : function(res){
                if (res.responseText != ''){
                    var form = $(res.responseText);
                    var modal = bootbox.dialog(form, [
                        {
                            "label" :  "<i class='icon-remove-sign'></i> <fmt:message key="button.cancel"/>",
                            "class" : "btn-small btn-primary",
                            "callback" : function(){
                                form.remove();

                            }
                        }],
                            {
                                "onEscape": function(){
                                    form.remove();
                                }
                            });
                    modal.modal("show");
                    $('#tbLogs').jScrollPane({contentWidth : 550});
                }
            }
        });
    }

    function showComponentLog(comID) {
        $.ajax({
            type: "POST",
            url:  '<c:url value="/ajax/componentLog.html"/>',
            dataType: 'html',
            data:{'machineComponentID': comID},
            complete : function(res){
                if (res.responseText != ''){
                    var form = $(res.responseText);
                    var modal = bootbox.dialog(form, [
                        {
                            "label" :  "<i class='icon-remove-sign'></i> <fmt:message key="button.cancel"/>",
                            "class" : "btn-small btn-primary",
                            "callback" : function(){
                                form.remove();

                            }
                        }],
                            {
                                "onEscape": function(){
                                    form.remove();
                                }
                            });
                    modal.modal("show");
                    $('#tbLogs').jScrollPane({contentWidth : 550});
                }
            }
        });
    }

    function submitForConfirm(machineId){
        bootbox.confirm('Xác nhận trình duyệt', 'Bạn có chắc muốn trình duyệt ko? Sau khi được duyệt, sẽ không thể xóa, sửa thông tin toàn bộ hệ thống máy - linh kiện này!', function(r) {
            if(r){
                $.ajax({
                    type: "POST",
                    dataType: "json",
                    data:{'machineID':machineId},
                    url: '<c:url value="/ajax/submitMachine.html"/>',
                    success: function(result){
                        if(result.msg == 'success'){
                            bootbox.alert('Thông báo', 'Trình duyệt thành công!', function(){
                                window.location.reload();
                            });
                        }else{
                            $('#eMsg').text('Có lỗi, vui lòng thử lại!');
                        }
                    }
                });
            }
        });

    }

    function rejectMachine(machineId){
        bootbox.confirm('Xác nhận từ chối', 'Bạn có chắc muốn từ chối? Sau khi từ chối, nhân viên sẽ được phép sửa thông tin máy để trình duyệt lại ', function(r) {
            if(r){
                $.ajax({
                    type: "POST",
                    dataType: "json",
                    data:{'machineID':machineId},
                    url: '<c:url value="/ajax/submitRejectMachine.html"/>',
                    success: function(result){
                        if(result.msg == 'success'){
                            bootbox.alert('Thông báo', 'Từ chối thành công!', function(){
                                window.location.reload();
                            });
                        }else{
                            $('#eMsg').text('Có lỗi, vui lòng thử lại!');
                        }
                    }
                });
            }
        });
    }

    function approveMachine(machineId){
        bootbox.confirm('Xác nhận đồng ý', 'Bạn có chắc muốn chấp thuận? Sau khi chấp thuận , thông tin lý lịch máy này sẽ không thể thay đổi! ', function(r) {
            if(r){
                $.ajax({
                    type: "POST",
                    dataType: "json",
                    data:{'machineID':machineId},
                    url: '<c:url value="/ajax/submitApproveMachine.html"/>',
                    success: function(result){
                        if(result.msg == 'success'){
                            bootbox.alert('Thông báo', 'Chấp thuận thành công!', function(){
                                window.location.reload();
                            });
                        }else{
                            $('#eMsg').text('Có lỗi, vui lòng thử lại!');
                        }
                    }
                });
            }
        });
    }

    function showUploadMachine(id) {
        $('#uploadButton').attr('onclick', 'uploadMachinePicture()');
        $('#uploadPictureHeader').html('<fmt:message key="label.upload.machine.picture"/>');
        showUploadBox(id);
    }

    function showUploadBox(id) {
        $('#errorDiv').html('');
        $('#errorDiv').hide();
        $('.file-path').val('');
        $('.file-des').val('');
        $('#upFor').val(id);
        var $modal = $('#uploadPictureBox');
        $modal.modal();
    }


    function uploadMachinePicture() {
        var formData = new FormData($('#uploadForm')[0]);
        $(".ajax-progress").show();
        $.ajax({
            url:  '<c:url value="/ajax/machineUpload.html"/>',
            type: "POST",
            data: formData,
            async: false,
            cache: false,
            contentType: false,
            processData: false,
            success: function (returndata) {
                window.location.reload();
            },
            error: function(){
                $('#errorDiv').show();
                $('#errorDiv').html('Tải hình thất bại, vui lòng thử lại!');
                $(".ajax-progress").hide();
            }
        });
    }

    function deleteMachinePicture(id){
        bootbox.confirm('Xác nhận xóa hình', 'Xác nhận đồng ý xóa hình', function(r) {
            if(r){
                $.ajax({
                    url:  '<c:url value="/ajax/deleteMachinePicture.html"/>',
                    type: "POST",
                    data: {machinePictureID : id},
                    success: function (returndata) {
                        $('#machine-pic-' + id).remove();
                    },
                    error: function(){
                        bootbox.alert('Thông báo', 'Chưa xóa được, vui lòng thử lại!', function(){
                        });
                    }
                });
            }
        });
    }

    function showUploadComponent(id) {
        $('#uploadButton').attr('onclick', 'uploadComponentPicture()');
        $('#uploadPictureHeader').html('<fmt:message key="label.upload.component.picture"/>');
        showUploadBox(id);
    }


    function uploadComponentPicture() {
        var formData = new FormData($('#uploadForm')[0]);
        $(".ajax-progress").show();
        $.ajax({
            url:  '<c:url value="/ajax/componentUpload.html"/>',
            type: "POST",
            data: formData,
            async: false,
            cache: false,
            contentType: false,
            processData: false,
            success: function (returndata) {
                window.location.reload();
            },
            error: function(){
                $('#errorDiv').show();
                $('#errorDiv').html('Tải hình thất bại, vui lòng thử lại!');
                $(".ajax-progress").hide();
            }
        });
    }

    function deleteComponentPicture(id){
        bootbox.confirm('Xác nhận xóa hình', 'Xác nhận đồng ý xóa hình', function(r) {
            if(r){
                $.ajax({
                    url:  '<c:url value="/ajax/deleteComponentPicture.html"/>',
                    type: "POST",
                    data: {componentPictureID : id},
                    success: function (returndata) {
                        $('#machine-pic-' + id).remove();
                    },
                    error: function(){
                        bootbox.alert('Thông báo', 'Chưa xóa được, vui lòng thử lại!', function(){
                        });
                    }
                });
            }
        });
    }
</script>
</body>

</html>


