package com.puter.final_project.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.puter.final_project.dao.ShopMapper;
import com.puter.final_project.util.MyCommon;
import com.puter.final_project.util.SportsPaging;
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
            @RequestParam(name = "categoryNo", defaultValue = "2") int categoryNo) {

        // 게시물의 범위 계산(start/end)
        int start = (nowPage - 1) * MyCommon.Shop.BLOCK_LIST + 1;
        int end = start + MyCommon.Shop.BLOCK_LIST - 1;

        Map<String, Object> map = new HashMap<String, Object>();
        map.put("start", start);
        map.put("end", end);

        List<ShopVo> list = shop_mapper.selectPageList(map);

        // 전체 게시물수
        int rowTotal = shop_mapper.selectRowTotalSports(categoryNo);

        // pageMenu만들기
        String pageMenu = SportsPaging.getPaging("sports.do", // pageURL
                nowPage, // 현재페이지
                rowTotal, // 전체게시물수
                MyCommon.Shop.BLOCK_LIST, // 한화면에 보여질 게시물수
                MyCommon.Shop.BLOCK_PAGE); // 한화면에 보여질 페이지수

        // 결과적으로 request binding
        model.addAttribute("list", list);
        model.addAttribute("pageMenu", pageMenu);

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
