package com.banvien.tpk.core.dto;

import java.io.Serializable;

/**
 * User: BAN
 * Date: 6/21/12
 * Time: 12:19 PM
 */
public class UserImportDcdtDTO implements Serializable {
    public String getRegion() {
        return region;
    }

    public void setRegion(String region) {
        this.region = region;
    }

    public String getRsmName() {
        return rsmName;
    }

    public void setRsmName(String rsmName) {
        this.rsmName = rsmName;
    }

    public String getRsmCode() {
        return rsmCode;
    }

    public void setRsmCode(String rsmCode) {
        this.rsmCode = rsmCode;
    }

    public String getAsmName() {
        return asmName;
    }

    public void setAsmName(String asmName) {
        this.asmName = asmName;
    }

    public String getAsmCode() {
        return asmCode;
    }

    public void setAsmCode(String asmCode) {
        this.asmCode = asmCode;
    }

    public String getDistributorName() {
        return distributorName;
    }

    public void setDistributorName(String distributorName) {
        this.distributorName = distributorName;
    }

    public String getDistributorCode() {
        return distributorCode;
    }

    public void setDistributorCode(String distributorCode) {
        this.distributorCode = distributorCode;
    }

    public String getSeName() {
        return seName;
    }

    public void setSeName(String seName) {
        this.seName = seName;
    }

    public String getSeCode() {
        return seCode;
    }

    public void setSeCode(String seCode) {
        this.seCode = seCode;
    }

    public String getSmName() {
        return smName;
    }

    public void setSmName(String smName) {
        this.smName = smName;
    }

    public String getSmCode() {
        return smCode;
    }

    public void setSmCode(String smCode) {
        this.smCode = smCode;
    }

    public String getErrorMessages() {
        return errorMessages;
    }

    public void setErrorMessages(String errorMessages) {
        this.errorMessages = errorMessages;
    }

    public Boolean getValid() {
        return valid;
    }

    public void setValid(Boolean valid) {
        this.valid = valid;
    }

    //region
    private String region;

    //RSM Name
    private String rsmName;

    //RSM Code
    private String rsmCode;

    //ASM Name
    private String asmName;

    //ASM Code
    private String asmCode;

    //DistributorName
    private String distributorName;

    //DistributorCode
    private String distributorCode;

    //SE Name
    private String seName;

    //SE Code
    private String seCode;

    //SM Name
    private String smName;

    //SM Code
    private String smCode;

    private String seEmail;

    private String asmEmail;

    private String rsmEmail;

    public String getSeEmail() {
        return seEmail;
    }

    public void setSeEmail(String seEmail) {
        this.seEmail = seEmail;
    }

    public String getAsmEmail() {
        return asmEmail;
    }

    public void setAsmEmail(String asmEmail) {
        this.asmEmail = asmEmail;
    }

    public String getRsmEmail() {
        return rsmEmail;
    }

    public void setRsmEmail(String rsmEmail) {
        this.rsmEmail = rsmEmail;
    }

    //Is Valid
    private Boolean valid;

    //Error Messages
    private String errorMessages;

    public UserImportDcdtDTO(UserImportDcdtDTO b) {
        this.setRegion(b.getRegion());
        this.setRsmName(b.getRsmName());
        this.setRsmCode(b.getRsmCode());
        this.setAsmName(b.getAsmName());
        this.setAsmCode(b.getAsmCode());
        this.setDistributorName(b.getDistributorName());
        this.setDistributorCode(b.getDistributorCode());
        this.setSeName(b.getSeName());
        this.setSeCode(b.getSeCode());
        this.setSmName(b.getSmName());
        this.setSmCode(b.getSmCode());
        this.setErrorMessages(b.getErrorMessages());
        this.setValid(b.getValid());
    }

    public UserImportDcdtDTO() {

    }
}
