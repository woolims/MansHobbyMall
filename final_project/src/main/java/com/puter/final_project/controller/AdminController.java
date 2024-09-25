package com.puter.final_project.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.puter.final_project.dao.AdminMapper;
import com.puter.final_project.dao.InquiryMapper;
import com.puter.final_project.dao.ProductMapper;
import com.puter.final_project.dao.ShopMapper;
import com.puter.final_project.vo.InquiryVo;
import com.puter.final_project.vo.PImageVo;
import com.puter.final_project.vo.ShopVo;
import com.puter.final_project.vo.UserVo;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

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
    InquiryMapper inquiryMapper;

    @Autowired
    ProductMapper productMapper;

    @Autowired
    ShopMapper shopMapper;

    @Autowired
    ServletContext application;

    @RequestMapping("admin.do")
    public String list(@RequestParam(value = "searchType", required = false) String searchType,
                    @RequestParam(value = "searchText", required = false) String searchText,
                    Model model) {

        UserVo user = (UserVo) session.getAttribute("user");
        if (user == null || "N".equals(user.getAdminAt())) {
            return "redirect:../home.do";
        }

        List<UserVo> list;
        if ("id".equals(searchType) && searchText != null && !searchText.isEmpty()) {
            // 아이디로 검색
            list = adminMapper.selectUsersById(searchText);  // id로 검색
        } else {
            // 전체 보기
            list = adminMapper.selectListUserView();
        }

        List<ShopVo> pList = shopMapper.selectAdminList();
        List<ShopVo> categoryName = shopMapper.selectCategoryNameList();
        List<InquiryVo> list2 = inquiryMapper.selectNoticeList();

        model.addAttribute("categoryName", categoryName);
        model.addAttribute("list", list);
        model.addAttribute("pList", pList);
        model.addAttribute("list2", list2);

        return "shopPage/adminMain";
    }

    @RequestMapping("adminAjax.do")
    @ResponseBody
    public List<ShopVo> adminAjax(@RequestParam(defaultValue = "대분류 선택") String categoryName, String mcategoryName) {

        if (categoryName != null && !categoryName.equals("대분류 선택") && !categoryName.equals("전체보기")
                && mcategoryName == null) {
            String categoryNameParam = categoryName;
            List<ShopVo> mcategoryNameList = shopMapper.selectMcategoryNameList(categoryNameParam);
            return mcategoryNameList;
        }

        if (mcategoryName != null && !mcategoryName.equals("선택 안 함")) {
            String mcategoryNameParam = mcategoryName;
            List<ShopVo> dcategoryNameList = shopMapper.selectDcategoryNameList(mcategoryNameParam);
            return dcategoryNameList;
        }

        return Collections.emptyList();
    }

    @RequestMapping("adminAjaxPList.do")
    @ResponseBody
    public List<ShopVo> adminAjaxPList(@RequestParam(defaultValue = "") String searchParam,
            @RequestParam(defaultValue = "") String categoryName,
            @RequestParam(defaultValue = "") String mcategoryName,
            @RequestParam(defaultValue = "") String dcategoryName) {

        ShopVo shop = new ShopVo();
        shop.setPName(searchParam);
        shop.setCategoryName(categoryName);
        shop.setMcategoryName(mcategoryName);
        shop.setDcategoryName(dcategoryName);

        if (categoryName.equals("전체보기")) {
            List<ShopVo> productList = shopMapper.selectAdminList();
            return productList;
        } else if (!categoryName.equals("")) {
            int categoryNo = shopMapper.selectAdminCategoryNo(shop);
            shop.setCategoryNo(categoryNo);
            if (!mcategoryName.equals("")) {
                int mcategoryNo = shopMapper.selectAdminMcategoryNo(shop);
                shop.setMcategoryNo(mcategoryNo);
                if (!dcategoryName.equals("")) {
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

        return Collections.emptyList(); // 그냥 리턴 적으려고 쓴 코드 실제로 작동안함
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
        int res2 = shopMapper.pImageDelete(pIdx);
        return "redirect:admin.do";
    }

    @RequestMapping("pInsertForm.do")
    public String pInsertForm(ShopVo shop, Model model) {

        // int maxPIdx = shopMapper.selectMaxPIdx();
        List<ShopVo> categoryName = shopMapper.selectCategoryNameList();
        List<ShopVo> mcategoryName = shopMapper.selectMcategoryNameList(shop.getCategoryName());
        List<ShopVo> dcategoryName = shopMapper.selectDcategoryNameList(shop.getMcategoryName());
        // model.addAttribute("maxPIdx", maxPIdx+1);
        model.addAttribute("categoryName", categoryName);
        model.addAttribute("mcategoryName", mcategoryName);
        model.addAttribute("dcategoryName", dcategoryName);
        model.addAttribute("shop", shop);
        return "shopPage/pInsertForm";
    }

    @PostMapping("pInsert.do")
    public String pInsert(ShopVo shop, Model model, List<MultipartFile> photo) throws Exception {
        int categoryNo = shopMapper.selectAdminCategoryNo(shop);
        int mcategoryNo = shopMapper.selectAdminMcategoryNo(shop);
        int dcategoryNo = shopMapper.selectAdminDcategoryNo(shop);
        shop.setCategoryNo(categoryNo);
        shop.setMcategoryNo(mcategoryNo);
        shop.setDcategoryNo(dcategoryNo);
        int res = shopMapper.productInsert(shop);

        List<String> filename_list = new ArrayList<String>();

        String absPath = application.getRealPath("/resources/images/");

        for (MultipartFile photoOne : photo) {
            if (!photoOne.isEmpty()) {
                String filename = photoOne.getOriginalFilename();

                filename = photoOne.getOriginalFilename();

                File f = new File(absPath, filename);

                if (f.exists()) {// 동일한 파일이 존재하냐?

                    // 시간_파일명 이름변경
                    long tm = System.currentTimeMillis();
                    filename = String.format("%d_%s", tm, filename);

                    f = new File(absPath, filename);
                }

                // spring이 저장해놓은 임시파일을 복사한다.
                photoOne.transferTo(f);

                filename_list.add(filename);
            }
        }

        int pIdx = shopMapper.selectMaxPIdx();

        PImageVo pImageVo = new PImageVo();

        for (int i = 0; i < filename_list.size(); i++) {
            String filename = filename_list.get(i);
            pImageVo.setPIdx(pIdx);
            pImageVo.setFileName(filename);
            pImageVo.setFileNameLink("N");
            shopMapper.insertPImage(pImageVo);
        }
        return "redirect:admin.do";
    }

    @RequestMapping("pUpdateForm.do")
    public String pUpdateForm(ShopVo shop, Model model) {

        String pEx = shopMapper.selectPEx(shop.getPIdx());

        List<ShopVo> categoryName = shopMapper.selectCategoryNameList();
        List<ShopVo> mcategoryName = shopMapper.selectMcategoryNameList(shop.getCategoryName());
        List<ShopVo> dcategoryName = shopMapper.selectDcategoryNameList(shop.getMcategoryName());
        List<PImageVo> pImageList = shopMapper.selectAdminPImageList(shop.getPIdx());

        model.addAttribute("pImageList", pImageList);
        model.addAttribute("categoryName", categoryName);
        model.addAttribute("mcategoryName", mcategoryName);
        model.addAttribute("dcategoryName", dcategoryName);
        model.addAttribute("shop", shop);
        model.addAttribute("pEx", pEx);

        return "shopPage/pUpdateForm";
    }

    @RequestMapping("pUpdate.do")
    public String pUpdate(ShopVo shop, Model model, List<MultipartFile> photo) throws Exception {

        int categoryNo = shopMapper.selectAdminCategoryNo(shop);
        int mcategoryNo = shopMapper.selectAdminMcategoryNo(shop);
        int dcategoryNo = shopMapper.selectAdminDcategoryNo(shop);

        shop.setCategoryNo(categoryNo);
        shop.setMcategoryNo(mcategoryNo);
        shop.setDcategoryNo(dcategoryNo);

        model.addAttribute(shopMapper.productUpdate(shop));

        List<String> filename_list = new ArrayList<String>();

        String absPath = application.getRealPath("/resources/images/");
        System.out.println("absPath : " + absPath);

        for (MultipartFile photoOne : photo) {
            if (!photoOne.isEmpty()) {
                String filename = photoOne.getOriginalFilename();

                filename = photoOne.getOriginalFilename();

                File f = new File(absPath, filename);

                if (f.exists()) {// 동일한 파일이 존재하냐?

                    // 시간_파일명 이름변경
                    long tm = System.currentTimeMillis();
                    filename = String.format("%d_%s", tm, filename);

                    f = new File(absPath, filename);
                }

                // spring이 저장해놓은 임시파일을 복사한다.
                photoOne.transferTo(f);

                filename_list.add(filename);
            }
        }

        int pIdx = shopMapper.selectMaxPIdx();

        PImageVo pImageVo = new PImageVo();

        for (int i = 0; i < filename_list.size(); i++) {
            String filename = filename_list.get(i);
            pImageVo.setPIdx(pIdx);
            pImageVo.setFileName(filename);
            pImageVo.setFileNameLink("N");
            shopMapper.insertPImage(pImageVo);
        }


        return "redirect:admin.do";
    }

    @RequestMapping("nInsertForm.do")
    public String nInsertForm() {

        return "shopPage/nInsertForm";
    }

    @RequestMapping("nInsert.do")
    public String nInsert(InquiryVo inquiry) throws Exception {

        UserVo user = (UserVo) session.getAttribute("user");
        inquiry.setUserIdx(user.getUserIdx());
        int res = inquiryMapper.nInsert(inquiry);

        return "redirect:admin.do";
    }

    @RequestMapping("nModifyForm.do")
    public String nModifyForm() {

        return "shopPage/nModifyForm";
    }

    @RequestMapping("nModify.do")
    public String nModify(InquiryVo inquiry) throws Exception {

        UserVo user = (UserVo) session.getAttribute("user");
        inquiry.setUserIdx(user.getUserIdx());
        int res = inquiryMapper.nInsert(inquiry);

        return "redirect:admin.do";
    }

    @RequestMapping("nDelete.do")
    public String confirmNoticeDelete(int inIdx) {

        int res = inquiryMapper.nDelete(inIdx);

        return "redirect:admin.do";
    }

    @RequestMapping("pImageDelete.do")
    @ResponseBody
    public List<PImageVo> pImageDelete(PImageVo pImage) {

        int res = shopMapper.deletePImageOne(pImage.getFileIdx());
        // 선택한 사진을 지운 후 남은 사진들의 리스트
        List<PImageVo> deleteAfterList = shopMapper.selectAdminPImageList(pImage.getPIdx());
        System.out.println(pImage);
        return deleteAfterList;
    }
}
