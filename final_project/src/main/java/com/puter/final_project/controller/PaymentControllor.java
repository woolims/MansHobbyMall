package com.puter.final_project.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.puter.final_project.dao.CartMapper;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class PaymentControllor {

    @Autowired
    HttpServletRequest request;

    @Autowired
    HttpSession session;

    @Autowired
	CartMapper cartMapper;

    // 최종 결제 금액
    @PostMapping("/user/updateQuantity1")
    @ResponseBody
    public ResponseEntity<Map<String, String>> updateQuantity() {

        Map<String, String> response = new HashMap<>();
        response.put("message", "수량이 성공적으로 업데이트되었습니다.");
        return ResponseEntity.ok(response);
    }

}
