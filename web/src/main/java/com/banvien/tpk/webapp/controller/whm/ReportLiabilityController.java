package com.banvien.tpk.webapp.controller.whm;

import com.banvien.tpk.core.Constants;
import com.banvien.tpk.core.dto.ReportBean;
import com.banvien.tpk.core.dto.SummaryLiabilityDTO;
import com.banvien.tpk.core.service.*;
import com.banvien.tpk.webapp.dto.CellDataType;
import com.banvien.tpk.webapp.dto.CellValue;
import com.banvien.tpk.webapp.editor.CustomDateEditor;
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
public class ReportLiabilityController extends ApplicationObjectSupport {
    private transient final Log log = LogFactory.getLog(getClass());

    @Autowired
    private RegionService regionService;

    @Autowired
    private ProvinceService provinceService;

    @Autowired
    private CustomerService customerService;

    @Autowired
    private UserService userService;

    @Autowired
    private ImportproductService importProductService;

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        binder.registerCustomEditor(Date.class, new CustomDateEditor("dd/MM/yyyy"));
    }

    @RequestMapping(value={"/whm/report/liability.html"})
    public ModelAndView list(ReportBean bean,HttpServletRequest request,HttpServletResponse response) {
        ModelAndView mav = new ModelAndView("/whm/report/liability");
        if(bean.getToDate() != null){
            bean.setToDate(DateUtils.move2TheEndOfDay(new Timestamp(bean.getToDate().getTime())));
        }else {
            bean.setToDate(new Date(System.currentTimeMillis()));
        }
        if(bean.getCrudaction() != null && ("report".equals(bean.getCrudaction()) || "export".equals(bean.getCrudaction()))){
            List<SummaryLiabilityDTO> results = this.importProductService.summaryLiability(bean);
            if(results != null && results.size() > 0){
                mav.addObject("results",results);
            }
            if(bean.getCrudaction() != null && "export".equals(bean.getCrudaction())){
                exportLiabilitySummary2Excel(bean, results, request, response);
            }
        }
        addData2ModelProduct(mav);
        mav.addObject(Constants.LIST_MODEL_KEY, bean);
        return mav;
    }

    private void addData2ModelProduct(ModelAndView mav){
        mav.addObject("regions", regionService.findAllSortAsc());
        mav.addObject("provinces", provinceService.findAll());
        mav.addObject("users",this.userService.findByRole(Constants.NVKD_ROLE));
        mav.addObject("customers",this.customerService.findAll());
    }

    private void exportLiabilitySummary2Excel(ReportBean bean, List<SummaryLiabilityDTO> results, HttpServletRequest request, HttpServletResponse response) {
        try{
            String outputFileName = "/files/temp/Bao_Cao_Cong_No_" + System.currentTimeMillis() + ".xls";
            String reportTemplate = request.getSession().getServletContext().getRealPath("/files/export/BaoCaoCongNo.xls");
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

            Label toDate = new Label(3, 1,DateUtils.date2String(bean.getToDate(),"dd/MM/yyyy") , normalFormat);
            sheet.addCell(toDate);

            int startRow = 4;
            int stt = 1;
            Double overallInitialOwe = 0d;
            Double overallMoney = 0d;
            Double overallPaid = 0d;
            for(SummaryLiabilityDTO summaryLiabilityDTO : results){

                Double initialOwe = summaryLiabilityDTO.getInitialOwe() != null ? summaryLiabilityDTO.getInitialOwe() : 0d;
                Double money = summaryLiabilityDTO.getBought() != null ? summaryLiabilityDTO.getBought() : 0d;
                Double paid = summaryLiabilityDTO.getPaid() != null ? summaryLiabilityDTO.getPaid() : 0d;

                overallInitialOwe += initialOwe;
                overallMoney += money;
                overallPaid += paid;

                CellValue[] res = new CellValue[9];
                int i = 0;
                res[i++] = new CellValue(CellDataType.STRING, stt++);
                res[i++] = new CellValue(CellDataType.STRING, summaryLiabilityDTO.getCustomerName());
                res[i++] = new CellValue(CellDataType.STRING, summaryLiabilityDTO.getProvince());
                res[i++] = new CellValue(CellDataType.STRING, summaryLiabilityDTO.getArisingDate() != null ? DateUtils.date2String(summaryLiabilityDTO.getArisingDate(),"dd/MM/yyyy") : "");
                res[i++] = new CellValue(CellDataType.STRING, summaryLiabilityDTO.getDueDate() != null ? DateUtils.date2String(summaryLiabilityDTO.getDueDate(),"dd/MM/yyyy") : "");
                res[i++] = new CellValue(CellDataType.STRING, initialOwe != 0 ? decimalFormat.format(initialOwe) : "-");
                res[i++] = new CellValue(CellDataType.STRING, money != 0 ? decimalFormat.format(money) : "-");
                res[i++] = new CellValue(CellDataType.STRING, paid != 0 ? decimalFormat.format(paid) : "-");
                res[i++] = new CellValue(CellDataType.STRING, initialOwe + money - paid != 0d ? decimalFormat.format(initialOwe + money - paid) : "-");
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

            CellValue[] res = new CellValue[9];
            int i = 0;
            res[i++] = new CellValue(CellDataType.STRING, "Tổng cộng");
            res[i++] = new CellValue(CellDataType.STRING, "");
            res[i++] = new CellValue(CellDataType.STRING, "");
            res[i++] = new CellValue(CellDataType.STRING, "");
            res[i++] = new CellValue(CellDataType.STRING, "");
            res[i++] = new CellValue(CellDataType.STRING, "");
            res[i++] = new CellValue(CellDataType.STRING, overallMoney != 0 ? decimalFormat.format(overallMoney) : "");
            res[i++] = new CellValue(CellDataType.STRING, overallPaid != 0 ? decimalFormat.format(overallPaid) : "");
            res[i++] = new CellValue(CellDataType.STRING, overallInitialOwe + overallMoney - overallPaid != 0d ? decimalFormat.format(overallInitialOwe + overallMoney - overallPaid) : "-");
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


    @RequestMapping(value={"/whm/report/customer_active.html"})
    public ModelAndView cusActive(ReportBean bean,HttpServletRequest request,HttpServletResponse response) {
        ModelAndView mav = new ModelAndView("/whm/report/customer_active");
        if(bean.getToDate() != null){
            bean.setToDate(DateUtils.move2TheEndOfDay(new Timestamp(bean.getToDate().getTime())));
        }else {
            bean.setToDate(new Date(System.currentTimeMillis()));
        }
        if(bean.getCrudaction() != null && ("report".equals(bean.getCrudaction()) || "export".equals(bean.getCrudaction()))){
            List<SummaryLiabilityDTO> results = this.importProductService.summaryLiability(bean);
            if(results != null && results.size() > 0){
                mav.addObject("results",results);
            }
            if(bean.getCrudaction() != null && "export".equals(bean.getCrudaction())){
                exportLiabilitySummary2Excel(bean, results, request, response);
            }
        }
        addData2ModelProduct(mav);
        mav.addObject(Constants.LIST_MODEL_KEY, bean);
        return mav;
    }
}
