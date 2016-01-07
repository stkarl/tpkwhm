package com.banvien.tpk.core;

/**
 * Created with IntelliJ IDEA.
 * User: viennh
 * Date: 8/28/13
 * Time: 6:45 PM
 * To change this template use File | Settings | File Templates.
 */
public enum StudentAssignmentEnum {
   // SCORECARD_ATTRITION_THRESHOLD("whm.scorecard.attrition.threshold");
   STUDENT_ASSIGNMENT_ENUM("");
    private String key;

    public String getKey() {
        return key;
    }

    public void setKey(String key) {
        this.key = key;
    }

    private StudentAssignmentEnum(String key) {
        this.key = key;
    }
}
