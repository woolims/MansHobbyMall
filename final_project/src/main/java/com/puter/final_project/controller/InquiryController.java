package com.puter.final_project.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.puter.final_project.dao.InquiryMapper;
import com.puter.final_project.vo.InquiryVo;
import com.puter.final_project.vo.UserVo;

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

    // 고객문의 페이지
    @RequestMapping("inquiry.do")
    public String inquiry(Model model) {

        List<InquiryVo> list = inquiryMapper.selectList();

        model.addAttribute("list", list);

        return "inquiry/inquiry";
    }

    // 게시글 작성폼 이동
    @RequestMapping("inquiryWriteForm.do")
    public String inquiryWriteForm() {

        return "inquiry/inquiryWriteForm";
    }

    // 게시글 작성
    @RequestMapping("inquiryWrite.do")
    public String inquiryWrite(InquiryVo vo) {

        UserVo user = (UserVo) session.getAttribute("user");

        vo.setUserIdx(user.getUserIdx());

        int res = inquiryMapper.inquiryInsert(vo);

        return "redirect:inquiry.do";
    }

}
