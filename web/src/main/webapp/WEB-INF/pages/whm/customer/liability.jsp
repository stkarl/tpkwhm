<%@ taglib prefix="path" uri="http://www.springframework.org/tags/form" %>
<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@page import="com.banvien.tpk.core.Constants" %>

<div class="row-fluid data_content">
    <div class="row-fluid">
        <div class="pane_info" style="border: none;">
            <div class="row-fluid">
                <div class="pane_info">
                    <div class="pane_title"><fmt:message key="whm.customer.info"/></div>
                    <div class="pane_content">
                        <div class="control-group">
                            <label class="control-label"><strong><fmt:message key="label.name"/>:</strong> ${customer.name}</label>
                            <label class="control-label"><strong><fmt:message key="label.address"/>:</strong> ${customer.address}</label>
                            <label class="control-label"><strong><fmt:message key="whm.province.name"/>:</strong> ${customer.province.name}</label>
                            <label class="control-label"><strong><fmt:message key="whm.region.name"/>:</strong> ${customer.region.name}</label>
                            <label class="control-label"><strong><fmt:message key="label.birthday"/>:</strong> <fmt:formatDate value="${customer.birthday}" pattern="dd/MM/yyyy"/></label>
                        </div>
                    </div>
                </div>

                <div class="pane_info">
                    <div class="pane_title"><fmt:message key="whm.customer.liability.info"/></div>
                    <div class="pane_content">
                        <div class="control-group">
                            <label class="control-label"><strong><fmt:message key="whm.current.money.owe"/>:</strong> <fmt:formatNumber value="${customer.owe}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/></label>
                            <label class="control-label"><strong><fmt:message key="whm.limit.money.owe"/>:</strong> <fmt:formatNumber value="${customer.oweLimit}" pattern="###,###" maxFractionDigits="0" minFractionDigits="0"/></label>
                            <label class="control-label"><strong><fmt:message key="whm.lastpay.date"/>:</strong>  <fmt:formatDate value="${customer.lastPayDate}" pattern="dd/MM/yyyy"/></label>
                            <label class="control-label"><strong><fmt:message key="whm.no.next.pay.day"/>:</strong> ${customer.dayAllow} <fmt:message key="label.no.day"/></label>
                            <label class="control-label"><strong><fmt:message key="label.status"/>:</strong> <c:if test="${customer.status == Constants.CUSTOMER_NORMAL}"><fmt:message key="label.normal"/></c:if>
                                <c:if test="${customer.status == Constants.CUSTOMER_WARNING}"><fmt:message key="label.bad"/></c:if>
                            </label>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

