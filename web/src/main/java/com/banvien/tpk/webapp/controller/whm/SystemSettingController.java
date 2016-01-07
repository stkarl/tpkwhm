package com.banvien.tpk.webapp.controller.whm;

import com.banvien.tpk.core.domain.Setting;
import com.banvien.tpk.core.dto.SettingBean;
import com.banvien.tpk.core.service.SettingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.ApplicationObjectSupport;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller
public class SystemSettingController extends ApplicationObjectSupport {
    @Autowired
    private SettingService settingService;

    @RequestMapping(value = "/whm/system/setting.html")
    public ModelAndView setting(@ModelAttribute("items") SettingBean bean) {
        ModelAndView mav = new ModelAndView("/whm/system/setting");

        if ("insert-update".equalsIgnoreCase(bean.getCrudaction())) {
            try{
                settingService.saveOrUpdateAll(bean.getSettings());
                mav.addObject("messageResponse", getMessageSourceAccessor().getMessage("setting.update.successful"));

            }catch (Exception e) {
                mav.addObject("messageResponse", getMessageSourceAccessor().getMessage("setting.update.failed"));
            }
        }else{
            List<Setting> settings = settingService.findSetting4WithPrefix("whm.system");
            bean.setSettings(settings);
            bean.setTotalItems(settings.size());
        }
        mav.addObject("items", bean);

        return mav;
    }
}
