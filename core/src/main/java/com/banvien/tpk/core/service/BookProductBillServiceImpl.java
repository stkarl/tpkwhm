package com.banvien.tpk.core.service;

import com.banvien.tpk.core.Constants;
import com.banvien.tpk.core.dao.*;
import com.banvien.tpk.core.domain.*;
import com.banvien.tpk.core.dto.BookProductBillBean;
import com.banvien.tpk.core.dto.SuggestPriceDTO;
import com.banvien.tpk.core.exception.ObjectNotFoundException;
import com.banvien.tpk.core.util.DateUtils;
import com.banvien.tpk.core.util.GeneratorUtils;
import com.banvien.tpk.security.SecurityUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import java.sql.Timestamp;
import java.util.*;

public class BookProductBillServiceImpl extends GenericServiceImpl<BookProductBill,Long>
                                                    implements BookProductBillService {

    protected final Log logger = LogFactory.getLog(getClass());

    private BookProductBillDAO bookProductBillDAO;

    public void setBookProductBillDAO(BookProductBillDAO bookProductBillDAO) {
        this.bookProductBillDAO = bookProductBillDAO;
    }

    private BookProductDAO bookProductDAO;

    public void setBookProductDAO(BookProductDAO bookProductDAO) {
        this.bookProductDAO = bookProductDAO;
    }

    private ImportproductDAO importproductDAO;

    public void setImportproductDAO(ImportproductDAO importproductDAO) {
        this.importproductDAO = importproductDAO;
    }

    private ProductqualityDAO productqualityDAO;

    public void setProductqualityDAO(ProductqualityDAO productqualityDAO) {
        this.productqualityDAO = productqualityDAO;
    }

    private OweLogDAO oweLogDAO;

    public void setOweLogDAO(OweLogDAO oweLogDAO) {
        this.oweLogDAO = oweLogDAO;
    }

    private CustomerDAO customerDAO;

    public void setCustomerDAO(CustomerDAO customerDAO) {
        this.customerDAO = customerDAO;
    }

    private BookBillSaleReasonDAO bookBillSaleReasonDAO;

    public void setBookBillSaleReasonDAO(BookBillSaleReasonDAO bookBillSaleReasonDAO) {
        this.bookBillSaleReasonDAO = bookBillSaleReasonDAO;
    }

    @Override
	protected GenericDAO<BookProductBill, Long> getGenericDAO() {
		return bookProductBillDAO;
	}

    @Override
    public String saveOrUpdateBookingBill(List<Long> bookedProductIDs,Long loginID, Long billID) throws ObjectNotFoundException {
        String result = "";
        User loginUser = new User();
        loginUser.setUserID(loginID);
        Timestamp now = new Timestamp(System.currentTimeMillis());
        BookProductBill dbBill = this.bookProductBillDAO.findByIdNoAutoCommit(billID);
        dbBill.setStatus(Constants.BOOK_WAIT_CONFIRM);
        dbBill.setUpdatedBy(loginUser);
        dbBill.setUpdatedDate(now);
        dbBill = this.bookProductBillDAO.update(dbBill);

        List<Long> listAbleBooked = new ArrayList<Long>();
        for(Long bookedProductID : bookedProductIDs){
            BookProduct bookProduct = new BookProduct();
            bookProduct.setBookProductBill(dbBill);
            Importproduct importproduct = this.importproductDAO.findByIdNoAutoCommit(bookedProductID);
            if(importproduct.getStatus().equals(Constants.ROOT_MATERIAL_STATUS_AVAILABLE)){
                bookProduct.setImportProduct(importproduct);
                this.bookProductDAO.save(bookProduct);
                listAbleBooked.add(bookedProductID);
            }else{
                result += StringUtils.isBlank(result) ? importproduct.getProductCode() : ", " + importproduct.getProductCode();
            }
        }
        if(listAbleBooked.size() > 0){
            this.importproductDAO.updateStatus(listAbleBooked,Constants.ROOT_MATERIAL_STATUS_BOOKED);
        }
        return result;
    }

    @Override
    public Object[] search(BookProductBillBean bean) {
        Map<String, Object> properties = new HashMap<String, Object>();
        StringBuffer whereClause = new StringBuffer(" 1 = 1");
        if(SecurityUtils.userHasAuthority(Constants.NVKD_ROLE)){
            whereClause.append(" AND createdBy.userID = " + bean.getLoginID());
        }

        if(SecurityUtils.userHasAuthority(Constants.NVKHO_ROLE) || SecurityUtils.userHasAuthority(Constants.QLKHO_ROLE)){
            whereClause.append(" AND EXISTS (SELECT 1 FROM BookProduct bp WHERE bp.bookProductBill.bookProductBillID = A.bookProductBillID")
                    .append(" AND bp.importProduct.warehouse.warehouseID = ").append(SecurityUtils.getPrincipal().getWarehouseID()).append(")");
        }

        if(bean.getFromDate() != null){
            whereClause.append(" AND createdDate >= '").append(bean.getFromDate()).append("'");
        }
        if(bean.getToDate() != null){
            whereClause.append(" AND createdDate <= '").append(bean.getToDate()).append("'");
        }
        if(bean.getCustomerID() != null &&  bean.getCustomerID() > 0){
            properties.put("customer.customerID", bean.getCustomerID());
        }

        if(bean.getUserID() != null &&  bean.getUserID() > 0){
            properties.put("createdBy.userID",bean.getUserID());
        }
        if(bean.getStatus() != null &&  bean.getStatus() > -1){
            properties.put("status",bean.getStatus());
        }
        if(bean.getSortExpression() == null){
            bean.setSortExpression("createdDate");
        }
        if(bean.getSortDirection() == null){
            bean.setSortDirection("1");
        }
        return this.bookProductBillDAO.searchByProperties(properties, bean.getFirstItem(), bean.getMaxPageItems(), bean.getSortExpression(), bean.getSortDirection(), true, whereClause.toString());
    }

    @Override
    public Integer deleteItems(String[] checkList) {
        Integer res = 0;
        if (checkList != null && checkList.length > 0) {
            res = checkList.length;
            for (String id : checkList) {
                Long ID = Long.parseLong(id);
                BookProductBill bill = this.bookProductBillDAO.findByIdNoAutoCommit(ID);
                if(bill.getBookProducts() != null && bill.getBookProducts().size() > 0){
                    pushProductBack(bill.getBookProducts(),Constants.ROOT_MATERIAL_STATUS_AVAILABLE);
                }
//                deleteOweLogByBookBill(ID);  //auto deleted
                bookProductBillDAO.delete(ID);
            }
        }
        return res;
    }

    private void deleteOweLogByBookBill(Long billId) {
        OweLog oweLog = this.oweLogDAO.findOweByBookBill(billId);
        if(oweLog != null){
//            Customer customer = oweLog.getCustomer();     // wont check customer own by time
//            customer.setOwe(customer.getOwe() - oweLog.getPay());
//            customerDAO.update(customer);
            oweLogDAO.delete(oweLog);
        }
    }

    @Override
    public void updateBookProductBill(Long billID, Long customerID, Long loginID, String des) throws ObjectNotFoundException {
        BookProductBill dbBill = this.bookProductBillDAO.findByIdNoAutoCommit(billID);
        if(dbBill == null) throw new ObjectNotFoundException("Cannot found Booking bill: " + billID);
        Customer customer = null;
        if(customerID != null){
            customer = new Customer();
            customer.setCustomerID(customerID);
        }

        User loginUser = new User();
        loginUser.setUserID(loginID);

        Timestamp now = new Timestamp(System.currentTimeMillis());
        String timeString = DateUtils.date2String(now,"dd/MM/yyyy - HH:mm");
        des += " - " + timeString;
        dbBill.setCustomer(customer);
        dbBill.setUpdatedBy(loginUser);
        dbBill.setUpdatedDate(now);
        dbBill.setDescription(des);
        dbBill.setStatus(Constants.BOOK_WAIT_CONFIRM);
        this.bookProductBillDAO.update(dbBill);
    }

    @Override
    public void updateStatus(Long bookProductBillID, Integer status, Long loginID) {
        BookProductBill bookProductBill = this.bookProductBillDAO.findByIdNoAutoCommit(bookProductBillID);
        User user = new User();
        user.setUserID(loginID);
        Timestamp now = new Timestamp(System.currentTimeMillis());
        bookProductBill.setUpdatedDate(now);
        bookProductBill.setUpdatedBy(user);
        bookProductBill.setStatus(status);
        this.bookProductBillDAO.update(bookProductBill);
    }

    @Override
    public void updateReject(String note, Long billID, Long userID) {
        BookProductBill bill = this.bookProductBillDAO.findByIdNoAutoCommit(billID);
        bill.setNote(note);
        bill.setStatus(Constants.BOOK_REJECTED);
        User loginUser = new User();
        loginUser.setUserID(userID);
        bill.setConfirmedBy(loginUser);
        bill.setConfirmedDate(new Timestamp(System.currentTimeMillis()));
        this.bookProductBillDAO.update(bill);
    }

    @Override
    public void updateConfirm(Long bookProductBillID, Long loginUserId) throws ObjectNotFoundException {
        BookProductBill dbItem = this.bookProductBillDAO.findByIdNoAutoCommit(bookProductBillID);
        if (dbItem == null) throw new ObjectNotFoundException("Not found BookProductBill " + bookProductBillID);
        dbItem.setConfirmedDate(new Timestamp(System.currentTimeMillis()));
        User loginUser = new User();
        loginUser.setUserID(loginUserId);
        dbItem.setConfirmedBy(loginUser);
        dbItem.setStatus(Constants.BOOK_ALLOW_EXPORT);
        this.bookProductBillDAO.update(dbItem);
    }

    @Override
    public BookProductBill saveOrUpdateBillInfo(BookProductBillBean bean) throws Exception{
        User loginUser = new User();
        loginUser.setUserID(bean.getLoginID());

        Timestamp now = new Timestamp(System.currentTimeMillis());
        if(bean.getPojo().getCustomer() != null && bean.getPojo().getCustomer().getCustomerID() != null && bean.getPojo().getCustomer().getCustomerID() < 0){
            bean.getPojo().setCustomer(null);
        }

        BookProductBill dbBill;
        if(bean.getPojo().getBookProductBillID() != null){
            dbBill = this.bookProductBillDAO.findByIdNoAutoCommit(bean.getPojo().getBookProductBillID());
            dbBill.setUpdatedBy(loginUser);
            dbBill.setUpdatedDate(now);
            dbBill.setDeliveryDate(bean.getPojo().getDeliveryDate());
            if(dbBill.getBillDate() != null){
                Calendar calendar = Calendar.getInstance();
                calendar.setTimeInMillis(dbBill.getBillDate().getTime());
                bean.getPojo().getBillDate().setHours(calendar.get(Calendar.HOUR_OF_DAY));
                bean.getPojo().getBillDate().setMinutes(calendar.get(Calendar.MINUTE));
            }
            dbBill.setBillDate(bean.getPojo().getBillDate());
            dbBill.setCustomer(bean.getPojo().getCustomer());
        }else{
            dbBill = bean.getPojo();
            String title = bean.getTitle();
            title += " - " + GeneratorUtils.getLatestBookNumber();
            dbBill.setDescription(title);
            dbBill.setCreatedBy(loginUser);
            dbBill.setCreatedDate(now);
            if(dbBill.getBillDate() != null){
                Calendar calendar = Calendar.getInstance();
                dbBill.getBillDate().setHours(calendar.get(Calendar.HOUR_OF_DAY));
                dbBill.getBillDate().setMinutes(calendar.get(Calendar.MINUTE));
            }
        }
        dbBill.setStatus(Constants.BOOK_WAIT_CONFIRM);
        dbBill = this.bookProductBillDAO.saveOrUpdate(dbBill);

        Double saleGap = saveOrUpdateSaleReason(bean.getMapReasonMoney(),bean.getMapReasonDate(), dbBill);
        saveOrUpdatePrePaid(bean.getPrePaids(), dbBill); // prePaids is save separately
        updateOweLogIfAny(saleGap, dbBill);
        return dbBill;
    }

    private void updateOweLogIfAny(Double saleGap, BookProductBill dbBill) {
        if(saleGap != 0){
            OweLog oweLog = this.oweLogDAO.findOweByBookBill(dbBill.getBookProductBillID());
            if(oweLog != null){
                oweLog.setPay(oweLog.getPay() - saleGap);
                oweLog.setOweDate(dbBill.getBillDate());
                this.oweLogDAO.update(oweLog);
            }
        }
    }

    private Double saveOrUpdateSaleReason(Map<Long, Double> mapReasonMoney, Map<Long, Timestamp> mapReasonDate, BookProductBill dbBill) {
        Double gap = 0d;
        Double temp;
        List<BookBillSaleReason> dbBookBillSaleReason = dbBill.getBookBillSaleReasons();
        if(mapReasonMoney != null){
            for(Long reasonID : mapReasonMoney.keySet()){
                Double money = mapReasonMoney.get(reasonID);
                Timestamp date = mapReasonDate.get(reasonID);
                BookBillSaleReason bookBillSaleReason = null;
                if(dbBookBillSaleReason != null){
                    for(int i = dbBill.getBookBillSaleReasons().size() - 1; i >= 0; i--){
                        BookBillSaleReason dbBookReason = dbBookBillSaleReason.get(i);
                        if(dbBookReason.getSaleReason().getSaleReasonID().equals(reasonID) && money != null && money > 0){
                            bookBillSaleReason = dbBookReason;
                            dbBookBillSaleReason.remove(i);
                            break;
                        }
                    }
                    temp = saveOrUpdateBookSaleReason(dbBill, bookBillSaleReason, reasonID, money, date);
                    gap += temp;
                }else{
                    temp = saveOrUpdateBookSaleReason(dbBill, bookBillSaleReason, reasonID, money, date);
                    gap += temp;
                }
            }
        }

        if(dbBookBillSaleReason != null && !dbBookBillSaleReason.isEmpty()){
            for(BookBillSaleReason saleReason : dbBookBillSaleReason){
                gap += (0 - saleReason.getMoney());
            }
            bookBillSaleReasonDAO.deleteAll(dbBookBillSaleReason);
        }
        return gap;
    }

    private Double saveOrUpdateBookSaleReason(BookProductBill dbBill, BookBillSaleReason bookBillSaleReason, Long reasonID, Double money, Timestamp date) {
        Double gap = 0d;
        if(money != null && money > 0){
            if(bookBillSaleReason == null){
                bookBillSaleReason = new BookBillSaleReason();
                bookBillSaleReason.setBookProductBill(dbBill);
                SaleReason saleReason = new SaleReason();
                saleReason.setSaleReasonID(reasonID);
                bookBillSaleReason.setSaleReason(saleReason);
                gap = money;
            }else{
                gap = money - bookBillSaleReason.getMoney();
            }
            bookBillSaleReason.setMoney(money);
            bookBillSaleReason.setDate(date);
            this.bookBillSaleReasonDAO.saveOrUpdate(bookBillSaleReason);
        }
        return gap;
    }

    private void saveOrUpdatePrePaid(List<OweLog> prePaids, BookProductBill dbBill) {
        List<OweLog> dbOweLogs = this.oweLogDAO.findPrePaidByBill(dbBill.getBookProductBillID());
        if(prePaids != null){
            for(OweLog prePaid : prePaids){
                Double paid = prePaid.getPay();
                String note = prePaid.getNote();
                Timestamp date = prePaid.getPayDate();
                if(date != null && StringUtils.isNotBlank(note) && paid != null && paid > 0){
                    OweLog oweLog = null;
                    if(dbOweLogs != null){
                        for(int i = dbOweLogs.size() - 1; i >= 0; i--){
                            OweLog dbOweLog = dbOweLogs.get(i);
                            if(dbOweLog.getNote().equalsIgnoreCase(note)){
                                oweLog = dbOweLog;
                                dbOweLogs.remove(i);
                                break;
                            }
                        }
                        saveOrUpdatePrePaidDetail(dbBill, oweLog, note, date, paid);
                    }else{
                        saveOrUpdatePrePaidDetail(dbBill, oweLog, note, date, paid);
                    }
                }
            }
        }

        if(dbOweLogs != null && !dbOweLogs.isEmpty()){
            oweLogDAO.deleteAll(dbOweLogs);
        }
    }

    private void saveOrUpdatePrePaidDetail(BookProductBill dbBill, OweLog oweLog, String note, Timestamp date, Double paid) {
        Calendar calendar = Calendar.getInstance();
        if(oweLog == null){
            oweLog = new OweLog();
            oweLog.setNote(note);
            oweLog.setBookProductBill(dbBill);
            oweLog.setCustomer(dbBill.getCustomer());
            oweLog.setCreatedDate(new Timestamp(System.currentTimeMillis()));
            oweLog.setCreatedBy(dbBill.getCreatedBy());
            oweLog.setType(Constants.OWE_MINUS);
            date.setHours(calendar.get(Calendar.HOUR_OF_DAY));
            date.setMinutes(calendar.get(Calendar.MINUTE));
        }else{
            calendar.setTimeInMillis(oweLog.getPayDate().getTime());
            date.setHours(calendar.get(Calendar.HOUR_OF_DAY));
            date.setMinutes(calendar.get(Calendar.MINUTE));
        }
        oweLog.setPayDate(date);
        oweLog.setPay(paid);
        this.oweLogDAO.saveOrUpdate(oweLog);
    }

    private void pushProductBack(List<BookProduct> bookProducts, Integer status) {
        List<Long> importProductIDs = new ArrayList<Long>();
        for(BookProduct bookProduct : bookProducts){
            importProductIDs.add(bookProduct.getImportProduct().getImportProductID()) ;
        }
        this.importproductDAO.updateStatus(importProductIDs,status);

    }

    @Override
    public String getLatestBookBillNumber() {
        return this.bookProductBillDAO.getLatestBookBillNumber();
    }



    @Override
    public BookProductBill updatePrice(BookProductBillBean bean) {
        BookProductBill dbBill = this.bookProductBillDAO.findByIdNoAutoCommit(bean.getPojo().getBookProductBillID());
        Object[] objects = buildPriceMap(bean.getSuggestedItems());
        Map<String,Double> mapProductPrice = (Map<String, Double>) objects[0];
        Map<String,Double> mapProductPriceSale = (Map<String, Double>) objects[1];
        Map<String,Double> mapProductQuantitySale = (Map<String, Double>) objects[2];
        List<BookProduct> bookProducts = dbBill.getBookProducts();
        if(bookProducts != null){
            String key;
            for(BookProduct bookProduct : bookProducts){
                if(bookProduct.getImportProduct().getProductqualitys() != null){
                    for(Productquality productquality : bookProduct.getImportProduct().getProductqualitys()){
                        key = bookProduct.getImportProduct().getImportProductID() + "_" + productquality.getQuality().getQualityID();
                        productquality.setPrice(mapProductPrice.get(key));
                        productquality.setSalePrice(mapProductPriceSale.get(key));
                        productquality.setSaleQuantity(mapProductQuantitySale.get(key));
                        productqualityDAO.update(productquality);
                    }
                }else {
                    bookProduct.getImportProduct().setSuggestedPrice(mapProductPrice.get(bookProduct.getImportProduct().getImportProductID().toString()));
                    bookProduct.getImportProduct().setSalePrice(mapProductPriceSale.get(bookProduct.getImportProduct().getImportProductID().toString()));
                    bookProduct.getImportProduct().setSaleQuantity(mapProductQuantitySale.get(bookProduct.getImportProduct().getImportProductID().toString()));
                    importproductDAO.update(bookProduct.getImportProduct());
                }
            }
        }
        dbBill.setMoney(bean.getTotalMoney());    // products price only
        dbBill.setDestination(bean.getPojo().getDestination());
        dbBill.setReduceCost(bean.getPojo().getReduceCost());
        dbBill.setReduce(bean.getPojo().getReduce());
        dbBill.setStatus(Constants.BOOK_WAIT_CONFIRM);
        dbBill = bookProductBillDAO.update(dbBill);
        saveOrUpdateOweLog(dbBill);
        return dbBill;
    }

    private void saveOrUpdateOweLog(BookProductBill dbBill) {
        OweLog oweLog = this.oweLogDAO.findOweByBookBill(dbBill.getBookProductBillID());
        Timestamp now = new Timestamp(System.currentTimeMillis());
        Double money = dbBill.getReduce() != null ? dbBill.getMoney() - dbBill.getReduce() : dbBill.getMoney();
        if(dbBill.getBookBillSaleReasons() != null){
            for(BookBillSaleReason bookBillSaleReason : dbBill.getBookBillSaleReasons()){
                money -= bookBillSaleReason.getMoney() != null ? bookBillSaleReason.getMoney() : 0d;
            }
        }
        if(oweLog == null){
            oweLog = new OweLog();
            oweLog.setCreatedBy(dbBill.getCreatedBy());
            oweLog.setType(Constants.OWE_PLUS);
            oweLog.setNote(dbBill.getDescription());
            oweLog.setBookProductBill(dbBill);
            oweLog.setCreatedDate(now);
            oweLog.setOweDate(dbBill.getBillDate());
            oweLog.setCustomer(dbBill.getCustomer());
        }
        oweLog.setPay(money);
        this.oweLogDAO.saveOrUpdate(oweLog);
    }

    private Object[] buildPriceMap(List<SuggestPriceDTO> suggestedItems) {
        Map<String,Double> priceMap = new HashMap<String, Double>();
        Map<String,Double> priceSaleMap = new HashMap<String, Double>();
        Map<String,Double> quantitySaleMap = new HashMap<String, Double>();

        String key;
        for (SuggestPriceDTO suggestPriceDTO : suggestedItems){
            key = suggestPriceDTO.getQualityID() != null ?  suggestPriceDTO.getItemID() + "_" + suggestPriceDTO.getQualityID() : suggestPriceDTO.getItemID().toString();
            priceMap.put(key, suggestPriceDTO.getPrice());
            priceSaleMap.put(key, suggestPriceDTO.getSalePrice());
            quantitySaleMap.put(key, suggestPriceDTO.getSaleQuantity());
        }
        return new Object[]{priceMap, priceSaleMap, quantitySaleMap} ;
    }
}