package com.puter.final_project.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.puter.final_project.dao.ReviewMapper;
import com.puter.final_project.vo.ReviewLikeVo;
import com.puter.final_project.vo.ReviewVo;
import com.puter.final_project.vo.UserVo;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import net.minidev.json.JSONObject;

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
    public String reviewWrite(ReviewVo vo, String url, HttpSession session, Model model) {

        UserVo user = (UserVo) session.getAttribute("user");

        // 유저 정보 세팅
        vo.setUserIdx(user.getUserIdx());

        // 데이터 삽입
        int res = reviewMapper.insertReview(vo);

        if (res > 0) {
            return "redirect:"+url;
        } else {
            model.addAttribute("error", "리뷰 작성에 실패했습니다.");
            return "redirect:"+url; // 실패 시 에러 메시지와 함께 폼으로 돌아감
        }
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

    @RequestMapping(value = "toggle.do", produces = "application/json; charset=utf-8;")
    @ResponseBody
    public String toggle(@RequestParam("rvIdx") int rvIdx) {
        UserVo user = (UserVo) session.getAttribute("user"); // 세션에서 userIdx 가져오기
        
        JSONObject json = new JSONObject();
        if (user == null) {
            json.put("result", "failure");
            json.put("message", "로그인이 필요합니다.");
            return json.toString();
        }

        ReviewLikeVo vo = new ReviewLikeVo();
        vo.setRvIdx(rvIdx);
        vo.setUserIdx(user.getUserIdx());

        ReviewVo rvo = reviewMapper.getReviewByLike(vo);
        if(rvo != null){
            vo.setRfIdx(rvo.getRfIdx());
        }

        boolean isLiked = reviewMapper.LikedByUser(vo) > 0;
        int res;

        if (isLiked) {
            // 좋아요 취소
            res = reviewMapper.deleteLike(vo);
            json.put("action", "removed");
        } else {
            // 좋아요 추가
            res = reviewMapper.insertLike(vo);
            json.put("action", "added");
        }

        int likeCount = reviewMapper.countLikes(rvIdx); // 리뷰의 최신 좋아요 수 조회
        json.put("count", likeCount);
        json.put("result", res == 1 ? "success" : "failure");
        return json.toString();
    }

    @RequestMapping(value = "count.do", produces = "application/json; charset=utf-8;")
    @ResponseBody
    public String count(@RequestParam("rvIdx") int rvIdx) {
        int count = reviewMapper.countLikes(rvIdx);

        JSONObject json = new JSONObject();
        json.put("count", count);
        return json.toString();
    }

    @RequestMapping(value = "isLiked.do", produces = "application/json; charset=utf-8;")
    @ResponseBody
    public String isLiked(@RequestParam("rvIdx") int rvIdx) {
        Integer userIdx = (Integer) request.getSession().getAttribute("userIdx"); // 세션에서 userIdx 가져오기
    
        JSONObject json = new JSONObject();
        if (userIdx == null) {
            json.put("isLiked", false);
            return json.toString();
        }
    
        ReviewLikeVo vo = new ReviewLikeVo();
        vo.setRvIdx(rvIdx);
        vo.setUserIdx(userIdx);
    
        boolean isLiked = reviewMapper.LikedByUser(vo) > 0;
    
        json.put("isLiked", isLiked);
        return json.toString();
    }
   
    @RequestMapping(value = "deleteReview.do", produces = "application/json; charset=utf-8;")
    @ResponseBody
    public String deleteReview(@RequestParam("rvIdx") int rvIdx) {
        System.out.println("=================== rvIdx ================="+rvIdx);
        int res = reviewMapper.deleteByReview(rvIdx);
        System.out.println("=================== res ================="+res);

        JSONObject json = new JSONObject();
        json.put("result", res > 0 ? "success" : "failure");
        return json.toString();
    }
}
