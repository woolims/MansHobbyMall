package com.puter.final_project.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.puter.final_project.dao.AnswerMapper;
import com.puter.final_project.vo.AnswerVo;

import ch.qos.logback.core.model.Model;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import net.minidev.json.JSONObject;

@Controller
@RequestMapping("/answer/")
public class AnswerController {

    @Autowired
    HttpServletRequest request;

    @Autowired
    HttpSession session;

    @Autowired
    AnswerMapper answerMapper;

    @RequestMapping("answer.do")
    public String list(int inIdx, Model model) {

        return "";
    }

    // inquiry 답글 작성
    @RequestMapping(value = "insert.do", produces = "application/json; charset=utf-8;")
    @ResponseBody
    public String insert(AnswerVo vo) {
        String aContent = vo.getAContent().replaceAll("\n", "<br>");
        vo.setAContent(aContent);
        int res = answerMapper.insert(vo);
        JSONObject json = new JSONObject();
        json.put("result", res == 1);
        return json.toString();
    }
}
