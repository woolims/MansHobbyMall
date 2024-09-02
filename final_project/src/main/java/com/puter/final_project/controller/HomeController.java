package com.puter.final_project.controller;

import org.springframework.security.core.Authentication;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class HomeController {

    @GetMapping("/loginTest/home.do")
    public ModelAndView test() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && authentication.getPrincipal() instanceof OAuth2User) {
            OAuth2User oauth2User = (OAuth2User) authentication.getPrincipal();
            // 속성 확인을 위해 로그에 기록
            oauth2User.getAttributes().forEach((key, value) -> System.out.println(key + ": " + value));
            return new ModelAndView("test").addObject("user", oauth2User);
        }
        return new ModelAndView("error").addObject("message", "User not authenticated.");
    }

}
