package com.puter.final_project.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.puter.final_project.dao.OrdersMapper;
import com.puter.final_project.dao.UserMapper;
import com.puter.final_project.vo.OrdersVo;
import com.puter.final_project.vo.UserVo;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/user/")
public class UserController {

	// 자동연결(요청시 마다 Injection)
	@Autowired
	HttpServletRequest request;

	@Autowired
	HttpSession session;

	// 처음에 1회연결
	@Autowired
	UserMapper userMapper;

	@Autowired
	OrdersMapper ordersMapper;

	// 회원전체목록
	@RequestMapping("list.do")
	public String list(Model model) {

		List<UserVo> list = userMapper.selectList();

		model.addAttribute("list", list);

		return "home";
	}

	@RequestMapping("login.do")
	public String login(String id, String password, String url, RedirectAttributes ra, Model model) {

		UserVo user = userMapper.selectOneFromId(id);

		// 아이디가 없는(틀린)경우
		if (user == null) {
			ra.addAttribute("reason", "fail_id");
			return "redirect:" + url;
		}

		// 비밀번호가 틀린경우
		if (user.getPassword().equals(password) == false) {
			ra.addAttribute("reason", "fail_password");
			return "redirect:" + url;
		}

		// 로그인처리: 현재 로그인된 객체(user)정보를 session저장
		session.setAttribute("user", user);
		model.addAttribute("showSignUpModal", false);

		if(url != null) return "redirect:" + url;

		return "redirect:../home.do";
	}


	// 로그아웃
	@RequestMapping("logout.do")
	public String logout() {

		session.removeAttribute("user");

		return "redirect:../home.do";
	}// end:logout()

	@RequestMapping(value = "check_id.do", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String check_id(String id) {

		UserVo vo = userMapper.selectOneFromId(id);

		boolean bResult = false;
		if (vo == null)
			bResult = true;
		else
			bResult = false;

		String json = String.format("{\"result\": %b }", bResult);

		return json;
	}// end:check_id()

	@RequestMapping("insert.do")
	public String insert(UserVo vo) {

		int res = userMapper.insert(vo);

		return "redirect:../home.do";
	}

	@RequestMapping("emailInsert.do")
	public String eminsert(UserVo vo) {

		int res = userMapper.insert(vo);

		UserVo user = userMapper.selectOneFromId(vo.getId());
		vo.setUserIdx(user.getUserIdx());

		res = userMapper.emailInsert(vo);

		user = userMapper.selectOneFromEmail(vo.getEmail(), vo.getEsite());
		session.setAttribute("user", user);

		return "redirect:../home.do";
	}

	@RequestMapping("integration.do")
	public String integration(UserVo vo, String url, RedirectAttributes ra){

		UserVo user = userMapper.selectOneFromId(vo.getId());
		if(user == null){
			ra.addAttribute("reason", "fail_id");
			return "redirect:../home.do";
		}
		if(user.getPassword().equals(vo.getPassword()) == false){
			ra.addAttribute("reason", "fail_password");
			return "redirect:../home.do";
		}
		vo.setUserIdx(user.getUserIdx());
		int res = userMapper.emailInsert(vo);

		session.setAttribute("user", user);



		return "redirect:../home.do";
	}



	@RequestMapping("admin.do")
	public String adminPage(Model model) {

		List<UserVo> userList = userMapper.selectList();
		model.addAttribute("userList", userList);

		return "shopPage/adminMain";
	}

	// 마이페이지 이동
	@RequestMapping("mypage.do")
	public String mypage() {

		return "shopPage/mypage";
	}

	@RequestMapping("cart.do")
	public String cart(){
		return "myPage/cart";
	}

	@RequestMapping("purchaseHistory.do")
	public String purchaseHistory(){
		return "myPage/purchaseHistory";
	}

	@RequestMapping("shippingTracking.do")
	public String shippingTracking(Model model){
		UserVo user = (UserVo) session.getAttribute("user");

		List<OrdersVo> orderList = ordersMapper.selectList(user.getUserIdx());

		model.addAttribute("orderList", orderList);

		return "myPage/shippingTracking";
	}

	@RequestMapping("accountInfo.do")
	public String accountInfo(){
		return "myPage/accountInfo";
	}

	@RequestMapping("userModify.do")
	public String userModify(UserVo vo){

		int res = userMapper.userModify(vo);

		UserVo user = userMapper.selectOneFromId(vo.getId());

		session.setAttribute("user", user);

		return "redirect:mypage.do";
	}
}