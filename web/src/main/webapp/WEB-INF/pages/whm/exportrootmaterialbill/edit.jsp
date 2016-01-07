<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" errorPage="/error.jsp" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@page import="com.banvien.tpk.core.Constants" %>
<c:set value="material" var="productType"/>
<c:if test="${!item.isBlackProduct}">
    <c:set value="product" var="productType"/>
</c:if>
<head>
    <title><fmt:message key="whm.exportproduct.${productType}.title"/></title>
    <meta name="heading" content="<fmt:message key="whm.exportproduct.${productType}.title"/>"/>
</head>

<c:url var="url" value="/whm/exportrootmaterialbill/edit.html"/>
<c:url var="backUrl" value="/whm/exportrootmaterialbill/list.html?isBlackProduct=${item.isBlackProduct}"/>
<form:form commandName="item" action="${url}" method="post" id="itemForm" class="form-horizontal" novalidate="novalidate">
    <div id="container-fluid data_content_box">
    <div class="row-fluid data_content">
        <div class="content-header"><fmt:message key="whm.exportproduct.${productType}.declare"/></div>
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
                        <form:select path="pojo.exporttype.exportTypeID" id="sl_exporttype" cssClass="required" onchange="loadRelated(this);">
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
                        <span id="note" style="display: none;">
                        <fmt:message key="label.description"/>
                        </span>
                    </td>
                    <td colspan="2">
                        <form:select path="pojo.receiveWarehouse.warehouseID" id="sl_receiver" cssStyle="display: none;">
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
                            <c:forEach items="${productionplans}" var="productionplan">
                                <form:option value="${productionplan.productionPlanID}">${productionplan.name}</form:option>
                            </c:forEach>
                        </form:select>
                        <form:input path="pojo.description" id="i_note" cssStyle="display: none;width: 360px;text-transform:none;"/>
                    </td>
                    <td class="wall">
                        <span id="span-exportDate" style="display: none;"><fmt:message key="export.date"/></span>
                    </td>
                    <td colspan="2" >
                        <div class="input-append date" id="div-exportDate" style="display: none;">
                            <fmt:formatDate var="exportedDate" value="${item.pojo.exportDate}" pattern="dd/MM/yyyy"/>
                            <input name="pojo.exportDate" id="exportDate" class="prevent_type text-center width2" value="${exportedDate}" type="text" />
                            <span class="add-on" id="exportDateIcon"><i class="icon-calendar"></i></span>
                        </div>
                    </td>
                </tr>

                <tr>
                    <td><fmt:message key="vehicle.no"/></td>
                    <td colspan="2">
                        <form:input path="pojo.vehicle" cssStyle="text-transform:none;"/>
                    </td>
                    <td class="wall"></td>
                    <td colspan="2">
                    </td>
                </tr>

            </table>
            <div class="row-fluid">
                <c:set var="counter" value="0"></c:set>
                <table class="tbInput">
                    <caption><fmt:message key="import.info.${productType}.base"/>
                        <span style="float: right;">
                            <a title="<fmt:message key="label.add"/>" class="tip-top" onclick="addRowMtr('${counter}');">
                                <i class="icon-plus-sign" ></i>
                            </a>
                        </span>
                    </caption>
                    <tr id="tbHead">
                        <th ><fmt:message key="label.code"/></th>
                        <th ><fmt:message key="label.name"/></th>
                        <th ><fmt:message key="label.size"/></th>
                        <c:if test="${!item.isBlackProduct}">
                            <th ><fmt:message key="label.quantity.meter"/></th>
                        </c:if>
                        <th ><fmt:message key="label.quantity.kg"/></th>
                        <th >
                            <c:if test="${!item.isBlackProduct}">
                                <fmt:message key="label.specific"/>
                            </c:if>
                            <c:if test="${item.isBlackProduct}">
                                <fmt:message key="whm.origin.name"/>
                            </c:if>
                        </th>
                    </tr>
                    <c:if test="${empty exportProducts}">
                    <tr id="prd_${counter}">
                        <td class="inputItemInfo2">
                            <a title="<fmt:message key="label.remove"/>" class="tip-top" id="addPrd_${counter}" onclick="deleteRowPrd(this);">
                            <i class="icon-minus" ></i>
                            </a>
                            <select name="itemInfos[${counter}].itemID" class="width3" id="sl_prd_${counter}" oldSelected="" onchange="loadDetail(this.value,${counter});">
                                <option value="-1">-<fmt:message key="label.select"/>-</option>
                                <c:forEach items="${blackProducts}" var="blackProduct">
                                    <option value="${blackProduct.importProductID}">${blackProduct.productCode}</option>
                                </c:forEach>
                            </select>
                        </td>
                        <td class="inputItemInfo1" id="name_${counter}"></td>
                        <td class="inputItemInfo1" id="size_${counter}"></td>
                        <c:if test="${!item.isBlackProduct}">
                            <td class="inputItemInfo1" id="met_${counter}"></td>
                        </c:if>
                        <td class="inputItemInfo1" id="kg_${counter}"></td>
                        <td class="inputItemInfo1" id="origin_${counter}"></td>
                    </tr>
                    </c:if>
                    <c:if test="${not empty exportProducts}">
                        <c:set var="counter" value="${fn:length(exportProducts)}"></c:set>
                        <c:forEach items="${exportProducts}" var="exportProduct" varStatus="status">
                            <tr id="prd_${status.index}">
                                <td class="inputItemInfo2">
                                    <a title="<fmt:message key="label.remove"/>" class="tip-top" onclick="deleteRowPrd(this);">
                                        <i class="icon-minus" ></i>
                                    </a>
                                    <select name="itemInfos[${status.index}].itemID" class="width3" id="sl_prd_${status.index}" oldSelected="${exportProduct.importproduct.importProductID}" onchange="loadDetail(this.value,${status.index});">
                                        <option value="-1">-<fmt:message key="label.select"/>-</option>
                                        <c:forEach items="${blackProducts}" var="blackProduct">
                                            <option value="${blackProduct.importProductID}" <c:if test="${blackProduct.importProductID == exportProduct.importproduct.importProductID}">selected</c:if>>${blackProduct.productCode}</option>
                                        </c:forEach>
                                    </select>
                                </td>
                                <td class="inputItemInfo1" id="name_${status.index}">${exportProduct.importproduct.productname.name}</td>
                                <td class="inputItemInfo1" id="size_${status.index}">${exportProduct.importproduct.size.name}</td>
                                <c:if test="${!item.isBlackProduct}">
                                    <td class="inputItemInfo1" id="met_${status.index}"><fmt:formatNumber value="${exportProduct.importproduct.quantity1}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/></td>
                                </c:if>
                                <td class="inputItemInfo1" id="kg_${status.index}"><fmt:formatNumber value="${exportProduct.importproduct.quantity2Pure}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/></td>
                                <td class="inputItemInfo1" id="origin_${status.index}">
                                    <c:if test="${!item.isBlackProduct}">
                                        ${not empty exportProduct.importproduct.colour ? exportProduct.importproduct.colour.code : exportProduct.importproduct.thickness.name}
                                    </c:if>
                                    <c:if test="${item.isBlackProduct}">
                                        ${exportProduct.importproduct.origin.name}
                                    </c:if>
                                </td>
                            </tr>
                            <input type="hidden" value="${exportProduct.importproduct.importProductID}" id="selectedProduct_${status.index}"/>
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
                    <c:set var="allowEdit" value="${item.pojo.editable}"/>
                    <c:if test="${empty item.pojo.exportProductBillID}">
                        <c:set var="allowEdit" value="true"/>
                    </c:if>
                    <c:if test="${allowEdit}">
                    <a onclick="save()" class="btn btn-success btn-green" style="cursor: pointer;">
                        <fmt:message key="button.save"/>
                    </a>
                    </c:if>
                    <div style="display: inline">
                        <form:hidden path="crudaction" id="crudaction" value="insert-update"/>
                        <form:hidden path="pojo.exporttype.code" id="exportcode"/>
                        <form:hidden path="pojo.exportProductBillID"/>
                        <form:hidden path="isBlackProduct"/>
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
    var listBlackProductSelected = [];

    $(document).ready(function(){
        var exportDateVar = $("#exportDate").datepicker({
            format: 'dd/mm/yyyy',
            onRender: function(date){
            }}).on('changeDate', function(ev) {
                    exportDateVar.hide();
                }).data('datepicker');
        $('#exportDateIcon').click(function() {
            $('#exportDate').focus();
            return true;
        });

        var exportType = $('#exportcode').val();
        loadInfo(exportType);
        pushSelectedProduct();
    });

    function pushSelectedProduct(){
        for(var i = 0;i < countPrd;i++){
            var selectedBPId = $('#selectedProduct_' + i).val();
            listBlackProductSelected.push({importProductID : selectedBPId});
        }
    }


    function addRowMtr(counter){
        var counter = counter;
        countPrd++;
        var id;
        var name = ""
        var row = '<tr id="prd_'+countPrd+'">'+
                '<td class="inputItemInfo2">'+
                '<a title="<fmt:message key="label.remove"/>" class="tip-top" id="addPrd_'+countPrd+'" onclick="deleteRowPrd(this);">'+
                '<i class="icon-minus" ></i>'+
                '</a> '+
                '<select name="itemInfos['+countPrd+'].itemID" id="sl_prd_'+countPrd+'" class="width3" oldSelected="" onchange="loadDetail(this.value,'+countPrd+');">'+
                '<option value="-1">-<fmt:message key="label.select"/>-</option>'+
                '<c:forEach items="${blackProducts}" var="blackProduct"><option value="${blackProduct.importProductID}">${blackProduct.productCode}</option></c:forEach>'+
                '</select></td>'+
                '<td class="inputItemInfo1" id="name_'+countPrd+'"></td>'+
                '<td class="inputItemInfo1" id="size_'+countPrd+'"></td>'+
                '<c:if test="${!item.isBlackProduct}">'+
                '<td class="inputItemInfo1" id="met_'+countPrd+'"></td>'+
                '</c:if>'+
                '<td class="inputItemInfo1" id="kg_'+countPrd+'"></td>'+
                '<td class="inputItemInfo1" id="origin_'+countPrd+'"></td>';
        $("#tbHead").after(row);
        $("#sl_prd_" + countPrd).select2();
    }
    function deleteRowPrd(Ele){
        var td = $(Ele).parent();
        var trid = $(td).parent().attr("id");
        var count = trid.split('_')[1];
        var blackProductID=$("#sl_prd_" + count +" option:selected").val();

        listBlackProductSelected = $.grep(listBlackProductSelected,
                function(o,i) { return o.importProductID === blackProductID; },true);
        $("#" + trid).remove();
    }
    function save(){
        $("#crudaction").val("insert-update");
        if(checkRequired()){
            $("#itemForm").submit();
        }else{
            $(".alert-error").show();
        }
    }
    function loadDetail(id,counter){
        var oldSelectedId = $("#sl_prd_" + counter).attr("oldSelected");
        if(oldSelectedId != null && oldSelectedId > 0){
            listBlackProductSelected = $.grep(listBlackProductSelected,
                    function(o,i) { return o.importProductID === oldSelectedId; },true);
        }
        if(id < 0){
            $("#sl_prd_" + counter).select2("val","");
            $("#name_" + counter).html("");
            $("#size_" + counter).html("");
            $("#met_" + counter).html("");
            $("#kg_" + counter).html("");
            $("#origin_" + counter).html("");
        }
        else if(!isSelectedItem(id)){
            var url = '<c:url value="/ajax/getAvailableBlackProduct.html"/>?importProductID=' + id;
            $.getJSON(url, function(data) {
                if (data.name != null){
                    var met = '';
                    var kg = '';

                    if(data.met != null){
                        met = numeral(data.met).format('###,###');
                    }
                    if(data.kg != null){
                        kg = numeral(data.kg).format('###,###');
                    }
                    $("#name_" + counter).html(data.name);
                    $("#size_" + counter).html(data.size);
                    $("#met_" + counter).html(met);
                    $("#kg_" + counter).html(kg);
                    $("#origin_" + counter).html(data.origin);
                    listBlackProductSelected.push({importProductID : id});
                    $("#sl_prd_" + counter).attr("oldSelected",id);
                }
            });
        }else{
            bootbox.alert("<fmt:message key="label.title.confirm"/>", "<fmt:message key="message.selected.black.product"/>",function(){
                $("#sl_prd_" + counter).select2("val","");
                $("#name_" + counter).html("");
                $("#size_" + counter).html("");
                $("#met_" + counter).html("");
                $("#kg_" + counter).html("");
                $("#origin_" + counter).html("");
            });
        }

    }
    function isSelectedItem(selectedItem){
        if(selectedItem != null && selectedItem > 0){
            for(var i = 0; i < listBlackProductSelected.length;i++){
                if(selectedItem==listBlackProductSelected[i].importProductID){
                    return true;
                }
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
            $('#span-exportDate').show();
            $('#div-exportDate').show();
            $('#s2id_sl_receiver').show();
            $("#sl_customer").select2("val","");
            $('#customer').hide();
            $('#s2id_sl_customer').hide();
            $("#sl_plan").select2("val","");
            $('#plan').hide();
            $('#s2id_sl_plan').hide();
            $('#note').hide();
            $('#i_note').hide();
        }else if(code === '${Constants.EXPORT_TYPE_BAN}'){
            $('#relatedInfo').show();
            $('#customer').show();
            $('#span-exportDate').show();
            $('#div-exportDate').show();
            $('#s2id_sl_customer').show();
            $("#sl_receiver").select2("val","");
            $('#warehouse').hide();
            $('#s2id_sl_receiver').hide();
            $("#sl_plan").select2("val","");
            $('#plan').hide();
            $('#s2id_sl_plan').hide();
            $('#note').hide();
            $('#i_note').hide();
        }else if(code === '${Constants.EXPORT_TYPE_SAN_XUAT}'){
            $('#relatedInfo').show();
            $('#plan').show();
            $('#span-exportDate').hide();
            $('#div-exportDate').hide();
            $('#s2id_sl_plan').show();
            $('#customer').hide();
            $("#sl_customer").select2("val","");
            $('#s2id_sl_customer').hide();
            $("#sl_receiver").select2("val","");
            $('#warehouse').hide();
            $('#s2id_sl_receiver').hide();
            $('#note').hide();
            $('#i_note').hide();
        }else{
            $('#relatedInfo').show();
            $('#note').show();
            $('#i_note').show();
            $('#span-exportDate').show();
            $('#div-exportDate').show();
            $('#customer').hide();
            $("#sl_customer").select2("val","");
            $('#s2id_sl_customer').hide();
            $("#sl_receiver").select2("val","");
            $('#warehouse').hide();
            $('#s2id_sl_receiver').hide();
            $("#sl_plan").select2("val","");
            $('#plan').hide();
            $('#s2id_sl_plan').hide();
        }
    }


</script>