package com.puter.final_project.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.security.SecurityProperties.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.puter.final_project.dao.AdminMapper;
import com.puter.final_project.dao.ProductMapper;
import com.puter.final_project.dao.ShopMapper;
import com.puter.final_project.vo.ProductVo;
import com.puter.final_project.vo.ShopVo;
import com.puter.final_project.vo.UserVo;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import java.util.Collections;

@Controller
@RequestMapping("/admin/")
public class AdminController {

    // 자동연결(요청시 마다 Injection)
    @Autowired
    HttpServletRequest request;

    @Autowired
    HttpSession session;

    @Autowired
    AdminMapper adminMapper;

    @Autowired
    ProductMapper productMapper;

    @Autowired
    ShopMapper shopMapper;

    @RequestMapping("admin.do")
    public String list(Model model) {

        UserVo user = (UserVo) session.getAttribute("user");
        if (user == null || "N".equals(user.getAdminAt())) {
            return "redirect:../home.do";
        }

        // 회원 관리 불러오기
        List<UserVo> list = adminMapper.selectListUserView();

        List<ShopVo> pList = shopMapper.selectAdminList();

        List<ShopVo> categoryName = shopMapper.selectCategoryNameList();

        
        
        // // 상품 관리 불러오기
        // List<AboardVo> list2 = .selectListMySb(user.getUserNo());
        // // 주문 관리 불러오기
        // List<AboardVo> list3 = aboard_dao.selectListMyAuc(user.getUserNo());
        // // 공지사항 관리 불러오기
        // List<AboardVo> list4 = aboard_dao.selectListMySc(user.getUserNo());

        model.addAttribute("categoryName", categoryName);
        model.addAttribute("list", list);
        model.addAttribute("pList", pList);

        // model.addAttribute("list2", list2);
        // model.addAttribute("list3", list3);
        // model.addAttribute("list4", list4);

        return "shopPage/adminMain";
    }
    @RequestMapping("adminAjax.do")
    @ResponseBody
    public List<ShopVo> adminAjax(@RequestParam(defaultValue = "대분류 선택")String categoryName, String mcategoryName){

        if (categoryName != null && !categoryName.equals("대분류 선택")) {
            String categoryNameParam = categoryName;
            List<ShopVo> mcategoryNameList = shopMapper.selectMcategoryNameList(categoryNameParam);
            return mcategoryNameList;
        }
        if (mcategoryName != null && !mcategoryName.equals("중분류 선택")){
            String mcategoryNameParam = mcategoryName;
            List<ShopVo> dcategoryNameList = shopMapper.selectDcategoryNameList(mcategoryNameParam);
            return dcategoryNameList;
        }

        return Collections.emptyList();
    }

    @RequestMapping("adminAjaxPList.do")
    @ResponseBody
    public List<ShopVo> adminAjaxPList( @RequestParam(defaultValue="")String searchParam,
                                        @RequestParam(defaultValue="")String categoryName, 
                                        @RequestParam(defaultValue="")String mcategoryName,
                                        @RequestParam(defaultValue="")String dcategoryName) {

        ShopVo shop = new ShopVo();
        shop.setPName(searchParam);
        shop.setCategoryName(categoryName);
        shop.setMcategoryName(mcategoryName);
        shop.setDcategoryName(dcategoryName);

        if (!categoryName.equals("")) {
            int categoryNo = shopMapper.selectAdminCategoryNo(shop);
            shop.setCategoryNo(categoryNo);
            if (!mcategoryName.equals("")) {
                int mcategoryNo = shopMapper.selectAdminMcategoryNo(shop);
                shop.setMcategoryNo(mcategoryNo);
                if(!dcategoryName.equals("")) {
                    int dcategoryNo = shopMapper.selectAdminDcategoryNo(shop);
                    shop.setDcategoryNo(dcategoryNo);
                }
            }
        }

        // 검색어(상품명)만 입력한 경우
        if (categoryName.equals("")) {
            List<ShopVo> searchList = shopMapper.selectSearchList(shop);
            return searchList;
        }

        // 대분류만 검색한 경우
        if (!categoryName.equals("") && searchParam.equals("") && mcategoryName.equals("")) {
            List<ShopVo> categoryList = shopMapper.selectCategoryList(shop);
            return categoryList;
        }

        // 대분류와 검색어(상품명)를 검색한 경우
        if (!categoryName.equals("") && !searchParam.equals("") && mcategoryName.equals("")) {
            List<ShopVo> categorySearchList = shopMapper.selectCategorySearchList(shop);
            return categorySearchList;
        }

        // 중분류를 검색한 경우
        if (!mcategoryName.equals("") && searchParam.equals("") && dcategoryName.equals("")) {
            List<ShopVo> mcategorySearchList = shopMapper.selectMcategoryList(shop);
            return mcategorySearchList;
        }

        // 중분류와 검색어(상품명)를 검색한 경우
        if (!mcategoryName.equals("") && !searchParam.equals("") && dcategoryName.equals("")) {
            List<ShopVo> mcategorySearchList = shopMapper.selectMcategorySearchList(shop);
            return mcategorySearchList;
        }

        // 소분류만 검색한 경우
        if (!dcategoryName.equals("") && searchParam.equals("")) {
            List<ShopVo> dcategoryList = shopMapper.selectDcategoryList(shop);
            return dcategoryList;
        }

        // 소분류와 검색어(상품명)를 검색한 경우
        if (!dcategoryName.equals("") && !searchParam.equals("")) {
            List<ShopVo> dcategorySearchList = shopMapper.selectDcategorySearchList(shop);
            return dcategorySearchList;
        }

        return Collections.emptyList(); //그냥 리턴 적으려고 쓴 코드 실제로 작동안함
    }


    @RequestMapping("delete.do")
    public String delete(int userIdx) {
        int res = adminMapper.userDelete(userIdx);

        if (res > 0) {
            session.setAttribute("alertMsg", "탈퇴되었습니다.");
        } else {
            session.setAttribute("alertMsg", "탈퇴 실패했습니다.");
        }

        return "redirect:admin.do";
    }

    @RequestMapping("pDelete.do")
    public String pDelete(int pIdx) {
        int res = productMapper.pDelete(pIdx);
        return "redirect:admin.do";
    }

    @RequestMapping("/pInsertForm.do")
    public String pInsertForm(ShopVo shop, Model model) {
        
        int maxPIdx = shopMapper.selectMaxPIdx();
        List<ShopVo> categoryName = shopMapper.selectCategoryNameList();
        List<ShopVo> mcategoryName = shopMapper.selectMcategoryNameList(shop.getCategoryName());
        List<ShopVo> dcategoryName = shopMapper.selectDcategoryNameList(shop.getMcategoryName());
        model.addAttribute("categoryName", categoryName);
        model.addAttribute("mcategoryName", mcategoryName);
        model.addAttribute("dcategoryName", dcategoryName);
        model.addAttribute("shop", shop);
        model.addAttribute("maxPIdx", maxPIdx+1);
        return "shopPage/pInsertForm";
    }

    @RequestMapping("/pInsert.do")
    public String productInsert(ShopVo shop, Model model) {
        int categoryNo = shopMapper.selectAdminCategoryNo(shop);
        int mcategoryNo = shopMapper.selectAdminMcategoryNo(shop);
        int dcategoryNo = shopMapper.selectAdminDcategoryNo(shop);
        shop.setCategoryNo(categoryNo);
        shop.setMcategoryNo(mcategoryNo);
        shop.setDcategoryNo(dcategoryNo);
        int res = shopMapper.productInsert(shop);
        return "redirect:admin.do";
    }

    @RequestMapping("/pUpdateForm.do")
    public String pUpdateForm(ShopVo shop, Model model) {

        String pEx = shopMapper.selectPEx(shop.getPIdx());

        List<ShopVo> categoryName = shopMapper.selectCategoryNameList();
        List<ShopVo> mcategoryName = shopMapper.selectMcategoryNameList(shop.getCategoryName());
        List<ShopVo> dcategoryName = shopMapper.selectDcategoryNameList(shop.getMcategoryName());
        model.addAttribute("categoryName", categoryName);
        model.addAttribute("mcategoryName", mcategoryName);
        model.addAttribute("dcategoryName", dcategoryName);
        model.addAttribute("shop", shop);
        model.addAttribute("pEx", pEx);

        return "shopPage/pUpdateForm";
    }

    @RequestMapping("/pUpdate.do")
    public String pUpdate(ShopVo shop, Model model) {

        int categoryNo = shopMapper.selectAdminCategoryNo(shop);
        int mcategoryNo = shopMapper.selectAdminMcategoryNo(shop);
        int dcategoryNo = shopMapper.selectAdminDcategoryNo(shop);

        shop.setCategoryNo(categoryNo);
        shop.setMcategoryNo(mcategoryNo);
        shop.setDcategoryNo(dcategoryNo);

        model.addAttribute(shopMapper.productUpdate(shop));

        return "redirect:admin.do";
    }

}
