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

    @RequestMapping("/sports.do")
    public String sports() {

        return "shopPage/sports";
    }

    @RequestMapping("/game.do")
    public String game() {

        return "shopPage/game";
    }
}
