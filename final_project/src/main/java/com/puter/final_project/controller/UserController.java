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

import com.puter.final_project.dao.UserMapper;
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

	// 회원전체목록
	@RequestMapping("list.do")
	public String list(Model model) {

		List<UserVo> list = userMapper.selectList();

		model.addAttribute("list", list);

		return "home";
	}

	@RequestMapping("login.do")
	public String login(String id, String password, String url, RedirectAttributes ra) {

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

		if(url != null) return "redirect:" + url;

		return "redirect:../home.do";
	}

	// 간편 로그인
	@GetMapping("easyLogin.do")
    public String easyLogin(Model model) {
        // 현재 인증된 사용자 정보 가져오기
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && authentication.getPrincipal() instanceof OAuth2User) {
            OAuth2User oauth2User = (OAuth2User) authentication.getPrincipal();

            String email = oauth2User.getAttribute("email");
            String esite = "google";

            // 사용자 정보를 모델에 추가
            model.addAttribute("name", oauth2User.getAttribute("name"));
            model.addAttribute("email", email);
            model.addAttribute("esite", esite);

            UserVo user = userMapper.selectOneFromEmail(email, esite);
            if(user != null){
                //로그인 처리
                session.setAttribute("user", user);
            }
            else {
                //회원가입으로 넘기기
                model.addAttribute("showSignUpModal", true);
            }

        }
        return "redirect:../home.do"; // home.jsp로 이동
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
	public String insert(String re_id, String re_password, UserVo vo) {

		vo.setId(re_id);
		vo.setPassword(re_password);

		int res = userMapper.insert(vo);

		return "redirect:../home.do";
	}

	@RequestMapping("emailInsert.do")
	public String eminsert(String em_id, String em_password, String em_nickName, String em_name, String em_phone, String em_addr, String em_subAddr, UserVo vo) {

		vo.setId(em_id);
		vo.setPassword(em_password);
		vo.setNickName(em_nickName);
		vo.setName(em_name);
		vo.setPhone(em_phone);
		vo.setAddr(em_addr);
		vo.setSubAddr(em_subAddr);

		int res = userMapper.insert(vo);

		UserVo user = userMapper.selectOneFromId(em_id);
		vo.setUserIdx(user.getUserIdx());

		res = userMapper.emailInsert(vo);

		return "redirect:../home.do";
	}

	@RequestMapping("admin.do")
	public String adminPage(Model model) {

		List<UserVo> userList = userMapper.selectList();
		model.addAttribute("userList", userList);

		return "shopPage/adminMain";
	}

}