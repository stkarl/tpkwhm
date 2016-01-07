package com.banvien.tpk.core.service;

import com.banvien.tpk.core.domain.Machine;
import com.banvien.tpk.core.domain.MachinePicture;


public interface MachinePictureService extends GenericService<MachinePicture,Long> {

    void saveMachinePicture(Machine machine, String path, String des);
}