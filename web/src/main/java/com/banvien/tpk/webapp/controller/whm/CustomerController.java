package com.banvien.tpk.webapp.controller.whm;

import com.banvien.tpk.core.Constants;
import com.banvien.tpk.core.domain.*;
import com.banvien.tpk.core.dto.*;
import com.banvien.tpk.core.exception.DuplicateException;
import com.banvien.tpk.core.exception.ObjectNotFoundException;
import com.banvien.tpk.core.service.*;
import com.banvien.tpk.core.util.CacheUtil;
import com.banvien.tpk.security.SecurityUtils;
import com.banvien.tpk.webapp.editor.CustomDateEditor;
import com.banvien.tpk.webapp.util.*;
import jxl.Cell;
import jxl.Sheet;
import jxl.Workbook;
import jxl.WorkbookSettings;
import jxl.read.biff.BiffException;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.json.JSONArray;
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

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.util.*;

@Controller
public class CustomerController extends ApplicationObjectSupport {
    private transient final Log log = LogFactory.getLog(getClass());
    private static final String CUSTOMER_IMPORT_KEY = "CustomerImportKey";


    @Autowired
    private CustomerService customerService;

    @Autowired
    private RegionService regionService;

    @Autowired
    private ProvinceService provinceService;

    @Autowired
    private UserCustomerService userCustomerService;

    @Autowired
    private OweLogService oweLogService;

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        binder.registerCustomEditor(Timestamp.class, new CustomDateEditor("dd/MM/yyyy"));
        binder.registerCustomEditor(Date.class, new CustomDateEditor("dd/MM/yyyy"));
    }
    
    @RequestMapping("/whm/customer/edit.html")
	public ModelAndView edit(@ModelAttribute(Constants.FORM_MODEL_KEY) CustomerBean customerBean, BindingResult bindingResult) {
		ModelAndView mav = new ModelAndView("/whm/customer/edit");
        User user = new User();
        user.setUserID(SecurityUtils.getLoginUserId());
		String crudaction = customerBean.getCrudaction();
		Customer pojo = customerBean.getPojo();
		if(StringUtils.isNotBlank(crudaction) && crudaction.equals("insert-update")) {
			try {
				if(!bindingResult.hasErrors()) {
					if(pojo.getCustomerID() != null && pojo.getCustomerID() > 0) {
						this.customerService.updateItem(customerBean);
                        mav = new ModelAndView("redirect:/whm/customer/list.html?isUpdate=true");
					} else {
                        pojo.setCreatedBy(user);
                        pojo = this.customerService.addNew(customerBean);
                        if(SecurityUtils.userHasAuthority(Constants.NVKD_ROLE)){
                            UserCustomer userCustomer = new UserCustomer();
                            userCustomer.setUser(user);
                            userCustomer.setCustomer(pojo);
                            userCustomerService.save(userCustomer);
                        }
                        mav = new ModelAndView("redirect:/whm/customer/list.html?isAdd=true");
					}
                    return mav;
				}
			}catch (ObjectNotFoundException oe) {
				logger.error(oe.getMessage());
				mav.addObject("errorMessage", this.getMessageSourceAccessor().getMessage("database.exception.keynotfound"));
			}catch (DuplicateException de) {
				logger.error(de.getMessage());
				mav.addObject("errorMessage", this.getMessageSourceAccessor().getMessage("database.exception.duplicate"));
			}catch(Exception e) {
				logger.error(e.getMessage(), e);
				mav.addObject("errorMessage", this.getMessageSourceAccessor().getMessage("general.exception.msg"));
			}
		}
		if(!bindingResult.hasErrors()&& customerBean.getPojo().getCustomerID() != null && customerBean.getPojo().getCustomerID() > 0) {
			try {
                Customer itemObj = this.customerService.findById(pojo.getCustomerID());
				customerBean.setPojo(itemObj);
			}
			catch (Exception e) {
				logger.error("Could not found item " + customerBean.getPojo().getCustomerID(), e);
			}
		}
        if(customerBean.getPojo().getStatus() == null){
            customerBean.getPojo().setStatus(Constants.CUSTOMER_NORMAL);
        }
        referenceData(mav);
		mav.addObject(Constants.FORM_MODEL_KEY, customerBean);
		return mav;
	}

    private void referenceData(ModelAndView mav) {
        mav.addObject("regions", regionService.findAllSortAsc());
        mav.addObject("provinces", provinceService.findAll());
        List<Customer> customers;
        if(SecurityUtils.userHasAuthority(Constants.NVKD_ROLE)){
            customers = this.customerService.findByUser(SecurityUtils.getLoginUserId());
        }else {
            customers = this.customerService.findAll();
        }
        mav.addObject("customers",customers);
    }


    @RequestMapping(value={"/whm/customer/list.html"})
    public ModelAndView list(CustomerBean bean, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("/whm/customer/list");
		if(StringUtils.isNotBlank(bean.getCrudaction()) && bean.getCrudaction().equals(Constants.ACTION_DELETE)) {
			Integer totalDeleted = 0;
			try {
				totalDeleted = customerService.deleteItems(bean.getCheckList());
				mav.addObject("totalDeleted", totalDeleted);
			}catch (Exception e) {
				log.error(e.getMessage(), e);
				mav.addObject(Constants.MESSAGE_RESPONSE_MODEL_KEY, this.getMessageSourceAccessor().getMessage("database.multipledelete.exception"));
			}
		}
        executeSearch(bean, request);
        referenceData(mav);
        mav.addObject(Constants.LIST_MODEL_KEY, bean);
        showAlert(mav,bean.getIsAdd(),bean.getIsUpdate(),bean.getIsError());
        return mav;
    }

    private void executeSearch(CustomerBean bean, HttpServletRequest request) {
        RequestUtil.initSearchBean(request, bean);

        Object[] results = this.customerService.search(bean);
        bean.setListResult((List<Customer>)results[1]);
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

    @RequestMapping(value="/ajax/getProvinceByRegion.html")
    public void getProvinceByRegion(@RequestParam(value = "regionID", required = true) Long regionID, HttpServletResponse response)  {
        try{
            response.setContentType("text/json; charset=UTF-8");
            PrintWriter out = response.getWriter();
            JSONObject obj = new JSONObject();
            obj.put("success", true);
            JSONArray array = new JSONArray();
            List<Province> provinces = null;
            if(regionID == null){
                provinces = provinceService.findAll();
            }
            else{
                provinces = provinceService.findByRegionID(regionID);
            }
            if (provinces != null && provinces.size() > 0) {
                for (Province province : provinces) {
                    JSONObject jsonO = new JSONObject();
                    jsonO.put("provinceID", province.getProvinceID());
                    jsonO.put("name", province.getName());
                    array.put(jsonO);
                }
            }
            obj.put("array", array);
            out.print(obj);
            out.flush();
            out.close();
        }catch (Exception e) {
            log.error(e.getMessage(), e);
        }
    }


    @RequestMapping(value={"/whm/customer/updateLiability.html"})
    public ModelAndView updateLiability(CustomerBean bean, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("/whm/customer/updateLiability");
        if(StringUtils.isNotBlank(bean.getCrudaction()) && bean.getCrudaction().equals(Constants.ACTION_INSERT_UPDATE)) {
            try {
                customerService.updateLiability(SecurityUtils.getLoginUserId(),bean.getUpdateLiabilities());
                mav = new ModelAndView("redirect:/whm/customer/owelog.html?isUpdate=true");
                return mav;
            }catch (Exception e) {
                log.error(e.getMessage(), e);
                mav.addObject("alertType","error");
                mav.addObject(Constants.MESSAGE_RESPONSE_MODEL_KEY, this.getMessageSourceAccessor().getMessage("error.occur"));
            }
        }
        executeSearch(bean, request);
        Map<Long,Double> mapCustomerOwe = mappingOwe(bean.getListResult());
        mav.addObject("mapCustomerOwe", mapCustomerOwe);
        referenceData(mav);
        mav.addObject(Constants.LIST_MODEL_KEY, bean);
        return mav;
    }

    @RequestMapping(value={"/whm/customer/receiveOwe.html"})
    public ModelAndView receiveOwe(CustomerBean bean, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("/whm/customer/receiveOwe");
        if(StringUtils.isNotBlank(bean.getCrudaction()) && bean.getCrudaction().equals(Constants.ACTION_INSERT_UPDATE)) {
            try {
                customerService.updateReceiveOwe(SecurityUtils.getLoginUserId(), bean.getUpdateLiabilities());
                mav = new ModelAndView("redirect:/whm/customer/owelog.html?isUpdate=true");
                return mav;
            }catch (Exception e) {
                log.error(e.getMessage(), e);
                mav.addObject("alertType","error");
                mav.addObject(Constants.MESSAGE_RESPONSE_MODEL_KEY, this.getMessageSourceAccessor().getMessage("error.occur"));
            }
        }
        executeSearch(bean, request);
        Map<Long,Double> mapCustomerOwe = mappingOwe(bean.getListResult());
        mav.addObject("mapCustomerOwe", mapCustomerOwe);
        referenceData(mav);
        mav.addObject(Constants.LIST_MODEL_KEY, bean);
        return mav;
    }

    private Map<Long, Double> mappingOwe(List<Customer> customers) {
        List<Long> customerIDs = new ArrayList<Long>();
        if(customers != null){
            for(Customer customer : customers){
                customerIDs.add(customer.getCustomerID());
            }
        }
        Map<Long,Double> mapCustomersOwe = this.oweLogService.findCustomersOweUtilDate(customerIDs,new Timestamp(System.currentTimeMillis()));
        return mapCustomersOwe;
    }

    @RequestMapping(value={"/whm/customer/owelog.html"})
    public ModelAndView oweLog(OweLogBean bean, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("/whm/customer/owelog");
        if(StringUtils.isNotBlank(bean.getCrudaction()) && bean.getCrudaction().equals(Constants.ACTION_DELETE)) {
            Integer totalDeleted = 0;
            try {
                totalDeleted = oweLogService.deleteItems(bean.getCheckList());
                mav.addObject("totalDeleted", totalDeleted);
            }catch (Exception e) {
                log.error(e.getMessage(), e);
                mav.addObject(Constants.MESSAGE_RESPONSE_MODEL_KEY, this.getMessageSourceAccessor().getMessage("database.multipledelete.exception"));
            }
        }
        if(bean.getToDate() != null){
            bean.setToDate(DateUtils.move2TheEndOfDay((Timestamp) bean.getToDate()));
        }
        executeSearchLog(bean, request);
        List<Customer> customers;
        if(SecurityUtils.userHasAuthority(Constants.NVKD_ROLE)){
            customers = this.customerService.findByUser(SecurityUtils.getLoginUserId());
        }else {
            customers = this.customerService.findByUser(null);
        }
        mav.addObject("customers", customers);
        mav.addObject(Constants.LIST_MODEL_KEY, bean);
        showAlert(mav,bean.getIsAdd(),bean.getIsUpdate(),bean.getIsError());
        return mav;
    }

    private void executeSearchLog(OweLogBean bean, HttpServletRequest request) {
        RequestUtil.initSearchBean(request, bean);
        Object[] results = this.oweLogService.search(bean);
        bean.setListResult((List<OweLog>)results[1]);
        bean.setTotalItems(Integer.valueOf(results[0].toString()));
    }

    @RequestMapping("/whm/customer/editlog.html")
    public ModelAndView editLog(@ModelAttribute(Constants.FORM_MODEL_KEY) OweLogBean bean, BindingResult bindingResult) {
        ModelAndView mav = new ModelAndView("/whm/customer/editlog");
        User user = new User();
        user.setUserID(SecurityUtils.getLoginUserId());
        String crudaction = bean.getCrudaction();
        OweLog pojo = bean.getPojo();
        if(StringUtils.isNotBlank(crudaction) && crudaction.equals("insert-update")) {
            try {
                if(!bindingResult.hasErrors()) {
                    if(pojo.getOweLogID() != null && pojo.getOweLogID() > 0) {
                        this.oweLogService.updateItem(bean);
                        mav = new ModelAndView("redirect:/whm/customer/owelog.html?isUpdate=true");
                    }
                    return mav;
                }
            }catch (ObjectNotFoundException oe) {
                logger.error(oe.getMessage());
                mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("database.exception.keynotfound"));
                mav = new ModelAndView("redirect:/whm/customer/owelog.html?isError=true");
            }catch (DuplicateException de) {
                logger.error(de.getMessage());
                mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("database.exception.duplicate"));
                mav = new ModelAndView("redirect:/whm/customer/owelog.html?isError=true");
            }catch(Exception e) {
                logger.error(e.getMessage(), e);
                mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("general.exception.msg"));
                mav = new ModelAndView("redirect:/whm/customer/owelog.html?isError=true");
            }
        }
        if(!bindingResult.hasErrors()&& bean.getPojo().getOweLogID() != null && bean.getPojo().getOweLogID() > 0) {
            try {
                OweLog itemObj = this.oweLogService.findById(pojo.getOweLogID());
                bean.setPojo(itemObj);
            }
            catch (Exception e) {
                logger.error("Could not found item " + bean.getPojo().getOweLogID(), e);
            }
        }
        mav.addObject(Constants.FORM_MODEL_KEY, bean);
        return mav;
    }

    @RequestMapping(value = "/ajax/printPayment.html", method = RequestMethod.GET)
    public ModelAndView printPayment(@RequestParam(value="oweLogID") Long oweLogID) {
        ModelAndView mav = new ModelAndView("/whm/customer/printpaylog");
        Map model = mav.getModel();
        try {
            OweLog oweLog = oweLogService.findByIdNoCommit(oweLogID);
            Customer customer = oweLog.getCustomer();
            model.put("customer", customer.getName());
            model.put("company", customer.getCompany() != null ? customer.getCompany() : "");
            model.put("customerAddress", customer.getAddress() != null ? customer.getAddress() : "");
            StringBuffer telFax = new StringBuffer();
            telFax.append(customer.getPhone() != null ? customer.getPhone() : "" );
            if(StringUtils.isNotBlank(customer.getFax())){
                telFax.append("*** Fax: ").append(customer.getFax());
            }
            model.put("customerTelFax", telFax.toString());
            model.put("payDate", DateUtils.date2String(oweLog.getPayDate(), "dd/MM/yyyy"));
            model.put("owe", this.oweLogService.findCustomerOweUtilDate(customer.getCustomerID(), oweLog.getPayDate()));
            model.put("pay", oweLog.getPay());
            model.put("note", oweLog.getNote());
        } catch (Exception e) {
            log.error(e.getMessage(),e);
        }
        return mav;
    }


    @RequestMapping(value={"/whm/customer/import.html"})
    public ModelAndView importData(ImportCustomerDataBean bean, HttpServletRequest request)throws IOException, ServletException {
        ModelAndView mav = new ModelAndView("/whm/customer/import");
        if (RequestMethod.GET.toString().equals(request.getMethod())) {
            CacheUtil.getInstance().remove(request.getSession().getId() + CUSTOMER_IMPORT_KEY);
            if(!SecurityUtils.getPrincipal().getRole().equals(Constants.ADMIN_ROLE)){
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
                    List<ImportCustomerDataDTO> importedDatas = new ArrayList<ImportCustomerDataDTO>();
                    extractExcelData(destFileName, importedDatas);
                    log.debug("Remove temp file: " + destFileName);
                    try{
                        FileUtils.remove(destFileName);
                    }catch (Exception e) {
                        log.debug("Temporary File could not be deleted" + e.getMessage(), e);
                    }
                    String sessionId = request.getSession().getId();
                    CacheUtil.getInstance().putValue(sessionId + CUSTOMER_IMPORT_KEY, importedDatas);
                }
                mav = new ModelAndView("redirect:/whm/customer/importlist.html");
            }catch (Exception ex) {
                mav = new ModelAndView("/whm/customer/import");
                mav.addObject("errorMessage", ex.getMessage());
                log.error(ex.getMessage(),ex);
            }
        }
        mav.addObject(Constants.FORM_MODEL_KEY, bean);
        return mav;
    }

    private void extractExcelData(String dbFileName, List<ImportCustomerDataDTO> importProductDataDTOs) throws BiffException, IOException {
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
                ImportCustomerDataDTO ImportCustomerDataDTO = new ImportCustomerDataDTO();
                int currentTotalCol = 1;
                ImportCustomerDataDTO.setUserName(rowData[currentTotalCol++].getContents());
                ImportCustomerDataDTO.setCustomerName(rowData[currentTotalCol++].getContents());
                ImportCustomerDataDTO.setCompanyName(rowData[currentTotalCol++].getContents());
                ImportCustomerDataDTO.setCompanyTel(rowData[currentTotalCol++].getContents());
                ImportCustomerDataDTO.setFax(rowData[currentTotalCol++].getContents());
                ImportCustomerDataDTO.setAddress(rowData[currentTotalCol++].getContents());
                ImportCustomerDataDTO.setProvince(rowData[currentTotalCol++].getContents());
                ImportCustomerDataDTO.setContact(rowData[currentTotalCol++].getContents());
                ImportCustomerDataDTO.setContactPhone(rowData[currentTotalCol++].getContents());
                ImportCustomerDataDTO.setBirthday(rowData[currentTotalCol++].getContents());
                ImportCustomerDataDTO.setOweLimit(rowData[currentTotalCol++].getContents());
                ImportCustomerDataDTO.setOwePast(rowData[currentTotalCol++].getContents());
                ImportCustomerDataDTO.setOweCurrent(rowData[currentTotalCol++].getContents());
                ImportCustomerDataDTO.setPayCurrent(rowData[currentTotalCol++].getContents());
                ImportCustomerDataDTO.setOweDate(rowData[currentTotalCol++].getContents());
                if(StringUtils.isBlank(ImportCustomerDataDTO.getCustomerName()) || StringUtils.isBlank(ImportCustomerDataDTO.getUserName())){
                    ImportCustomerDataDTO.setValid(false);
                }
                importProductDataDTOs.add(ImportCustomerDataDTO);
            }
        }
    }

    @RequestMapping(value="/whm/customer/importlist.html", method=RequestMethod.GET)
    public ModelAndView importDataList(HttpServletRequest request, ImportCustomerDataBean bean) throws Exception {
        String sessionId = request.getSession().getId();
        List<ImportCustomerDataDTO> importedDatas = (List<ImportCustomerDataDTO>) CacheUtil.getInstance().getValue(sessionId + CUSTOMER_IMPORT_KEY);
        if (importedDatas == null || importedDatas.size() == 0) {
            return new ModelAndView("redirect:/whm/customer/import.html");
        }
        ModelAndView mav = new ModelAndView("/whm/customer/importlist");
        try{
            List<ImportCustomerDataDTO> displayDatas = importedDatas;
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

    @RequestMapping(value="/whm/customer/importsave.html")
    public ModelAndView importDataSave(HttpServletRequest request, ImportCustomerDataBean bean) throws Exception {
        ModelAndView mav = new ModelAndView("/whm/customer/importreport");
        String sessionId = request.getSession().getId();
        List<ImportCustomerDataDTO> importedDatas = (List<ImportCustomerDataDTO>) CacheUtil.getInstance().getValue(sessionId + CUSTOMER_IMPORT_KEY);
        if (importedDatas != null && importedDatas.size()  > 0) {
            try{
                Object[] objs = this.customerService.importCustomerData2DB(importedDatas);
                CacheUtil.getInstance().remove(sessionId + CUSTOMER_IMPORT_KEY);
                mav.addObject("success", true);
                mav.addObject("successMessage", this.getMessageSourceAccessor().getMessage("database.add.successful"));
                mav.addObject("totalSuccess", objs[0]);
                mav.addObject("totalItems", importedDatas.size());
                if(StringUtils.isNotBlank(objs[1].toString())){
                    mav.addObject("failCode", objs[1].toString());
                }
            }catch (Exception e) {
                log.error(e.getMessage(),e);
                CacheUtil.getInstance().remove(sessionId + CUSTOMER_IMPORT_KEY);
                mav.addObject("errorMessage", e.getMessage());
            }
        }else{
            mav = new ModelAndView("redirect:/whm/customer/import.html");
            return mav;
        }
        return mav;
    }

    @RequestMapping(value={"/whm/customer/importOwe.html"})
    public ModelAndView importOweData(ImportCustomerOweBean bean, HttpServletRequest request)throws IOException, ServletException {
        ModelAndView mav = new ModelAndView("/whm/customer/importOwe");
        if (RequestMethod.GET.toString().equals(request.getMethod())) {
            CacheUtil.getInstance().remove(request.getSession().getId() + CUSTOMER_IMPORT_KEY);
            if(!SecurityUtils.getPrincipal().getRole().equals(Constants.ADMIN_ROLE)){
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
                    List<ImportCustomerOweDTO> importedDatas = new ArrayList<ImportCustomerOweDTO>();
                    extractExcelOwe(destFileName, importedDatas);
                    log.debug("Remove temp file: " + destFileName);
                    try{
                        FileUtils.remove(destFileName);
                    }catch (Exception e) {
                        log.debug("Temporary File could not be deleted" + e.getMessage(), e);
                    }
                    String sessionId = request.getSession().getId();
                    CacheUtil.getInstance().putValue(sessionId + CUSTOMER_IMPORT_KEY, importedDatas);
                }
                mav = new ModelAndView("redirect:/whm/customer/importowelist.html");
            }catch (Exception ex) {
                mav = new ModelAndView("/whm/customer/importOwe");
                mav.addObject("errorMessage", ex.getMessage());
                log.error(ex.getMessage(),ex);
            }
        }
        mav.addObject(Constants.FORM_MODEL_KEY, bean);
        return mav;
    }

    private void extractExcelOwe(String dbFileName, List<ImportCustomerOweDTO> importProductDataDTOs) throws BiffException, IOException {
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
                ImportCustomerOweDTO ImportCustomerOweDTO = new ImportCustomerOweDTO();
                int currentTotalCol = 1;
                ImportCustomerOweDTO.setCustomerName(rowData[currentTotalCol++].getContents());
                ImportCustomerOweDTO.setProvince(rowData[currentTotalCol++].getContents());
                ImportCustomerOweDTO.setOweDate(rowData[currentTotalCol++].getContents());
                ImportCustomerOweDTO.setOwePast(rowData[currentTotalCol++].getContents());
                ImportCustomerOweDTO.setOweCurrent(rowData[currentTotalCol++].getContents());
                ImportCustomerOweDTO.setPayCurrent(rowData[currentTotalCol++].getContents());
                if(StringUtils.isBlank(ImportCustomerOweDTO.getCustomerName())){
                    ImportCustomerOweDTO.setValid(false);
                }
                importProductDataDTOs.add(ImportCustomerOweDTO);
            }
        }
    }

    @RequestMapping(value="/whm/customer/importowelist.html", method=RequestMethod.GET)
    public ModelAndView importOweList(HttpServletRequest request, ImportCustomerOweBean bean) throws Exception {
        String sessionId = request.getSession().getId();
        List<ImportCustomerOweDTO> importedDatas = (List<ImportCustomerOweDTO>) CacheUtil.getInstance().getValue(sessionId + CUSTOMER_IMPORT_KEY);
        if (importedDatas == null || importedDatas.size() == 0) {
            return new ModelAndView("redirect:/whm/customer/importOwe.html");
        }
        ModelAndView mav = new ModelAndView("/whm/customer/importowelist");
        try{
            List<ImportCustomerOweDTO> displayDatas = importedDatas;
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

    @RequestMapping(value="/whm/customer/importowesave.html")
    public ModelAndView importOweSave(HttpServletRequest request, ImportCustomerOweBean bean) throws Exception {
        ModelAndView mav = new ModelAndView("/whm/customer/importowereport");
        String sessionId = request.getSession().getId();
        List<ImportCustomerOweDTO> importedDatas = (List<ImportCustomerOweDTO>) CacheUtil.getInstance().getValue(sessionId + CUSTOMER_IMPORT_KEY);
        if (importedDatas != null && importedDatas.size()  > 0) {
            try{
                Object[] objs = this.customerService.importCustomerOwe2DB(importedDatas,SecurityUtils.getLoginUserId());
                CacheUtil.getInstance().remove(sessionId + CUSTOMER_IMPORT_KEY);
                mav.addObject("success", true);
                mav.addObject("successMessage", this.getMessageSourceAccessor().getMessage("database.add.successful"));
                mav.addObject("totalSuccess", objs[0]);
                mav.addObject("totalItems", importedDatas.size());
                if(StringUtils.isNotBlank(objs[1].toString())){
                    mav.addObject("failCode", objs[1].toString());
                }
            }catch (Exception e) {
                log.error(e.getMessage(),e);
                CacheUtil.getInstance().remove(sessionId + CUSTOMER_IMPORT_KEY);
                mav.addObject("errorMessage", e.getMessage());
            }
        }else{
            mav = new ModelAndView("redirect:/whm/customer/importOwe.html");
            return mav;
        }
        return mav;
    }

    @RequestMapping(value={"/whm/report/dailyOwe.html"})
    public ModelAndView sellSummary(DailyOweBean bean, HttpServletRequest request, HttpServletResponse response) {
        ModelAndView mav = new ModelAndView("/whm/report/dailyOweReport");
        if(bean.getToDate() == null){
            bean.setToDate(new Timestamp(System.currentTimeMillis()));
        }else{
            bean.setToDate(DateUtils.move2TheEndOfDay(new Timestamp(bean.getToDate().getTime())));
        }

        if(bean.getFromDate() == null){
            Calendar calendar = Calendar.getInstance();
            calendar.setTimeInMillis(bean.getToDate().getTime());
            calendar.set(Calendar.DATE, 1);
            bean.setFromDate(new Timestamp(calendar.getTimeInMillis()));
        }
        mav.addObject(Constants.LIST_MODEL_KEY, bean);
        if((bean.getToDate().getTime() - bean.getFromDate().getTime())/(24 * 3600000L) > 31 ||
                bean.getToDate().getTime() - bean.getFromDate().getTime() < 0){
            mav.addObject("alertType","error");
            mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("invalid.date.range"));
            return mav;
        }

        if(bean.getCrudaction() != null && "report".equals(bean.getCrudaction())){
            computeDailyOwe(bean, mav);
        }
        return mav;
    }

    private void computeDailyOwe(DailyOweBean bean, ModelAndView mav){
        try {
            List<OweByDateDTO> results = oweLogService.dailyOwe(bean);
            if(results != null && results.size() > 0){
                mav.addObject("results",results);
            }
        } catch (Exception e) {
            log.error(e.getMessage(),e);
        }
        List<Date> dates = new LinkedList<Date>();
        Date date = bean.getFromDate();
        while(date.before(bean.getToDate())){
            dates.add(date);
            date = DateUtils.addDate(date, 1);
        }
        mav.addObject("dates", dates);
    }
}
