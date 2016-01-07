<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" errorPage="/error.jsp" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@page import="com.banvien.tpk.core.Constants" %>
<head>
    <title><fmt:message key="whm.export.material.title"/></title>
    <meta name="heading" content="<fmt:message key="whm.export.material.title"/>"/>
</head>
<c:url var="url" value="/whm/exportmaterialbill/edit.html"/>
<c:url var="backUrl" value="/whm/exportmaterialbill/list.html"/>
<body>
<form:form commandName="item" action="${url}" id="itemForm" method="post" autocomplete="off" name="itemForm">
    <div class="row-fluid data_content">
        <div class="content-header"><fmt:message key="whm.export.material.declare"/></div>
        <div class="clear"></div>
        <div class="guideline">
            <span>(<span class="required">*</span>): là bắt buộc.</span>
            <%--Note: In case tranfering material to another warehouse, its required to transfer all material quantity--%>
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
                <td>
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
                        <c:forEach items="${productionPlans}" var="productionPlan">
                            <form:option value="${productionPlan.productionPlanID}">${productionPlan.name}</form:option>
                        </c:forEach>
                    </form:select>
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

            <tr id="relatedInfo2" style="display: none;">
                <td>
                        <span id="machine" style="display: none;">
                            <fmt:message key="whm.machine.name"/></span>
                    </span>
                </td>
                <td colspan="2">
                    <form:select path="pojo.machine.machineID" id="sl_machine" cssStyle="display: none;" onchange="changeComponent(this.value);">
                        <form:option value="">-<fmt:message key="label.select"/>-</form:option>
                        <c:forEach items="${machines}" var="machine">
                            <form:option value="${machine.machineID}">${machine.name}</form:option>
                        </c:forEach>
                    </form:select>
                </td>
                <td class="wall">
                        <span id="machinecomponent" style="display: none;">
                            <fmt:message key="whm.machinecomponent.name"/></span>
                    </span>
                </td>
                <td colspan="2">
                    <form:select path="pojo.machinecomponent.machineComponentID" id="sl_machinecomponent" cssStyle="display: none;">
                        <form:option value="">-<fmt:message key="label.select"/>-</form:option>
                    </form:select>
                </td>
            </tr>

            <tr>
                <td><fmt:message key="label.description"/></td>
                <td colspan="5">
                    <form:textarea path="pojo.description" cssClass="span11" rows="2"/>
                </td>
            </tr>
        </table>
        <div class="clear"></div>
        <div class="report-filter">
            <table class="tbReportFilter" >
                <caption><fmt:message key="search.instock.material"/></caption>
                <tr>

                    <td class="label-field" ><fmt:message key="label.number"/></td>
                    <td><form:input path="code" size="25" maxlength="45" /></td>
                    <td class="label-field"><fmt:message key="whm.materialcategory.name"/></td>
                    <td>
                        <form:select path="materialCategoryID">
                            <form:option value="-1">Tất cả</form:option>
                            <form:options items="${materialCategories}" itemValue="materialCategoryID" itemLabel="name"/>
                        </form:select>
                    </td>
                </tr>
                <tr>
                    <td class="label-field"><fmt:message key="label.from.import.date"/></td>
                    <td>
                        <div class="input-append date" >
                            <fmt:formatDate var="ngayKeKhaiFrom" value="${item.fromDate}" pattern="dd/MM/yyyy"/>
                            <input name="fromDate" id="effectiveFromDate" class="prevent_type text-center width2" value="${ngayKeKhaiFrom}" type="text" />
                            <span class="add-on" id="effectiveFromDateIcon"><i class="icon-calendar"></i></span>
                        </div>
                    </td>
                    <td class="label-field"><fmt:message key="label.to.import.date"/></td>
                    <td>
                        <div class="input-append date" >
                            <fmt:formatDate var="ngayKeKhaiTo" value="${item.toDate}" pattern="dd/MM/yyyy"/>
                            <input name="toDate" id="effectiveToDate" class="prevent_type text-center width2" value="${ngayKeKhaiTo}" type="text" />
                            <span class="add-on" id="effectiveToDateIcon"><i class="icon-calendar"></i></span>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="label-field"><fmt:message key="label.to.expire.date"/></td>
                    <td>
                        <div class="input-append date" >
                            <fmt:formatDate var="ngayHetHanTo" value="${item.expiredDate}" pattern="dd/MM/yyyy"/>
                            <input name="expiredDate" id="effectiveExpiredDate" class="prevent_type text-center width2" value="${ngayHetHanTo}" type="text" />
                            <span class="add-on" id="effectiveExpiredDateIcon"><i class="icon-calendar"></i></span>
                        </div>
                    </td>
                    <td class="label-field"><fmt:message key="whm.material.name"/></td>
                    <td>
                        <form:select path="materialID">
                            <form:option value="-1">Tất cả</form:option>
                            <form:options items="${materials}" itemValue="materialID" itemLabel="name"/>
                        </form:select>
                    </td>
                </tr>
                <tr>
                    <td class="label-field"><fmt:message key="whm.origin.name"/></td>
                    <td>
                        <form:select path="originID">
                            <form:option value="-1">Tất cả</form:option>
                            <form:options items="${origins}" itemValue="originID" itemLabel="name"/>
                        </form:select>
                    </td>
                    <td class="label-field"><fmt:message key="whm.market.name"/></td>
                    <td>
                        <form:select path="marketID">
                            <form:option value="-1">Tất cả</form:option>
                            <form:options items="${markets}" itemValue="marketID" itemLabel="name"/>
                        </form:select>
                    </td>
                </tr>
                <tr>
                    <td class="label-field"><fmt:message key="remain.from"/></td>
                    <td><form:input path="fromQuantity" size="25" maxlength="45" cssClass="inputNumber" cssStyle="width: 145px;"/></td>
                    <td class="label-field"><fmt:message key="label.to"/></td>
                    <td><form:input path="toQuantity" size="25" maxlength="45" cssClass="inputNumber" cssStyle="width: 145px;"/></td>
                </tr>
                <tr style="text-align: center;">
                    <td colspan="4">
                        <a id="btnFilter" class="btn btn-primary"><i class="icon-refresh"></i> <fmt:message key="label.search"/> </a>
                    </td>
                </tr>
            </table>
            <div class="clear"></div>
            <div id="infoMsg"></div>
            <display:table name="availableMaterials" cellspacing="0" cellpadding="0" requestURI="${url}"
                           partialList="true" sort="external" size="${totalAvailableMaterial}"
                           uid="tableList" excludedParams="crudaction"
                           pagesize="${item.maxPageItems}" export="false" class="tableSadlier table-hover">
                <display:column headerClass="table_header_center" sortable="false" title="STT" class="text-center" style="width: 2%;">
                    ${tableList_rowNum}
                </display:column>
                <display:column headerClass="table_header_center" property="material.name" sortable="true" sortName="material.name" titleKey="whm.material.name" class="text-center" style="width: 7%;"/>
                <display:column headerClass="table_header_center" property="code" titleKey="label.number" class="text-center" style="width: 7%;"/>
                <display:column headerClass="table_header_center" property="origin.name" sortable="true" sortName="origin.name" titleKey="whm.origin.name" class="text-center" style="width: 7%;"/>
                <display:column headerClass="table_header_center" property="market.name" sortable="true" sortName="market.name" titleKey="whm.market.name" class="text-center" style="width: 7%;"/>
                <display:column headerClass="table_header_center" sortable="false" titleKey="import.warehouse.date" class="text-center" style="width: 7%;">
                    <fmt:formatDate value="${tableList.importDate}" pattern="dd/MM/yyyy"/>
                </display:column>
                <display:column headerClass="table_header_center" sortable="false" titleKey="label.expiredDate" class="text-center" style="width: 7%;">
                    <fmt:formatDate value="${tableList.expiredDate}" pattern="dd/MM/yyyy"/>
                </display:column>
                <display:column headerClass="table_header_center" property="material.unit.name" sortable="false" title="ĐVT" class="text-center" style="width: 7%;"/>
                <display:column headerClass="table_header_center" sortName="remainQuantity" sortable="true" titleKey="label.quantity.remain" class="text-center" style="width: 10%;">
                    <fmt:formatNumber value="${tableList.remainQuantity}" pattern="###,###.#" maxFractionDigits="1" minFractionDigits="0"/>
                    <input type="hidden" id="remain-${tableList.importMaterialID}" value="${tableList.remainQuantity}"/>
                </display:column>
                <display:column headerClass="table_header_center" sortable="false" titleKey="label.quantity.export" class="text-center" style="width: 10%;">
                    <input onblur="checkNumber(this.value, this.id);calcTempRemain(this);" id="export-${tableList.importMaterialID}" type="text" style="width: 70%;" value="${mapSelectedMaterial[tableList.importMaterialID] eq true ? mapSelectedMaterialValue[tableList.importMaterialID] : ""}" name="itemInfos[${tableList_rowNum - 1}].usedQuantity" ${item.pojo.exporttype.code eq Constants.EXPORT_TYPE_CHUYEN_KHO ? "readonly=\"readonly\"" : ""}>
                </display:column>

                <display:column headerClass="table_header_center" sortName="remainQuantity" sortable="true" titleKey="label.remain" class="text-center" style="width: 10%;">
                    <span id="temp-remain-${tableList.importMaterialID}"><fmt:formatNumber value="${mapSelectedMaterial[tableList.importMaterialID] eq true ? tableList.remainQuantity - mapSelectedMaterialValue[tableList.importMaterialID] : tableList.remainQuantity}" pattern="###,###.#" maxFractionDigits="1" minFractionDigits="0"/></span>
                </display:column>

                <display:column headerClass="table_header_center" sortable="false" titleKey="" class="text-center" style="width: 3%;">
                    <input class="checkMtr" id="check-${tableList.importMaterialID}" type="checkbox" name="itemInfos[${tableList_rowNum - 1}].itemID" value="${tableList.importMaterialID}" ${mapSelectedMaterial[tableList.importMaterialID] eq true ? "checked=\"checked\"" : ""}>
                </display:column>


                <display:setProperty name="paging.banner.item_name" value="loại vật tư"/>
                <display:setProperty name="paging.banner.items_name" value="loại vật tư"/>
                <display:setProperty name="paging.banner.placement" value="bottom"/>
                <display:setProperty name="paging.banner.no_items_found" value=""/>
            </display:table>


        </div>
        <c:if test="${not empty item.pojo.status}">
            <table class="tbHskt info">
                <caption><fmt:message key="label.confirmation"/></caption>
                <tr>
                    <td style="width:20%;"><fmt:message key="label.note"/></td>
                    <td style="width:80%;"><form:textarea path="pojo.note" cssClass="span11" rows="2"/></td>
                </tr>
            </table>
        </c:if>
        <div class="controls" style="text-align: center;margin: 12px;">
            <c:set var="allowEdit" value="${item.pojo.editable}"/>
            <c:if test="${empty item.pojo.exportMaterialBillID}">
                <c:set var="allowEdit" value="true"/>
            </c:if>
            <c:if test="${allowEdit}">
                <a onclick="save()" class="btn btn-success btn-green" style="cursor: pointer;">
                    <fmt:message key="button.save"/>
                </a>
            </c:if>
            <div style="display: inline">
                <form:hidden path="crudaction" id="crudaction"/>
                <form:hidden path="pojo.exporttype.code" id="exportcode"/>
                <form:hidden path="pojo.exportMaterialBillID"/>
                <a href="${backUrl}" class="cancel-link">
                    <fmt:message key="button.cancel"/>
                </a>
            </div>
        </div>
        <%@include file="../common/tablelog.jsp"%>
    </div>
</form:form>

<script type="text/javascript">
    $(document).ready(function(){
        var effectiveToDateVar = $("#effectiveToDate").datepicker({
            format: 'dd/mm/yyyy',
            onRender: function(date){
            }}).on('changeDate', function(ev) {
                    effectiveToDateVar.hide();
                }).data('datepicker');
        var effectiveFromDateVar = $("#effectiveFromDate").datepicker({
            format: 'dd/mm/yyyy',
            onRender: function(date){
            }}).on('changeDate', function(ev) {
                    effectiveFromDateVar.hide();
                }).data('datepicker');
        var effectiveExpiredDateVar = $("#effectiveExpiredDate").datepicker({
            format: 'dd/mm/yyyy',
            onRender: function(date){
            }}).on('changeDate', function(ev) {
                    effectiveExpiredDateVar.hide();
                }).data('datepicker');
        $('#effectiveExpiredDateIcon').click(function() {
            $('#effectiveExpiredDate').focus();
            return true;
        });
        $('#effectiveToDateIcon').click(function() {
            $('#effectiveToDate').focus();
            return true;
        });
        $('#effectiveFromDateIcon').click(function() {
            $('#effectiveFromDate').focus();
            return true;
        });


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


        $("#btnFilter").click(function(){
            $("#crudaction").val("search");
            $('.inputNumber').each(function(){
                if($(this).val() != '' && $(this).val() != 0 ) {
                    $(this).val(numeral().unformat($(this).val()));
                }
            });
            $("#itemForm").submit();
        });
        var exportType = $('#exportcode').val();
        loadInfo(exportType);
    });

    function loadRelated(Ele){
        var code = $(Ele).find('option:selected').attr('code');
        loadInfo(code);
        changePlan(code);
        $('#exportcode').val(code);
        if(code === '${Constants.EXPORT_TYPE_CHUYEN_KHO}'){
            $('.inputNumber').each(function(){
                $(this).attr("readonly","readonly");
            });
        }else{
            $('.inputNumber').each(function(){
                $(this).removeAttr("readonly");
            });
        }
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
            $("#sl_machine").select2("val","");
            $('#machine').hide();
            $('#s2id_sl_machine').hide();
            $("#sl_machinecomponent").select2("val","");
            $('#machinecomponent').hide();
            $('#s2id_sl_machinecomponent').hide();
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
            $("#sl_machine").select2("val","");
            $('#machine').hide();
            $('#s2id_sl_machine').hide();
            $("#sl_machinecomponent").select2("val","");
            $('#machinecomponent').hide();
            $('#s2id_sl_machinecomponent').hide();
        }else if(code === '${Constants.EXPORT_TYPE_SAN_XUAT}' || code === '${Constants.EXPORT_TYPE_BTSC}'){
            $('#relatedInfo').show();
            $('#plan').show();
            $('#s2id_sl_plan').show();
            $('#span-exportDate').hide();
            $('#div-exportDate').hide();
            $('#customer').hide();
            $("#sl_customer").select2("val","");
            $('#s2id_sl_customer').hide();
            $("#sl_receiver").select2("val","");
            $('#warehouse').hide();
            $('#s2id_sl_receiver').hide();
            if(code === '${Constants.EXPORT_TYPE_BTSC}'){
                $('#relatedInfo2').show();
                $('#machine').show();
                $('#s2id_sl_machine').show();
                $('#machinecomponent').show();
                $('#s2id_sl_machinecomponent').show();
            }
        }else{
            $('#customer').hide();
            $("#sl_customer").select2("val","");
            $('#s2id_sl_customer').hide();

            $("#sl_receiver").select2("val","");
            $('#warehouse').hide();
            $('#s2id_sl_receiver').hide();

            $("#sl_plan").select2("val","");
            $('#plan').hide();
            $('#s2id_sl_plan').hide();

            $("#sl_machine").select2("val","");
            $('#machine').hide();
            $('#s2id_sl_machine').hide();

            $("#sl_machinecomponent").select2("val","");
            $('#machinecomponent').hide();
            $('#s2id_sl_machinecomponent').hide();
            $('#relatedInfo').show();
            $('#span-exportDate').show();
            $('#div-exportDate').show();

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
        $('#sl_plan').select2("val","");
    }

    function changeComponent(machineID){
        if(machineID != '' && machineID > 0){
            var options = document.getElementById('sl_machinecomponent').options;
            options.length = 1;
            var url = '<c:url value="/ajax/getComponentByMachine.html"/>?machineID=' + machineID;
            $.getJSON(url, function(data) {
                var error = data.error;
                if (error != null) {
                    alert(error);
                }else if (data.array != null){
                    for (i = 0; i < data.array.length; i++) {
                        var item = data.array[i];
                        options[i + 1] = new Option(item.name, item.machineComponentID);
                    }
                }

            });
        }else{
            var options = document.getElementById('sl_machinecomponent').options;
            options.length = 1;
            $("#sl_machinecomponent").select2("val","");
        }
    }

    function save(){
        $("#crudaction").val("insert-update");
        $('.inputNumber').each(function(){
            if($(this).val() != '' && $(this).val() != 0 ) {
                $(this).val(numeral().unformat($(this).val()));
            }
        });
        if(checkRequired()){
            if(checkSelectedItem()){
                $("#itemForm").submit();
            }else{
                bootbox.alert("<fmt:message key="label.title.confirm"/>", "<fmt:message key="material.message.chooseAtLeastOne"/>");
            }
        }else{
            $(".alert-error").show();
        }
    }
    function checkSelectedItem(){
        var checker = false;
        $('.checkMtr').each(function(){
            if($(this).is(':checked')){
                var id = $(this).attr('id').split("-")[1];
                var exportVal = $('#export-' + id).val();
                if(exportVal != null && exportVal != ''){
                    checker = true;
                }
            }
        });
        return checker;
    }
    function calcTempRemain(Ele){
        var exportVal = 0;
        if($(Ele).val() != null && $(Ele).val() != ''){
            exportVal = numeral().unformat($(Ele).val());
        }
        var id = $(Ele).attr('id').split('-')[1];
        var curVal = $('#remain-' + id).val();
        if(curVal >= exportVal && exportVal != 0){
            $('#temp-remain-' + id).text(numeral(curVal - exportVal).format('###,###.#'));
            if(!$('#check-' + id).is(':checked')){
                $('#check-' + id).attr("checked", true);
                $('#check-' + id).parent("span").addClass("checked")
            }
        }else if(exportVal == 0){
            $('#temp-remain-' + id).text(numeral(curVal).format('###,###.#'));
            if($('#check-' + id).is(':checked')){
                $('#check-' + id).attr("checked", false);
                $('#check-' + id).parent("span").removeClass("checked")
            }
        }
        else{
            bootbox.alert('<fmt:message key="label.title.confirm"/>', 'Số lượng xuất không phù hợp!', '<fmt:message key="button.accept"/>', function(result){
                $(Ele).val('0');
                $('#temp-remain-' + id).text(numeral(curVal).format('###,###.#'));
                $('#check-' + id).attr("checked", false);
                $('#check-' + id).parent("span").removeClass("checked")
            });
            return false;
        }
    }
</script>
</body>
</html>