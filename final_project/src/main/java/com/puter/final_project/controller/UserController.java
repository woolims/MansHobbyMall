package com.puter.final_project.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

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
	public String login(String id, String password) {
		
		UserVo user = userMapper.selectOneFromId(id);
		
		//아이디가 없는(틀린)경우
		if(user==null) {
			return "redirect:../home.do?reason=fail_id";
		}
		
		//비밀번호가 틀린경우
		if(user.getPassword().equals(password)==false) {
			return "redirect:../home.do?reason=fail_pwd";
		}
		
		//로그인처리: 현재 로그인된 객체(user)정보를 session저장
		session.setAttribute("user", user);
		
		return "redirect:../home.do";
	}

    //로그아웃
	@RequestMapping("logout.do")
	public String logout() {
		
		session.removeAttribute("user");
		
		return "redirect:../home.do";
	}//end:logout()

    @RequestMapping(value = "check_id.do", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String check_id(String id) {
		
		UserVo vo = userMapper.selectOneFromId(id);
		
		boolean bResult = false;
		if(vo==null)
			bResult=true;
		else
			bResult=false;
		
		String json = String.format("{\"result\": %b }", bResult);
		
		return json;
	}//end:check_id()

	@RequestMapping("insert.do")
	public String insert(String re_id, String re_password, UserVo vo){

		vo.setId(re_id);
		vo.setPassword(re_password);

		int res = userMapper.insert(vo);

		return "redirect:../home.do";
	}

}
