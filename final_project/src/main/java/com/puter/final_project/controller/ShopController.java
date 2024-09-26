package com.puter.final_project.controller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.puter.final_project.dao.CartMapper;
import com.puter.final_project.dao.CouponBoxMapper;
import com.puter.final_project.dao.ReviewMapper;
import com.puter.final_project.dao.ShopMapper;
import com.puter.final_project.dao.UserMapper;
import com.puter.final_project.service.NaverSearchService;
import com.puter.final_project.vo.CartVo;
import com.puter.final_project.vo.PImageVo;
import com.puter.final_project.vo.ProductVo;
import com.puter.final_project.vo.CouponBoxVo;
import com.puter.final_project.vo.CouponVo;
import com.puter.final_project.vo.ReviewVo;
import com.puter.final_project.vo.ShopVo;
import com.puter.final_project.vo.UserVo;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class ShopController {

    @Autowired
    ShopMapper shopMapper;

    @Autowired
    UserMapper userMapper;

    @Autowired
    CartMapper cartMapper;

    @Autowired
    ReviewMapper reviewMapper;

    @Autowired
    HttpServletRequest request;

    @Autowired
    HttpSession session;

    @Autowired
    CouponBoxMapper couponBoxMapper;

    @Autowired
    NaverSearchService searchService;

    // DB에 데이터삽입
    @RequestMapping("DBData.do")
    @ResponseBody
    public void DBData() {
        ShopVo shop = new ShopVo();
        // 1=게임 2=스포츠
        for (int c = 1; c <= 2; c++) {
            // 대분류가 게임인 경우
            if (c == 1) {
                // String categoryName = shopMapper.selectCategoryName(c);
                List<ShopVo> gameMcategory = shopMapper.DBMcategoryName(c);
                for (int gm = 0; gm < gameMcategory.size(); gm++) {
                    String gameMcategoryName = gameMcategory.get(gm).getMcategoryName();
                    shop.setMcategoryName(gameMcategoryName);
                    shop.setCategoryNo(c);
                    int gameMcategoryNo = shopMapper.selectMCategoryNo(shop);
                    List<ShopVo> gameDcategory = shopMapper.selectdCategoryNameList(gameMcategoryNo);
                    for (int gd = 0; gd < gameDcategory.size(); gd++) {
                        String gameDcategoryName = gameDcategory.get(gd).getDcategoryName();
                        searchService.searchAndSave(1, gameMcategoryName, gameDcategoryName);
                    }
                }
                System.out.println("================게임추가 끝===============");
                // 대분류가 스포츠인 경우
            } else if (c == 2) {
                List<ShopVo> sportsMcategory = shopMapper.DBMcategoryName(c);
                for (int sm = 0; sm < sportsMcategory.size(); sm++) {
                    String sportsMcategoryName = sportsMcategory.get(sm).getMcategoryName();
                    shop.setMcategoryName(sportsMcategoryName);
                    shop.setCategoryNo(c);
                    int sportsMcategoryNo = shopMapper.selectMCategoryNo(shop);
                    List<ShopVo> sportsDcategory = shopMapper.selectdCategoryNameList(sportsMcategoryNo);
                    for (int sd = 0; sd < sportsDcategory.size(); sd++) {
                        String sportsDcategoryName = sportsDcategory.get(sd).getDcategoryName();
                        searchService.searchAndSave(2, sportsMcategoryName, sportsDcategoryName);
                    }
                }
                System.out.println("================스포츠추가 끝===============");
            }
        }

        // searchService.searchAndSave(query);
    }

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
    public String sports(Model model,
            @RequestParam(name = "categoryNo", defaultValue = "2") int categoryNo,
            @RequestParam(name = "mcategoryNo", defaultValue = "1") int mcategoryNo,
            @RequestParam(name = "mcategoryName", defaultValue = "emptyMcategoryName") String mcategoryName,
            @RequestParam(name = "dcategoryName", defaultValue = "emptyDcategoryName") String dcategoryNameParam) {

        List<ShopVo> mCategoryNameList = shopMapper.selectMCategoryNameList(categoryNo);

        ShopVo shop = new ShopVo();
        shop.setCategoryNo(categoryNo);
        shop.setMcategoryNo(mcategoryNo);
        shop.setDcategoryName(dcategoryNameParam);
        // if (!mcategoryName.equals("emptyMcategoryName")) {
        // shop.setMcategoryName(mcategoryName);
        // int mCategoryNo = shopMapper.selectMCategoryNo(shop);
        // List<ShopVo> dCategoryName = shopMapper.selectdCategoryNameList(mCategoryNo);
        // List<ProductVo> productMCategoryList =
        // shopMapper.selectProductMCategoryList(mCategoryNo);
        // for (int i = 0; i < productMCategoryList.size(); i++) {
        // int pIdx = productMCategoryList.get(i).getPIdx();
        // ProductVo fileName = shopMapper.selectFileName(pIdx);
        // // duplicate 중복제거
        // HashSet<String> duplicate = new HashSet<>();
        // if (duplicate.contains(productMCategoryList.get(i).getFileName())) {
        // productMCategoryList.add(fileName);
        // }
        // }
        // model.addAttribute("dCategoryName", dCategoryName);
        // model.addAttribute("productList", productMCategoryList);
        // if (!dcategoryNameParam.equals("emptyDcategoryName")) {
        // int dCategoryNo = shopMapper.selectDcategoryNo(shop);
        // List<ProductVo> productDCategoryList =
        // shopMapper.selectProductDCategoryList(dCategoryNo);
        // for (int i = 0; i < productDCategoryList.size(); i++) {
        // int pIdx = productMCategoryList.get(i).getPIdx();
        // ProductVo fileName = shopMapper.selectFileName(pIdx);
        // // duplicate 중복제거
        // HashSet<String> duplicate = new HashSet<>();
        // if (duplicate.contains(productDCategoryList.get(i).getFileName())) {
        // productDCategoryList.add(fileName);
        // }
        // }
        // model.addAttribute("productList", productDCategoryList);
        // }
        // }
        List<ProductVo> productList = shopMapper.selectListSports(shop.getCategoryNo());
        model.addAttribute("productList", productList);
        model.addAttribute("mcategoryName", mcategoryName);
        model.addAttribute("shop", shop);
        model.addAttribute("mCategoryNameList", mCategoryNameList);

        return "shopPage/sportsMain";
    }

    @RequestMapping("/categoryAjax.do")
    @ResponseBody
    public List<ShopVo> sportsAjax(int categoryNo, String mcategoryName) {

        ShopVo shop = new ShopVo();
        shop.setCategoryNo(categoryNo);
        shop.setMcategoryName(mcategoryName);

        int mCategoryNo = shopMapper.selectMCategoryNo(shop);
        List<ShopVo> dCategoryList = shopMapper.selectdCategoryNameList(mCategoryNo);
        return dCategoryList;
    }

    @RequestMapping("productAjax.do")
    @ResponseBody
    public List<ProductVo> productAjax(int categoryNo,
            @RequestParam(name = "mcategoryName", defaultValue = "emptyMcategoryName") String mcategoryName,
            Integer dcategoryNo) {

        ShopVo shop = new ShopVo();
        shop.setCategoryNo(categoryNo);
        shop.setMcategoryName(mcategoryName);
        if (dcategoryNo != null) {
            shop.setDcategoryNo(dcategoryNo);
        }
        ;

        if (!mcategoryName.equals("emptyMcategoryName")) {
            int mCategoryNo = shopMapper.selectMCategoryNo(shop);
            shop.setMcategoryNo(mCategoryNo);
            if (dcategoryNo == null) {
                List<ProductVo> productMCategoryList = shopMapper.selectProductMCategoryList(mCategoryNo);
                for (int i = 0; i < productMCategoryList.size(); i++) {
                    int pIdx = productMCategoryList.get(i).getPIdx();
                    ProductVo fileName = shopMapper.selectFileName(pIdx);
                    // duplicate 중복제거
                    HashSet<String> duplicate = new HashSet<>();
                    if (duplicate.contains(productMCategoryList.get(i).getFileName())) {
                        productMCategoryList.add(fileName);
                    }
                }
                return productMCategoryList;
            }
        }

        if (dcategoryNo != null) {
            List<ProductVo> productDCategoryList = shopMapper.selectProductDCategoryList(dcategoryNo);
            for (int i = 0; i < productDCategoryList.size(); i++) {
                int pIdx = productDCategoryList.get(i).getPIdx();
                ProductVo fileName = shopMapper.selectFileName(pIdx);
                // duplicate 중복제거
                HashSet<String> duplicate = new HashSet<>();
                if (duplicate.contains(productDCategoryList.get(i).getFileName())) {
                    productDCategoryList.add(fileName);
                }
            }
            return productDCategoryList;
        }
        return Collections.emptyList(); // 작동안함
    }

    // 상품 클릭 시 이동하는 상세페이지
    @RequestMapping("/productOne.do")
    public String productOne(int categoryNo, int pIdx,
            @RequestParam(value = "couponId", required = false) Integer couponId,
            Model model) {

        // 1. 상품 정보 가져오기
        ShopVo shop = shopMapper.selectProductInfoList(categoryNo, pIdx);
        if (shop == null) {
            model.addAttribute("error", "해당 상품이 존재하지 않습니다.");
            return "shopPage/productOne";
        }
        List<PImageVo> product = shopMapper.selectPImageList(pIdx);
        model.addAttribute("product", product);

        // 2. 리뷰 목록 가져오기
        List<ReviewVo> reviewList = reviewMapper.selectReviewsByProduct(pIdx);

        // 3. 사용자 쿠폰 목록 가져오기
        UserVo user = (UserVo) session.getAttribute("user");
        if (user != null) {
            List<CouponBoxVo> couponList = couponBoxMapper.selectCouponsByUserId(user.getUserIdx());
            model.addAttribute("couponList", couponList);
        }

        // 4. 쿠폰이 있을 때만 할인 적용
        double discount = 0;
        if (couponId != null) {
            CouponBoxVo coupon = couponBoxMapper.selectCouponById(couponId);
            if (coupon != null && coupon.getCoupon() != null) {
                if ("-".equals(coupon.getCoupon().getDctype())) { // 금액 할인
                    discount = coupon.getCoupon().getDiscount();
                } else if ("%".equals(coupon.getCoupon().getDctype())) { // 퍼센트 할인
                    discount = shop.getPrice() * (coupon.getCoupon().getDiscount() / 100.0);
                }
            }
        }

        // 5. 최종 금액 계산
        double finalPrice = shop.getPrice() - discount;
        if (finalPrice < 0) {
            finalPrice = 0;
        }

        // 6. 모델에 정보 추가
        model.addAttribute("shop", shop);
        model.addAttribute("reviewList", reviewList);
        model.addAttribute("discount", discount);
        model.addAttribute("finalPrice", finalPrice);

        return "shopPage/productOne";
    }

    @RequestMapping("/cartInsert.do")
    public String cartInsert(CartVo vo) {

        UserVo user = (UserVo) session.getAttribute("user");
        vo.setUserIdx(user.getUserIdx());

        int res = cartMapper.cartInsert(vo);

        return "redirect:home.do";
    }

    // 게임카테고리 전체조회
    @RequestMapping("/game.do")
    public String game(Model model,
            @RequestParam(name = "categoryNo", defaultValue = "1") int categoryNo,
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
            List<ProductVo> productMCategoryList = shopMapper.selectProductMCategoryList(mCategoryNo);
            for (int i = 0; i < productMCategoryList.size(); i++) {
                int pIdx = productMCategoryList.get(i).getPIdx();
                ProductVo fileName = shopMapper.selectFileName(pIdx);
                // duplicate 중복제거
                HashSet<String> duplicate = new HashSet<>();
                if (duplicate.contains(productMCategoryList.get(i).getFileName())) {
                    productMCategoryList.add(fileName);
                }
            }
            model.addAttribute("dCategoryName", dCategoryName);
            model.addAttribute("productList", productMCategoryList);
            if (!dcategoryNameParam.equals("emptyDcategoryName")) {
                int dCategoryNo = shopMapper.selectDcategoryNo(shop);
                List<ProductVo> productDCategoryList = shopMapper.selectProductDCategoryList(dCategoryNo);
                for (int i = 0; i < productDCategoryList.size(); i++) {
                    int pIdx = productMCategoryList.get(i).getPIdx();
                    ProductVo fileName = shopMapper.selectFileName(pIdx);
                    // duplicate 중복제거
                    HashSet<String> duplicate = new HashSet<>();
                    if (duplicate.contains(productDCategoryList.get(i).getFileName())) {
                        productDCategoryList.add(fileName);
                    }
                }
                model.addAttribute("productList", productDCategoryList);
            }
        }
        if (mcategoryName.equals("emptyMcategoryName") && dcategoryNameParam.equals("emptyDcategoryName")) {

            List<ProductVo> productList = shopMapper.selectListSports(categoryNo);
            model.addAttribute("productList", productList);
        }
        if (mcategoryName.equals("emptyMcategoryName")) {
            model.addAttribute("mcategoryName", mcategoryName);
        }
        model.addAttribute("shop", shop);
        model.addAttribute("mCategoryNameList", mCategoryNameList);

        return "shopPage/gameMain";
    }

}
