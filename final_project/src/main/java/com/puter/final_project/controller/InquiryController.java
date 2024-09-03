package com.puter.final_project.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.puter.final_project.dao.InquiryMapper;
import com.puter.final_project.vo.InquiryVo;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/inquiry/")
public class InquiryController {

    @Autowired
    HttpServletRequest request;

    @Autowired
    HttpSession session;

    @Autowired
    InquiryMapper inquiryMapper;

    @RequestMapping("inquiry.do")
    public String list(Model model) {

        List<InquiryVo> list = inquiryMapper.selectList();

        model.addAttribute("list", list);

        return "inquiry/inquiry";
    }

}
