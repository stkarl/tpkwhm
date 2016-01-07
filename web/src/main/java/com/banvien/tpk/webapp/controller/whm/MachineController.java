package com.banvien.tpk.webapp.controller.whm;

import com.banvien.tpk.core.Constants;
import com.banvien.tpk.core.domain.*;
import com.banvien.tpk.core.dto.MachineBean;
import com.banvien.tpk.core.dto.MachinecomponentBean;
import com.banvien.tpk.core.exception.DuplicateException;
import com.banvien.tpk.core.exception.ObjectNotFoundException;
import com.banvien.tpk.core.service.*;
import com.banvien.tpk.security.SecurityUtils;
import com.banvien.tpk.webapp.editor.CustomDateEditor;
import com.banvien.tpk.webapp.util.CommonUtil;
import com.banvien.tpk.webapp.util.FileUtils;
import com.banvien.tpk.webapp.util.RequestUtil;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.aspectj.util.FileUtil;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.ApplicationObjectSupport;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

@Controller
public class MachineController extends ApplicationObjectSupport {
    private transient final Log log = LogFactory.getLog(getClass());

    @Autowired
    private MachineService machineService;

    @Autowired
    private WarehouseService warehouseService;

    @Autowired
    private MachinecomponentService machinecomponentService;

    @Autowired
    private MaintenanceHistoryService maintenanceHistoryService;

    @Autowired
    private UserService userService;

    @Autowired
    private MachinePictureService machinePictureService;

    @Autowired
    private MachineComponentPictureService machineComponentPictureService;



    @InitBinder
    public void initBinder(WebDataBinder binder) {
        binder.registerCustomEditor(Timestamp.class, new CustomDateEditor("dd/MM/yyyy"));
    }

    @RequestMapping("/whm/machine/edit.html")
    public ModelAndView edit(@ModelAttribute(Constants.FORM_MODEL_KEY) MachineBean bean, BindingResult bindingResult) {
        ModelAndView mav = new ModelAndView("/whm/machine/edit");

        String crudaction = bean.getCrudaction();
        Machine pojo = bean.getPojo();
        bean.setLoginID(SecurityUtils.getLoginUserId());
        if(StringUtils.isNotBlank(crudaction) && crudaction.equals("insert-update")) {
            try {

                if(!bindingResult.hasErrors()) {
                    if(pojo.getMachineID() != null && pojo.getMachineID() > 0) {
                        this.machineService.updateItem(bean);
                        mav = new ModelAndView("redirect:/whm/machine/list.html?isUpdate=true");
                    } else {
                        this.machineService.addNew(bean);
                        mav = new ModelAndView("redirect:/whm/machine/list.html?isAdd=true");
                    }
                    return mav;
                }
            }catch (ObjectNotFoundException oe) {
                logger.error(oe.getMessage());
                mav.addObject("alertType","error");
                mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("database.exception.keynotfound"));
            }catch (DuplicateException de) {
                logger.error(de.getMessage());
                mav.addObject("alertType","error");
                mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("database.exception.duplicate"));
            }catch(Exception e) {
                logger.error(e.getMessage(), e);
                mav.addObject("alertType","error");
                mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("general.exception.msg"));
            }
        }
        if(!bindingResult.hasErrors()&& bean.getPojo().getMachineID() != null && bean.getPojo().getMachineID() > 0) {
            try {
                Machine itemObj = this.machineService.findById(pojo.getMachineID());
                bean.setPojo(itemObj);
            }
            catch (Exception e) {
                logger.error("Could not found news " + bean.getPojo().getMachineID(), e);
            }
        }else if(bean.getPojo().getStatus() == null){
            bean.getPojo().setStatus(Constants.MACHINE_NORMAL);
        }
        addData2Model(mav);
        mav.addObject(Constants.FORM_MODEL_KEY, bean);
        return mav;
    }

    private void addData2Model(ModelAndView mav){
        mav.addObject("warehouses", this.warehouseService.findAllActiveWarehouseExcludeID(null));
    }



    @RequestMapping(value={"/whm/machine/list.html"})
    public ModelAndView list(MachineBean bean,HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("/whm/machine/list");
        if(StringUtils.isNotBlank(bean.getCrudaction()) && bean.getCrudaction().equals(Constants.ACTION_DELETE)) {
            Integer totalDeleted = 0;
            try {
                totalDeleted = machineService.deleteItems(bean.getCheckList());
                mav.addObject("totalDeleted", totalDeleted);
            }catch (Exception e) {
                log.error(e.getMessage(), e);
                mav.addObject("alertType","error");
                mav.addObject(Constants.MESSAGE_RESPONSE_MODEL_KEY, this.getMessageSourceAccessor().getMessage("database.multipledelete.exception"));
            }
        }
        bean.setLoginID(SecurityUtils.getLoginUserId());
        executeSearch(bean, request);
        mav.addObject(Constants.LIST_MODEL_KEY, bean);
        showAlert(mav,bean.getIsAdd(),bean.getIsUpdate(),bean.getIsError());
        return mav;
    }

    private void executeSearch(MachineBean bean, HttpServletRequest request) {
        RequestUtil.initSearchBean(request, bean);
        Object[] results = this.machineService.search(bean);
        bean.setListResult((List<Machine>)results[1]);
        bean.setTotalItems(Integer.valueOf(results[0].toString()));
    }

    private void showAlert(ModelAndView mav,Boolean isAdd, Boolean isUpdate, Boolean isError){
        if(isAdd){
            mav.addObject("alertType","success");
            mav.addObject(Constants.MESSAGE_RESPONSE_MODEL_KEY, this.getMessageSourceAccessor().getMessage("database.add.successful"));
        }else if(isUpdate){
            mav.addObject("alertType","success");
            mav.addObject(Constants.MESSAGE_RESPONSE_MODEL_KEY, this.getMessageSourceAccessor().getMessage("database.update.successful"));
        }else if(isError){
            mav.addObject("alertType","error");
            mav.addObject(Constants.MESSAGE_RESPONSE_MODEL_KEY, this.getMessageSourceAccessor().getMessage("error.occur"));
        }
    }

    @RequestMapping("/whm/machine/viewdetail.html")
    public ModelAndView viewDetail(@ModelAttribute(Constants.FORM_MODEL_KEY) MachineBean bean, BindingResult bindingResult) {
        ModelAndView mav = new ModelAndView("/whm/machine/viewdetail");

        Machine pojo = bean.getPojo();
        if(!bindingResult.hasErrors()&& bean.getPojo().getMachineID() != null && bean.getPojo().getMachineID() > 0) {
            try {
                Machine itemObj = this.machineService.findById(pojo.getMachineID());
                addData2Machine(itemObj);
                bean.setPojo(itemObj);
            }
            catch (Exception e) {
                logger.error("Could not found news " + bean.getPojo().getMachineID(), e);
            }
        }
        mav.addObject(Constants.FORM_MODEL_KEY, bean);
        return mav;
    }

    private void addData2Machine(Machine machine) {
        List<Machinecomponent> machinecomponents = this.machinecomponentService.findByMachineAndWarehouse(machine.getMachineID(),machine.getWarehouse().getWarehouseID());
        machine.setMachinecomponents(machinecomponents);

        Maintenancehistory log = this.maintenanceHistoryService.findLastestMachine(machine.getMachineID());
        machine.setLatestMaintenance(log);
    }

    @RequestMapping("/ajax/addComponent.html")
    public ModelAndView ajaxAddComponent(@RequestParam(value = "componentCode", required = true) String componentCode,
                                         @RequestParam(value = "componentName", required = true) String componentName,
                                         @RequestParam(value = "machineID", required = true) Long machineID,
                                         @RequestParam(value = "componentDescription", required = false) String componentDescription,
                                         HttpServletResponse response){
        ModelAndView mav = new ModelAndView("/whm/machine/success");
        Machine machine = new Machine();
        machine.setMachineID(machineID);
        MachinecomponentBean bean = new MachinecomponentBean();
        Machinecomponent component = new Machinecomponent(componentName, componentCode, componentDescription, machine, Constants.MACHINE_NORMAL);
        bean.setPojo(component);
        bean.setLoginID(SecurityUtils.getLoginUserId());
        try {
            this.machinecomponentService.addNew(bean);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        return mav;
    }

    @RequestMapping("/ajax/addSubComponent.html")
    public ModelAndView ajaxAddSubComponent(@RequestParam(value = "componentCode", required = true) String componentCode,
                                            @RequestParam(value = "componentName", required = true) String componentName,
                                            @RequestParam(value = "parentID", required = true) Long parentID,
                                            @RequestParam(value = "componentDescription", required = false) String componentDescription,
                                            HttpServletResponse response){
        ModelAndView mav = new ModelAndView("/whm/machine/success");
        Machinecomponent parent = this.machinecomponentService.findByIdNoCommit(parentID);
        parent.setMachineComponentID(parentID);
        MachinecomponentBean bean = new MachinecomponentBean();
        Machinecomponent component = new Machinecomponent(componentName, componentCode, componentDescription, null, Constants.MACHINE_NORMAL);
        component.setParent(parent);
        bean.setPojo(component);
        bean.setLoginID(SecurityUtils.getLoginUserId());
        try {
            this.machinecomponentService.addNew(bean);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            return new ModelAndView();
        }
        return mav;
    }

    private Machine getMachineRoot(Machinecomponent parent) {
        if(parent.getMachine() != null){
            return parent.getMachine();
        }else{
            return getMachineRoot(parent.getParent());
        }
    }

    @RequestMapping("/ajax/editComponent.html")
    public ModelAndView ajaxEditComponent(@RequestParam(value = "componentCode", required = true) String componentCode,
                                          @RequestParam(value = "componentName", required = true) String componentName,
                                          @RequestParam(value = "componentID", required = true) Long componentID,
                                          @RequestParam(value = "componentDescription", required = false) String componentDescription,
                                          HttpServletResponse response){
        ModelAndView mav = new ModelAndView("/whm/machine/success");
        Machinecomponent component = null;
        try {
            component = this.machinecomponentService.updateItemAjax(componentID, componentName, componentCode, componentDescription);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        return mav;
    }

    @RequestMapping(value = "/ajax/deleteComponent.html")
    public void ajaxDeleteComponent(@RequestParam(value = "componentID", required = true) Long componentID,
                                    HttpServletResponse response){
        try{
            response.setContentType("text/json; charset=UTF-8");
            PrintWriter out = response.getWriter();
            JSONObject object = new JSONObject();
            Machinecomponent machinecomponent = new Machinecomponent();
            machinecomponent.setMachineComponentID(componentID);
            try {
                this.machinecomponentService.delete(machinecomponent);
            } catch (Exception e) {
                logger.error(e.getMessage(),e);
                object.put("text", "fail");
            }
            object.put("text", "success");
            out.print(object);
            out.flush();
            out.close();
        } catch (IOException e) {
            logger.error(e.getMessage(),e);
        } catch (JSONException e1) {
            logger.error(e1.getMessage(),e1);
        }
    }
    @RequestMapping(value = "/ajax/duplicateComponent.html")
    public void ajaxDupComponent(@RequestParam(value = "componentID", required = true) Long componentID,
                                 @RequestParam(value = "numberOfComponent", required = true) Integer numberOfComponent,
                                 HttpServletResponse response){
        try{
            response.setContentType("text/json; charset=UTF-8");
            PrintWriter out = response.getWriter();
            JSONObject object = new JSONObject();
            try {
                this.machinecomponentService.addDuplicateComponent(componentID, numberOfComponent);
                object.put("msg", "success");
            } catch (Exception e) {
                logger.error(e.getMessage(),e);
                object.put("msg", "fail");
            }
            out.print(object);
            out.flush();
            out.close();
        } catch (IOException e) {
            logger.error(e.getMessage(),e);
        } catch (JSONException e1) {
            logger.error(e1.getMessage(),e1);
        }
    }

    @RequestMapping(value = "/ajax/maintainComponent.html")
    public void ajaxMaintainComponent(@RequestParam(value = "componentID", required = true) Long componentID,
                                      @RequestParam(value = "componentDate", required = true) String componentDate,
                                      @RequestParam(value = "componentNoDay", required = false) Integer componentNoDay,
                                      @RequestParam(value = "maintainDes", required = false) String maintainDes,
                                      @RequestParam(value = "status", required = false) Integer status,
                                      HttpServletResponse response){
        try{
            response.setContentType("text/json; charset=UTF-8");
            PrintWriter out = response.getWriter();
            JSONObject object = new JSONObject();
            try {
                this.machinecomponentService.addMaintainDetail(SecurityUtils.getLoginUserId(), componentID, componentDate, componentNoDay, maintainDes,status);
                object.put("msg", "success");
            } catch (Exception e) {
                logger.error(e.getMessage(),e);
                object.put("msg", "fail");
            }
            out.print(object);
            out.flush();
            out.close();
        } catch (IOException e) {
            logger.error(e.getMessage(),e);
        } catch (JSONException e1) {
            logger.error(e1.getMessage(),e1);
        }
    }

    @RequestMapping(value = "/ajax/maintainMachine.html")
    public void ajaxMaintainMachine(@RequestParam(value = "machineID", required = true) Long machineID,
                                    @RequestParam(value = "machineDate", required = true) String machineDate,
                                    @RequestParam(value = "machineNoDay", required = false) Integer machineNoDay,
                                    @RequestParam(value = "maintainDes", required = false) String maintainDes,
                                    @RequestParam(value = "status", required = false) Integer status,
                                    HttpServletResponse response){
        try{
            response.setContentType("text/json; charset=UTF-8");
            PrintWriter out = response.getWriter();
            JSONObject object = new JSONObject();
            try {
                this.machinecomponentService.addMaintainMachineDetail(SecurityUtils.getLoginUserId(), machineID, machineDate, machineNoDay, maintainDes,status);
                object.put("msg", "success");
            } catch (Exception e) {
                logger.error(e.getMessage(),e);
                object.put("msg", "fail");
            }
            out.print(object);
            out.flush();
            out.close();
        } catch (IOException e) {
            logger.error(e.getMessage(),e);
        } catch (JSONException e1) {
            logger.error(e1.getMessage(),e1);
        }
    }


    @RequestMapping(value = "/ajax/machineLog.html")
    public ModelAndView machineLog(@RequestParam(value = "machineID", required = true)Long machineID,
                                   HttpServletResponse response) throws ObjectNotFoundException {

        ModelAndView mav = new ModelAndView("/whm/machine/logs");
        try{
            Machine machine = this.machineService.findById(machineID);
            List<Maintenancehistory> logs = this.maintenanceHistoryService.findByMachine(machineID);
            mav.addObject("machine", machine);
            mav.addObject("logs", logs);
        }catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        return mav;
    }

    @RequestMapping(value = "/ajax/componentLog.html")
    public ModelAndView componentLog(@RequestParam(value = "machineComponentID", required = true)Long machineComponentID,
                                     HttpServletResponse response) throws ObjectNotFoundException {

        ModelAndView mav = new ModelAndView("/whm/machinecomponent/logs");
        try{
            Machinecomponent machineComponent = this.machinecomponentService.findById(machineComponentID);
            List<Maintenancehistory> logs = this.maintenanceHistoryService.findByMachineComponent(machineComponentID);
            mav.addObject("machineComponent", machineComponent);
            mav.addObject("logs", logs);
        }catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        return mav;
    }

    @RequestMapping(value = "/ajax/submitMachine.html")
    public void ajaxSubmitForConfirm(@RequestParam(value = "machineID", required = true) Long machineID,
                                     HttpServletResponse response){
        try{
            response.setContentType("text/json; charset=UTF-8");
            PrintWriter out = response.getWriter();
            JSONObject object = new JSONObject();
            try {
                object.put("msg", "success");
                this.machineService.updateSubmitMachineForConfirm(SecurityUtils.getLoginUserId(), machineID, Constants.MACHINE_SUBMIT);
            } catch (Exception e) {
                logger.error(e.getMessage(),e);
                object.put("msg", "fail");
            }
            out.print(object);
            out.flush();
            out.close();
        } catch (IOException e) {
            logger.error(e.getMessage(),e);
        } catch (JSONException e1) {
            logger.error(e1.getMessage(),e1);
        }
    }

    @RequestMapping(value = "/ajax/submitRejectMachine.html")
    public void ajaxSubmitRejectMachine(@RequestParam(value = "machineID", required = true) Long machineID,
                                        HttpServletResponse response){
        response.setContentType("text/json; charset=UTF-8");
        try {
            PrintWriter out = response.getWriter();
            JSONObject object = new JSONObject();
            try {
                object.put("msg", "success");
                this.machineService.updateSubmitMachineForConfirm(SecurityUtils.getLoginUserId(), machineID, Constants.MACHINE_REJECTED);
            } catch (Exception e) {
                logger.error(e.getMessage(),e);
                object.put("msg", "fail");
            }
            out.print(object);
            out.flush();
            out.close();
        } catch (IOException e) {
            logger.error(e.getMessage(),e);
        } catch (JSONException e1) {
            logger.error(e1.getMessage(),e1);
        }

    }

    @RequestMapping(value = "/ajax/submitApproveMachine.html")
    public void ajaxSubmitApproveMachine(@RequestParam(value = "machineID", required = true) Long machineID,
                                         HttpServletResponse response){
        response.setContentType("text/json; charset=UTF-8");
        try {
            PrintWriter out = response.getWriter();
            JSONObject object = new JSONObject();
            try {
                object.put("msg", "success");
                Integer status = SecurityUtils.getPrincipal().getRole().equals(Constants.LANHDAO_ROLE) ? Constants.MACHINE_APPROVED_2 : SecurityUtils.getPrincipal().getRole().equals(Constants.QLKT_ROLE) ? Constants.MACHINE_APPROVED_1 : null;
                this.machineService.updateSubmitMachineForConfirm(SecurityUtils.getLoginUserId(), machineID, status);
            } catch (Exception e) {
                logger.error(e.getMessage(),e);
                object.put("msg", "fail");
            }
            out.print(object);
            out.flush();
            out.close();
        } catch (IOException e) {
            logger.error(e.getMessage(),e);
        } catch (JSONException e1) {
            logger.error(e1.getMessage(),e1);
        }

    }


    @RequestMapping(value = "/ajax/machineUpload.html")
    public void machineUpload(
            @RequestParam(value = "upFor", required = true) Long upFor,
            @RequestParam(value = "picDes", required = false) Map<Integer,String> picDes,
                                         HttpServletResponse response, HttpServletRequest request){
        response.setContentType("text/json; charset=UTF-8");
        try {
            PrintWriter out = response.getWriter();
            JSONObject object = new JSONObject();
            try {
                Machine machine = this.machineService.findByIdNoCommit(upFor);
                String destFolder = CommonUtil.getBaseFolder() + CommonUtil.getTempFolderName();
                MultipartHttpServletRequest mRequest = (MultipartHttpServletRequest)request;
                Map<String, MultipartFile> map = mRequest.getFileMap();
                String key;
                String path;
                String des;
                for(int i = 0; i < 5 ; i++){
                    key = "path-" + i;
                    if (map.get(key)!= null){
                        MultipartFile fileUpload = (MultipartFile) map.get(key);
                        if (fileUpload!= null && fileUpload.getSize() > 0){
                            String fileName = FileUtils.upload(mRequest, destFolder, fileUpload);
                            String destFileNamePicture = request.getSession().getServletContext().getRealPath(destFolder + "/" + fileName);
                            File file = new File(destFileNamePicture);
                            path = extractUploadFileForMachine(file, request, "machine", machine.getCode());
                            machinePictureService.saveMachinePicture(machine,path,"");
                        }
                    }
                }
                object.put("msg", "success");
            } catch (Exception e) {
                logger.error(e.getMessage(),e);
                object.put("msg", "fail");
            }
            out.print(object);
            out.flush();
            out.close();
        } catch (IOException e) {
            logger.error(e.getMessage(),e);
        } catch (JSONException e1) {
            logger.error(e1.getMessage(),e1);
        }
    }

    private String extractUploadFileForMachine(File fileEntry, HttpServletRequest request,String subFolder, String code)
    {
        String path = null;
        try
        {
            String fileName = fileEntry.getName().toLowerCase();
            if(!fileName.endsWith(".exe") || !fileName.endsWith(".bat") || !fileName.endsWith(".msi")){
                //Copy to server
                code = StringUtils.isNotBlank(code) ? code : String.valueOf(System.currentTimeMillis());
                String strFolder = "files/" + subFolder + "/" + code;
                File folder = new File(request.getSession().getServletContext().getRealPath(strFolder));
                if(folder.mkdir())
                {
                    System.out.println("Multiple directories are created!");
                }
                else
                {
                    System.out.println("Failed to create multiple directories!");
                }
                File srcFile = new File(fileEntry.getPath());
                FileUtil.copyFile(srcFile, folder);
                path = strFolder + "/"+ fileEntry.getName();
            }
        }
        catch (Exception ex)
        {
            ex.printStackTrace();
            log.error("can't insert pictures", ex);
        }
        return path;
    }


    @RequestMapping(value = "/ajax/deleteMachinePicture.html")
    public void deleteMachinePicture(
            @RequestParam(value = "machinePictureID", required = true) Long machinePictureID,
            HttpServletResponse response, HttpServletRequest request){
        response.setContentType("text/json; charset=UTF-8");
        try {
            PrintWriter out = response.getWriter();
            JSONObject object = new JSONObject();
            try {
                MachinePicture machinePicture = new MachinePicture();
                machinePicture.setMachinePictureID(machinePictureID);
                machinePictureService.delete(machinePicture);
                object.put("msg", "success");
            } catch (Exception e) {
                logger.error(e.getMessage(),e);
                object.put("msg", "fail");
            }
            out.print(object);
            out.flush();
            out.close();
        } catch (IOException e) {
            logger.error(e.getMessage(),e);
        } catch (JSONException e1) {
            logger.error(e1.getMessage(),e1);
        }
    }

    @RequestMapping(value = "/ajax/componentUpload.html")
    public void componentUpload(
            @RequestParam(value = "upFor", required = true) Long upFor,
            @RequestParam(value = "picDes", required = false) Map<Integer,String> picDes,
            HttpServletResponse response, HttpServletRequest request){
        response.setContentType("text/json; charset=UTF-8");
        try {
            PrintWriter out = response.getWriter();
            JSONObject object = new JSONObject();
            try {
                Machinecomponent machinecomponent = this.machinecomponentService.findByIdNoCommit(upFor);
                String destFolder = CommonUtil.getBaseFolder() + CommonUtil.getTempFolderName();
                MultipartHttpServletRequest mRequest = (MultipartHttpServletRequest)request;
                Map<String, MultipartFile> map = mRequest.getFileMap();
                String key;
                String path;
                String des;
                for(int i = 0; i < 5 ; i++){
                    key = "path-" + i;
                    if (map.get(key)!= null){
                        MultipartFile fileUpload = (MultipartFile) map.get(key);
                        if (fileUpload!= null && fileUpload.getSize() > 0){
                            String fileName = FileUtils.upload(mRequest, destFolder, fileUpload);
                            String destFileNamePicture = request.getSession().getServletContext().getRealPath(destFolder + "/" + fileName);
                            File file = new File(destFileNamePicture);
                            path = extractUploadFileForMachine(file, request, "machinecomponent", machinecomponent.getCode());
                            machineComponentPictureService.saveComponentPicture(machinecomponent,path,"");
                        }
                    }
                }
                object.put("msg", "success");
            } catch (Exception e) {
                logger.error(e.getMessage(),e);
                object.put("msg", "fail");
            }
            out.print(object);
            out.flush();
            out.close();
        } catch (IOException e) {
            logger.error(e.getMessage(),e);
        } catch (JSONException e1) {
            logger.error(e1.getMessage(),e1);
        }
    }

    @RequestMapping(value = "/ajax/deleteComponentPicture.html")
    public void deleteComponentPicture(
            @RequestParam(value = "componentPictureID", required = true) Long componentPictureID,
            HttpServletResponse response, HttpServletRequest request){
        response.setContentType("text/json; charset=UTF-8");
        try {
            PrintWriter out = response.getWriter();
            JSONObject object = new JSONObject();
            try {
                MachineComponentPicture machineComponentPicture = new MachineComponentPicture();
                machineComponentPicture.setMachineComponentPictureID(componentPictureID);
                machineComponentPictureService.delete(machineComponentPicture);
                object.put("msg", "success");
            } catch (Exception e) {
                logger.error(e.getMessage(),e);
                object.put("msg", "fail");
            }
            out.print(object);
            out.flush();
            out.close();
        } catch (IOException e) {
            logger.error(e.getMessage(),e);
        } catch (JSONException e1) {
            logger.error(e1.getMessage(),e1);
        }
    }
}
