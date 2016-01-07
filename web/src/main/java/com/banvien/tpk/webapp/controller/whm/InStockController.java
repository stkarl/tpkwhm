package com.banvien.tpk.webapp.controller.whm;

import com.banvien.tpk.core.Constants;
import com.banvien.tpk.core.domain.*;
import com.banvien.tpk.core.dto.SearchMaterialBean;
import com.banvien.tpk.core.dto.SearchProductBean;
import com.banvien.tpk.core.exception.ObjectNotFoundException;
import com.banvien.tpk.core.service.*;
import com.banvien.tpk.security.SecurityUtils;
import com.banvien.tpk.webapp.dto.CellDataType;
import com.banvien.tpk.webapp.dto.CellValue;
import com.banvien.tpk.webapp.editor.CustomDateEditor;
import com.banvien.tpk.webapp.util.DateUtils;
import com.banvien.tpk.webapp.util.ExcelUtil;
import com.banvien.tpk.webapp.util.RequestUtil;
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
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.PrintWriter;
import java.lang.Boolean;
import java.sql.Timestamp;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

@Controller
public class InStockController extends ApplicationObjectSupport {
    private transient final Log log = LogFactory.getLog(getClass());

    @Autowired
    private ImportproductService importProductService;

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
    private StiffnessService stiffnessService;

    @Autowired
    private OverlaytypeService overlaytypeService;

    @Autowired
    private MaterialService materialService;

    @Autowired
    private MaterialcategoryService materialcategoryService;

    @Autowired
    private ImportmaterialService importMaterialService;

    @Autowired
    private CustomerService customerService;

    @Autowired
    private BookProductBillService bookProductBillService;

    @Autowired
    private UserService userService;

    @Autowired
    private WarehouseMapService warehouseMapService;

    @Autowired
    private QualityService qualityService;

    @Autowired
    private OweLogService oweLogService;

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        binder.registerCustomEditor(Date.class, new CustomDateEditor("dd/MM/yyyy"));
    }

    @RequestMapping(value={"/whm/report/instock/product.html"})
    public ModelAndView list(SearchProductBean bean,HttpServletRequest request,HttpServletResponse response) {
        ModelAndView mav = new ModelAndView("/whm/instock/product");
        bean.setLoginWarehouseID(SecurityUtils.getPrincipal().getWarehouseID());
        if(bean.getToImportedDate() != null){
            bean.setToImportedDate(DateUtils.move2TheEndOfDay(new Timestamp(bean.getToImportedDate().getTime())));
        }
        if(bean.getCrudaction() != null && "export".equals(bean.getCrudaction())){
            bean.setMaxPageItems(Integer.MAX_VALUE);
        }
        bean.setViewInStock(Boolean.TRUE);
        try {
            executeSearchProduct(bean, request);
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
        }
        if(bean.getCrudaction() != null && "export".equals(bean.getCrudaction())){
            exportInStockProduct2Excel(bean, request, response);
        }
        addData2ModelProduct(mav);
        mav.addObject(Constants.LIST_MODEL_KEY, bean);
        return mav;
    }

    @RequestMapping(value={"/whm/instock/location/product.html"})
    public ModelAndView changeProductLocation(SearchProductBean bean,HttpServletRequest request,HttpServletResponse response) {
        ModelAndView mav = new ModelAndView("/whm/instock/productlocation");
        bean.setLoginWarehouseID(SecurityUtils.getPrincipal().getWarehouseID());
        if(bean.getToImportedDate() != null){
            bean.setToImportedDate(DateUtils.move2TheEndOfDay(new Timestamp(bean.getToImportedDate().getTime())));
        }
        try {
            executeSearchProduct(bean, request);
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
        }
        try {
            if(bean.getCrudaction() != null && "location".equals(bean.getCrudaction())){
                this.importProductService.updateProductLocation(bean.getSuggestedItems(),SecurityUtils.getLoginUserId());
                mav.addObject("alertType","success");
                mav.addObject("messageResponse",this.getMessageSourceAccessor().getMessage("change.location.completed"));
            }
        } catch (Exception e) {
            mav.addObject("alertType", "error");
            mav.addObject("messageResponse",this.getMessageSourceAccessor().getMessage("error.occur"));
        }
        addData2ModelProduct(mav);
        mav.addObject(Constants.LIST_MODEL_KEY, bean);
        return mav;
    }

    private void exportInStockProduct2Excel(SearchProductBean bean, HttpServletRequest request, HttpServletResponse response) {
        try{
            String outputFileName = "/files/temp/TonTonKho" + System.currentTimeMillis() + ".xls";
            String reportTemplate = request.getSession().getServletContext().getRealPath("/files/export/TonTonKho.xls");
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
            int startRow = 3;
            int stt = 1;
            String originName;
            for(Importproduct importproduct : bean.getListResult()){
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
            }

            WritableFont boldFont = new WritableFont(WritableFont.TIMES, 12,
                    WritableFont.BOLD, false,
                    UnderlineStyle.NO_UNDERLINE,
                    Colour.BLACK);
            WritableCellFormat boldCenterFormat = new WritableCellFormat(boldFont);
            boldCenterFormat.setWrap(true);
            boldCenterFormat.setAlignment(Alignment.CENTRE);
            boldCenterFormat.setBorder(jxl.format.Border.ALL, jxl.format.BorderLineStyle.THIN);

            Label tong = new Label(0,startRow,"Tổng: " + bean.getListResult().size() + " cuộn",boldCenterFormat);
            sheet.addCell(tong);
            sheet.mergeCells(0,startRow,3,startRow);

            Label blank = new Label(4,startRow,"",boldCenterFormat);
            sheet.addCell(blank);
            sheet.mergeCells(4,startRow,11,startRow);
            String sMet = bean.getTotalMet() != null && bean.getTotalMet() > 0 ? decimalFormat.format(bean.getTotalMet())  : "";
            Label met = new Label(12,startRow,sMet,boldCenterFormat);
            sheet.addCell(met);
            String sKg = bean.getTotalKg() != null ? decimalFormat.format(bean.getTotalKg())  : "";
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

    private void executeSearchProduct(SearchProductBean bean, HttpServletRequest request) {
        RequestUtil.initSearchBean(request, bean);
        Object[] results = this.importProductService.searchProductsInStock(bean);
        bean.setListResult((List<Importproduct>)results[1]);
        bean.setTotalItems(Integer.valueOf(results[0].toString()));
        bean.setTotalKg((Double)results[3]);
        bean.setTotalMet((Double)results[2]);
    }


    @RequestMapping(value={"/whm/instock/suggestprice.html"})
    public ModelAndView suggestPriceList(SearchProductBean bean,HttpServletRequest request,HttpServletResponse response) {
        ModelAndView mav = new ModelAndView("/whm/instock/suggestprice");
        bean.setLoginWarehouseID(SecurityUtils.getPrincipal().getWarehouseID());
        if(bean.getToImportedDate() != null){
            bean.setToImportedDate(DateUtils.move2TheEndOfDay(new Timestamp(bean.getToImportedDate().getTime())));
        }
        bean.setSuggestPrice(Boolean.TRUE);
        String crudaction = bean.getCrudaction();
        if(crudaction != null && StringUtils.isNotBlank(crudaction) && crudaction.equals("suggest")){
            this.importProductService.updateSuggestPrice(bean.getSuggestedItems(), SecurityUtils.getLoginUserId());
        }
        executeSearchProduct(bean, request);
        addData2ModelProduct(mav);
        mav.addObject(Constants.LIST_MODEL_KEY, bean);
        return mav;
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

    @RequestMapping(value={"/whm/report/instock/material.html"})
    public ModelAndView list(SearchMaterialBean bean,HttpServletRequest request, HttpServletResponse response) {
        ModelAndView mav = new ModelAndView("/whm/instock/material");
        bean.setLoginWarehouseID(SecurityUtils.getPrincipal().getWarehouseID());
        if(bean.getToImportedDate() != null){
            bean.setToImportedDate(DateUtils.move2TheEndOfDay(new Timestamp(bean.getToImportedDate().getTime())));
        }
        if(bean.getCrudaction() != null && "export".equals(bean.getCrudaction())){
            bean.setMaxPageItems(Integer.MAX_VALUE);
        }
        executeSearchMaterial(bean, request);
        if(bean.getCrudaction() != null && "export".equals(bean.getCrudaction())){
            exportInStockMaterial2Excel(bean,request,response);
        }
        addData2ModelMaterial(mav);
        mav.addObject(Constants.LIST_MODEL_KEY, bean);
        return mav;
    }

    @RequestMapping(value={"/whm/instock/location/material.html"})
    public ModelAndView changeMaterialLocation(SearchMaterialBean bean,HttpServletRequest request, HttpServletResponse response) {
        ModelAndView mav = new ModelAndView("/whm/instock/materiallocation");
        bean.setLoginWarehouseID(SecurityUtils.getPrincipal().getWarehouseID());
        if(bean.getToImportedDate() != null){
            bean.setToImportedDate(DateUtils.move2TheEndOfDay(new Timestamp(bean.getToImportedDate().getTime())));
        }
        executeSearchMaterial(bean, request);
        try {
            if(bean.getCrudaction() != null && "location".equals(bean.getCrudaction())){
                this.importMaterialService.updateMaterialLocation(bean.getSelectedItems(),SecurityUtils.getLoginUserId());
                mav.addObject("alertType","success");
                mav.addObject("messageResponse",this.getMessageSourceAccessor().getMessage("change.location.completed"));
            }
        } catch (Exception e) {
            mav.addObject("alertType", "error");
            mav.addObject("messageResponse",this.getMessageSourceAccessor().getMessage("error.occur"));
        }

        addData2ModelMaterial(mav);
        mav.addObject(Constants.LIST_MODEL_KEY, bean);
        return mav;
    }

    private void exportInStockMaterial2Excel(SearchMaterialBean bean, HttpServletRequest request, HttpServletResponse response) {
        try{
            String outputFileName = "/files/temp/PhuLieuTonKho" + System.currentTimeMillis() + ".xls";
            String reportTemplate = request.getSession().getServletContext().getRealPath("/files/export/VatTuTonKho.xls");
            String export2FileName = request.getSession().getServletContext().getRealPath(outputFileName);

            Workbook templateWorkbook = Workbook.getWorkbook(new File(reportTemplate));
            WritableWorkbook workbook = Workbook.createWorkbook(new File(export2FileName), templateWorkbook);

            WritableSheet sheet = workbook.getSheet(0);

            WritableFont normalFont = new WritableFont(WritableFont.TIMES, 12,
                    WritableFont.NO_BOLD, false,
                    UnderlineStyle.NO_UNDERLINE,
                    Colour.BLACK);
            WritableCellFormat normalFormat = new WritableCellFormat(normalFont);
            normalFormat.setBorder(jxl.format.Border.ALL, jxl.format.BorderLineStyle.THIN);
            normalFormat.setAlignment(Alignment.CENTRE);
            normalFormat.setVerticalAlignment(VerticalAlignment.CENTRE);
            normalFormat.setWrap(true);
            DecimalFormat decimalFormat = new DecimalFormat("###,###");
            int startRow = 3;
            int stt = 1;
            for(Importmaterial importmaterial : bean.getListResult()){
                CellValue[] res = new CellValue[10];
                int i = 0;
                res[i++] = new CellValue(CellDataType.STRING, stt++);
                res[i++] = new CellValue(CellDataType.STRING, importmaterial.getCode() != null ? importmaterial.getCode() : "");
                res[i++] = new CellValue(CellDataType.STRING, importmaterial.getMaterial().getName());
                res[i++] = new CellValue(CellDataType.STRING, importmaterial.getMaterial().getUnit() != null ? importmaterial.getMaterial().getUnit().getName() : "");
                res[i++] = new CellValue(CellDataType.STRING, importmaterial.getRemainQuantity() != null ? decimalFormat.format(importmaterial.getRemainQuantity())  : "");
                res[i++] = new CellValue(CellDataType.STRING, importmaterial.getWarehouse() != null ? importmaterial.getWarehouse().getName() : "");
                res[i++] = new CellValue(CellDataType.STRING, importmaterial.getImportDate() != null ? DateUtils.date2String(importmaterial.getImportDate(),"dd/MM/yyyy") : "");
                res[i++] = new CellValue(CellDataType.STRING, importmaterial.getExpiredDate() != null ? DateUtils.date2String(importmaterial.getExpiredDate(),"dd/MM/yyyy") : "");
                res[i++] = new CellValue(CellDataType.STRING, importmaterial.getOrigin() != null ? importmaterial.getOrigin().getName() : "");
                res[i++] = new CellValue(CellDataType.STRING, importmaterial.getMarket() != null ? importmaterial.getMarket().getName() : "");
                ExcelUtil.addRow(sheet,startRow++,res,normalFormat,normalFormat,normalFormat,normalFormat);
            }
            workbook.write();
            workbook.close();
            response.sendRedirect(request.getSession().getServletContext().getContextPath() + outputFileName);
        }
        catch(Exception ex){
            logger.error(ex.getMessage(), ex);
        }
    }

    private void executeSearchMaterial(SearchMaterialBean bean, HttpServletRequest request) {
        RequestUtil.initSearchBean(request, bean);
        Object[] results = this.importMaterialService.searchMaterialsInStock(bean);
        bean.setListResult((List<Importmaterial>)results[1]);
        bean.setTotalItems(Integer.valueOf(results[0].toString()));
    }

    private void addData2ModelMaterial(ModelAndView mav){
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
        mav.addObject("materials", this.materialService.findNoneMeasurement());
        mav.addObject("materialCategories", this.materialcategoryService.findAll());
        mav.addObject("warehouseMaps", this.warehouseMapService.findAll());
        mav.addObject("origins", this.originService.findAll());
        mav.addObject("markets", this.marketService.findAll());
    }


    @RequestMapping(value={"/whm/instock/booking.html"})
    public ModelAndView bookingProducts(SearchProductBean bean,HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("/whm/instock/booking");
        try {
            bean.setLoginWarehouseID(SecurityUtils.getPrincipal().getWarehouseID());
            if(bean.getToImportedDate() != null){
                bean.setToImportedDate(DateUtils.move2TheEndOfDay(new Timestamp(bean.getToImportedDate().getTime())));
            }
            bean.setBooking(Boolean.TRUE);
            String crudaction = bean.getCrudaction();
            if(crudaction != null && StringUtils.isNotBlank(crudaction) && crudaction.equals("booking") && bean.getBookProductBillID() != null){
                String codes = this.bookProductBillService.saveOrUpdateBookingBill(bean.getBookedProductIDs(), SecurityUtils.getLoginUserId(), bean.getBookProductBillID());
                mav.addObject("alertType","success");
                if(StringUtils.isNotBlank(codes)){
                    mav.addObject("messageResponse",this.getMessageSourceAccessor().getMessage("booking.product.partial.completed", new String[] {codes}));
                }else{
                    mav.addObject("messageResponse",this.getMessageSourceAccessor().getMessage("booking.product.completed") );
                }
            }
            executeSearchProduct4Book(bean, request);
            if(bean.getBookProductBillID() != null){
                BookProductBill bill = this.bookProductBillService.findByIdNoCommit(bean.getBookProductBillID());
                List<OweLog> prePaids = this.oweLogService.findPrePaidByBill(bean.getBookProductBillID());
                bill.setPrePaids(prePaids);
                mav.addObject("bookBill", bill);
                mav.addObject("owe", this.oweLogService.findCustomerOweUtilDate(bill.getCustomer().getCustomerID(), bill.getBillDate()));
            }
            addData2ModelProduct(mav);
            mav.addObject(Constants.LIST_MODEL_KEY, bean);
        } catch (Exception e) {
            log.error(e.getMessage(),e);
            return new ModelAndView("redirect:/whm/booking/list.html?isError=true");
        }
        return mav;
    }

    private void executeSearchProduct4Book(SearchProductBean bean, HttpServletRequest request) {
        RequestUtil.initSearchBean(request, bean);
        Object[] results = this.importProductService.searchProductsInStock(bean);
        bean.setListResult((List<Importproduct>)results[1]);
        bean.setTotalItems(Integer.valueOf(results[0].toString()));
    }

    @RequestMapping(value = "/ajax/customer/verifyLiability.html")
    public void kiemTraCongNo(@RequestParam(value = "customerID", required = true)Long customerID, HttpServletResponse response) throws ObjectNotFoundException {
        try{
            response.setContentType("text/json; charset=UTF-8");
            PrintWriter out = response.getWriter();
            JSONObject obj = new JSONObject();
            Customer customer = null;
            Integer allow = 1;
            if(customerID != null) {
                customer = this.customerService.findById(customerID);
            }
            if(customer != null){
                if(customer.getStatus().equals(Constants.CUSTOMER_WARNING))
                    allow = 0;
            }
            obj.put("allow", allow);
            out.print(obj);
            out.flush();
            out.close();
        }catch (Exception e) {
            log.error(e.getMessage(), e);
        }
    }

    @RequestMapping(value = "/ajax/customer/showDetailLiability.html")
    public ModelAndView showCongNoDetail(@RequestParam(value = "customerID", required = true)Long customerID) throws ObjectNotFoundException {
        ModelAndView mav = new ModelAndView("/whm/customer/liability");
        Customer customer = this.customerService.findByIdNoCommit(customerID);
        mav.addObject("customer", customer);
        return mav;
    }

    @RequestMapping(value = "/ajax/customer/showLiability.html")
    public void showCongNo(@RequestParam(value = "customerID", required = true)Long customerID,
                           @RequestParam(value = "date", required = true)Date date,
                           @RequestParam(value = "bookProductBillID", required = false)Long bookProductBillID,
                           HttpServletResponse response) throws ObjectNotFoundException {
        try{
            response.setContentType("text/json; charset=UTF-8");
            PrintWriter out = response.getWriter();
            JSONObject obj = new JSONObject();
            if(bookProductBillID != null){
                BookProductBill bookProductBill = this.bookProductBillService.findByIdNoCommit(bookProductBillID);
                Calendar calendar = Calendar.getInstance();
                calendar.setTimeInMillis(bookProductBill.getBillDate().getTime());
                date.setHours(calendar.get(Calendar.HOUR_OF_DAY));
                date.setMinutes(calendar.get(Calendar.MINUTE));
            }else{
                date = DateUtils.move2TheEndOfDay(new Timestamp(date.getTime()));
            }
            Double owe = this.oweLogService.findCustomerOweUtilDate(customerID, date);
            obj.put("owe", owe);
            out.print(obj);
            out.flush();
            out.close();
        }catch (Exception e) {
            log.error(e.getMessage(), e);
        }
    }



}
