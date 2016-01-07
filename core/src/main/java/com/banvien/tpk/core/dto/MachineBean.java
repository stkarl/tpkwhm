package com.banvien.tpk.core.dto;

import com.banvien.tpk.core.domain.Machine;

/**
 * Created with IntelliJ IDEA.
 * User: Chu Quoc Khanh
 * Date: 18/02/14
 * Time: 22:14
 * To change this template use File | Settings | File Templates.
 */
public class MachineBean extends AbstractBean<Machine> {
    public MachineBean(){
        this.pojo = new Machine();
    }

    private String componentCode;
    private String componentName;

    public String getComponentCode() {
        return componentCode;
    }

    public void setComponentCode(String componentCode) {
        this.componentCode = componentCode;
    }

    public String getComponentName() {
        return componentName;
    }

    public void setComponentName(String componentName) {
        this.componentName = componentName;
    }
}
