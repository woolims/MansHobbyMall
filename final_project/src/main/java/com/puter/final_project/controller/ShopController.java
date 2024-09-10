package com.puter.final_project.controller;

import java.util.ArrayList;
import java.util.List;

import org.apache.catalina.mbeans.UserMBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.puter.final_project.dao.ShopMapper;
import com.puter.final_project.dao.UserMapper;
import com.puter.final_project.vo.ShopVo;
import com.puter.final_project.vo.UserVo;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class ShopController {

    @Autowired
    ShopMapper shopMapper;

    @Autowired
    UserMapper userMapper;

    @Autowired
    HttpServletRequest request;

    @Autowired
    HttpSession session;

    // main 페이지 이동
    @RequestMapping("/home.do")
    public String home(Model model, @RequestParam(value = "showSignUpModal", required = false) String showSignUpModal) {

        String email = (String) session.getAttribute("email");
        String esite = (String) session.getAttribute("esite");

        model.addAttribute("email", email);
        model.addAttribute("esite", esite);

        if (showSignUpModal != null && showSignUpModal.equals("true")) {
            model.addAttribute("showSignUpModal", true);
        }

        return "home";
    }

    // 간편 로그인
    @GetMapping("/easyLogin.do")
    public String easyLogin(RedirectAttributes ra) {
        // 현재 인증된 사용자 정보 가져오기
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && authentication.getPrincipal() instanceof OAuth2User) {
            OAuth2User oauth2User = (OAuth2User) authentication.getPrincipal();

            String email = oauth2User.getAttribute("email");
            String esite = oauth2User.getAttribute("esite");

            // 사용자 정보를 session에 저장
            session.setAttribute("email", email);
            session.setAttribute("esite", esite);

            System.out.println(esite);

            UserVo user = userMapper.selectOneFromEmail(email, esite);
            if (user != null) {
                // 로그인 처리
                session.setAttribute("user", user);
                return "redirect:home.do";
            } else {
                ra.addAttribute("showSignUpModal", "true");
                return "redirect:home.do";
            }

        }
        return "home"; // home.jsp로 이동
        // return "redirect:../home.do"; // home.jsp로 이동
    }

    // 스포츠카테고리 전체조회
    @RequestMapping("/sports.do")
    public String sports(@RequestParam(name = "page", defaultValue = "1") int nowPage, Model model,
            @RequestParam(name = "categoryNo", defaultValue = "2") int categoryNo,
            @RequestParam(name = "mcategoryNo", defaultValue = "1") int mcategoryNo,
            @RequestParam(name = "mcategoryName", defaultValue = "emptyMcategoryName") String mcategoryName,
            @RequestParam(name = "dcategoryName", defaultValue = "emptyDcategoryName") String dcategoryNameParam) {

        List<ShopVo> mCategoryNameList = shopMapper.selectMCategoryNameList(categoryNo);

        ShopVo shop = new ShopVo();
        shop.setCategoryNo(categoryNo);
        shop.setMcategoryNo(mcategoryNo);
        shop.setDcategoryName(dcategoryNameParam);

        if (!mcategoryName.equals("emptyMcategoryName")) {
            shop.setMcategoryName(mcategoryName);
            int mCategoryNo = shopMapper.selectMCategoryNo(shop);
            List<ShopVo> dCategoryName = shopMapper.selectdCategoryNameList(mCategoryNo);
            List<ShopVo> productMCategoryList = shopMapper.selectProductMCategoryList(mCategoryNo);
            model.addAttribute("dCategoryName", dCategoryName);
            model.addAttribute("productList", productMCategoryList);
            if (!dcategoryNameParam.equals("emptyDcategoryName")) {
                int dCategoryNo = shopMapper.selectDCategoryNo(shop);
                List<ShopVo> productDCategoryList = shopMapper.selectProductDCategoryList(dCategoryNo);
                model.addAttribute("productList", productDCategoryList);
            }
        }
        if (mcategoryName.equals("emptyMcategoryName") && dcategoryNameParam.equals("emptyDcategoryName")) {

            List<ShopVo> productList = shopMapper.selectListSports(categoryNo);
            model.addAttribute("productList", productList);
        }
        if (mcategoryName.equals("emptyMcategoryName")) {
            model.addAttribute("mcategoryName", mcategoryName);
        }
        model.addAttribute("shop", shop);
        model.addAttribute("mCategoryNameList", mCategoryNameList);

        return "shopPage/sportsMain";
    }

    // 스포츠 상품 클릭 시 이동하는 상세페이지
    @RequestMapping("/productOne.do")
    public String sports_one(int categoryNo, int pIdx, Model model) {

        ShopVo shop = (ShopVo) shopMapper.selectProductInfoList(categoryNo, pIdx);
        shop.setCategoryNo(categoryNo);
        shop.setPIdx(pIdx);

        model.addAttribute("shop", shop);

        return "shopPage/productOne";
    }

    // 게임카테고리 전체조회
    @RequestMapping("/game.do")
    public String game() {

        return "shopPage/gameMain";
    }


}
