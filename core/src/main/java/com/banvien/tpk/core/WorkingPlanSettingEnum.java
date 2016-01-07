package com.banvien.tpk.core;

/**
 * Created with IntelliJ IDEA.
 * User: viennh
 * Date: 8/28/13
 * Time: 6:45 PM
 * To change this template use File | Settings | File Templates.
 */
public enum  WorkingPlanSettingEnum {
    FIELD_DATE_SE("whm.workingplan.fielddate.se"),
    FIELD_DATE_ASM("whm.workingplan.fielddate.asm"),
    FIELD_DATE_RSM("whm.workingplan.fielddate.rsm"),
    DEADLINE_PLAN_SE("whm.workingplan.deadline.plan.se"),
    DEADLINE_PLAN_ASM("whm.workingplan.deadline.plan.asm"),
    DEADLINE_PLAN_RSM("whm.workingplan.deadline.plan.rsm"),
    DEADLINE_REPORT_SE("whm.workingplan.deadline.report.se"),
    DEADLINE_REPORT_ASM("whm.workingplan.deadline.report.asm"),
    DEADLINE_REPORT_RSM("whm.workingplan.deadline.report.rsm"),
    DEADLINE_PLAN_ALERT_1("whm.workingplan.deadline.plan.alert1"),
    DEADLINE_PLAN_ALERT_2("whm.workingplan.deadline.plan.alert2"),
    DEADLINE_REPORT_ALERT_1("whm.workingplan.deadline.report.alert1"),
    DEADLINE_REPORT_ALERT_2("whm.workingplan.deadline.report.alert2");
    private String key;

    public String getKey() {
        return key;
    }

    public void setKey(String key) {
        this.key = key;
    }

    private WorkingPlanSettingEnum(String key) {
        this.key = key;
    }
}
