<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<head>
    <title><fmt:message key="update.customer.receive.owe"/></title>
    <meta name="heading" content="<fmt:message key="update.customer.receive.owe"/>"/>
</head>

<c:url var="url" value="/whm/customer/receiveOwe.html"/>
<div id="content">
    <form:form commandName="items" action="${url}" method="post" id="listForm" name="listForm">
        <div id="container-fluid data_content_box">
            <div class="row-fluid data_content">
                <div class="content-header">
                    <fmt:message key="update.customer.receive.owe"/>
                </div>
                <div class="clear"></div>
                <c:if test="${not empty messageResponse}">
                    <div class="alert alert-${alertType}">
                        <button aria-hidden="true" data-dismiss="alert" class="close" type="button">x</button>
                            ${messageResponse}
                    </div>
                </c:if>
                <div class="report-filter">
                    <div class="row-fluid report-filter">
                        <table class="tbReportFilter">
                            <caption><fmt:message key="label.search.title"/></caption>
                            <tr>
                                <td ><fmt:message key="whm.customer.name"/></td>
                                <td>
                                    <form:select path="pojo.customerID" cssStyle="width: 360px;">
                                        <form:option value="-1">Tất cả</form:option>
                                        <c:forEach items="${customers}" var="customer">
                                            <form:option value="${customer.customerID}">${customer.name} - ${customer.province.name}</form:option>
                                        </c:forEach>
                                    </form:select>
                                </td>
                                <td colspan="2"></td>
                            </tr>
                            <tr>
                                <td ><fmt:message key="whm.province.name"/></td>
                                <td>
                                    <form:select path="pojo.province.provinceID">
                                        <form:option value="-1">Tất cả</form:option>
                                        <form:options items="${provinces}" itemValue="provinceID" itemLabel="name"/>
                                    </form:select>
                                </td>
                                <td ><fmt:message key="whm.region.name"/></td>
                                <td>
                                    <form:select path="pojo.region.regionID">
                                        <form:option value="-1">Tất cả</form:option>
                                        <form:options items="${regions}" itemValue="regionID" itemLabel="name"/>
                                    </form:select>
                                </td>
                            </tr>
                            <tr style="text-align: center;">
                                <td colspan="4">
                                    <form:hidden path="crudaction" id="crudaction" value="doReport"/>
                                    <a id="btnFilter" class="btn btn-primary" onclick="submitSearch();"><i class="icon-refresh"></i> <fmt:message key="label.search"/> </a>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
                <div class="clear"></div>
                <div class="button-actions">
                    <a class="btn btn-info" onclick="save();"><i class="icon-save"></i>  <fmt:message key="button.update"/></a>
                </div>
                <div class="clear"></div>
                <display:table name="items.listResult" cellspacing="0" cellpadding="0" requestURI="${url}"
                               partialList="true" sort="external" size="${items.totalItems}"  uid="tableList" pagesize="${items.maxPageItems}" class="tableSadlier table-hover" export="false">
                    <display:caption><fmt:message key='update.customer.receive.owe'/></display:caption>
                    <display:column headerClass="table_header_center"  escapeXml="false" sortable="true" sortName="name" titleKey="label.name" style="width: 10%;text-align:center;" >
                        ${tableList.name}
                    </display:column>
                    <display:column headerClass="table_header_center"  escapeXml="false" sortable="false" sortName="region.name" titleKey="whm.region.name" style="width: 15%;text-align:center;" >
                        ${tableList.province.name}
                    </display:column>
                    <display:column headerClass="table_header_center"  escapeXml="false" sortable="false" titleKey="whm.current.money.owe" style="width: 10%;text-align:center;" >
                        <span id="current-owe-${tableList.customerID}"><fmt:formatNumber value="${mapCustomerOwe[tableList.customerID]}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/></span>
                    </display:column>
                    <display:column headerClass="table_header_center"  escapeXml="false" sortable="false" titleKey="label.owe" style="width: 10%;text-align:center;" >
                        <input type="text" class="inputFractionNumber" name="updateLiabilities[${tableList_rowNum - 1}].value" id="owe-${tableList.customerID}" onblur="calNewOwe(this);" style="width: 90px;text-align:center;"/>
                    </display:column>
                    <display:column headerClass="table_header_center"  escapeXml="false" sortable="false" titleKey="label.new.own.remain" style="width: 10%;text-align:center;" >
                        <span id="remain-owe-${tableList.customerID}"></span>
                    </display:column>
                    <display:column headerClass="table_header_center"  escapeXml="false" sortable="false" titleKey="owe.date" style="width: 10%;text-align:center;">
                        <input id="date-${tableList.customerID}" type="text" class="datePicker prevent_type text-center" name="updateLiabilities[${tableList_rowNum - 1}].date" style="width: 80px;text-align:center;"/>
                    </display:column>
                    <display:column headerClass="table_header_center"  escapeXml="false" sortable="false" titleKey="will.pay.after.no.day" style="width: 5%;text-align:center;" >
                        <input style="width: 25px;" type="text" name="updateLiabilities[${tableList_rowNum - 1}].day"/>
                    </display:column>
                    <display:column headerClass="table_header_center"  escapeXml="false" sortable="false" titleKey="label.note" style="width: 5%;text-align:center;" >
                        <textarea style="width: 180px;" rows="2" name="updateLiabilities[${tableList_rowNum - 1}].note"></textarea>
                    </display:column>
                    <display:column headerClass="table_header_center" sortable="false" titleKey="<input type=\"checkbox\" onclick=\"checkAllByClass('checkPrd', this);\"/>" style="width: 5%;text-align:center;">
                        <input class="checkPrd" type="checkbox" name="updateLiabilities[${tableList_rowNum - 1}].customerID" value="${tableList.customerID}" id="check-${tableList.customerID}"/>
                    </display:column>
                    <display:setProperty name="paging.banner.item_name"><fmt:message key= "whm.customer.name"/></display:setProperty>
                    <display:setProperty name="paging.banner.items_name"><fmt:message key= "whm.customer.name"/></display:setProperty>
                    <display:setProperty name="paging.banner.placement" value="bottom"/>
                    <display:setProperty name="paging.banner.no_items_found" value=""/>
                </display:table>
                <div class="clear"></div>
            </div>
        </div>


    </form:form>
</div>


<script type="text/javascript">

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

    <c:if test="${not empty items.crudaction}">
    highlightTableRows("tableList");
    </c:if>
    $(function() {
        $("#deleteConfirmLink").click(function() {
            $('#crudaction').val('delete');
            document.forms['listForm'].submit();
        });
        $('a[name="deleteLink"]').click(function(eventObj) {
            //document.location.href = eventObj.target.href;
            return true;

        });

    });
    function confirmDeleteItem(){
        var fb = checkSelected4ConfirmDelete('listForm', 'checkList');
        if(fb) {
            $("#deleteConfirmLink").trigger('click');
        }else {
            $("#hidenWarningLink").trigger('click');
        }
    }

    function calNewOwe(ele){
        var id = $(ele).attr('id').split('-')[1];
        var val = $(ele).val();
        if(val != ''){
            val = numeral().unformat(val);
        }else{
            val = 0;
        }
        var cur = $('#current-owe-' + id).text();
        if(cur != ''){
            cur = numeral().unformat(cur);
        }else{
            cur = 0;
        }
        $('#remain-owe-' + id).text(numeral(cur + val).format('###,###'))
        $("#check-" + id).attr("checked", true);
        $("#check-" + id).parent("span").addClass("checked")


    }

    function submitSearch(){
        $("#crudaction").val("search");
        $('#listForm').submit();
    }

    function save(){
        $("#crudaction").val("insert-update");
        var hasInputNumber = false;
        $('.inputFractionNumber').each(function(){
            if($(this).val() != '' && $(this).val() != 0 ) {
                hasInputNumber = true;
                $(this).val(numeral().unformat($(this).val()));
            }
        });
        var checker = true;
        var checkDate = true;
        var isSelected = false;
        $(".checkPrd:checked").each(function()
        {
            isSelected = true;
            var cusId = $(this).val();
            if($('#date-' + cusId).val() == ''){
                checkDate = false;
            }
            if($('#owe-' + cusId).val() == ''){
                checker = false;
            }
        });
        if(checker && checkDate && isSelected){
            bootbox.confirm('Xác nhận cập nhật công nợ', 'Bạn có chắc chắn muốn cập nhật công nợ không?', function(r) {
                if(r){
                    $("#listForm").submit();
                }
            });
        }else if(!checker){
            bootbox.alert("<fmt:message key="label.title.confirm"/>", "<fmt:message key="msg.waring.write.owe.incorrect"/>",function(){
            });
        }else if(!checkDate){
            bootbox.alert("<fmt:message key="label.title.confirm"/>", "Chưa chọn ngày thanh toán",function(){
            });
        }
        else if(!isSelected){
            bootbox.alert("<fmt:message key="label.title.confirm"/>", "Chưa chọn khách hàng cần thanh toán",function(){
            });
        }
    }

</script>


