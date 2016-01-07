package com.banvien.tpk.core;

/**
 * Created with IntelliJ IDEA.
 * User: viennh
 * Date: 8/28/13
 * Time: 6:45 PM
 * To change this template use File | Settings | File Templates.
 */
public enum ScorecardSettingEnum {
    SCORECARD_ATTRITION_THRESHOLD("whm.scorecard.attrition.threshold"),
    SCORECARD_MONTH_DEADLINE_SUBMISSION("whm.scorecard.month.deadline.submission");
    private String key;

    public String getKey() {
        return key;
    }

    public void setKey(String key) {
        this.key = key;
    }

    private ScorecardSettingEnum(String key) {
        this.key = key;
    }
}
