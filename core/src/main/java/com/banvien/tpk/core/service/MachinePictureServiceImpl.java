package com.banvien.tpk.core.service;

import com.banvien.tpk.core.dao.GenericDAO;
import com.banvien.tpk.core.dao.MachinePictureDAO;
import com.banvien.tpk.core.domain.Machine;
import com.banvien.tpk.core.domain.MachinePicture;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class MachinePictureServiceImpl extends GenericServiceImpl<MachinePicture,Long>
                                                    implements MachinePictureService {

    protected final Log logger = LogFactory.getLog(getClass());

    private MachinePictureDAO machinePictureDAO;

    public void setMachinePictureDAO(MachinePictureDAO machinePictureDAO) {
        this.machinePictureDAO = machinePictureDAO;
    }

    @Override
	protected GenericDAO<MachinePicture, Long> getGenericDAO() {
		return machinePictureDAO;
	}


    @Override
    public void saveMachinePicture(Machine machine, String path, String des) {
        MachinePicture machinePicture = new MachinePicture();
        machinePicture.setMachine(machine);
        machinePicture.setPath(path);
        machinePicture.setDes(des);
        machinePictureDAO.save(machinePicture);

    }
}