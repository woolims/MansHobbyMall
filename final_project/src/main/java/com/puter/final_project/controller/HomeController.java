package com.puter.final_project.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import com.puter.final_project.dao.UserMapper;

import com.puter.final_project.vo.UserVo;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class HomeController {

	// 자동연결(요청시 마다 Injection)
	@Autowired
	HttpServletRequest request;

	@Autowired
	HttpSession session;

    @Autowired
    private UserMapper userMapper;

    @GetMapping("loginTest/home.do")
    public String home(Model model) {
        // 현재 인증된 사용자 정보 가져오기
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && authentication.getPrincipal() instanceof OAuth2User) {
            OAuth2User oauth2User = (OAuth2User) authentication.getPrincipal();

            String email = oauth2User.getAttribute("email");
            String esite = "google";

            // 사용자 정보를 모델에 추가
            model.addAttribute("name", oauth2User.getAttribute("name"));
            model.addAttribute("email", email);

            UserVo user = userMapper.selectOneFromEmail(email, esite);
            if(user != null){
                //로그인 처리
                session.setAttribute("user", user);
            }
            else {
                //회원가입으로 넘기기
            }

        }
        return "test"; // home.jsp로 이동
    }

}
