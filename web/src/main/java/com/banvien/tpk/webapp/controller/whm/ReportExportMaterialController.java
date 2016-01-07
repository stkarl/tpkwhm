package com.banvien.tpk.webapp.controller.whm;

import com.banvien.tpk.core.Constants;
import com.banvien.tpk.core.domain.Warehouse;
import com.banvien.tpk.core.dto.ExportMaterialReportBean;
import com.banvien.tpk.core.dto.ExportMaterialReportDTO;
import com.banvien.tpk.core.dto.ExportMaterialReportDetailDTO;
import com.banvien.tpk.core.service.*;
import com.banvien.tpk.security.SecurityUtils;
import com.banvien.tpk.webapp.dto.CellDataType;
import com.banvien.tpk.webapp.dto.CellValue;
import com.banvien.tpk.webapp.editor.CustomDateEditor;
import com.banvien.tpk.webapp.util.DateUtils;
import com.banvien.tpk.webapp.util.ExcelUtil;
import jxl.Workbook;
import jxl.format.UnderlineStyle;
import jxl.write.*;
import org.apache.commons.lang.StringUtils;
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
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

@Controller
public class ReportExportMaterialController extends ApplicationObjectSupport {
    private transient final Log log = LogFactory.getLog(getClass());

    @Autowired
    private ExportmaterialbillService exportmaterialbillService;

    @Autowired
    private MaterialService materialService;

    @Autowired
    private MaterialcategoryService materialcategoryService;

    @Autowired
    private WarehouseService warehouseService;

    @Autowired
    private OriginService originService;


    @InitBinder
    public void initBinder(WebDataBinder binder) {
        binder.registerCustomEditor(Date.class, new CustomDateEditor("dd/MM/yyyy"));
    }

    @RequestMapping(value={"/whm/report/material/export.html"})
    public ModelAndView list(ExportMaterialReportBean bean,HttpServletRequest request, HttpServletResponse response) {
        ModelAndView mav = new ModelAndView("/whm/report/material/export");
        if(bean.getToDate() != null){
            bean.setToDate(DateUtils.move2TheEndOfDay(new Timestamp(bean.getToDate().getTime())));
        }
        String crudaction = bean.getCrudaction();
        if(crudaction !=null && StringUtils.isNotBlank(crudaction)){
            try {
                ExportMaterialReportDTO exportMaterialReport = this.exportmaterialbillService.reportExportMaterial(bean);
                if(crudaction.equalsIgnoreCase("report")){
                    mav.addObject("exportMaterialReport",exportMaterialReport);
                }
                if(crudaction.equalsIgnoreCase("export")){
                    mav.addObject("exportMaterialReport",exportMaterialReport);
                    exportReport2Excel(bean, exportMaterialReport, request, response);
                }
            } catch (Exception e) {
                log.error(e.getMessage(),e);
            }
        }
        addData2ModelMaterial(mav,bean);
        mav.addObject(Constants.LIST_MODEL_KEY, bean);
        return mav;
    }

    private void addData2ModelMaterial(ModelAndView mav, ExportMaterialReportBean bean){
        if (bean.getFromDate() == null){
            bean.setFromDate(new Date(System.currentTimeMillis()));
        }
        if (bean.getToDate() == null){
            bean.setToDate(new Date(System.currentTimeMillis()));
        }
        mav.addObject("origins", this.originService.findAll());
        List<Warehouse> warehouseList = new ArrayList<Warehouse>();
        if(SecurityUtils.getPrincipal().getWarehouseID() != null){
            Warehouse warehouse = this.warehouseService.findByIdNoCommit(SecurityUtils.getPrincipal().getWarehouseID());
            warehouseList.add(warehouse);
        }else{
            warehouseList = this.warehouseService.findAll();
        }
        mav.addObject("warehouses", warehouseList);
        mav.addObject("materials", this.materialService.findAll());
        mav.addObject("materialCategories", this.materialcategoryService.findAll());
    }


    private void exportReport2Excel(ExportMaterialReportBean bean, ExportMaterialReportDTO results, HttpServletRequest request, HttpServletResponse response) {
        try{
            String outputFileName = "/files/temp/BaoCaoNhapXuatTonNPL" + System.currentTimeMillis() + ".xls";
            String reportTemplate = request.getSession().getServletContext().getRealPath("/files/export/ExportMaterialReport.xls");
            String export2FileName = request.getSession().getServletContext().getRealPath(outputFileName);

            Workbook templateWorkbook = Workbook.getWorkbook(new File(reportTemplate));
            WritableWorkbook workbook = Workbook.createWorkbook(new File(export2FileName), templateWorkbook);

            WritableSheet sheet = workbook.getSheet(0);

            WritableFont normalFont = new WritableFont(WritableFont.TIMES, 12,
                    WritableFont.NO_BOLD, false,
                    UnderlineStyle.NO_UNDERLINE,
                    jxl.format.Colour.BLACK);
            WritableCellFormat normalFormat = new WritableCellFormat(normalFont);
            normalFormat.setAlignment(Alignment.LEFT);
            normalFormat.setWrap(true);
            normalFormat.setBorder(jxl.format.Border.ALL, jxl.format.BorderLineStyle.THIN);

            WritableFont boldFont = new WritableFont(WritableFont.TIMES, 12,
                    WritableFont.BOLD, false,
                    UnderlineStyle.NO_UNDERLINE,
                    jxl.format.Colour.BLACK);
            WritableCellFormat headerFormat = new WritableCellFormat(boldFont);
            headerFormat.setAlignment(Alignment.CENTRE);
            headerFormat.setVerticalAlignment(VerticalAlignment.CENTRE);
            headerFormat.setWrap(true);
            headerFormat.setBorder(jxl.format.Border.ALL, jxl.format.BorderLineStyle.THIN);
            headerFormat.setBackground(jxl.format.Colour.GRAY_25);

            WritableCellFormat boldFormat = new WritableCellFormat(boldFont);
            boldFormat.setAlignment(Alignment.CENTRE);
            boldFormat.setWrap(true);
            boldFormat.setBorder(jxl.format.Border.ALL, jxl.format.BorderLineStyle.THIN);

            DecimalFormat decimalFormat = new DecimalFormat("###,###.##");

            Date from =  bean.getFromDate();
            Label fromCell = new Label(1, 1, from != null ? DateUtils.date2String(from,"dd/MM/yyyy") : "", boldFormat);
            sheet.addCell(fromCell);


            Date to =  bean.getToDate();
            Label toCell = new Label(1, 2, to != null ? DateUtils.date2String(to,"dd/MM/yyyy") : "", boldFormat);
            sheet.addCell(toCell);

            int startRow = 5;
            List<ExportMaterialReportDetailDTO> initialValue = results.getInitialValue();
            Map<String,Double> mapImportValue = results.getMapImportValue();
            Map<String,Double> mapExportUtilDateValue = results.getMapExportUtilDateValue();
            Map<String,Double> mapExportDuringDateValue = results.getMapExportDuringDateValue();
            int index;
            CellValue[] resValue;
            Double iVal;
            Double exportToVal;
            Double importVal;
            Double exportVal;
            Double remainVal;
            String key, origin;
            for(ExportMaterialReportDetailDTO initVal : initialValue){
                origin = initVal.getOrigin() != null ? initVal.getOrigin().getOriginID().toString() : "";
                key = initVal.getMaterial().getMaterialID() + "_" + origin;
                exportToVal = mapExportUtilDateValue.get(key) != null ? mapExportUtilDateValue.get(key) : 0d;
                iVal = initVal.getQuantity() != null ? initVal.getQuantity() - exportToVal : 0 - exportToVal;
                importVal = mapImportValue.get(key) != null ? mapImportValue.get(key) : 0d;
                exportVal = mapExportDuringDateValue.get(key) != null ? mapExportDuringDateValue.get(key) : 0d;
                remainVal = iVal + importVal - exportVal;
                index = 0;
                resValue = new CellValue[10];

                resValue[index++] = new CellValue(CellDataType.STRING, initVal.getOrigin() != null ? initVal.getOrigin().getName() : "");
                resValue[index++] = new CellValue(CellDataType.STRING, initVal.getMaterial() != null ? initVal.getMaterial().getName() : "");
                resValue[index++] = new CellValue(CellDataType.STRING, StringUtils.isNotBlank(initVal.getCode()) ? initVal.getCode() : "");
                resValue[index++] = new CellValue(CellDataType.STRING, initVal.getMaterial() != null ? initVal.getMaterial().getUnit() != null ? initVal.getMaterial().getUnit().getName() : "" : "");
                resValue[index++] = new CellValue(CellDataType.STRING, decimalFormat.format(iVal));
                resValue[index++] = new CellValue(CellDataType.STRING, decimalFormat.format(importVal));
                resValue[index++] = new CellValue(CellDataType.STRING, decimalFormat.format(exportVal));
                resValue[index++] = new CellValue(CellDataType.STRING, decimalFormat.format(remainVal));
                resValue[index++] = new CellValue(CellDataType.STRING, "");
                resValue[index++] = new CellValue(CellDataType.STRING, initVal.getImportDate() != null ? DateUtils.date2String(initVal.getImportDate(),"dd/MM/yyyy") : "");

                ExcelUtil.addRow(sheet, startRow++, resValue,normalFormat,normalFormat,normalFormat,normalFormat);
            }
            workbook.write();
            workbook.close();
            response.sendRedirect(request.getSession().getServletContext().getContextPath() + outputFileName);
        }
        catch(Exception ex){
            logger.error(ex.getMessage(), ex);
        }
    }
}
