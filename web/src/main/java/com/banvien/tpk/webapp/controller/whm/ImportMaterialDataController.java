package com.banvien.tpk.webapp.controller.whm;

import com.banvien.tpk.core.Constants;
import com.banvien.tpk.core.domain.Warehouse;
import com.banvien.tpk.core.dto.ImportMaterialDataBean;
import com.banvien.tpk.core.dto.ImportMaterialDataDTO;
import com.banvien.tpk.core.dto.ImportmaterialbillBean;
import com.banvien.tpk.core.service.ImportmaterialService;
import com.banvien.tpk.core.service.MaterialService;
import com.banvien.tpk.core.service.OriginService;
import com.banvien.tpk.core.service.WarehouseService;
import com.banvien.tpk.core.util.CacheUtil;
import com.banvien.tpk.security.SecurityUtils;
import com.banvien.tpk.webapp.util.CommonUtil;
import com.banvien.tpk.webapp.util.ExcelUtil;
import com.banvien.tpk.webapp.util.FileUtils;
import com.banvien.tpk.webapp.util.RequestUtil;
import jxl.Cell;
import jxl.Sheet;
import jxl.Workbook;
import jxl.WorkbookSettings;
import jxl.read.biff.BiffException;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.ApplicationObjectSupport;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;


@Controller
public class ImportMaterialDataController extends ApplicationObjectSupport {
    private transient final Log log = LogFactory.getLog(getClass());
    private static final String MATERIAL_IMPORT_KEY = "MaterialImportKey";
    private static final String MATERIAL_QUICK_IMPORT_KEY = "MaterialQuickImportKey";


    @Autowired
    private WarehouseService warehouseService;

    @Autowired
    private ImportmaterialService importmaterialService;

    @Autowired
    private MaterialService materialService;

    @Autowired
    private OriginService originService;

    @InitBinder
    public void initBinder(WebDataBinder binder) {
    }

    @RequestMapping(value={"/whm/material/import.html"})
    public ModelAndView importData(ImportMaterialDataBean bean, HttpServletRequest request)throws IOException, ServletException {
        ModelAndView mav = new ModelAndView("/whm/material/import");
        referenceData(mav,bean);
        if (RequestMethod.GET.toString().equals(request.getMethod())) {
            CacheUtil.getInstance().remove(request.getSession().getId() + MATERIAL_IMPORT_KEY);
//            if(!SecurityUtils.getPrincipal().getRole().equals(Constants.ADMIN_ROLE)){
//                mav = new ModelAndView("redirect:/whm/home.html");
//            }
        } else if (RequestMethod.POST.toString().equals(request.getMethod())) {
            Warehouse warehouse = new Warehouse();
            try{
                if(StringUtils.isNotBlank(bean.getCrudaction()) && bean.getCrudaction().equals(Constants.ACTION_IMPORT)) {
                    Warehouse dbWarehouse = warehouseService.findByIdNoCommit(bean.getWarehouse().getWarehouseID());
                    warehouse.setWarehouseID(dbWarehouse.getWarehouseID());
                    warehouse.setName(dbWarehouse.getName());
                }
            }catch (Exception ex){
                mav = new ModelAndView("/whm/material/import");
                referenceData(mav,bean);
                mav.addObject("errorMessage", "Please select warehouse");
            }

            try{
                if(StringUtils.isNotBlank(bean.getCrudaction()) && bean.getCrudaction().equals(Constants.ACTION_IMPORT)) {
                    String destFolder = CommonUtil.getBaseFolder() + CommonUtil.getTempFolderName();
                    MultipartHttpServletRequest mRequest = (MultipartHttpServletRequest) request;
                    Map<String, MultipartFile> map = mRequest.getFileMap();
                    MultipartFile csvfile = (MultipartFile) map.get("dataFile");
                    String fileName = FileUtils.upload(mRequest, destFolder, csvfile);
                    String destFileName = request.getSession().getServletContext().getRealPath(destFolder + "/" + fileName);
                    List<ImportMaterialDataDTO> importedDatas = new ArrayList<ImportMaterialDataDTO>();
                    extractExcelData(destFileName, importedDatas);
                    importedDatas.get(0).setWarehouse(warehouse);
                    log.debug("Remove temp file: " + destFileName);
                    try{
                        FileUtils.remove(destFileName);
                    }catch (Exception e) {
                        log.debug("Temporary File could not be deleted" + e.getMessage(), e);
                    }
                    String sessionId = request.getSession().getId();
                    CacheUtil.getInstance().putValue(sessionId + MATERIAL_IMPORT_KEY, importedDatas);
                }
                mav = new ModelAndView("redirect:/whm/material/importlist.html");
            }catch (Exception ex) {
                mav = new ModelAndView("/whm/material/import");
                referenceData(mav,bean);
                mav.addObject("errorMessage", ex.getMessage());
            }
        }
        return mav;
    }

    private void referenceData(ModelAndView mav,ImportMaterialDataBean bean ) {
        mav.addObject(Constants.FORM_MODEL_KEY, bean);
        mav.addObject("warehouses", warehouseService.findByStatus(Constants.TPK_USER_ACTIVE));
    }

    private void extractExcelData(String dbFileName, List<ImportMaterialDataDTO> importMaterialDataDTOs) throws BiffException, IOException {
        WorkbookSettings ws = new WorkbookSettings();
        FileInputStream fs = new FileInputStream(new File(dbFileName));
        Workbook workbook = Workbook.getWorkbook(fs, ws);
        Sheet s = workbook.getSheet(0);
        ExcelUtil.setEncoding4Workbook(ws);

        Cell rowData[] = null;
        int rowCount = s.getRows();
        boolean beginExtractData = false;
        for(int i = 0; i < rowCount;i++){
            rowData = s.getRow(i);
            if (rowData.length == 0) {
                continue;
            }
            // Identify row header
            if(rowData[0].getContents().equalsIgnoreCase("STT")){
                beginExtractData = true;
            }
            else if(beginExtractData){
                ImportMaterialDataDTO importMaterialDataDTO = new ImportMaterialDataDTO();
                int currentTotalCol = 1;
                importMaterialDataDTO.setCode(rowData[currentTotalCol++].getContents().trim());
                importMaterialDataDTO.setName(rowData[currentTotalCol++].getContents().trim());
                importMaterialDataDTO.setUnit(rowData[currentTotalCol++].getContents().trim());
                importMaterialDataDTO.setTotal(rowData[currentTotalCol++].getContents().trim());
                importMaterialDataDTO.setMoney(rowData[currentTotalCol++].getContents().trim());
                importMaterialDataDTO.setDate(rowData[currentTotalCol++].getContents().trim());
                importMaterialDataDTO.setExpiredDate(rowData[currentTotalCol++].getContents().trim());
                importMaterialDataDTO.setOrigin(rowData[currentTotalCol++].getContents().trim());
                importMaterialDataDTO.setMarket(rowData[currentTotalCol++].getContents().trim());
                if(importMaterialDataDTO.getName() == null || StringUtils.isBlank(importMaterialDataDTO.getName())
                || importMaterialDataDTO.getTotal() == null || StringUtils.isBlank(importMaterialDataDTO.getTotal())
                || importMaterialDataDTO.getUnit() == null || StringUtils.isBlank(importMaterialDataDTO.getUnit())){
                    importMaterialDataDTO.setValid(false);
                }
                importMaterialDataDTOs.add(importMaterialDataDTO);
            }
        }
    }


    @RequestMapping(value="/whm/material/importlist.html", method=RequestMethod.GET)
    public ModelAndView importDataList(HttpServletRequest request, ImportMaterialDataBean bean) throws Exception {
        String sessionId = request.getSession().getId();
        List<ImportMaterialDataDTO> importedDatas = (List<ImportMaterialDataDTO>) CacheUtil.getInstance().getValue(sessionId + MATERIAL_IMPORT_KEY);
        if (importedDatas == null || importedDatas.size() == 0) {
            return new ModelAndView("redirect:/whm/material/import.html");
        }
        ModelAndView mav = new ModelAndView("/whm/material/importlist");
        try{
            List<ImportMaterialDataDTO> displayDatas = importedDatas;
            RequestUtil.initSearchBean(request, bean);
            if (displayDatas.size() > 0) {
                Integer lastIndex = bean.getPage() * bean.getMaxPageItems();
                if (lastIndex > displayDatas.size()) {
                    lastIndex = displayDatas.size();
                }
                if (bean.getFirstItem() > displayDatas.size()) {
                    bean.setFirstItem(0);
                }
                bean.setListResult(displayDatas.subList(bean.getFirstItem(), lastIndex));
            }
            bean.setTotalItems(displayDatas.size());
        }catch (Exception ex) {
            logger.error(ex.getMessage());
        }
        mav.addObject(Constants.LIST_MODEL_KEY,bean);
        return mav;
    }

    @RequestMapping(value="/whm/material/importsave.html")
    public ModelAndView importDataSave(HttpServletRequest request, ImportMaterialDataBean bean) throws Exception {
        ModelAndView mav = new ModelAndView("/whm/material/importreport");
        String sessionId = request.getSession().getId();
        List<ImportMaterialDataDTO> importedDatas = (List<ImportMaterialDataDTO>) CacheUtil.getInstance().getValue(sessionId + MATERIAL_IMPORT_KEY);
        if (importedDatas != null && importedDatas.size()  > 0) {
            try{
               Object[] objs = this.importmaterialService.importMaterialData2DB(importedDatas,SecurityUtils.getLoginUserId());
                CacheUtil.getInstance().remove(sessionId + MATERIAL_IMPORT_KEY);
                mav.addObject("success", true);
                mav.addObject("successMessage", this.getMessageSourceAccessor().getMessage("database.add.successful"));
                mav.addObject("totalSuccess", objs[0]);
                mav.addObject("totalItems", importedDatas.size());
                if(StringUtils.isNotBlank(objs[1].toString())){
                    mav.addObject("failCode", objs[1].toString());
                }
            }catch (Exception e) {
                log.error(e);
                CacheUtil.getInstance().remove(sessionId + MATERIAL_IMPORT_KEY);
                mav.addObject("errorMessage", this.getMessageSourceAccessor().getMessage("general.exception.duplicate"));
            }
        }else{
            mav = new ModelAndView("redirect:/whm/material/import.html");
            referenceData(mav,bean);
            return mav;
        }
        referenceData(mav,bean);
        return mav;
    }



    @RequestMapping(value={"/whm/material/quickimport.html"})
    public ModelAndView importScoreCardMonth(ImportMaterialDataBean bean, HttpServletRequest request)throws IOException, ServletException {
        ModelAndView mav = new ModelAndView("/whm/material/quickimport");
        referenceDataQuickImport(mav, bean);
        if (RequestMethod.GET.toString().equals(request.getMethod())) {
//            Clear cache
            CacheUtil.getInstance().remove(request.getSession().getId() + MATERIAL_QUICK_IMPORT_KEY);
            if(SecurityUtils.getPrincipal().getWarehouseID() == null){
                mav = new ModelAndView("redirect:/whm/home.html");
            }
        } else if (RequestMethod.POST.toString().equals(request.getMethod())) {
            try{
                if(StringUtils.isNotBlank(bean.getCrudaction()) && bean.getCrudaction().equals(Constants.ACTION_IMPORT)) {
                    String destFolder = CommonUtil.getBaseFolder() + CommonUtil.getTempFolderName();
                    MultipartHttpServletRequest mRequest = (MultipartHttpServletRequest) request;
                    Map<String, MultipartFile> map = mRequest.getFileMap();
                    MultipartFile csvfile = (MultipartFile) map.get("dataFile");
                    String fileName = FileUtils.upload(mRequest, destFolder, csvfile);
                    String destFileName = request.getSession().getServletContext().getRealPath(destFolder + "/" + fileName);
                    List<ImportMaterialDataDTO> quickImportDatas = new ArrayList<ImportMaterialDataDTO>();
                    extractExcelData4QuickImport(destFileName, quickImportDatas);

                    quickImportDatas.get(0).setMaterialID(bean.getMaterialID());
                    quickImportDatas.get(0).setOriginID(bean.getOriginID());
                    log.debug("Remove temp file: " + destFileName);
                    try{
                        FileUtils.remove(destFileName);
                    }catch (Exception e) {
                        log.debug("Temporary File could not be deleted" + e.getMessage());
                    }

                    String sessionId = request.getSession().getId();
                    CacheUtil.getInstance().putValue(sessionId + MATERIAL_QUICK_IMPORT_KEY, quickImportDatas);
                }
                mav = new ModelAndView("redirect:/whm/importmaterialbill/edit.html");
            }catch (Exception ex) {
                mav = new ModelAndView("/whm/material/quickimport");
                referenceDataQuickImport(mav, bean);
                mav.addObject("errorMessage", "Có lỗi trong quá trình đọc dữ liệu từ file excel.");
            }
        }
        return mav;
    }

    private void referenceDataQuickImport(ModelAndView mav,ImportMaterialDataBean bean ) {
        mav.addObject(Constants.FORM_MODEL_KEY, bean);
        mav.addObject("materials", materialService.findAssigned(SecurityUtils.getLoginUserId()));
        mav.addObject("origins", originService.findAll());
    }

    private void extractExcelData4QuickImport(String dbFileName, List<ImportMaterialDataDTO> importMaterialDataDTOs) throws BiffException, IOException {
        WorkbookSettings ws = new WorkbookSettings();
        FileInputStream fs = new FileInputStream(new File(dbFileName));
        Workbook workbook = Workbook.getWorkbook(fs, ws);
        Sheet s = workbook.getSheet(0);
        ExcelUtil.setEncoding4Workbook(ws);

        Cell rowData[] = null;
        int rowCount = s.getRows();
        boolean beginExtractData = false;
        for(int i = 0; i < rowCount;i++){
            rowData = s.getRow(i);
            if (rowData.length == 0) {
                continue;
            }
            // Identify row header
            if(rowData[0].getContents().equalsIgnoreCase("STT")){
                beginExtractData = true;
            }
            else if(beginExtractData){
                ImportMaterialDataDTO importMaterialDataDTO = new ImportMaterialDataDTO();
                int currentTotalCol = 1;
                importMaterialDataDTO.setCode(rowData[currentTotalCol++].getContents());
                importMaterialDataDTO.setTotal(rowData[currentTotalCol++].getContents());
                importMaterialDataDTO.setExpiredDate(rowData[currentTotalCol++].getContents());
                if(StringUtils.isBlank(importMaterialDataDTO.getTotal())){
                    importMaterialDataDTO.setValid(false);
                }
                importMaterialDataDTOs.add(importMaterialDataDTO);
            }
        }
    }

    @RequestMapping(value="/whm/material/quickImportList.html", method=RequestMethod.GET)
    public ModelAndView importScoreCardMonthList(HttpServletRequest request, ImportMaterialDataBean bean) throws Exception {
        String sessionId = request.getSession().getId();
        List<ImportMaterialDataDTO> importMaterialDataDTOs = (List<ImportMaterialDataDTO>) CacheUtil.getInstance().getValue(sessionId + MATERIAL_QUICK_IMPORT_KEY);
        if (importMaterialDataDTOs == null || importMaterialDataDTOs.size() == 0) {
            return new ModelAndView("redirect:/whm/material/quickimport.html");
        }
        ModelAndView mav = new ModelAndView("redirect:/whm/importmaterialbill/edit.html");
        ImportmaterialbillBean importmaterialbillBean = new ImportmaterialbillBean();
        try{
            importmaterialbillBean.setImportMaterialDataDTOs(importMaterialDataDTOs);
            importmaterialbillBean.setCrudaction("quickImport");
            CacheUtil.getInstance().remove(sessionId + MATERIAL_QUICK_IMPORT_KEY);
            CacheUtil.getInstance().putValue(sessionId + MATERIAL_QUICK_IMPORT_KEY, importmaterialbillBean);
        }catch (Exception ex) {
            logger.error(ex.getMessage());
        }
        mav.addObject(Constants.FORM_MODEL_KEY,importmaterialbillBean);
        return mav;
    }
}
