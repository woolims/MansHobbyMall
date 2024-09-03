package com.puter.final_project.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.security.SecurityProperties.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.puter.final_project.dao.AdminMapper;
import com.puter.final_project.vo.UserVo;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/admin/")
public class AdminController {

    // 자동연결(요청시 마다 Injection)
    @Autowired
    HttpServletRequest request;

    @Autowired
    HttpSession session;

    @Autowired
    AdminMapper adminMapper;

    // 회원전체목록
    // @RequestMapping("admin.do")
    // public String list(Model model) {

    // List<UserVo> list = adminMapper.selectList();
    // UserVo user = (UserVo) session.getAttribute("user");

    // // 회원 관리 불러오기
    // List<UserVo> list = .selectListMyBid(user.getUserNo());
    // // 상품 관리 불러오기
    // List<AboardVo> list2 = .selectListMySb(user.getUserNo());
    // // 주문 관리 불러오기
    // List<AboardVo> list3 = aboard_dao.selectListMyAuc(user.getUserNo());
    // // 공지사항 관리 불러오기
    // List<AboardVo> list4 = aboard_dao.selectListMySc(user.getUserNo());

    // model.addAttribute("list", list);
    // model.addAttribute("list2", list2);
    // model.addAttribute("list3", list3);
    // model.addAttribute("list4", list4);

    // return "redirect:user/admin.do";
    // }

}
