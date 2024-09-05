package com.puter.final_project.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.security.SecurityProperties.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.puter.final_project.dao.AdminMapper;
import com.puter.final_project.dao.ProductMapper;
import com.puter.final_project.dao.ShopMapper;
import com.puter.final_project.vo.ProductVo;
import com.puter.final_project.vo.ShopVo;
import com.puter.final_project.vo.UserVo;

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
        // // 상품 관리 불러오기
        // List<AboardVo> list2 = .selectListMySb(user.getUserNo());
        // // 주문 관리 불러오기
        // List<AboardVo> list3 = aboard_dao.selectListMyAuc(user.getUserNo());
        // // 공지사항 관리 불러오기
        // List<AboardVo> list4 = aboard_dao.selectListMySc(user.getUserNo());

        model.addAttribute("list", list);
        model.addAttribute("pList", pList);

        // model.addAttribute("list2", list2);
        // model.addAttribute("list3", list3);
        // model.addAttribute("list4", list4);

        return "shopPage/adminMain";
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

    @RequestMapping("p_insert.do")
    public String p_insert() {

        return "";

    }

    @RequestMapping("p_select.do")
    public String p_select() {

        return "redirect:admin.do";

    }

}
