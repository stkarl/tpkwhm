package com.banvien.tpk.webapp.controller.game;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

/**
 * Created with IntelliJ IDEA.
 * User: tdtran
 * Date: 2/29/16
 * Time: 2:11 PM
 * To change this template use File | Settings | File Templates.
 */
@Controller
public class PanBalanceGameController {
    @RequestMapping(value = {"/game/pan_balance/panBalance.html"})
    public ModelAndView showGame(@RequestParam(value = "grade", required = false) Long grade) {
        ModelAndView view = new ModelAndView("/games/panBalance/panBalance");
        return view;
    }
    @RequestMapping(value = {"/game/attribute_block/attributeBlock.html"})
    public ModelAndView attributeBlock() {
        ModelAndView view = new ModelAndView("/games/attributeBlock/attributeBlock");
        return view;
    }
}
