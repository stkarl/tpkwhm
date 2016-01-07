package com.banvien.tpk.core.service;

import com.banvien.tpk.core.domain.MachineComponentPicture;
import com.banvien.tpk.core.domain.Machinecomponent;


public interface MachineComponentPictureService extends GenericService<MachineComponentPicture,Long> {

    void saveComponentPicture(Machinecomponent machinecomponent, String path, String des);
}