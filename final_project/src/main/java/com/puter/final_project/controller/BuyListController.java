package com.puter.final_project.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.puter.final_project.dao.BuyListMapper;
import com.puter.final_project.dao.CouponBoxMapper;
import com.puter.final_project.vo.BuyListVo;
import com.puter.final_project.vo.UserVo;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/buyList/")
public class BuyListController {

    @Autowired
    HttpServletRequest request;

    @Autowired
    HttpSession session;

    @Autowired
    BuyListMapper buyListMapper;

    @Autowired
    CouponBoxMapper couponBoxMapper;

    @RequestMapping(value = "/buy.do", produces = "application/json; charset=utf-8")
    public String buy(BuyListVo vo, @RequestParam(value = "couponid", required = false) Integer couponid) {
        // 디버깅 로그 추가
        System.out.println("BuyListVo: " + vo);
        System.out.println("Received couponid: " + couponid);

        System.out.println(vo);
        int res = buyListMapper.insert(vo);
        int bIdx = buyListMapper.selectBuyListOne(vo);

        res = buyListMapper.orderInsert(bIdx);

        if (res > 0) {
            // 쿠폰 사용 처리: couponid가 있을 경우 N -> Y로 업데이트
            if (couponid != null && couponid != 0) {
                System.out.println("업데이트 시도하려는 couponid: " + couponid);
                int updateRes = couponBoxMapper.updateCouponUsage(couponid);
                if (updateRes > 0) {
                    System.out.println("Coupon successfully updated to 'Y'.");
                } else {
                    System.out.println("Coupon update failed.");
                }
            } else {
                System.out.println("No couponid provided or couponid is 0.");
            }

            session.setAttribute("alertMsg", "결제 완료 되었습니다!");

            UserVo user = (UserVo) session.getAttribute("user");
            user = buyListMapper.selectOne(user.getUserIdx());

            session.setAttribute("user", user);

            // {"result" : true}
            String json = String.format("{\"result\" : %d}", res);

            return json;

        } else {

            session.setAttribute("alertMsg", "결제에 실패했습니다!");
            return "redirect:home.do";
        }

    }

}
