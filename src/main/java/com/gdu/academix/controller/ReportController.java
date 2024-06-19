package com.gdu.academix.controller;

import java.util.Map;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.gdu.academix.service.AnonService;
import com.gdu.academix.service.ReportService;

import lombok.RequiredArgsConstructor;

@RequestMapping("/report")
@RequiredArgsConstructor
@Controller
public class ReportController {
  
  private final ReportService reportService;
  
  @GetMapping("/list.page")
  public String list() {
    return "report/list";
  }
  
  
  
  @GetMapping("/write.page")
  public String writePage() {
    return "report/write";
  }  
  
  @PostMapping("/registerReport.do")
  public String register(HttpServletRequest request, RedirectAttributes redirectAttributes) {
    int insertCount = reportService.registerReport(request);
    redirectAttributes.addFlashAttribute("insertResult", insertCount == 1 ? "블로그가 등록되었습니다." : "블로그가 등록되지 않았습니다.");
    return "redirect:/report/list.page";
  }
  
  
  @GetMapping(value="/getReportList.do", produces="application/json")
  public ResponseEntity<Map<String, Object>> getReportList(HttpServletRequest request) {
    return reportService.getReportList(request);
  }
  
  
  @GetMapping("/detail.do")
  public String detail(@RequestParam int reportNo, Model model) {
    model.addAttribute("report", reportService.getReportByNo(reportNo));
    return "report/detail";
  }
  
  @PostMapping("/editReport.do")
  public String editReport(@RequestParam int reportNo, Model model) {
    model.addAttribute("report", reportService.getReportByNo(reportNo));
    return "report/edit";
  }
  
//  @PostMapping("/modifyReport.do")
//  public String modifyReport(HttpServletRequest request, RedirectAttributes redirectAttributes) {
//    int modifyCount = reportService.modifyReport(request);
//    redirectAttributes
//      .addAttribute("reportNo", request.getParameter("reportNo"))
//      .addFlashAttribute("modifyResult", modifyCount == 1 ? "수정되었습니다.": "수정되지 않았습니다.");
//    return "redirect:/report/detail.do?reportNo={reportNo}";
//  }
  
  @PostMapping("/removeReport.do")
  public String removeReport(@RequestParam(value="reportNo", required=false, defaultValue="0") int reportNo
                         , RedirectAttributes redirectAttributes) {
    int removeCount = reportService.removeReport(reportNo);
    redirectAttributes.addFlashAttribute("removeResult", removeCount == 1 ? "블로그가 삭제되었습니다." : "블로그가 삭제되지 않았습니다.");
    return "redirect:/report/list.page";
  }
  
  
}