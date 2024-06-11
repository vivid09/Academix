package com.gdu.academix.controller;

import java.util.Map;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.gdu.academix.dto.UserDto;
import com.gdu.academix.service.UserService;

@RequestMapping("/user")
@Controller
public class UserController {

  private final UserService userService;

  public UserController(UserService userService) {
    super();
    this.userService = userService;
  }
  
  @GetMapping("/leave.do")
  public void leave(HttpServletRequest request, HttpServletResponse response) {
    userService.leave(request, response);
  }

  @GetMapping("/signin.page")
  public String signinPage(HttpServletRequest request) {
    return "user/signin";
  }
  
  @PostMapping("/signin.do")
  public void signin(HttpServletRequest request, HttpServletResponse response) {
    userService.signin(request, response);
  }
  
  @GetMapping("/signout.do")
  public void signout(HttpServletRequest request, HttpServletResponse response) {
    userService.signout(request, response);
  }
  
  // 오채원 - 조직도 직원 데이터 가져오기
  @GetMapping(value="/getUserList.do", produces="application/json")
  public ResponseEntity<Map<String, Object>> getMemberList() {
    return userService.getMemberList();
  }
  
  @GetMapping(value="/getUserProfileByNo.do", produces="application/json")
  public ResponseEntity<Map<String, Object>> getUserProfileByNo(@RequestParam int employeeNo) {
    System.out.println("employeeNo: " + employeeNo);
    return userService.getUserProfileByNo(employeeNo);
  }
  
  
/*
 * 
  @GetMapping("/naver/getAccessToken.do")
  public String getAccessToken(HttpServletRequest request) {
    String accessToken = userService.getNaverLoginAccessToken(request);
    return "redirect:/user/naver/getProfile.do?accessToken=" + accessToken;
  }
  
  @GetMapping("/naver/getProfile.do")
  public String getProfile(HttpServletRequest request, Model model) {
    
    // 네이버로부터 받은 프로필 정보
    UserDto naverUser = userService.getNaverLoginProfile(request.getParameter("accessToken"));
    
    // 반환 경로
    String path = null;
    
    // 프로필이 DB에 있는지 확인 (있으면 Sign In, 없으면 Sign Up)
    if(userService.hasUser(naverUser)) {
      // Sign In
      userService.naverSignin(request, naverUser);
      path = "redirect:/main.page";
    } else {
      // Sign Up (네이버 가입 화면으로 이동)
      model.addAttribute("naverUser", naverUser);
      path = "user/naver_signup";
    }
    
    return path;
    
  }
  
  @PostMapping(value="/checkEmail.do", produces="application/json")
  public ResponseEntity<Map<String, Object>> checkEmail(@RequestBody Map<String, Object> params) {
    return userService.checkEmail(params);
  }
  
  @PostMapping(value="/sendCode.do", produces="application/json")
  public ResponseEntity<Map<String, Object>> sendCode(@RequestBody Map<String, Object> params) {
    return userService.sendCode(params);
  }  
  
  @GetMapping("/signup.page")
  public String signupPage() {
    return "user/signup";
  }
  
  @PostMapping("/signup.do")
  public void signup(HttpServletRequest request, HttpServletResponse response) {
    userService.signup(request, response);
  }
  
  @GetMapping("/leave.do")
  public void leave(HttpSession session, HttpServletResponse response) {
    UserDto user = (UserDto) session.getAttribute("user");
  }
  @GetMapping("/leave.do")
  public void leave(@SessionAttribute(name="user") UserDto user, HttpServletResponse response) {   
  }
 * 
 * 
 */
  
}
