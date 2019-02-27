package com.banvien.tpk.webapp.controller.whm;

import com.banvien.tpk.core.Constants;
import com.banvien.tpk.core.domain.*;
import com.banvien.tpk.core.dto.*;
import com.banvien.tpk.core.exception.DuplicateException;
import com.banvien.tpk.core.exception.ObjectNotFoundException;
import com.banvien.tpk.core.service.*;
import com.banvien.tpk.core.util.CacheUtil;
import com.banvien.tpk.core.util.GeneratorUtils;
import com.banvien.tpk.security.SecurityUtils;
import com.banvien.tpk.webapp.dto.CellDataType;
import com.banvien.tpk.webapp.dto.CellValue;
import com.banvien.tpk.webapp.editor.CustomDateEditor;
import com.banvien.tpk.webapp.editor.PojoEditor;
import com.banvien.tpk.webapp.util.DateUtils;
import com.banvien.tpk.webapp.util.ExcelUtil;
import com.banvien.tpk.webapp.util.RequestUtil;
import com.banvien.tpk.webapp.util.WebCommonUtils;
import com.banvien.tpk.webapp.validator.ImportProductValidator;
import jxl.Workbook;
import jxl.format.Colour;
import jxl.format.UnderlineStyle;
import jxl.write.*;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.ApplicationObjectSupport;
import org.springframework.dao.InvalidDataAccessResourceUsageException;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.lang.Boolean;
import java.sql.Timestamp;
import java.text.DecimalFormat;
import java.util.*;


@Controller
public class ImportProductBillController extends ApplicationObjectSupport {
    private transient final Log log = LogFactory.getLog(getClass());
    private static final String PRODUCT_QUICK_IMPORT_KEY = "ProductQuickImportKey";

    @Autowired
    private ImportproductbillService importproductbillService;

    @Autowired
    private ProductService productService;

    @Autowired
    private UnitService unitService;

    @Autowired
    private CustomerService customerService;

    @Autowired
    private WarehouseService warehouseService;

    @Autowired
    private MarketService marketService;

    @Autowired
    private OriginService originService;

    @Autowired
    private ProductnameService productnameService;

    @Autowired
    private ColourService colourService;

    @Autowired
    private ThicknessService thicknessService;

    @Autowired
    private SizeService sizeService;

    @Autowired
    private QualityService qualityService;

    @Autowired
    private  StiffnessService stiffnessService;

    @Autowired
    private ExportproductService exportproductService;

    @Autowired
    private ProductionPlanService productionPlanService;

    @Autowired
    private OverlaytypeService overlaytypeService;

    @Autowired
    private WarehouseMapService warehouseMapService;

    @Autowired
    private ImportproductService importproductService;

    @Autowired
    private ImportProductValidator importProductValidator;

    @Autowired
    private ImportproductService importProductService;

    @Autowired
    private BuyContractService buyContractService;

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        binder.registerCustomEditor(Date.class, new CustomDateEditor("dd/MM/yyyy"));
        binder.registerCustomEditor(ProductionPlan.class, new PojoEditor(ProductionPlan.class, "productionPlanID", Long.class));

    }
    
    @RequestMapping("/whm/importrootmaterialbill/edit.html")
	public ModelAndView keKhaiNhapTonDen(@ModelAttribute(Constants.FORM_MODEL_KEY) ImportproductbillBean bean, BindingResult bindingResult, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView("/whm/importrootmaterialbill/edit");

		String crudaction = bean.getCrudaction();
		Importproductbill pojo = bean.getPojo();
        Warehouse warehouse = new Warehouse();
        warehouse.setWarehouseID(SecurityUtils.getPrincipal().getWarehouseID());
        pojo.setWarehouse(warehouse);
        bean.setLoginID(SecurityUtils.getLoginUserId());
        bean.setLoginWarehouseID(SecurityUtils.getPrincipal().getWarehouseID());
        boolean isUpdate = false;
        boolean isError = false;
		if(StringUtils.isNotBlank(crudaction) && crudaction.equals("insert-update")) {
			try {
				if(!bindingResult.hasErrors()) {

					if(pojo.getImportProductBillID() != null && pojo.getImportProductBillID() > 0) {
                        isUpdate = true;
                        if(bean.getPojo().getNote() == null || !StringUtils.isNotBlank(bean.getPojo().getNote()))
                            bean.getPojo().setNote(this.getMessageSourceAccessor().getMessage("msg.update"));
						this.importproductbillService.updateRootMaterialBill(bean);
                        mav = new ModelAndView("redirect:/whm/importrootmaterialbill/list.html?isUpdate=true");
                    } else {
                        isUpdate = false;
                        if(bean.getPojo().getNote() == null || !StringUtils.isNotBlank(bean.getPojo().getNote()))
                            bean.getPojo().setNote(this.getMessageSourceAccessor().getMessage("msg.create"));
						this.importproductbillService.addNewRootMaterialBill(bean);
                        mav = new ModelAndView("redirect:/whm/importrootmaterialbill/list.html?isAdd=true");
                    }
                    return mav;
                }
			}catch (ObjectNotFoundException oe) {
                isError = true;
				logger.error(oe.getMessage(),oe);
                mav.addObject("alertType", "error");
                mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("database.exception.keynotfound"));
                prepareDataToEdit(mav,bean,isUpdate);
            }catch (DuplicateException de) {
                isError = true;
				logger.error(de.getMessage(),de);
                mav.addObject("alertType", "error");
                mav.addObject("messageResponse", de.getMessage());
                prepareDataToEdit(mav,bean, isUpdate);
            }catch(Exception e) {
                isError = true;
				logger.error(e.getMessage(),e);
                mav.addObject("alertType", "error");
                mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("general.exception.msg"));
                prepareDataToEdit(mav,bean, isUpdate);
            }
		}
        if(!isError){
            if(!bindingResult.hasErrors() && bean.getPojo().getImportProductBillID() != null &&bean.getPojo().getImportProductBillID() > 0){
                try {
                    Importproductbill itemObj = this.importproductbillService.findById(pojo.getImportProductBillID());
                    bean.setPojo(itemObj);
                    setEditable(bean.getPojo());
                    mav.addObject("importProducts", itemObj.getImportproducts());
                }
                catch (Exception e) {
                    logger.error("Could not found item " + bean.getPojo().getImportProductBillID(), e);
                }
            }else{
                if(bean.getPojo().getCode() == null){
                    bean.getPojo().setCode(GeneratorUtils.generatePNKTONCode());
                }

                String sessionId = request.getSession().getId();
                List<ImportProductDataDTO> importProductDataDTOs = (List<ImportProductDataDTO>) CacheUtil.getInstance().getValue(sessionId + PRODUCT_QUICK_IMPORT_KEY);
                CacheUtil.getInstance().remove(sessionId + PRODUCT_QUICK_IMPORT_KEY);
                if(importProductDataDTOs != null && importProductDataDTOs.size() > 0) {
                    try {
                        List<Importproduct> importProducts = convertData2Show(importProductDataDTOs);
                        mav.addObject("importProducts", importProducts);
                    }
                    catch (Exception e) {
                        logger.error("Can not prepare data to view", e);
                    }
                }
            }
        }

        addData2Model(mav,bean);
		mav.addObject(Constants.FORM_MODEL_KEY, bean);
		return mav;
	}

    private List<Importproduct> convertData2Show(List<ImportProductDataDTO> importProductDataDTOs) {
        List<Importproduct> importProducts = new ArrayList<Importproduct>();
        Map<String, Origin> originMap = getOriginData();
        Map<String, Size> sizeMap = getSizeData();
        for(ImportProductDataDTO importProductDataDTO : importProductDataDTOs){
            Importproduct importProduct = new Importproduct();
            importProduct.setProductCode(importProductDataDTO.getCode());
            importProduct.setSize(sizeMap.get(importProductDataDTO.getSize().toLowerCase()));
            if(StringUtils.isNotEmpty(importProductDataDTO.getQuantityPure())){
                importProduct.setQuantity2Pure(Double.valueOf(importProductDataDTO.getQuantityPure()));
            }
            if(StringUtils.isNotEmpty(importProductDataDTO.getQuantityOverall())){
                importProduct.setQuantity2(Double.valueOf(importProductDataDTO.getQuantityOverall()));
            }
            if(StringUtils.isNotEmpty(importProductDataDTO.getQuantityActual())){
                importProduct.setQuantity2Actual(Double.valueOf(importProductDataDTO.getQuantityActual()));
            }
            importProduct.setOrigin(originMap.get(importProductDataDTO.getOrigin().toLowerCase()));
            importProducts.add(importProduct);
        }
        return importProducts;
    }


    private Map<String, Origin> getOriginData() {
        Map<String, Origin> data = new HashMap<String, Origin>();
        for(Origin origin : originService.findAll()){
            data.put(origin.getName().toLowerCase(), origin);
        }
        return data;
    }

    private Map<String, Size> getSizeData() {
        Map<String, Size> data = new HashMap<String, Size>();
        for(Size size : sizeService.findAll()){
            data.put(size.getName().toLowerCase(), size);
        }
        return data;
    }

    private void prepareDataToEdit(ModelAndView mav, ImportproductbillBean bean, boolean isUpdate) {
        if(!isUpdate){
            bean.getPojo().setImportProductBillID(null);
        }
        bean.getPojo().setEditable(Boolean.TRUE);
        List<Importproduct> importproducts = prepareImportProducts(bean.getItemInfos());
        mav.addObject("importProducts", importproducts);
    }

    private List<Importproduct> prepareImportProducts(List<ItemInfoDTO> itemInfos) {
        List<Importproduct> importproducts = new ArrayList<Importproduct>();
        for(ItemInfoDTO item : itemInfos){
            if(
                    StringUtils.isBlank(item.getCode()) &&
                    item.getQuantityOverall() == null &&
                    item.getQuantityPure() == null &&
                    item.getQuantityActual() == null){
                continue;
            }else{
                Importproduct importproduct = new Importproduct();
                importproduct.setProductCode(StringUtils.isNotBlank(item.getCode()) ? item.getCode().toUpperCase() : "");
                importproduct.setProductname(item.getProductName());
                importproduct.setMarket(item.getMarket());

                if(item.getSize() != null && item.getSize().getSizeID() != null && item.getSize().getSizeID() > 0){
                    importproduct.setSize(item.getSize());
                }
                else{
                    importproduct.setSize(null);
                }

                if(item.getThickness() != null && item.getThickness().getThicknessID() != null && item.getThickness().getThicknessID() > 0){
                    importproduct.setThickness(item.getThickness());
                }
                else{
                    importproduct.setThickness(null);
                }
                if(item.getStiffness() != null && item.getStiffness().getStiffnessID() != null && item.getStiffness().getStiffnessID() > 0){
                    importproduct.setStiffness(item.getStiffness());
                }
                else{
                    importproduct.setStiffness(null);
                }
                if(item.getColour() != null && item.getColour().getColourID() != null && item.getColour().getColourID() > 0){
                    importproduct.setColour(item.getColour());
                }
                else{
                    importproduct.setColour(null);
                }
                if(item.getOrigin() != null && item.getOrigin().getOriginID() != null && item.getOrigin().getOriginID() > 0){
                    importproduct.setOrigin(item.getOrigin());
                }
                else{
                    importproduct.setOrigin(null);
                }

                if(item.getOverlayType() != null && item.getOverlayType().getOverlayTypeID() != null && item.getOverlayType().getOverlayTypeID() > 0){
                    importproduct.setOverlaytype(item.getOverlayType());
                }
                else{
                    importproduct.setOverlaytype(null);
                }

                if(item.getQuantityOverall() != null && item.getQuantityOverall() > 0){
                    importproduct.setQuantity2(item.getQuantityOverall());
                }else if(item.getQuantityKg() != null && item.getQuantityKg() > 0){
                    importproduct.setQuantity2(item.getQuantityKg());
                }
                else{
                    importproduct.setQuantity2(null);
                }

                if(item.getQuantityPure() != null && item.getQuantityPure() > 0){
                    importproduct.setQuantity2Pure(item.getQuantityPure());
                }
                if(item.getQuantityActual() != null && item.getQuantityActual() > 0){
                    importproduct.setQuantity2Actual(item.getQuantityActual());
                }

                if(item.getOrigin() != null && item.getOrigin().getOriginID() != null && item.getOrigin().getOriginID() > 0){
                    importproduct.setOrigin(item.getOrigin());
                }
                else{
                    importproduct.setOrigin(null);
                }

                if(item.getCore() != null && StringUtils.isNotBlank(item.getCore())){
                    importproduct.setCore(item.getCore());
                }
                else{
                    importproduct.setCore(null);
                }

                if(item.getNote() != null && StringUtils.isNotBlank(item.getNote())){
                    importproduct.setNote(item.getNote());
                }
                else{
                    importproduct.setNote(null);
                }

                importproduct.setQualityQuantityMap(item.getQualityQuantityMap());
                importproducts.add(importproduct);
            }
        }
        return importproducts;
    }

    private void addData2Model(ModelAndView mav, ImportproductbillBean bean) {
        mav.addObject("markets", marketService.findAll());
        mav.addObject("customers", customerService.findAll());
//        if(SecurityUtils.getPrincipal().getWarehouseID() != null){
//            mav.addObject("warehouses", warehouseService.findByIdNoCommit(SecurityUtils.getPrincipal().getWarehouseID()));
//        }else{
//            mav.addObject("warehouses", warehouseService.findAllActiveWarehouseExcludeID(null));
//        }
        mav.addObject("productNames", productnameService.findAll());
        mav.addObject("units", unitService.findAll());
        mav.addObject("origins", originService.findAll());
        mav.addObject("colours", colourService.findAll());
        mav.addObject("thicknesses", thicknessService.findAll());
        mav.addObject("sizes", sizeService.findAll());
        mav.addObject("qualities", qualityService.findAll());
        mav.addObject("stiffnesses", stiffnessService.findAll());
        mav.addObject("overlayTypes", overlaytypeService.findAll());
        List<WarehouseMap> warehouseMaps = new ArrayList<WarehouseMap>();
        if(SecurityUtils.getPrincipal().getWarehouseID() != null){
            warehouseMaps = this.warehouseMapService.findByWarehouseID(SecurityUtils.getPrincipal().getWarehouseID());
        }
        mav.addObject("warehouseMaps",warehouseMaps);
        if(bean != null){
            bean.setLoginID(SecurityUtils.getLoginUserId());
        }
    }


    @RequestMapping(value={"/whm/importrootmaterialbill/list.html"})
    public ModelAndView danhSachNhapTonDen(@ModelAttribute(Constants.LIST_MODEL_KEY) ImportproductbillBean bean,HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("/whm/importrootmaterialbill/list");
        if(bean.getToDate() != null){
            bean.setToDate(DateUtils.move2TheEndOfDay(new Timestamp(bean.getToDate().getTime())));
        }
		if(StringUtils.isNotBlank(bean.getCrudaction()) && bean.getCrudaction().equals(Constants.ACTION_DELETE)) {
			Integer totalDeleted = 0;
			try {
				totalDeleted = importproductbillService.deleteItems(bean.getCheckList());
				mav.addObject("totalDeleted", totalDeleted);
                mav.addObject("alertType","success");
                mav.addObject(Constants.MESSAGE_RESPONSE_MODEL_KEY, this.getMessageSourceAccessor().getMessage("delete.successful"));
			}catch (Exception e) {
				log.error(e.getMessage(), e);
                mav.addObject("alertType","error");
                mav.addObject(Constants.MESSAGE_RESPONSE_MODEL_KEY, this.getMessageSourceAccessor().getMessage("database.multipledelete.exception"));
			}
		}
        bean.setIsBlackProduct(Boolean.TRUE);
        executeSearch(bean, request);
        addData2Model(mav,bean);
        mav.addObject(Constants.LIST_MODEL_KEY, bean);
        showAlert(mav,bean.getIsAdd(),bean.getIsUpdate(),bean.getIsError());
        countNoBillofMonth(mav, Boolean.TRUE);
        return mav;
    }

    private void countNoBillofMonth(ModelAndView mav, Boolean isBlack) {
        List<Importproductbill> allBills = this.importproductbillService.findAllByOrderAndDateLimit("importDate", isBlack, Constants.A_MONTH * 6);
        Map<Long,String> mapBillNoInMonth = new HashMap<Long, String>();
        if(allBills != null && allBills.size() > 0){
            Map<String,List<Importproductbill>> mapMonthBills = new HashMap<String, List<Importproductbill>>();
            for(Importproductbill bill : allBills){
                String billDate = DateUtils.date2String(bill.getImportDate(), "MM/yyyy") ;
                if(mapMonthBills.get(billDate) != null){
                    mapMonthBills.get(billDate).add(bill);
                }else{
                    List<Importproductbill> bills = new LinkedList<Importproductbill>();
                    bills.add(bill);
                    mapMonthBills.put(billDate,bills);
                }
            }

            for(String month : mapMonthBills.keySet()){
                List<Importproductbill> bills = mapMonthBills.get(month);
                Integer counter = 1;
                for(Importproductbill bill : bills){
                    mapBillNoInMonth.put(bill.getImportProductBillID(), "#" + counter + "-" + month);
                    counter++;
                }
            }
        }
        mav.addObject("mapBillNoInMonth", mapBillNoInMonth);
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

    private void executeSearch(ImportproductbillBean bean, HttpServletRequest request) {
        RequestUtil.initSearchBean(request, bean);
        Object[] results = this.importproductbillService.search(bean);
        List<Importproductbill> importproductbills = (List<Importproductbill>)results[1];
        for(Importproductbill importproductbill : importproductbills){
            setEditable(importproductbill);
        }
        bean.setListResult(importproductbills);
        bean.setTotalItems(Integer.valueOf(results[0].toString()));
    }

    private void setEditable(Importproductbill importproductbill){
        if(!importproductbill.getStatus().equals(Constants.CONFIRMED)
                && SecurityUtils.getLoginUserId().equals(importproductbill.getCreatedBy().getUserID())){
            importproductbill.setEditable(Boolean.TRUE);
        }
    }

    @RequestMapping("/whm/importrootmaterialbill/view.html")
    public ModelAndView viewImportRootProduct(@ModelAttribute(Constants.FORM_MODEL_KEY) ImportproductbillBean bean, BindingResult bindingResult,
                                                HttpServletRequest request,HttpServletResponse response) {
        ModelAndView mav = new ModelAndView("/whm/importrootmaterialbill/view");

        String crudaction = bean.getCrudaction();
        Importproductbill pojo = bean.getPojo();
        bean.setLoginID(SecurityUtils.getLoginUserId());
        if (StringUtils.isNotBlank(crudaction) && crudaction.equals("reject")){
            try {
                if(!bindingResult.hasErrors()) {
                    if(pojo.getImportProductBillID() != null && pojo.getImportProductBillID() > 0) {
                        if(bean.getPojo().getNote() == null || !StringUtils.isNotBlank(bean.getPojo().getNote()))
                            bean.getPojo().setNote(this.getMessageSourceAccessor().getMessage("msg.reject"));
                        this.importproductbillService.updateReject(bean.getPojo().getNote(),bean.getPojo().getImportProductBillID(),SecurityUtils.getLoginUserId());
                        mav = new ModelAndView("redirect:/whm/importrootmaterialbill/list.html?isUpdate=true");
                    }
                    return mav;
                }
            }catch(Exception e) {
                logger.error(e.getMessage(),e);
                mav.addObject("alertType", "error");
                mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("general.exception.msg"));
                mav = new ModelAndView("redirect:/whm/importrootmaterialbill/list.html?isError=true");
            }
        }else if (StringUtils.isNotBlank(crudaction) && crudaction.equals("insert-update")){
            try {
                if(!bindingResult.hasErrors()) {
                    if(pojo.getImportProductBillID() != null && pojo.getImportProductBillID() > 0) {
                        if(bean.getPojo().getNote() == null || !StringUtils.isNotBlank(bean.getPojo().getNote()))
                            bean.getPojo().setNote(this.getMessageSourceAccessor().getMessage("msg.approve"));
                        this.importproductbillService.updateConfirm(bean);
                        mav = new ModelAndView("redirect:/whm/importrootmaterialbill/list.html?isUpdate=true");
                    }
                    return mav;
                }
            }catch(Exception e) {
                logger.error(e.getMessage(),e);
                mav.addObject("alertType", "error");
                mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("general.exception.msg"));
                mav = new ModelAndView("redirect:/whm/importrootmaterialbill/list.html?isError=true");
            }
        }   else if (StringUtils.isNotBlank(crudaction) && crudaction.equals("update-money")){
            try {
                if(!bindingResult.hasErrors()) {
                    if(pojo.getImportProductBillID() != null && pojo.getImportProductBillID() > 0) {
                        if(bean.getPojo().getNote() == null || !StringUtils.isNotBlank(bean.getPojo().getNote()))
                            bean.getPojo().setNote(this.getMessageSourceAccessor().getMessage("msg.approve.money"));
                        this.importproductbillService.updateConfirmMoney(bean);
                        mav = new ModelAndView("redirect:/whm/importrootmaterialbill/list.html?isUpdate=true");
                    }
                    return mav;
                }else{
                    mav.addObject("alertType", "error");
                    mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("general.exception.msg"));
                    mav = new ModelAndView("redirect:/whm/importrootmaterialbill/list.html?isError=true");
                }
            }catch(Exception e) {
                logger.error(e.getMessage(),e);
                mav.addObject("alertType", "error");
                mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("general.exception.msg"));
                mav = new ModelAndView("redirect:/whm/importrootmaterialbill/list.html?isError=true");
            }
        }
        if(!bindingResult.hasErrors() && bean.getPojo().getImportProductBillID() != null && bean.getPojo().getImportProductBillID() > 0){
            try {
                Importproductbill itemObj = this.importproductbillService.findById(pojo.getImportProductBillID());
                bean.setPojo(itemObj);
                mav.addObject("importProducts", itemObj.getImportproducts());
                if(StringUtils.isNotBlank(crudaction) && crudaction.equals("export")){
                    exportImportBlack2Excel(itemObj, request, response);
                }
            }
            catch (Exception e) {
                logger.error("Could not found item " + bean.getPojo().getImportProductBillID(), e);
            }
        }
        if(SecurityUtils.userHasAuthority(Constants.NVTT_ROLE) || SecurityUtils.userHasAuthority(Constants.QLTT_ROLE) || SecurityUtils.userHasAuthority(Constants.LANHDAO_ROLE)){
            mav.addObject("buyContracts", this.buyContractService.findAll());
        }
        mav.addObject(Constants.FORM_MODEL_KEY, bean);
        return mav;
    }

    private void exportImportBlack2Excel(Importproductbill bill, HttpServletRequest request, HttpServletResponse response) {
        try{
            String outputFileName = "/files/temp/PhieuNhapTonDen" + System.currentTimeMillis() + ".xls";
            String reportTemplate = request.getSession().getServletContext().getRealPath("/files/export/ImportBlackTemplate.xls");
            String export2FileName = request.getSession().getServletContext().getRealPath(outputFileName);

            Workbook templateWorkbook = Workbook.getWorkbook(new File(reportTemplate));
            WritableWorkbook workbook = Workbook.createWorkbook(new File(export2FileName), templateWorkbook);

            WritableSheet sheet = workbook.getSheet(0);


            WritableFont normalFont = new WritableFont(WritableFont.TIMES, 12,
                    WritableFont.NO_BOLD, false,
                    UnderlineStyle.NO_UNDERLINE,
                    jxl.format.Colour.BLACK);
            WritableCellFormat normalFormat = new WritableCellFormat(normalFont);
            WritableCellFormat filterFormat = new WritableCellFormat(normalFont);
            normalFormat.setAlignment(jxl.write.Alignment.CENTRE);
            normalFormat.setWrap(true);
            normalFormat.setBorder(jxl.format.Border.ALL, jxl.format.BorderLineStyle.THIN);
            DecimalFormat decimalFormat = new DecimalFormat("###,###");

            Label customer = new Label(2, 1, bill.getCustomer().getName(), filterFormat);
            sheet.addCell(customer);

            Label date = new Label(6, 1, DateUtils.date2String(bill.getImportDate(), "dd/MM/yyyy"), filterFormat);
            sheet.addCell(date);

            int startRow = 4;
            int stt = 1;
            String originName;
            Double total = 0d;
            Double pure = 0d;
            Double actual = 0d;
            for(Importproduct importproduct : bill.getImportproducts()){
                CellValue[] res = new CellValue[8];
                int i = 0;
                res[i++] = new CellValue(CellDataType.STRING, stt++);
                res[i++] = new CellValue(CellDataType.STRING, importproduct.getProductCode() != null ? importproduct.getProductCode() : "");
                res[i++] = new CellValue(CellDataType.STRING, importproduct.getSize() != null ? importproduct.getSize().getName() : "");
                res[i++] = new CellValue(CellDataType.STRING, importproduct.getQuantity2Pure() != null ? decimalFormat.format(importproduct.getQuantity2Pure())  : "");
                res[i++] = new CellValue(CellDataType.STRING, importproduct.getQuantity2() != null ? decimalFormat.format(importproduct.getQuantity2())  : "");
                res[i++] = new CellValue(CellDataType.STRING, importproduct.getQuantity2Actual() != null ? decimalFormat.format(importproduct.getQuantity2Actual())  : "");
                res[i++] = new CellValue(CellDataType.STRING, importproduct.getQuantity2() != null && importproduct.getQuantity2Actual() != null ? decimalFormat.format(importproduct.getQuantity2Actual() - importproduct.getQuantity2())  : "");
                originName = "";
                if(importproduct.getOrigin() != null){
                    originName = importproduct.getOrigin().getName();
                }else if(importproduct.getMainUsedMaterial() != null && importproduct.getMainUsedMaterial().getOrigin() != null){
                    originName = importproduct.getMainUsedMaterial().getOrigin().getName();
                }else if(importproduct.getMainUsedMaterial() != null && importproduct.getMainUsedMaterial().getMainUsedMaterial() != null && importproduct.getMainUsedMaterial().getMainUsedMaterial().getOrigin() != null){
                    originName = importproduct.getMainUsedMaterial().getMainUsedMaterial().getOrigin().getName();
                }
                res[i++] = new CellValue(CellDataType.STRING, originName);
                ExcelUtil.addRow(sheet, startRow++, res, normalFormat, normalFormat, normalFormat, normalFormat);
                total +=  importproduct.getQuantity2() != null ? importproduct.getQuantity2() : 0d;
                pure +=  importproduct.getQuantity2Pure() != null ? importproduct.getQuantity2Pure() : 0d;
                actual +=  importproduct.getQuantity2Actual() != null ? importproduct.getQuantity2Actual() : 0d;
            }

            WritableFont boldFont = new WritableFont(WritableFont.TIMES, 12,
                    WritableFont.BOLD, false,
                    UnderlineStyle.NO_UNDERLINE,
                    jxl.format.Colour.BLACK);
            WritableCellFormat boldCenterFormat = new WritableCellFormat(boldFont);
            boldCenterFormat.setWrap(true);
            boldCenterFormat.setAlignment(jxl.write.Alignment.CENTRE);
            boldCenterFormat.setBorder(jxl.format.Border.ALL, jxl.format.BorderLineStyle.THIN);

            Label tong = new Label(0,startRow,"Tổng",boldCenterFormat);
            sheet.addCell(tong);
            sheet.mergeCells(0,startRow,1,startRow);

            Label cuon = new Label(2,startRow, bill.getImportproducts().size() + " cuộn",boldCenterFormat);
            sheet.addCell(cuon);

            Label lPure = new Label(3,startRow, decimalFormat.format(pure),boldCenterFormat);
            sheet.addCell(lPure);

            Label lTotal = new Label(4,startRow, decimalFormat.format(total),boldCenterFormat);
            sheet.addCell(lTotal);

            Label lActual = new Label(5,startRow, decimalFormat.format(actual),boldCenterFormat);
            sheet.addCell(lActual);

            Label lGap = new Label(6,startRow, decimalFormat.format(actual - total),boldCenterFormat);
            sheet.addCell(lGap);

            Label blank = new Label(7,startRow, "",boldCenterFormat);
            sheet.addCell(blank);

            workbook.write();
            workbook.close();
            response.sendRedirect(request.getSession().getServletContext().getContextPath() + outputFileName);
        }
        catch(Exception ex){
            logger.error(ex.getMessage(), ex);
        }
    }

    @RequestMapping("/whm/importproductbill/edit.html")
    public ModelAndView importProduct(@ModelAttribute(Constants.FORM_MODEL_KEY) ImportproductbillBean bean, BindingResult bindingResult) throws ObjectNotFoundException {
        ModelAndView mav = new ModelAndView("/whm/importproductbill/edit");
        String crudaction = bean.getCrudaction();
        Importproductbill pojo = bean.getPojo();
        Warehouse warehouse = new Warehouse();
        warehouse.setWarehouseID(SecurityUtils.getPrincipal().getWarehouseID());
        pojo.setWarehouse(warehouse);
        bean.setLoginID(SecurityUtils.getLoginUserId());
        boolean isError = false;
        boolean isUpdate = false;
        if(StringUtils.isNotBlank(crudaction) && crudaction.equals("insert-update")) {
            try {
                if(validateDataStructure(bean.getPojo(), bean.getMainMaterials())){
                    if(!bindingResult.hasErrors()) {
                        if(pojo.getImportProductBillID() != null && pojo.getImportProductBillID() > 0) {
                            isUpdate = true;
                            if(bean.getPojo().getNote() == null || !StringUtils.isNotBlank(bean.getPojo().getNote()))
                                bean.getPojo().setNote(this.getMessageSourceAccessor().getMessage("msg.update"));
                            this.importproductbillService.updateProductBill(bean);
                            mav = new ModelAndView("redirect:/whm/importproductbill/list.html?isUpdate=true");
                        } else {
                            isUpdate = false;
                            if(bean.getPojo().getNote() == null || !StringUtils.isNotBlank(bean.getPojo().getNote()))
                                bean.getPojo().setNote(this.getMessageSourceAccessor().getMessage("msg.create"));
                            this.importproductbillService.addProductBill(bean);
                            mav = new ModelAndView("redirect:/whm/importproductbill/list.html?isAdd=true");
                        }
                        return mav;
                    }
                }else {
                    isError = true;
                    logger.error("Incorrect data structure (comma occur in bill/product code)");
                    mav.addObject("alertType", "error");
                    mav.addObject("messageResponse", "Số phiếu/mã tôn bị phân mảnh (có dấu phẩy) trong quá trình lưu, đã được loại bỏ, vui lòng thử lại");
                    prepareProductDataToEdit(mav, bean, isUpdate);
                }
            }
            catch(Exception e) {
                isError = true;
                logger.error(e.getMessage(),e);
                mav.addObject("alertType", "error");
                mav.addObject("messageResponse", e.getMessage());
                prepareProductDataToEdit(mav, bean, isUpdate);
            }
        }
        if(!isError){
            if(!bindingResult.hasErrors() && bean.getPojo().getImportProductBillID() != null &&bean.getPojo().getImportProductBillID() > 0){
                try {
                    Importproductbill itemObj = this.importproductbillService.findById(pojo.getImportProductBillID());
                    Object[] objects = prepare2Display(itemObj.getImportproducts());
                    List<MainMaterialInfoDTO> mainMaterialInfoDTOs = (List<MainMaterialInfoDTO>) objects[0];
                    List<Importproduct> usedProducts = (List<Importproduct>) objects[1];
                    bean.setPojo(itemObj);
                    setEditable(bean.getPojo());
                    mav.addObject("mainUsedMaterials", mainMaterialInfoDTOs);
                    addExportProduct2Model(mav,bean,usedProducts);
                }
                catch (Exception e) {
                    logger.error("Could not found item " + bean.getPojo().getImportProductBillID(), e);
                }
            }else {
                if(bean.getPojo().getProductionPlan() != null && bean.getPojo().getProductionPlan().getProductionPlanID() != null && bean.getPojo().getProductionPlan().getProductionPlanID() > 0 ){
                    ProductionPlan productionPlan = this.productionPlanService.findById(bean.getPojo().getProductionPlan().getProductionPlanID());
                    bean.getPojo().setProductionPlan(productionPlan);
                    addExportProduct2Model(mav,bean,null);
                }
                if(bean.getPojo().getCode() == null){
                    bean.getPojo().setCode(GeneratorUtils.generatePNKTONCode());
                }
            }
        }

        addData2Model(mav,bean);
        mav.addObject(Constants.FORM_MODEL_KEY, bean);
        return mav;
    }

    private void prepareProductDataToEdit(ModelAndView mav, ImportproductbillBean bean, boolean isUpdate) throws ObjectNotFoundException {
        if(bean.getPojo().getProductionPlan() != null && bean.getPojo().getProductionPlan().getProductionPlanID() != null && bean.getPojo().getProductionPlan().getProductionPlanID() > 0 ){
            ProductionPlan productionPlan = this.productionPlanService.findById(bean.getPojo().getProductionPlan().getProductionPlanID());
            bean.getPojo().setProductionPlan(productionPlan);
        }
        if(!isUpdate){
            bean.getPojo().setImportProductBillID(null);
        }
        bean.getPojo().setEditable(Boolean.TRUE);
        addProductDataToEdit(mav, bean, isUpdate);
    }

    private void addProductDataToEdit(ModelAndView mav, ImportproductbillBean bean, boolean update) {
        List<Importproduct> exportProducts = this.exportproductService.findProductByProductionPlan(bean.getPojo().getProductionPlan().getProductionPlanID());
        List<MainMaterialInfoDTO> mainMaterialInfoDTOs = new LinkedList<MainMaterialInfoDTO>();


        for(MainMaterialInfoDTO mainMaterialInfoDTO : bean.getMainMaterials()){
            Importproduct mainUsedMaterial = importProductService.findByIdNoCommit(mainMaterialInfoDTO.getItemID());

            List<Importproduct> importproductList = prepareImportProducts(mainMaterialInfoDTO.getItemInfos());
            mainMaterialInfoDTO.setMainMaterialName(mainUsedMaterial.getProductname().getName());
            if(mainUsedMaterial.getSize() != null){
                mainMaterialInfoDTO.setMainMaterialSize(mainUsedMaterial.getSize().getName());
            }
            String specific = "";
            if(mainUsedMaterial.getProductname().getCode().equals(Constants.PRODUCT_BLACK)){
                specific = mainUsedMaterial.getOrigin() != null ? mainUsedMaterial.getOrigin().getName() : null;
            }else{
                mainMaterialInfoDTO.setTotalM(mainUsedMaterial.getQuantity1());
                if(mainUsedMaterial.getColour() != null){
                    specific = mainUsedMaterial.getColour().getName();

                }else if (mainUsedMaterial.getThickness() != null) {
                    specific = mainUsedMaterial.getThickness().getName();
                }
            }
            mainMaterialInfoDTO.setTotalKg(mainUsedMaterial.getQuantity2Pure());
            mainMaterialInfoDTO.setMainMaterialSpecific(specific);
            mainMaterialInfoDTO.setImportproducts(importproductList);
            mainMaterialInfoDTO.setMainMaterialCode(mainUsedMaterial.getProductCode());
            mainMaterialInfoDTOs.add(mainMaterialInfoDTO);
            if(!exportProducts.contains(mainUsedMaterial)){
                exportProducts.add(mainUsedMaterial);
            }
        }
        mav.addObject("mainUsedMaterials", mainMaterialInfoDTOs);
        mav.addObject("products",exportProducts);
    }

    private boolean validateDataStructure(Importproductbill bill, List<MainMaterialInfoDTO> mainMaterials) {
        boolean isCorrect = true;
        if(StringUtils.isNotBlank(bill.getCode()) && bill.getCode().indexOf(",") > 0){
            String[] codes = StringUtils.split(bill.getCode(), ",");
            bill.setCode(codes[codes.length - 1]);
            isCorrect = false;
        }
        String[] pCodes;
        if(mainMaterials != null){
            for(MainMaterialInfoDTO mainMaterialInfoDTO : mainMaterials){
                if(mainMaterialInfoDTO.getItemID() != null && mainMaterialInfoDTO.getItemID() > 0){
                    if(mainMaterialInfoDTO.getItemInfos() != null){
                        for(ItemInfoDTO itemInfoDTO : mainMaterialInfoDTO.getItemInfos()){
                            if (StringUtils.isNotBlank(itemInfoDTO.getCode()) && itemInfoDTO.getCode().indexOf(",") > 0) {
                                pCodes = StringUtils.split(itemInfoDTO.getCode(), ",");
                                itemInfoDTO.setCode(pCodes[0]);
                                isCorrect = false;
                            }
                        }
                    }
                }
            }
        }
        return isCorrect;
    }

    @RequestMapping(value={"/whm/importproductbill/list.html"})
    public ModelAndView danhSachNhapThanhPham(@ModelAttribute(Constants.LIST_MODEL_KEY) ImportproductbillBean bean,HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("/whm/importproductbill/list");
        if(bean.getToDate() != null){
            bean.setToDate(DateUtils.move2TheEndOfDay(new Timestamp(bean.getToDate().getTime())));
        }
        if(StringUtils.isNotBlank(bean.getCrudaction()) && bean.getCrudaction().equals(Constants.ACTION_DELETE)) {
            Integer totalDeleted = 0;
            try {
                totalDeleted = importproductbillService.deleteItems(bean.getCheckList());
                mav.addObject("totalDeleted", totalDeleted);
            }catch (Exception e) {
                log.error(e.getMessage(), e);
                mav.addObject("alertType","error");
                mav.addObject(Constants.MESSAGE_RESPONSE_MODEL_KEY, this.getMessageSourceAccessor().getMessage("database.multipledelete.exception"));
            }
        }
        bean.setIsBlackProduct(Boolean.FALSE);
        executeSearch(bean, request);
        mav.addObject(Constants.LIST_MODEL_KEY, bean);
        addData2Model(mav,bean);
        showAlert(mav,bean.getIsAdd(),bean.getIsUpdate(),bean.getIsError());
        countNoBillofMonth(mav,Boolean.FALSE);
        return mav;
    }

    @RequestMapping("/whm/importproductbill/view.html")
    public ModelAndView importProductView(@ModelAttribute(Constants.FORM_MODEL_KEY) ImportproductbillBean bean, BindingResult bindingResult) throws ObjectNotFoundException {
        ModelAndView mav = new ModelAndView("/whm/importproductbill/viewNew");
        String crudaction = bean.getCrudaction();
        Importproductbill pojo = bean.getPojo();
        Warehouse warehouse = new Warehouse();
        warehouse.setWarehouseID(SecurityUtils.getPrincipal().getWarehouseID());
        pojo.setWarehouse(warehouse);
        bean.setLoginID(SecurityUtils.getLoginUserId());
        if (StringUtils.isNotBlank(crudaction) && crudaction.equals("reject")){
            try {
                if(!bindingResult.hasErrors()) {
                    if(pojo.getImportProductBillID() != null && pojo.getImportProductBillID() > 0) {
                        if(bean.getPojo().getNote() == null || !StringUtils.isNotBlank(bean.getPojo().getNote()))
                            bean.getPojo().setNote(this.getMessageSourceAccessor().getMessage("msg.reject"));
                        this.importproductbillService.updateReject(bean.getPojo().getNote(),bean.getPojo().getImportProductBillID(),SecurityUtils.getLoginUserId());
                        mav = new ModelAndView("redirect:/whm/importproductbill/list.html?isUpdate=true");
                    }
                    return mav;
                }
            }catch(Exception e) {
                logger.error(e.getMessage(),e);
                mav.addObject("alertType", "error");
                mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("general.exception.msg"));
                mav = new ModelAndView("redirect:/whm/importproductbill/list.html?isError=true");
            }
        }else if (StringUtils.isNotBlank(crudaction) && crudaction.equals("insert-update")){
            try {
                if(!bindingResult.hasErrors()) {
                    if(pojo.getImportProductBillID() != null && pojo.getImportProductBillID() > 0) {
                        if(bean.getPojo().getNote() == null || !StringUtils.isNotBlank(bean.getPojo().getNote()))
                            bean.getPojo().setNote(this.getMessageSourceAccessor().getMessage("msg.approve"));
                        this.importproductbillService.updateConfirm(bean);
                        mav = new ModelAndView("redirect:/whm/importproductbill/list.html?isUpdate=true");
                    }
                    return mav;
                }
            }catch (InvalidDataAccessResourceUsageException ie){
                logger.error(ie.getMessage(),ie);
                mav.addObject("alertType", "error");
                mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("no.product.exception.msg"));
                mav = new ModelAndView("redirect:/whm/importproductbill/list.html?isError=true");
            }
            catch(Exception e) {
                logger.error(e.getMessage(),e);
                mav.addObject("alertType", "error");
                mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("general.exception.msg"));
                mav = new ModelAndView("redirect:/whm/importproductbill/list.html?isError=true");
            }
        }
        if(!bindingResult.hasErrors() && bean.getPojo().getImportProductBillID() != null &&bean.getPojo().getImportProductBillID() > 0){
            try {
                Importproductbill itemObj = this.importproductbillService.findById(pojo.getImportProductBillID());
                Object[] objects = prepare2Display(itemObj.getImportproducts());
                List<MainMaterialInfoDTO> mainMaterialInfoDTOs = (List<MainMaterialInfoDTO>) objects[0];
                List<Importproduct> usedProducts = (List<Importproduct>) objects[1];
                bean.setPojo(itemObj);
                mav.addObject("mainUsedMaterials", mainMaterialInfoDTOs);

                Importproductbill importBackBill = this.importproductbillService.findByParentBill(bean.getPojo().getImportProductBillID());
                if(importBackBill != null && importBackBill.getImportproducts() != null && importBackBill.getImportproducts().size() > 0){
                    mav.addObject("importBackBill", importBackBill);
                }
            }
            catch (Exception e) {
                logger.error("Could not found item " + bean.getPojo().getImportProductBillID(), e);
            }
        }
        mav.addObject(Constants.FORM_MODEL_KEY, bean);
        mav.addObject("qualities", qualityService.findAll());
        return mav;
    }

    private void addExportProduct2Model(ModelAndView mav, ImportproductbillBean bean, List<Importproduct> usedProducts) {
        List<Importproduct> importproducts = this.exportproductService.findProductByProductionPlan(bean.getPojo().getProductionPlan().getProductionPlanID());
        if(usedProducts != null && usedProducts.size() > 0) importproducts.addAll(usedProducts);
        mav.addObject("products",importproducts);
    }

    private Object[] prepare2Display(List<Importproduct> importproducts){
        List<MainMaterialInfoDTO> mainMaterialInfoDTOs = new LinkedList<MainMaterialInfoDTO>();
        Map<Long,List<Importproduct>> materialProductsMap = new LinkedHashMap<Long, List<Importproduct>>();
        List<Importproduct> usedProducts = new ArrayList<Importproduct>();
        for(Importproduct importproduct : importproducts){
            if(importproduct.getMainUsedMaterial() != null){
                Map<Long,Double> qualityQuantityMap = mapProductQuality(importproduct.getProductqualitys());
                importproduct.setQualityQuantityMap(qualityQuantityMap);
                if(!materialProductsMap.containsKey(importproduct.getMainUsedMaterial().getImportProductID())){
                    List<Importproduct> importproductList = new LinkedList<Importproduct>();
                    importproductList.add(importproduct);
                    materialProductsMap.put(importproduct.getMainUsedMaterial().getImportProductID(),importproductList);
                }else {
                    materialProductsMap.get(importproduct.getMainUsedMaterial().getImportProductID()).add(importproduct);
                }
            }
        }
        for(Long mainMaterialID : materialProductsMap.keySet()){
            List<Importproduct> importproductList = materialProductsMap.get(mainMaterialID);
            Importproduct mainUsedMaterial = importproductList.get(0).getMainUsedMaterial();

            MainMaterialInfoDTO mainMaterialInfoDTO = new MainMaterialInfoDTO();
            mainMaterialInfoDTO.setItemID(mainUsedMaterial.getImportProductID());
            mainMaterialInfoDTO.setMainMaterialName(mainUsedMaterial.getProductname().getName());
            if(mainUsedMaterial.getSize() != null){
                mainMaterialInfoDTO.setMainMaterialSize(mainUsedMaterial.getSize().getName());
            }
            String specific = "";
            if(mainUsedMaterial.getProductname().getCode().equals(Constants.PRODUCT_BLACK)){
                specific = mainUsedMaterial.getOrigin() != null ? mainUsedMaterial.getOrigin().getName() : null;
            }else{
                mainMaterialInfoDTO.setTotalM(mainUsedMaterial.getQuantity1());
                if(mainUsedMaterial.getColour() != null){
                    specific = mainUsedMaterial.getColour().getName();

                }else if (mainUsedMaterial.getThickness() != null) {
                    specific = mainUsedMaterial.getThickness().getName();
                }
            }
            mainMaterialInfoDTO.setTotalKg(mainUsedMaterial.getQuantity2Pure());
            mainMaterialInfoDTO.setMainMaterialSpecific(specific);
            mainMaterialInfoDTO.setCutOff(mainUsedMaterial.getCutOff());
            mainMaterialInfoDTO.setImportBack(mainUsedMaterial.getImportBack());
            mainMaterialInfoDTO.setImportproducts(importproductList);
            mainMaterialInfoDTO.setMainMaterialCode(mainUsedMaterial.getProductCode());
            mainMaterialInfoDTOs.add(mainMaterialInfoDTO);

            usedProducts.add(importproductList.get(0).getMainUsedMaterial());
        }
        return new Object[]{mainMaterialInfoDTOs,usedProducts};
    }

    private Map<Long,Double> mapProductQuality(List<Productquality> productqualities){
        Map<Long,Double> productqualityMap = new HashMap<Long, Double>();
        for(Productquality productquality : productqualities){
            productqualityMap.put(productquality.getQuality().getQualityID(),productquality.getQuantity1());
        }
        return productqualityMap;
    }

    @RequestMapping("/whm/viewbyplan/importproduct.html")
    public ModelAndView viewExportProductByPlan(@ModelAttribute(Constants.FORM_MODEL_KEY) ImportproductbillBean bean, BindingResult bindingResult) {
        ModelAndView mav = new ModelAndView("/whm/viewbyplan/importproduct");

        if(!bindingResult.hasErrors() && bean.getProductionPlanID() != null){
            try {
                ProductionPlan plan = this.productionPlanService.findByIdNoCommit(bean.getProductionPlanID());
                List<Importproduct> importproducts = this.importproductService.findImportByPlan(bean.getProductionPlanID(),Constants.PRODUCT_GROUP_PRODUCED);
                Object[] objects = prepare2Display(importproducts);
                List<MainMaterialInfoDTO> mainMaterialInfoDTOs = (List<MainMaterialInfoDTO>) objects[0];
                List<Importproduct> usedProducts = (List<Importproduct>) objects[1];
                mav.addObject("mainUsedMaterials", mainMaterialInfoDTOs);
                mav.addObject("plan", plan);
                List<Importproduct> importBackProducts = this.importproductService.findImportByPlan(bean.getProductionPlanID(),Constants.PRODUCT_GROUP_IMPORT_BACK);
                if(importBackProducts != null && importBackProducts.size() >0){
                    mav.addObject("importBackProducts", importBackProducts);
                }
            }
            catch (Exception e) {
                logger.error("Could not found item " + bean.getProductionPlanID(), e);
            }
        }
        mav.addObject(Constants.FORM_MODEL_KEY, bean);
        mav.addObject("qualities", qualityService.findAll());
        return mav;
    }

    @RequestMapping("/whm/importproductbill/reimport.html")
    public ModelAndView taiNhapTonThanhPham(@ModelAttribute(Constants.FORM_MODEL_KEY) ImportproductbillBean bean, BindingResult bindingResult) {
        ModelAndView mav = new ModelAndView("/whm/importproductbill/reimportnew");

        String crudaction = bean.getCrudaction();
        Importproductbill pojo = bean.getPojo();
        Warehouse warehouse = new Warehouse();
        warehouse.setWarehouseID(SecurityUtils.getPrincipal().getWarehouseID());
        pojo.setWarehouse(warehouse);
        bean.setLoginID(SecurityUtils.getLoginUserId());
        bean.setLoginWarehouseID(SecurityUtils.getPrincipal().getWarehouseID());
        boolean isUpdate = false;
        boolean isError = false;
        if(StringUtils.isNotBlank(crudaction) && crudaction.equals("insert-update")) {
            try {
                if(!bindingResult.hasErrors()) {

                    if(pojo.getImportProductBillID() != null && pojo.getImportProductBillID() > 0) {
                        isUpdate = true;
                        if(bean.getPojo().getNote() == null || !StringUtils.isNotBlank(bean.getPojo().getNote()))
                            bean.getPojo().setNote(this.getMessageSourceAccessor().getMessage("msg.update"));
                        this.importproductbillService.updateReImportProuduct(bean);
                        mav = new ModelAndView("redirect:/whm/importproductbill/reimportlist.html?isUpdate=true");
                    } else {
                        isUpdate = false;
                        if(bean.getPojo().getNote() == null || !StringUtils.isNotBlank(bean.getPojo().getNote()))
                            bean.getPojo().setNote(this.getMessageSourceAccessor().getMessage("msg.create"));
                        this.importproductbillService.saveReImportProduct(bean);
                        mav = new ModelAndView("redirect:/whm/importproductbill/reimportlist.html?isAdd=true");
                    }
                    return mav;
                }
            }catch(Exception e) {
                isError = true;
                logger.error(e.getMessage(),e);
                mav.addObject("alertType", "error");
                mav.addObject("messageResponse", e.getMessage().indexOf("ConstraintViolationException") > -1 ? this.getMessageSourceAccessor().getMessage("duplicate.product.code.exception") : e.getMessage());
                prepareReImportDataToEdit(mav, bean, isUpdate);
            }
        }
        if(!isError){
            if(!bindingResult.hasErrors() && bean.getPojo().getImportProductBillID() != null &&bean.getPojo().getImportProductBillID() > 0){
                try {
                    Importproductbill itemObj = this.importproductbillService.findById(pojo.getImportProductBillID());
                    bean.setPojo(itemObj);
                    setEditable(bean.getPojo());
                    mav.addObject("importProducts", itemObj.getImportproducts());
                }
                catch (Exception e) {
                    logger.error("Could not found item " + bean.getPojo().getImportProductBillID(), e);
                }
            }else{
                if(bean.getPojo().getCode() == null){
                    bean.getPojo().setCode(GeneratorUtils.generatePTNTCode());
                }
            }
        }
        addData2Model(mav,bean);
        mav.addObject(Constants.FORM_MODEL_KEY, bean);
        return mav;
    }

    private void prepareReImportDataToEdit(ModelAndView mav, ImportproductbillBean bean, boolean isUpdate) {
        if(!isUpdate){
            bean.getPojo().setImportProductBillID(null);
        }
        bean.getPojo().setEditable(Boolean.TRUE);
        bean.getPojo().setImportproducts(bean.getReImportProducts());
    }

    @RequestMapping(value={"/whm/importproductbill/reimportlist.html"})
    public ModelAndView danhSachTaiNhapThanhPham(@ModelAttribute(Constants.LIST_MODEL_KEY) ImportproductbillBean bean,HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("/whm/importproductbill/reimportlist");
        if(bean.getToDate() != null){
            bean.setToDate(DateUtils.move2TheEndOfDay(new Timestamp(bean.getToDate().getTime())));
        }
        if(StringUtils.isNotBlank(bean.getCrudaction()) && bean.getCrudaction().equals(Constants.ACTION_DELETE)) {
            Integer totalDeleted = 0;
            try {
                totalDeleted = importproductbillService.deleteItems(bean.getCheckList());
                mav.addObject("totalDeleted", totalDeleted);
            }catch (Exception e) {
                log.error(e.getMessage(), e);
                mav.addObject("alertType","error");
                mav.addObject(Constants.MESSAGE_RESPONSE_MODEL_KEY, this.getMessageSourceAccessor().getMessage("database.multipledelete.exception"));
            }
        }
        bean.setIsBlackProduct(Boolean.FALSE);
        bean.setReImport(Boolean.TRUE);
        executeSearch(bean, request);
        mav.addObject(Constants.LIST_MODEL_KEY, bean);
        addData2Model(mav,bean);
        showAlert(mav,bean.getIsAdd(),bean.getIsUpdate(),bean.getIsError());
        return mav;
    }

    @RequestMapping("/whm/importproductbill/reimportview.html")
    public ModelAndView viewReImportProduct(@ModelAttribute(Constants.FORM_MODEL_KEY) ImportproductbillBean bean, BindingResult bindingResult) {
        ModelAndView mav = new ModelAndView("/whm/importproductbill/reimportview");

        String crudaction = bean.getCrudaction();
        Importproductbill pojo = bean.getPojo();
        bean.setLoginID(SecurityUtils.getLoginUserId());
        if (StringUtils.isNotBlank(crudaction) && crudaction.equals("reject")){
            try {
                if(!bindingResult.hasErrors()) {
                    if(pojo.getImportProductBillID() != null && pojo.getImportProductBillID() > 0) {
                        if(bean.getPojo().getNote() == null || !StringUtils.isNotBlank(bean.getPojo().getNote()))
                            bean.getPojo().setNote(this.getMessageSourceAccessor().getMessage("msg.reject"));
                        this.importproductbillService.updateReject(bean.getPojo().getNote(),bean.getPojo().getImportProductBillID(),SecurityUtils.getLoginUserId());
                        mav = new ModelAndView("redirect:/whm/importproductbill/reimportlist.html?isUpdate=true");
                    }
                    return mav;
                }
            }catch(Exception e) {
                logger.error(e.getMessage(),e);
                mav.addObject("alertType", "error");
                mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("general.exception.msg"));
                mav = new ModelAndView("redirect:/whm/importproductbill/reimportlist.html?isError=true");
            }
        }else if (StringUtils.isNotBlank(crudaction) && crudaction.equals("insert-update")){
            try {
                if(!bindingResult.hasErrors()) {
                    if(pojo.getImportProductBillID() != null && pojo.getImportProductBillID() > 0) {
                        if(bean.getPojo().getNote() == null || !StringUtils.isNotBlank(bean.getPojo().getNote()))
                            bean.getPojo().setNote(this.getMessageSourceAccessor().getMessage("msg.approve"));
                        this.importproductbillService.updateConfirm(bean);
                        mav = new ModelAndView("redirect:/whm/importproductbill/reimportlist.html?isUpdate=true");
                    }
                    return mav;
                }
            }catch(Exception e) {
                logger.error(e.getMessage(),e);
                mav.addObject("alertType", "error");
                mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("general.exception.msg"));
                mav = new ModelAndView("redirect:/whm/importproductbill/reimportlist.html?isError=true");
            }
        }
//        else if (StringUtils.isNotBlank(crudaction) && crudaction.equals("update-money")){
//            try {
//                if(!bindingResult.hasErrors()) {
//                    if(pojo.getImportProductBillID() != null && pojo.getImportProductBillID() > 0) {
//                        if(bean.getPojo().getNote() == null || !StringUtils.isNotBlank(bean.getPojo().getNote()))
//                            bean.getPojo().setNote(this.getMessageSourceAccessor().getMessage("msg.approve.money"));
//                        this.importproductbillService.updateConfirmMoney(bean);
//                        mav = new ModelAndView("redirect:/whm/importrootmaterialbill/list.html?isUpdate=true");
//                    }
//                    return mav;
//                }
//            }catch(Exception e) {
//                logger.error(e.getMessage(),e);
//                mav.addObject("alertType", "error");
//                mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("general.exception.msg"));
//                mav = new ModelAndView("redirect:/whm/importproductbill/list.html?isError=true");
//            }
//        }
        if(!bindingResult.hasErrors() && bean.getPojo().getImportProductBillID() != null &&bean.getPojo().getImportProductBillID() > 0){
            try {
                Importproductbill itemObj = this.importproductbillService.findById(pojo.getImportProductBillID());
                bean.setPojo(itemObj);
                mav.addObject("importProducts", itemObj.getImportproducts());
            }
            catch (Exception e) {
                logger.error("Could not found item " + bean.getPojo().getImportProductBillID(), e);
            }
        }
        mav.addObject(Constants.FORM_MODEL_KEY, bean);
        return mav;
    }

    @RequestMapping("/ajax/exportReImport.html")
    public ModelAndView exportReImport(@RequestParam(value = "importProductBillID", required = true) Long importProductBillID,
                               HttpServletRequest request, HttpServletResponse response){

        try {
            Importproductbill itemObj = this.importproductbillService.findById(importProductBillID);
            exportReImportProduct2Excel(itemObj , request, response);
        }
        catch (Exception e) {
            logger.error("Could not found item " + importProductBillID, e);
        }
        return null;
    }

    private void exportReImportProduct2Excel(Importproductbill itemObj, HttpServletRequest request, HttpServletResponse response) {
        try{
            String outputFileName = "/files/temp/TonNgoaiSanXuat" + System.currentTimeMillis() + ".xls";
            String reportTemplate = request.getSession().getServletContext().getRealPath("/files/export/TonNgoaiSanXuat.xls");
            String export2FileName = request.getSession().getServletContext().getRealPath(outputFileName);

            Workbook templateWorkbook = Workbook.getWorkbook(new File(reportTemplate));
            WritableWorkbook workbook = Workbook.createWorkbook(new File(export2FileName), templateWorkbook);

            WritableSheet sheet = workbook.getSheet(0);

            WritableFont normalFont = new WritableFont(WritableFont.TIMES, 12,
                    WritableFont.NO_BOLD, false,
                    UnderlineStyle.NO_UNDERLINE,
                    Colour.BLACK);
            WritableCellFormat normalFormat = new WritableCellFormat(normalFont);
            normalFormat.setAlignment(Alignment.CENTRE);
            normalFormat.setWrap(true);
            normalFormat.setBorder(jxl.format.Border.ALL, jxl.format.BorderLineStyle.THIN);
            DecimalFormat decimalFormat = new DecimalFormat("###,###");


            WritableCellFormat infoFormat = new WritableCellFormat(normalFont);
            infoFormat.setAlignment(Alignment.LEFT);
            infoFormat.setWrap(false);
            String cusName = "";
            if(itemObj.getCustomer() != null){
                cusName = itemObj.getCustomer().getName();
                if(itemObj.getCustomer().getProvince() != null){
                    cusName += " - " + itemObj.getCustomer().getProvince().getName();
                }
            }

            sheet.addCell(new Label(2,2,itemObj.getCode(),infoFormat));
            sheet.addCell(new Label(2,3,cusName,infoFormat));
            sheet.addCell(new Label(2,4,itemObj.getDescription() != null ? itemObj.getDescription() : "" ,infoFormat));
            sheet.addCell(new Label(6,2,itemObj.getWarehouse().getName(),infoFormat));
            sheet.addCell(new Label(6,3,itemObj.getImportDate() != null ? DateUtils.date2String(itemObj.getImportDate(),"dd/MM/yyyy") : "",infoFormat));

            int startRow = 7;
            int stt = 1;
            String originName;


            Double totalMet = 0d;
            Double totalKg = 0d;

            for(Importproduct importproduct : itemObj.getImportproducts()){
                CellValue[] res = new CellValue[15];
                int i = 0;
                res[i++] = new CellValue(CellDataType.STRING, stt++);
                res[i++] = new CellValue(CellDataType.STRING, importproduct.getProductname().getName());
                res[i++] = new CellValue(CellDataType.STRING, importproduct.getProductCode() != null ? importproduct.getProductCode() : "");
                res[i++] = new CellValue(CellDataType.STRING, importproduct.getSize() != null ? importproduct.getSize().getName() : "");
                res[i++] = new CellValue(CellDataType.STRING, importproduct.getThickness() != null ? importproduct.getThickness().getName() : "");
                res[i++] = new CellValue(CellDataType.STRING, importproduct.getStiffness() != null ? importproduct.getStiffness().getName() : "");
                res[i++] = new CellValue(CellDataType.STRING, importproduct.getColour() != null ? importproduct.getColour().getName() : "");
                res[i++] = new CellValue(CellDataType.STRING, importproduct.getOverlaytype() != null ? importproduct.getOverlaytype().getName() : "");
                originName = "";
                if(importproduct.getOrigin() != null){
                    originName = importproduct.getOrigin().getName();
                }else if(importproduct.getMainUsedMaterial() != null && importproduct.getMainUsedMaterial().getOrigin() != null){
                    originName = importproduct.getMainUsedMaterial().getOrigin().getName();
                }else if(importproduct.getMainUsedMaterial() != null && importproduct.getMainUsedMaterial().getMainUsedMaterial() != null && importproduct.getMainUsedMaterial().getMainUsedMaterial().getOrigin() != null){
                    originName = importproduct.getMainUsedMaterial().getMainUsedMaterial().getOrigin().getName();
                }
                res[i++] = new CellValue(CellDataType.STRING, originName);
                res[i++] = new CellValue(CellDataType.STRING, importproduct.getMarket() != null ? importproduct.getMarket().getName() : "");
                res[i++] = new CellValue(CellDataType.STRING, importproduct.getWarehouse() != null ? importproduct.getWarehouse().getName() : "");
                res[i++] = new CellValue(CellDataType.STRING, importproduct.getImportDate() != null ? DateUtils.date2String(importproduct.getImportDate(),"dd/MM/yyyy") : (importproduct.getProduceDate() != null ? DateUtils.date2String(importproduct.getProduceDate(),"dd/MM/yyyy") : ""));
                res[i++] = new CellValue(CellDataType.STRING, importproduct.getQuantity1() != null ? decimalFormat.format(importproduct.getQuantity1())  : "");
                res[i++] = new CellValue(CellDataType.STRING, importproduct.getQuantity2Pure() != null ? decimalFormat.format(importproduct.getQuantity2Pure())  : "");
                res[i++] = new CellValue(CellDataType.STRING, importproduct.getNote() != null ? importproduct.getNote() : "");
                ExcelUtil.addRow(sheet,startRow++,res,normalFormat,normalFormat,normalFormat,normalFormat);
                if(importproduct.getQuantity1() != null){
                    totalMet += importproduct.getQuantity1();
                }
                if(importproduct.getQuantity2Pure() != null){
                    totalKg += importproduct.getQuantity2Pure();
                }
            }

            WritableFont boldFont = new WritableFont(WritableFont.TIMES, 12,
                    WritableFont.BOLD, false,
                    UnderlineStyle.NO_UNDERLINE,
                    Colour.BLACK);
            WritableCellFormat boldCenterFormat = new WritableCellFormat(boldFont);
            boldCenterFormat.setWrap(true);
            boldCenterFormat.setAlignment(Alignment.CENTRE);
            boldCenterFormat.setBorder(jxl.format.Border.ALL, jxl.format.BorderLineStyle.THIN);

            Label tong = new Label(0,startRow,"Tổng: " + itemObj.getImportproducts().size() + " cuộn",boldCenterFormat);
            sheet.addCell(tong);
            sheet.mergeCells(0,startRow,3,startRow);

            Label blank = new Label(4,startRow,"",boldCenterFormat);
            sheet.addCell(blank);
            sheet.mergeCells(4,startRow,11,startRow);
            String sMet = totalMet != null && totalMet > 0 ? decimalFormat.format(totalMet)  : "";
            Label met = new Label(12,startRow,sMet,boldCenterFormat);
            sheet.addCell(met);
            String sKg = totalKg != null ? decimalFormat.format(totalKg)  : "";
            Label kg = new Label(13,startRow,sKg,boldCenterFormat);
            sheet.addCell(kg);
            Label note = new Label(14,startRow,"",boldCenterFormat);
            sheet.addCell(note);
            workbook.write();
            workbook.close();
            response.sendRedirect(request.getSession().getServletContext().getContextPath() + outputFileName);
        }
        catch(Exception ex){
            logger.error(ex.getMessage(), ex);
        }
    }


    @RequestMapping(value="/ajax/getOriginalProduct.html")
    public void getAvailableBlackProduct(@RequestParam(value = "code", required = true) String code, HttpServletResponse response)  {

        try{
            JSONObject obj = new JSONObject();
            PrintWriter out = response.getWriter();
            response.setContentType("text/json; charset=UTF-8");
            if(StringUtils.isNotBlank(code)) {
                Importproduct importproduct = null;
                try {
                    importproduct = this.importproductService.findEqualUnique("productCode", code);
                } catch (Exception e) {
                    log.error(e.getMessage(), e);
                }
                if(importproduct != null){
                    obj.put("originalID",importproduct.getImportProductID());
                }else {
                    obj.put("error","error");
                }
            }
            out.print(obj);
            out.flush();
            out.close();
        }catch (Exception e) {
            log.error(e.getMessage(), e);
        }
    }

    @RequestMapping("/ajax/getOriginalProductNew.html")
    public ModelAndView getOriginalProductNew(@RequestParam(value = "code", required = true) String code,
                                                  @RequestParam(value = "counter", required = true) String counter,
                                                  HttpServletResponse response){
        ModelAndView mav = new ModelAndView("/whm/importproductbill/productTable");
        mav.addObject("counterSP", counter);
        addData2Model(mav, null);
        if(StringUtils.isNotBlank(code)) {
            Importproduct importproduct = null;
            try {
                importproduct = this.importproductService.findEqualUnique("productCode", code);
            } catch (Exception e) {
                log.error(e.getMessage(), e);
            }
            if(importproduct != null){
                mav.addObject("product", importproduct);
            }else {
                mav = null;
            }
        }
        return mav;
    }

    @RequestMapping(value = "/ajax/importproductbill/checkCodes.html")
    public void checkCodes(@RequestParam(value = "codes", required = true) String[] codes, HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/json; charset=UTF-8");
        PrintWriter out = response.getWriter();
        JSONObject obj = new JSONObject();
        String errorCode = "";
        if(codes != null && codes.length > 0) {
            try {
                List<String> productCodes = new ArrayList<String>();
                for(String code : codes) {
                    productCodes.add(code);
                }
                List<Importproduct> importproducts = this.importproductService.findByCodes(productCodes);
                if(importproducts != null & importproducts.size() > 0){
                    StringBuffer buffer = new StringBuffer();
                   for(int i = 0; i < importproducts.size(); i++){
                       String date = DateUtils.date2String(importproducts.get(i).getProduceDate() != null ? importproducts.get(i).getProduceDate() : importproducts.get(i).getImportDate(), "dd/MM/yyy");
                       if(i != 0){
                           buffer.append(", ").append(importproducts.get(i).getProductCode()).append(" - ").append(date);
                       }else {
                           buffer.append(importproducts.get(i).getProductCode()).append(" - ").append(date);
                       }
                   }
                   errorCode = buffer.toString();
                }
                obj.put("codeInfo", errorCode);
            } catch (Exception e) {
                log.error(e.getMessage(), e);
            }  finally {
                out.print(obj);
                out.flush();
                out.close();
            }
        }

    }

    @RequestMapping(value={"/whm/product/list.html"})
    public ModelAndView list(SearchProductBean bean,HttpServletRequest request,HttpServletResponse response) {
        ModelAndView mav = new ModelAndView("/whm/product/list");
        bean.setLoginWarehouseID(SecurityUtils.getPrincipal().getWarehouseID());
        if(bean.getToImportedDate() != null){
            bean.setToImportedDate(DateUtils.move2TheEndOfDay(new Timestamp(bean.getToImportedDate().getTime())));
        }
        bean.setEditInfo(Boolean.TRUE);
        executeSearchProduct(bean, request);
        addData2ModelProduct(mav);
        mav.addObject(Constants.LIST_MODEL_KEY, bean);
        showAlert(mav,bean.getIsAdd(),bean.getIsUpdate(),bean.getIsError());
        return mav;
    }

    private void executeSearchProduct(SearchProductBean bean, HttpServletRequest request) {
        RequestUtil.initSearchBean(request, bean);
        Object[] results = this.importProductService.searchProductsInStock(bean);
        bean.setListResult((List<Importproduct>)results[1]);
        bean.setTotalItems(Integer.valueOf(results[0].toString()));
        bean.setTotalKg((Double)results[3]);
        bean.setTotalMet((Double)results[2]);
    }

    private void addData2ModelProduct(ModelAndView mav){
        List<Warehouse> warehouses = new ArrayList<Warehouse>();
        List<WarehouseMap> warehouseMaps = new ArrayList<WarehouseMap>();
        if(SecurityUtils.getPrincipal().getWarehouseID()!=null){
            Warehouse warehouse = this.warehouseService.findByIdNoCommit(SecurityUtils.getPrincipal().getWarehouseID());
            warehouses.add(warehouse);
            warehouseMaps = this.warehouseMapService.findByWarehouseID(SecurityUtils.getPrincipal().getWarehouseID());
        }else{
            warehouses = this.warehouseService.findByStatus(Constants.TPK_USER_ACTIVE);
        }
        mav.addObject("warehouseMaps", warehouseMaps);
        mav.addObject("warehouses", warehouses);
        mav.addObject("productNames", this.productnameService.findAll());
        mav.addObject("sizes", this.sizeService.findAll());
        mav.addObject("thicknesses", this.thicknessService.findAll());
        mav.addObject("stiffnesses", this.stiffnessService.findAll());
        mav.addObject("colours", this.colourService.findAll());
        mav.addObject("overlayTypes", this.overlaytypeService.findAll());
        mav.addObject("origins", this.originService.findAll());
        mav.addObject("markets", this.marketService.findAll());
        mav.addObject("qualities", this.qualityService.findAll());

    }

    @RequestMapping("/whm/product/edit.html")
    public ModelAndView editProduct(@ModelAttribute(Constants.FORM_MODEL_KEY) ImportproductbillBean bean, BindingResult bindingResult) {
        ModelAndView mav = new ModelAndView("/whm/product/edit");
        String crudaction = bean.getCrudaction();
        if(StringUtils.isNotBlank(crudaction) && crudaction.equals("insert-update")) {
            try {
                if(!bindingResult.hasErrors()) {

                    if(bean.getProductInfo() != null && bean.getProductInfo().getItemID() != null &&  bean.getProductInfo().getItemID() > 0) {
                        Importproduct importproduct =  this.importproductbillService.updateProductInfo(bean.getProductInfo(), SecurityUtils.getLoginUserId());
                        mav = new ModelAndView("redirect:/whm/product/list.html?isUpdate=true&code=" + importproduct.getProductCode());
                    }
                    return mav;
                }
            }catch(Exception e) {
                logger.error(e.getMessage(),e);
                mav.addObject("alertType", "error");
                mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("general.exception.msg"));
                mav = new ModelAndView("redirect:/whm/importproductbill/reimportlist.html?isError=true");
                return mav;
            }
        }
        if(!bindingResult.hasErrors() && bean.getProductInfo() != null && bean.getProductInfo().getItemID() != null && bean.getProductInfo().getItemID() > 0){
            try {
                Importproduct importProduct = this.importproductService.findByIdNoCommit(bean.getProductInfo().getItemID());
                if(importProduct.getProductqualitys() != null){
                    importProduct.setQualityQuantityMap(WebCommonUtils.mapProductQuality(importProduct.getProductqualitys()));
                }
                mav.addObject("product", importProduct);
            }
            catch (Exception e) {
                logger.error("Could not found item " + bean.getProductInfo().getItemID(), e);
            }
        }
        addData2ModelProduct(mav);
        mav.addObject(Constants.FORM_MODEL_KEY, bean);
        return mav;
    }

    @RequestMapping("/whm/importrootmaterialbill/mergeView.html")
    public ModelAndView viewMergeBills(@ModelAttribute(Constants.FORM_MODEL_KEY) ImportproductbillBean bean, BindingResult bindingResult,
                                       HttpServletRequest request,HttpServletResponse response) {
        ModelAndView mav = new ModelAndView("/whm/importrootmaterialbill/mergeview");
        String crudaction = bean.getCrudaction();


        if (StringUtils.isNotBlank(crudaction) && crudaction.equals("insert-update")){
            try {
                this.importproductbillService.updateMergeBills(bean);
                mav = new ModelAndView("redirect:/whm/importrootmaterialbill/list.html?isUpdate=true");
                return mav;
            }catch(Exception e) {
                logger.error(e.getMessage(),e);
                addDateToMergeView(mav,bean);
                mav.addObject("alertType", "error");
                mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("general.exception.msg"));
            }
        }else{
            addDateToMergeView(mav, bean);
        }

        mav.addObject("markets", this.marketService.findAll());
        mav.addObject(Constants.FORM_MODEL_KEY, bean);
        return mav;
    }

    private void addDateToMergeView(ModelAndView mav, ImportproductbillBean bean) {
        List<Importproductbill> importproductbills = this.importproductbillService.findByIds(bean.getBillIDs());
        mav.addObject("importproductbills", importproductbills);
        mav.addObject("customer", importproductbills.get(0).getCustomer());
        mav.addObject("marketID", importproductbills.get(0).getMarket() != null ? importproductbills.get(0).getMarket().getMarketID() : 0l);
        mav.addObject("importDate", importproductbills.get(0).getImportDate());
        mav.addObject("code", importproductbills.get(0).getCode());
        mav.addObject("warehouse", importproductbills.get(0).getWarehouse());
        mav.addObject("warehouseMap", importproductbills.get(0).getWarehouseMap());
        mav.addObject("description", importproductbills.get(0).getDescription());
    }

}
