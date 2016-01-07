package com.banvien.tpk.webapp.controller.whm;

import com.banvien.tpk.core.Constants;
import com.banvien.tpk.core.domain.Warehouse;
import com.banvien.tpk.core.dto.ImportProductDataBean;
import com.banvien.tpk.core.dto.ImportProductDataDTO;
import com.banvien.tpk.core.service.ImportproductService;
import com.banvien.tpk.core.service.InitProductService;
import com.banvien.tpk.core.service.WarehouseService;
import com.banvien.tpk.core.util.CacheUtil;
import com.banvien.tpk.security.SecurityUtils;
import com.banvien.tpk.webapp.editor.CustomDateEditor;
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
import java.util.Date;
import java.util.List;
import java.util.Map;


@Controller
public class ImportProductDataController extends ApplicationObjectSupport {
    private transient final Log log = LogFactory.getLog(getClass());
    private static final String PRODUCT_IMPORT_KEY = "ProductImportKey";
    private static final String PRODUCT_IMPORT_INIT_KEY = "ProductImportInitKey";

    @Autowired
    private WarehouseService warehouseService;

    @Autowired
    private ImportproductService importproductService;

    @Autowired
    private InitProductService initProductService;

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        binder.registerCustomEditor(Date.class, new CustomDateEditor("dd/MM/yyyy"));
    }

    @RequestMapping(value={"/whm/product/import.html"})
    public ModelAndView importData(ImportProductDataBean bean, HttpServletRequest request)throws IOException, ServletException {
        ModelAndView mav = new ModelAndView("/whm/product/import");
        referenceData(mav,bean);
        if (RequestMethod.GET.toString().equals(request.getMethod())) {
            CacheUtil.getInstance().remove(request.getSession().getId() + PRODUCT_IMPORT_KEY);
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
                mav = new ModelAndView("/whm/product/import");
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
                    List<ImportProductDataDTO> importedDatas = new ArrayList<ImportProductDataDTO>();
                    extractExcelData(destFileName, importedDatas);
                    importedDatas.get(0).setWarehouse(warehouse);
                    importedDatas.get(0).setInitDate(bean.getInitDate());

                    log.debug("Remove temp file: " + destFileName);
                    try{
                        FileUtils.remove(destFileName);
                    }catch (Exception e) {
                        log.debug("Temporary File could not be deleted" + e.getMessage(), e);
                    }
                    String sessionId = request.getSession().getId();
                    CacheUtil.getInstance().putValue(sessionId + PRODUCT_IMPORT_KEY, importedDatas);
                }
                mav = new ModelAndView("redirect:/whm/product/importlist.html");
            }catch (Exception ex) {
                mav = new ModelAndView("/whm/product/import");
                referenceData(mav,bean);
                mav.addObject("errorMessage", ex.getMessage());
            }
        }
        return mav;
    }

    private void referenceData(ModelAndView mav,ImportProductDataBean bean ) {
        mav.addObject(Constants.FORM_MODEL_KEY, bean);
        mav.addObject("warehouses", warehouseService.findByStatus(Constants.TPK_USER_ACTIVE));
    }

    private void extractExcelData(String dbFileName, List<ImportProductDataDTO> importProductDataDTOs) throws BiffException, IOException {
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
                ImportProductDataDTO importProductDataDTO = new ImportProductDataDTO();
                int currentTotalCol = 1;
                importProductDataDTO.setName(rowData[currentTotalCol++].getContents().trim());
                importProductDataDTO.setCode(rowData[currentTotalCol++].getContents().trim());
                importProductDataDTO.setSize(rowData[currentTotalCol++].getContents().trim());
                importProductDataDTO.setThickness(rowData[currentTotalCol++].getContents().trim());
                importProductDataDTO.setStiffness(rowData[currentTotalCol++].getContents().trim());
                importProductDataDTO.setColour(rowData[currentTotalCol++].getContents().trim());
                importProductDataDTO.setOverlay(rowData[currentTotalCol++].getContents().trim());
                importProductDataDTO.setOrigin(rowData[currentTotalCol++].getContents().trim());
                importProductDataDTO.setMarket(rowData[currentTotalCol++].getContents().trim());
                importProductDataDTO.setLoi(!rowData[currentTotalCol++].getContents().equals("0") ? rowData[currentTotalCol - 1].getContents().trim() : "");
                importProductDataDTO.setA(!rowData[currentTotalCol++].getContents().equals("0") ? rowData[currentTotalCol - 1].getContents().trim() : "");
                importProductDataDTO.setB(!rowData[currentTotalCol++].getContents().equals("0") ? rowData[currentTotalCol - 1].getContents().trim() : "");
                importProductDataDTO.setC(!rowData[currentTotalCol++].getContents().equals("0") ? rowData[currentTotalCol - 1].getContents().trim() : "");
                importProductDataDTO.setPp(!rowData[currentTotalCol++].getContents().equals("0") ? rowData[currentTotalCol - 1].getContents().trim() : "");
                importProductDataDTO.setTotalM(!rowData[currentTotalCol++].getContents().equals("0") ? rowData[currentTotalCol - 1].getContents().trim() : "");
                importProductDataDTO.setTotalKg(!rowData[currentTotalCol++].getContents().equals("0") ? rowData[currentTotalCol - 1].getContents().trim() : "");
                importProductDataDTO.setDate(rowData[currentTotalCol++].getContents().trim());
                importProductDataDTO.setNote(!rowData[currentTotalCol++].getContents().equals("0") ? rowData[currentTotalCol - 1].getContents().trim() : "");
                importProductDataDTO.setMoney(rowData[currentTotalCol++].getContents().trim());
                if(importProductDataDTO.getName() == null || StringUtils.isBlank(importProductDataDTO.getName())
                || importProductDataDTO.getTotalKg() == null || StringUtils.isBlank(importProductDataDTO.getTotalKg())){
                    importProductDataDTO.setValid(false);
                }
                importProductDataDTOs.add(importProductDataDTO);
            }
        }
    }


    @RequestMapping(value="/whm/product/importlist.html", method=RequestMethod.GET)
    public ModelAndView importDataList(HttpServletRequest request, ImportProductDataBean bean) throws Exception {
        String sessionId = request.getSession().getId();
        List<ImportProductDataDTO> importedDatas = (List<ImportProductDataDTO>) CacheUtil.getInstance().getValue(sessionId + PRODUCT_IMPORT_KEY);
        if (importedDatas == null || importedDatas.size() == 0) {
            return new ModelAndView("redirect:/whm/product/import.html");
        }
        ModelAndView mav = new ModelAndView("/whm/product/importlist");
        try{
            List<ImportProductDataDTO> displayDatas = importedDatas;
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

    @RequestMapping(value="/whm/product/importsave.html")
    public ModelAndView importDataSave(HttpServletRequest request, ImportProductDataBean bean) throws Exception {
        ModelAndView mav = new ModelAndView("/whm/product/importreport");
        String sessionId = request.getSession().getId();
        List<ImportProductDataDTO> importedDatas = (List<ImportProductDataDTO>) CacheUtil.getInstance().getValue(sessionId + PRODUCT_IMPORT_KEY);
        if (importedDatas != null && importedDatas.size()  > 0) {
            try{
               Object[] objs = this.importproductService.importProductData2DB(importedDatas,SecurityUtils.getLoginUserId());
                CacheUtil.getInstance().remove(sessionId + PRODUCT_IMPORT_KEY);
                mav.addObject("success", true);
                mav.addObject("successMessage", this.getMessageSourceAccessor().getMessage("database.add.successful"));
                mav.addObject("totalSuccess", objs[0]);
                mav.addObject("totalItems", importedDatas.size());
                if(StringUtils.isNotBlank(objs[1].toString())){
                    mav.addObject("failCode", objs[1].toString());
                }
            }catch (Exception e) {
                log.error(e.getMessage(),e);
                CacheUtil.getInstance().remove(sessionId + PRODUCT_IMPORT_KEY);
                mav.addObject("errorMessage", e.getMessage());
            }
        }else{
            mav = new ModelAndView("redirect:/whm/product/import.html");
            referenceData(mav,bean);
            return mav;
        }
        referenceData(mav,bean);
        return mav;
    }


    @RequestMapping(value={"/whm/product/importinit.html"})
    public ModelAndView importInitData(ImportProductDataBean bean, HttpServletRequest request)throws IOException, ServletException {
        ModelAndView mav = new ModelAndView("/whm/product/importinit");
        referenceData(mav,bean);
        if (RequestMethod.GET.toString().equals(request.getMethod())) {
            CacheUtil.getInstance().remove(request.getSession().getId() + PRODUCT_IMPORT_INIT_KEY);
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
                mav = new ModelAndView("/whm/product/importinit");
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
                    List<ImportProductDataDTO> importedDatas = new ArrayList<ImportProductDataDTO>();
                    extractExcelData4Init(destFileName, importedDatas);
                    importedDatas.get(0).setWarehouse(warehouse);
                    importedDatas.get(0).setInitDate(bean.getInitDate());
                    log.debug("Remove temp file: " + destFileName);
                    try{
                        FileUtils.remove(destFileName);
                    }catch (Exception e) {
                        log.debug("Temporary File could not be deleted" + e.getMessage(), e);
                    }
                    String sessionId = request.getSession().getId();
                    CacheUtil.getInstance().putValue(sessionId + PRODUCT_IMPORT_INIT_KEY, importedDatas);
                }
                mav = new ModelAndView("redirect:/whm/product/importinitlist.html");
            }catch (Exception ex) {
                mav = new ModelAndView("/whm/product/importinit");
                referenceData(mav,bean);
                mav.addObject("errorMessage", ex.getMessage());
            }
        }
        return mav;
    }

    @RequestMapping(value="/whm/product/importinitlist.html", method=RequestMethod.GET)
    public ModelAndView importInitDataList(HttpServletRequest request, ImportProductDataBean bean) throws Exception {
        String sessionId = request.getSession().getId();
        List<ImportProductDataDTO> importedDatas = (List<ImportProductDataDTO>) CacheUtil.getInstance().getValue(sessionId + PRODUCT_IMPORT_INIT_KEY);
        if (importedDatas == null || importedDatas.size() == 0) {
            return new ModelAndView("redirect:/whm/product/importinit.html");
        }
        ModelAndView mav = new ModelAndView("/whm/product/importinitlist");
        try{
            List<ImportProductDataDTO> displayDatas = importedDatas;
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

    @RequestMapping(value="/whm/product/importinitsave.html")
    public ModelAndView importInitDataSave(HttpServletRequest request, ImportProductDataBean bean) throws Exception {
        ModelAndView mav = new ModelAndView("/whm/product/importinitreport");
        String sessionId = request.getSession().getId();
        List<ImportProductDataDTO> importedDatas = (List<ImportProductDataDTO>) CacheUtil.getInstance().getValue(sessionId + PRODUCT_IMPORT_INIT_KEY);
        if (importedDatas != null && importedDatas.size()  > 0) {
            try{
                Object[] objs = this.initProductService.importInitProductData2DB(importedDatas,SecurityUtils.getLoginUserId());
                CacheUtil.getInstance().remove(sessionId + PRODUCT_IMPORT_INIT_KEY);
                mav.addObject("success", true);
                mav.addObject("successMessage", this.getMessageSourceAccessor().getMessage("database.add.successful"));
                mav.addObject("totalSuccess", objs[0]);
                mav.addObject("totalItems", importedDatas.size());
                if(StringUtils.isNotBlank(objs[1].toString())){
                    mav.addObject("failCode", objs[1].toString());
                }
            }catch (Exception e) {
                log.error(e.getMessage(),e);
                CacheUtil.getInstance().remove(sessionId + PRODUCT_IMPORT_INIT_KEY);
                mav.addObject("errorMessage", e.getMessage());
            }
        }else{
            mav = new ModelAndView("redirect:/whm/product/importinit.html");
            referenceData(mav,bean);
            return mav;
        }
        referenceData(mav,bean);
        return mav;
    }

    private void extractExcelData4Init(String dbFileName, List<ImportProductDataDTO> importProductDataDTOs) throws BiffException, IOException {
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
                ImportProductDataDTO importProductDataDTO = new ImportProductDataDTO();
                int currentTotalCol = 1;
                importProductDataDTO.setCode(rowData[currentTotalCol++].getContents().trim());
                importProductDataDTOs.add(importProductDataDTO);
            }
        }
    }
}
