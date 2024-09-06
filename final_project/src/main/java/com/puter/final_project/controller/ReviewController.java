package com.puter.final_project.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.puter.final_project.dao.ReviewMapper;
import com.puter.final_project.vo.InquiryVo;
import com.puter.final_project.vo.ReviewVo;
import com.puter.final_project.vo.UserVo;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/review/")
public class ReviewController {

    @Autowired
    HttpServletRequest request;

    @Autowired
    HttpSession session;

    @Autowired
    ReviewMapper reviewMapper;

    @RequestMapping("review.do")
    public String list(Model model) {

        // 전체 리뷰 불러오기
        List<ReviewVo> list = reviewMapper.getAllReviews();

        model.addAttribute("list", list);

        return "shopPage/review";
    }

    // 게시글 작성
    @RequestMapping("reviewWrite.do")
    public String reviewWrite(ReviewVo vo) {

        UserVo user = (UserVo) session.getAttribute("user");

        vo.setUserIdx(user.getUserIdx());

        int res = reviewMapper.insertReview(vo);

        return "redirect:review.do";
    }

    @RequestMapping("delete.do")
    public String delete(int rvIdx) {
        int res = reviewMapper.deleteReview(rvIdx);

        if (res > 0) {
            session.setAttribute("alertMsg", "삭제되었습니다.");
        } else {
            session.setAttribute("alertMsg", "삭제 실패했습니다.");
        }

        return "redirect:review.do";
    }

}
