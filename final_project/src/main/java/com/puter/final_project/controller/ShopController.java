package com.puter.final_project.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.puter.final_project.dao.ShopMapper;
import com.puter.final_project.vo.ShopVo;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class ShopController {

    @Autowired
    ShopMapper shop_mapper;

    @Autowired
    HttpServletRequest request;

    @Autowired
    HttpSession session;

    // main 페이지 이동
    @RequestMapping("/home.do")
    public String home() {

        return "home";
    }

    // 스포츠카테고리 전체조회
    @RequestMapping("/sports.do")
    public String sports(@RequestParam(name = "page", defaultValue = "1") int nowPage, Model model,
            @RequestParam(name = "categoryNo", defaultValue = "2") int categoryNo,
            @RequestParam(name = "mcategoryNo", defaultValue = "1") int mcategoryNo,
            @RequestParam(name = "mcategoryName", defaultValue = "emptyMcategoryName") String mcategoryName,
            @RequestParam(name = "dcategoryName", defaultValue = "emptyDcategoryName") String dcategoryNameParam) {

        List<ShopVo> mCategoryNameList = shop_mapper.selectMCategoryNameList(categoryNo);

        ShopVo shop = new ShopVo();
        shop.setCategoryNo(categoryNo);
        shop.setMcategoryNo(mcategoryNo);
        shop.setDcategoryName(dcategoryNameParam);

        if (!mcategoryName.equals("emptyMcategoryName")) {
            shop.setMcategoryName(mcategoryName);
            int mCategoryNo = shop_mapper.selectMCategoryNo(shop);
            List<ShopVo> dCategoryName = shop_mapper.selectdCategoryNameList(mCategoryNo);
            List<ShopVo> productMCategoryList = shop_mapper.selectProductMCategoryList(mCategoryNo);
            model.addAttribute("dCategoryName", dCategoryName);
            model.addAttribute("productList", productMCategoryList);
            if (!dcategoryNameParam.equals("emptyDcategoryName")) {
                int dCategoryNo = shop_mapper.selectDCategoryNo(shop);
                List<ShopVo> productDCategoryList = shop_mapper.selectProductDCategoryList(dCategoryNo);
                model.addAttribute("productList", productDCategoryList);
            }
        }
        if (mcategoryName.equals("emptyMcategoryName") && dcategoryNameParam.equals("emptyDcategoryName")) {

            List<ShopVo> productList = shop_mapper.selectListSports(categoryNo);
            model.addAttribute("productList", productList);

        }
        if (mcategoryName.equals("emptyMcategoryName")) {
            model.addAttribute("mcategoryName", mcategoryName);
        }
        model.addAttribute("shop", shop);
        model.addAttribute("mCategoryNameList", mCategoryNameList);
        System.out.println(mcategoryName);
        return "shopPage/sportsMain";
    }

    // 게임카테고리 전체조회
    @RequestMapping("/game.do")
    public String game() {

        return "shopPage/gameMain";
    }

    // 마이페이지 이동
    @RequestMapping("/mypage.do")
    public String mypage() {

        return "shopPage/mypage";
    }

    // 고객센터 이동
    @RequestMapping("/inquiry.do")
    public String inquiry() {

        return "shopPage/inquiry";
    }

    @RequestMapping("/product_insert.do")
    public String product_insert() {

        return "shopPage/productInsert";
    }
}
