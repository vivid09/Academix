package com.gdu.academix.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.gdu.academix.dto.EmployeesDto;
import com.gdu.academix.dto.LeaveRequestDto;
import com.gdu.academix.dto.RequestsDto;
import com.gdu.academix.service.RequestsService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@RequestMapping("/requests")
@Controller
public class RequestsController {

 @Autowired	
  private RequestsService requestsService;	
	
	/*
	 * @GetMapping("/main.page") public String RequestsMain() {
	 * return"requests/main"; }
	 */
	
  @GetMapping("/write.page")
  public String write() {
	  return "requests/write";
  }
  
  
  @PostMapping("/write.do")
  public String createLeaveRequest(MultipartHttpServletRequest multipartRequest, RedirectAttributes redirectAttributes) {
	  //boolean insertCount = ;
	  redirectAttributes.addFlashAttribute("insertCount", requestsService.createLeaveRequest(multipartRequest));
	    int employeeNo = Integer.parseInt(multipartRequest.getParameter("employeeNo"));
	    return "redirect:/requests/main.page?employeeNo=" + employeeNo; // 리디렉션
	}
  
  @PostMapping("/writeAttendance.do")
   public String createAttendanceRequest(MultipartHttpServletRequest multipartRequest, RedirectAttributes redirectAttributes) {
	  int employeeNo = Integer.parseInt(multipartRequest.getParameter("employeeNo"));
	  redirectAttributes.addFlashAttribute("insertCount", requestsService.createAttendanceRequest(multipartRequest));
	  return "redirect:/requests/main.page?employeeNo=" + employeeNo;
  }
  
  @GetMapping(value="/main.page")
  public String getList(HttpServletRequest request, Model model) {
	  requestsService.prepareRequestsList(request, model);
	  return "requests/main";
   }
  
  @GetMapping("attendanceDetail.do")
   public String attendance(@RequestParam int requestNo, Model model) {
	  model.addAttribute("attendance", requestsService.getAttendanceRequestNo(requestNo));
	  return"requests/attendaceDetail";
  }
  
	
  @GetMapping("/detail.do")
  public String detail(@RequestParam int requestNo, Model model) {
	   model.addAttribute("leaveRequests", requestsService.getRequestsbyNo(requestNo));
	   
	   //LeaveRequestDto a = requestsService.getRequestsbyNo(requestNo);
	   //System.out.println(a.getRequests().getEmployees().getName());
	  return "requests/detail";
  }
	 
  @GetMapping("/approval.page")
  public String approvalPage() {
	  return"requests/approval";
  }
  
  @PostMapping("/requestApproval.do")
  public String requestModify(HttpServletRequest request, RedirectAttributes redirectAttributes) {
	  int modifyCount = requestsService.requestApproval(request);
	  redirectAttributes.addFlashAttribute("modifyCount", modifyCount == 1  ? "결재되었습니다." : "결재 되지 않았습니다");
	  return "redirect:/requests/requestsList.do"; // 리디렉션 
  }
  
  @PostMapping("/reject.do")
  public String rejectRequest(HttpServletRequest request, RedirectAttributes redirectAttributes) {
	  int rejectCount = requestsService.requestreject(request);
	  redirectAttributes.addFlashAttribute("rejectCount", rejectCount == 1 ? "반려되었습니다." : "반려되지 않았습니다");
	  return "redirect:/requests/requestsList.do";
  }
  
  @GetMapping("/requestsList.do")
  public String Paging(HttpServletRequest request, Model model) {
	  //model.addAttribute("request", request);
	  requestsService.getRequestsList(request, model);
	  return "requests/paging";
  }
  
  @PostMapping("/edit.do")
  public String edit(@RequestParam int requestNo, Model model) {
	  model.addAttribute("leaveRequests", requestsService.getRequestsbyNo(requestNo));
	   
	   //LeaveRequestDto a = requestsService.getRequestsbyNo(requestNo);
	   //System.out.println(a.getRequests().getEmployees().getName());
	  return "requests/edit";
  }
  
  @PostMapping("/requestModify.do")
  public String modifyRequest(MultipartHttpServletRequest multipartRequest, RedirectAttributes redirectAttributes) {
	  int requestNo = Integer.parseInt(multipartRequest.getParameter("requestNo"));
	  redirectAttributes
      .addFlashAttribute("modifyResult", requestsService.modifyRequest(multipartRequest) == 1 ? "수정되었습니다." : "수정을 하지 못했습니다.");
       return "redirect:/requests/detail.do?requestNo=" +requestNo;
	  
  }
  @PostMapping("attendanceModify.do")
   public String attendanceModify(MultipartHttpServletRequest multipartRequest, RedirectAttributes redirectAttributes) {
	  redirectAttributes.addFlashAttribute("modifyResult", requestsService.attendanceModify(multipartRequest) == 1 ? "수정" : "수정되지않았습니다");
      return "requests/main"; 
  }
  
  @PostMapping("/removeRequest.do")
  public  String removeRequest(@RequestParam(value="requestNo", required=false, defaultValue="0") int requestNo
          , RedirectAttributes redirectAttributes, @RequestParam int employeeNo) {
			int removeCount = requestsService.removeRequest(requestNo, employeeNo);
			redirectAttributes.addFlashAttribute("removeResult", removeCount == 1 ? "기안서가 삭제되었습니다." : "기안서가 삭제되지 않았습니다.");
			return "redirect:/requests/main.page?employeeNo=" + employeeNo;
	}
  
	
   @GetMapping(value="/pending.do", produces="application/json")
	public ResponseEntity<Map<String, Object>> pending() {
	  System.out.println();
	   return  requestsService.pending();
    }
	 
   @GetMapping("/download.do")
   public ResponseEntity<Resource> download(HttpServletRequest request){
	   return requestsService.download(request);
   }
   
   @GetMapping("/removeAttendance.do")
    public String removeAttendance(@RequestParam int requestNo, RedirectAttributes redirectAttributes, HttpServletRequest request) {
	   int removeCount = requestsService.removeAttendance(requestNo);
	   redirectAttributes.addFlashAttribute("removeCount", removeCount);
	   int employeeNo = Integer.parseInt(request.getParameter("employeeNo"));
	   return "redirect:/requests/main.page?employeeNo=" + employeeNo;
	   //return "redirect:/requests/requestsList.do";
   }
   
   
  
}
