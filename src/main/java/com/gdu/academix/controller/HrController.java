package com.gdu.academix.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.gdu.academix.service.HrService;

@RequestMapping("/hr")
@Controller
public class HrController {
	
	@Autowired
	private HrService hrService;

 @GetMapping("/list.page")
 public String hrList() {
	 return "hr/list";
 }
 @GetMapping("/chat.page")
 public String hrc() {
	 return "hr/chat";
 }
 
 @GetMapping("/employeeRegister.page")
 public String registerMove() {
	 return"hr/register";
 }
 
  @PostMapping(value="/checkEmail.do", produces="application/json")
 public ResponseEntity<Map<String, Object>> checkEmail(@RequestBody Map<String, Object> params) {
    return hrService.checkEmail(params);
 }
 
 @PostMapping("/employeeRegister.do")
  public String employeeRegister(MultipartHttpServletRequest multipartRequest, RedirectAttributes redirectAttributes) {
	 int insertCount = hrService.registerEmployee(multipartRequest);
	 redirectAttributes.addFlashAttribute("insertCount", insertCount == 1  ? "등록되었습니다." : "등록 되지 않았습니다");
	 return "redirect:/hr/list.page";
 }
  
 @GetMapping("/profileEdit.do")
  public String modifyMove(@RequestParam int employeeNo, Model model) {
	 model.addAttribute("employee", hrService.getUserProfileByNo(employeeNo));
	 return "hr/edit";
 }
 
 @PostMapping("/employeeModify.do")
  public String employeeModify(MultipartHttpServletRequest multipartRequest, RedirectAttributes redirectAttributes) {
	 
	 redirectAttributes
     .addFlashAttribute("modifyResult", hrService.emloyeeModify(multipartRequest) == 1 ? "수정되었습니다." : "수정을 하지 못했습니다.");

      return "hr/list";
 }
		 
 @GetMapping("removeEmployee.do")
  public String removeEmployee(@RequestParam int employeeNo, RedirectAttributes redirectAttributes) {
	   redirectAttributes.addFlashAttribute("deleteCount", hrService.removeEmoloyee(employeeNo));
	   return "hr/list";
}

 
}
