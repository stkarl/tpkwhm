<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<head>
    <title><fmt:message key="whm.materialmeasurement.title"/></title>
    <meta name="heading" content="<fmt:message key="whm.materialmeasurement.title"/>"/>
</head>
<style>
    table tbody tr td{
        vertical-align: middle;
    }
    .sanXuat {
        background-color: darkseagreen;text-align: center;font-weight: bold;
    }
</style>

<c:url var="url" value="/whm/materialmeasurement/editlist.html"/>
<c:url var="backUrl" value="/whm/home.html"/>
<form:form commandName="item" action="${url}" method="post" id="itemForm" class="form-horizontal" novalidate="novalidate">
    <div id="container-fluid data_content_box">
        <div class="row-fluid data_content">

            <c:if test="${!empty errorMessage}">
                <div class="alert alert-error">
                    <a class="close" data-dismiss="alert" href="#">x</a>
                        ${errorMessage}
                </div>
                <div style="clear:both;"></div>
            </c:if>
            <c:if test="${!empty successMessage}">
                <div class="alert alert-success">
                    <a class="close" data-dismiss="alert" href="#">x</a>
                        ${successMessage}
                </div>
                <div style="clear:both;"></div>
            </c:if>

            <div class="content-header">
                <fmt:message key="whm.materialmeasurement.title"/>
            </div>
            <div class="clear"></div>
            <div class="row-fluid">
                <div class="pane_info">
                    <div class="pane_title">Thông tin chung</div>
                    <div class="pane_content">
                        <div class="control-group">
                            <label class="control-label">
                                <fmt:message key="whm.warehouse"/>
                            </label>
                            <div class="controls">
                                <form:select path="warehouseID" cssStyle="width: 220px;" onchange="reloadByWarehouse(this);">
                                    <form:options itemLabel="name" itemValue="warehouseID" items="${warehouses}"/>
                                </form:select>
                                <form:errors path="pojo.warehouse.warehouseID" cssClass="error-inline-validate"/>
                            </div>
                            <div class="controls">
                                <a onclick="submitMeasure();" class="btn btn-success btn-green" style="cursor: pointer;">
                                    <fmt:message key="button.update"/>
                                </a>
                                <div style="display: inline">
                                    <form:hidden path="crudaction" id="crudaction" value="insert-update"/>
                                    <a href="${backUrl}" class="cancel-link">
                                        <fmt:message key="button.cancel"/>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <table class="tbHskt info">
                <caption>Danh sách vật tư ghi chỉ số</caption>
                <tr>
                    <td>Vật tư</td>
                    <td>Đơn vị tính</td>
                    <td>Ghi cho ngày</td>
                    <td>Tiêu thụ</td>
                    <td>Ghi chú</td>
                </tr>
                <tr class="sanXuat"><td colspan="5">Sản xuất mạ lạnh/kẽm</td></tr>
                <c:set var="counter" value="0"/>
                <c:forEach items="${materialLanhs}" var="material" >
                    <tr>
                        <td>
                            ${material.name}
                            <input type="hidden" value="${material.materialID}" name="measurements[${counter}].materialID">
                        </td>
                        <td>${material.unit.name}</td>
                        <td>
                            <input type="text" class="datePicker prevent_type text-center" name="measurements[${counter}].date" style="width: 90px;"/>
                        </td>
                        <td><input id="value_${material.materialID}" name="measurements[${counter}].value" type="text" style="width: 120px;" onchange="checkNumber(this.value, this.id);"/></td>
                        <td><textarea rows="2" name="measurements[${counter}].note" class="span11"></textarea></td>
                    </tr>
                    <c:set var="counter" value="${counter + 1}"/>
                </c:forEach>
                <tr class="sanXuat"><td colspan="5">Sản xuất mạ màu</td></tr>
                <c:forEach items="${measureMaterialMaus}" var="material" >
                    <tr>
                        <td>
                                ${material.name}
                            <input type="hidden" value="${material.materialID}" name="measurements[${counter}].materialID">
                        </td>
                        <td>${material.unit.name}</td>
                        <td>
                            <input type="text" class="datePicker prevent_type text-center" name="measurements[${counter}].date" style="width: 90px;"/>
                        </td>
                        <td><input id="value_${material.materialID}" name="measurements[${counter}].value" type="text" style="width: 120px;" onchange="checkNumber(this.value, this.id);"/></td>
                        <td><textarea rows="2" name="measurements[${counter}].note" class="span11"></textarea></td>
                    </tr>
                    <c:set var="counter" value="${counter + 1}"/>
                </c:forEach>
            </table>
        </div>
    </div>
</form:form>
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
    });
    function reloadByWarehouse(select){
        var warehouseID = $(select).val();
        location.href = '${formUrl}?warehouseID=' + warehouseID;
    }
    function checkMaterial(Ele){
        var id = $(Ele).attr("id");
        var materialID = id.split("_")[1];
        var value = $(Ele).val() != "" ? numeral().unformat($(Ele).val()) : 0;
        if(value > 0){
            $("#check_" + materialID).attr("checked", true);
            $("#check_" + materialID).parent("span").addClass("checked")
        }else{
            $("#check_" + materialID).attr("checked", false);
            $("#check_" + materialID).parent("span").removeClass("checked")
        }
    }
    function submitMeasure(){
        $("#crudaction").val("insert-update");
        $("#itemForm").submit();
    }

</script>
