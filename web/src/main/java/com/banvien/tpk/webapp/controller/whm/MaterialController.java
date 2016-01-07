package com.banvien.tpk.webapp.controller.whm;

import com.banvien.tpk.core.Constants;
import com.banvien.tpk.core.domain.Material;
import com.banvien.tpk.core.domain.MaterialAndCategory;
import com.banvien.tpk.core.domain.Region;
import com.banvien.tpk.core.dto.MaterialBean;
import com.banvien.tpk.core.exception.DuplicateException;
import com.banvien.tpk.core.exception.ObjectNotFoundException;
import com.banvien.tpk.core.service.MaterialService;
import com.banvien.tpk.core.service.MaterialcategoryService;
import com.banvien.tpk.core.service.RegionService;
import com.banvien.tpk.core.service.UnitService;
import com.banvien.tpk.webapp.editor.PojoEditor;
import com.banvien.tpk.webapp.util.RequestUtil;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.ApplicationObjectSupport;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

@Controller
public class MaterialController extends ApplicationObjectSupport {
    private transient final Log log = LogFactory.getLog(getClass());

    @Autowired
    private MaterialService materialService;

    @Autowired
    private MaterialcategoryService materialcategoryService;

    @Autowired
    private UnitService unitService;

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        binder.registerCustomEditor(Region.class, new PojoEditor(Region.class, "regionID", Long.class));
	}
    
    @RequestMapping("/whm/material/edit.html")
	public ModelAndView edit(@ModelAttribute(Constants.FORM_MODEL_KEY) MaterialBean materialBean, BindingResult bindingResult) {
		ModelAndView mav = new ModelAndView("/whm/material/edit");

		String crudaction = materialBean.getCrudaction();
		Material pojo = materialBean.getPojo();
		if(StringUtils.isNotBlank(crudaction) && crudaction.equals("insert-update")) {
			try {
				if(!bindingResult.hasErrors()) {
					if(pojo.getMaterialID() != null && pojo.getMaterialID() > 0) {
						this.materialService.updateItem(materialBean);
                        mav = new ModelAndView("redirect:/whm/material/list.html?isUpdate=true");
					} else {
						this.materialService.addNew(materialBean);
                        mav = new ModelAndView("redirect:/whm/material/list.html?isAdd=true");
					}
                    return mav;
				}
			}catch (ObjectNotFoundException oe) {
				logger.error(oe.getMessage());
				mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("database.exception.keynotfound"));
                mav = new ModelAndView("redirect:/whm/material/list.html?isError=true");
            }catch (DuplicateException de) {
				logger.error(de.getMessage());
				mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("database.exception.duplicate"));
                mav = new ModelAndView("redirect:/whm/material/list.html?isError=true");
			}catch(Exception e) {
				logger.error(e.getMessage(), e);
				mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("general.exception.msg"));
                mav = new ModelAndView("redirect:/whm/material/list.html?isError=true");
			}
		}
		if(!bindingResult.hasErrors()&& materialBean.getPojo().getMaterialID() != null && materialBean.getPojo().getMaterialID() > 0) {
			try {
                Material itemObj = this.materialService.findById(pojo.getMaterialID());
				materialBean.setPojo(itemObj);
                if(itemObj.getMaterialAndCategories() != null){
                    List<Long> materialCategoryIDs = new ArrayList<Long>();
                    for(MaterialAndCategory materialAndCategory : itemObj.getMaterialAndCategories()){
                        materialCategoryIDs.add(materialAndCategory.getMaterialCategory().getMaterialCategoryID());
                    }
                    materialBean.setMaterialCategoryIDs(materialCategoryIDs);
                }
			}
			catch (Exception e) {
				logger.error("Could not found item " + materialBean.getPojo().getMaterialID(), e);
			}
		}
        referenceData(mav);
		mav.addObject(Constants.FORM_MODEL_KEY, materialBean);
		return mav;
	}

    private void referenceData(ModelAndView mav) {
        mav.addObject("materialcategorys", materialcategoryService.findAll());
        mav.addObject("units", unitService.findAll());
    }


    @RequestMapping(value={"/whm/material/list.html"})
    public ModelAndView list(MaterialBean bean, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("/whm/material/list");
		if(StringUtils.isNotBlank(bean.getCrudaction()) && bean.getCrudaction().equals(Constants.ACTION_DELETE)) {
			Integer totalDeleted = 0;
			try {
				totalDeleted = materialService.deleteItems(bean.getCheckList());
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

    private void executeSearch(MaterialBean bean, HttpServletRequest request) {
        RequestUtil.initSearchBean(request, bean);

        Object[] results = this.materialService.searchByBean(bean);
        bean.setListResult((List<Material>)results[1]);
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
}
