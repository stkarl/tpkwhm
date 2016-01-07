package com.banvien.tpk.webapp.controller.whm;

import com.banvien.tpk.core.Constants;
import com.banvien.tpk.core.domain.Importproduct;
import com.banvien.tpk.core.dto.ReportBean;
import com.banvien.tpk.core.dto.SellSummaryDTO;
import com.banvien.tpk.core.service.*;
import com.banvien.tpk.webapp.dto.CellDataType;
import com.banvien.tpk.webapp.dto.CellValue;
import com.banvien.tpk.webapp.editor.CustomDateEditor;
import com.banvien.tpk.webapp.util.CommonUtil;
import com.banvien.tpk.webapp.util.DateUtils;
import com.banvien.tpk.webapp.util.ExcelUtil;
import jxl.Workbook;
import jxl.format.Colour;
import jxl.format.UnderlineStyle;
import jxl.write.*;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.ApplicationObjectSupport;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.sql.Timestamp;
import java.text.DecimalFormat;
import java.util.Date;
import java.util.List;

@Controller
public class SoldReportController extends ApplicationObjectSupport {
    private transient final Log log = LogFactory.getLog(getClass());

    @Autowired
    private ImportproductService importProductService;

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
    private CustomerService customerService;

    @Autowired
    private UserService userService;

    @Autowired
    private QualityService qualityService;

    @Autowired
    private UserCustomerService userCustomerService;
    @InitBinder
    public void initBinder(WebDataBinder binder) {
        binder.registerCustomEditor(Date.class, new CustomDateEditor("dd/MM/yyyy"));
    }

    @RequestMapping(value={"/whm/report/sold.html"})
    public ModelAndView list(ReportBean bean,HttpServletRequest request,HttpServletResponse response) {
        ModelAndView mav = new ModelAndView("/whm/report/sold");
        if(bean.getToDate() != null){
            bean.setToDate(DateUtils.move2TheEndOfDay(new Timestamp(bean.getToDate().getTime())));
        }
        if(bean.getCrudaction() != null && ("search".equals(bean.getCrudaction()) || "export".equals(bean.getCrudaction()))){
            try {
                List<Importproduct> results = this.importProductService.summarySoldProducts(bean);
                if(results != null && results.size() > 0){
                    mav.addObject("results",results);
                }
                if(bean.getCrudaction() != null && "export".equals(bean.getCrudaction())){
                }
            } catch (Exception e) {
                log.error(e.getMessage(),e);
            }
        }
        addData2ModelProduct(mav);
        mav.addObject(Constants.LIST_MODEL_KEY, bean);
        return mav;
    }

    private void addData2ModelProduct(ModelAndView mav){
        mav.addObject("qualities", this.qualityService.findAll());
        mav.addObject("productNames", this.productnameService.findAll());
        mav.addObject("sizes", this.sizeService.findAll());
        mav.addObject("thicknesses", this.thicknessService.findAll());
        mav.addObject("stiffnesses", this.stiffnessService.findAll());
        mav.addObject("colours", this.colourService.findAll());
        mav.addObject("overlayTypes", this.overlaytypeService.findAll());
        mav.addObject("users",this.userService.findByRole(Constants.NVKD_ROLE));
        mav.addObject("customers",this.customerService.findAll());
        mav.addObject("mapCustomerUser", CommonUtil.getMapCustomerUser(userCustomerService.findAll()));
    }

    @RequestMapping(value={"/whm/report/sellreport.html"})
    public ModelAndView sellSummary(ReportBean bean,HttpServletRequest request,HttpServletResponse response) {
        ModelAndView mav = new ModelAndView("/whm/report/sellreport");
        if(bean.getToDate() != null){
            bean.setToDate(DateUtils.move2TheEndOfDay(new Timestamp(bean.getToDate().getTime())));
        }else {
            bean.setToDate(new Date(System.currentTimeMillis()));
        }
        if(bean.getFromDate() == null){
            bean.setFromDate(new Date(System.currentTimeMillis()));
        }
        if(bean.getCrudaction() != null && ("report".equals(bean.getCrudaction()) || "export".equals(bean.getCrudaction()))){
            try {
                List<SellSummaryDTO> results = this.importProductService.sellReport(bean);
                if(results != null && results.size() > 0){
                    mav.addObject("results",results);
                    if(bean.getUserID() != null && bean.getUserID() > 0){
                        mav.addObject("user",this.userService.findByIdNoCommit(bean.getUserID()));
                    }
                    if(bean.getCustomerID() != null && bean.getCustomerID() > 0){
                        mav.addObject("customer",this.customerService.findByIdNoCommit(bean.getCustomerID()));
                    }
                }
                if(bean.getCrudaction() != null && "export".equals(bean.getCrudaction())){
                    exportSellSummary2Excel(bean,results, request, response);
                }
            } catch (Exception e) {
                log.error(e.getMessage(),e);
            }
        }
        addData2ModelProduct(mav);
        mav.addObject(Constants.LIST_MODEL_KEY, bean);
        return mav;
    }

    private void exportSellSummary2Excel(ReportBean bean, List<SellSummaryDTO> results, HttpServletRequest request, HttpServletResponse response) {
        try{
            String outputFileName = "/files/temp/Bao_Cao_Ban_Hang_" + System.currentTimeMillis() + ".xls";
            String reportTemplate = request.getSession().getServletContext().getRealPath("/files/export/BaoCaoBanHang.xls");
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

            Label fromDate = new Label(5, 1,DateUtils.date2String(bean.getFromDate(),"dd/MM/yyyy") , normalFormat);
            sheet.addCell(fromDate);
            Label toDate = new Label(8, 1,DateUtils.date2String(bean.getToDate(),"dd/MM/yyyy") , normalFormat);
            sheet.addCell(toDate);

            int startRow = 5;
            int stt = 1;
            Double overallInitialOwe = 0d;
            Double totalKem = 0d;
            Double totalLanh = 0d;
            Double totalMau = 0d;
            Double overallMoney = 0d;
            Double overallPaid = 0d;
            for(SellSummaryDTO sellSummaryDTO : results){
                Double kem = sellSummaryDTO.getKem() != null ? sellSummaryDTO.getKem() : 0d;
                Double lanh = sellSummaryDTO.getLanh() != null ? sellSummaryDTO.getLanh() : 0d;
                Double mau = sellSummaryDTO.getMau() != null ? sellSummaryDTO.getMau() : 0d;

                Double initialOwe = sellSummaryDTO.getInitialOwe() != null ? sellSummaryDTO.getInitialOwe() : 0d;
                Double money = sellSummaryDTO.getTotalMoney() != null ? sellSummaryDTO.getTotalMoney() : 0d;
                Double paid = sellSummaryDTO.getPaid() != null ? sellSummaryDTO.getPaid() : 0d;

                overallInitialOwe += initialOwe;
                totalKem += kem;
                totalLanh += lanh;
                totalMau += mau;
                overallMoney += money;
                overallPaid += paid;

                CellValue[] res = new CellValue[13];
                int i = 0;
                res[i++] = new CellValue(CellDataType.STRING, stt++);
                res[i++] = new CellValue(CellDataType.STRING, sellSummaryDTO.getCustomerName());
                res[i++] = new CellValue(CellDataType.STRING, sellSummaryDTO.getProvince());
                res[i++] = new CellValue(CellDataType.STRING, sellSummaryDTO.getToDate() != null ? DateUtils.date2String(sellSummaryDTO.getToDate(),"dd/MM/yyyy") : "");
                res[i++] = new CellValue(CellDataType.STRING, initialOwe != 0 ? decimalFormat.format(initialOwe) : "");
                res[i++] = new CellValue(CellDataType.STRING, kem != 0d ? decimalFormat.format(kem) : "");
                res[i++] = new CellValue(CellDataType.STRING, lanh != 0d ? decimalFormat.format(lanh) : "");
                res[i++] = new CellValue(CellDataType.STRING, mau != 0d ? decimalFormat.format(mau) : "");
                res[i++] = new CellValue(CellDataType.STRING, kem + lanh + mau != 0d ? decimalFormat.format(kem + lanh + mau) : "-");
                res[i++] = new CellValue(CellDataType.STRING, money != 0 ? decimalFormat.format(money) : "");
                res[i++] = new CellValue(CellDataType.STRING, paid != 0 ? decimalFormat.format(paid) : "");
                res[i++] = new CellValue(CellDataType.STRING, initialOwe + money - paid != 0d ? decimalFormat.format(initialOwe + money - paid) : "-");
                res[i++] = new CellValue(CellDataType.STRING, "");
                ExcelUtil.addRow(sheet, startRow++, res, normalFormat, normalFormat, normalFormat, normalFormat);
            }

            WritableFont boldFont = new WritableFont(WritableFont.TIMES, 12,
                    WritableFont.BOLD, false,
                    UnderlineStyle.NO_UNDERLINE,
                    Colour.BLACK);
            WritableCellFormat boldCenterFormat = new WritableCellFormat(boldFont);
            boldCenterFormat.setWrap(true);
            boldCenterFormat.setAlignment(Alignment.CENTRE);
            boldCenterFormat.setBorder(jxl.format.Border.ALL, jxl.format.BorderLineStyle.THIN);

            Label tong = new Label(0,startRow,"Tổng cộng",boldCenterFormat);
            sheet.addCell(tong);
            sheet.mergeCells(0,startRow,3,startRow);

            CellValue[] res = new CellValue[13];
            int i = 0;
            res[i++] = new CellValue(CellDataType.STRING, "Tổng cộng");
            res[i++] = new CellValue(CellDataType.STRING, "");
            res[i++] = new CellValue(CellDataType.STRING, "");
            res[i++] = new CellValue(CellDataType.STRING, "");
            res[i++] = new CellValue(CellDataType.STRING, overallInitialOwe != 0 ? decimalFormat.format(overallInitialOwe) : "");
            res[i++] = new CellValue(CellDataType.STRING, totalKem != 0d ? decimalFormat.format(totalKem) : "");
            res[i++] = new CellValue(CellDataType.STRING, totalLanh != 0d ? decimalFormat.format(totalLanh) : "");
            res[i++] = new CellValue(CellDataType.STRING, totalMau != 0d ? decimalFormat.format(totalMau) : "");
            res[i++] = new CellValue(CellDataType.STRING, totalKem + totalLanh + totalMau != 0d ? decimalFormat.format(totalKem + totalLanh + totalMau) : "-");
            res[i++] = new CellValue(CellDataType.STRING, overallMoney != 0 ? decimalFormat.format(overallMoney) : "");
            res[i++] = new CellValue(CellDataType.STRING, overallPaid != 0 ? decimalFormat.format(overallPaid) : "");
            res[i++] = new CellValue(CellDataType.STRING, overallInitialOwe + overallMoney - overallPaid != 0d ? decimalFormat.format(overallInitialOwe + overallMoney - overallPaid) : "-");
            res[i++] = new CellValue(CellDataType.STRING, "");
            ExcelUtil.addRow(sheet, startRow, res, boldCenterFormat, boldCenterFormat, boldCenterFormat, boldCenterFormat);
            sheet.mergeCells(0,startRow,3,startRow);
            workbook.write();
            workbook.close();
            response.sendRedirect(request.getSession().getServletContext().getContextPath() + outputFileName);
        }
        catch(Exception ex){
            logger.error(ex.getMessage(), ex);
        }
    }

}
