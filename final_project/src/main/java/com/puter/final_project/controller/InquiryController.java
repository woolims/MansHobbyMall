package com.puter.final_project.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

        // 1. parameter 받기
		String search		= request.getParameter("search");
		String search_text	= request.getParameter("search_text");
		
		if(search == null) search="all";
		
		// 검색조건을 담을 맵
		Map<String, String> map = new HashMap<String, String>();
		
		// 이름 + 제목
		if(search.equals("name")) {
			
			map.put("name", search_text);
			map.put("inType", search_text);
			
		} else if(search.equals("name")) {		// search == "name" (X)
			
			// 이름
			map.put("name", search_text);
			
		} else if(search.equals("inType")) {	
			
			// 제목
			map.put("inType", search_text);
			
		}
        List<InquiryVo> list = inquiryMapper.selectByCondition(map);

        model.addAttribute("list", list);

        return "inquiry/inquiry";
    }

    // 게시글 상세 조회
    @RequestMapping("inquirySelect.do")
    public String inquirySelect(int inIdx, Model model) {

        InquiryVo vo = inquiryMapper.selectOne(inIdx);

        model.addAttribute("vo", vo);

        return "inquiry/inquirySelect";
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

    // 게시글 삭제
    @RequestMapping("inquiryDelete.do")
    public String inquiryDelete(int inIdx) {

        int res = inquiryMapper.delete(inIdx);

        return "redirect:inquiry.do";
    }

    // 게시글 수정폼 이동
    @RequestMapping("inquiryModifyForm.do")
    public String inquiryModifyForm(int inIdx, Model model) {

        InquiryVo vo = inquiryMapper.selectOne(inIdx);

        model.addAttribute("vo", vo);

        return "inquiry/inquiryModifyForm";
    }

    // 게시글 수정
    @RequestMapping("inquiryModify.do")
    public String inquiryModify(InquiryVo vo) {

        int res = inquiryMapper.update(vo);

        return "redirect:inquiry.do";
    }

}
