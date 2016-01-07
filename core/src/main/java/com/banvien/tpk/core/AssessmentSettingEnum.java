package com.banvien.tpk.core;

/**
 * Created with IntelliJ IDEA.
 * User: viennh
 * Date: 8/28/13
 * Time: 4:42 PM
 * To change this template use File | Settings | File Templates.
 */
public enum AssessmentSettingEnum {
    ASS_DEADLINE_SE("whm.assessment.deadline.se"),
    ASS_DEADLINE_ASM("whm.assessment.deadline.asm"),
    ASS_DEADLINE_RSM("whm.assessment.deadline.rsm"),
    ASS_DEADLINE_ALERT_1("whm.assessment.deadline.alert1"),
    ASS_DEADLINE_ALERT_2("whm.assessment.deadline.alert2");

    private String key;
    private AssessmentSettingEnum(String key) {
        this.key = key;
    }

    public String getKey() {
        return key;
    }

    public void setKey(String key) {
        this.key = key;
    }
}
