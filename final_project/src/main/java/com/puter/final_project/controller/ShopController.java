package com.puter.final_project.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ShopController {

    // main 페이지 이동
    @RequestMapping("/home.do")
    public String home() {

        return "home";
    }

    // 스포츠카테고리 전체조회
    @RequestMapping("/sports.do")
    public String sports() {

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
