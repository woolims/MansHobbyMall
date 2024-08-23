package com.puter.final_project.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class userController {

    // main 페이지 이동
    @RequestMapping("/home.do")
    public String home() {

        return "home";
    }

}
