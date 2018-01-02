package com.banvien.tpk.webapp.controller.whm;

import com.banvien.tpk.core.Constants;
import com.banvien.tpk.core.domain.*;
import com.banvien.tpk.core.dto.BookProductBillBean;
import com.banvien.tpk.core.dto.ExportproductbillBean;
import com.banvien.tpk.core.dto.ItemInfoDTO;
import com.banvien.tpk.core.exception.ObjectNotFoundException;
import com.banvien.tpk.core.service.*;
import com.banvien.tpk.core.util.GeneratorUtils;
import com.banvien.tpk.security.SecurityUtils;
import com.banvien.tpk.webapp.editor.CustomDateEditor;
import com.banvien.tpk.webapp.editor.CustomTimestampEditor;
import com.banvien.tpk.webapp.util.DateUtils;
import com.banvien.tpk.webapp.util.RequestUtil;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.ApplicationObjectSupport;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.util.*;

@Controller
public class BookingController extends ApplicationObjectSupport {
    private transient final Log log = LogFactory.getLog(getClass());

    @Autowired
    private CustomerService customerService;

    @Autowired
    private BookProductBillService bookProductBillService;

    @Autowired
    private UserService userService;

    @Autowired
    private BookProductService bookProductService;

    @Autowired
    private ExportproductbillService exportproductbillService;

    @Autowired
    private ExporttypeService exporttypeService;

    @Autowired
    private OweLogService oweLogService;

    @Autowired
    private SaleReasonService saleReasonService;

    @Autowired
    private ImportproductService importproductService;

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        binder.registerCustomEditor(Date.class, new CustomDateEditor("dd/MM/yyyy"));
        binder.registerCustomEditor(Timestamp.class, new CustomTimestampEditor("dd/MM/yyyy"));
    }

    @RequestMapping(value={"/whm/booking/list.html"})
    public ModelAndView bookingProductsList(BookProductBillBean bean,HttpServletRequest request) throws ObjectNotFoundException {
        ModelAndView mav = new ModelAndView("/whm/booking/list");
        bean.setLoginWarehouseID(SecurityUtils.getPrincipal().getWarehouseID());
        if(bean.getToDate() != null){
            bean.setToDate(DateUtils.move2TheEndOfDay(new Timestamp(bean.getToDate().getTime())));
        }
        bean.setLoginID(SecurityUtils.getLoginUserId());
        String crudaction = bean.getCrudaction();
        if(crudaction != null && StringUtils.isNotBlank(crudaction) && crudaction.equals(Constants.ACTION_DELETE)) {
            Integer totalDeleted = 0;
            try {
                totalDeleted = bookProductBillService.deleteItems(bean.getCheckList());
                mav.addObject("totalDeleted", totalDeleted);
                mav.addObject("alertType","success");
                mav.addObject(Constants.MESSAGE_RESPONSE_MODEL_KEY, this.getMessageSourceAccessor().getMessage("database.deleted.success"));
            }catch (Exception e) {
                log.error(e.getMessage(), e);
                mav.addObject("alertType","error");
                mav.addObject(Constants.MESSAGE_RESPONSE_MODEL_KEY, this.getMessageSourceAccessor().getMessage("database.multipledelete.exception"));
            }
        }
        executeSearchBookList(bean, request);
        addData2Model(mav);
        mav.addObject("users", this.userService.findByRole(Constants.NVKD_ROLE));
        mav.addObject(Constants.LIST_MODEL_KEY, bean);
        showAlert(mav,bean.getIsAdd(),bean.getIsUpdate(),bean.getIsError());
        return mav;
    }

    private void executeSearchBookList(BookProductBillBean bean, HttpServletRequest request) {
        RequestUtil.initSearchBean(request, bean);
        Object[] results = this.bookProductBillService.search(bean);
        bean.setListResult((List<BookProductBill>)results[1]);
        bean.setTotalItems(Integer.valueOf(results[0].toString()));
    }

    private void addData2Model(ModelAndView mav){
        List<Customer> customers;
        if(SecurityUtils.getPrincipal().getRole().equals(Constants.NVKD_ROLE)){
            customers = this.customerService.findByUser(SecurityUtils.getLoginUserId());
        }else {
            customers = this.customerService.findAll();
        }
        mav.addObject("customers",customers);
        mav.addObject("defaultBankAccount", GeneratorUtils.defaultBankAccount);
        mav.addObject("priceTypeC", GeneratorUtils.priceTypeC);
    }

    @RequestMapping("/whm/booking/edit.html")
    public ModelAndView editBooking(@ModelAttribute(Constants.FORM_MODEL_KEY) BookProductBillBean bean, BindingResult bindingResult) {
        ModelAndView mav = new ModelAndView("/whm/booking/edit");
        String crudaction = bean.getCrudaction();
        BookProductBill pojo = bean.getPojo();
        if(StringUtils.isNotBlank(crudaction) && crudaction.equals("insert-update")) {
            try {
                if(!bindingResult.hasErrors()) {
                    if(pojo.getBookProductBillID() != null && pojo.getBookProductBillID() > 0) {
                        if(bean.getPojo().getNote() == null || !StringUtils.isNotBlank(bean.getPojo().getNote()))
                            bean.getPojo().setNote(this.getMessageSourceAccessor().getMessage("msg.update"));
                        Long customerID = null;
                        if(pojo.getCustomer() != null && pojo.getCustomer().getCustomerID() != null && pojo.getCustomer().getCustomerID() > 0){
                            customerID = pojo.getCustomer().getCustomerID();
                        }
                        String des = this.getMessageSourceAccessor().getMessage("booking.product");
                        this.bookProductBillService.updateBookProductBill(pojo.getBookProductBillID(),customerID,SecurityUtils.getLoginUserId(),des);
                        mav = new ModelAndView("redirect:/whm/booking/list.html?isUpdate=true");
                    } 
                    return mav;
                }
            }catch(Exception e) {
                logger.error(e.getMessage(), e);
                mav.addObject("alertType", "error");
                mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("general.exception.msg"));
                mav = new ModelAndView("redirect:/whm/booking/list.html?isError=true");
            }
        }
        if(pojo.getBookProductBillID() != null && pojo.getBookProductBillID() > 0) {
            try {
                BookProductBill dbItem = this.bookProductBillService.findByIdNoCommit(pojo.getBookProductBillID());
                bean.setPojo(dbItem);
            } catch (Exception e) {
                logger.error("Could not found item " + bean.getPojo().getBookProductBillID(), e);
            }
        }
        mav.addObject(Constants.FORM_MODEL_KEY, bean);
        addData2Model(mav);
        return mav;
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

    @RequestMapping(value="/ajax/removeBookedProduct.html")
    public void getProvinceByRegion(@RequestParam(value = "bookProductID", required = true) Long bookProductID,
                                    @RequestParam(value = "productID", required = true) Long productID,
                                    HttpServletResponse response)  {
        try{
            this.bookProductService.deleteItem(bookProductID);
        }catch (Exception e) {
            log.error(e.getMessage(), e);
        }
    }

    @RequestMapping("/whm/booking/view.html")
    public ModelAndView viewBooking(@ModelAttribute(Constants.FORM_MODEL_KEY) BookProductBillBean bean, BindingResult bindingResult) {
        ModelAndView mav = new ModelAndView("/whm/booking/view");
        String crudaction = bean.getCrudaction();
        BookProductBill pojo = bean.getPojo();
        if(StringUtils.isNotBlank(crudaction) && crudaction.equals("insert-update")) {
            try {
                if(!bindingResult.hasErrors()) {
                    if(pojo.getBookProductBillID() != null && pojo.getBookProductBillID() > 0) {
                        ExportproductbillBean exportBillBean = new ExportproductbillBean();
                        boolean isAll = addData2ExportBill(pojo.getBookProductBillID(),exportBillBean,bean.getBookedProductIDs(), bean.getExportDate());
                        this.exportproductbillService.addExportRootMaterialBill(exportBillBean);
                        Integer status = isAll ? Constants.BOOK_EXPORTED : Constants.BOOK_EXPORTING;
                        this.bookProductBillService.updateStatus(pojo.getBookProductBillID(), status, SecurityUtils.getLoginUserId());
                        mav = new ModelAndView("redirect:/whm/booking/list.html?isUpdate=true");
                    }
                    return mav;
                }
            }catch(Exception e) {
                logger.error(e.getMessage(), e);
                mav.addObject("alertType", "error");
                mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("general.exception.msg"));
                mav = new ModelAndView("redirect:/whm/booking/list.html?isError=true");
            }
        }else if (StringUtils.isNotBlank(crudaction) && crudaction.equals("reject")){
            try {
                if(!bindingResult.hasErrors()) {
                    if(pojo.getBookProductBillID() != null && pojo.getBookProductBillID() > 0) {
                        if(bean.getPojo().getNote() == null || !StringUtils.isNotBlank(bean.getPojo().getNote()))
                            bean.getPojo().setNote(this.getMessageSourceAccessor().getMessage("msg.reject"));
                        this.bookProductBillService.updateReject(bean.getPojo().getNote(),bean.getPojo().getBookProductBillID(),SecurityUtils.getLoginUserId());
                        mav = new ModelAndView("redirect:/whm/booking/list.html?isUpdate=true");
                    }
                    return mav;
                }
            }catch(Exception e) {
                logger.error(e.getMessage(), e);
                mav.addObject("alertType", "error");
                mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("general.exception.msg"));
                mav = new ModelAndView("redirect:/whm/booking/list.html?isError=true");
            }
        }else if (StringUtils.isNotBlank(crudaction) && crudaction.equals("approve")){
            try {
                if(!bindingResult.hasErrors()) {
                    if(pojo.getBookProductBillID() != null && pojo.getBookProductBillID() > 0) {
                        if(bean.getPojo().getNote() == null || !StringUtils.isNotBlank(bean.getPojo().getNote()))
                            bean.getPojo().setNote(this.getMessageSourceAccessor().getMessage("msg.approve"));
                        this.bookProductBillService.updateConfirm(bean.getPojo().getBookProductBillID(),SecurityUtils.getLoginUserId());
                        mav = new ModelAndView("redirect:/whm/booking/list.html?isUpdate=true");
                    }
                    return mav;
                }
            }catch(Exception e) {
                logger.error(e.getMessage(), e);
                mav.addObject("alertType", "error");
                mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("general.exception.msg"));
                mav = new ModelAndView("redirect:/whm/booking/list.html?isError=true");
            }
        }


        if(pojo.getBookProductBillID() != null && pojo.getBookProductBillID() > 0) {
            try {
                BookProductBill dbItem = this.bookProductBillService.findByIdNoCommit(pojo.getBookProductBillID());
                List<OweLog> prePaids = this.oweLogService.findPrePaidByBill(pojo.getBookProductBillID());
                dbItem.setPrePaids(prePaids);
                if(dbItem.getBookProducts() != null && dbItem.getStatus().equals(Constants.BOOK_EXPORTING)){
//                    if(SecurityUtils.userHasAuthority(Constants.MODULE_XUAT_TP)){
//                        dbItem.setBookProducts(getWaitExportProduct(dbItem));
//                    }
                }
                bean.setPojo(dbItem);
                mav.addObject("owe", this.oweLogService.findCustomerOweUtilDate(dbItem.getCustomer().getCustomerID(), dbItem.getBillDate()));
            } catch (Exception e) {
                logger.error("Could not found item " + bean.getPojo().getBookProductBillID(), e);
            }
        }
        mav.addObject(Constants.FORM_MODEL_KEY, bean);
        mav.addObject("loginWarehouseID", SecurityUtils.getPrincipal().getWarehouseID());
        addData2Model(mav);
        return mav;
    }
    private List<BookProduct> getWaitExportProduct(BookProductBill bill){
        List<BookProduct> bookProducts = new ArrayList<BookProduct>();
        for(BookProduct bookProduct : bill.getBookProducts()){
            if(bookProduct.getImportProduct().getStatus().equals(Constants.ROOT_MATERIAL_STATUS_BOOKED) || bookProduct.getImportProduct().getSaleWarehouse() != null){
                bookProducts.add(bookProduct);
            }
        }
        return bookProducts;
    }

    private boolean addData2ExportBill(Long bookProductBillID, ExportproductbillBean exportBillBean,List<Long> productIDs, Date exportDate) {
        BookProductBill bookProductBill = this.bookProductBillService.findByIdNoCommit(bookProductBillID);
        Exportproductbill exportproductbill = exportBillBean.getPojo();
        exportproductbill.setBookProductBill(bookProductBill);
        exportBillBean.setLoginID(SecurityUtils.getLoginUserId());
        exportproductbill.setNote(this.getMessageSourceAccessor().getMessage("msg.create"));
        Exporttype exporttype = this.exporttypeService.findByCode(Constants.EXPORT_TYPE_BAN);
        exportproductbill.setExportDate(new Timestamp(exportDate.getTime()));
        exportproductbill.setExporttype(exporttype);
        exportproductbill.setCustomer(bookProductBill.getCustomer());
        exportproductbill.setCode(GeneratorUtils.generatePXKTONCode());
        exportproductbill.setDescription(this.getMessageSourceAccessor().getMessage("button.create.export.bill"));
        List<ItemInfoDTO> itemInfoDTOs = new ArrayList<ItemInfoDTO>();
        Map<Long,Integer> mapWarehouseProductCount = new HashMap<Long, Integer>();
        bookProductBill.setBookProducts(getWaitExportProduct(bookProductBill));
        for(BookProduct bookProduct : bookProductBill.getBookProducts()){
            if(productIDs.contains(bookProduct.getImportProduct().getImportProductID())){
                Importproduct importproduct = bookProduct.getImportProduct();
                Long warehouseID = importproduct.getWarehouse().getWarehouseID();

                ItemInfoDTO item = new ItemInfoDTO();
                item.setItemID(importproduct.getImportProductID());
                itemInfoDTOs.add(item);

                if(!mapWarehouseProductCount.containsKey(warehouseID)){
                    mapWarehouseProductCount.put(warehouseID,1);
                }else {
                    mapWarehouseProductCount.put(warehouseID,mapWarehouseProductCount.get(warehouseID) + 1);
                }
            }
        }
        exportBillBean.setItemInfos(itemInfoDTOs);

        Long selectedWarehouseID = null;
        Integer maxCount = 0;
        for(Long warehouseID : mapWarehouseProductCount.keySet()){
            if(mapWarehouseProductCount.get(warehouseID) > maxCount){
                selectedWarehouseID =  warehouseID;
                maxCount =  mapWarehouseProductCount.get(warehouseID);
            }
        }
        Warehouse warehouse = new Warehouse();
        warehouse.setWarehouseID(selectedWarehouseID);
        exportproductbill.setExportWarehouse(warehouse);
        return bookProductBill.getBookProducts().size() == productIDs.size() ? true : false;
    }

    @RequestMapping(value = "/ajax/booking/confirmation.html")
    public void confirmSubmittedScoreCardYear(@ModelAttribute(Constants.FORM_MODEL_KEY) BookProductBillBean bean,
                                              HttpServletResponse response){
        try{
            response.setContentType("text/json; charset=UTF-8");
            PrintWriter out = response.getWriter();
            JSONObject object = new JSONObject();
            BookProductBill bill = this.bookProductBillService.findByIdNoCommit(bean.getPojo().getBookProductBillID());
            if(bill != null){
                if(bean.getPojo().getStatus() != null){
                    bill.setStatus(bean.getPojo().getStatus());
                    User approvedUser = new User();
                    approvedUser.setUserID(SecurityUtils.getLoginUserId());
                    bill.setConfirmedBy(approvedUser);
                    bill.setConfirmedDate(new Timestamp(new Date().getTime()));
                }
                this.bookProductBillService.update(bill);
                if (bill.getStatus() == Constants.BOOK_ALLOW_EXPORT){
                    object.put("text", "Approve");
                }
                else if(bill.getStatus() == Constants.BOOK_REJECTED){
                    object.put("text", "Reject");
                }
            }
            out.print(object);
            out.flush();
            out.close();
        }catch (Exception e){
            log.error(e.getMessage(),e);
        }
    }

    @RequestMapping(value = "/ajax/printShippingBill.html", method = RequestMethod.GET)
    public ModelAndView printShippingBill(@RequestParam(value="bookProductBillId") Long bookProductBillId) {
        ModelAndView mav = new ModelAndView("/whm/booking/shippingbill");
        Map model = mav.getModel();

        try {
            BookProductBill bookProductBill = bookProductBillService.findByIdNoCommit(bookProductBillId);
            Calendar calendar = Calendar.getInstance();
            calendar.setTimeInMillis(bookProductBill.getBillDate().getTime());
            model.put("year", calendar.get(Calendar.YEAR));
            model.put("bookProducts", bookProductBill.getBookProducts());
            model.put("customer", bookProductBill.getCustomer().getName().concat(bookProductBill.getCustomer().getProvince() != null ? " - " + bookProductBill.getCustomer().getProvince().getName() : ""));
            model.put("warehouse", bookProductBill.getBookProducts().get(0).getImportProduct().getWarehouse().getName());
        } catch (Exception e) {
            log.error(e.getMessage(),e);
        }
        return mav;
    }

    @RequestMapping(value = "/ajax/printShippingConfirmBill.html", method = RequestMethod.GET)
    public ModelAndView printShippingConfirmBill(@RequestParam(value="bookProductBillId") Long bookProductBillId) {
        ModelAndView mav = new ModelAndView("/whm/booking/shippingconfirmbill");
        Map model = mav.getModel();

        try {
            BookProductBill bookProductBill = bookProductBillService.findByIdNoCommit(bookProductBillId);
            Calendar calendar = Calendar.getInstance();
            calendar.setTimeInMillis(bookProductBill.getBillDate().getTime());
            model.put("year", calendar.get(Calendar.YEAR));
            Customer customer = bookProductBill.getCustomer();
            model.put("customer", customer.getName().concat(customer.getProvince() != null ? " - " + customer.getProvince().getName() : ""));
            model.put("company", customer.getCompany() != null ? customer.getCompany() : "");
            model.put("contact", customer.getContact() != null ? customer.getContact() : "");
            model.put("contactPhone", customer.getContactPhone() != null ? customer.getContactPhone() : "");
            model.put("customerAddress", customer.getAddress() != null ? customer.getAddress() : "");
            StringBuffer telFax = new StringBuffer();
            telFax.append(customer.getPhone() != null ? customer.getPhone() : "" );
            if(StringUtils.isNotBlank(customer.getFax())){
                telFax.append("*** Fax: ").append(customer.getFax());
            }
            model.put("customerTelFax", telFax.toString());
            model.put("bookProducts", bookProductBill.getBookProducts());
            model.put("warehouse", bookProductBill.getBookProducts().get(0).getImportProduct().getWarehouse().getName());
            if(bookProductBill.getDeliveryDate() != null){
                Timestamp utilDate = new Timestamp(bookProductBill.getBillDate().getTime() - Constants.A_DAY);
                model.put("utilDate", DateUtils.date2String(bookProductBill.getBillDate(),"dd/MM/yyyy"));
            }
            model.put("noinhan", bookProductBill.getDestination() != null ? bookProductBill.getDestination() : "");
            model.put("transportFee", bookProductBill.getReduce() != null ? bookProductBill.getReduce() : "");
            model.put("deliveryDate", bookProductBill.getDeliveryDate() != null ? bookProductBill.getDeliveryDate() : "");
            model.put("owe", this.oweLogService.findCustomerOweUtilDate(bookProductBill.getCustomer().getCustomerID(), bookProductBill.getBillDate()));
            model.put("bookSales", bookProductBill.getBookBillSaleReasons());
            model.put("prePaids", this.oweLogService.findPrePaidByBill(bookProductBill.getBookProductBillID()));
            model.put("user", bookProductBill.getCreatedBy());
            model.put("oldFormula", bookProductBill.getOldFormula());
        } catch (Exception e) {
            log.error(e.getMessage(),e);
        }
        return mav;
    }


    @RequestMapping("/whm/booking/editinfo.html")
    public ModelAndView edit(@ModelAttribute(Constants.FORM_MODEL_KEY) BookProductBillBean bean, BindingResult bindingResult) {
        ModelAndView mav = new ModelAndView("/whm/booking/editinfo");

        String crudaction = bean.getCrudaction();
        BookProductBill pojo = bean.getPojo();
        bean.setLoginID(SecurityUtils.getLoginUserId());
        bean.setTitle(this.getMessageSourceAccessor().getMessage("booking.product.description"));
        try {
            if(StringUtils.isNotBlank(crudaction) && (crudaction.equals("insert-update") || crudaction.equals("save-then-book"))) {
                if(!bindingResult.hasErrors()) {
                    pojo = this.bookProductBillService.saveOrUpdateBillInfo(bean);
                    mav = new ModelAndView(crudaction.equals("insert-update") ? (pojo.getBookProductBillID() != null ? "redirect:/whm/booking/list.html?isUpdate=true" :  "redirect:/whm/booking/list.html?isAdd=true") : "redirect:/whm/instock/booking.html?bookProductBillID=" + pojo.getBookProductBillID());
                    return mav;
                }
            }
        }catch(Exception e) {
            logger.error(e.getMessage(), e);
            mav = new ModelAndView("redirect:/whm/booking/list.html?isError=true");
            return mav;
        }
        if(!bindingResult.hasErrors()&& bean.getPojo().getBookProductBillID() != null && bean.getPojo().getBookProductBillID() > 0) {
            try {
                BookProductBill itemObj = this.bookProductBillService.findById(pojo.getBookProductBillID());
                List<OweLog> prePaids = this.oweLogService.findPrePaidByBill(pojo.getBookProductBillID());
                itemObj.setPrePaids(prePaids);
                bean.setPojo(itemObj);
                if(itemObj.getBookBillSaleReasons() != null){
                    Map<Long,Double> mapReasonMoney = new HashMap<Long, Double>();
                    Map<Long,Timestamp> mapReasonDate = new HashMap<Long, Timestamp>();
                    for(BookBillSaleReason bookBillSaleReason : itemObj.getBookBillSaleReasons()){
                        mapReasonMoney.put(bookBillSaleReason.getSaleReason().getSaleReasonID(), bookBillSaleReason.getMoney());
                        mapReasonDate.put(bookBillSaleReason.getSaleReason().getSaleReasonID(), bookBillSaleReason.getDate());
                    }
                    mav.addObject("mapReasonMoney", mapReasonMoney);
                    mav.addObject("mapReasonDate", mapReasonDate);
                }
            }
            catch (Exception e) {
                logger.error("Could not found item " + bean.getPojo().getBookProductBillID(), e);
            }
        }
        if(bean.getPojo().getBillDate() == null){
            bean.getPojo().setBillDate(new Timestamp(System.currentTimeMillis()));
        }
        addData2Model(mav);
        mav.addObject("saleReasons", saleReasonService.findAllByOrder());
        mav.addObject(Constants.FORM_MODEL_KEY, bean);
        return mav;
    }

    @RequestMapping("/whm/booking/addPrice.html")
    public ModelAndView addPrice(@ModelAttribute(Constants.FORM_MODEL_KEY) BookProductBillBean bean, BindingResult bindingResult) {
        ModelAndView mav = new ModelAndView("/whm/booking/addPrice");

        String crudaction = bean.getCrudaction();
        BookProductBill pojo = bean.getPojo();
        bean.setLoginID(SecurityUtils.getLoginUserId());
        try {
            if(StringUtils.isNotBlank(crudaction) && crudaction.equals("insert-update")) {
                if(!bindingResult.hasErrors()) {
                    if(pojo.getOldFormula() == null){
                        pojo.setOldFormula(true);
                    }
                    pojo = this.bookProductBillService.updatePrice(bean);
                    mav = new ModelAndView("redirect:/whm/booking/view.html?pojo.bookProductBillID=" + pojo.getBookProductBillID());
                    return mav;
                }
            }
        }catch(Exception e) {
            logger.error(e.getMessage(), e);
            mav = new ModelAndView("redirect:/whm/booking/list.html?isError=true");
            return mav;
        }
        if(!bindingResult.hasErrors()&& bean.getPojo().getBookProductBillID() != null && bean.getPojo().getBookProductBillID() > 0) {
            try {
                BookProductBill itemObj = this.bookProductBillService.findById(pojo.getBookProductBillID());
                List<OweLog> prePaids = this.oweLogService.findPrePaidByBill(pojo.getBookProductBillID());
                itemObj.setPrePaids(prePaids);
                bean.setPojo(itemObj);
                mav.addObject("owe", this.oweLogService.findCustomerOweUtilDate(itemObj.getCustomer().getCustomerID(), itemObj.getBillDate()));
            }
            catch (Exception e) {
                logger.error("Could not found item " + bean.getPojo().getBookProductBillID(), e);
            }
        }
        addData2Model(mav);
        mav.addObject(Constants.FORM_MODEL_KEY, bean);
        return mav;
    }
}
