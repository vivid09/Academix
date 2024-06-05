package com.gdu.academix.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.MultipartRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.gdu.academix.dto.EmployeesDto;
import com.gdu.academix.dto.LeaveRequestDto;
import com.gdu.academix.dto.RequestsDto;
import com.gdu.academix.service.RequestsService;

import jakarta.servlet.http.HttpServletRequest;

@RequestMapping("/hr")
@Controller
public class HrController {

 @GetMapping("/list.do")
 public String hrList() {
	 return "hr/list";
 }
 
 @GetMapping("/employeeRegister.page")
 public String registerMove() {
	 return"hr/register";
 }
 
 @PostMapping("/employeeRegister.do")
  public String employeeRegister(MultipartRequest multipartRequest) {
	 
	 return "redirect:/hr/employeeRegister.do";
 }
  
}
