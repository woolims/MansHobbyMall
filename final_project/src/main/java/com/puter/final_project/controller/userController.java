package com.puter.final_project.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.puter.final_project.dao.UserMapper;
import com.puter.final_project.vo.UserVo;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/user/")
public class UserController {

    // 자동연결(요청시 마다 Injection)
    @Autowired
    HttpServletRequest request;

    @Autowired
    HttpSession session;

    // 처음에 1회연결
    @Autowired
    UserMapper userMapper;

    // 회원전체목록
    @RequestMapping("list.do")
    public String list(Model model) {

        List<UserVo> list = userMapper.selectList();

        model.addAttribute("list", list);

        return "home";
    }

}
