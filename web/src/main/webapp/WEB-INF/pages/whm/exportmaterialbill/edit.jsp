<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" errorPage="/error.jsp" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@page import="com.banvien.tpk.core.Constants" %>
<head>
    <title><fmt:message key="whm.export.material.title"/></title>
    <meta name="heading" content="<fmt:message key="whm.export.material.title"/>"/>
</head>

<c:url var="url" value="/whm/exportmaterialbill/edit.html"/>
<c:url var="backUrl" value="/whm/exportmaterialbill/list.html"/>
<form:form commandName="item" action="${url}" method="post" id="itemForm" class="form-horizontal" novalidate="novalidate">
    <div id="container-fluid data_content_box">
        <div class="row-fluid data_content">
            <div class="content-header"><fmt:message key="whm.export.material.declare"/></div>
            <div class="clear"></div>
            <div class="guideline">
                <span>(<span class="required">*</span>): là bắt buộc.</span>
                <div style="clear:both"></div>
            </div>
            <div class="alert alert-error" style="display: none;">
                <a onclick="closeAlert();" href="#" style="float: right;font-size: larger;color: #C5B0C2;">&times;</a>
                Hãy nhập đủ thông tin bắt buộc trước khi lưu.
            </div>
            <table class="tbHskt info">
                <caption><fmt:message key="import.material.generalinfo"/></caption>
                <tr>
                    <td><fmt:message key="label.number"/></td>
                    <td colspan="2">
                        <span>${item.pojo.code}</span>
                        <form:hidden path="pojo.code"/>
                    </td>
                    <td class="wall"><fmt:message key="label.export.type"/> <span id="rq_exporttype" class="required">*</span></td>
                    <td colspan="2">
                        <form:select path="pojo.exporttype.exportTypeID" cssClass="required" onchange="loadRelated(this);">
                            <form:option value="">-<fmt:message key="label.select"/>-</form:option>
                            <c:forEach items="${exporttypes}" var="exporttype">
                                <form:option code="${exporttype.code}" value="${exporttype.exportTypeID}">${exporttype.name}</form:option>
                            </c:forEach>
                        </form:select>
                    </td>

                </tr>
                <tr id="relatedInfo" style="display: none;">
                    <td class="wall">
                        <span id="warehouse" style="display: none;">
                            <fmt:message key="warehouse.receive"/> <span id="rq_receiver" class="required">*</span>
                        </span>
                        <span id="customer" style="display: none;">
                        <fmt:message key="label.customer"/> <span id="rq_customer" class="required">*</span>
                        </span>
                        <span id="plan" style="display: none;">
                        <fmt:message key="whm.productionplan.name"/> <span id="rq_plan" class="required">*</span>
                        </span>
                    </td>
                    <td colspan="2">
                        <form:select path="pojo.receiveWarehouse.warehouseID" id="sl_warehouse" cssStyle="display: none;">
                            <form:option value="">-<fmt:message key="label.select"/>-</form:option>
                            <c:forEach items="${warehouses}" var="warehouse">
                                <form:option value="${warehouse.warehouseID}">${warehouse.name}</form:option>
                            </c:forEach>
                        </form:select>
                        <form:select path="pojo.customer.customerID" id="sl_customer" cssStyle="display: none;">
                            <form:option value="">-<fmt:message key="label.select"/>-</form:option>
                            <c:forEach items="${customers}" var="customer">
                                <form:option value="${customer.customerID}">${customer.name} - ${customer.address} </form:option>
                            </c:forEach>
                        </form:select>

                        <form:select path="pojo.productionPlan.productionPlanID" id="sl_plan" cssStyle="display: none;">
                            <form:option value="">-<fmt:message key="label.select"/>-</form:option>
                            <c:forEach items="${productionPlans}" var="productionPlan">
                                <form:option value="${productionPlan.productionPlanID}">${productionPlan.name}</form:option>
                            </c:forEach>
                        </form:select>
                    </td>
                    <td class="wall"></td>
                    <td colspan="2"></td>
                </tr>
                    <%--<tr>--%>
                    <%--<td class="wall"><fmt:message key="label.receiver"/></td>--%>
                    <%--<td colspan="2">--%>
                    <%--<form:input path="pojo.receiver"/>--%>
                    <%--</td>--%>

                    <%--<td class="wall"></td>--%>
                    <%--<td colspan="2"></td>--%>
                    <%--</tr>--%>
                <tr>
                    <td><fmt:message key="label.description"/></td>
                    <td colspan="5">
                        <form:textarea path="pojo.description" cssClass="span11" rows="2"/>
                    </td>
                </tr>
            </table>
            <div class="row-fluid">
                <c:set var="counter" value="0"></c:set>
                <table class="tbInput">
                    <caption><fmt:message key="import.info.material"/>
                        <span style="float: right;">
                            <a title="<fmt:message key="label.add"/>" class="tip-top" onclick="addRowMtr('${counter}');">
                                <i class="icon-plus-sign" ></i>
                            </a>
                        </span>
                    </caption>
                    <tr id="tbHead">
                        <th ><fmt:message key="whm.material.name"/></th>
                        <th ><fmt:message key="label.detail.info"/></th>
                        <th ><fmt:message key="label.quantity"/></th>
                    </tr>
                    <c:if test="${empty exportMaterials}">
                        <tr id="mtr_${counter}">
                            <td class="inputItemInfo2">
                                <a title="<fmt:message key="label.remove"/>" class="tip-top" id="addPrd_${counter}" onclick="deleteRowMtr(this);">
                                    <i class="icon-minus" ></i>
                                </a>
                                <select name="itemInfos[${counter}].itemID" class="width3" id="sl_mtr_${counter}" oldSelected="" onchange="loadDetail(this.value,${counter});">
                                    <option value="">-<fmt:message key="label.select"/>-</option>
                                    <c:forEach items="${availableMaterials}" var="availableMaterial">
                                        <option value="${availableMaterial.importMaterialID}">
                                                ${availableMaterial.material.name} - <fmt:formatNumber value="${availableMaterial.remainQuantity}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/> ${availableMaterial.material.unit.name}
                                        </option>
                                    </c:forEach>
                                </select>
                            </td>
                            <td class="inputItemInfo6" id="detail_${counter}"></td>
                            <td class="inputItemInfo2">
                                <input type="text" class="inputNumber" name="itemInfos[${counter}].usedQuantity" id="usedQuantity_${counter}">
                            </td>
                        </tr>
                    </c:if>
                    <c:if test="${not empty exportMaterials}">
                        <c:set var="counter" value="${fn:length(exportMaterials)}"></c:set>
                        <c:forEach items="${exportMaterials}" var="exportMaterial" varStatus="status">
                            <tr id="mtr_${status.index}">
                                <td class="inputItemInfo2">
                                    <a title="<fmt:message key="label.remove"/>" class="tip-top" onclick="deleteRowMtr(this);">
                                        <i class="icon-minus" ></i>
                                    </a>
                                    <select name="itemInfos[${status.index}].itemID" class="width3" id="sl_mtr_${status.index}" oldSelected="${exportMaterial.importmaterial.importMaterialID}" onchange="loadDetail(this.value,${status.index});">
                                        <option value="">-<fmt:message key="label.select"/>-</option>
                                        <c:forEach items="${availableMaterials}" var="availableMaterial">
                                            <option value="${availableMaterial.importMaterialID}" <c:if test="${availableMaterial.importMaterialID == exportMaterial.importmaterial.importMaterialID}">selected</c:if>>
                                                    ${availableMaterial.material.name} - <fmt:formatNumber value="${availableMaterial.remainQuantity}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/> ${availableMaterial.material.unit.name}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </td>
                                <td class="inputItemInfo6" id="detail_${status.index}">
                                        ${exportMaterial.importmaterial.detailInfo}
                                </td>
                                <td class="inputItemInfo2">
                                    <input type="text" class="inputNumber" name="itemInfos[${status.index}].usedQuantity" id="usedQuantity_${status.index}" value="<fmt:formatNumber value="${exportMaterial.quantity}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/>">
                                </td>
                            </tr>
                            <input type="hidden" value="${exportMaterial.importmaterial.importMaterialID}" id="selectedMaterial_${status.index}"/>
                        </c:forEach>
                    </c:if>
                </table>
                <c:if test="${not empty item.pojo.status}">
                    <table class="tbHskt info">
                        <caption><fmt:message key="label.confirmation"/></caption>
                        <tr>
                            <td style="width:20%;"><fmt:message key="label.note"/></td>
                            <td style="width:80%;"><form:textarea path="pojo.note" cssClass="nohtml nameValidate span11" rows="2"/></td>
                        </tr>
                    </table>
                </c:if>
                <div class="controls">
                    <a onclick="save()" class="btn btn-success btn-green" style="cursor: pointer;">
                        <fmt:message key="button.save"/>
                    </a>
                    <div style="display: inline">
                        <form:hidden path="crudaction" id="crudaction" value="insert-update"/>
                        <form:hidden path="pojo.exporttype.code" id="exportcode"/>
                        <form:hidden path="pojo.exportMaterialBillID"/>
                        <a href="${backUrl}" class="cancel-link">
                            <fmt:message key="button.cancel"/>
                        </a>
                    </div>
                </div>
                <%@include file="../common/tablelog.jsp"%>

            </div>
        </div>
    </div>
</form:form>
<script type="text/javascript">
    var countPrd = ${counter};
    var listAvailableMaterialSelected = [];

    $(document).ready(function(){
        var exportType = $('#exportcode').val();
        loadInfo(exportType);
        pushSelectedMaterial();
    });

    function pushSelectedMaterial(){
        for(var i = 0;i < countPrd;i++){
            var selectedBPId = $('#selectedMaterial_' + i).val();
            listAvailableMaterialSelected.push({importMaterialID : selectedBPId});
        }
    }


    function addRowMtr(counter){
        var counter = counter;
        countPrd++;
        var id;
        var name = ""
        var row = '<tr id="mtr_'+countPrd+'">'+
                '<td class="inputItemInfo2">'+
                '<a title="<fmt:message key="label.remove"/>" class="tip-top" id="addPrd_'+countPrd+'" onclick="deleteRowMtr(this);">'+
                '<i class="icon-minus" ></i>'+
                '</a> '+
                '<select name="itemInfos['+countPrd+'].itemID" id="sl_mtr_'+countPrd+'" class="width3" oldSelected="" onchange="loadDetail(this.value,'+countPrd+');">'+
                '<option value="">-<fmt:message key="label.select"/>-</option>'+
                '<c:forEach items="${availableMaterials}" var="availableMaterial"><option value="${availableMaterial.importMaterialID}">${availableMaterial.material.name} - <fmt:formatNumber value="${availableMaterial.remainQuantity}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/> ${availableMaterial.material.unit.name}</option></c:forEach>'+
                '</select></td>'+
                '<td class="inputItemInfo6" id="detail_'+countPrd+'"></td>'+
                '<td class="inputItemInfo2"><input type="text" class="inputNumber" name="itemInfos['+countPrd+'].usedQuantity" id="usedQuantity_'+countPrd+'"></td>';
        $("#tbHead").after(row);
        $("#sl_mtr_" + countPrd).select2();
    }
    function deleteRowMtr(Ele){
        var td = $(Ele).parent();
        var trid = $(td).parent().attr("id");
        var count = trid.split('_')[1];
        var availableMaterialID=$("#sl_mtr_" + count +" option:selected").val();

        listAvailableMaterialSelected = $.grep(listAvailableMaterialSelected,
                function(o,i) { return o.importMaterialID === availableMaterialID; },true);
        $("#" + trid).remove();
    }
    function save(){
        $("#crudaction").val("insert-update");
        $('.inputNumber').each(function(){
            if($(this).val() != '' && $(this).val() != 0 ) {
                $(this).val(numeral().unformat($(this).val()));
            }
        });
        $("#itemForm").submit();
    }
    function loadDetail(id,counter){
        var oldSelectedId = $("#sl_mtr_" + counter).attr("oldSelected");
        if(oldSelectedId != null && oldSelectedId != ''){
            listAvailableMaterialSelected = $.grep(listAvailableMaterialSelected,
                    function(o,i) { return o.importMaterialID === oldSelectedId; },true);
        }
        if(!isSelectedItem(id)){
            var url = '<c:url value="/ajax/getAvailableMaterial.html"/>?importMaterialID=' + id;
            $.getJSON(url, function(data) {
                if (data.info != null){
                    var detail = data.info;
                    var remainQuantity = data.remainQuantity;
                    $("#detail_" + counter).html(detail);
                    $("#usedQuantity_" + counter).val(numeral(remainQuantity).format('0,0'));
                    listAvailableMaterialSelected.push({importMaterialID : id});
                    $("#sl_mtr_" + counter).attr("oldSelected",id);
                }
            });
        }else{
            bootbox.alert("<fmt:message key="label.title.confirm"/>", "<fmt:message key="message.selected.material"/>",function(){
                $("#sl_mtr_" + counter).select2("val","");
                $("#detail_" + counter).html("");
                $("#usedQuantity_" + counter).val("");

            });

        }

    }
    function isSelectedItem(selectedItem){
        for(var i = 0; i < listAvailableMaterialSelected.length;i++){
            if(selectedItem==listAvailableMaterialSelected[i].importMaterialID){
                return true;
            }
        }
        return false;
    }
    function loadRelated(Ele){
        var code = $(Ele).find('option:selected').attr('code');
        loadInfo(code);
        $('#exportcode').val(code);
    }

    function loadInfo(code){
        if(code === '${Constants.EXPORT_TYPE_CHUYEN_KHO}'){
            $('#relatedInfo').show();
            $('#warehouse').show();
            $('#s2id_sl_warehouse').show();
            $("#sl_customer").select2("val","");
            $('#customer').hide();
            $('#s2id_sl_customer').hide();
            $("#sl_plan").select2("val","");
            $('#plan').hide();
            $('#s2id_sl_plan').hide();
        }else if(code === '${Constants.EXPORT_TYPE_BAN}'){
            $('#relatedInfo').show();
            $('#customer').show();
            $('#s2id_sl_customer').show();
            $("#sl_warehouse").select2("val","");
            $('#warehouse').hide();
            $('#s2id_sl_warehouse').hide();
            $("#sl_plan").select2("val","");
            $('#plan').hide();
            $('#s2id_sl_plan').hide();
        }else if(code === '${Constants.EXPORT_TYPE_SAN_XUAT}' || code === '${Constants.EXPORT_TYPE_BTSC}'){
            $('#relatedInfo').show();
            $('#plan').show();
            $('#s2id_sl_plan').show();
            $('#customer').hide();
            $("#sl_customer").select2("val","");
            $('#s2id_sl_customer').hide();
            $("#sl_warehouse").select2("val","");
            $('#warehouse').hide();
            $('#s2id_sl_warehouse').hide();
            changePlan(code);
        }else{
            $("#sl_customer").select2("val","");
            $("#sl_warehouse").select2("val","");
            $("#sl_plan").select2("val","");
            $('#relatedInfo').hide();
        }
    }

    function changePlan(code){
        var options = document.getElementById('sl_plan').options;
        options.length = 1;
        var url = '<c:url value="/ajax/getPlanByType.html"/>?exportTypeCode=' + code;
        $.getJSON(url, function(data) {
            var error = data.error;
            if (error != null) {
                alert(error);
            }else if (data.array != null){
                for (i = 0; i < data.array.length; i++) {
                    var item = data.array[i];
                    options[i + 1] = new Option(item.name, item.productionPlanID);
                }
            }

        });
    }


</script>