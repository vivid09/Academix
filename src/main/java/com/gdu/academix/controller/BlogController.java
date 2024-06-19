package com.gdu.academix.controller;

import java.util.Map;

import jakarta.servlet.http.HttpServletRequest;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.gdu.academix.service.BlogService;

import lombok.RequiredArgsConstructor;

@RequestMapping("/blog")
@RequiredArgsConstructor
@Controller
public class BlogController {
  
  private final BlogService blogService;
  
  @GetMapping("/list.page")
  public String list() {
    return "blog/list";
  }
  
  @GetMapping("/write.page")
  public String writePage() {
    return "blog/write";
  }
  
  @PostMapping(value="/summernote/imageUpload.do", produces="application/json")
  public ResponseEntity<Map<String, Object>> summernoteImageUpload(@RequestParam("image") MultipartFile multipartFile) {
    return blogService.summernoteImageUpload(multipartFile);
  }
  
  @PostMapping("/registerBlog.do")
  public String register(HttpServletRequest request, RedirectAttributes redirectAttributes) {
    int insertCount = blogService.registerBlog(request);
    redirectAttributes.addFlashAttribute("insertResult", insertCount == 1 ? "블로그가 등록되었습니다." : "블로그가 등록되지 않았습니다.");
    return "redirect:/blog/list.page";
  }
  
  @GetMapping(value="/getBlogList.do", produces="application/json")
  public ResponseEntity<Map<String, Object>> getBlogList(HttpServletRequest request) {
    return blogService.getBlogList(request);
  }
  
  @GetMapping("/updateHit.do")
  public String updateHit(@RequestParam int blogNo) {
    blogService.updateHit(blogNo);
    return "redirect:/blog/detail.do?blogNo=" + blogNo;
  }
  
  @GetMapping("/detail.do")
  public String detail(@RequestParam int notiPostNo, Model model) {
    model.addAttribute("blog", blogService.getBlogByNo(notiPostNo));
    return "blog/detail";
  }
  
  @PostMapping("/editBlog.do")
  public String editBlog(@RequestParam int notiPostNo, Model model) {
    model.addAttribute("blog", blogService.getBlogByNo(notiPostNo));
    return "blog/edit";
  }
  
  @PostMapping("/modifyBlog.do")
  public String modifyBlog(HttpServletRequest request, RedirectAttributes redirectAttributes) {
    int modifyCount = blogService.modifyBlog(request);
    redirectAttributes
      .addAttribute("notiPostNo", request.getParameter("notiPostNo"))
      .addFlashAttribute("modifyResult", modifyCount == 1 ? "수정되었습니다.": "수정되지 않았습니다.");
    return "redirect:/blog/detail.do?notiPostNo={notiPostNo}";
  }
  
  @PostMapping("/removeBlog.do")
  public String removeBlog(@RequestParam(value="notiPostNo", required=false, defaultValue="0") int notiPostNo
                         , RedirectAttributes redirectAttributes) {
    int removeCount = blogService.removeBlog(notiPostNo);
    redirectAttributes.addFlashAttribute("removeResult", removeCount == 1 ? "블로그가 삭제되었습니다." : "블로그가 삭제되지 않았습니다.");
    return "redirect:/blog/list.page";
  }
  
  @PostMapping(value="/registerComment.do", produces="application/json")
  public ResponseEntity<Map<String, Object>> registerComment(HttpServletRequest request) {
    return ResponseEntity.ok(Map.of("insertCount", blogService.registerComment(request)));
  }
  
  @GetMapping(value="/comment/list.do", produces="application/json")
  public ResponseEntity<Map<String, Object>> commentList(HttpServletRequest request) {
    return ResponseEntity.ok(blogService.getCommentList(request));
  }
  
  @PostMapping(value="/comment/registerReply.do", produces="application/json")
  public ResponseEntity<Map<String, Object>> registerReply(HttpServletRequest request) {
    return ResponseEntity.ok(Map.of("insertReplyCount", blogService.registerReply(request)));
  }
  
  @PostMapping(value="/removeComment.do", produces="application/json")
  public ResponseEntity<Map<String, Object>> removeComment(@RequestParam(value="commentNo", required=false, defaultValue="0") int commentNo) {
    return ResponseEntity.ok(Map.of("removeResult", blogService.removeComment(commentNo) == 1 ? "댓글이 삭제되었습니다." : "댓글이 삭제되지 않았습니다."));
  }
  
}