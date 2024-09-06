package com.puter.final_project.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

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
        List<ReviewVo> list = reviewMapper.selectList();

        model.addAttribute("list", list);

        return "shopPage/review";
    }

    // 리뷰 작성
    @RequestMapping("reviewWriteForm.do")
    public String reviewWriteForm() {

        return "shopPage/reviewWriteForm";
    }

    @RequestMapping("reviewWrite.do")
    public String reviewWrite(ReviewVo vo, HttpSession session, Model model) {

        UserVo user = (UserVo) session.getAttribute("user");

        // 유저 정보 세팅
        vo.setUserIdx(user.getUserIdx());

        // 데이터 삽입
        int res = reviewMapper.insertReview(vo);

        if (res > 0) {
            return "redirect:review.do";
        } else {
            model.addAttribute("error", "리뷰 작성에 실패했습니다.");
            return "redirect:review.do"; // 실패 시 에러 메시지와 함께 폼으로 돌아감
        }
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

    @GetMapping("getReviewInfo.do")
    public ResponseEntity<ReviewVo> getReviewInfo(@RequestParam("rvIdx") int rvIdx) {
        ReviewVo reviewVo = reviewMapper.getReviewInfo(rvIdx);
        if (reviewVo != null) {
            return ResponseEntity.ok(reviewVo); // 200 OK와 함께 JSON 반환
        } else {
            return ResponseEntity.notFound().build(); // 404 Not Found
        }
    }

    @RequestMapping("/reviewModify.do")
    public String modifyReview(ReviewVo vo) {
        reviewMapper.updateReview(vo);
        return "redirect:review.do";
    }

}
